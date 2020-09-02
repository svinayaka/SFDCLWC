@isTest
global class MultiPricingeEntryBatch_Test{
public static  testmethod  void MultiPricingEntryBatchMethod(){


    Product2 pd=new Product2();
    pd.name='Test product';
    pd.ProductCode='1234';
    pd.Description='Test description';
    pd.IsActive = true;
    pd.CurrencyIsoCode='MXN';
    insert pd;

    ID standardPBID = Test.getStandardPricebookId();


    pricebook2 pb2=new pricebook2();
    pb2.name='test';
    pb2.IsActive = true;
    pb2.CurrencyIsoCode='MXN';
    insert pb2;



    list<PricebookEntry > prbookEntryList=new list<PricebookEntry>();
    PricebookEntry prbookEntry=new PricebookEntry();

    prbookEntry.UseStandardPrice=false;
    //prbookEntry.StandardPrice=1.02;
    prbookEntry.CurrencyIsoCode='MXN';
    //prbookEntry.ProductCode=1234;
    prbookEntry.Product2Id=pd.id;
    prbookEntry.Pricebook2Id=standardPBID;
    prbookEntry.isActive=true;
    prbookEntry.UnitPrice=1.02;
    prbookEntryList.add(prbookEntry);
    insert prbookEntryList;

    SVMX_MultiPricing__c nmultiObj = new SVMX_MultiPricing__c();
    list<SVMX_MultiPricing__c> nmultiObj1 = new list<SVMX_MultiPricing__c>();

    //nmultiObj.List_price__c= pbEntry.UnitPrice;
    nmultiObj.SVMX_Price_Book__c = prbookEntry.pricebook2id;
    nmultiObj.SVMX_Product__c = prbookEntry.Product2Id;
    //nmultiObj.Product_code__c=pbEntry.ProductCode;
    insert nmultiObj;
    //multiObjListToInsert.add(nmultiObj);
    prbookEntry.MultiPricingExisted__c = true;
    //pricebookEntryToUpdate.add(pbEntry);

    Test.starttest();
    MultiPricingEntryBatch mpse=new MultiPricingEntryBatch();

    Database.QueryLocator ql = mpse.start(null);
    mpse.execute(null,prbookEntryList);
    mpse.Finish(null);
    //database.executebatch(mpse);
    Test.stoptest();
}
}