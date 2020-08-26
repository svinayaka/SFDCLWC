/*
Class/Trigger Name     : UploadRequestSubmitted
Purpose/Overview       : This trigger is called after update of Upload Request record.
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-31649
Author                 : Harsha C
Created Date           : 08/MAY/2019
Test Class Name        : MassCancelOpportunities_GE_OG_Test
Code Coverage          : 
*/
trigger UploadRequestSubmitted on Upload_Request_ge_og__c (After insert,After Update) {
    MassCancelOpportunities_GE_OG masscancelopportunities = new MassCancelOpportunities_GE_OG();
    List<Upload_Request_ge_og__c> urlist = new List<Upload_Request_ge_og__c>();
    if(trigger.isUpdate){
        for (Upload_Request_ge_og__c ur : Trigger.new) {
            Upload_Request_ge_og__c oldur = Trigger.oldMap.get(ur.Id);
           // System.debug('System.Label.Upload_Request_Record_Type_Id  >>> '+System.Label.Upload_Request_Record_Type_Id );
            if(/*ur.Status__c != oldur.Status__c && */ur.Status__c == 'Submitted' && ur.RecordTypeId == System.Label.Upload_Request_Record_Type_Id && ur.Trigger_Upload_Request_ge_og__c == true){
                urlist.add(ur);  
            }
            if( urlist.size()>0){
                MassCancelOpportunities_GE_OG.massCancelOptyRecords(urlist);
            }
        }
    }
}