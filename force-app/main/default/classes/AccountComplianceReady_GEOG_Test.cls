@isTest
private class AccountComplianceReady_GEOG_Test{


//static Account acc;
@testsetup
    static void createData()
    {

       
   /* acc = AccountTestDataFactory.createRelationshipAccount('TestAccount1');
         Contact con = AccountTestDataFactory.createContact(acc.ID,'test','test');
    country_region_mapping_ge_og__c ctry= AccountTestDataFactory.createCountryRegionMappingData('205','UNITED ARAB EMIRATES','AE','Middle East / North Africa','Active');
    */



  }
    Static testMethod void ComplianceReady_Test() {
    
    
    
    
    Account acc=  AccountTestDataFactory.createRelationshipAccountGlobal('Account Global','Direct Customer');
    Account regAcct=AccountTestDataFactory.createRegionalAccount(acc.id,'Test Account Regional','Direct Customer');   
     Account cntryLevAcct=AccountTestDataFactory.createCountryaccount(acc.id,regAcct.id,'Test Account Country',False,True,'Direct Customer');
    Contact createContact1=AccountTestDataFactory.createContact(cntryLevAcct.id,'test','test');
    Contact createContact2=AccountTestDataFactory.createContact(cntryLevAcct.id,'test','test');
    AccountTestDataFactory.createLegalEntityAccount1('Test Account LE',cntryLevAcct.id,'Direct Customer');
    
      
    
    
    /*account acc = new account();
    acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    acc.name = 'Account Global';
    acc.Account_Tier_GEOG__c = 'Global';
    acc.Classification__c= 'Strategic';
    acc.Type = 'Competitor';
    acc.ShippingCountry = 'India';
    insert acc;
    
    //Creating Regional account
    account accRegional = new account();
    accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accRegional.name = 'Test Account Regional';
    accRegional.Account_Tier_GEOG__c = 'Regional';
    accRegional.Country_GEOG__c = 'INDIA';
    accRegional.Classification__c= 'Strategic';
    accRegional.Type = 'Competitor';
    accRegional.ShippingCountry = 'India';
    accRegional.Member_of_GE_OG__c = acc.Id;
    accRegional.ParentId = acc.Id;
    insert accRegional;
      
    //Creating Country account
    account accCountry = new account();
    accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accCountry.name = 'Test Account Country';
    accCountry.Account_Tier_GEOG__c = 'Country';
    accCountry.Country_GEOG__c = 'INDIA';
    accCountry.Classification__c= 'Strategic';
    accCountry.Type = 'Competitor';
    accCountry.ShippingCountry = 'India';
    accCountry.Member_of_GE_OG__c = acc.Id;
    accCountry.ParentId = accRegional.Id;
    accCountry.Finance_Lock_GEOG__c = True;
    accCountry.Compliance_Ready__c  =  False;
    insert accCountry;
   
    Contact con = new Contact();
    con.FirstName='test';
    con.LastName='test';
    con.Email='terst@test.com';
    con.AccountId = accCountry.Id;
    insert con;
    
    Contact con2 = new Contact();
    con2.FirstName='test';
    con2.LastName='test';
    con2.Email='terst1@test.com';
    con2.AccountId = accCountry.Id;
    insert con2;
      
    //Creating LE account    
    account accLE = new account();
    accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accLE.name = 'Test Account LE';
    accLE.Account_Tier_GEOG__c = 'LE';
    accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
    accLE.Country_GEOG__c = 'INDIA';
    accLE.Classification__c= 'Strategic';
    accLE.Type = 'Competitor';
    accLE.ShippingCountry = 'India';
    accLE.Account_Status__c = 'CC Approved';
    accLE.Member_of_GE_OG__c = acc.Id;
    accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
    insert accLE;
    */
    test.starttest();
    acc.name ='test1/test12';
    acc.type = 'Direct Customer';
    update acc;
    test.stoptest();
   }
    
      
}