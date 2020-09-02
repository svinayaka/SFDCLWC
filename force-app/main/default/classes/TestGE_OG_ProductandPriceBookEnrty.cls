@isTest
private class TestGE_OG_ProductandPriceBookEnrty{

    static testMethod void testMCSProductInsert() {
        try{
             Product2 ptest=new Product2();
             ptest.Name='test Product';
             ptest.IsActive=TRUE;
             ptest.GE_ES_P_L__c='MCS';
             ptest.GE_ES_Sub_P_L__c=null;
     
             insert ptest;
            
            ptest.Name='test Product1';
            update ptest;
            
            delete ptest;
             
        }catch (exception e){
            throw e;
       }
       
    }
    
    
}