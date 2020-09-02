/*
Class/Trigger Name     : GE_OG_eRad_Creation
Used For               : GE_OG_eRad_Creation-----78%
Purpose/Overview       : Test Class to calculate the code coverage for the GE_OG_eRad_Creation on eRad
Scrum Team             : Transformation - oppSS MGMT
Requirement Number     : R-23908
Author                 : Nitish Pandey
Created Date           : 28-Dec-2015
*/

@isTest
public class GE_OG_eRad_Creation_Test
{
    //method will create new dummy records for all required Objects from the datafactory "CommonTestDataFactory_GE_OG"
    @testsetup
    static void createRecord()
    {
        
		test.startTest();
        
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        Account accMem = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        account accCountry = CommonTestDataFactory_GE_OG.createCommercialParentAccount('Test Account Country');
        
        Test.stopTest();
    }
    
    
    public static testMethod void test1()
    {
        test.startTest();
        
        //account accLE = [ select id from Account where name = 'Test Account LE'];
        //Account accRelation = [select id from Account where name = 'TestAccount Relation'];
        Account accRelation = CommonTestDataFactory_GE_OG.createAccount('TestAccount Relation');
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting2();
        
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Hedge').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Prospecting';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accRelation.Id;
        // changed from Subsea & Drilling to Oil Field Equipment
        oppSS.tier_2_ge_og__c ='Oil Field Equipment'; 
        //Changed from Drilling to Services
        oppSS.tier_3_ge_og__c ='Services';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        //Create Product
        Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        // changed from Subsea & Drilling to Oil Field Equipment
        productSS.GE_Tier2_PnL__c = 'Oil Field Equipment';
        //Changed from Drilling to Subsea Drilling Systems
        productSS.GE_Tier3_PnL__c = 'Subsea Drilling Systems';
        productSS.isActive = true;
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk;
        
        
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        test.stopTest();
    }
    
    //Method to test Subsea & Drilling
    public static testMethod void test2()
    {
        
        Account accLE = CommonTestDataFactory_GE_OG.createAccount('TestAccountRelation2');
        Account accComp1 = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('TestAccountCountry2');
        // Account accComp1 = AccountTestDataFactory.createRelationshipAccount('TestAccountCountry2'); 
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting2();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp1 = CommonTestDataFactory_GE_OG.createCommercialParentAccount('accComp1');
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        //creating new opportuntiy for Subsea & Drilling
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Hedge').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        
        oppSS.stageName = 'Prospecting';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Oil Field Equipment'; 
        oppSS.tier_3_ge_og__c ='Subsea Drilling Systems';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        //Create Product
        Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Oil Field Equipment';
        productSS.GE_Tier3_PnL__c = 'Subsea Drilling Systems';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        //1S.by Gourav
        
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            test.startTest();
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,
                                                                                             entity_ge_og__c=  accComp1.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        oppSS.stageName = 'Closed Won';
        oppSS.has_commercial_primary_resource_ge_og__c=true;
        update oppSS;
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        
        erad__c objEradCreate = new erad__c(Opportunity__c = oppSS.Id, Status__c = 'Active Bid');
        insert objEradCreate;
        
        //objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);   
        //1E. by Gourav
        
        test.stopTest();
    }
    
    //Method to test Turbomachinery Solutions
    public static testMethod void test3()
    {
        
        Account accLE = CommonTestDataFactory_GE_OG.createAccount('TestAccountRelation3');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('TestAccountCountry3');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        //creating new opportuntiy for Turbomachinery Solutions
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Hedge').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        //Changed by Nitish
        oppSS.stageName = 'Prospecting';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='New Units';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        //Create Product
        Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'New Units';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //   objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        //1S.by Gourav
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            test.startTest();
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        
        erad__c objEradCreate = new erad__c(Opportunity__c = oppSS.Id, Status__c = 'Active Bid');
        insert objEradCreate;
        
        
        //objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);   
        //1E. by Gourav
        
        
        test.stopTest();
    }
    
    //Method to test Downstream Technology Solutions
    public static testMethod void test4()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createAccount('TestAccountRelation4');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('TestAccountCountry4');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        
        
