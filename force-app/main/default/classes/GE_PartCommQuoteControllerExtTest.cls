/*
Class Name        : GE_PartCommQuoteControllerExtTest
Purpose/Overview  : Test class for GE_PartCommQuoteControllerExt class
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-11    : Htut Zaw           : Initial creation
*/
@isTest(SeeAllData = true)
private class GE_PartCommQuoteControllerExtTest
{

  @isTest static void testQuotePagination()
  {
    List<Quote> quoteList = new List<Quote>();

    /////////////////////////
    // create test account //
    /////////////////////////
    /*Account testAccount = new Account();
    testAccount.Name = 'Test Account';
    testAccount.currencyIsoCode = 'USD';
    testAccount.GE_HQ_DUNS_Number__c = '101010101';
    testAccount.GE_HQ_KYC_Complete__c = TRUE;
    testAccount.GE_HQ_Request_Status__c = 'CMF Approved';
    insert testAccount;
    */
        //GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;

      Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
      Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
      Schema.RecordTypeInfo rtByName_accr =  accByName.get('Relationship Account');
      Id accr = rtByName_accr.getRecordTypeId();
      
      Account acc1 = new Account();
      acc1.Name='Test Acc For TestClass';
      acc1.GE_HQ_DUNS_Number__c='GEGUL9999';
      acc1.RecordTypeId = accr;
      acc1.Type='Direct Customer';
      acc1.Classification__c='Strategic';
      insert acc1;
      
      Account acc = new Account();
          acc.Name='Test Acc For TestClass';  
           //acc.GE_HQ_Request_Status__c='CMF Approved';
           //acc.GE_HQ_KYC_Complete__c=TRUE;
           //acc.GE_PRM_KYC_Completed__c=TRUE;
           acc.GE_HQ_DUNS_Number__c='557851129';  
           //acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
           //acc.GE_OG_Buss_Tier2__c='Lufkin';
           //acc.GE_OG_Buss_Tier3__c='Oilfield';
           //acc.Account_Tier_GEOG__c='LE';
           acc.ParentId=acc1.id;
           //acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
           //acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
           //acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
           //acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
           //acc.GE_PW_Country_Bill_To__c='UNITED STATES';
           //acc.GE_PW_City_Bill_To__c='United States';
           //acc.GE_PW_State_Province_Bill_To__c='state';
           //acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
           //acc.GE_PW_Country_Ship_To__c='UNITED STATES';
           //acc.GE_PW_City_Ship_To__c='city';
           //acc.GE_PW_State_Province_Ship_To__c='state';
           //acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
           //acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
           //acc.GE_HQ_Nts_Comments__c='Test';
           acc.RecordTypeId = accr;
          acc.Type='Direct Customer';
      acc.Classification__c='Strategic';    
           //acc.GE_OG_AccFin_Status__c = 'In Progress';
           //acc.GE_HQ_Request_Status__c ='CMF Approved';
           //acc.ShippingCountry = 'ARGENTINA';
           //acc.GE_PW_Phone_New_Request__c = '(111)111-1111';
           insert acc;
      
    ///////////////////////
    // create test oppty //
    ///////////////////////
    /*Opportunity testOpp = new Opportunity();
    testOpp.Name = 'Test Opp';
    testOpp.AccountId = acc.Id;
    testOpp.GE_HQ_Business_Tier1__c = 'Oil & Gas (O&G)';
    testOpp.GE_HQ_Business_Tier2__c = 'Measurement & Control (M&C)';
    testOpp.GE_ES_PGS_Sub_P_L__c = 'Bently Nevada';
    testOpp.GE_ES_Customer_Type__c = 'End User';
    testOpp.StageName = 'Abandoned';
    testOpp.CloseDate = Date.today().addDays(14);
    insert testOpp;
    */
     Opportunity oppty = new Opportunity();
        //oppty.RecordTypeId =[select id,name from recordtype where name like 'OG TMS Service Opportunity' limit 1].id;
        oppty.Name= 'Test Oppty1';
        oppty.AccountId = acc.Id;
        oppty.Type = 'External';
        oppty.StageName = 'Prospecting';
        oppty.CurrencyIsoCode = 'USD';
        oppty.bid_due_date_ge_og__c = Date.today();
        oppty.CloseDate= Date.today();
       // oppty.GE_OG_TM_Commercial_Center__c= 'Bari';
       // oppty.GE_OG_Stream__c = 'Core Services - Aberdeen';
        //Start: Commented for Opportunity Cleanup
        //oppty.GE_OG_TM_Quote_Type__c = 'Budget';
        //Start: Commented for Opportunity Cleanup
        //oppty.GE_OG_TM_Industrial_Sector__c = 'LNG';
        //oppty.GE_OG_TM_Generate_ID__c = True;
        //Start:Commented below for Oppty Cleanup
        //oppty.GE_OG_TM_Subsector__c = 'CCR';
        //End:Commented below for Oppty Cleanup
        //oppty.GE_OG_TM_Application_Center__c = 'Bari';
        oppty.rfq_received_date_ge_og__c = Date.today();
        //Start: Commented below for Opportunity Cleanup
        //oppty.GE_OG_TM_Proposal_Assesment__c = 'Tech & Comm With Same Due Date';
        //End: Commented below for Opportunity Cleanup
        //oppty.end_user_ge_og__c = acc.Id;
        oppty.oppty_cm_ge_og__c = 35;
        oppty.tier_2_ge_og__c = 'Digital Solutions';
        oppty.amount_ge_og__c=100;
        oppty.tier_3_ge_og__c='Bently Nevada';
        insert oppty;

    ////////////////////////
    // create test quotes //
    ////////////////////////
    //Quote quote = new Quote(Name = 'Test1', OpportunityId = testOpp.Id, ExpirationDate = Date.today(), GE_SOR_Grand_Total__c = 100.0);
    Quote quote = new Quote(Name = 'Test1', OpportunityId = Oppty.Id);
    insert quote;
    quoteList.add(quote);

    //quote = new Quote(Name = 'Test2', OpportunityId = testOpp.Id, ExpirationDate = Date.today(), GE_SOR_Grand_Total__c = 155.0);
    quote = new Quote(Name = 'Test2', OpportunityId = Oppty.Id);
    insert quote;
    quoteList.add(quote);

    ///////////////////
    // start testing //
    ///////////////////
    Test.startTest();
    ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(quoteList);
    GE_PartCommQuoteControllerExt controllerExt = new GE_PartCommQuoteControllerExt(stdSetController);

    List<Quote> qList = controllerExt.getQuotePagination();
    System.assert(qList.size() > 0);

    //////////////////
    // stop testing //
    //////////////////
    Test.stopTest();
  }

}