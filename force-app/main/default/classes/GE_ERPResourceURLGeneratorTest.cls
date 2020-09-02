/*
Class Name        : GE_ERPResourceURLGeneratorTest
Purpose/Overview  : Test class for GE_ERPResourceURLGeneratorTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-06-27    : Htut Zaw           : Inital creation
*/
@isTest
private class GE_ERPResourceURLGeneratorTest{

    @isTest static void testURLGeneration(){
    RecordType csRT = [select Id, Name from RecordType where sObjectType = 'Case' and Name = 'MCS - CS'];
    //RecordType opRT = [select Id, Name from RecordType where sObjectType = 'Opportunity' and Name = 'MCS RFQ Processing'];
    RecordType qtRT = [select Id, Name from RecordType where sObjectType = 'Quote' and Name = 'MCS RFQ'];

   // Account buyer1 = new Account();
    // creating account from datafactory
    account buyer1 = CommonTestDataFactory_GE_OG.createRelationshipAccount ('Test Account');
    
    User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
 /*   
    buyer1.Name='Test Acc For TestClass1';  
    
    Schema.DescribeSObjectResult accObj1 = Schema.SObjectType.Account; 
    Map<String,Schema.RecordTypeInfo> accByName1 = accObj1.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName_acc1 =  accByName1.get('Relationship Account');
    Id acc1=rtByName_acc1.getRecordTypeId();
    buyer1.RecordTypeId=acc1;
    buyer1.GE_OG_AccFin_Status__c='In Progress';
    buyer1.GE_HQ_Request_Status__c ='CMF Approved';
    buyer1.ShippingCountry ='ARGENTINA';
    buyer1.GE_PW_Phone_New_Request__c='(111)111-1111';
    buyer1.Account_Tier_GEOG__c = 'Country';
    buyer1.type = 'Channel Partner';
    buyer1.Classification__c = 'Strategic';
    insert buyer1;
    */
    
    Project_ge_og__c prj = new Project_ge_og__c();
    prj.Name = 'TestProject1';
    prj.GE_OG_SS_First_Oil_Date__c = Date.today();
    prj.project_account_ge_og__c = buyer1.id;
    insert prj;
        
    upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
    upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;
    CommonTestDataFactory_GE_OG.DeactivateIFETrig();
    
      //creating new opportuntiy
        opportunity oppty = CommonTestDataFactory_GE_OG.createOppty('TestOppty', buyer1.id);
  /*
    Opportunity oppty = new Opportunity();
    oppty.RecordTypeId =[select id,name from recordtype where name like 'Grouped Flow' limit 1].id;
    oppty.Name= 'Test Oppty1';
    //Start: Commented for Opportunity Cleanup
    //oppty.GE_ES_Project__c = prj.Id;
    //End: Commented for Opportunity Cleanup
    oppty.AccountId = buyer1.Id;
    oppty.Type = 'External';
    oppty.StageName = 'Negotiating';
    oppty.CurrencyIsoCode = 'USD';
    oppty.bid_due_date_ge_og__c = Date.today();
    oppty.CloseDate= Date.today();
    //oppty.GE_OG_TM_Commercial_Center__c= 'Bari';
    //oppty.GE_OG_Stream__c = 'Core Services - Aberdeen';
    //Start: Commented for Opportunity Cleanup
    //oppty.GE_OG_TM_Quote_Type__c = 'Budget';
    //End: Commented for Opportunity Cleanup
    //oppty.GE_OG_TM_Industrial_Sector__c = 'LNG';
    //oppty.GE_OG_TM_Generate_ID__c = True;
    //oppty.GE_OG_TM_Subsector__c = 'CCR';
    //oppty.GE_OG_TM_Application_Center__c = 'Bari';
    oppty.rfq_received_date_ge_og__c = Date.today();
    //Start: Commented below for Opportunity Cleanup
    //oppty.GE_OG_TM_Proposal_Assesment__c = 'Tech & Comm With Same Due Date';
    //End: Commented below for Opportunity Cleanup
    //oppty.end_user_ge_og__c = buyer1.Id;
    oppty.oppty_cm_ge_og__c = 35;
    oppty.tier_1_ge_og__c= 'Oil & Gas';
    oppty.tier_2_ge_og__c = 'Turbomachinery & Process Solutions';
    oppty.tier_3_ge_og__c = 'Upgrades';
    //oppty.expected_delivery_date_ge_og__c = date.today();
   // oppty.GE_ES_Ship_To__c = buyer1.Id;
    oppty.disposition_comments_ge_og__c = 'Disposition Comments';
    insert oppty;
    
 */   
    /*
    Case testCase = new Case();
    testCase.AccountId = buyer1.Id;
    testCase.RecordTypeId = csRT.Id;
    testCase.GE_Tier_3__c = 'Bently Nevada';
    testCase.Status = 'Open';
    testCase.GE_PW_SubCaseTyp__c = 'RFQ Processing';
    testCase.GE_ES_Customer_Request_Date__c = Date.today();
    testCase.Opportunity_Name__c = oppty.Id;
    testCase.GE_ES_Sub_Type__c='Technical Support Request';
    insert testCase;
    */
    Quote testQuote = new Quote();
    testQuote.RecordTypeId = qtRT.Id;
    testQuote.Name = 'Test Quote';
    testQuote.OpportunityId = oppty.Id;
    testQuote.GE_SOR_Quote_Number__c = '1234';
    insert testQuote;

    Order testOrder = new Order();
    testOrder.AccountId = buyer1.Id;
    testOrder.Name = 'Test Order';
    //testOrder.GE_SOR_Sales_Order__c = '1234';
    testOrder.EffectiveDate = Date.today();
    Schema.DescribeFieldResult statusFieldRes = Order.Status.getDescribe();
    testOrder.Status = statusFieldRes.getPicklistValues().get(0).getValue();
    insert testOrder;

    Test.startTest();

    String quoteURL = GE_ERPResourceURLGenerator.getQuotePersonaURL(testQuote.Id, false);
    System.debug('quoteURL=' + quoteURL);
    System.assert(quoteURL != null);
    System.assert(quoteURL.contains('P_DUNS'));
    System.assert(quoteURL.contains('P_SFDC'));

    String orderURL = GE_ERPResourceURLGenerator.getOrderPersonaURL(testOrder.Id, false);
    System.debug('orderURL=' + orderURL);
    System.assert(orderURL != null);
    System.assert(orderURL.contains('P_DUNS'));
    System.assert(orderURL.contains('P_SFDC'));
    System.assert(!orderURL.contains('P_SAP_OD'));

    testOrder.GE_SOR_Sales_Order__c = '1234';
    update testOrder;
    orderURL = GE_ERPResourceURLGenerator.getOrderPersonaURL(testOrder.Id, false);
    System.assert(orderURL.contains('P_SAP_OD'));
    System.assert(!orderURL.contains('P_DUNS'));

    //String quoteId = GE_QuoteUtilsWS.rtnQuoteId(testOpp.Id);
    //System.assertEquals(quoteId, testQuote.Id);

    Test.stopTest();
  }
  
  @isTest static void testURLGeneration2()
  {
      new GE_ERPResourceURLGenerator();
  }
}