        //creating new opportuntiy for Downstream Technology Solutions
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Hedge').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Prospecting';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        //  productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        test.startTest();
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        //  oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c ,RecordTypeId
        //           FROM Opportunity 
        //           WHERE ID=:oppSS.Id]; 
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        erad__c objEradCreate = objErad.returneradrec(oppSS.Id,oppSS.RecordTypeId,oppSS.OwnerId,'test','test');
        
       // erad__c objEradCreate = new erad__c(Opportunity__c = oppSS.Id, Status__c = 'Active Bid');
       // insert objEradCreate;
      	 Discount__c discount = new Discount__c();
        discount.eRAD__c = objEradCreate.Id;
        discount.Discount_type__c = 'Volume discount';
        discount.Discount_MM__c = 10;
               
        
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    //3S. Method to test TMS Opex Core
    public static testMethod void test_new()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createAccount('TestAccountRelationnew');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('TestAccountCountrynew');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        //creating new opportuntiy for Turbomachinery Solutions
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Hedge').getRecordTypeId();
        oppSS.name= 'TESToppSS TESToppSS TESToppSS TESToppSS TESToppSS TESToppSS TESToppSS TESToppSS';
        
        oppSS.stageName = 'Prospecting';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Opex';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        //Create Product
        Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Opex';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            test.startTest();
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        oppSS.stageName = 'Closed Won';
        oppSS.has_commercial_primary_resource_ge_og__c=true;
        update oppSS;
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        
        erad__c objEradCreate = new erad__c(Opportunity__c = oppSS.Id, Status__c = 'Active Bid');
        insert objEradCreate;
         Discount__c discount = new Discount__c();
        discount.eRAD__c = objEradCreate.Id;
        discount.Discount_type__c = 'Volume discount';
        discount.Discount_MM__c = 10;
        
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);   
        //1E. by Gourav
        
        
        test.stopTest();
    }
    public static testMethod void test5()
    {
        test.startTest();
        
        Account accLE = CommonTestDataFactory_GE_OG.createAccount('TestAccount Relation');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country5');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Hedge').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Prospecting';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        //Create Product
        Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        test.stopTest();
    }
    
    
    public static testMethod void test6()
    {
        test.startTest();
        
        Account accLE = CommonTestDataFactory_GE_OG.createAccount('TestAccount Relation');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Hedge').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Prospecting';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Opex';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        //Create Product
        Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Opex';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        test.stopTest();
    }
    
    public static testMethod void test7()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createAccount('TestAccount Relation7');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country7');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Hedge').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Prospecting';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<id,opportunity> opptyoldMap = new Map<id,opportunity>();
        opptyoldMap.put(oppSS.id,oppSS);
        
        //Create Product
        Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        //  productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c,RecordTypeId 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        
        erad__c objEradCreate = new erad__c(Opportunity__c = oppSS.Id, Status__c = 'Active Bid');
        insert objEradCreate;
        //Added By Nitish
        ERadApprovalProcess.submitErad(objEradCreate.id);
        String str = ERadApprovalProcess.submitErad(oppSS.id);
        
        
        
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    
    public static testMethod void test8()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation8');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country8');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting2();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Negotiating';
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Oil Field Equipment'; 
        oppSS.tier_3_ge_og__c ='Subsea Drilling Systems';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Oil Field Equipment';
        productSS.GE_Tier3_PnL__c = 'Subsea Drilling Systems';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c,RecordTypeId 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        
        erad__c objEradCreate = new erad__c(Opportunity__c = oppSS.Id, Status__c = 'Active Bid');
        insert objEradCreate;
        //Added By Nitish
        ERadApprovalProcess.submitErad(objEradCreate.id);
        String str = ERadApprovalProcess.submitErad(oppSS.id);
        
        
        
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    
    public static testMethod void test9()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation9');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country9');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c,RecordTypeId 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        
        erad__c objEradCreate = new erad__c(Opportunity__c = oppSS.Id, Status__c = 'Active Bid');
        insert objEradCreate;
        
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    //2S.by Gourav
    public static testMethod void test9_new()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createAccount('TestAccountRelation9');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country9');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Hedge').getRecordTypeId();
        oppSS.name= 'TESToppSSNew';
        oppSS.stageName = 'Prospecting';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        //changed from Submitted to Blank - Kiru                               
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCreate= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCreate;
        
        test.stopTest();
    }
    //2E.by Gourav
    
    
    public static testMethod void test10()
    {
        //account accLE = [ select id from Account where name = 'TestAccountRelation10'];
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation10');
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country10');
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,Name,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,Name,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c,OwnerId,RecordTypeId 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        
        erad__c objEradCreate = new erad__c(Opportunity__c = oppSS.Id, Status__c = 'Active Bid');
        insert objEradCreate;
        
        
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        objErad.retclosederadrec(oppSS.Id,  
                                 Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId(), 
                                 oppSS.OwnerId, 
                                 accLE.Id,
                                 '');
        
        test.stopTest();
    }
    
    public static testMethod void test11()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation11');
        //account accLE = [ select id from Account where name = 'TestAccountRelation11'];
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country11');
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting2();
        
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Grouped_Flow_Type_ge_og__c='With Account';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Oil Field Equipment'; 
        oppSS.tier_3_ge_og__c ='Subsea Drilling Systems';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Oil Field Equipment';
        productSS.GE_Tier3_PnL__c = 'Subsea Drilling Systems';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,Name,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,Name,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    
    public static testMethod void test12()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation12');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country12');
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    
    public static testMethod void test13()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation13');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country13');
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.deal_path_ge_og__c = 'Express';
        oppSS.opportunity_region_ge_og__c = 'Region';
        //oppSS.convertibility_ge_og__c = True;
        oppSS.GE_OG_Convertible_Amount__c = 1000;
        //oppSS.convertible_ge_og__c = 'Yes';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, legal_entity_ge_og__c, StageName,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,Name,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        System.debug('222222222222222222222222222222   '+oppSS.StageName);
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,Name,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        //Account accCountry = [select id from account where name='Test Account Country'];
        //  Account accLEntity = [select id from account where name='TestAccount Legal'];
        
        //GE_ES_ITO_Competitor__c comp = new GE_ES_ITO_Competitor__c();
        //comp.GE_ES_Competitor__c = accComp.id;
        //Insert Comp;
        
        //oppSS.stage_ge_og__c = 'Closed Won';
        //oppSS.primary_reason_code_ge_og__c = 'XYZ';
        //oppSS.primary_sub_reason_ge_og__c = 'ABC';
        oppSS.disposition_comments_ge_og__c = 'Comment';
        oppSS.CloseDate = System.today().AddDays(40);
        oppSS.competitor_1_ge_og__c = 'Competitor';
        oppSS.competitor_ge_og__c = False;
        
        oppSS.bid_sent_date_ge_og__c = System.Today();
        oppSS.bid_sent_ge_og__c = True;
        
        oppSS.StageName = System.Label.Closed_Won;
        oppSS.primary_reason_code_ge_og__c = 'XYZ';
        oppSS.primary_sub_reason_code_ge_og__c = 'ABC';
        // oppSS.legal_entity_ge_og__c  = accLE.ID;
        
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,Name,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c,OwnerId,RecordTypeId 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        system.debug('3333333333333333333333333333   '+ oppSS.StageName);
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                system.assertEquals('Closed Won',oppSS.StageName);
        
        
        GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    
    public static testMethod void test14()
    {
        
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation14');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country14');
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='New Units';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'New Units';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        
        oppSS.RecordtypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Grouped Flow').getRecordTypeId();
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    
    public static testMethod void test15()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation15');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country15');
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting2();
        
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Oil Field Equipment'; 
        oppSS.tier_3_ge_og__c ='Subsea Drilling Systems';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Oil Field Equipment';
        productSS.GE_Tier3_PnL__c = 'Subsea Drilling Systems';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        
        test.startTest();
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c,RecordTypeId 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        oppSS.RecordtypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Grouped Flow').getRecordTypeId();
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        
        erad__c objEradCreate = new erad__c(Opportunity__c = oppSS.Id, Status__c = 'Active Bid');
        insert objEradCreate;
        
        ERadApprovalProcess.submitErad(objEradCreate.id);
        String str = ERadApprovalProcess.submitErad(oppSS.id);
        
        
        
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    
    public static testMethod void test16()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation16');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country16');
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.deal_path_ge_og__c = 'Express';
        oppSS.opportunity_region_ge_og__c = 'Region';
        //oppSS.convertibility_ge_og__c = True;
        oppSS.GE_OG_Convertible_Amount__c = 1000;
        //oppSS.convertible_ge_og__c = 'Yes';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, legal_entity_ge_og__c, StageName,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,Name,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,Name,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        //GE_ES_ITO_Competitor__c comp = new GE_ES_ITO_Competitor__c();
        //comp.GE_ES_Competitor__c = accComp.id;
        
        oppSS.disposition_comments_ge_og__c = 'Comment';
        oppSS.CloseDate = System.today().AddDays(40);
        oppSS.competitor_1_ge_og__c = 'Competitor';
        oppSS.competitor_ge_og__c = False;
        
        oppSS.bid_sent_date_ge_og__c = System.Today();
        oppSS.bid_sent_ge_og__c = True;
        
        oppSS.StageName = System.Label.Closed_Won;
        oppSS.primary_reason_code_ge_og__c = 'XYZ';
        oppSS.primary_sub_reason_code_ge_og__c = 'ABC';
        
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,end_user_ge_og__c,Name,tier_2_ge_og__c,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c,OwnerId,RecordTypeId 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        oppSS.RecordtypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Grouped Flow').getRecordTypeId();
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    
    public static testMethod void test17()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation17');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country17');
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting2();
        
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Oil Field Equipment'; 
        oppSS.tier_3_ge_og__c ='Subsea Drilling Systems';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Oil Field Equipment';
        productSS.GE_Tier3_PnL__c = 'Subsea Drilling Systems';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        oppSS.RecordtypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Grouped Flow').getRecordTypeId();
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        
        test.stopTest();
    }
    
    
    public static testMethod void test18()
    {
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation18');
        Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country18');
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Turbomachinery & Process Solutions'; 
        oppSS.tier_3_ge_og__c ='PVS - Installation';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
            
            
            //Create Product
            Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
        // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Turbomachinery & Process Solutions';
        productSS.GE_Tier3_PnL__c = 'PVS - Installation';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
        // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        test.startTest();
        
        Pre_Bid_ge_og__c preBidList = [Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.region_ge_og__c,
                                       pre_bid_opportunity_ge_og__r.is_global_ge_og__c 
                                       from Pre_Bid_ge_og__c WHERE pre_bid_opportunity_ge_og__c =: oppSS.Id];
        
        
        
        preBidList.pre_bid_status_ge_og__c = '';
        update preBidList;
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,entity_ge_og__c=  accComp.Id,ge_record_ge_og__c= false);
        Insert preBidEvaluationCraete;
        
        
        oppSS.stageName = 'Closed Won';
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id]; 
        
        oppSS.RecordtypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Grouped Flow').getRecordTypeId();
        update oppSS;
        
        oppSS = [SELECT Id, StageName,Name,end_user_ge_og__c,tier_2_ge_og__c,OwnerId,RecordtypeId,has_commercial_primary_resource_ge_og__c,tier_3_ge_og__c 
                 FROM Opportunity 
                 WHERE ID=:oppSS.Id];
        
        List<Opportunity> opptyLstNew = new List<Opportunity>{oppSS};
            Map<Id,Opportunity> mapOpptyNew = new Map<Id,Opportunity>{oppSS.Id => oppSS};
                
                
                GE_OG_eRad_Creation objErad = new GE_OG_eRad_Creation();
        objErad.onupdateradrecordcreation(opptyLstNew, mapOpptyNew, mapOpptyOld);
        objErad.compids = new Set<Id>();
        objErad.Profiles = new List<String>();
        objErad.executeboo = false;
        
        test.stopTest();
    }
}