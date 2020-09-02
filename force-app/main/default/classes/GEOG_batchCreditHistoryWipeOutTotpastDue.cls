global class GEOG_batchCreditHistoryWipeOutTotpastDue implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        Date inputDate = Date.newInstance(2014,7,13);
        String query = 'Select Id, GE_HQ_Tot_Past_Due__c FROM GE_HQ_CUST_CREDIT_HIST__c Where LastModifiedDate < : inputDate';
        if(!Test.isRunningTest()){
            query = 'Select Id, GE_HQ_Tot_Past_Due__c FROM GE_HQ_CUST_CREDIT_HIST__c Where LastModifiedDate < : inputDate';
        }
        else{
            query = 'Select Id, GE_HQ_Tot_Past_Due__c FROM GE_HQ_CUST_CREDIT_HIST__c';
        }
        
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<GE_HQ_CUST_CREDIT_HIST__c> scope)
    {
        list<GE_HQ_CUST_CREDIT_HIST__c> lstCusHist = new list<GE_HQ_CUST_CREDIT_HIST__c>();
        for(GE_HQ_CUST_CREDIT_HIST__c Custhis :scope) {
            Custhis.GE_HQ_Tot_Past_Due__c = null;
            //Database.update(Custhis);
            lstCusHist.add(Custhis);
        } 
         update lstCusHist;
    }   
    global void finish(Database.BatchableContext BC)
    {
          Database.executeBatch(new GEOG_batchCreditHistoryWipeOutRest(), 200);
    }
}