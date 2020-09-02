@isTest
public class eRADTriggerHandler_GE_OG_Test {
    static testMethod void calculateProductUnitsTest(){
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        //Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity', acc.Id);
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        
        Product2 prod = new Product2();
        prod.name = 'Power Plant - Maintenance - Long Term Agreements - CS ERP Data Migration - Long Cycle';
        prod.IsActive = true;
        prod.ProductCode = '567';
        prod.GE_Tier2_PnL__c = 'Digital Solutions';
        prod.GE_Tier3_PnL__c = 'Bently Nevada';
        prod.GE_OG_CM__c = 89;
        insert prod;
        
     	Opportunity Opp1 = new Opportunity();
        Opp1.tier_1_ge_og__c ='Oil & Gas';
        Opp1.tier_2_ge_og__c = 'Digital Solutions';
        Opp1.StageName ='Prospecting';
        Opp1.Name ='Unique Opp1';
        Opp1.CloseDate =Date.Today();
        Opp1.AccountID = acc.Id;
        Opp1.amount_ge_og__c = 1000;
        Opp1.tier_2_ge_og__c ='Digital Solutions';
        Opp1.tier_3_ge_og__c ='Bently Nevada';
        Opp1.Amount = 1000;
        //Opp1.install_country_ge_og__c= 'India';
        insert Opp1;
        
        PricebookEntry p = new PricebookEntry();        
        p.Product2Id = prod.Id;        
        p.Pricebook2Id = Test.getStandardPricebookId();        
        p.UnitPrice = 100;               
        p.IsActive = true;        
        insert p;  
        
        Opportunitylineitem optyline = new Opportunitylineitem();
        optyline.PricebookEntryId  = p.id;
        optyline.opportunityid = Opp1.id;
        optyline.UnitPrice = 100;
        optyline.uom_ge_og__c = 'Train';
        optyline.Quantity = 2;    
        optyline.of_Units_Text__c = '1';
        optyline.detail_ge_og__c = 1;
        insert optyline; 
        
        List<eRAD__c> er = new List<eRAD__c>();
        eRAD__c e = new eRAD__c();
        e.Opportunity__c = Opp1.Id;
        er.add(e);        
        
        Test.startTest();
        insert er;
        eRADTriggerHandler_GE_OG.calculateProductUnits(er);
        Test.stopTest();
    }
    
}