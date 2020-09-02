@isTest
private class GEESPopulateSICDesc_Test{
    static testMethod void GEESPopulateTest1() {
    GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
    Account Acnt = new Account();
    Acnt.Name='Test Acc For TestClass';  
    Acnt.GE_HQ_Request_Status__c='CMF Approved';
    Acnt.Account_Tier_GEOG__c = 'Global';
    //Acnt.Account_Status__c = 'CC Approved';
    Acnt.GE_HQ_SIC1__c = 25625;
    Acnt.GE_HQ_SIC2__c = 45435;
    Acnt.GE_HQ_SIC3__c = 253525;
    Acnt.GE_HQ_KYC_Complete__c=TRUE;
    Acnt.GE_PRM_KYC_Completed__c=TRUE;
    Acnt.GE_HQ_DUNS_Number__c='555123459';  
    Acnt.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
    Acnt.GE_OG_Buss_Tier2__c='Lufkin';
    Acnt.GE_OG_Buss_Tier3__c='Oilfield';
    Acnt.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
    Acnt.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
    Acnt.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
    Acnt.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
    Acnt.GE_PW_Country_Bill_To__c='UNITED STATES';
    Acnt.GE_PW_City_Bill_To__c='United States';
    Acnt.GE_PW_State_Province_Bill_To__c='state';
    Acnt.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
    Acnt.GE_PW_Country_Ship_To__c='UNITED STATES';
    Acnt.GE_PW_City_Ship_To__c='city';
    Acnt.GE_PW_State_Province_Ship_To__c='state';
    Acnt.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
    Acnt.GE_HQ_New_Account_Country__c = 'UNITED STATES';
    Acnt.GE_HQ_Nts_Comments__c='Test';

    Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
    Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('Relationship Account');
    Id acc1 = rtByName_acc1.getRecordTypeId();
    Acnt.RecordTypeId = acc1;
    Acnt.GE_OG_AccFin_Status__c = 'In Progress';
    Acnt.GE_HQ_Request_Status__c ='CMF Approved';
    Acnt.ShippingCountry = 'ARGENTINA';
    Acnt.GE_PW_Phone_New_Request__c = '(111)111-1111';
    Acnt.Type = 'Direct Customer';
    Acnt.Classification__c = 'Strategic';
    insert Acnt;
    
    Acnt.GE_HQ_SIC2__c = 45735;
    update Acnt;
    
 
    }
}