@isTest
public class AddLEAccountController_GEOG_Test {        

    static testMethod void AddLEAccountController_GEOG1() {
        
        AccountTestDataFactory.createAccountPrepoulateDataData();

   String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('New Customer Request').getRecordTypeId();

    /* GE_Account_Prepopulate_OG__c cs = new GE_Account_Prepopulate_OG__c();
    cs.Name ='Test1';
    cs.Region_GEOG__c ='Sub-saharan';
    cs.Type__c ='Direct Customer';
    cs.Classification__c ='Key Account';
    cs.Country_GEOG__c ='EQUATORIAL GUINEA';
    cs.Member_of_GE_OG__c ='MARATHON OIL / HQ';
    cs.Oil_Gas_Parent_Account__c ='MARATHON OIL / EQUATORIAL GUINEA';
    cs.Account_Tier_GEOG__c ='LE';
    insert cs;*/
    

   
   /* Account oGAct = new Account();
    oGAct.recordtypeId = recordTypeName;
    oGAct.Name='TestAccount1';
    oGAct.Phone='8963217452';
    //oGAct.RecordTypeId=recordTypeName;
    oGAct.GE_HQ_Site_Use_Code__c= 'Country';
    oGAct.GE_HQ_New_Account_Street__c ='test';
    oGAct.GE_HQ_New_Account_City__c ='test';
    oGAct.GE_HQ_New_Account_State_Province__c = 'test';
    oGAct.GE_HQ_New_Account_Zip_Postal_Code__c ='201301';
    oGAct.GE_HQ_New_Account_Country__c ='India';
    insert oGAct;*/
    Account oGAct = AccountTestDataFactory.createHQAccnt('TestAccount1');

    GE_Account_Prepopulate_OG__c ap = new GE_Account_Prepopulate_OG__c();
    ap.Name = 'GE Account Fields';
    ap.Oil_Gas_Parent_Account__c = 'Oil_Gas_Parent_Account__c';
    ap.Type__c= 'acc6';
    ap.Member_of_GE_OG__c= 'Member_of_GE_OG__c';
    ap.Classification__c= 'Classification__c';
    ap.Region_GEOG__c= 'Region_GEOG__c';
    ap.Country_GEOG__c= 'Country_GEOG__c';
    ap.Account_Tier_GEOG__c = 'Account_Tier_GEOG__c';
    insert ap;
            
    Test.setCurrentPageReference(new PageReference('Page.myPage'));
    ApexPages.currentPage().getParameters().put('OG_Id',oGAct.Id);

    ApexPages.currentPage().getParameters().put('recordType',recordTypeName);
    String id = ApexPages.currentPage().getParameters().get('recordType');
    ApexPages.StandardController stdOppObj = new ApexPages.standardController(oGAct);
    AddLEAccountController_GEOG accsearch = new AddLEAccountController_GEOG(stdOppObj);
    //accsearch.cs = ap;
    accsearch.isEdit = true;
    accsearch.Save();
    accsearch.callpageredirect();
    accsearch.isEdit =true;
       }
}