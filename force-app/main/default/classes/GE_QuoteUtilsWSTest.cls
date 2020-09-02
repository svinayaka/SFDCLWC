/*
Class Name        : GE_QuoteUtilsWSTest
Purpose/Overview  : Test class for GE_QuoteUtilsWS class
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-11    : Htut Zaw           : Inital creation
*/
@isTest
private class GE_QuoteUtilsWSTest
{

  @isTest static void testQuery()
  {
   
        // Account create
        
        account acc = new account();
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Drilling';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        insert acc;

   
        // Project create
         
        Project_ge_og__c prj = new Project_ge_og__c();
        prj.name = 'Test';
        prj.Project_Summary_ge_og__c = 'Test';
        prj.project_account_ge_og__c = acc.id;
        prj.Estimated_Value_ge_og__c = 10;
        Prj.Project_Stage_ge_og__c='Negotiation';
        Insert prj;
        
        upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
        upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;
        
        //Opportunity create
        
        Opportunity oppty = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',oppty.Name);


        // create test quote 
 
        Quote testQuote = new Quote();
        testQuote.Name = 'Test Quote';
        testQuote.OpportunityId = oppty.Id;
        insert testQuote;

        Test.startTest();
    
        String quoteId = GE_QuoteUtilsWS.rtnQuoteId(oppty.Id);
        System.assertEquals(quoteId, testQuote.Id);
    
        Test.stopTest();
  }

}