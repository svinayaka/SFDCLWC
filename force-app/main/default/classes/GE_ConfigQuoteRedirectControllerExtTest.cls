/*
Class Name        : GE_ConfigQuoteRedirectControllerExtTest
Purpose/Overview  : Test class for GE_ConfigQuoteRedirectControllerExt
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-06-16    : Htut Zaw           : Inital creation
*/
@isTest(seealldata=true)
private class GE_ConfigQuoteRedirectControllerExtTest
{

  @isTest static void testController()
  {
    /////////////////////////
    // create test account //
    /////////////////////////
    //GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
    //CommonTestDataFactory_GE_OG.DeactivateIFETrig();
    Account acc = new Account();
           acc.Name='Test Acc For TestClass';  
           acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
           acc.Account_Tier_GEOG__c = 'Country';
           acc.Country_GEOG__c = 'INDIA';
           acc.Classification__c= 'Strategic';
           acc.Type = 'Direct Customer';
           acc.ShippingCountry = 'India';
           acc.GE_ES_Primary_Industry__c = 'ABC';           
           insert acc;

    ///////////////////////
    // create test oppty //
    ///////////////////////
   /* Opportunity testOpp = new Opportunity();
    testOpp.AccountId = acc.Id;
    testOpp.GE_HQ_Business_Tier1__c = 'Oil & Gas (O&G)';
    testOpp.GE_HQ_Business_Tier2__c = 'Lufkin';
    testOpp.GE_ES_PGS_Sub_P_L__c = 'Bently Nevada';
    testOpp.GE_ES_Customer_Type__c = 'End User';
    testOpp.StageName = 'Quoted';
    testOpp.CloseDate = Date.today();
    testOpp.Name = 'Test Opp';
    testOpp.GE_Tier_4__c = 'MVS';
    testOpp.GE_Tier_5_del__c = 'SC';
    insert testOpp; */
    
    Project_ge_og__c prj = new Project_ge_og__c();
        prj.Name = 'TestProject1';
        prj.GE_OG_SS_First_Oil_Date__c=Date.today();
        prj.project_account_ge_og__c=acc.id;
        //insert prj;
        
        upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
        upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;
        
        //Opportunity oppty = CommonTestDataFactory_GE_OG.createOppty('TEst Oppty', acc.id);
        /*
        Opportunity oppty = new Opportunity();
        //oppty.RecordTypeId =[select id,name from recordtype where name like 'OG TMS Service Opportunity' limit 1].id;
        oppty.Name= 'Test Oppty1';
        oppty.opportunity_project_ge_og__c = prj.Id;
        oppty.AccountId = acc.Id;
        oppty.Type = 'Primary';
        oppty.StageName = 'Prospecting';
        oppty.CurrencyIsoCode = 'USD';
        oppty.bid_due_date_ge_og__c = Date.today();
        oppty.CloseDate= Date.today();
        //oppty.GE_OG_TM_Commercial_Center__c= 'Bari';
        //oppty.GE_OG_Stream__c = 'Core Services - Aberdeen';
        //Start: Commeneted below for Opportunity Cleanup
        //oppty.GE_OG_TM_Quote_Type__c = 'Budget';
        //End: Commeneted below for Opportunity Cleanup
        //oppty.GE_OG_TM_Industrial_Sector__c = 'LNG';
        //oppty.GE_OG_TM_Generate_ID__c = True;
        //oppty.GE_OG_TM_Subsector__c = 'CCR';
        //oppty.GE_OG_TM_Application_Center__c = 'Bari';
        oppty.rfq_received_date_ge_og__c = Date.today();
        //Start: Commented for Opportunity Cleanup
        //oppty.GE_OG_TM_Proposal_Assesment__c = 'Tech & Comm With Same Due Date';
        //End: Commented for Opportunity Cleanup
        //oppty.end_user_ge_og__c = acc.Id;
        oppty.oppty_cm_ge_og__c = 35;
        oppty.tier_2_ge_og__c = 'TMS';
        oppty.tier_3_ge_og__c ='Bently Nevada';
        oppty.amount_ge_og__c =1000.00;
        
        insert oppty;

        */
    ///////////////////////
    // create test quote //
    ///////////////////////
    /*
    Quote testQuote = new Quote();
    //testQuote.AccountId = testAccount.Id;
    testQuote.Name = 'Test Quote';
    testQuote.OpportunityId = oppty.Id;
    //testQuote.GE_MCS_ERP_Quote_Number__c = data.erpQuoteNum;
    insert testQuote;

    GE_ERP_Endpoints__c orgDef = GE_ERP_Endpoints__c.getOrgDefaults();

    Test.startTest();

    ApexPages.StandardController sc = new ApexPages.standardController(testQuote);
    GE_ConfigQuoteRedirectControllerExt ext = new GE_ConfigQuoteRedirectControllerExt(sc);

    PageReference pageRef = ext.redirectToPage();
    System.assert(pageRef.getUrl().startsWith(orgDef.SAP_Persona_BaseURL__c));

    Test.stopTest();
   */ 
  }

}