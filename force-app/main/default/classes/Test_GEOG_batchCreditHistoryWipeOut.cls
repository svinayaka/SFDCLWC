@isTest() 
private class Test_GEOG_batchCreditHistoryWipeOut{
    static testMethod void ValidateBatchClass() {
   Test.StartTest();
   
    Account Acc = new Account(Name ='Test',GE_HQ_ACCOUNT_ID__c='1010'); 
    Insert Acc;

    GE_HQ_CUST_CREDIT_HIST__c obj = new GE_HQ_CUST_CREDIT_HIST__c(GE_HQ_Acc__c=Acc.Id, GE_HQ_Past_Due_91_180__c=343, GE_HQ_Past_Due_181_365__c=33,  GE_HQ_Past_Due_365__c=53 , GE_HQ_Past_Due_1_30__c=23,  GE_HQ_Past_Due_31_60__c=44, GE_HQ_Past_Due_61_90__c=43 , GE_HQ_Tot_Past_Due__c=44);
    insert obj;
     GEOG_batchCreditHistoryWipeOutTotpastDue TestObj=new GEOG_batchCreditHistoryWipeOutTotpastDue();
   Database.executebatch(Testobj,20);
         Test.Stoptest();
    }
}