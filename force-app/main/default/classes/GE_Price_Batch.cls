global class GE_Price_Batch implements Database.Batchable<sObject> {
    Id StandardPriceBookId = '01sA0000000QYqf';
    Id PrdServiceMaxRecordTypeId = '01212000000VooH';
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        DescribeSObjectResult describeResult = PriceStaging__c.getSObjectType().getDescribe();
        List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );
        String query = ' SELECT  ' +       String.join( fieldNames, ',' ) +    ' FROM PriceStaging__c where Processed__c = false' ;
        return Database.getQueryLocator(query); 
    }
    
    global void execute(Database.BatchableContext BC, List<Sobject> scope) {
        System.debug('Inside Execute');
        For(Sobject sObj : scope){
            system.debug('Pricing Record' + sObj);
            
            PriceStaging__c prc =  (PriceStaging__c)sObj ;
            Product2 prd = null;
            Pricebook2 pb = null;
            PricebookEntry pbe = null;
            PricebookEntry pbeStd = null;
            
            Id prdId = null;
            Id pricebookId = null;
            Id pricebookEntryId = null;
            
            Decimal rate = null;
            rate = prc.Rate__c;
            String rateUnit = null; 
            rateUnit = prc.Rate_Unit__c;
            String ErrorMessage = null;
            String CurrencyCode = prc.currencyIsoCode;
            
            
            List<Product2> prdList = [Select Id from product2 where ProductCode = :prc.Product_Code__c and Description = :prc.Product_Description__c limit 1];
            if(prdList.size() == 0)
                prd = New Product2(RecordTypeId=PrdServiceMaxRecordTypeId, SVMXC__Product_Type__c=prc.product_type__c, ProductCode=prc.Product_Code__c,Description=prc.Product_Description__c, Name=prc.product_name__c, IsActive=true, GE_Tier1_PnL__c=prc.tier_1__c,GE_Tier2_PnL__c=prc.tier_2__c,GE_Tier3_PnL__c=prc.tier_3__c);
            else
                prdId = prdList[0].Id;
            
            if(prd != null){
                Database.SaveResult prdSR = Database.insert(prd);
                if (prdSR.isSuccess()) {
                    prdId = prdSR.getId();
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : prdSR.getErrors()) {
                        ErrorMessage = ErrorMessage + err.getMessage();                   
                    }
                }
            }
            if(prdId != null)
                prc.Product__c = prdId;
            System.debug('prc.Product_Type__c,rate-------'+prc.Product_Type__c+'rate'+rate);
            if((prc.Product_Type__c == 'Parts' && rate != null) || prc.Product_Type__c == 'Travel' || prc.Product_Type__c == 'Expense' ){
                if(rate == null)    rate = 0;
                pricebookId = prc.Price_Book__c;            
                List<PriceBookEntry> pbeList = [Select Id from pricebookentry where pricebook2Id =:pricebookId and product2Id=:prdId and CurrencyIsoCode=:prc.CurrencyIsoCode limit 1];
                
                if(pbeList.size()==0){
                    
                    List<PriceBookEntry> pbeStdList = [Select Id from pricebookentry where pricebook2Id =:StandardPriceBookId and product2Id=:prdId and CurrencyIsoCode=:prc.CurrencyIsoCode limit 1];
                    if(pbeStdList.size()==0){
                        //Insert Standard Price
                        pbeStd = New pricebookentry(pricebook2Id=StandardPriceBookId, product2Id=prdId, IsActive = true, UnitPrice =rate , CurrencyIsoCode=prc.CurrencyIsoCode);
                        if(pbeStd != null){
                            Database.SaveResult pbeStdSR = Database.insert(pbeStd);
                            if (pbeStdSR.isSuccess()) {
                                //prdId = pbeStdSR.getId();
                                system.debug('Standard PriceBookEntry Id: ' + pbeStdSR.getId());
                            }
                            else {             
                                for(Database.Error err : pbeStdSR.getErrors()) {
                                    ErrorMessage = ErrorMessage + err.getMessage();                   
                                }
                            }
                        }
                    }
                    
                    // Insert into Custom Pricebook
                    pbe = New pricebookentry(pricebook2Id=PriceBookId, product2Id=prdId, IsActive = true, UnitPrice =rate , CurrencyIsoCode=prc.CurrencyIsoCode);
                    if(pbe != null){
                        Database.SaveResult pbeSR = Database.insert(pbe);
                        if (pbeSR.isSuccess()) {
                            pricebookEntryId = pbeSR.getId();
                        }
                        else {             
                            for(Database.Error err : pbeSR.getErrors()) {
                                ErrorMessage = ErrorMessage + err.getMessage();                   
                            }
                        }
                    }
                }
                else{
                    pbeList[0].UnitPrice = rate;
                    database.update(pbeList);
                }
            }
            
            else if(prc.Product_Type__c == 'Labor' && rate != null){
                system.debug('----inside--');
                List<SVMXC__Activity_Product__c> activityProductList = new List<SVMXC__Activity_Product__c>();
                List<SVMXC__Service_Pricebook_Entry__c> servicePriceBookEntryList =  new List<SVMXC__Service_Pricebook_Entry__c>();
                SVMXC__Service_Pricebook__c servicePriceBook;
                
                pricebookId = prc.Service_Pricebook__c;
                
                //Map<Id,List<SVMXC__Activity_Product__c>> activityMasterList = [Select Id,(Select Id From SVMXC__Activity_Products__r limit 1)from SVMXC__Activity_Master__c];
                List<SVMXC__Activity_Master__c> activityMasterList = [Select Id,(Select Id From SVMXC__Activity_Products__r where SVMXC__Product__c = :prdId limit 1)from SVMXC__Activity_Master__c];
                system.debug('-activityMasterList----'+activityMasterList); 
                Map<ID,SVMXC__Activity_Product__c> apRecordMap = new Map<ID,SVMXC__Activity_Product__c>();     
                for(SVMXC__Activity_Master__c activityMaster : activityMasterList) {
                    if(activityMaster.SVMXC__Activity_Products__r.size() > 0){
                        apRecordMap.put(activityMaster.Id,activityMaster.SVMXC__Activity_Products__r[0]);
                        system.debug('---activityMaster.SVMXC__Activity_Products__r[0]---'+activityMaster.SVMXC__Activity_Products__r[0]);
                    }
                }
                if(activityMasterList.size() > 0){
                    
                    system.debug('-------');
                    for(SVMXC__Activity_Master__c amRecord : activityMasterList){
                        system.debug('----apRecordMap.get(amRecord.Id)--'+apRecordMap.get(amRecord.Id));
                        SVMXC__Activity_Product__c  activityProduct;
                        if(apRecordMap.get(amRecord.Id)==null){
                            activityProduct = new SVMXC__Activity_Product__c(SVMXC__Activity__c = amRecord.Id,SVMXC__Product__c = prdId);
                            activityProductList.add(activityProduct);
                        }else{
                            
                            List<SVMXC__Service_Pricebook_Entry__c> priceBookEntry = [Select Id From SVMXC__Service_Pricebook_Entry__c where SVMXC__Activity_Product__c = :apRecordMap.get(amRecord.Id).Id and SVMXC__Price_Book__c =:pricebookId limit 10];
                            system.debug('-priceBookEntry----'+priceBookEntry);
                            if(priceBookEntry.size() >0){
                                for(SVMXC__Service_Pricebook_Entry__c pbEntry:priceBookEntry){
                                    pbEntry.SVMXC__Regular_Rate__c = rate;
                                    pbEntry.SVMXC__Unit__c = rateUnit;
                                    servicePriceBookEntryList.add(pbEntry);
                                }
                            }
                            else{
                                SVMXC__Service_Pricebook_Entry__c servicePriceBookEntry = new SVMXC__Service_Pricebook_Entry__c(SVMXC__Activity_Product__c = apRecordMap.get(amRecord.Id).Id,SVMXC__Price_Book__c=pricebookId,SVMXC__Regular_Rate__c = rate,SVMXC__Unit__c = rateUnit, currencyIsoCode=CurrencyCode);
                                servicePriceBookEntryList.add(servicePriceBookEntry);
                            }
                        }
                        
                        
                    }
                    system.debug('--servicePriceBookEntryList-----'+servicePriceBookEntryList);
                    system.debug('---activityProductList--'+activityProductList);
                    if(activityProductList.size() > 0){
                        
                        Database.SaveResult[] activityProdSR = Database.insert(activityProductList);
                        system.debug('----product record list---'+activityProductList);
                        
                        for(Database.SaveResult sr: activityProdSR){
                            if (sr.isSuccess()) {
                                SVMXC__Service_Pricebook_Entry__c servicePriceBookEntry = new SVMXC__Service_Pricebook_Entry__c(SVMXC__Activity_Product__c = sr.getId(),SVMXC__Price_Book__c=pricebookId,SVMXC__Regular_Rate__c = rate,SVMXC__Unit__c = rateUnit, currencyIsoCode=CurrencyCode);
                                servicePriceBookEntryList.add(servicePriceBookEntry);
                            }
                            else{
                                //prc.Error_Message__c = 'Unable to process.Something went wrong';
                                for(Database.Error err : sr.getErrors()) {
                                    ErrorMessage = ErrorMessage + err.getMessage(); 
                                }
                            }
                        }
                    }
                    if(servicePriceBookEntryList.size() > 0){
                        Database.UpsertResult[] priceBookSR = Database.upsert(servicePriceBookEntryList);
                        system.debug('-----priceBookSR---'+priceBookSR);
                        for(Database.UpsertResult sr: priceBookSR){
                            if (!sr.isSuccess()) {
                                //prc.Error_Message__c = 'Unable to process.Something went wrong';
                                for(Database.Error err : sr.getErrors()) {
                                    ErrorMessage = ErrorMessage + err.getMessage(); 
                                }
                            }
                        }
                        system.debug('--price book entry---'+servicePriceBookEntryList.size());
                        system.debug('--price book entry---'+servicePriceBookEntryList);
                    }   
                    
                }
            }
            if(ErrorMessage != null && ErrorMessage.length() > 0)
                prc.error_message__c = ErrorMessage.left(250);
            prc.Processed__c = true;
            Database.update(prc);
        }    
    }
    
    global void finish(Database.BatchableContext BC) {
        MultiPricingEntryBatch b = new MultiPricingEntryBatch();
        ID batchprocessid=Database.executeBatch(b,200); 
    }
}