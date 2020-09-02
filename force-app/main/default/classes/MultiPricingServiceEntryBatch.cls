global class MultiPricingServiceEntryBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {

        //datetime yesterdayDate = system.today();
        DescribeSObjectResult describeResult = SVMXC__Service_Pricebook_Entry__c.getSObjectType().getDescribe();
        List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );
        String query = ' SELECT  ' +       String.join( fieldNames, ',' ) +    ' FROM SVMXC__Service_Pricebook_Entry__c where MultiPricingExisted__c = false  and CreatedDate = today' ;
        system.debug('servicePriceBokkquery :'+query);
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC, List<SVMXC__Service_Pricebook_Entry__c> scope) {
        
       
        system.debug('scope ---:'+scope);
        List<SVMX_MultiPricing__c> multiObjListToInsert = new List<SVMX_MultiPricing__c>();
        List<SVMXC__Service_Pricebook_Entry__c> serpricebookEntryToUpdate = new List<SVMXC__Service_Pricebook_Entry__c>();
        for(SVMXC__Service_Pricebook_Entry__c serpbEntry : scope){
            if(serpbEntry.SVMXC__Price_Book__c != NULL){
                SVMX_MultiPricing__c nmultiObj = new SVMX_MultiPricing__c();
                //nmultiObj.List_price__c= serpbEntry.SVMXC__Regular_Rate__c;
                nmultiObj.Service_Pricebook__c= serpbEntry.SVMXC__Price_Book__c;
                nmultiObj.SVMX_Product__c = serpbEntry.SVMXC__Product__c;
                //nmultiObj.Product_code__c=serpbEntry.ProductCode;
                multiObjListToInsert.add(nmultiObj);
                serpbEntry.MultiPricingExisted__c = true;
                 system.debug('serpbEntry.MultiPricingExisted__c ---:'+serpbEntry.MultiPricingExisted__c);
                serpricebookEntryToUpdate.add(serpbEntry);
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
                
                try
                {
                //Database.INSERT(multiObjListToInsert,false);
                if(serpricebookEntryToUpdate.size() > 0){
                
                    Database.UPDATE(serpricebookEntryToUpdate);
                }
            }catch(Exception e) {
                System.debug(e);
            }
        }
    }   
     
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
  }
}