/*
Class Name : GE_OG_SS_ProjectIntegration_Utility 
Purpose/Overview: Integration utility class to get DMZ token and invoke SOA web service method
Functional Area :- Sub-Sea 
Author :- Shiv Pratap Singh Bhadauria
Created Date: 14th July 2019
*/

global class GE_OG_SS_ProjectIntegration_Utility{
    @future(callout=true)
    public static void submitFSProjectToOracle(Set<Id> fsProjectRecordIdSet){
        List<GE_SS_Project__c> fsprojectListToUpdate = new list<GE_SS_Project__c>() ;
        try{
            GE_OG_SS_FSProject_Wrapper wrapperObject = new GE_OG_SS_FSProject_Wrapper() ;
            String dmzResponse = GE_OG_PCIntegrationUtility.getDMZAccessToken() ;
            system.debug('Connection got established' + dmzResponse ) ;              
            wrapperObject.submitFSProjectToOracle(fsProjectRecordIdSet,dmzResponse) ;              
        }catch(Exception e1){
            system.debug('There is an error while set up the connection' + e1.getMessage()) ;
            for(Id projectRecordId : fsProjectRecordIdSet){
                GE_SS_Project__c fsProjectToErrorupdate = new GE_SS_Project__c() ;
                fsProjectToErrorupdate.id = projectRecordId ;
                fsProjectToErrorupdate.GE_SS_Integration_Error__c = 'There is a connection error in sending FS Project ----> ' + e1.getMessage() ;
                fsprojectListToUpdate.add(fsProjectToErrorupdate) ;
            } 
            if(fsprojectListToUpdate.size() > 0){
                try{
                    update fsprojectListToUpdate ;
                }
                catch(Exception e2){
                    system.debug('There is an error while Logging the exception on FS Project' + e2.getMessage()) ;
                }
            }   
        }  
    }
    
    @future(callout = true)
    public static void submitFSProjectDetailUpdatesToOracle(Set<Id> fsProjectDetailRecordIdSet){
        List<GE_OG_FS_Project_Detail__c> fsProjectLineListToUpdate = new list<GE_OG_FS_Project_Detail__c>() ;
        String dmzResponse ;
        try{
            dmzResponse  = GE_OG_PCIntegrationUtility.getDMZAccessToken() ;
            GE_OG_SS_FSProjectDetail_Wrapper projectDetailWrapperObject = new GE_OG_SS_FSProjectDetail_Wrapper() ;    
            projectDetailWrapperObject.submitFSProjectDetailUpdatesToOracleERP(fsProjectDetailRecordIdSet,dmzResponse) ;             
        }catch(Exception e3){
            system.debug('There is an error while set up the connection' + e3.getMessage()) ;
            for(Id projectDetailRecordId : fsProjectDetailRecordIdSet){
                GE_OG_FS_Project_Detail__c fsProjectDetailErrorUpdate = new GE_OG_FS_Project_Detail__c() ;
                fsProjectDetailErrorUpdate.Id = projectDetailRecordId ;
                fsProjectDetailErrorUpdate.GE_OG_Error_Message__c = 'There is a connection error in sending FS Project Lines ---->' + e3.getMessage() ;
                fsProjectLineListToUpdate.add(fsProjectDetailErrorUpdate) ;
            }
        } 
        
        if(fsProjectLineListToUpdate.size() > 0){
            try{
                update fsProjectLineListToUpdate ;
            }
            catch(Exception e4){
                system.debug('There is an error while Logging the exception on FS Project Detail' + e4.getMessage()) ;
            }
        }      
    }
}