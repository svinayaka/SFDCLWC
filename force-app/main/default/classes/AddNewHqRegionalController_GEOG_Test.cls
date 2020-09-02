@isTest
public class AddNewHqRegionalController_GEOG_Test {        
    static testMethod void TestAddNewAccountExt1() {
    String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();

    Account globacc = new Account();
    globacc.Name='TestAccount1';
    globacc.GE_HQ_DUNS_Number__c='GEGUL9999';
    globacc.RecordTypeId=recordTypeName;
    globacc.Account_Tier_GEOG__c = 'Global';
    globacc.Classification__c= 'Strategic';
    globacc.type='Direct Customer';
    insert globacc;

    Account globacc1 = new Account();
    globacc1.Name='Account2';
    globacc1.GE_HQ_DUNS_Number__c='GEGUL0000';
    globacc1.RecordTypeId=recordTypeName;
    globacc1.Account_Tier_GEOG__c = 'Global';
    globacc1.Classification__c= 'Strategic';
    globacc1.type='Direct Customer';
    insert globacc1;
        
    Account oGAct = new Account();
    oGAct.Name='TestAccountreg';
    oGAct.GE_HQ_DUNS_Number__c='GEGUL9989';
    oGAct.RecordTypeId=recordTypeName;
    oGAct.Account_Tier_GEOG__c = 'Regional';
    oGAct.Member_of_GE_OG__c = globacc.id;
    oGAct.ParentId = globacc.id;
    oGAct.Classification__c= 'Strategic';
    oGAct.type='Direct Customer';
    insert oGAct; 

    Contact con1 = new Contact();
    con1.FirstName='test';
    con1.LastName='test';
    con1.Email='terst12@test.com';
    con1.AccountId = globacc1.Id;
    //con.isDuplicate__c = false;
    con1.GE_OG_Contact_Audience__c = 'Sales / ITO';
    insert con1;  

    Contact con = new Contact();
    con.FirstName='test';
    con.LastName='test';
    con.Email='terst@test.com';
    con.AccountId = oGAct.Id;
    con.GE_OG_Contact_Audience__c = 'Sales / ITO';
    //con.isDuplicate__c = false;
    insert con;  

    list<Contact> lstcont = new list<Contact>();
    lstcont.add(con1);

    PageReference myVfPage = Page.AddNewAccount_GEOG;
    Test.setCurrentPage(myVfPage);
    
   
    ApexPages.currentPage().getParameters().put('name',oGAct.name);
    String id = ApexPages.currentPage().getParameters().get('name');
    ApexPages.StandardController stdOppObj = new ApexPages.standardController(oGAct);
    AddNewHqRegionalController_GEOG addacc = new AddNewHqRegionalController_GEOG(stdOppObj);
    //ApexPages.currentPage().getParameters().put('Id',oGAct.Id);
    ApexPages.currentPage().getParameters().put('name','test');
    addacc.isEdit = true;
    addacc.con.Email = 'terst@test.com';
    //addacc.fetchAllCountry();
    addacc.getPickLstValue();
    addacc.lstcon =  lstcont;

    addacc.con.Email = 'terst@test.com';
    addacc.Save();
    addacc.Cancel();

    }
     
    static testMethod void TestAddNewAccountExt2() {
    String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();

    Account globacc = new Account();
    globacc.Name='TestAccount1';
    globacc.GE_HQ_DUNS_Number__c='GEGUL9999';
    globacc.RecordTypeId=recordTypeName;
    globacc.Account_Tier_GEOG__c = 'Global';
    globacc.Classification__c= 'Strategic';
    globacc.type='Direct Customer';
    insert globacc;

    Account globacc1 = new Account();
    globacc1.Name='Account2';
    globacc1.GE_HQ_DUNS_Number__c='GEGUL0000';
    globacc1.RecordTypeId=recordTypeName;
    globacc1.Account_Tier_GEOG__c = 'Global';
    globacc1.Classification__c= 'Strategic';
    globacc1.type='Direct Customer';
    insert globacc1;
        
    Account oGAct = new Account();
    oGAct.Name='TestAccountreg';
    oGAct.GE_HQ_DUNS_Number__c='GEGUL9989';
    oGAct.RecordTypeId=recordTypeName;
    oGAct.Account_Tier_GEOG__c = 'Regional';
    oGAct.Member_of_GE_OG__c = globacc.id;
    oGAct.ParentId = globacc.id;
    oGAct.Classification__c= 'Strategic';
    oGAct.type='Direct Customer';
    insert oGAct; 

    PageReference myVfPage = Page.AddNewAccount_GEOG;
    Test.setCurrentPage(myVfPage);
    
    ApexPages.currentPage().getParameters().put('name',oGAct.name);
    String id = ApexPages.currentPage().getParameters().get('name');
    ApexPages.StandardController stdOppObj = new ApexPages.standardController(oGAct);
    AddNewHqRegionalController_GEOG addacc = new AddNewHqRegionalController_GEOG(stdOppObj);
    //ApexPages.currentPage().getParameters().put('Id',oGAct.Id);
    ApexPages.currentPage().getParameters().put('name','test');
    addacc.isEdit = true;
    addacc.con.Email = 'terst@test.com';
    //addacc.fetchAllCountry();
    addacc.getPickLstValue();
    //addacc.lstcon =  lstcont;

    addacc.con.Email = 'terst@test.com';
    addacc.Save();
    addacc.Cancel();

    }

}