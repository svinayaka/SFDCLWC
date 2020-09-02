global class GEOG_batchCreditHistoryWipeOutRest implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'Select Id, GE_HQ_Past_Due_91_180__c, GE_HQ_Past_Due_181_365__c,  GE_HQ_Past_Due_365__c , GE_HQ_Past_Due_1_30__c,  GE_HQ_Past_Due_31_60__c , GE_HQ_Past_Due_61_90__c , GE_HQ_Tot_Past_Due__c FROM GE_HQ_CUST_CREDIT_HIST__c';
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<GE_HQ_CUST_CREDIT_HIST__c> scope)
    {
        list<GE_HQ_CUST_CREDIT_HIST__c> lstCusHist = new list<GE_HQ_CUST_CREDIT_HIST__c>();
        for(GE_HQ_CUST_CREDIT_HIST__c Custhis1 :scope) {

            Custhis1.GE_HQ_Past_Due_1_30__c = null;
            Custhis1.GE_HQ_Past_Due_31_60__c = null;
            Custhis1.GE_HQ_Past_Due_61_90__c = null;
            Custhis1.GE_HQ_Past_Due_91_180__c = null;
            Custhis1.GE_HQ_Past_Due_181_365__c = null;
            Custhis1.GE_HQ_Past_Due_365__c =null;
            //Database.update(Custhis1);
            lstCusHist.add(Custhis1);
            //System.debug('********>'+Custhis1);

        }
        update  lstCusHist;
    }   
    global void finish(Database.BatchableContext BC)
    {
        
    }
}