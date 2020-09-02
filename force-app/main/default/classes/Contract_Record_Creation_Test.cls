/*
Class/Trigger Name     : Contract_Record_Creation,DeactivateContractsOnOptyClose
Purpose/Overview       : Test Class to calculate the code coverage for the DeactivateContractsOnOptyClose,Contract_Record_Creation Classes.              
Requirement Number     : R-32173,R-32213
Author                 : Harsha C
Created Date           : 08-july-2019
Used For               : Contract_Record_Creation - 87%,
						 DeactivateContractsOnOptyClose - 76%
*/ 

@isTest
public class Contract_Record_Creation_Test {
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
        
        //   Account accmem = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccount Relation 1');
        // system.assertEquals('TestAccount Relation 1',accmem.Name);
        
        //Createing an Account
        Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('TestAccount Legal',acc.ID,acc1.ID);
        system.assertEquals('TestAccount Legal',accLE.Name);
        
        //Create Test Account for ContactSumTrigger
        String TestAccountName = system.Label.Test_Account_Name;
        
        Account accInternal = CommonTestDataFactory_GE_OG.createSellingLegalEntityAccount('TestAccount Internal',acc.ID);
        system.assertEquals('TestAccount Internal',accInternal.Name);
        
        /* Account accnt= new Account();
accnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Competitor').getRecordTypeId();
accnt.name = 'Test';
accnt.Account_Tier_GEOG__c = 'Global';
accnt.Classification__c= 'Strategic';
accnt.Type = 'Competitor';
accnt.ShippingCountry = 'India';
accnt.Account_Status__c='Active';
insert accnt;*/
        Account competitorAccount = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Competitor Account');
        test.startTest();
        
        //Creating an Opportunity
        Opportunity opp = CommonTestDataFactory_GE_OG.createOpptyOFSIWS('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',opp.Name);
        
        //Creating a Product
        Product2 prod1 = CommonTestDataFactory_GE_OG.createProduct('testProduct','Oil Field Services');
        system.assertEquals('testProduct',prod1.Name);
        
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        
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
    public static testMethod void testContractRecordCreation(){
        
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
        oppty.install_country_ge_og__c = 'India';
        update oppty;
        
        
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
        oppty.bid_to_win_approval_ge_og__c = True;
        oppty.legal_entity_ge_og__c = accLE.id;
        oppty.ge_legal_entity_ge_og__c = accInternal.ID;
        CheckRecursion_GE_OG.run =true; //handling recursion Scenario
        oppty.primary_reason_code_ge_og__c = 'XYZ';
        oppty.primary_sub_reason_code_ge_og__c = 'ABC';
        oppty.create_Contract_Record_ge_og__c = true;
        CheckRecursion_GE_OG.run =false; //handling recursion Scenario
        update oppty;
        List<Id> oplist = new List<Id>();
        oplist.add(oppty.Id);
        Contract_Record_Creation.contractRecordCreation(oplist);
       // DealMachineContractTeamCraetion.contractTeamDMContract(oplist);
        
        
        
        Test.stopTest();
        
    }
    public static testMethod void testDealDeskOpptyAutomation(){
        test.startTest();
        List<Id> optylist = new List<Id>(); 
        List<Opportunity> opplist = new List<Opportunity>();
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
        acc.name = 'Test LE121212';
        acc.Account_Tier_GEOG__c = 'LE';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Unclassified';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        //acc.Oil_Gas_Parent_Account__c = accID;
        //Account accGlobal= CommonTestDataFactory_GE_OG.createAccount('TestAccount Global');    
        //acc.Member_of_GE_OG__c = accGlobal.Id;//
        insert acc;
        
        
        
        Opportunity oppty = [Select Id,name,primary_country_ge_og__c from Opportunity where Name ='Testopportunity'];
        
        
        Contract objCon = new Contract();
        objCon.name = 'Test Team Contract';
        objCon.AccountId = acc.id;
        objCon.Status = 'Draft';
        objCon.RecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Deal Machine Contract').getRecordTypeId();
        insert objCon; 
        
        Opportunity_Contract_Relationship_GE_OG__c oppcon = new Opportunity_Contract_Relationship_GE_OG__c();
        oppcon.Contract_ID_GE_OG__c = objCon.Id;
        oppcon.Primary_Opportunity_GE_OG__c = true;
        oppcon.opportunity_ID_ge_og__c = oppty.Id;
        insert oppcon;
        oppty.disposition_comments_ge_og__c = 'winlossComments';
        oppty.primary_reason_code_ge_og__c = 'Alternate Channel';
        oppty.primary_sub_reason_code_ge_og__c = 'Alternate BHGE Solution';
        oppty.stage_ge_og__c = 'Cancelled';
        opplist.add(oppty);
        optylist.add(oppty.Id);
       // update opplist;
        DeactivateContractsOnOptyClose.contractRecordCreation(optylist);
        
        Test.stopTest();
    }
}