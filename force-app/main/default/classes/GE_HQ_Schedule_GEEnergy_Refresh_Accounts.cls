/*
Class Name        : GE_HQ_Schedule_GEEnergy_Refresh_Accounts
Purpose/Overview  : Inserting all the child Accounts in Junction Object
Author            : Lakshmi Prasanna Kethu
Test Class        : GE_HQ_Refresh_Accounts_Test
*/


global class GE_HQ_Schedule_GEEnergy_Refresh_Accounts implements Schedulable{
    public static String CRON_EXP = '0 0 0 3 9 ? 2022';
    global void execute(SchedulableContext SC) {
        String recordTypeName = Schema.SObjectType.GE_HQ_Account_Plan__c.getRecordTypeInfosByName().get('GE Energy Plan').getRecordTypeId();
        String returnQuery= 'Select g.Id, g.GE_HQ_DDUNS_Number__c, g.GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c from GE_HQ_Account_Plan__c g Where g.RecordTypeID =\'' + recordTypeName + '\'' + 'and g.GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c!=null' ;
        
        GE_HQ_Batch_Refresh_Accounts BatchRefreshAccounts = new GE_HQ_Batch_Refresh_Accounts();
        BatchRefreshAccounts.Query = returnQuery;
        Database.executebatch(BatchRefreshAccounts, 10);
    }
}