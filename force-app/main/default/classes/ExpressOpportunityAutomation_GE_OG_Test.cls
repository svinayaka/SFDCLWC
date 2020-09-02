@isTest
public class ExpressOpportunityAutomation_GE_OG_Test {
    @testsetup
    static void createRecord()
    {
        
        //creating 'Country Region Mapping' for 'INDIA'
        Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
        //Country_Region_Mapping_ge_og__c objcust = CommonTestDataFactory_GE_OG.createCountryRegionMappingData('1','RUSSIAN FEDERATION','TT','RUSSIAN FEDERATION','Active');
        insert objcustom;
       // insert objcust;
        
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
        Account accInternal = CommonTestDataFactory_GE_OG.createSellingLegalEntityAccount('TestAccount Internal',acc.ID);
        system.assertEquals('TestAccount Internal',accInternal.Name);
        test.startTest();
        //Creating an Opportunity
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',opp.Name);
       
        //Creating a Product
        Product2 prod1 = CommonTestDataFactory_GE_OG.createProduct('testProduct');
        system.assertEquals('testProduct',prod1.Name);
        
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
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
            }Test.stopTest();
        }
         
    }
    public static testMethod void testOpportunityStages1(){
        Account accLE = [select id from account where name='TestAccount Legal'];
        Account internalLe = [Select id,Name from Account where Name = 'TestAccount Internal'];
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        User u1 = new User(Alias = 'standt', Email='standarduser@testorg.com',
                           EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles', UserName='grvAnan123@testorg.com');
        insert u1;
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        objcont.GE_HQ_SFDC_Legacy_Id__c='random id';
        insert objcont;
        
        
        test.startTest();
        Opportunity opp = [Select Id,Name from Opportunity where Name='Testopportunity'];
        
        OpportunityContactRole ocr = new OpportunityContactRole();
        ocr.OpportunityId = opp.Id;
        ocr.ContactId = objcont.id;
        insert ocr;
        
        
        OpportunityTeamMember otm = new OpportunityTeamMember();
        otm.UserId = u1.Id;
        otm.OpportunityId = opp.Id;
        otm.TeamMemberRole = 'Commercial Primary Resource';
        //otm.OpportunityAccessLevel = 'Read Only';
        insert otm;
        
        opp.deal_path_ge_og__c = 'Express';
        opp.isbudgetary_ge_og__c = 'Firm Fixed';
        opp.primary_industry_ge_og__c= 'Upstream Offshore';
        opp.sub_industry_ge_og__c = 'CO2 capture and storage';
        opp.quote_type_ge_og__c = 'Bid Competitive / Tender';
        opp.install_country_ge_og__c = 'India';
        opp.bid_due_date_ge_og__c = system.today();
        opp.bid_sent_date_ge_og__c = system.today();
        opp.delivery_date_ge_og__c = system.today();
        opp.countryworkflow_ge_og__c = '1222323435';
        opp.Das_Project_Workflow_ge_og__c  = 'test';
        opp.dsa_workflow_ge_og__c='testing';
        opp.oppty_cm_ge_og__c = 10;
       // opp.has_commercial_primary_resource_ge_og__c = true;
       // opp.ge_legal_entity_ge_og__c = internalLe.Id;
        
        
        update opp;
        test.stopTest();
        
        
        
    }
}