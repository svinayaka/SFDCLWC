//modified:

@isTest
public class AccountSearchExtension_GEOG_Test {        

//static Account acc;
@testsetup
    static void createData()
    {

       
   /* acc = AccountTestDataFactory.createRelationshipAccount('TestAccount1');
         Contact con = AccountTestDataFactory.createContact(acc.ID,'test','test');
    country_region_mapping_ge_og__c ctry= AccountTestDataFactory.createCountryRegionMappingData('205','UNITED ARAB EMIRATES','AE','Middle East / North Africa','Active');
    */



  }



    
       static testMethod void TestfetchAllCountry() {
       test.startTest();
       /*String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
    
        Account oGAct = new Account();
        oGAct.Name='TestAccount1';
        oGAct.GE_HQ_DUNS_Number__c='GEGUL9999';
        oGAct.RecordTypeId=recordTypeName;
        oGAct.Account_Tier_GEOG__c = 'Country';
        insert oGAct; 
        
        Contact con = new Contact();
        con.FirstName='test';
        con.LastName='test';
        con.Email='terst@test.com';
        con.AccountId = oGAct.Id;
        //con.isDuplicate__c = false;
        insert con;  
        
        country_region_mapping_ge_og__c country = new country_region_mapping_ge_og__c();
        country.Name = '205';
        country.country_name_ge_og__c = 'UNITED ARAB EMIRATES';
        country.iso_code_ge_og__c = 'AE';
        country.region_ge_og__c = 'Middle East / North Africa';
        country.status_ge_og__c = 'Active';
        insert country;*/
        
        Account acc = AccountTestDataFactory.createRelationshipAccount('TestAccount1');
         Contact con = AccountTestDataFactory.createContact(acc.ID,'test','test');
    country_region_mapping_ge_og__c ctry= AccountTestDataFactory.createCountryRegionMappingData('205','UNITED ARAB EMIRATES','AE','Middle East / North Africa','Active');


 
        ApexPages.StandardController stdOppObj = new ApexPages.standardController(acc);
        AccountSearchExtension_GEOG accsearch = new AccountSearchExtension_GEOG(stdOppObj);
        accsearch.fetchAllCountry();
        accsearch.search();
        accsearch.newacc();
        accsearch.AddCntryAcc();
        accsearch.selectAcc();
        accsearch.beginning();
        accsearch.previous();
        accsearch.next();
        accsearch.end();
        accsearch.getprev();
        accsearch.getnxt();
  
  test.stopTest();
    }
  }