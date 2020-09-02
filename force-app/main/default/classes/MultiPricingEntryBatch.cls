global class MultiPricingEntryBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
          Id StandardPriceBookId = '01sA0000000QYqf';
        //datetime yesterdayDate = system.now().addDays(-1);
        DescribeSObjectResult describeResult = PricebookEntry.getSObjectType().getDescribe();
        List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );
        String query = ' SELECT  ' +       String.join( fieldNames, ',' ) +    ' FROM PricebookEntry where MultiPricingExisted__c = false AND createddate  =today and pricebook2Id != :StandardPriceBookId ' ;
        system.debug('query :'+query);
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC, List<PricebookEntry> scope) {
        
       
        system.debug('scope :'+scope);
        List<SVMX_MultiPricing__c> multiObjListToInsert = new List<SVMX_MultiPricing__c>();
        List<PricebookEntry> pricebookEntryToUpdate = new List<PricebookEntry>();
        for(PricebookEntry pbEntry : scope){
            if(pbEntry.pricebook2id != NULL){
                SVMX_MultiPricing__c nmultiObj = new SVMX_MultiPricing__c();
                //nmultiObj.List_price__c= pbEntry.UnitPrice;
                nmultiObj.SVMX_Price_Book__c = pbEntry.pricebook2id;
                nmultiObj.SVMX_Product__c = pbEntry.Product2Id;
                //nmultiObj.Product_code__c=pbEntry.ProductCode;
                multiObjListToInsert.add(nmultiObj);
                pbEntry.MultiPricingExisted__c = true;
                pricebookEntryToUpdate.add(pbEntry);
            }
        }
        system.debug('entred');
        if(multiObjListToInsert.size() > 0){
        
        Database.SaveResult[] sresultlist=Database.INSERT(multiObjListToInsert,false);
                for(Database.SaveResult sr:sresultlist){
                    
                    if(sr.isSuccess()){
                        
                        system.debug('SVMX MultiPricing record created successfully with the id:  ' +sr.getId());
                    }
                else{
                    for(database.Error err:sr.getErrors()){
                        system.debug('The following error has occured.');
                        system.debug(err.getStatusCode() +':'+err.getMessage());
                        system.debug('MultiPricing fields  that effected this error due to'+err.getFields());
                }
                }
                }
        
        
             try {
            // Database.INSERT(multiObjListToInsert,false);
               
                system.debug('multiObjListToInsert :'+multiObjListToInsert);
                if(pricebookEntryToUpdate.size() > 0){
                Database.UPDATE(pricebookEntryToUpdate,false);
                    
                }
            }catch(Exception e) {
                System.debug(e);
            }
        }
    }   
     
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
        MultiPricingServiceEntryBatch b = new MultiPricingServiceEntryBatch();
        ID batchprocessid=Database.executeBatch(b,200); 
  }
}