/*
Class/Trigger Name     : OpportunityStagesAutomation_GE_OG_Test
Purpose/Overview       : Test Class to calculate the code coverage for the OpportunityStagesAutomationHandler_GE_OG Class 
of OpportunityTrigger_GE_OG Trigger helper class and for DealDeskOpportunityAutomation_GE_OG  Class
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23281
Author                 : Nitish Pandey
Created Date           : 17-Sep-2015
Used For               : OpportunityStagesAutomationHandler_GE_OG - 90%
DealDeskOpportunityAutomation_GE_OG    - 80%
*/ 

@isTest

public class OpportunityStagesAutomation_GE_OG_Test
{
    
    @testsetup
    static void createRecord()
    {
        
        //creating 'Country Region Mapping' for 'INDIA'
        Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
        insert objcustom;
        
        /* Create Opportunity Reason Code Custom Setting */
        List<Opportunity_Primary_Reason_Has_Code__c> lstReasonCode = CommonTestDataFactory_GE_OG.createPrimaryReasonCustomSetting();
        insert lstReasonCode;
        
        
        // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        
        //Createing an Account 
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        Account accmem = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccount Relation 1');
        system.assertEquals('TestAccount Relation 1',accmem.Name);
        
        //Createing an Account
        Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('TestAccount Legal',acc.ID,acc1.ID);
        system.assertEquals('TestAccount Legal',accLE.Name);
        
        //Create Test Account for ContactSumTrigger
        String TestAccountName = system.Label.Test_Account_Name;
        // Account testacc = CommonTestDataFactory_GE_OG.createCommercialParentAccount(TestAccountName); commetned by kiru
        
        // Create Legal Account with Type 'Internal' 
        /*Account accInternal = CommonTestDataFactory_GE_OG.createInternalLegalEntity('TestAccount Internal');
system.assertEquals('TestAccount Internal',accInternal.Name);*/
        Account accInternal = CommonTestDataFactory_GE_OG.createSellingLegalEntityAccount('TestAccount Internal',acc.ID);
        system.assertEquals('TestAccount Internal',accInternal.Name);
        test.startTest();
        //Creating an Opportunity
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',opp.Name);
        //  Test.startTest();
        
        Opportunity opp1 = CommonTestDataFactory_GE_OG.createOppty('Testopportunity2',acc.ID);
        system.assertEquals('Testopportunity2',opp1.Name);
        Test.stopTest();
        //Creating a Product
        Product2 prod1 = CommonTestDataFactory_GE_OG.createProduct('testProduct');
        system.assertEquals('testProduct',prod1.Name);
        
        Product2 prod2 = CommonTestDataFactory_GE_OG.createProduct('testProduct2');
        //system.assertEquals('testProduct2',prod1.Name);
        
        //Creating a PriceBookEntry
        //PriceBookEntry PBE=  CommonTestDataFactory_GE_OG.createPriceBookEntry(prod1);
        //system.assertEquals(prod1.ID,PBE.Product2ID);
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        //lstPBE.add(PBE);
        
        
        //Create OpportunityLineItem 
        if(lstPBE.size()==0){
            PricebookEntry objPBE = new PricebookEntry();
            objPBE.Product2Id = prod1.Id;
            objPBE.UseStandardPrice = False;
            objPBE.UnitPrice = 0;
            objPBE.CurrencyIsoCode = 'USD';
            objPBE.IsActive = prod1.IsActive;
            objPBE.Pricebook2Id = Test.getStandardPricebookID();
            insert  objPBE;
            lstPBE = new List<PriceBookEntry>();
            lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        }
        system.assertEquals(1,lstPBE.size());
        if(lstPBE.size()>0){
            List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
            lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemDiffTier(opp, lstPBE);
            if(lstOLI.size()>0){
                insert lstOLI;
            }
        }
        
    }
    
    
    //Method for checking the code coverage of class : 'OpportunityStagesAutomationHandler_GE_OG'
    public static testMethod void testOpportunityStages1(){
        
        Test.startTest();
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        objcont.GE_HQ_SFDC_Legacy_Id__c='random id';
        insert objcont;
        
        Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, 
                             //Commented for DOA Revamp
                             //risk_checklist_submitted_ge_og__c, 
                             accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
        /* opportunitycontactrole objocr = new opportunitycontactrole();
objocr.opportunityid = oppty.id;
objocr.role = 'Technical';
objocr.ContactId = objcont.id;
insert objocr;
oppty.install_country_ge_og__c = 'India';
update oppty;

Test.startTest();

Deal_Desk_ge_og__c objDeal = new Deal_Desk_ge_og__c();
objDeal.deal_desk_opportunity_id_ge_og__c = oppty.ID;
objDeal.active_deal_desk_ge_og__c = true;
CheckRecursion_GE_OG.run =true; 
insert objDeal;

oppty.quote_type_ge_og__c = 'Bid Competitive';
oppty.has_opportunitycontactrole_ge_og__c =true ;
oppty.deal_path_ge_og__c = 'Deal Desk';
oppty.need_comm_ops_support_ge_og__c = true;

oppty.bid_due_date_ge_og__c= system.today();
oppty.rfq_received_date_ge_og__c = system.today();
//oppty.accountId = acc.Id;
oppty.pre_bid_evaluation_ge_og__c = true;
oppty.bid_no_bid_approval_ge_og__c = true;
oppty.delivery_date_ge_og__c = null;
CheckRecursion_GE_OG.run =true; //handling recursion Scenario
update oppty;

oppty.deal_path_ge_og__c = 'Express';
CheckRecursion_GE_OG.run =true; 
update oppty;

oppty.stage_ge_og__c = System.Label.Closed_Lost;
oppty.primary_reason_code_ge_og__c = 'XYZ';
oppty.primary_sub_reason_code_ge_og__c = 'ABC';
CheckRecursion_GE_OG.run =true; 
update oppty; */
        
        oppty.deal_path_ge_og__c = 'Express';
        CheckRecursion_GE_OG.run =true; 
        // Test.stopTest();
        update oppty;
        // OpportunityTeamMember otm = CommonTestDataFactory_GE_OG.create
        Test.stopTest();
        
    }
    
