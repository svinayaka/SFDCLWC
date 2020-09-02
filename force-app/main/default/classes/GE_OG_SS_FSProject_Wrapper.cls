/*
Class Name: GE_OG_SS_FSProject_Wrapper 
Purpose/Overview: Wrapper class for GE_OG_PCOutboundIntegration class to invoke SOA Endpoint.
Author: Shiv Pratap Singh Bhadauria
Developed Date : 26/06/2019
Test Class Name:  Test_GE_OG_PCIntegration
*/
Global class GE_OG_SS_FSProject_Wrapper{
    public GE_OG_SS_FSProject_Wrapper() {
    
    }         
    GE_SS_FS_Project_Publish.FSProjct_BPELProcess_pt processRequest_x = new GE_SS_FS_Project_Publish.FSProjct_BPELProcess_pt () ;
    GE_SS_FS_Project_Publish.GE_SS_Project_Collection projectCollection_x = new GE_SS_FS_Project_Publish.GE_SS_Project_Collection() ; 
    GE_SS_FS_Project_Publish.notificationsResponse_element  notificationResponse_x = new GE_SS_FS_Project_Publish.notificationsResponse_element() ;    
    list<GE_SS_FS_Project_Publish.GE_SS_Project_xc> fsProjectRecordDetailsItems_x = new list<GE_SS_FS_Project_Publish.GE_SS_Project_xc>() ;
    
    public void submitFSProjectToOracle(Set<Id> fsProjectIdSet , String accessToken){
         Map<string,string> inputHeaderMap = new Map<string,string>() ;
         List<GE_SS_Project__c> fsprojectListToUpdate = new list<GE_SS_Project__c>() ;
         String result ;         
         inputHeaderMap.put('Authorization',accessToken) ;
         processRequest_x.inputHttpHeaders_x = inputHeaderMap ;
         processRequest_x.timeout_x = GE_OG_PCIntegrationUtility.PC_SOA_TIMEOUT;  
         processRequest_x.endpoint_x = System.Label.FS_Project_Endpoint ;                 
         for(GE_SS_Project__c projectRecord : [SELECT 
                                                                                      Id,Name,
                                                                                      GE_SS_Project_ID__c,
                                                                                      GE_OG_SS_FS_Project_Link__c
                                                                                      FROM 
                                                                                      GE_SS_Project__c 
                                                                                      WHERE Id IN : fsProjectIdSet ]){
                   GE_SS_FS_Project_Publish.GE_SS_Project_xc fsProjectElement_x = new GE_SS_FS_Project_Publish.GE_SS_Project_xc () ;                                                                   
                   fsProjectElement_x.FS_Project_ID = projectRecord.Id ;
                   fsProjectElement_x.FS_Project_Number = projectRecord.GE_SS_Project_ID__c ;
                   fsProjectElement_x.FS_Project_Description = projectRecord.Name ;
                   fsProjectElement_x.FS_Project_URL =  projectRecord.GE_OG_SS_FS_Project_Link__c ;
                   fsProjectRecordDetailsItems_x.add(fsProjectElement_x)  ;                                                               
          }
          
          projectCollection_x.GE_SS_Project_xc =  fsProjectRecordDetailsItems_x ; 
          try{ 
             notificationResponse_x.ACK = processRequest_x.process(fsProjectRecordDetailsItems_x)  ;   
             system.debug('Call out result is ' + notificationResponse_x.ACK) ;              
          }catch(Exception e){
             for(Id projectRecordId : fsProjectIdSet){
                GE_SS_Project__c fsProjectToErrorupdate = new GE_SS_Project__c() ;
                fsProjectToErrorupdate.id = projectRecordId ;
                fsProjectToErrorupdate.GE_SS_Integration_Error__c = 'There is an error in FS Project web service invocation ----> ' + e.getMessage() ;
                fsprojectListToUpdate.add(fsProjectToErrorupdate) ;
             }
          }
          
          if(fsprojectListToUpdate.size() > 0){
                update fsprojectListToUpdate ;
          }               
    }    
}