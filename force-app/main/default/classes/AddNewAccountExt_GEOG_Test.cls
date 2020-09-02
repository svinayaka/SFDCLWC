@isTest
public class AddNewAccountExt_GEOG_Test {        
    static testMethod void TestAddNewAccountExt1() {
       /*String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        
        Account oGAct = new Account();
        oGAct.Name='TestAccount1';
        oGAct.GE_HQ_DUNS_Number__c='GEGUL9999';
        oGAct.RecordTypeId=recordTypeName;
        oGAct.Account_Tier_GEOG__c = 'Country';
        insert oGAct; */
        
        Account oGAct =AccountTestDataFactory.createRelationshipAccount('TestAccount1','GEGUL999');
        
        
      /*Contact con = new Contact();
        con.FirstName='test';
        con.LastName='test';
        con.Email='terst@test.com';
        con.AccountId = oGAct.Id;
        //con.isDuplicate__c = false;
        insert con;  
        */
        
        
        Contact con = AccountTestDataFactory.createContact(oGAct.id,'test','test');
        /*
        country_region_mapping_ge_og__c country = new country_region_mapping_ge_og__c();
        country.Name = '205';
        country.country_name_ge_og__c = 'UNITED ARAB EMIRATES';
        country.iso_code_ge_og__c = 'AE';
        country.region_ge_og__c = 'Middle East / North Africa';
        country.status_ge_og__c = 'Active';
        insert country;
        */
AccountTestDataFactory.createStaticCountryRegionMappingData();
        
        PageReference myVfPage = Page.AddNewAccount_GEOG;
        Test.setCurrentPage(myVfPage);
        ApexPages.StandardController stdOppObj = new ApexPages.standardController(oGAct);
        AddNewAccountExt_GEOG addacc = new AddNewAccountExt_GEOG(stdOppObj);
        //ApexPages.currentPage().getParameters().put('Id',oGAct.Id);
        ApexPages.currentPage().getParameters().put('name','test');
        ApexPages.currentPage().getParameters().put('region','Middle East / North Africa');
        ApexPages.currentPage().getParameters().put('Country', 'UNITED ARAB EMIRATES');
        addacc.isEdit = true;
        addacc.fetchAllCountry();
        addacc.Save();
        addacc.Cancel();
        
        

    }
    
    static testMethod void TestAddNewAccountExt2() {
        /*String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
      
       Account acc = new Account();
        acc.Name='TestAccount1';
        acc.GE_HQ_DUNS_Number__c='GEGUL9999';
        acc.RecordTypeId=recordTypeName;
        acc.Account_Tier_GEOG__c = 'Global';
        insert acc;*/
        
        Account acc = AccountTestDataFactory.createGlobalRelationshipAccount('TestAccount1','GEGUL999');
         Account Mainacc =AccountTestDataFactory.createCountryLevelAccountWithDunNum(acc,'Strategic','Direct Customer','GEGUL999'); 
        /*Account Mainacc = new Account();
        Mainacc.Name='TestAccount1';
        Mainacc.GE_HQ_DUNS_Number__c='GEGUL9989';
        Mainacc.Account_Tier_GEOG__c ='Country';
        Mainacc.RecordTypeId=recordTypeName;
        Mainacc.Member_of_GE_OG__c = acc.id;
        insert Mainacc;*/
        
        
       /* Contact con = new Contact();
        con.FirstName='test';
        con.LastName='test';
        con.Email='terst@test.com';
        con.AccountId = Mainacc.Id;
        //con.isDuplicate__c = false;
        insert con;  
        */
        
        
        Contact con = AccountTestDataFactory.createContact(Mainacc.Id,'test','test');
        
AccountTestDataFactory.createStaticCountryRegionMappingData();
         
        /*country_region_mapping_ge_og__c country = new country_region_mapping_ge_og__c();
        country.Name = '205';
        country.country_name_ge_og__c = 'UNITED ARAB EMIRATES';
        country.iso_code_ge_og__c = 'AE';
        country.region_ge_og__c = 'Middle East / North Africa';
        country.status_ge_og__c = 'Active';
        insert country;*/
        
        
         ApexPages.currentPage().getParameters().put('id', Mainacc.Id);
        ApexPages.currentPage().getParameters().put('name','test');
        ApexPages.currentPage().getParameters().put('region','Middle East / North Africa');
        ApexPages.currentPage().getParameters().put('Country', 'UNITED ARAB EMIRATES');
        
        PageReference myVfPage = Page.AddNewAccount_GEOG;
        Test.setCurrentPage(myVfPage);
        ApexPages.StandardController stdOppObj = new ApexPages.standardController(Mainacc);
        AddNewAccountExt_GEOG addacc = new AddNewAccountExt_GEOG(stdOppObj);
       
        addacc.isEdit = false;
        addacc.fetchAllCountry();
        addacc.Save();
        addacc.Cancel();
    }
    
     static testMethod void TestAddNewAccountExt3() {
         
         Account acc = AccountTestDataFactory.createGlobalRelationshipAccount('TestAccount1','GEGUL999');
      /* String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        
        Account acc = new Account();
        acc.Name='TestAccount1';
        acc.GE_HQ_DUNS_Number__c='GEGUL9999';
        acc.RecordTypeId=recordTypeName;
        acc.Account_Tier_GEOG__c = 'Global';
        insert acc;
        */
        
        
       /* Account Mainacc = new Account();
        Mainacc.Name='TestAccount1';
        Mainacc.GE_HQ_DUNS_Number__c='GEGUL9989';
        Mainacc.Account_Tier_GEOG__c ='Country';
        Mainacc.RecordTypeId=recordTypeName;
        Mainacc.Member_of_GE_OG__c = acc.id;
        insert Mainacc;*/
        
         Account Mainacc =AccountTestDataFactory.createCountryLevelAccountWithDunNum(acc,'Strategic','Competitor','GEGUL999'); 
         Contact con = AccountTestDataFactory.createContact(Mainacc.Id,'test','test');
         
        
       /* Contact con = new Contact();
        con.FirstName='test';
        con.LastName='test';
        con.Email='terst@test.com';
        con.AccountId = Mainacc.Id;
        //con.isDuplicate__c = false;
        insert con;  
        */
        AccountTestDataFactory.createStaticCountryRegionMappingData();
       /* country_region_mapping_ge_og__c country = new country_region_mapping_ge_og__c();
        country.Name = '205';
        country.country_name_ge_og__c = 'UNITED ARAB EMIRATES';
        country.iso_code_ge_og__c = 'AE';
        country.region_ge_og__c = 'Middle East / North Africa';
        country.status_ge_og__c = 'Active';
        insert country;
        */
   
    
      ApexPages.StandardController Controller = new ApexPages.StandardController (Mainacc);

System.currentPageReference().getParameters().put('id', Mainacc.id);
AddNewAccountExt_GEOG  controller2 = new AddNewAccountExt_GEOG(Controller);
      
    }
    
}