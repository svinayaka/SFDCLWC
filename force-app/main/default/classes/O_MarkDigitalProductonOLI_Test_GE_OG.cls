/*
Class                  : O_MarkDigitalProductonOLI_Test_GE_OG
Used Where ?           : Used to test the coverage of O_MarkDigitalProductOnOLIFalse_GE_OG class
Scrum Team             : Opportunity Management
Requirement Number     : R-29717
Author                 : Rupal Seth
Created Date           : 21/MAY/2018
*/

@isTest

public class O_MarkDigitalProductonOLI_Test_GE_OG {
Public static Product2 digprod {
        get;
        set;
    }
    Public static Product2 prod {
        get;
        set;
    }
    Public static PricebookEntry pbEntry {
        get;
        set;
    }
    Public static PricebookEntry digpbEntry {
        get;
        set;
    }
    Public static OpportunityLineItem oli {
        get;
        set;
    }
    Public static OpportunityLineItem digoli {
        get;
        set;
    }
    Public static Opportunity oppty {
        get;
        set;
    }
    Public static Account acc {
        get;
        set;
    }
    public static void init() {
        digprod = new Product2();
        digprod = CommonTestDataFactory_GE_OG.createDigitalProduct('TestDigitalProduct');
        
        prod = new Product2();
        prod = CommonTestDataFactory_GE_OG.createProduct('TestnonDigitalProduct');

        pbEntry = new PricebookEntry();
        pbEntry = CommonTestDataFactory_GE_OG.createPriceBookEntry(prod);
        
        digpbEntry = new PricebookEntry();
        digpbEntry = CommonTestDataFactory_GE_OG.createPriceBookEntry(digprod);
        
        acc = new Account();
        acc = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccount');
        
        oppty = new Opportunity();
        oppty = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.Id);

        oli = new OpportunityLineItem();
        oli = CommonTestDataFactory_GE_OG.createOpportunityLineItem(oppty, pbEntry);
        
        digoli = new OpportunityLineItem();
        digoli = CommonTestDataFactory_GE_OG.createOpportunityLineItem(oppty, digpbEntry);
    }
    
    public static testMethod void testProdDigFlag(){
        init();
        Test.startTest();
        digprod.digital_ge_og__c = false;
        update digprod;
        Test.stopTest();
        
    }
    public static testMethod void testProdnonDigFlag(){
        init();
        Test.startTest();
        prod.digital_ge_og__c = true;
        update prod;
        Test.stopTest();
        
    }
     //Method for checking the code coverage of class : 'OpportunityStagesAutomationHandler_GE_OG'
   /* public static testMethod void testProductDigitalFlag(){
        
        O_MarkDigitalProductOnOLIFalse_GE_OG markdigitalflag = new O_MarkDigitalProductOnOLIFalse_GE_OG();
        User u = [Select Id from User where Profile.name ='System Administrator' and isActive= true limit 1];
        
        Test.startTest(); 
            //Creating new accounts
            Account acc1 = CommonTestDataFactory_GE_OG.createAccount('Test AccountTest');
        
            //creating new opportuntiy
            opportunity oppty = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc1.id);
                         
            //Create Product
            Product2 product = new Product2();
            product.name = 'Test Product1';
            product.GE_Tier2_PnL__c = 'Digital Solutions';
            product.GE_Tier3_PnL__c = 'Digital';
            product.IsActive = True;
            product.digital_ge_og__c = true;
            insert product; 
            
            product.digital_ge_og__c = false;
            system.runAs(u){
            update product; 
        }
        
            
            List<Product2> prodIds = new List<Product2>();
            prodIds.add(product);
        
            //Product2 product2 = CommonTestDataFactory_GE_OG.createProduct('Test Prod2');
            //List<Product2> prodIds1 = new List<Product2>();
            //prodIds1.add(product);
        
            Map<Id,Product2> oldmapProdIds = new Map<Id,Product2>();
            oldmapProdIds.putAll(prodIds);
        
            
            //Create Price Book Entry
            PriceBookEntry prBook1= CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
        
            
            //Craete oppty Product
            OpportunityLineItem oti1 = CommonTestDataFactory_GE_OG.createOpportunityLineItem(oppty,prBook1);
            
            //markdigitalflag.afterUpdateHandler(prodIds,oldmapProdIds);
            Test.stopTest(); 
    }*/
    /*public static testMethod void testProductDigitalFlag2(){
        
        O_MarkDigitalProductOnOLIFalse_GE_OG markdigitalflag = new O_MarkDigitalProductOnOLIFalse_GE_OG();
        
        Test.startTest(); 
            //Creating new accounts
            Account acc1 = CommonTestDataFactory_GE_OG.createAccount('Test AccountTest');
        
            //creating new opportuntiy
            opportunity oppty = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc1.id);
                         
            //Create Product
             //Create Product
            Product2 product = new Product2();
            product.name = 'Test Product2';
            product.GE_Tier2_PnL__c = 'Digital Solutions';
            product.GE_Tier3_PnL__c = 'Digital';
            product.IsActive = True;
            product.digital_ge_og__c = false;
            insert product; 
            
            product.digital_ge_og__c = true;
            update product;
            
            List<Product2> prodIds = new List<Product2>();
            prodIds.add(product);
        
            //Product2 product2 = CommonTestDataFactory_GE_OG.createProduct('Test Prod2');
            //List<Product2> prodIds1 = new List<Product2>();
            //prodIds1.add(product);
        
            Map<Id,Product2> oldmapProdIds = new Map<Id,Product2>();
            oldmapProdIds.putAll(prodIds);
        
            
            //Create Price Book Entry
            PriceBookEntry prBook1= CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
            
            //Craete oppty Product
            OpportunityLineItem objOppline=CommonTestDataFactory_GE_OG.createOpportunityLineItem(oppty, prBook1);
            //markdigitalflag.afterUpdateHandler(prodIds,oldmapProdIds);
            Test.stopTest(); 
    }*/
 
 
}