@isTest
private class QuoteLatestTest
{

  @isTest static void testQuery()
  {
    
    // create test account 
   
    CommonTestDataFactory_GE_OG objCTDF =  new CommonTestDataFactory_GE_OG ();
    
    Account objacc = CommonTestDataFactory_GE_OG.createRelationshipAccount('test account');
    system.assertEquals('test account',objacc.Name);
  
    Project_ge_og__c prj = new Project_ge_og__c();
    prj.Name = 'TestProject1';
    prj.project_account_ge_og__c = objacc.id;
    prj.GE_OG_SS_First_Oil_Date__c=Date.today();
    insert prj;
        
    upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
    upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;
    ///////////////////////
    // create test oppty //
    ///////////////////////
    Opportunity oppty = CommonTestDataFactory_GE_OG.createOppty('TestOppty',objacc.id);
    system.assertEquals('TestOppty',oppty.Name);
   
    // create test quote //
  
    Quote testQuote = new Quote();
    //testQuote.AccountId = testAccount.Id;
    testQuote.Name = 'Test Quote';
    testQuote.OpportunityId = oppty.Id;
    //testQuote.GE_MCS_ERP_Quote_Number__c = data.erpQuoteNum;
    insert testQuote;

    Test.startTest();

    String quoteId = QuoteLatest.rtnQuoteId(oppty.Id);
    System.assertEquals(quoteId, testQuote.Id);

    Test.stopTest();
  }

}