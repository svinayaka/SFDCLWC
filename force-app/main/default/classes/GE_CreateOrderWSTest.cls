/*
Class Name        : GE_CreateOrderWSTest
Purpose/Overview  : Test class for GE_CreateOrderWS class
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-05-20    : Htut Zaw           : Inital creation
*/
@isTest
private class GE_CreateOrderWSTest
{
  @isTest static void testCreateOrder()
  {
    RecordType csRT = [select Id, Name from RecordType where sObjectType = 'Case' and Name = 'MCS - CS'];
   // RecordType opRT = [select Id, Name from RecordType where sObjectType = 'Opportunity' and Name = 'MCS RFQ Processing'];
    RecordType qtRT = [select Id, Name from RecordType where sObjectType = 'Quote' and Name = 'MCS RFQ'];
    /////////////////////////
    // create test account //
    /////////////////////////
  /* Account Acc= new Account();
    Account buyer1 = new Account();

            User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
            
            buyer1.Name='Test Acc For TestClass1';  
            
            Schema.DescribeSObjectResult accObj1 = Schema.SObjectType.Account; 
            Map<String,Schema.RecordTypeInfo> accByName1 = accObj1.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName_acc1 =  accByName1.get('CMF Approved');
            Id acc1=rtByName_acc1.getRecordTypeId();
            buyer1.RecordTypeId=acc1;
            buyer1.GE_OG_AccFin_Status__c='In Progress';
            buyer1.GE_HQ_Request_Status__c ='CMF Approved';
            buyer1.ShippingCountry ='ARGENTINA';
            buyer1.GE_PW_Phone_New_Request__c='(111)111-1111';
            insert buyer1; */
            
        account acc = new account();
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Drilling';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        
        insert acc;
    ///////////////////////
    // create test oppty //
    ///////////////////////
       /* Project_ge_og__c prj = new Project_ge_og__c();
        prj.Name = 'TestProject1';
        prj.GE_OG_SS_First_Oil_Date__c=Date.today();
        Prj.Project_Stage_ge_og__c='Negotiation';
        Prj.project_account_ge_og__c =buyer1.id;
        insert prj;
         */
          //Cretaing Project
        Project_ge_og__c prj = new Project_ge_og__c();
        prj.name = 'Test';
        prj.Project_Summary_ge_og__c = 'Test';
        prj.project_account_ge_og__c = acc.id;
        prj.Estimated_Value_ge_og__c = 10;
        Prj.Project_Stage_ge_og__c='Negotiation';
        Insert prj;
        
        upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
        upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;
      
      /*  Opportunity oppty = new Opportunity();
        oppty.RecordTypeId =[select id,name from recordtype where name like 'OG TMS Unit Opportunity' limit 1].id;
        oppty.Name= 'Test Oppty1';
        oppty.opportunity_project_ge_og__c = prj.Id;
        oppty.AccountId = acc.Id;
        oppty.Type = 'Primary';
        oppty.StageName = 'Cancelled';
        oppty.CurrencyIsoCode = 'USD';
        oppty.bid_due_date_ge_og__c = Date.today();
        oppty.CloseDate= Date.today();
        oppty.GE_OG_TM_Commercial_Center__c= 'Bari';
        oppty.GE_OG_Stream__c = 'Core Services - Aberdeen';
        oppty.GE_OG_TM_Quote_Type__c = 'Budget';
        oppty.GE_OG_TM_Industrial_Sector__c = 'LNG';
        oppty.GE_OG_TM_Generate_ID__c = True;
        oppty.GE_OG_TM_Subsector__c = 'CCR';
        oppty.GE_OG_TM_Application_Center__c = 'Bari';
        oppty.rfq_received_date_ge_og__c = Date.today();
        oppty.GE_OG_TM_Proposal_Assesment__c = 'Tech & Comm With Same Due Date';
        oppty.end_user_ge_og__c = acc.Id;
        oppty.oppty_cm_ge_og__c = 35;
        oppty.tier_2_ge_og__c = 'TMS';
        oppty.delivery_date_ge_og__c = date.today();
        oppty.GE_ES_Ship_To__c = acc.Id;
        oppty.disposition_comments_ge_og__c = 'Disposition Comments';
        insert oppty; */
        
        Opportunity oppty = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',oppty.Name);
    ///////////////////////
    // create test case //
    ///////////////////////
    Case testCase = new Case();
    testCase.AccountId = acc.Id;
    testCase.RecordTypeId=csRT.Id;
    testCase.GE_Tier_3__c = 'Bently Nevada';
    testCase.Status = 'Open';
    //testCase.GE_PW_SubCaseTyp__c = 'RFQ Processing';
    testCase.GE_ES_Customer_Request_Date__c = Date.today();
    testCase.Opportunity_Name__c=oppty.Id;
    testCase.GE_ES_Sub_Type__c='Technical Support Request';
    insert testCase;
    ///////////////////////
    // create test quote //
    ///////////////////////
    Quote testQuote = new Quote();
    testQuote.RecordTypeId=qtRT.Id;
    testQuote.Name = 'Test Quote';
    testQuote.OpportunityId = oppty.Id;
    insert testQuote;

    Test.startTest();
    String orderId = GE_CreateOrderWS.creatOrder(testQuote.Id);
    Test.stopTest();
    
    Order qOrdObj = [Select Id from Order where GE_Quote__c =:testQuote.Id];
    System.assertEquals(orderId, qOrdObj.Id);
  }

  @isTest static void testCreateOrderFromCase()
  {
    RecordType csRT = [select Id, Name from RecordType where sObjectType = 'Case' and Name = 'MCS - CS'];
    /////////////////////////
    // create test account //
    /////////////////////////
    Account Acc= new Account();
    Account buyer1 = new Account();

            User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
            
            buyer1.Name='Test Acc For TestClass1';  
            
            Schema.DescribeSObjectResult accObj1 = Schema.SObjectType.Account; 
            Map<String,Schema.RecordTypeInfo> accByName1 = accObj1.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName_acc1 =  accByName1.get('CMF Approved');
            Id acc1=rtByName_acc1.getRecordTypeId();
            buyer1.RecordTypeId=acc1;
            buyer1.GE_OG_AccFin_Status__c='In Progress';
            buyer1.GE_HQ_Request_Status__c ='CMF Approved';
            buyer1.ShippingCountry ='ARGENTINA';
            buyer1.GE_PW_Phone_New_Request__c='(111)111-1111';
            insert buyer1;
    ///////////////////////
    // create test case //
    ///////////////////////
    Case testCase = new Case();
    testCase.AccountId = buyer1.Id;
    testCase.RecordTypeId=csRT.Id;
    testCase.GE_Tier_3__c = 'Bently Nevada';
    testCase.Status = 'Open';
    //testCase.GE_PW_SubCaseTyp__c = 'PO pre-Processing';
    testCase.GE_ES_Customer_Request_Date__c = Date.today();
    testCase.GE_ES_Env_Case_Amount__c = 5000;
    testCase.GE_OG_MCS_ERP_Status__c = 'Not Reported/Not Booked';
     testCase.GE_ES_Sub_Type__c='Technical Support Request';
    insert testCase;

    Test.startTest();
    String orderId = GE_CreateOrderWS.createOrderForCase(testCase.Id);
    Test.stopTest();
    
    Order qOrdObj = [Select Id from Order where Case__c =:testCase.Id];
    System.assertEquals(orderId, qOrdObj.Id);
  }
}