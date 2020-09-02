@isTest
private class GE_HQ_populateParentDUNS_Test{
        
    Static testMethod void populateParent_Test1() {

    //Creating LE account    
    account accLE = new account();
    accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Customer Request').getRecordTypeId();
    accLE.name = 'Test Account LE';
    accLE.Account_Tier_GEOG__c = 'LE';
    accLE.Country_GEOG__c = 'INDIA';
    accLE.Classification__c= 'Strategic';
    accLE.Type = 'Competitor';
    accLE.ShippingCountry = 'India';
    accLE.Account_Status__c = 'CC Approved';
    accLE.GE_HQ_DUNS_Number__c = '988558098';
    accLE.GE_HQ_HQ_Parent_Duns__c = '988558098';
    accLE.GE_HQ_Dom_Ult_Duns__c = '988558098';
    accLE.GE_HQ_Glo_Ult_Duns__c = '988558098';
    accLE.GE_HQ_GE_Global_Duns__c = '988558098';
    insert accLE;
    

    
    }
    
    Static testMethod void populateParent_Test2() {
    
    //Creating LE account    
    account accLE = new account();
    accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Customer Request').getRecordTypeId();
    accLE.name = 'Test Account LE';
    accLE.Account_Tier_GEOG__c = 'LE';
    accLE.Country_GEOG__c = 'INDIA';
    accLE.Classification__c= 'Strategic';
    accLE.Type = 'Competitor';
    accLE.ShippingCountry = 'India';
    accLE.Account_Status__c = 'CC Approved';
    accLE.GE_HQ_DUNS_Number__c = '988558098';
    accLE.GE_HQ_HQ_Parent_Duns__c = '988558098';
    accLE.GE_HQ_Dom_Ult_Duns__c = '988558098';
    accLE.GE_HQ_Glo_Ult_Duns__c = '988558098';
    accLE.GE_HQ_GE_Global_Duns__c = '988558099';
    insert accLE;
    

    accLE.Type = 'EPC';
    update accLE;
    
    }
               
}