@isTest
private class GE_OG_InsertTeamMember_Test {
public static testMethod void testSuccess(){
    test.startTest();
    GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
    Account Acnt = new Account();
    User u = [select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   

    Acnt.Name='Test Acc For TestClass';  
    Acnt.Account_Tier_GEOG__c = 'Global';
    //Acnt.Account_Status__c = 'CC Approved';
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
    Acnt.IsLeadAccount_GEOG__c = true;

    Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    Acnt.recordtypeid = devRecordTypeId;
    Acnt.OwnerId = userinfo.getUserId();
    Acnt.ShippingCountry = 'ARGENTINA';
    Acnt.GE_PW_Phone_New_Request__c = '(111)111-1111';
    insert Acnt;
    Acnt.Name='Test Acc For TestClasses';
    update Acnt;
    test.stopTest();
    }
    
    public static testMethod void testAccountUpdate(){
      test.startTest();
        Account Acnt = new Account();
        //User u = [select id,firstname,lastname,email from User where FirstName='System' AND LastName='Integration' LIMIT 1];   
    
        Acnt.Name='Test Acc For TestClass';  
        Acnt.Account_Tier_GEOG__c = 'Global';
        //Acnt.Account_Status__c = 'CC Approved';
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
        Acnt.IsLeadAccount_GEOG__c = true;
    
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
        Acnt.recordtypeid = devRecordTypeId;
        Acnt.ShippingCountry = 'ARGENTINA';
        Acnt.GE_PW_Phone_New_Request__c = '(111)111-1111';
        Acnt.OwnerId = System.Label.System_Integration_User_ID;
        insert Acnt;
        Acnt.OwnerId=userinfo.getUserId(); 
        update Acnt;
        test.stopTest();      
    }
}