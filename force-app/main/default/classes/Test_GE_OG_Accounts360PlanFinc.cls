/*
Class Name        : Test_GE_OG_Accounts360PlanFinc
Purpose/Overview  : Test class for 5 classes
                    1. GE_HQ_Accounts360ViewController
                    2. AccTeamAccPlanController
                    3. GE_HQ_FinancialsController
                    4. GE_HQ_GoogleMapController
                    5. GE_HQ_Refresh_Accounts

Author            : Satyanarayana Pusuluri
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
*/
@isTest
Private Class Test_GE_OG_Accounts360PlanFinc
{

/* Start Test Class "GE_HQ_Accounts360ViewController" */
    Static TestMethod void GE_HQ_Accounts360ViewController_Test()
    {       
        GE_HQ_Account_Plan__c AccPlan = Test_GE_OG_AccountPlan_Handler.createAccountPlan();
          System.assertEquals(AccPlan.name,'TestMeth');
        // Creating a new Account
        
        List<Account> AccList = [select id from Account where Name = 'TestClassAccount-EndUser' or Name = 'TestClassAccount-ShipTo' limit 2];
       // Account Acc1 = Test_GE_OG_AccountPlan_Handler.createAccount('TestClassAccount-EndUser');
        //Account Acc2 = Test_GE_OG_AccountPlan_Handler.createAccount('TestClassAccount-ShipTo');

        account Acc1 = new account();
        Acc1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        Acc1.Name = 'accname';
        Acc1.Account_Tier_GEOG__c = 'Country';
        Acc1.Country_GEOG__c = 'USA';
        Acc1.Classification__c= 'Strategic';
        Acc1.BillingCountry = 'USA';
        Acc1.ShippingCountry = 'USA';
        Acc1.GE_HQ_DUNS_Number__c='555126948';
        Acc1.GE_ES_Primary_Industry__c = 'Industrial';
        Acc1.ShippingState = 'AT';
        Acc1.ShippingCity = 'TestShipping City';
        Acc1.ShippingStreet = 'Test Shipping Street';
        Acc1.ShippingPostalCode = '101010';
        Acc1.Type = 'Direct Customer'; 
        Acc1.Classification__c='Gold';
        //Acc.Type='Direct Customer';
        insert Acc1 ;
        
        account Acc2= new account();
        Acc2.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        Acc2.Name = 'accname1';
        Acc2.Account_Tier_GEOG__c = 'Country';
        Acc2.Country_GEOG__c = 'USA';
        Acc2.Classification__c= 'Strategic';
        Acc2.BillingCountry = 'USA';
        Acc2.ShippingCountry = 'USA';
        //Acc2.GE_HQ_DUNS_Number__c='555126949';
        Acc2.GE_ES_Primary_Industry__c = 'Industrial';
        Acc2.ShippingState = 'AT';
        Acc2.ShippingCity = 'TestShipping City';
        Acc2.ShippingStreet = 'Test Shipping Street';
        Acc2.ShippingPostalCode = '101010';
        Acc2.Classification__c='Gold';
        Acc2.Type = 'Direct Customer'; 
        insert Acc2 ;
        
       // String TestAccountName = system.Label.Test_Account_Name;
       // Account testRRAccount = new Account(name=TestAccountName);
       // insert testRRAccount;

        GE_HQ_Acc_AccPlan_Rel__c AccPlanRel = Test_GE_OG_AccountPlan_Handler.createAccountPlanRel(Acc1, AccPlan);
        GE_HQ_Acc_AccPlan_Rel__c AccPlanRe2 = Test_GE_OG_AccountPlan_Handler.createAccountPlanRel(Acc2, AccPlan);

        User user1=[Select Id,Name from User where isActive=True limit 1 ][0];
        //Start:Commented below for Opportunity Cleanup
        //Opportunity Opp1 = new Opportunity(tier_2_ge_og__c = 'Subsea (SS)', StageName='Prospect',GE_OG_DP_Ld_Pltfm__c = 'SS - Subsea', Name='Opp1', CloseDate=Date.Today(),GE_ES_Customer_Type__c = 'End User', AccountID=Acc1.Id, GE_ES_Last_Allowable_Ship_Date__c = Date.today(), delivery_date_ge_og__c = Date.today(), disposition_reason_ge_og__c= 'Cycle', install_country_ge_og__c='AUSTRALIA',GE_OG_DP_Global_Customer__c='BG GROUP',GE_OG_TM_Commercial_Center__c = 'Australia',GE_OG_TM_Quote_Type__c = 'Engineering', GE_OG_SS_Tender__c = 'Single PMS product - Tender');
        //Opportunity Opp2 = new Opportunity(tier_2_ge_og__c = 'Subsea (SS)', StageName='Prospect',GE_OG_DP_Ld_Pltfm__c = 'SS - Wellstream', Name='Opp2', CloseDate=Date.Today(),GE_ES_Customer_Type__c = 'End User', AccountID=Acc2.Id, GE_ES_Last_Allowable_Ship_Date__c = Date.today(), delivery_date_ge_og__c= Date.today(), disposition_reason_ge_og__c= 'Cycle', install_country_ge_og__c='AUSTRIA',GE_OG_DP_Global_Customer__c='BG GROUP',GE_OG_TM_Commercial_Center__c = 'AUS',GE_OG_TM_Quote_Type__c = 'Engineering');        
        //Start:Commented below for Opportunity Cleanup
        //Start: Added below for Opportunity Cleanup
        Opportunity Opp1 = new Opportunity(tier_2_ge_og__c = 'Subsea (SS)', StageName='Prospect', Name='Opp1', CloseDate=Date.Today(), AccountID=Acc1.Id, delivery_date_ge_og__c = Date.today(), disposition_reason_ge_og__c= 'Cycle', install_country_ge_og__c='AUSTRALIA');
        Opportunity Opp2 = new Opportunity(tier_2_ge_og__c = 'Subsea (SS)', StageName='Prospect', Name='Opp2', CloseDate=Date.Today(), AccountID=Acc2.Id,  delivery_date_ge_og__c= Date.today(), disposition_reason_ge_og__c= 'Cycle', install_country_ge_og__c='AUSTRIA');        
        //End: Added below for Opportunity Cleanup
        List<Opportunity> ListOpp = new List<Opportunity>();
        ListOpp.add(Opp1);
        ListOpp.add(Opp2);
        //Insert ListOpp;
        
        
        Contact contact1 = new Contact( GE_OG_Contact_Audience__c= 'Sales / ITO',AccountId = Acc1.Id, Email = 'test@testmail1.com', MailingStreet='Test mailing street', MailingCity='Test Mailing City', MailingState='Test State', MailingPostalCode='101010', MailingCountry='Test Country', Phone='101010' ,GE_ES_Function__c='Pricing',GE_ES_I_Agree_picklist__c='Yes' ,FirstName='Test FN', LastName='Test LN', GE_OG_Country__c = 'United States');
        
        Contact contact2 = new Contact( GE_OG_Contact_Audience__c= 'Sales / ITO',AccountId = Acc2.Id, MailingStreet='Test mailing street2',Email = 'test@testmail1.com', MailingCity='Test Mailing City', MailingState='Test State', MailingPostalCode='101010', MailingCountry='Test Country', Phone='101010' ,GE_ES_Function__c='Pricing',GE_ES_I_Agree_picklist__c='Yes',FirstName='Test FN', LastName='Test LN', GE_OG_Country__c = 'United States');
        
        List<Contact> ListContact=new List<Contact>();
        ListContact.add(contact1);
        ListContact.add(contact2);
        Insert ListContact;
        
        Contract Contract1 = new Contract();
        Contract1.Name='Contract 1';
        Contract1.AccountId=Acc1.Id;
        Contract1.StartDate=Date.Today();
        Contract1.Status='Draft';
        Contract1.GE_ES_Agreement_Title__c='Test title';
        Contract1.GE_HQ_Buss_Tier1__c='Digital Solutions';
        Contract1.ContractTerm=2;
        Contract1.RecordTypeId =[select id,name from recordtype where name like 'Master Agreement' AND SobjectType = 'Contract' ].id;
        Contract Contract2 = new Contract();
        Contract2.Name='Contract 2';
        Contract2.AccountId=Acc2.Id;
        Contract2.StartDate=Date.Today();
        Contract2.Status='Draft';
        Contract2.GE_ES_Agreement_Title__c='Test title';
        Contract2.GE_HQ_Buss_Tier1__c='Global Services (GS)';
        Contract2.ContractTerm=2;
        Contract2.RecordTypeId =[select id,name from recordtype where name like 'Master Agreement' AND SobjectType = 'Contract' ].id;
        List<Contract> ListContract=new List<Contract>();
        ListContract.add(Contract1);
        ListContract.add(Contract2);
        //Insert ListContract;    
        
        System.assertEquals(Contract1.GE_ES_Agreement_Title__c,'Test title');          
        
        Project_ge_og__c  Proj1= new Project_ge_og__c (Name='Test Proj1',project_account_ge_og__c=Acc1.Id, GE_ES_Account__c=Acc1.Id, GE_ES_Outage_Start_Date__c=Date.Today());
        Project_ge_og__c  Proj2= new Project_ge_og__c (Name='Test Proj2', project_account_ge_og__c=Acc2.Id ,GE_ES_Account__c=Acc2.Id, GE_ES_Outage_Start_Date__c=Date.Today());
        List<Project_ge_og__c> ListProj= new List<Project_ge_og__c>();
        ListProj.add(Proj1);
        ListProj.add(Proj2);
        Insert ListProj;

        
        /*Case case1 = new Case(AccountId=Acc1.Id, ContactId=Contact1.Id,GE_ES_IsueStrtDt__c = Date.Today(), Subject='Test sub-case', Status='Resolved', Priority='High',GE_ES_Invoice__c ='123456',GE_ES_Project_Number__c ='123456',GE_ES_PO__c ='123',GE_ES_Shop_Order__c ='465',GE_ES_Sub_Type__c = 'Internal GE');
        Case case2 = new Case(AccountId=Acc2.Id, ContactId=Contact2.Id,GE_ES_IsueStrtDt__c = Date.Today(), Subject='Test sub-case', Status='Resolved', Priority='High',GE_ES_Invoice__c ='234567',GE_ES_Project_Number__c ='234567',GE_ES_PO__c ='234',GE_ES_Shop_Order__c ='457',GE_ES_Sub_Type__c = 'Internal GE');
        List<Case> ListCase = new List<Case>();
        ListCase.add(Case1);
        ListCase.add(Case2);
        Insert ListCase;*/
        
        GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
        ChApp.GE_PRM_Account_Name__c=acc2.id;
        ChApp.GE_PRM_Current_Status__c= 'In Process'; 
        ChApp.GE_PRM_Master_appointment_type__c ='New';
        ChApp.GE_PRM_Primary_bank_account_country__c = 'UNITED KINGDOM ';
        ChApp.GE_PRM_Primary_bank_name_address__c = 'test';
        ChApp.GE_PRM_Primary_bank_contact__c = 'test';
        ChApp.GE_PRM_Primary_bank_account__c = 'test';
        ChApp.GE_PRM_Payment_term_requested__c= '30';
        ChApp.GE_PRM_Commercial_quali_rationale__c='abcde';
        ChApp.GE_PRM_Prior_growth_rating__c = 'Medium';
        ChApp.GE_PRM_Prior_year_commission_paid__c='New';
        ChApp.GE_PRM_Prior_performance_rating__c = 'Medium';
        ChApp.GE_PRM_Prior_year_orders__c = '<$100K';
        ChApp.GE_PRM_With_GE_since__c = 0;
        ChApp.GE_PRM_In_Business_Since__c = Date.today();
        ChApp.GE_PRM_Mandated_by_End_Customer__c = 'No';
        ChApp.GE_PRM_Convicted_of_any_felony_crims_r_s__c= 'No';
        ChApp.GE_PRM_Do_you_have_Officers_in_Gov__c= 'No';
        ChApp.GE_PRM_High_Risk_product_lines__c= 'No';
        ChApp.GE_PRM_Sell_to_Nuclear_industry__c= 'No';
        ChApp.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c= 'No';
        ChApp.GE_PRM_Does_Channel_Partner_have_subsid__c= 'No';
        ChApp.GE_PRM_Export_Controlled_products__c= 'No';
        ChApp.GE_PRM_Export_outside_own_country__c= 'No';
        ChApp.GE_PRM_Approved_exclusivity_from_P_L__c= 'No';
        ChApp.GE_PRM_Primary_Sales_Channel_Manager__c=UserInfo.getUserId();
        ChApp.GE_PRM_Region_Sales_Channel_Leader__c=UserInfo.getUserId();    
        ChApp.GE_PRM_Tier_2_P_L__c='Measurement & Control (M&C)';
        
        GE_PRM_Channel_Appointment__c ChApp1 = new GE_PRM_Channel_Appointment__c();
        ChApp1.GE_PRM_Account_Name__c=acc1.id;
        ChApp1.GE_PRM_Current_Status__c= 'In Process'; 
        ChApp1.GE_PRM_Master_appointment_type__c ='New';
        ChApp1.GE_PRM_Primary_bank_account_country__c = 'UNITED KINGDOM ';
        ChApp1.GE_PRM_Primary_bank_name_address__c = 'test';
        ChApp1.GE_PRM_Primary_bank_contact__c = 'test';
        ChApp1.GE_PRM_Primary_bank_account__c = 'test';
        ChApp1.GE_PRM_Payment_term_requested__c= '30';
        ChApp1.GE_PRM_Commercial_quali_rationale__c='abcde';
        ChApp1.GE_PRM_Prior_growth_rating__c = 'Medium';
        ChApp1.GE_PRM_Prior_year_commission_paid__c='New';
        ChApp1.GE_PRM_Prior_performance_rating__c = 'Medium';
        ChApp1.GE_PRM_Prior_year_orders__c = '<$100K';
        ChApp1.GE_PRM_With_GE_since__c = 0;
        ChApp1.GE_PRM_In_Business_Since__c = Date.today();
        ChApp1.GE_PRM_Mandated_by_End_Customer__c = 'No';
        ChApp1.GE_PRM_Convicted_of_any_felony_crims_r_s__c= 'No';
        ChApp1.GE_PRM_Do_you_have_Officers_in_Gov__c= 'No';
        ChApp1.GE_PRM_High_Risk_product_lines__c= 'No';
        ChApp1.GE_PRM_Sell_to_Nuclear_industry__c= 'No';
        ChApp1.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c= 'No';
        ChApp1.GE_PRM_Does_Channel_Partner_have_subsid__c= 'No';
        ChApp1.GE_PRM_Export_Controlled_products__c= 'No';
        ChApp1.GE_PRM_Export_outside_own_country__c= 'No';
        ChApp1.GE_PRM_Approved_exclusivity_from_P_L__c= 'No';
        ChApp1.GE_PRM_Primary_Sales_Channel_Manager__c=UserInfo.getUserId();
        ChApp1.GE_PRM_Region_Sales_Channel_Leader__c=UserInfo.getUserId();    
        ChApp1.GE_PRM_Tier_2_P_L__c='Measurement & Control (M&C)';  
        
        List<GE_PRM_Channel_Appointment__c> ListCHA= new List<GE_PRM_Channel_Appointment__c>();
        ListCHA.add(ChApp);
        ListCHA.add(ChApp1);
        insert ListCHA;
        
        AccountTeamMember Atm1 = new AccountTeamMember (UserId=user1.Id, TeamMemberRole='Account Manager', AccountId=Acc1.Id);
        AccountTeamMember Atm2 = new AccountTeamMember (UserId=user1.Id, TeamMemberRole='Account Manager', AccountId=Acc2.Id);               
        List<AccountTeamMember> ListAtm= new List<AccountTeamMember>();
        ListAtm.add(Atm1);
        ListAtm.add(Atm2);
        Insert ListAtm;
        
        Id TaskRecordTypeId = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();
        Task Task1 = new Task(Subject='Test Task', RecordTypeId=TaskRecordTypeId, Type='Call', WhoId=Contact1.Id, WhatId=Acc1.Id, Priority='High', ActivityDate=Date.Today(), Status='Not Started' );
        Task Task2 = new Task(Subject='Test Task', RecordTypeId=TaskRecordTypeId, Type='Call',WhoId=Contact1.Id, WhatId=Acc2.Id, Priority='Low', ActivityDate=Date.Today(), Status='Not Started' );        
        List<Task> ListTask = new List<Task>();
        ListTask.add(Task1);
        ListTask.add(Task2);
        Insert ListTask;
                
        //GE_DS_Tech_Assignment__c techassign = new GE_DS_Tech_Assignment__c(GE_DS_Locations_1__c = 'test' ,GE_DS_Locations_2__c = 'test2',GE_DS_Locations_3__c = 'test3',GE_DS_Locations_4__c ='test4');
        //List<GE_DS_Tech_Assignment__c> ListTech = new List<GE_DS_Tech_Assignment__c> ();
        //listTech.add(techassign);
        //insert listTech;     
                
        Test.startTest();
        PageReference pageRef = Page.GE_HQ_Accounts360View;
        Test.setCurrentPageReference(pageRef);
        //Setting the page's Id to the id of Account plan.
        //AccPlan.recordtypeid=[select id from Recordtype where  SobjectType = 'GE_HQ_Account_Plan__c' and DeveloperName = 'Private_Plan'][0].id;
        //update AccPlan;

       /* Field_of_Play__c fieldObj = new Field_of_Play__c(Name = 'Test Field Of Play 1', GE_HQ_STATUS__c ='Active', Account__c = acc2.id);
        insert fieldObj; */
                                   
        //Get all the Record Types of Account and store it in a map.
        Map <String,Schema.RecordTypeInfo> AccPlanrecordTypes = GE_HQ_Account_Plan__c.sObjectType.getDescribe().getRecordTypeInfosByName();

        List<GE_HQ_Account_Plan__c> accPlanList = new List<GE_HQ_Account_Plan__c>();
        
        //User partneruser= new User();
        
        GE_HQ_Account_Plan__c accPlanObj = new GE_HQ_Account_Plan__c();                
        accPlanObj.name = 'Test EnergyPlan 1';
        accPlanObj.GE_PRM_Account__c = Acc1.id;
        accPlanObj.RecordTypeId = AccPlanrecordTypes.get('Account Management Playbook').getRecordTypeId();
        accPlanList.add(accPlanObj);      
        
        //if(accPlanList.size()>0) insert accPlanList;
        List<Task> taskList = new List<Task>();
        List<GE_HQ_Acc_AccPlan_Rel__c> myGEAccountsList = new List<GE_HQ_Acc_AccPlan_Rel__c>();
        for(GE_HQ_Account_Plan__c accPlanObj1: accPlanList){
            GE_HQ_Acc_AccPlan_Rel__c myGEObj = new GE_HQ_Acc_AccPlan_Rel__c(GE_HQ_Account__c = Acc2.id, GE_HQ_Account_Plan__c = accPlanObj1.id);    
            myGEAccountsList.add(myGEObj);
            Task taskObj = new Task(Subject='Test Task',  WhatId=accPlanObj1.Id, Priority='High', ActivityDate=Date.Today(), Status='Not Started' );
            taskList.add(taskObj);            
        }
                            
        //if(myGEAccountsList.size()>0) insert myGEAccountsList;
        //if(taskList.size()>0) insert taskList; 
        
        ApexPages.currentPage().getParameters().put('id', AccPlan.Id);
        
        ApexPages.StandardController con = new ApexPages.StandardController(AccPlan);
        
        GE_HQ_Accounts360ViewController FC = new GE_HQ_Accounts360ViewController(con);
        //FC.NoOfRows = 1;
        
        //Test.startTest();
        //Channel Records
        
        /*FC.getchanApptRecs();
        FC.getNextchanAppt();        
        FC.getPrevchanAppt();
        FC.getFirstchanAppt();
        FC.getLastchanAppt();
        FC.SearchTextchanAppt='';
        FC.SearchchanAppt();
        
        FC.myGEAccounts();
        FC.getAccountRecs();
        FC.getNextAcc();        
        FC.getAccountRecs();
        FC.getPrevAcc();
        FC.getLastAcc();
        FC.getNextAcc();
        FC.getNextAcc();
        FC.getFirstAcc();
        FC.getPrevAcc();
        FC.SearchTextAcc='';
        FC.SearchAcc();
        
        // For Opportunity records:-
        
        FC.getOpportunityRecs();
        FC.getNextOpp();        
        FC.getOpportunityRecs();
        FC.getPrevOpp();
        FC.getLastOpp();
        FC.getNextOpp();
        FC.getNextOpp();
        FC.getFirstOpp();
        FC.getPrevOpp();
        FC.SearchTextOpp='';
        FC.SearchOpp();
    
        // For Contact Records:-
         
        FC.getContactRecs();
        FC.getNextContact();        
        FC.getContactRecs();
        FC.getPrevContact();
        FC.getLastContact();
        FC.getNextContact();
        FC.getNextContact();
        FC.getFirstContact();
        FC.getPrevContact();
        FC.SearchTextContact='';
        FC.SearchContact();
        
        // For Contract records
        FC.getContractRecs();
        FC.getNextContract();        
        FC.getContractRecs();
        FC.getPrevContract();
        FC.getLastContract();
        FC.getNextContract();
        FC.getNextContract();
        FC.getFirstContract();
        FC.getPrevContract();
        FC.SearchTextContract='';
        FC.SearchContract();
              
        // For Account Team Members(ATM) records
        FC.getATMRecs();
        FC.getNextATM();
        FC.getATMRecs();
        FC.getPrevATM();
        FC.getLastATM();
        FC.getNextATM();
        FC.getNextATM();
        FC.getFirstATM();
        FC.getPrevATM();
        FC.SearchTextATM='';
        FC.SearchATM();

        // For Task Records
        FC.getTaskRecs();
        FC.getNextTask();
        FC.getTaskRecs();
        FC.getPrevTask();
        FC.getLastTask();
        FC.getNextTask();
        FC.getNextTask();
        FC.getFirstTask();
        FC.getPrevTask();
        FC.SearchTextTask='';
        FC.SearchTask();
        
        // For Event Records
        FC.getEventRecs();
        FC.getNextEvent();
        FC.getEventRecs();
        FC.getPrevEvent();
        FC.getLastEvent();
        FC.getNextEvent();
        FC.getNextEvent();
        FC.getFirstEvent();
        FC.getPrevEvent();
        FC.SearchTextEvent='';
        FC.SearchEvent();

        // For Project Records
        FC.getProjectRecs();
        FC.getNextProject();
        FC.getProjectRecs();
        FC.getPrevProject();
        FC.getLastProject();
        FC.getNextProject();
        FC.getNextProject();
        FC.getFirstProject();
        FC.getPrevProject();
        FC.SearchTextProject='';
        FC.SearchProject();
         
        // For Case Records
        FC.getCaseRecs();
        FC.getNextCase();
        FC.getCaseRecs();
        FC.getPrevCase();
        FC.getLastCase();
        FC.getNextCase();
        FC.getNextCase();
        FC.getFirstCase();
        FC.getPrevCase();
        FC.SearchTextCase='';
        FC.SearchCase();
        
        FC.getSelectedTab();
        FC.setSelectedTab('Opp');       
                                   
        FC.getEnergyPlanRecs();
        FC.getNextEnergyPlan();
        FC.getEnergyPlanRecs();
        FC.getPrevEnergyPlan();
        FC.getLastEnergyPlan();
        FC.getNextEnergyPlan();
        FC.getNextEnergyPlan();
        FC.getFirstEnergyPlan();
        FC.getPrevEnergyPlan();
        FC.SearchTextEnergyPlan='';
        FC.SearchEnergyPlan();
        
        FC.getPRMPlanRecs();
        FC.getNextPRMPlan();
        FC.getPRMPlanRecs();
        FC.getPrevPRMPlan();
        FC.getLastPRMPlan();
        FC.getNextPRMPlan();
        FC.getNextPRMPlan();
        FC.getFirstPRMPlan();
        FC.getPrevPRMPlan();
        FC.SearchTextPRMPlan='';
        FC.SearchPRMPlan();      
              
        FC.getFieldOfPlayRecs();
        FC.getNextFieldOfPlay();
        FC.getFieldOfPlayRecs();
        FC.getPrevFieldOfPlay();
        FC.getLastFieldOfPlay();
        FC.getNextFieldOfPlay();
        FC.getNextFieldOfPlay();
        FC.getFirstFieldOfPlay();
        FC.getPrevFieldOfPlay();
        FC.SearchTextFieldOfPlay='';
        FC.SearchFieldOfPlay();
        FC.getPlanActivityRecs();
        FC.SearchTextPlanActivity='';
        FC.SearchPlanActivity();
        //FC.getNextPlanActivity();
        FC.getPrevPlanActivity();
        FC.getFirstPlanActivity();
        //FC.getLastPlanActivity();
        
        List<SelectOption> listOpt = FC.accountsType;

        //FC.accountType='My GE Accounts';
        FC.getAccountRecs();
        FC.getOpportunityRecs();
        FC.getContactRecs();
        FC.getContractRecs();
        FC.getchanApptRecs();
        FC.getIBRecs();
        FC.getNextIB();
        FC.getIBRecs();
        FC.getPrevIB();
        FC.getFirstIB();
        FC.getLastIB();
        FC.SearchTextIB ='';
        FC.SearchIB();
        FC.getATMRecs();
        FC.getTaskRecs();
        FC.getEventRecs(); 
        FC.getProjectRecs();
        FC.getCaseRecs();
        FC.refreshSearchStrings();
        FC.getEnergyPlanRecs();
        FC.getPRMPlanRecs();*/
        Test.stopTest();    

        //FC.getFieldOfPlayRecs();
                                
    }
/* Start Test Class "AccTeamAccPlanController" */
    Public Static TestMethod void AccTeamAccPlanController_Test() 
    {        
        User usr = Test_GE_OG_AccountPlan_Handler.createUser('test user');      
        Account Acc = Test_GE_OG_AccountPlan_Handler.createAccount('Test account');    
        System.assertEquals(acc.Name,'Test account');                     
        GE_Installed_Base__c ib1 = Test_GE_OG_AccountPlan_Handler.createInstalledBase(Acc);
        GE_HQ_SUBSCR_SYSTEMS__c ss1 = Test_GE_OG_AccountPlan_Handler.createSubScribeSystem(Acc);

        PageReference pageRef = Page.GE_HQ_MyAccountController;
        Test.setCurrentPageReference(pageRef);
        ApexPages.currentPage().getParameters().put('AccIds', Acc.Id);
        ApexPages.currentPage().getParameters().put('Action', 'AA');
        ApexPages.currentPage().getParameters().put('IBIds', ib1.Id );
        ApexPages.currentPage().getParameters().put('SSIds', ss1.Id );
                
        System.runAs(usr) {
            // Covering AddToAccountPlan() method            
            GE_HQ_Account_Plan__c AcP = Test_GE_OG_AccountPlan_Handler.createAccountPlan();
            GE_HQ_Acc_AccPlan_Rel__c APR = Test_GE_OG_AccountPlan_Handler.createAccountPlanRel(Acc, AcP);

            ApexPages.currentPage().getParameters().put('RelIds', APR.Id );
            Test.startTest();
            AccTeamAccPlanController Con = new AccTeamAccPlanController();
            //Con.reDirect();
            //Con.reDirect();
            // Covering AddToAccountTeam() method
            ApexPages.currentPage().getParameters().put('Action', 'AT');
            Con = new AccTeamAccPlanController();
            Con.getRoles(); 
            con.SelectedRole = 'Approver';
            Con.reDirect();
            Con.AddToAccountTeam();
            Con.AddToAccountTeam();
            // Covering RemoveFromAccountTeam() method
            ApexPages.currentPage().getParameters().put('Action', 'RT');
            Con = new AccTeamAccPlanController();
            Con.reDirect();
            Con.Back();
            
            // Covering AddIBAccountsToAccountPlan() method
            ApexPages.currentPage().getParameters().put('Action', 'IB');
            Con = new AccTeamAccPlanController();
            //Con.reDirect();
            //Con.AddIBAccountsToAccountPlan();
            //Con.AddIBAccountsToAccountPlan();
            
            // Covering AddSSAccountsToAccountPlan() method
            ApexPages.currentPage().getParameters().put('Action', 'SS');
            Con = new AccTeamAccPlanController();
            //Con.reDirect();
            //Con.AddSSAccountsToAccountPlan();
            //Con.AddSSAccountsToAccountPlan();

            // Covering DeleteAccsSelected() method
            ApexPages.currentPage().getParameters().put('Action', 'Del');
            Con = new AccTeamAccPlanController();
            Con.reDirect();
            Con.DeleteAccsSelected();
            Test.stopTest();
        }
    }

    Public Static TestMethod void AddSSAccountsToAccountPlan_Test() 
    {
        User usr = Test_GE_OG_AccountPlan_Handler.createUser('test user');      
        Account Acc = Test_GE_OG_AccountPlan_Handler.createAccount('Test account'); 
        System.assertEquals(Acc.Name,'Test account');            
        //GE_Installed_Base__c ib1 = Test_GE_OG_AccountPlan_Handler.createInstalledBase(Acc);
        GE_HQ_SUBSCR_SYSTEMS__c ss1 = Test_GE_OG_AccountPlan_Handler.createSubScribeSystem(Acc);

        PageReference pageRef = Page.GE_HQ_MyAccountController;
        Test.setCurrentPageReference(pageRef);
        ApexPages.currentPage().getParameters().put('SSIds', ss1.Id );
                 
        System.runAs(usr) {
            // Covering AddToAccountPlan() method            
            GE_HQ_Account_Plan__c AcP = Test_GE_OG_AccountPlan_Handler.createAccountPlan();
            GE_HQ_Acc_AccPlan_Rel__c APR = Test_GE_OG_AccountPlan_Handler.createAccountPlanRel(Acc, AcP);
            Test.startTest();
            AccTeamAccPlanController Con = new AccTeamAccPlanController();

            // Covering AddSSAccountsToAccountPlan() method
            ApexPages.currentPage().getParameters().put('Action', 'SS');
            Con = new AccTeamAccPlanController();
            //Con.reDirect();
            //Con.AddSSAccountsToAccountPlan();
            //Con.AddSSAccountsToAccountPlan();      
            Test.stopTest();    
        }
    }

    Public Static TestMethod void AddIBAccountsToAccountPlan_Test() 
    {
        User usr = Test_GE_OG_AccountPlan_Handler.createUser('test user');      
        Account Acc = Test_GE_OG_AccountPlan_Handler.createAccount('Test account'); 
        System.assertEquals(Acc.Name,'Test account');            
        GE_Installed_Base__c ib1 = Test_GE_OG_AccountPlan_Handler.createInstalledBase(Acc);
        //GE_HQ_SUBSCR_SYSTEMS__c ss1 = Test_GE_OG_AccountPlan_Handler.createSubScribeSystem(Acc);

        PageReference pageRef = Page.GE_HQ_MyAccountController;
        Test.setCurrentPageReference(pageRef);
        ApexPages.currentPage().getParameters().put('IBIds', ib1.Id );
                
        System.runAs(usr) {
            // Covering AddToAccountPlan() method            
            GE_HQ_Account_Plan__c AcP = Test_GE_OG_AccountPlan_Handler.createAccountPlan();
            GE_HQ_Acc_AccPlan_Rel__c APR = Test_GE_OG_AccountPlan_Handler.createAccountPlanRel(Acc, AcP);
            Test.startTest();
            AccTeamAccPlanController Con = new AccTeamAccPlanController();

            // Covering AddIBAccountsToAccountPlan() method
            ApexPages.currentPage().getParameters().put('Action', 'IB');
            Con = new AccTeamAccPlanController();
            //Con.reDirect();
            //Con.AddIBAccountsToAccountPlan();
            //Con.AddIBAccountsToAccountPlan();  
            Test.stopTest();    
        }
    }
    
    /*Public Static TestMethod void EmbeddedAnalyticsExtn_Test() 
    {
        Test.startTest(); 
        User usr = Test_GE_OG_AccountPlan_Handler.createUser('test user'); 
        System.assertEquals(usr.Alias,'tuser');           
        System.runAs(usr) {                     
            GE_HQ_Account_Plan__c AcP = Test_GE_OG_AccountPlan_Handler.createAccountPlan();
            AcP.GE_HQ_DDUNS_Number__c = '001A000000vqUry';  
            update AcP;
            GE_HQ_Account_Plan__c  acplist =[select id from GE_HQ_Account_Plan__c where name = 'TestMeth' limit 1];
            
            PageReference pageRef = Page.Embedded_Analytics_Page;
            Test.setCurrentPageReference(pageRef);
            ApexPages.currentPage().getParameters().put('AccIds', AcP.id);                      
            //Embedded_Analytics_Extn  rm = new Embedded_Analytics_Extn(new ApexPages.standardController(acplist));             
            // rm.setTiers();                                
        }
        Test.stopTest();    
    }
    */
/* End Test Class "AccTeamAccPlanController" */ 

/* Start Test Class "GE_HQ_FinancialsController" */
    static testMethod void GE_HQ_Financials_Test() 
    {
        // Creating a new Account Plan
        GE_HQ_Account_Plan__c AccPlan = Test_GE_OG_AccountPlan_Handler.createAccountPlan();

        //Account Acc1 = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and GE_HQ_Request_Status__c = 'CMF Approved' limit 1];
        //System.assertEquals(Acc1.Name,'TestClassAccount');      
        // Creating the junction object record to connect the Account and Account Plan
        //GE_HQ_Acc_AccPlan_Rel__c AccPlanRel = Test_GE_OG_AccountPlan_Handler.createAccountPlanRel(Acc1, AccPlan);
        //PriceBook2 MyPriceBook = [select Id from Pricebook2 where isStandard=true limit 1][0];
       // Product2 MyProduct = new Product2(Name = 'Test Product1', ProductCode = '123456', GE_ES_P_L__c = 'Env', GE_ES_Sub_P_L__c = 'Wind', GE_ES_Product_Service__c = 'Test Service', GE_ES_Offering__c = 'Test Offering', GE_ES_Oppty_Driver__c = 'Test Driver', Description = 'Test Prod Description', Family = 'Test Prod Family',GE_ES_Reporting_Segment__c='Testing');
         Product2 MyProduct = new Product2(Name = 'Test Product1', ProductCode = '123456', GE_ES_P_L__c = 'Env', GE_ES_Sub_P_L__c = 'Wind', GE_ES_Product_Service__c = 'Test Service', GE_ES_Offering__c = 'Test Offering', GE_ES_Oppty_Driver__c = 'Test Driver', Description = 'Test Prod Description', Family = 'Test Prod Family');
        Insert MyProduct;
        //PricebookEntry Pbe = new PricebookEntry(Product2Id=MyProduct.Id, Pricebook2Id=MyPriceBook.Id, UnitPrice=1000, UseStandardPrice=False, IsActive=True);
        //Insert Pbe;
        PageReference pageRef = Page.GE_HQ_Financials;
        Test.setCurrentPageReference(pageRef);
        //Setting the page's Id to the id of Account plan.
        ApexPages.currentPage().getParameters().put('id', AccPlan.Id);
        ApexPages.StandardController con = new ApexPages.StandardController(AccPlan);
        GE_HQ_FinancialsController FC = new GE_HQ_FinancialsController(con);
        //FC.getPenetratingRecs(); 
        
        FC.getPipelineRecs(); 
        FC.getPacingRecs();

       /* GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.COProdflag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true; */
      
        List<Opportunity> OppList = new List<Opportunity>();
        String[] PnL = new String[]{'Industrial Solutions (IS)','Digital Energy (DE)','Measurement Control Solutions (MCS)' }; //'Env','MCS','DE'}; //,'Dresser','Water ES','Motors','DE'};
        for(Integer i=0; i<PnL.size() ;i++) {
            //Opportunity Opp = new Opportunity(tier_2_ge_og__c = PnL[i], StageName='Active - Commit', Name='Opp1', CloseDate=Date.Today(), AccountID=Acc1.Id, GE_ES_Last_Allowable_Ship_Date__c = Date.today(), delivery_date_ge_og__c= Date.today(), disposition_reason_ge_og__c= 'Cycle',GE_ES_Bid_Due_Date__c=Date.Today());
            //OppList.add(Opp);
        }
        for(Integer i=0; i<PnL.size();i++) {
            //Opportunity Opp = new Opportunity(tier_2_ge_og__c = PnL[i], StageName='Prospect', Name='Opp1', CloseDate=Date.Today(), AccountID=Acc1.Id, GE_ES_Last_Allowable_Ship_Date__c = Date.today(), delivery_date_ge_og__c= Date.today(), disposition_reason_ge_og__c= 'Cycle');
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
        Test.startTest();
        FC = new GE_HQ_FinancialsController(con);
        FC.NoOfRows=2;
        FC.getPacingRecs();    FC.getNextPacing(); 
        FC.getPacingRecs(); // To run the else conditions..
        FC.getPrevPacing();    FC.getLastPacing();     FC.getNextPacing();    
        FC.getNextPacing();    FC.getFirstPacing();    FC.getPrevPacing();
        FC.getPipelineRecs();         
        FC.getNextPipeLine();
        FC.getPrevPipeline();
        FC.getFirstPipeline();
        FC.getLastPipeLine();
        Test.stopTest();
    }
/* End Test Class "GE_HQ_FinancialsController" */

/* Start Test Class "GE_HQ_GoogleMapController" */
    Public Static TestMethod void GE_HQ_GoogleMapController_test() {
        /*
        User usr=[select Id,Name,isActive,Profile.Name from User where Profile.Name like '%System Administrator%' and isActive=true limit 1];      
        
        System.runAs(usr)
        {
            List<String> accountNames = new List<String>();
            accountNames.add('TestClassAccount-EndUser');
            accountNames.add('TestClassAccount-LegalEntity');
            accountNames.add('TestClassAccount');
            accountNames.add('TestClassAccount-ShipTo');
            List<Account> accList =new List<Account>();
            accList = [select id,name from Account where name in: accountNames];
            for(Account accObj: [select id from Account limit 4])
                accList.add(accObj);
            //System.debug('****accounts Size****'+accList.size());
            String recordTypeName = Schema.SObjectType.GE_HQ_Account_Plan__c.getRecordTypeInfosByName().get('Account Management Playbook').getRecordTypeId();
            List<GE_HQ_Acc_AccPlan_Rel__c> lstAPA = new List<GE_HQ_Acc_AccPlan_Rel__c>();
            GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = 'PrivatePlan(111111)',  GE_HQ_Business_Tier1__c = 'PW', RecordTypeId = recordTypeName);
            Insert newAccPlan;
            System.assertEquals(newAccPlan.Name,'PrivatePlan(111111)');      
            for(Account acc: accList)
            {  
                GE_HQ_Acc_AccPlan_Rel__c newAPA = new GE_HQ_Acc_AccPlan_Rel__c();
                newAPA.GE_HQ_Account__c = acc.Id;
                newAPA.GE_HQ_Account_Plan__c = newaccPlan.Id;
                newAPA.GE_HQ_Acc_Type__c = 'Private Plan';
                lstAPA.add(newAPA);
            }

            if(lstAPA.size()>0)
            { 
                insert lstAPA;
                String str = '';
                for(GE_HQ_Acc_AccPlan_Rel__c myGEAccount: lstAPA){
                    str = str + myGEAccount.id + ',';
                }
                str = str.substring(0,str.length()-1);
                System.debug('****MyGEAccountIds****'+str);
                ApexPages.currentPage().getParameters().put('AccIds',str);
                Test.startTest();
                ApexPages.StandardController stdController = new ApexPages.StandardController(lstAPA[0]);
                GE_HQ_GoogleMapController gMapObj = new GE_HQ_GoogleMapController(stdController);
                PageReference pgf = gMapObj.backToMyGEAccounts();
                List<Account> accListObj = gMapObj.getaccountRes();
                List<selectOption> options = gMapObj.RecordsPerPage;
                gMapObj.NextPage();
                gMapObj.FirstPage();
                gMapObj.LastPage();            
                gMapObj.PrevPage();

                //System.debug('****Default Address****'+gMapObj.addressmodel.getDefault());
                ApexPages.currentPage().getParameters().put('AccIds','');
                gMapObj = new GE_HQ_GoogleMapController(stdController);
                accListObj = gMapObj.getaccountRes();
                Test.stopTest();
                //System.debug('****Default Address****'+gMapObj.addressmodel.getDefault());
            }                                   
        }*/
        GE_HQ_GoogleMapController gMapObj = new GE_HQ_GoogleMapController();
    }
/* End Test Class "GE_HQ_GoogleMapController" */

/* Start Test Class "GE_HQ_Refresh_Accounts" */
    static testMethod void ScheduleRefreshAccounts_Test() 
    {
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('TestScheduleRefreshAccounts',GE_HQ_Schedule_Refresh_Accounts.CRON_EXP, new GE_HQ_Schedule_Refresh_Accounts());
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        // Verify the expressions are the same
        System.assertEquals(GE_HQ_Schedule_Refresh_Accounts.CRON_EXP, ct.CronExpression);
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);
        // Verify the next time the job will run
        System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));
        Test.stopTest();
    }

    static testMethod void GEEnergyScheduleRefreshAccounts_Test() 
    {
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('TestScheduleRefreshAccounts',GE_HQ_Schedule_GEEnergy_Refresh_Accounts.CRON_EXP, new GE_HQ_Schedule_GEEnergy_Refresh_Accounts());
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        // Verify the expressions are the same
        System.assertEquals(GE_HQ_Schedule_GEEnergy_Refresh_Accounts.CRON_EXP, ct.CronExpression);
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);
        // Verify the next time the job will run
        System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));
        Test.stopTest();
    }
    
    static testMethod void BatchRefreshAccounts_Test()
    {
        Test.startTest();
        List<Account> accList = new List<Account>();
        String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        /*        
        for(Integer i=1;i<12;i++) {
            Account a = new Account(Name='TestRefreshAccount' + i,GE_HQ_DUNS_Number__c='GEGUL99'+ i,RecordTypeId=recordTypeName);
            accList.add(a);
        }
        insert accList;
        */
        accList.add(new Account(Name='TestRefreshAccount1', GE_HQ_DUNS_Number__c='GEGUL9999', RecordTypeId=recordTypeName));
        accList.add(new Account(Name='TestRefreshAccount2', GE_HQ_DUNS_Number__c='GEGUL0000', RecordTypeId=recordTypeName));
        accList.add(new Account(Name='TestRefreshAccount3', GE_HQ_DUNS_Number__c='GEGUL4444', RecordTypeId=recordTypeName));
        accList.add(new Account(Name='TestRefreshAccount11', GE_HQ_GE_GLOBAL_DUNS__c='GEGUL9999', RecordTypeId=recordTypeName));
        accList.add(new Account(Name='TestRefreshAccount12', GE_HQ_GE_GLOBAL_DUNS__c='GEGUL9999', RecordTypeId=recordTypeName));
        accList.add(new Account(Name='TestRefreshAccount21', GE_HQ_GE_GLOBAL_DUNS__c='GEGUL0000', RecordTypeId=recordTypeName));
        accList.add(new Account(Name='TestRefreshAccount22', GE_HQ_GE_GLOBAL_DUNS__c='GEGUL0000', RecordTypeId=recordTypeName));
        accList.add(new Account(Name='TestRefreshAccount31', GE_HQ_GE_GLOBAL_DUNS__c='GEGUL4444', RecordTypeId=recordTypeName));
        accList.add(new Account(Name='TestRefreshAccount32', GE_HQ_GE_GLOBAL_DUNS__c='GEGUL4444', RecordTypeId=recordTypeName));
        accList.add(new Account(Name='TestRefreshAccount4', GE_HQ_DUNS_Number__c='GEGUL2222', RecordTypeId=recordTypeName));
        insert accList;
        
        
        recordTypeName = Schema.SObjectType.GE_HQ_Account_Plan__c.getRecordTypeInfosByName().get('Account Management Playbook').getRecordTypeId();
        List<GE_HQ_Account_Plan__c> accPlanList = new List<GE_HQ_Account_Plan__c>();
        accPlanList.add(new GE_HQ_Account_Plan__c(Name='ACPlanTest1', GE_HQ_DDUNS_Number__c=accList.get(0).Id, RecordTypeId=recordTypeName));
        accPlanList.add(new GE_HQ_Account_Plan__c(Name='ACPlanTest2', GE_HQ_DDUNS_Number__c=accList.get(1).Id, RecordTypeId=recordTypeName));
        accPlanList.add(new GE_HQ_Account_Plan__c(Name='ACPlanTest3', GE_HQ_DDUNS_Number__c=accList.get(2).Id, RecordTypeId=recordTypeName));
        //accPlanList.add(new GE_HQ_Account_Plan__c(Name='ACPlanTest4', GE_HQ_DDUNS_Number__c=accList.get(9).Id, RecordTypeId=recordTypeName));
        insert accPlanList;
        
        insert new GE_HQ_Acc_AccPlan_Rel__c(GE_HQ_Account_Plan__c=accPlanList.get(2).Id, GE_HQ_Account__c=accList.get(9).Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(accPlanList.get(2));
        ApexPages.currentPage().getParameters().put('Id', accPlanList.get(2).Id);
        GE_HQ_Refresh_Accounts refAcc = new GE_HQ_Refresh_Accounts(sc);
        refAcc.RefreshAccts();
        List<GE_HQ_Acc_AccPlan_Rel__c> junRecords = new List<GE_HQ_Acc_AccPlan_Rel__c>([Select id from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c IN :accPlanList]);
        System.assertEquals(junRecords.size(),2);
                
        insert new GE_HQ_Acc_AccPlan_Rel__c(GE_HQ_Account_Plan__c=accPlanList.get(2).Id, GE_HQ_Account__c=accList.get(9).Id);
        String Query= 'Select Id, GE_HQ_DDUNS_Number__c, GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c from GE_HQ_Account_Plan__c Where Name like \'ACPlanTest%\' and RecordTypeID =\'' + recordTypeName + '\'';
        List<GE_HQ_Account_Plan__c> accPList = Database.query(Query);
        System.assertEquals(accPList.size(), 3);
        GE_HQ_Batch_Refresh_Accounts BatchRefreshAccounts = new GE_HQ_Batch_Refresh_Accounts();
        BatchRefreshAccounts.Query = Query;
        Database.executebatch(BatchRefreshAccounts);
        Test.stopTest();
        
        junRecords = new List<GE_HQ_Acc_AccPlan_Rel__c>([Select id from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c IN :accPlanList]);
        System.assertEquals(junRecords.size(),6);
    }   
/* End Test Class "GE_HQ_Refresh_Accounts" */   

}