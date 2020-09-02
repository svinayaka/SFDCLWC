@isTest
public class GE_OG_ProductAndPriceBookEnrty_Test {
    @isTest public static void TestProduct2(){
        //Test.startTest();
        Account a = CommonTestDataFactory_GE_OG.createAccount('BugTest');
       // insert a;
        
        Opportunity o = CommonTestDataFactory_GE_OG.createOppty('Test', a.id);
       // insert o;
        
        Product2 deactTest = CommonTestDataFactory_GE_OG.createProduct('deactivate');
        PricebookEntry test1 = CommonTestDataFactory_GE_OG.createPriceBookEntry(deactTest);
            //createPriceBookEntry('product1');
     //  insert deactTest;
        
        Test.startTest();
        upsert deactTest; 
     upsert test1;
        Test.stopTest();
        
        
    }    
     @isTest public static void TestProduct3(){
        //Test.startTest();
        Account a = CommonTestDataFactory_GE_OG.createAccount('BugTest');
       // insert a;
        
        Opportunity o = CommonTestDataFactory_GE_OG.createOppty('Test', a.id);
       // insert o;
        
        Product2 deactTest = CommonTestDataFactory_GE_OG.createProduct('deactivate');
        PricebookEntry test1 = CommonTestDataFactory_GE_OG.createPriceBookEntry(deactTest);
            //createPriceBookEntry('product1');
     //  insert deactTest;
        
        Test.startTest();
       delete deactTest; 
     //delete test1;
        Test.stopTest();
}
}