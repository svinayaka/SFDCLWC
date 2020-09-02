/*
Class/Trigger Name     : MMIDemandWebService_Test
Purpose/Overview       : Test Class to calculate the code coverage for the MMIDemandWebService Class 
Scrum Team             : GRID
Author                 : Sonali Rathore
Created Date           : 04-Jul-2018
Used For               : MMIDemandWebService 
*/ 

@isTest

public class MMIDemandWebService_Test {
    
    static testMethod void testMethod1(){
       
        // Create Member Account
       account acc = new account();
        acc.name = 'Test Acc';
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.ShippingCountry = 'India';
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Region_GEOG__c = 'India';
        acc.Type = 'Direct Customer';
        acc.Classification__c = 'Strategic';
        insert acc;
               
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting3();
        
        Product2 Product= CommonTestDataFactory_GE_OG.createProduct('Product','Oil Field Services');

        
        PriceBookEntry Pricebook = CommonTestDataFactory_GE_OG.createPriceBookEntry(Product);

        MMI_Product_Mapping_ge_og__c custMeta=new MMI_Product_Mapping_ge_og__c();
        custMeta.Name='Test Data';
        custMeta.Tier_2__c='OilFieldServices';
        custMeta.Tier_3__c='PressurePumping';
        custMeta.Tier_4__c='CoiledTubing';
        custMeta.TierKey__c='OilFieldServicesPressurePumpingCoiledTubing';
        custMeta.ProductId__c=Product.Id;
        insert custMeta;
        
        //Creating an Opportunity
        opportunity opp = new opportunity();
        opp.name= 'Test Oppty';
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = acc.Id;
        opp.tier_2_ge_og__c ='Oil Field Services';
        opp.tier_3_ge_og__c ='Chemicals';
        opp.amount_ge_og__c =100.00;
        opp.install_country_ge_og__c= 'India'; 
        opp.MMI_Demand_Key_ge_og__c ='aAw0t0000004DzjCAE';      
        insert opp;
        
        
        
        
        
        String jsonstr='{"DemandList":[{"operations":"Link","MMIDemandKey":"aAw0t0000004DzjCAE","OpportunityID":"'+opp.id+'","lineItems":[{"Tierkey":"OilFieldServicesPressurePumpingCoiledTubing","Amount":10},{"Tierkey":"OilFieldServicesChemicalsAquaness","Amount":5}]}]}';  
        
        MMIDemandWebService.parse(jsonstr);
        
        String jsonstr1='{"DemandList":[{"operations":"UnLink","MMIDemandKey":"aAw0t0000004DzjCAE","OpportunityID":"'+opp.id+'","lineItems":[{"Tierkey":"OilFieldServicesPressurePumpingCoiledTubing","Amount":10},{"Tierkey":"OilFieldServicesChemicalsAquaness","Amount":5}]}]}';  
       
        MMIDemandWebService.parse(jsonstr1);
     }
}