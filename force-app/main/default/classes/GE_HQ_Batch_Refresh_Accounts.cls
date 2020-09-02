/*
Class Name        : GE_HQ_Batch_Refresh_Accounts 
Purpose/Overview  : Inserting all the child Accounts in Junction Object
Author            : Lakshmi Prasanna Kethu
Test Class        : GE_HQ_Refresh_Accounts_Test
*/

global class GE_HQ_Batch_Refresh_Accounts implements Database.Batchable<sObject> {

    public String Query;
    
    global Database.QueryLocator start(Database.BatchableContext BC){ 
    
        System.debug('execute start >>-> '); 
        //String recordTypeName = Schema.SObjectType.GE_HQ_Account_Plan__c.getRecordTypeInfosByName().get('AE Account Plan').getRecordTypeId();
        //String Query= 'Select g.Id, g.GE_HQ_DDUNS_Number__c, g.GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c from GE_HQ_Account_Plan__c g Where g.RecordTypeID =\'' + recordTypeName + '\'';
        Return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC,List<GE_HQ_Account_Plan__c> AccPlanList){
        system.debug('execute execute>>-> '+AccPlanList.size());

        GE_HQ_Refresh_Accounts RefreshAcc = new GE_HQ_Refresh_Accounts();

        if(AccPlanList!=null && AccPlanList.size()>0){
            List<GE_HQ_Acc_AccPlan_Rel__c> deleteJORecords = RefreshAcc.deleteJunctionRecords(AccPlanList);
            System.debug('deleteJORecords*****************'+deleteJORecords.size());
            if(deleteJORecords!=null && deleteJORecords.size()>0)
                delete deleteJORecords;
            
            List<GE_HQ_Acc_AccPlan_Rel__c> InsertList = RefreshAcc.getJunctionRecords(AccPlanList);
            //System.debug('InsertList *****************'+InsertList.size());
            if(InsertList !=null && InsertList.size() > 0)
                insert InsertList;
        }
    }
    
    global void finish(Database.BatchableContext BC){
    
       // Query the AsyncApexJob object to retrieve the current job's information. 
    
       AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
          TotalJobItems,CreatedById, CreatedBy.Email
          FROM AsyncApexJob WHERE Id =
          :BC.getJobId()];
       

       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       mail.setTargetObjectId(a.CreatedById);
       mail.setSaveAsActivity(false);
       mail.setSubject('Apex Sharing Recalculation ' + a.Status);
       mail.setPlainTextBody
       ('The batch Apex job processed ' + a.TotalJobItems +
       ' batches with '+ a.NumberOfErrors + ' failures.');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    }
}