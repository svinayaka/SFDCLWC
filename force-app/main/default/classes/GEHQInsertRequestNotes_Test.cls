@isTest
private class GEHQInsertRequestNotes_Test{
        
    Static testMethod void CommContact_Switchto_Test() {

    //Creating LE account    
    account accLE = new account();
    accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Customer Request').getRecordTypeId();
    accLE.name = 'Test Account LE';
    accLE.Account_Tier_GEOG__c = 'LE';
    //accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
    accLE.Country_GEOG__c = 'INDIA';
    accLE.Classification__c= 'Strategic';
    accLE.Type = 'Competitor';
    accLE.ShippingCountry = 'India';
    accLE.Account_Status__c = 'CC Approved';
    //accLE.Member_of_GE_OG__c = acc.Id;
    //accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
    insert accLE;
    
    Account_Request_Note__c nott = new Account_Request_Note__c();
    nott.Account__c=accLE.id;
    nott.Comments__c ='testetetedtetetestet';
    insert nott;
    
    }
    
    Static testMethod void CommContact_Switchto_Test1() {
    
    account accLE = new account();
    accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Customer Request').getRecordTypeId();
    accLE.name = 'Test Account LE';
    accLE.Account_Tier_GEOG__c = 'LE';
    //accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
    accLE.Country_GEOG__c = 'INDIA';
    accLE.Classification__c= 'Strategic';
    accLE.Type = 'Competitor';
    accLE.ShippingCountry = 'India';
    accLE.Account_Status__c = 'CC Approved';
    accLE.GE_HQ_Nts_Comments__c='twertertete';
    //accLE.Member_of_GE_OG__c = acc.Id;
    //accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
    insert accLE;
    
     Account_Request_Note__c nott = new Account_Request_Note__c();
    nott.Account__c=accLE.id;
    nott.Comments__c ='testetetedtetetestet';
    insert nott;
    
    accLE.GE_HQ_Nts_Comments__c='terteteeeee';
    accLE.Type = 'EPC';
    update accLE;
    
    }
               
}