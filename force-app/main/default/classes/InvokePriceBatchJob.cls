/*************************************************************************************************************************************************************
@ Class:          InvokePriceBatchJob
@ Version:        1.0
@ Author:         Raksha Shanbhag(raksha.shanbhag@bhge.com)
@ Purpose:        To invoke the batch job to to create price records and delete the price records.
/*************************************************************************************************************************************************************/


global with sharing class InvokePriceBatchJob{
   
  /*@methodName- ExecutePriceBatchJob
  *@description- Method to call the Batch class to create price records.
  *@param- null
  *@return- batch Id
  */
   WebService static string ExecutePriceBatchJob(){
        GE_Price_Batch b = new GE_Price_Batch();
        ID batchprocessid=Database.executeBatch(b,1); 
        return batchprocessid;
   }
   
   
  /*@methodName- deleteAssociateRecord
  *@description- Method to delete price records.
  *@param- recId
  *@return- Success Message
  */
   
   WebService static string deleteAssociateRecord(Id recId){
       List<pricebookentry> deletePriceBookEntry = new List<pricebookentry>();
       List<SVMXC__Service_Pricebook_Entry__c> deleteServicePriceBookEntry = new List<SVMXC__Service_Pricebook_Entry__c>();
       SVMXC__Activity_Product__c deleteActivityProduct = new SVMXC__Activity_Product__c();
       List<SVMX_MultiPricing__c> deleteMultiPricingList = new List<SVMX_MultiPricing__c>();
       String returnMessage;
       
       try{
           PriceStaging__c priceStaging = [Select id,Product_Type__c,Price_Book__c,Service_Pricebook__c,Product__c,Price_Deleted__c,CurrencyIsoCode from PriceStaging__c where Id =: recId];
           system.debug('-priceStaging -----'+priceStaging );
           String priceBookId;
           String servicePriceBookId;
           String productId = String.valueOf(priceStaging.Product__c).substring(0, 15);
           
           if(priceStaging.Product_Type__c == 'Parts' || priceStaging.Product_Type__c == 'Travel' || priceStaging.Product_Type__c == 'Expense'){
               priceBookId = String.valueOf(priceStaging.Price_Book__c).substring(0, 15);
               deletePriceBookEntry =[Select id from pricebookentry where pricebook2Id =: priceBookId and product2Id = :productId and CurrencyIsoCode =:priceStaging.CurrencyIsoCode limit 100];
           }
           else if(priceStaging.Product_Type__c == 'Labor'){
               servicePriceBookId = String.valueOf(priceStaging.Service_Pricebook__c).substring(0, 15);
               deleteServicePriceBookEntry =[Select id from SVMXC__Service_Pricebook_Entry__c where SVMXC__Price_Book__c =: servicePriceBookId and SVMXC__Product__c =:productId and CurrencyIsoCode =:priceStaging.CurrencyIsoCode limit 100];
           }
           
           deleteMultiPricingList = [Select id from SVMX_MultiPricing__c where (SVMX_Price_Book__c =:priceBookId or Service_Pricebook__c =:servicePriceBookId) and CurrencyIsoCode =: priceStaging.CurrencyIsoCode and SVMX_Product__c =:productId limit 100];
           
           system.debug('-deleteMultiPricingList---'+deleteMultiPricingList);
           system.debug('-deletePriceBookEntry ---'+deletePriceBookEntry );
           system.debug('-deleteServicePriceBookEntry---'+deleteServicePriceBookEntry);
                      
           if(deletePriceBookEntry.size()>0){
               Database.delete(deletePriceBookEntry);           
           }
           if(deleteServicePriceBookEntry.size()>0){
               Database.delete(deleteServicePriceBookEntry);
           }
           if(deleteMultiPricingList.size()>0){
               Database.delete(deleteMultiPricingList);
           }
           
           priceStaging.Price_Deleted__c = true;
           database.update(priceStaging);
           returnMessage = 'Records are deleted successfully';
           
       }catch(Exception ex){
           returnMessage = ex.getMessage();
           System.debug('Exception in class InvokePriceBatchJob and Method Name deleteAssociateRecord'+returnMessage);
       }
       
       return returnMessage;
        
   }
}