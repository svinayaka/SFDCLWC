@isTest 
private class GE_PRM_Orders_Summary_Create_Test{

    static testMethod void AccountStrengthTest() {
         Account acnt = new Account();
         acnt.Name='Customer value perception';
         acnt.Type = 'EPC';
         acnt.Classification__c = 'Strategic';
         acnt.Strength__c = 'Low';
         insert acnt;
         
         GE_HQ_Account_Plan__c obj = new GE_HQ_Account_Plan__c();
         insert obj;
     }


}