/*
Class/Trigger Name     : mark_ProductActive_ge_og_test
Used For               : mark_ProductActive_ge_og
Purpose/Overview       : Test Class to calculate the code coverage for the mark_ProductActive_ge_og Class 
Scrum Team             : Opportunity Management.
Requirement Number     : R-31551
Author                 : Harsha C
Created Date           : 20/MARCH/2019
*/
@istest
public class mark_ProductActive_ge_og_test {
    
    @testsetup
    static void createRecord()
    {
        //Creating new account
        account acc = CommonTestDataFactory_GE_OG.createRelationshipAccount('Test Account');
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        Product2 product = new Product2();
        product.name = 'Grv_productName';
        product.GE_Tier2_PnL__c = 'Digital Solutions';
        product.GE_Tier3_PnL__c = 'Bently Nevada';
        product.IsActive = true;
        insert product; 
        
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = product.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=opp.Id;
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=2;
        objOppline.UNITPRICE=30; 
        objOppline.GE_OG_SS_Oppty_Product_CM__c = 45;
        insert objOppline;
        
    }
    public static testMethod void testsubmitDealDesk()
    {
        test.startTest();
        Product2 pro = [Select Id,name,IsActive from Product2 Where Name='Grv_productName' limit 1];
        pro.IsActive = false;
        update pro;
        List<Product2> prodlist = new List<Product2>();
        prodlist.add(pro);
        mark_ProductActive_ge_og.markProductActiveOLI(prodlist);
        test.stopTest();
    }
}