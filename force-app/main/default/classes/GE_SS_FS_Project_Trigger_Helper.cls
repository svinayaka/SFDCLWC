public with sharing class GE_SS_FS_Project_Trigger_Helper{
public static Boolean isRecursive = false; 
     public static void invokeFSProjectSubmitToOracle(List<GE_SS_Project__c> projectRecord ){
           ID ssProjectRectypeId = Schema.SObjectType.GE_SS_Project__c.getRecordTypeInfosByName().get('SS Project').getRecordTypeId(); 
           List<GE_SS_Project__c> fsprojectListToUpdate = new list<GE_SS_Project__c>() ;
           Set<Id> recordIdSet = new Set<Id>() ;
           for(GE_SS_Project__c record : projectRecord){
               if(record.RecordtypeId == ssProjectRectypeId){
                    recordIdSet.add(record.Id) ;
                    GE_SS_Project__c fsProjectToStatusupdate= new GE_SS_Project__c() ;
                    fsProjectToStatusupdate.id = record.Id;
                    fsProjectToStatusupdate.GE_SS_Integration_Status__c = 'Sent to Oracle';
                    fsprojectListToUpdate.add(fsProjectToStatusupdate) ;
                    isRecursive = true;                 
               }
           }
           
           if(fsprojectListToUpdate.size() > 0){
               update fsprojectListToUpdate ;
           }
           
           if(recordIdSet.size() > 0 && recordIdSet != null) {
                GE_OG_SS_ProjectIntegration_Utility.submitFSProjectToOracle(recordIdSet) ;
           }    
     }
     
    public static void invokeFSProjectDetailUpdateSubmitToOracle(List<GE_OG_FS_Project_Detail__c> fsProjectDetailRecord , Map<Id,GE_OG_FS_Project_Detail__c> oldFSProjectDetailRecordMap){
           ID fsProjectDetailRectypeId = Schema.SObjectType.GE_OG_FS_Project_Detail__c.getRecordTypeInfosByName().get('SS Lines').getRecordTypeId(); 
           List<GE_OG_FS_Project_Detail__c> fsProjectLineListToUpdate = new list<GE_OG_FS_Project_Detail__c>() ;
           Set<Id> fsProjectDetailRecordIdSet = new Set<Id>() ;
           Boolean sBatchFlag = false;
           for(GE_OG_FS_Project_Detail__c projectDetailRecord : fsProjectDetailRecord){
                   if(projectDetailRecord.RecordtypeId == fsProjectDetailRectypeId && projectDetailRecord.GE_OG_Line_Id__c != null && projectDetailRecord.GE_OG_Line_Id__c != '' && projectDetailRecord.GE_SS_Tool_condition__c != null && projectDetailRecord.GE_SS_Expected_Arrival_Date_to_Shop__c != null && projectDetailRecord.GE_SS_Actual_Shipped_Date_from_Customer__c  != null && projectDetailRecord.GE_OG_Line_Type__c == 'Tools'){
                        if( (oldFSProjectDetailRecordMap.get(projectDetailRecord.Id).GE_SS_Tool_condition__c !=  projectDetailRecord.GE_SS_Tool_condition__c ) ||  
                            (oldFSProjectDetailRecordMap.get(projectDetailRecord.Id).GE_SS_Expected_Arrival_Date_to_Shop__c !=  projectDetailRecord.GE_SS_Expected_Arrival_Date_to_Shop__c) || 
                            (oldFSProjectDetailRecordMap.get(projectDetailRecord.Id).GE_SS_Actual_Shipped_Date_from_Customer__c !=  projectDetailRecord.GE_SS_Actual_Shipped_Date_from_Customer__c) ){
                                     fsProjectDetailRecordIdSet.add(projectDetailRecord.Id) ;
                                     GE_OG_FS_Project_Detail__c fsProjectDetailErrorUpdate = new GE_OG_FS_Project_Detail__c() ;
                                     fsProjectDetailErrorUpdate.Id = projectDetailRecord.Id ;
                                     fsProjectDetailErrorUpdate.Integration_Status__c = 'Line Sent to Oracle' ;
                                     fsProjectLineListToUpdate.add(fsProjectDetailErrorUpdate) ;                            
                        }   
                   }
                   
                   if(projectDetailRecord.RecordtypeId == fsProjectDetailRectypeId && !system.IsBatch() && !Test.isRunningTest())
                   {
                       sBatchFlag = true;
                   }
           }
           
           if(fsProjectLineListToUpdate.size() > 0){
                update fsProjectLineListToUpdate ;
            }
           
           if(fsProjectDetailRecordIdSet.size() > 0 && fsProjectDetailRecordIdSet != null){
                  GE_OG_SS_ProjectIntegration_Utility.submitFSProjectDetailUpdatesToOracle(fsProjectDetailRecordIdSet) ;
           } 

           if(sBatchFlag){
               GE_OG_InvokeFSProjectDetailMgmtBatch.executeFSPDProcessing();
            }
     }
     
     public static void preventFSProjectLineDeletion(List<GE_OG_FS_Project_Detail__c> projectLineRecord){
        String temp = System.label.Subsea_profiles ;
        List<String> ssProfileNameSet = temp.split(',') ;          
        Set<Id> ssProfileIdSet = new Set<Id>() ;
        Map<Id,Profile> ssProfileMap = new Map<Id,Profile>() ;
        for(Profile pro : [Select Id,Name FROM Profile WHERE Name IN : ssProfileNameSet]){
            ssProfileMap.put(pro.Id,pro) ;
        }
        for(GE_OG_FS_Project_Detail__c lineRec : projectLineRecord){
            if((lineRec.GE_OG_Line_Id__c != null && lineRec.GE_OG_Line_Id__c != '') && ssProfileMap.containsKey(Userinfo.getProfileId())){
                lineRec.addError('You can not delete Project Line record if SO Line Number Id is present.') ;
            }
        }
     }
     
    public static void onBeforeUpdate(List<GE_OG_FS_Project_Detail__c> fsProjectDetailRecord , Map<Id,GE_OG_FS_Project_Detail__c> oldFSProjectDetailRecordMap){
           ID fsProjectDetailRectypeId = Schema.SObjectType.GE_OG_FS_Project_Detail__c.getRecordTypeInfosByName().get('SS Lines').getRecordTypeId(); 
           List<SS_FS_Lines_Sync__mdt> mappingFieldList = [SELECT Source_Field__c, WD_Target_Field__c FROM SS_FS_Lines_Sync__mdt where Active__c = true];

           
           for(GE_OG_FS_Project_Detail__c projectDetailRecord : fsProjectDetailRecord){
                   if(projectDetailRecord.RecordtypeId == fsProjectDetailRectypeId && !system.IsBatch() ){
                       if( oldFSProjectDetailRecordMap.get(projectDetailRecord.Id).GE_SS_Actual_Returned_Date__c == null && projectDetailRecord.GE_SS_Actual_Returned_Date__c != null){
                           projectDetailRecord.GE_OG_IP_Status__c = 'Inventory'; 
                           projectDetailRecord.GE_SS_IP_Current_Activity_Status__c = 'Maintenance'; 
                      }
                      
                      else if( oldFSProjectDetailRecordMap.get(projectDetailRecord.Id).GE_SS_Send_to_Oracle__c == false && projectDetailRecord.GE_SS_Send_to_Oracle__c == true){
                           projectDetailRecord.GE_OG_IP_Status__c = 'In-Transit-Return'; 
                           projectDetailRecord.GE_SS_IP_Current_Activity_Status__c = 'Returned';
                           projectDetailRecord.GE_OG_FS_Line_Status__c = 'CLOSED'; 
                      }                   
                   
                        for(Integer i=0 ; i < mappingFieldList.size() ; i++){ 
                         String sourceField = String.ValueOf(mappingFieldList.get(i).Source_Field__c);                       
                         if (oldFSProjectDetailRecordMap.get(projectDetailRecord.Id).get(sourceField) !=  projectDetailRecord.get(sourceField) ){
                                 projectDetailRecord.GE_OG_Processed__c = false;   
                                 break;
                            }
                        }   
                   }
           }
     }
}