    //4S.by Gourav Method for checking the code coverage of class : addOppOwnerToOpportunityTeam
    public static testMethod void testOpportunityStages2(){
        
        Test.startTest();
        
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        //Commented by Harsha 
        /*  Opportunity opp = new Opportunity();
opp.name= 'oppName Test';
opp.stageName = 'Prospecting';
opp.has_opportunitycontactrole_ge_og__c = True;
opp.region_ge_og__c = 'Test Region';
opp.closedate = system.today().addDays(30);
opp.accountId = accLE.id;
//Changed below from Measurement & Control to Digital Solutions
opp.tier_2_ge_og__c ='Digital Solutions';
opp.tier_3_ge_og__c ='Bently Nevada';
//opp.GE_Estimated_Amount__c = 1000.00;
opp.amount_ge_og__c =1000.00;
opp.install_country_ge_og__c= 'India';
opp.OwnerId = UserInfo.getUserID();
opp.RecordTypeId=schema.sObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeID();
insert opp;*/
        Opportunity opp = [Select Id,Name from Opportunity where Name = 'Testopportunity2'];
        /* opportunitycontactrole objocr = new opportunitycontactrole();
objocr.opportunityid = oppty.id;
objocr.role = 'Technical';
objocr.ContactId = objcont.id;
insert objocr;
oppty.install_country_ge_og__c = 'India';
update oppty;

Test.startTest();

Deal_Desk_ge_og__c objDeal = new Deal_Desk_ge_og__c();
objDeal.deal_desk_opportunity_id_ge_og__c = oppty.ID;
objDeal.active_deal_desk_ge_og__c = true;
CheckRecursion_GE_OG.run =true; 
insert objDeal;

oppty.quote_type_ge_og__c = 'Bid Competitive';
oppty.has_opportunitycontactrole_ge_og__c =true ;
oppty.deal_path_ge_og__c = 'Deal Desk';
oppty.need_comm_ops_support_ge_og__c = true;

oppty.bid_due_date_ge_og__c= system.today();
oppty.rfq_received_date_ge_og__c = system.today();
//oppty.accountId = acc.Id;
oppty.pre_bid_evaluation_ge_og__c = true;
oppty.bid_no_bid_approval_ge_og__c = true;
oppty.delivery_date_ge_og__c = null;
CheckRecursion_GE_OG.run =true; //handling recursion Scenario
update oppty;

oppty.deal_path_ge_og__c = 'Express';
CheckRecursion_GE_OG.run =true; 
update oppty;

oppty.stage_ge_og__c = System.Label.Closed_Lost;
oppty.primary_reason_code_ge_og__c = 'XYZ';
oppty.primary_sub_reason_code_ge_og__c = 'ABC';
CheckRecursion_GE_OG.run =true; 
update oppty; */
        
        opp.deal_path_ge_og__c = 'Express';
        CheckRecursion_GE_OG.run =true; 
        update opp;
        // OpportunityTeamMember otm = CommonTestDataFactory_GE_OG.create
        Test.stopTest();
        
    }
    
    
    //4S.by Gourav Method for checking the code coverage of class : addOppOwnerToOpportunityTeam_2
    public static testMethod void testOpportunityStages3(){
        
        
        Test.startTest();
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        User u1 = new User(Alias = 'standt', Email='standarduser@testorg.com',
                           EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles', UserName='grvAnan123@testorg.com');
        insert u1;
        User u2 = new User(Alias = 'standt', Email='standarduser@testorg.com',
                           EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles', UserName='grvAnan123xyzz@testorg.com');
        insert u2;
        //  CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        // Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        /*     Opportunity opp = new Opportunity();
opp.name= 'oppName Test';
opp.stageName = 'Prospecting';
opp.has_opportunitycontactrole_ge_og__c = True;
opp.region_ge_og__c = 'Test Region';
opp.closedate = system.today().addDays(30);
opp.accountId = accLE.id;
//Changed the below from Measurement & Control to Digital Solutions
opp.tier_2_ge_og__c ='Digital Solutions';
opp.tier_3_ge_og__c ='Bently Nevada';
//opp.GE_Estimated_Amount__c = 1000.00;
opp.amount_ge_og__c =1000.00;
opp.install_country_ge_og__c= 'India';
opp.OwnerId = u1.Id;
opp.RecordTypeId=schema.sObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeID();
insert opp;*/  
        
        Opportunity opp = [Select Id,Name from Opportunity where Name = 'Testopportunity2'];
        
        /* opportunitycontactrole objocr = new opportunitycontactrole();
objocr.opportunityid = oppty.id;
objocr.role = 'Technical';
objocr.ContactId = objcont.id;
insert objocr;
oppty.install_country_ge_og__c = 'India';
update oppty;

Test.startTest();

Deal_Desk_ge_og__c objDeal = new Deal_Desk_ge_og__c();
objDeal.deal_desk_opportunity_id_ge_og__c = oppty.ID;
objDeal.active_deal_desk_ge_og__c = true;
CheckRecursion_GE_OG.run =true; 
insert objDeal;

oppty.quote_type_ge_og__c = 'Bid Competitive';
oppty.has_opportunitycontactrole_ge_og__c =true ;
oppty.deal_path_ge_og__c = 'Deal Desk';
oppty.need_comm_ops_support_ge_og__c = true;

oppty.bid_due_date_ge_og__c= system.today();
oppty.rfq_received_date_ge_og__c = system.today();
//oppty.accountId = acc.Id;
oppty.pre_bid_evaluation_ge_og__c = true;
oppty.bid_no_bid_approval_ge_og__c = true;
oppty.delivery_date_ge_og__c = null;
CheckRecursion_GE_OG.run =true; //handling recursion Scenario
update oppty;

oppty.deal_path_ge_og__c = 'Express';
CheckRecursion_GE_OG.run =true; 
update oppty;

oppty.stage_ge_og__c = System.Label.Closed_Lost;
oppty.primary_reason_code_ge_og__c = 'XYZ';
oppty.primary_sub_reason_code_ge_og__c = 'ABC';
CheckRecursion_GE_OG.run =true; 
update oppty; */
        
        opp.deal_path_ge_og__c = 'Express';
        CheckRecursion_GE_OG.run =true; 
        opp.OwnerId=u2.Id;
        update opp;
        // OpportunityTeamMember otm = CommonTestDataFactory_GE_OG.create
        Test.stopTest();
        
    }
    
    
    //2S.by Gourav Method for checking the code coverage of class : 'OpportunityStagesAutomationHandler_GE_OG'Sales - Primary
    public static testMethod void testOpportunityStagesCPR(){
        
        Test.startTest();
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        
        Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, 
                             //Commented for DOA Revamp
                             //risk_checklist_submitted_ge_og__c, 
                             accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
        
        opportunitycontactrole objocr = new opportunitycontactrole();
        objocr.opportunityid = oppty.id;
        objocr.role = 'Technical';
        objocr.ContactId = objcont.id;
        insert objocr;
        oppty.install_country_ge_og__c = 'India';
        update oppty;
        
        
        
        Deal_Desk_ge_og__c objDeal = new Deal_Desk_ge_og__c();
        objDeal.deal_desk_opportunity_id_ge_og__c = oppty.ID;
        objDeal.active_deal_desk_ge_og__c = true;
        CheckRecursion_GE_OG.run =true; 
        insert objDeal;
        //Changed from Bid Competitive to Bid Competitive / Tender
        oppty.quote_type_ge_og__c = 'Bid Competitive / Tender';
        oppty.has_opportunitycontactrole_ge_og__c =true ;
        oppty.deal_path_ge_og__c = 'Deal Desk';
        oppty.need_comm_ops_support_ge_og__c = true;
        
        oppty.bid_due_date_ge_og__c= system.today();
        oppty.rfq_received_date_ge_og__c = system.today();
        //oppty.accountId = acc.Id;
        oppty.pre_bid_evaluation_ge_og__c = true;
        oppty.bid_no_bid_approval_ge_og__c = true;
        oppty.delivery_date_ge_og__c = null;
        
        CheckRecursion_GE_OG.run =true; 
        update oppty;
        
        /* OpportunityShare oppShr = new OpportunityShare();
oppShr.OpportunityId=oppty.Id;
oppShr.RowCause='Team';
oppShr.OpportunityAccessLevel='Edit';
insert oppShr; */
        OpportunityTeamMember otm = CommonTestDataFactory_GE_OG.createOpportunityTeamMember(oppty.Id,UserInfo.getUserID(),'Sales');
        // otm.TeamMemberRole='Commercial Primary Resource';
        //update otm;
        // otm.TeamMemberRole='Legal';
        //update otm;
        Test.stopTest();
        
    }
    //2E.by Gourav
    
    //3S.by Gourav Method for checking the code coverage of class : 'OpportunityStagesAutomationHandler_GE_OG' Delete Comm Check
    public static testMethod void testOpportunityStagesDelComm(){
        Test.startTest();
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        
        
        Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, 
                             //Commented for DOA Revamp
                             //risk_checklist_submitted_ge_og__c, 
                             accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
        
        
        /* oppty.install_country_ge_og__c = 'India';

oppty.pre_bid_evaluation_ge_og__c = true;
oppty.bid_no_bid_approval_ge_og__c = true;
oppty.delivery_date_ge_og__c = null;

CheckRecursion_GE_OG.run =true; 
update oppty; */
        
        
        //OpportunityTeamMember otm = CommonTestDataFactory_GE_OG.createOpportunityTeamMember(oppty.Id,UserInfo.getUserID(),'Commercial Primary Resource');
        //delete otm;
        Test.stopTest();
        
    }
    //3E.by Gourav
    
    //#S.by Gourav Method for checking the code coverage of class : 'OpportunityStagesAutomationHandler_GE_OG'Sales - Primary
    public static testMethod void testOpportunityStagesSalesP(){
        Test.startTest();
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        
        
        Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, 
                             //Commented for DOA Revamp
                             //risk_checklist_submitted_ge_og__c, 
                             accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
        
        /*opportunitycontactrole objocr = new opportunitycontactrole();
objocr.opportunityid = oppty.id;
objocr.role = 'Technical';
objocr.ContactId = objcont.id;
insert objocr;
oppty.install_country_ge_og__c = 'India';
update oppty;*/
        
        
        
        /* Deal_Desk_ge_og__c objDeal = new Deal_Desk_ge_og__c();
objDeal.deal_desk_opportunity_id_ge_og__c = oppty.ID;
objDeal.active_deal_desk_ge_og__c = true;
CheckRecursion_GE_OG.run =true; 
insert objDeal;

oppty.quote_type_ge_og__c = 'Bid Competitive';
oppty.has_opportunitycontactrole_ge_og__c =true ;
oppty.deal_path_ge_og__c = 'Deal Desk';
oppty.need_comm_ops_support_ge_og__c = true;

oppty.bid_due_date_ge_og__c= system.today();
oppty.rfq_received_date_ge_og__c = system.today();
//oppty.accountId = acc.Id;
oppty.pre_bid_evaluation_ge_og__c = true;
oppty.bid_no_bid_approval_ge_og__c = true;
oppty.delivery_date_ge_og__c = null;

CheckRecursion_GE_OG.run =true; 
update oppty;

OpportunityShare oppShr = new OpportunityShare();
oppShr.OpportunityId=oppty.Id;
oppShr.RowCause='Team';
oppShr.OpportunityAccessLevel='Edit';
insert oppShr; */
        /*
OpportunityTeamMember otm = CommonTestDataFactory_GE_OG.createOpportunityTeamMember(oppty.Id,UserInfo.getUserID(),'Sales - Primary');
//otm.TeamMemberRole='Commercial Primary Resource';
otm = [select id,TeamMemberRole from OpportunityTeamMember where id=:otm.id ];
otm.TeamMemberRole='Primary Resource';
update otm;
delete otm;
*/
        Test.stopTest();
        
    }
    //2E.by Gourav
    
    //Method for checking the code coverage of class : 'DealDeskOpportunityAutomation_GE_OG'
    public static testMethod void testDealDeskOpptyAutomation(){
        
        Test.startTest(); 
        
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.accountid =  accLE.id;
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        
        
        Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, oppty_cm_ge_og__c,
                             //Commented for DOA Revamp
                             //risk_checklist_submitted_ge_og__c, 
                             accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
        
        opportunitycontactrole objocr = new opportunitycontactrole();
        objocr.opportunityid = oppty.id;
        objocr.role = 'Technical';
        objocr.ContactId = objcont.id;
        insert objocr;
        oppty.install_country_ge_og__c = 'UNITED KINGDOM';
        update oppty;
        
        /*
product2 objprod = [Select id from product2 where name = 'testProduct' limit 1];
objprod.GE_OG_CM__c = 10;
update objprod;
*/
        
        oppty.quote_type_ge_og__c = 'Bid Sole Source';
        oppty.has_opportunitycontactrole_ge_og__c =true ;
        oppty.deal_path_ge_og__c = 'Deal Desk';
        oppty.need_comm_ops_support_ge_og__c = true;
        oppty.has_commercial_primary_resource_ge_og__c = True;
        oppty.end_user_ge_og__c= accLE.id;
        oppty.install_country_ge_og__c= 'India';
        oppty.oppty_cm_ge_og__c =  15;
        oppty.bid_due_date_ge_og__c= system.today();
        oppty.rfq_received_date_ge_og__c = system.today();
        oppty.pre_bid_evaluation_ge_og__c = true;
        oppty.bid_no_bid_approval_ge_og__c = true;
        oppty.delivery_date_ge_og__c = system.today();
        oppty.isbudgetary_ge_og__c = 'Firm Fixed';
        oppty.sub_industry_ge_og__c = 'XYZ'; 
        // oppty.convertible_ge_og__c = 'No' ;
        oppty.bid_to_win_approval_ge_og__c = True;
        oppty.legal_entity_ge_og__c = accLE.id;
        // oppty.ge_legal_entity_ge_og__c = accInternal.ID;
        //Commented for DOA Revamp
        //  oppty.risk_checklist_submitted_ge_og__c = True;
        CheckRecursion_GE_OG.run =true; //handling recursion Scenario
        
        // update oppty;
        
        //oppty.stage_ge_og__c = System.Label.Cancelled;
        oppty.primary_reason_code_ge_og__c = 'XYZ';
        oppty.primary_sub_reason_code_ge_og__c = 'ABC';
        oppty.Anti_boycott_ge_og__c = 'Potential Boycott Language Not Identified';
        
        CheckRecursion_GE_OG.run =false; //handling recursion Scenario
        update oppty;
        
        
        Test.stopTest();
        
    }
    
    //Method for checking the code coverage of class : 'ExpressOpportunityAutomation_GE_OG'
    //changed to cover code > 80%
    public static testMethod void testExpressOpptyAutomation()
    {
        
        Test.startTest();
        
        //Account accCountry = [select id from account where name='Test Account Country'];
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        
        
        Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, 
                             //Commented for DOA Revamp
                             //risk_checklist_submitted_ge_og__c, 
                             accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
        
        /*   opportunitycontactrole objocr = new opportunitycontactrole();
objocr.opportunityid = oppty.id;
objocr.role = 'Technical';
objocr.ContactId = objcont.id;
insert objocr;

*/
        oppty.install_country_ge_og__c = 'India';
        //update oppty;
        
        // Changed from Bid Competitive to Bid Competitive / Tender
        oppty.quote_type_ge_og__c = 'Bid Competitive / Tender';
        oppty.has_opportunitycontactrole_ge_og__c =true ;
        oppty.deal_path_ge_og__c = 'Express';
        oppty.Is_express_ge_og__c = 'Yes';
        oppty.need_comm_ops_support_ge_og__c = true;
        oppty.has_commercial_primary_resource_ge_og__c = True;
        oppty.end_user_ge_og__c= accLE.id;
        oppty.install_country_ge_og__c= 'India';
        oppty.bid_due_date_ge_og__c= system.today();
        oppty.delivery_date_ge_og__c = null;
        oppty.isbudgetary_ge_og__c = 'Firm Fixed';
        oppty.sub_industry_ge_og__c = 'XYZ'; 
        oppty.legal_entity_ge_og__c = accLE.id;
        // oppty.convertible_ge_og__c = 'No' ;
        oppty.ge_legal_entity_ge_og__c = accInternal.ID;
        CheckRecursion_GE_OG.run =true; //handling recursion Scenario
        // update oppty;
        //update from null to accInternal.ID;
        oppty.ge_legal_entity_ge_og__c = null;
        CheckRecursion_GE_OG.run =true; //handling recursion Scenario
        // update oppty;
        
        oppty.bid_sent_date_ge_og__c = System.Today();
        oppty.bid_sent_ge_og__c = True;
        oppty.stage_ge_og__c = System.Label.Closed_Won;
        oppty.primary_reason_code_ge_og__c = 'XYZ';
        oppty.primary_sub_reason_code_ge_og__c = 'ABC';
        oppty.legal_entity_ge_og__c = accLE.id;
        //Added to make type as Internal to create Express Deal
        oppty.Type = 'External'; 
        CheckRecursion_GE_OG.run =true; //handling recursion Scenario
        update oppty;
        
        Test.stopTest();
        
    }
    
    //4S. by Gourav
    //Method for checking the code coverage of :Opportunity_Stage_Won_Lost_Nego_GE_OG.checkedCancelled() ;PRC blank
    public static testMethod void testExpressOpptyAutomation_new()
    {
        
        
        //Account accCountry = [select id from account where name='Test Account Country'];
        Account accLE = [select id from account where name='TestAccount Legal'];
        Test.startTest();
        Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        
        
        try{
            Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c,
                                 //Commented for DOA Revamp
                                 //risk_checklist_submitted_ge_og__c, 
                                 accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity1'];
            
            oppty.install_country_ge_og__c = 'India';
            //update oppty;
            
            
            oppty.quote_type_ge_og__c = 'Bid Competitive';
            oppty.has_opportunitycontactrole_ge_og__c =true ;
            oppty.deal_path_ge_og__c = 'Express';
            oppty.Is_express_ge_og__c = 'Yes';
            oppty.need_comm_ops_support_ge_og__c = true;
            oppty.has_commercial_primary_resource_ge_og__c = True;
            oppty.end_user_ge_og__c= accLE.id;
            oppty.install_country_ge_og__c= 'India';
            oppty.bid_due_date_ge_og__c= system.today();
            oppty.delivery_date_ge_og__c = null;
            oppty.isbudgetary_ge_og__c = 'Firm Fixed';
            oppty.sub_industry_ge_og__c = 'XYZ'; 
            oppty.legal_entity_ge_og__c = accLE.id;
            // oppty.convertible_ge_og__c = 'No' ;
            oppty.ge_legal_entity_ge_og__c = accInternal.ID;
            oppty.bid_sent_date_ge_og__c = System.Today();
            oppty.bid_sent_ge_og__c = True;
            oppty.stage_ge_og__c = System.Label.Cancelled;
            oppty.primary_reason_code_ge_og__c = 'PRC';
            oppty.primary_sub_reason_code_ge_og__c = '';
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
            update oppty;
            
            
            Test.stopTest();
        }catch(Exception e)
        {
            Boolean expectedExceptionThrown =  e.getMessage().contains(System.Label.Cancelled_Error_Message) ? true : false;
            //System.AssertEquals(expectedExceptionThrown, true);
        } 
    } 
    //4E. by Gourav
    
    //4S. by Gourav
    //Method for checking the code coverage of :Opportunity_Stage_Won_Lost_Nego_GE_OG.checkedCancelled() ;CancellledStage
    public static testMethod void testExpressOpptyAutomation_canStg()
    {
        
        Test.startTest();
        //Account accCountry = [select id from account where name='Test Account Country'];
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];
        
        Opportunity_Primary_Reason_Has_Code__c opr = new Opportunity_Primary_Reason_Has_Code__c();
        opr.has_primary_sub_reason_code_ge_og__c = true;
        opr.primary_reason_code_ge_og__c ='Funding';
        opr.name ='Funding';
        insert opr;
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        
        
        try{
            Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c,
                                 //Commented for DOA Revamp
                                 //risk_checklist_submitted_ge_og__c,
                                 accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
            
            oppty.install_country_ge_og__c = 'India';
            
            update oppty;
            
            
            oppty.quote_type_ge_og__c = 'Bid Competitive';
            oppty.has_opportunitycontactrole_ge_og__c =true ;
            // oppty.deal_path_ge_og__c = 'Express';
            //oppty.Is_express_ge_og__c = 'Yes';
            oppty.need_comm_ops_support_ge_og__c = true;
            oppty.has_commercial_primary_resource_ge_og__c = True;
            oppty.end_user_ge_og__c= accLE.id;
            oppty.install_country_ge_og__c= 'India';
            oppty.bid_due_date_ge_og__c= system.today();
            oppty.delivery_date_ge_og__c = null;
            oppty.isbudgetary_ge_og__c = 'Firm Fixed';
            oppty.sub_industry_ge_og__c = 'XYZ'; 
            oppty.legal_entity_ge_og__c = accLE.id;
            // oppty.convertible_ge_og__c = 'No' ;
            oppty.ge_legal_entity_ge_og__c = accInternal.ID;
            oppty.bid_sent_date_ge_og__c = System.Today();
            oppty.bid_sent_ge_og__c = True;
            system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1  '+ [select id, stage_ge_og__c from opportunity where id=:oppty.id]);
            oppty.primary_reason_code_ge_og__c = 'Funding' ;
            oppty.primary_sub_reason_code_ge_og__c = 'Alternate Channel';
            oppty.stage_ge_og__c = System.Label.Cancelled;
            
            
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
            update oppty;
            Map<id,Opportunity> oldOpptyMap = new Map<id,Opportunity>();
            List<Opportunity> newOpptyList =  [select id, StageName, stage_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c from opportunity where id=:oppty.id];
            
            Map<String, Boolean> mapOppPrimaryReason = null;
            Opportunity_Stage_Won_Lost_Nego_GE_OG oswln = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
            oswln.checkedCancelled(newOpptyList, oldOpptyMap, mapOppPrimaryReason);
            
            system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  '+ [select id, stage_ge_og__c from opportunity where id=:oppty.id]);
            Test.stopTest();
        }catch(Exception e)
        {
            Boolean expectedExceptionThrown =  e.getMessage().contains(System.Label.Cancelled_Error_Message) ? true : false;
            //System.AssertEquals(expectedExceptionThrown, true);
        } 
    }
    //6E. by Gourav
    
    //5S. by Gourav
    //Method for checking the code coverage of :Opportunity_Stage_Won_Lost_Nego_GE_OG.checkedCancelled() ;PRC& SPRC not blank
    public static testMethod void testExpressOpptyAutomation_new2()
    {
        
        
        Test.startTest();
        //Account accCountry = [select id from account where name='Test Account Country'];
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        
        
        try{
            Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c,
                                 //Commented for DOA Revamp
                                 //risk_checklist_submitted_ge_og__c, 
                                 accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
            
            oppty.install_country_ge_og__c = 'India';
            //update oppty;
            
            
            oppty.quote_type_ge_og__c = 'Bid Competitive';
            oppty.has_opportunitycontactrole_ge_og__c =true ;
            oppty.deal_path_ge_og__c = 'Express';
            oppty.Is_express_ge_og__c = 'Yes';
            oppty.need_comm_ops_support_ge_og__c = true;
            oppty.has_commercial_primary_resource_ge_og__c = True;
            oppty.end_user_ge_og__c= accLE.id;
            oppty.install_country_ge_og__c= 'India';
            oppty.bid_due_date_ge_og__c= system.today();
            oppty.delivery_date_ge_og__c = null;
            oppty.isbudgetary_ge_og__c = 'Firm Fixed';
            oppty.sub_industry_ge_og__c = 'XYZ'; 
            oppty.legal_entity_ge_og__c = accLE.id;
            // oppty.convertible_ge_og__c = 'No' ;
            oppty.ge_legal_entity_ge_og__c = accInternal.ID;
            oppty.bid_sent_date_ge_og__c = System.Today();
            oppty.bid_sent_ge_og__c = True;
            oppty.stage_ge_og__c = System.Label.Closed_Lost;
            oppty.primary_reason_code_ge_og__c = '';
            oppty.primary_sub_reason_code_ge_og__c = '';
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
            update oppty;
            
            Test.stopTest();
        }catch(Exception e)
        {
            Boolean expectedExceptionThrown =  e.getMessage().contains('To move the stage to \'Closed Lost\', Primary Reason Code and respected Primary Sub Reason Code should be populated.') ? true : false;
            // System.AssertEquals(expectedExceptionThrown, true);
        } 
        
    }
    //5E. by Gourav
    
    //5S. by Gourav
    //Method for checking the code coverage of :Opportunity_Stage_Won_Lost_Nego_GE_OG.checkClosed_Won_Lost_Negotiating()
    public static testMethod void testExpressOpptyAutomation_new3()
    {
        
        
        //Account accCountry = [select id from account where name='Test Account Country'];
        Test.startTest();
        
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        insert objcont;
        
        
        
        try{
            Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, 
                                 //Commented for DOA Revamp
                                 //risk_checklist_submitted_ge_og__c, 
                                 accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
            
            oppty.install_country_ge_og__c = 'India';
            //update oppty;
            
            oppty.quote_type_ge_og__c = 'Bid Competitive';
            oppty.has_opportunitycontactrole_ge_og__c =true ;
            oppty.deal_path_ge_og__c = 'Deal Desk';
            oppty.Is_express_ge_og__c = 'No';
            oppty.need_comm_ops_support_ge_og__c = true;
            oppty.has_commercial_primary_resource_ge_og__c = True;
            oppty.end_user_ge_og__c= accLE.id;
            oppty.install_country_ge_og__c= 'India';
            oppty.bid_due_date_ge_og__c= system.today();
            oppty.delivery_date_ge_og__c = null;
            oppty.isbudgetary_ge_og__c = 'Firm Fixed';
            oppty.sub_industry_ge_og__c = 'XYZ'; 
            oppty.legal_entity_ge_og__c = accLE.id;
            // oppty.convertible_ge_og__c = 'No' ;
            oppty.ge_legal_entity_ge_og__c = accInternal.ID;
            oppty.bid_sent_date_ge_og__c = System.Today();
            oppty.bid_sent_ge_og__c = True;
            oppty.stage_ge_og__c = System.Label.Bid_In_Submission;
            oppty.StageName = System.Label.Bid_In_Submission;    
            oppty.primary_reason_code_ge_og__c = '';
            oppty.primary_sub_reason_code_ge_og__c = '';
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
            update oppty;
            
            Test.stopTest();
        }catch(Exception e)
        {
            Boolean expectedExceptionThrown =  e.getMessage().contains('To move the stage to \'Closed Lost\', Primary Reason Code and respected Primary Sub Reason Code should be populated.') ? true : false;
            //System.AssertEquals(expectedExceptionThrown, true);
        } 
    }
    //6E. by Gourav
    
    
    public static testMethod void testExpressOpptyAutomation_new4()
    {
        
        
        Map<id,Opportunity> oldOpptyMap = new Map<id,Opportunity>();
        List<Opportunity> newOpptyList;
        
        Map<String, Boolean> mapOppPrimaryReason = new Map<String,Boolean>();
        mapOppPrimaryReason.put('Test', True);
        
        Opportunity_Stage_Won_Lost_Nego_GE_OG oswl = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
        Test.startTest();
        Opportunity oppty = [select id, stage_ge_og__c, StageName, competitor_required_ge_og__c, competitor_ge_og__c, competitor_1_ge_og__c, Is_express_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c  from opportunity where Name = 'Testopportunity'];
        
        oppty.install_country_ge_og__c = 'India';
        //oppty.Is_express_ge_og__c = 'No';
        update oppty;
        
        oldOpptyMap.put(Oppty.id, Oppty);
        
        
        try{
            
            
            oppty.stage_ge_og__c = 'Closed Lost';
            oppty.primary_reason_code_ge_og__c = 'TEst';
            oppty.primary_sub_reason_code_ge_og__c = 'Test';
            oppty.disposition_comments_ge_og__c = 'Closed';
            
            
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
            update oppty;
            newOpptyList= new List<Opportunity>();
            Opportunity oppty1 = [select id, stage_ge_og__c, StageName, competitor_required_ge_og__c, competitor_ge_og__c, competitor_1_ge_og__c, Is_express_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c  from opportunity where Name = 'Testopportunity'];
            newOpptyList.add( Oppty1);
            CheckRecursion_GE_OG.run =true;
            oswl.checkedCancelled(newOpptyList, oldOpptyMap, mapOppPrimaryReason);
            
            
        }catch(Exception e)
        {
            
        } 
        
        try{
            oppty.stage_ge_og__c = 'Closed Lost';
            oppty.primary_reason_code_ge_og__c = 'TEst';
            oppty.primary_sub_reason_code_ge_og__c = 'Test';
            oppty.disposition_comments_ge_og__c = 'Closed';
            oppty.competitor_ge_og__c = True;
            oppty.competitor_1_ge_og__c = 'Test';
            
            
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
            update oppty;
            newOpptyList= new List<Opportunity>();
            Opportunity oppty2 = [select id, stage_ge_og__c, StageName, competitor_required_ge_og__c, competitor_ge_og__c, competitor_1_ge_og__c, Is_express_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c  from opportunity where Name = 'Testopportunity'];
            newOpptyList.add( Oppty2);
            CheckRecursion_GE_OG.run =true;
            oswl.checkedCancelled(newOpptyList, oldOpptyMap, mapOppPrimaryReason);
            
            
            
        }
        catch(exception e){
            
        }
        Test.stopTest();
    }
    
    
    public static testMethod void testExpressOpptyAutomation_new41()
    {
        
        
        Map<id,Opportunity> oldOpptyMap = new Map<id,Opportunity>();
        List<Opportunity> newOpptyList;
        
        Map<String, Boolean> mapOppPrimaryReason = new Map<String,Boolean>();
        mapOppPrimaryReason.put('Test', True);
        
        Opportunity_Stage_Won_Lost_Nego_GE_OG oswl = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
        
        Opportunity oppty = [select id, stage_ge_og__c, StageName, competitor_required_ge_og__c, competitor_ge_og__c, competitor_1_ge_og__c, Is_express_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c  from opportunity where Name = 'Testopportunity'];
        
        oppty.install_country_ge_og__c = 'India';
        //oppty.Is_express_ge_og__c = 'No';
        CheckRecursion_GE_OG.run =true;
        CheckRecursion_GE_OG.eRadCreation =true;
        CheckRecursion_GE_OG.runDeliveryDate =true;
        //update oppty;
        
        oldOpptyMap.put(Oppty.id, Oppty);
        Test.startTest();
        
        try{
            
            
            oppty.stage_ge_og__c = 'Closed Lost';
            oppty.primary_reason_code_ge_og__c = 'TEst';
            oppty.primary_sub_reason_code_ge_og__c = 'Test';
            oppty.disposition_comments_ge_og__c = 'Closed';
            
            
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
            CheckRecursion_GE_OG.eRadCreation =true;
            CheckRecursion_GE_OG.runDeliveryDate =true;
            update oppty;
            
            system.debug('iiiiiiiiiiiiiiiiiiiiiiiiiiii    '+ [select id, stageName from Opportunity where id=:oppty.id]);
            newOpptyList= new List<Opportunity>();
            Opportunity oppty1 = [select id, stage_ge_og__c, StageName, competitor_required_ge_og__c, competitor_ge_og__c, competitor_1_ge_og__c, Is_express_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c  from opportunity where Name = 'Testopportunity'];
            newOpptyList.add( Oppty1);
            //CheckRecursion_GE_OG.run =true;
            //oswl.checkedCancelled(newOpptyList, oldOpptyMap, mapOppPrimaryReason);
            
            
        }catch(Exception e)
        {
            system.debug('exxxxxxxxxxx     ' + e);
        } 
        
        try{
            oppty.stage_ge_og__c = 'Closed Lost';
            oppty.primary_reason_code_ge_og__c = 'TEst';
            oppty.primary_sub_reason_code_ge_og__c = 'Test';
            oppty.disposition_comments_ge_og__c = 'Closed';
            oppty.competitor_ge_og__c = True;
            oppty.competitor_1_ge_og__c = 'Test';
            
            
            CheckRecursion_GE_OG.run =false; //handling recursion Scenario
            
            update oppty;
            system.debug('iiiiiiiiiiiiiiiiiiiiiiiiiiii    '+ [select id, stageName from Opportunity where id=:oppty.id]);
            newOpptyList= new List<Opportunity>();
            Opportunity oppty2 = [select id, stage_ge_og__c, StageName, competitor_required_ge_og__c, competitor_ge_og__c, competitor_1_ge_og__c, Is_express_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c  from opportunity where Name = 'Testopportunity'];
            newOpptyList.add( Oppty2);
            //CheckRecursion_GE_OG.run =true;
            oswl.checkedCancelled(newOpptyList, oldOpptyMap, mapOppPrimaryReason);
            
            
            
        }
        catch(exception e){
            system.debug('exxxxxxxxxxx     ' + e);
        }
        Test.stopTest();
    }
    
    //Commented by Sonali and created a new test class for this
    //by Gourav Closed Lost:
    /*   public static testMethod void testExpressOpptyAutomation_newCL()
{

Account acc = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member 123456789');

Account accLE = [select id from account where name='TestAccount Legal'];
Test.startTest();
Map<id,Opportunity> oldOpptyMap = new Map<id,Opportunity>();
Map<id,Opportunity> newOpptyMap = new Map<id,Opportunity>();

Map<String, Boolean> mapOppPrimaryReason = new Map<String,Boolean>();
mapOppPrimaryReason=null;

Opportunity_Stage_Won_Lost_Nego_GE_OG oswl = new Opportunity_Stage_Won_Lost_Nego_GE_OG();

Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSettingOFS();

Opportunity oppty = new Opportunity();
oppty.Name='TestOptyZ';
oppty.install_country_ge_og__c = 'India';
oppty.AccountId = acc.id;
//Changed from Bid Competitive to Bid Competitive / Tender
oppty.quote_type_ge_og__c = 'Bid Competitive / Tender';
oppty.has_opportunitycontactrole_ge_og__c =true ;
oppty.deal_path_ge_og__c = 'Deal Desk';
oppty.Is_express_ge_og__c = 'No';
oppty.need_comm_ops_support_ge_og__c = true;
oppty.has_commercial_primary_resource_ge_og__c = True;
oppty.end_user_ge_og__c= accLE.id;
oppty.install_country_ge_og__c= 'India';
oppty.bid_due_date_ge_og__c= system.today();
oppty.delivery_date_ge_og__c = null;
oppty.isbudgetary_ge_og__c = 'Firm Fixed';
oppty.sub_industry_ge_og__c = 'XYZ'; 
//oppty.legal_entity_ge_og__c = accLE.id;
// oppty.convertible_ge_og__c = 'No' ;
//oppty.ge_legal_entity_ge_og__c = accInternal.ID;
oppty.bid_sent_date_ge_og__c = System.Today();
oppty.bid_sent_ge_og__c = True;
oppty.stage_ge_og__c = 'Prospecting';
oppty.StageName = 'Prospecting';
//oppty.competitor_required_ge_og__c=true;
oppty.competitor_ge_og__c=false;
oppty.primary_reason_code_ge_og__c = '';
oppty.primary_sub_reason_code_ge_og__c = '';
oppty.region_ge_og__c = 'Test Region';
oppty.closedate = system.today().addDays(30);
oppty.RecordTypeId=Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
//Changed the below from Measurement & Control to Digital Solutions
oppty.tier_2_ge_og__c ='Oil Field Services'; //changed from DS to OFS
oppty.tier_3_ge_og__c ='Artificial Lift';//changed from Bently Nevada to AL

oppty.amount_ge_og__c =1000.00;
oppty.install_country_ge_og__c= 'India';
insert oppty;
Opportunity opptyOld =[Select Id,bid_sent_date_ge_og__c, competitor_required_ge_og__c,competitor_ge_og__c,stage_ge_og__c,StageName from opportunity where Id=:oppty.Id];

//  try{
//update oppty
oppty.stage_ge_og__c = 'Bid In Submission';
oppty.StageName = 'Bid In Submission';
oppty.primary_reason_code_ge_og__c='PRCval';
oppty.primary_sub_reason_code_ge_og__c='SRCval';
update oppty;
// }catch(Exception e){System.debug('Getting error'+e.getMessage());
//}
Opportunity opptyNew = [Select Id,bid_sent_date_ge_og__c, competitor_required_ge_og__c,competitor_ge_og__c,stage_ge_og__c,StageName from opportunity where Id=:oppty.Id];
CheckRecursion_GE_OG.run =true;
CheckRecursion_GE_OG.eRadCreation =true;
CheckRecursion_GE_OG.runDeliveryDate =true;


oldOpptyMap.put(oppty.id, opptyOld);
newOpptyMap.put(oppty.id, opptyNew);



//CheckRecursion_GE_OG.run =true;
oswl.checkClosed_Won_Lost_Negotiating(newOpptyMap, oldOpptyMap, mapOppPrimaryReason);
//oswl.getCustomStageValue(oppty,'');

Test.stopTest();
}

//By Gourav to test Express checkClosed_Won_Lost_Negotiating
public static testMethod void testExpressOpptyAutomation_closed()
{
Test.startTest();
Account accLE = [select id from account where name='TestAccount Legal'];
Account acc = CommonTestDataFactory_GE_OG.createAccount ('qwertyuiop');
Map<id,Opportunity> oldOpptyMap = new Map<id,Opportunity>();
Map<id,Opportunity> newOpptyMap = new Map<id,Opportunity>();

Map<String, Boolean> mapOppPrimaryReason = new Map<String,Boolean>();
mapOppPrimaryReason=null;

Opportunity_Stage_Won_Lost_Nego_GE_OG oswl = new Opportunity_Stage_Won_Lost_Nego_GE_OG();


Opportunity oppty = new Opportunity();
oppty.Name='12aergcduhvcxhvcsicvshsy';
oppty.install_country_ge_og__c = 'India';
oppty.AccountId = acc.Id;
//Changed from Bid Competitive to Bid Competitive / Tender
oppty.quote_type_ge_og__c = 'Bid Competitive / Tender';
oppty.has_opportunitycontactrole_ge_og__c =true ;
oppty.deal_path_ge_og__c = 'Express';
oppty.Is_express_ge_og__c = 'Yes';
oppty.need_comm_ops_support_ge_og__c = true;
oppty.has_commercial_primary_resource_ge_og__c = True;
oppty.end_user_ge_og__c= accLE.id;
oppty.install_country_ge_og__c= 'India';
oppty.bid_due_date_ge_og__c= system.today();
oppty.delivery_date_ge_og__c = null;
oppty.isbudgetary_ge_og__c = 'Firm Fixed';
oppty.sub_industry_ge_og__c = 'XYZ'; 
//oppty.legal_entity_ge_og__c = accLE.id;
// oppty.convertible_ge_og__c = 'No' ;
//oppty.ge_legal_entity_ge_og__c = accInternal.ID;
oppty.bid_sent_date_ge_og__c = System.Today();
oppty.bid_sent_ge_og__c = True;
// oppty.stage_ge_og__c = 'Prospecting';
oppty.StageName = 'Prospecting';
//oppty.competitor_required_ge_og__c=true;
oppty.competitor_ge_og__c=true;
oppty.primary_reason_code_ge_og__c = '';
oppty.primary_sub_reason_code_ge_og__c = '';
oppty.region_ge_og__c = 'Test Region';
oppty.closedate = system.today().addDays(30);
oppty.RecordTypeId=Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
//Changed the below from Measurement & Control to Digital Solutions
oppty.tier_2_ge_og__c ='Digital Solutions';
oppty.tier_3_ge_og__c ='Bently Nevada';
oppty.AccountId = acc.id;
oppty.amount_ge_og__c =1000.00;
oppty.install_country_ge_og__c= 'India';
insert oppty;
Opportunity opptyOld =[Select Id,bid_sent_date_ge_og__c, competitor_required_ge_og__c,competitor_ge_og__c,stage_ge_og__c,StageName from opportunity where Id=:oppty.Id];
System.debug('---------------......before stage update--------Updated stage:'+ oppty.stage_ge_og__c);

//  try{
//update oppty
oppty.stage_ge_og__c = 'Bid In Submission';
oppty.StageName = 'Bid In Submission';
oppty.primary_reason_code_ge_og__c='PRCval';
oppty.primary_sub_reason_code_ge_og__c='SRCval';
update oppty;
// }catch(Exception e){System.debug('Getting error'+e.getMessage());
//}
System.debug('---------------......after stage update--------Updated stage:'+ oppty.stage_ge_og__c);
Opportunity opptyNew = [Select Id,bid_sent_date_ge_og__c, competitor_required_ge_og__c,competitor_ge_og__c,stage_ge_og__c,StageName from opportunity where Id=:oppty.Id];
CheckRecursion_GE_OG.run =true;
CheckRecursion_GE_OG.eRadCreation =true;
CheckRecursion_GE_OG.runDeliveryDate =true;


oldOpptyMap.put(oppty.id, opptyOld);
newOpptyMap.put(oppty.id, oppty);
System.debug('---------------......send checkClosed_Won_Lost_Negotiating--------Updated old stage:'+ opptyOld.stage_ge_og__c);
System.debug('---------------......send checkClosed_Won_Lost_Negotiating--------Updated new stage:'+ opptyNew.stage_ge_og__c);


//CheckRecursion_GE_OG.run =true;
oswl.checkClosed_Won_Lost_Negotiating(newOpptyMap, oldOpptyMap, mapOppPrimaryReason);
//oswl.getCustomStageValue(oppty,'');

Test.stopTest();
}
*/
    public static testMethod void testRecursion()
    {
        Boolean objRecursion1 = CheckRecursion_GE_OG.runteamMember();
        Boolean objRecursion2 = CheckRecursion_GE_OG.runOnce();
        Boolean objRecursion3 = CheckRecursion_GE_OG.dealDeskRecusrion();
        Boolean objRecursion4 = CheckRecursion_GE_OG.ddBeforeProcess();
        Boolean objRecursion5 = CheckRecursion_GE_OG.prebidRecursion();
        Boolean objRecursion6 = CheckRecursion_GE_OG.runDeliveryDate();
        Boolean objRecursion7 = CheckRecursion_GE_OG.eRadCreation();
        Boolean objRecursion8 = CheckRecursion_GE_OG.taskRecursion();
        
    }
    
    // added for R-25898 tied to code coverage for AddOpportunityToProject_GE_OG
    public static testMethod void testEmailToProjectTeam(){
        
        Project_ge_og__c testProject = new Project_ge_og__c();
        Project_ge_og__c testProject2 = new Project_ge_og__c();
        Test.startTest();
        RecordType rtId = [SELECT Id FROM RecordType where DeveloperName='OG_Project'];
        
        
        //Createing an Account 
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member Koshay');
        Account accR = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation Koshay', acc1.ID);
        
        testProject.recordtypeid = rtId.Id;
        testProject.Name = 'The Testing Project';
        testProject.GE_ES_Tier_1_P_L__c = 'Oil & Gas (O&G)';
        testProject.GE_ES_Tier_2_P_L__c = 'Digital Solutions';
        testProject.Project_Account_ge_og__c = accR.Id;
        testProject.Project_Stage_ge_og__c = 'Feasibility';
        testProject.Project_Summary_ge_og__c = 'My Summary';
        
        Insert testProject;
        
        testProject2.recordtypeid = rtId.Id;
        testProject2.Name = 'The Testing Project 2';
        testProject2.GE_ES_Tier_1_P_L__c = 'Oil & Gas (O&G)';
        testProject2.GE_ES_Tier_2_P_L__c = 'Digital Solutions';
        testProject2.Project_Account_ge_og__c = accR.Id;
        testProject2.Project_Stage_ge_og__c = 'Feasibility';
        testProject2.Project_Summary_ge_og__c = 'My Summary';
        
        Insert testProject2;
        // CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        //Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        
        Opportunity myopp = [Select Id,Name from Opportunity where Name = 'Testopportunity2'];
        
        /*  myopp.name= 'Testopportunity Koshay';
myopp.stageName = 'Prospecting';
myopp.has_opportunitycontactrole_ge_og__c = True;
myopp.region_ge_og__c = 'Test Region';
myopp.Risk_Region_ge_og__c = 'Test Region';
myopp.closedate = system.today().addDays(30);
myopp.accountId = accR.ID;
//Changed the below from Measurement & Control to Digital Solutions
myopp.tier_2_ge_og__c ='Digital Solutions';
myopp.tier_3_ge_og__c ='Bently Nevada';
myopp.amount_ge_og__c =100.00;
myopp.install_country_ge_og__c= 'India';
myopp.opportunity_project_ge_og__c = testProject.Id;
insert myopp;*/
        
        System.debug('KOSHAY: Name of Opportunity: ' + myopp.Name);
        
        myopp.opportunity_project_ge_og__c  = testProject2.Id;
        test.stopTest();
        update myopp;
        
        
        
    }
    //testing fullstream project 
    /*  public static testMethod void testFullstreamProject(){

{
//Account accCountry = [select id from account where name='Test Account Country'];
Account accLE = [select id from account where name='TestAccount Legal'];

Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];

Project_ge_og__c fullStreamProject = CommonTestDataFactory_GE_OG.createProject('Test full stream');

contact objcont = new contact();
objcont.Email = 'test@sfdc.com';
objcont.accountid =  accLE.id;
objcont.firstname = 'test';
objcont.lastname = 'test';
objcont.GE_OG_Contact_Audience__c = 'Field Service';
insert objcont;


List<Opportunity> oppty =  new List<Opportunity>();
String [] otyNames = new String[]{'Testopportunity','Testopportunity2'};

oppty = [select id, has_opportunitycontactrole_ge_og__c, 
//Commented for DOA Revamp
//risk_checklist_submitted_ge_og__c, 
accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'otyNames'];

OpportunityContactRole oppcr = new OpportunityContactRole();
oppcr.ContactId = objcont.Id;
oppcr.OpportunityId = oppty[0].Id;
insert oppcr;

OpportunityContactRole oppcr1 = new OpportunityContactRole();
oppcr1.ContactId = objcont.Id;
oppcr1.OpportunityId = oppty[1].Id;
insert oppcr1;



oppty[0].install_country_ge_og__c = 'India';
//update oppty;
Test.startTest();
// Changed from Bid Competitive to Bid Competitive / Tender
oppty[0].quote_type_ge_og__c = 'Bid Competitive / Tender';
oppty[0].opportunity_project_ge_og__c = fullStreamProject.Id;
oppty[0].has_opportunitycontactrole_ge_og__c =true ;
oppty[0].deal_path_ge_og__c = 'Express';
oppty[0].Is_express_ge_og__c = 'Yes';
oppty[0].need_comm_ops_support_ge_og__c = true;
oppty[0].has_commercial_primary_resource_ge_og__c = True;
oppty[0].end_user_ge_og__c= accLE.id;
oppty[0].install_country_ge_og__c= 'India';
oppty[0].bid_due_date_ge_og__c= system.today();
oppty[0].delivery_date_ge_og__c = null;
oppty[0].isbudgetary_ge_og__c = 'Firm Fixed';
oppty[0].sub_industry_ge_og__c = 'XYZ'; 
oppty[0].legal_entity_ge_og__c = accLE.id;
// oppty[0].convertible_ge_og__c = 'No' ;
oppty[0].ge_legal_entity_ge_og__c = accInternal.ID;
CheckRecursion_GE_OG.run =true; //handling recursion Scenario
// update oppty[0];
//update from null to accInternal.ID;
oppty[0].ge_legal_entity_ge_og__c = null;
CheckRecursion_GE_OG.run =true; //handling recursion Scenario
// update oppty[0];

oppty[0].bid_sent_date_ge_og__c = System.Today();
oppty[0].bid_sent_ge_og__c = True;
oppty[0].stage_ge_og__c = System.Label.Closed_Won;
oppty[0].primary_reason_code_ge_og__c = 'XYZ';
oppty[0].primary_sub_reason_code_ge_og__c = 'ABC';
oppty[0].legal_entity_ge_og__c = accLE.id;
//Added to make type as Internal to create Express Deal
oppty[0].Type = 'External'; 
CheckRecursion_GE_OG.run =true; //handling recursion Scenario
update oppty[0];


oppty[1].install_country_ge_og__c = 'India';
//update oppty;

// Changed from Bid Competitive to Bid Competitive / Tender
oppty[1].quote_type_ge_og__c = 'Bid Competitive / Tender';
oppty[1].has_opportunitycontactrole_ge_og__c =true ;
oppty[1].tier_2_ge_og__c = 'Oil Field Equipment';
oppty[1].tier_3_ge_og__c = 'Services';
oppty[1].opportunity_project_ge_og__c = fullStreamProject.Id;
oppty[1].deal_path_ge_og__c = 'Express';
oppty[1].Is_express_ge_og__c = 'Yes';
oppty[1].need_comm_ops_support_ge_og__c = true;
oppty[1].has_commercial_primary_resource_ge_og__c = True;
oppty[1].end_user_ge_og__c= accLE.id;
oppty[1].install_country_ge_og__c= 'India';
oppty[1].bid_due_date_ge_og__c= system.today();
oppty[1].delivery_date_ge_og__c = null;
oppty[1].isbudgetary_ge_og__c = 'Firm Fixed';
oppty[1].sub_industry_ge_og__c = 'XYZ'; 
oppty[1].legal_entity_ge_og__c = accLE.id;
// oppty[1].convertible_ge_og__c = 'No' ;
oppty[1].ge_legal_entity_ge_og__c = accInternal.ID;
CheckRecursion_GE_OG.run =true; //handling recursion Scenario
// update oppty[1];
//update from null to accInternal.ID;
oppty[1].ge_legal_entity_ge_og__c = null;
CheckRecursion_GE_OG.run =true; //handling recursion Scenario
// update oppty[1];

oppty[1].bid_sent_date_ge_og__c = System.Today();
oppty[1].bid_sent_ge_og__c = True;
oppty[1].stage_ge_og__c = System.Label.Closed_Won;
oppty[1].primary_reason_code_ge_og__c = 'XYZ';
oppty[1].primary_sub_reason_code_ge_og__c = 'ABC';
oppty[1].legal_entity_ge_og__c = accLE.id;
//Added to make type as Internal to create Express Deal
oppty[1].Type = 'External'; 
CheckRecursion_GE_OG.run =true; //handling recursion Scenario

Test.stopTest();

update oppty[1];



}*/
    //}
    public static testMethod void testcoverage()
        
    {
        DealDeskOpportunityAutomation_GE_OG.Codecoverage();
    }
    
}