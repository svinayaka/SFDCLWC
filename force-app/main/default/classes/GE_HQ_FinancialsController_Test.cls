@isTest
Public class GE_HQ_FinancialsController_Test{

static testmethod void createTest1(){
    User usr = [select Id,Name,isActive,Profile.Name from User where Profile.Name like '%System Administrator%' and GE_HQ_Tier_2_P_L__c = 'HQ' and isActive=true limit 1];
    test.startTest();
    System.runAs(usr){
    // Create Account record
    Account objAccount = new Account();
    User u = [select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   

    objAccount.Name='Test Acc For TestClass'; 
    objAccount.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    //objAccount.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
    objAccount.type='Channel Partner';
    objAccount.GE_HQ_Request_Status__c='CMF Approved';
    objAccount.GE_HQ_KYC_Complete__c=TRUE;
    objAccount.GE_PRM_KYC_Completed__c=TRUE;   
    //objAccount.GE_HQ_DUNS_Number__c='555123459';  
    objAccount.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
    objAccount.GE_OG_Buss_Tier2__c='Lufkin';
    objAccount.GE_OG_Buss_Tier3__c='Oilfield';
    objAccount.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
    objAccount.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
    objAccount.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
    objAccount.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
    objAccount.GE_PW_Country_Bill_To__c='UNITED STATES';
    objAccount.GE_PW_City_Bill_To__c='United States';
    objAccount.GE_PW_State_Province_Bill_To__c='state';
    objAccount.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
    objAccount.GE_PW_Country_Ship_To__c='UNITED STATES';
    objAccount.GE_PW_City_Ship_To__c='city';
    objAccount.GE_PW_State_Province_Ship_To__c='state';
    objAccount.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
    objAccount.GE_HQ_New_Account_Country__c = 'UNITED STATES';
    objAccount.GE_HQ_Nts_Comments__c='Test';
    objAccount.Classification__c = 'Strategic';
    objAccount.GE_OG_AccFin_Status__c = 'In Progress';
    objAccount.GE_HQ_Request_Status__c ='CMF Approved';
    objAccount.ShippingCountry = 'ARGENTINA';
    objAccount.GE_PW_Phone_New_Request__c = '(111)111-1111';
    objAccount.Account_Tier_GEOG__c='Country';    
    objAccount.type='Channel Partner';
    objAccount.Classification__c='Unclassified';
    objAccount.Account_Tier_GEOG__c='Country';
    objAccount.Account_Status__c='Active';
    insert objAccount;

    GE_HQ_Account_Plan__c accPlan = new GE_HQ_Account_Plan__c(Name = 'Test Account Plan 1', GE_PRM_Account__c = objAccount.id);
    insert accPlan;

    //inserting account plan rel
    GE_HQ_Acc_AccPlan_Rel__c myGEAccount = new GE_HQ_Acc_AccPlan_Rel__c (GE_HQ_Account_Plan__c=accPlan.Id, GE_HQ_Account__c = objAccount.id);
    insert myGEAccount ;

    test.stoptest(); 
    // Create Project record
    Project_ge_og__c objProject = new Project_ge_og__c();
    objProject.Name = 'TestProject1';
    objProject.GE_OG_SS_First_Oil_Date__c = Date.today();
    objProject.project_account_ge_og__c = objAccount.id;
    insert objProject;

    // Create custom setting record
    upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
    upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;

    // Create Opportuntiy record
    CommonTestDataFactory_GE_OG.DeactivateIFETrig();
    Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
    Opportunity objOpportunity = new Opportunity();
    objOpportunity.RecordTypeId = [select id,name from recordtype where Name like 'O&G' limit 1].id;
    objOpportunity.Name = 'Test Oppty1';          
    objOpportunity.AccountId = objAccount.Id;
    objOpportunity.Type = 'External';
    objOpportunity.StageName = 'Prospecting';
    objOpportunity.amount_ge_og__c = 568995;
    objOpportunity.CurrencyIsoCode = 'USD';
    objOpportunity.bid_due_date_ge_og__c = Date.today();
    objOpportunity.CloseDate = Date.today();
   // objOpportunity.GE_OG_TM_Commercial_Center__c = 'Bari';
    //objOpportunity.GE_OG_Stream__c = 'Core Services - Aberdeen';
    //Start: Commeneted below for Opportunity Cleanup
    //objOpportunity.GE_OG_TM_Quote_Type__c = 'Budget';
    //End: Commeneted below for Opportunity Cleanup
    //objOpportunity.GE_OG_TM_Industrial_Sector__c = 'LNG';
    //objOpportunity.GE_OG_TM_Generate_ID__c = True;
    //objOpportunity.GE_OG_TM_Subsector__c = 'CCR';
    //objOpportunity.GE_OG_TM_Application_Center__c = 'Bari';
    //Start: Commented for Opportunity Cleanup
    //objOpportunity.GE_OG_TM_Proposal_Assesment__c = 'Tech & Comm With Same Due Date';
    //End: Commented for Opportunity Cleanup
    objOpportunity.tier_2_ge_og__c = objAccount.Id;
    // objOpportunity.GE_ES_OPPTY_CM__c = 35;
    objOpportunity.tier_1_ge_og__c='Oil & Gas';
    objOpportunity.tier_3_ge_og__c= 'Bently Nevada';
    objOpportunity.tier_2_ge_og__c='Digital Solutions';
    insert objOpportunity; 

    objOpportunity.StageName='Active-Commit';
    update objOpportunity;

    Product2 prod = new Product2();
    prod.name = 'Power Plant - Maintenance - Long Term Agreements - CS ERP Data Migration - Long Cycle';
    prod.IsActive = true;
    prod.ProductCode = '567';
   // prod.is_service_max_ge_og__c='Yes';
    prod.GE_Tier2_PnL__c = 'Digital Solutions';
    prod.GE_Tier3_PnL__c = 'Bently Nevada';
    prod.GE_OG_CM__c = 89;
    insert prod;

    PriceBookEntry Spbe = new PriceBookEntry();
    Spbe.CurrencyIsoCode = 'USD';
    Spbe.IsActive = true;
    Spbe.Pricebook2Id = Test.getStandardPricebookId();
    Spbe.Product2Id = prod.Id;
    Spbe.UnitPrice = 30;
    Insert Spbe;

    OpportunityLineItem OLI = new OpportunityLineItem();
    OLI.OpportunityId = objOpportunity.Id;
    OLI.PRICEBOOKENTRYID =   Spbe.ID ;
    OLI.Quantity=2;        
    OLI.UNITPRICE=30;
   // OLI.GE_Rll_Curr__c   =5 ;
    insert OLI;
    
 }
    GE_HQ_Account_Plan__c AccPlan = [Select ID From GE_HQ_Account_Plan__c Limit 1 ];

    PageReference pg = Page.GE_HQ_Financials ;
    pg.getParameters().Put('id',AccPlan.ID);
    Test.setCurrentPage(pg); 

    ApexPages.StandardController std = New ApexPages.StandardController(AccPlan);
    GE_HQ_FinancialsController cc = New GE_HQ_FinancialsController(std);
    GE_HQ_FinancialsController.FinancialRec fc = new GE_HQ_FinancialsController.FinancialRec(2016,12345678,'test');
   
    cc.TotalPTRecords = 5; 
    cc.StartRecPT = 5 ;
    //cc.NextCountPacing=0;
    cc.TotalPacingRecords=5;
    cc.StartRecPacing=5;
    cc.EndRecpacing=5;
    cc.renderNextPacing=true;
    cc.renderLastPacing=true;
    cc.renderFirstPacing=true;
    cc.renderPrevPacing=true;
    cc.EndRecPT = 6 ;
    cc.TotalPipelineRecords=5; 
    //cc.NextCountPL=0;
    cc.StartRecPL=5;
    cc.EndRecPL=5;
    cc.renderFirstPL=false;
    cc.renderPrevPL=false;
    cc.renderFirstPT = true ;
    cc.renderPrevPT  = true ;
    cc.renderNextPT  = true ;
    cc.renderLastPT  = true ;
            cc.getPipelineRecs(); 
    cc.getPacingRecs();

    List<Opportunity> OppList = new List<Opportunity>();
    String[] PnL = new String[]{'Industrial Solutions (IS)','Digital Energy (DE)','Measurement Control Solutions (MCS)' }; //'Env','MCS','DE'}; //,'Dresser','Water ES','Motors','DE'};
    for(Integer i=0; i<PnL.size() ;i++) {
    //Opportunity Opp = new Opportunity(GE_HQ_Business_Tier2__c = PnL[i], StageName='Active - Commit', Name='Opp1', CloseDate=Date.Today(), AccountID=Acc1.Id, GE_ES_Last_Allowable_Ship_Date__c = Date.today(), Expected_Delivery_Date__c = Date.today(), GE_ES_Disposition_Reason__c= 'Cycle',bid_due_date_ge_og__c=Date.Today());
    //OppList.add(Opp);
    }
    for(Integer i=0; i<PnL.size();i++) {
    //Opportunity Opp = new Opportunity(GE_HQ_Business_Tier2__c = PnL[i], StageName='Prospect', Name='Opp1', CloseDate=Date.Today(), AccountID=Acc1.Id, GE_ES_Last_Allowable_Ship_Date__c = Date.today(), Expected_Delivery_Date__c = Date.today(), GE_ES_Disposition_Reason__c= 'Cycle');
    //OppList.add(Opp);
    }
    Insert OppList;
    List<OpportunityLineItem> OLIlist = new List<OpportunityLineItem>();
    For(Opportunity o: OppList) {
    //OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = o.Id, GE_ES_Primary_Quote__c = True, Quantity = 1, UnitPrice = 500, PricebookEntryId = pbe.Id);
    //OLIlist.add(oli);
    }
    Insert OLIlist;
    List<GE_HQ_Forecasted_SAS__c> FSList = new List<GE_HQ_Forecasted_SAS__c>();
    GE_HQ_Forecasted_SAS__c FS1 = new GE_HQ_Forecasted_SAS__c(GE_HQ_Account_Plan__c = AccPlan.Id,GE_HQ_SAS_Value__c =1000,GE_HQ_Buss_Tier__c='Energy Management (EM)', GE_HQ_Buss_Tier1__c = 'Digital Energy (DE)',GE_HQ_Year__c ='2011',GE_HQ_External_ID__c = 'Test1'); FSList.add(FS1);
    GE_HQ_Forecasted_SAS__c FS2 = new GE_HQ_Forecasted_SAS__c(GE_HQ_Account_Plan__c = AccPlan.Id,GE_HQ_SAS_Value__c =0,GE_HQ_Buss_Tier__c='Energy Management (EM)', GE_HQ_Buss_Tier1__c = 'Industrial Solutions (IS)',GE_HQ_Year__c ='2011',GE_HQ_External_ID__c = 'Test2'); FSList.add(FS2);
    Insert FSList;

    cc = new GE_HQ_FinancialsController(std);
    cc.NoOfRows=2;
    cc.getPacingRecs();    cc.getNextPacing(); 
    try{
    cc.getPacingRecs();
    }
    catch(Exception e)
    {
    } // To run the else conditions..
    cc.getPrevPacing();    cc.getLastPacing();     cc.getNextPacing();    
    cc.getNextPacing();    cc.getFirstPacing();    cc.getPrevPacing();
    cc.getPipelineRecs();         
    cc.getNextPipeLine();
    cc.getPrevPipeline();
    cc.getFirstPipeline();
    cc.getLastPipeLine();

    }

}