@isTest
private class Test_AccountRelatedListMigration{
//This Test method is to test the Try block of AccountRelatedListMigration
public static testMethod void testAccountRelatedListMigrationTry(){
GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest = true;
    Account acc = new Account();
    acc.Name='Test Acc For TestClass';  
    acc.GE_HQ_Request_Status__c='CMF Approved';
    acc.GE_HQ_KYC_Complete__c=TRUE;
    acc.GE_PRM_KYC_Completed__c=TRUE;
    acc.GE_HQ_DUNS_Number__c='554520959';  
    acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
    acc.GE_OG_Buss_Tier2__c='Lufkin';
    acc.GE_OG_Buss_Tier3__c='Oilfield';
    acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
    acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
    acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
    acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
    acc.GE_PW_Country_Bill_To__c='UNITED STATES';
    acc.GE_PW_City_Bill_To__c='United States';
    acc.GE_PW_State_Province_Bill_To__c='state';
    acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
    acc.GE_PW_Country_Ship_To__c='UNITED STATES';
    acc.GE_PW_City_Ship_To__c='city';
    acc.GE_PW_State_Province_Ship_To__c='state';
    acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
    acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
    acc.GE_HQ_Nts_Comments__c='Test';
    acc.GE_HQ_Proposed_DUNS__c = 'test';

    Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
    Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('Relationship Account');
    Id acc1 = rtByName_acc1.getRecordTypeId();
    acc.RecordTypeId = acc1;
    acc.GE_OG_AccFin_Status__c = 'In Progress';
    acc.GE_HQ_Request_Status__c ='CMF Approved';
    acc.ShippingCountry = 'ARGENTINA';
    acc.GE_PW_Phone_New_Request__c = '(111)111-1111';
    acc.Type = 'Direct Customer';
    acc.Classification__c = 'Strategic';
    insert acc;
    //creating a project

    Project_ge_og__c proj=new Project_ge_og__c();
    proj.Name='test';
    proj.GE_OG_TM_Project_End_User__c=acc.id;
    proj.project_account_ge_og__c = acc.id;
    insert proj;
              
    upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
    upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;

    Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();


    Opportunity Oppt=new Opportunity(name='MyOpportunity11');
    Oppt.Recordtypeid=[select id from Recordtype where sobjecttype='Opportunity' and name like 'O&G' limit 1].id;
    Oppt.StageName='Prospecting';
    Oppt.accountid=acc.id;
    Oppt.tier_2_ge_og__c='Digital Solutions';    
    Oppt.tier_3_ge_og__c ='Control Solutions';
    oppt.amount_ge_og__c = 43534;
    Oppt.bid_due_date_ge_og__c=Date.today()+3;
    //Oppt.GE_ES_R_Status__c='R0'; 
    //Oppt.GE_ES_R2_Completed_Date__c=Date.today();
    //Oppt.Proposal_Date_Stamp__c=Date.today();
    //Oppt.GE_ES_Disposition_Date__c=Date.today();
    Oppt.CloseDate=Date.today()+5;
    //Oppt.commercial_primary_resource_ge_og__c=UserInfo.getUserId();         
    Oppt.Type='External';  
    Oppt.LeadSource='Other';
    //Oppt.GE_OG_This_Deal_meets_all_Express_Reqs__c=true;
    //Oppt.GE_ES_Risk_Path__c='Express'; 
    //Oppt.rev_request_date_ge_og__c=Date.Today(); 
    //Oppt.rev_due_date_ge_og__c=Date.today();
    // Oppt.GE_ES_OPPTY_CM__c=12.00;
    oppt.CurrencyIsoCode = 'USD';
    //oppt.end_user_ge_og__c=acc.id;             
    insert Oppt;    
    Opportunity retOppBM=[select id, name, AccountId from Opportunity where AccountID=:acc.id];
    system.debug('New Opp Created::::::::::::::::::::::::::::::::::::::::::' +retOppBM);
    Contact conTest= new Contact(GE_OG_Contact_Audience__c='Customer Care',FirstName='Pragyaa',LastName='Dutta',AccountId=acc.id, GE_ES_I_Agree_picklist__c='Yes' ,Email='user@ge.com');
    insert conTest;
    Contact retConBM=[select id, name,AccountId from Contact where AccountID=:acc.id];
    system.debug('New Cont Created::::::::::::::::::::::::::::::::::::::::::' +retConBM);

    System.assertEquals(retOppBM.AccountId,acc.id);
    System.assertEquals(retConBM.AccountId,acc.id);

    PageReference pageRef = Page.InitiateMigration;
    pageRef.getParameters().put('id',acc.id); 
    Test.setCurrentPage(pageRef);

    ApexPages.StandardController stdOppObj= new ApexPages.standardController(acc);
    AccountRelatedListMigration accRelListMig= new AccountRelatedListMigration(stdOppObj);

    accRelListMig.arrAcc=new list<account>();
    accRelListMig.strAccName=new list<account>();
    accRelListMig.strProposedDUNS=new list<account>();
    accRelListMig.oppId= new list<Opportunity>();
    accRelListMig.contactId= new list<Contact>();

    accRelListMig.Migrate();
    try{
    Opportunity retOppAM=[select id, name, AccountId from Opportunity where AccountID=:acc.id];
    Contact retConAM=[select id, name, AccountId from Contact where AccountID=:acc.id];
    }
    Catch(Exception e){
    System.debug(e.getMessage());
    }
    accRelListMig.CancelMigration();
    }


}