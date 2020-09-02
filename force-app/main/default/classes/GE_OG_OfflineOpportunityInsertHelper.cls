/*Class/Trigger Name     : OpportunityTriggerHandler_GE_OG
  Used Where ?           : OpportunityTrigger_GE_OG
  Purpose/Overview       : Helper Class for Trigger on Opportunity
  Requirement Number     : R-24778
  Test Class Name        : GE_OG_OfflineOpptyInsertHelper_Test
  Updated on             : 23rd April 2019
  Updated By             : Shiv Pratap Singh Bhadauria for Requirement R-31943
*/

    public with sharing class GE_OG_OfflineOpportunityInsertHelper{
        @future
        public static void InsertOfflineOpportunity(set<Id> newOpptySet){
            Id OpptyRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
            Id offOpptyRecordTypeId = Schema.SObjectType.Custom_Opportunity__c.getRecordTypeInfosByName().get('O&G').getRecordTypeId();                                        
            List<Opportunity> newOpptyList = new  List<Opportunity>(); 
            List<OpportunityLineItem> opportunityProductList = new  List<OpportunityLineItem>();            
            List<Custom_Opportunity__c> opptyMaxInsertOrUpdateList = new List<Custom_Opportunity__c>();      
            List<Custom_Opportunity__c> opptyMaxUpdateList = new List<Custom_Opportunity__c>();                  
            List<Opportunity_to_OpptyMax__mdt> opptyMaxMappingFieldList = new  List<Opportunity_to_OpptyMax__mdt>() ; 
            List<Opportunity_to_OpptyMax__mdt> opptyMaxOliMappingFieldList = new  List<Opportunity_to_OpptyMax__mdt>() ; 
            List<GE_OG_Forecast_ServiceProduct__c> opptyMaxProductsInsertOrUpdateList = new List<GE_OG_Forecast_ServiceProduct__c>();                                   
            Map<String,Decimal> isoWithRateMap = new Map<String, Decimal>();  
            Map<Id,Id> opptymaxWithOpptyMap = new Map<Id, Id>();
            Set<Id> insertedOpptymaxId = new Set<Id>() ;
            Set<String> unipueOpptyFieldSet = new Set<String>() ;
            Database.UpsertResult [] upsertState ;            
            String opportunityQuery = '', oliQuery = '', opportunityFieldList = 'CurrencyIsoCode, ',oliFieldList = 'Product2.Field_Service__c, OpportunityId, Product2.Name, Opportunity.CurrencyIsoCode, '  ;   
            
            for(Opportunity_to_OpptyMax__mdt metaDataRecords : [SELECT 
                                                                      Label,Type__c,OpptyMax_Field__c ,
                                                                      Forecast_Service_Product__c,
                                                                      Opportunity_Line_Item__c,Opportunity_Field__c
                                                                      FROM Opportunity_to_OpptyMax__mdt  
                                                                      WHERE ( Type__c = 'OpptyMax Opportunity'  OR Type__c = 'OpptyMax LineItem' )
                                                                      AND Active__c  = true]){
                if(metaDataRecords.Type__c == 'OpptyMax Opportunity'){
                    opptyMaxMappingFieldList.add(metaDataRecords);
                }  
                
                if(metaDataRecords.Type__c == 'OpptyMax LineItem'){
                    opptyMaxOliMappingFieldList.add(metaDataRecords);
                }               
                                 
            }
            
            for(Opportunity_to_OpptyMax__mdt opptyFieldList : opptyMaxMappingFieldList){
                unipueOpptyFieldSet.add(opptyFieldList.Opportunity_Field__c) ;                
            }
            
            for(String str : unipueOpptyFieldSet ){
                opportunityFieldList += str + ', ' ; 
            }   
            
            for(Opportunity_to_OpptyMax__mdt oliFields : opptyMaxOliMappingFieldList){
                oliFieldList += oliFields.Opportunity_Line_Item__c + ', ' ;
            } 
            
            opportunityFieldList = opportunityFieldList.removeEnd(', ') ; // Generating the field list to query 
            opportunityQuery = 'SELECT '+ opportunityFieldList + ' FROM Opportunity WHERE ID IN : newOpptySet ' ;   
            
            system.debug('Opportunity Query string is ' + opportunityQuery ) ;
            
            oliFieldList = oliFieldList.removeEnd(', ') ; // Generating the field list to query Opportunity Product 
            oliQuery = 'SELECT ' +  oliFieldList + ' FROM OpportunityLineItem WHERE OpportunityId in : newOpptySet AND Product2.Field_Service__c = TRUE '  ;
            
            for(Opportunity opp : Database.query(opportunityQuery)) {
                newOpptyList.add(opp) ;
            }   
            
            System.debug('Opportunity Record' + newOpptyList )  ;  
            
            for(OpportunityLineItem olirecord : Database.query(oliQuery)) {
                opportunityProductList.add(olirecord) ;
            }  
            
            System.debug('Opportunity Product Record' + opportunityProductList )  ;        
            
            //Below List and Map is to collect the Currency ISoCode and conversion Rates
            for(CurrencyType currType : [SELECT Id,
                                                IsoCode,
                                                ConversionRate 
                                                FROM CurrencyType 
                                                WHERE isActive = True]){
                isoWithRateMap.put(currType.IsoCode,currType.ConversionRate);
            }    
                
            for(Opportunity oppty : newOpptyList){        
                     Custom_Opportunity__c customOpportunityToInsertOrUpdate = new  Custom_Opportunity__c();
                     customOpportunityToInsertOrUpdate.Name = oppty.Name.length() < 80 ? oppty.Name : oppty.Name.SubString(0,79) ;  //Added as part of Bug 0000024657
                     customOpportunityToInsertOrUpdate.RecordTypeId = offOpptyRecordTypeId  ;                     
                     customOpportunityToInsertOrUpdate.GE_OG_Amount__c = (oppty.CurrencyIsoCode != 'USD' && isoWithRateMap.containsKey(oppty.CurrencyIsoCode) && oppty.amount_ge_og__c != null) ?  
                                                                                                                      (oppty.amount_ge_og__c / isoWithRateMap.get(oppty.CurrencyIsoCode)).setScale(2) : oppty.amount_ge_og__c ; //Converting into USD Currency
                     for(Integer i=0 ; i < opptyMaxMappingFieldList.size() ; i++){ 
                         String targetField = String.valueOf(opptyMaxMappingFieldList.get(i).OpptyMax_Field__c);
                         String sourceField = String.ValueOf(opptyMaxMappingFieldList.get(i).Opportunity_Field__c);
                         if(oppty.get(sourceField) != null && oppty.get(sourceField) != ''){                       
                             customOpportunityToInsertOrUpdate.put(targetField,oppty.get(sourceField)); 
                         }                                                                  
                     }
    
                     system.debug('Inside Opptymax insertion block') ;
                     opptyMaxInsertOrUpdateList.add(customOpportunityToInsertOrUpdate) ;      
            }           
            
            system.debug('Opptymax Record to insert or update ' + opptyMaxInsertOrUpdateList) ;
            Schema.SObjectField ftoken = Custom_Opportunity__c.Fields.GE_OG_Opportunity_Number__c;
            
            if(opptyMaxInsertOrUpdateList.size() > 0 && opptyMaxInsertOrUpdateList != null){
                try{ 
                      upsertState = database.upsert(opptyMaxInsertOrUpdateList,ftoken, false); 
                      for(Database.UpsertResult sr : upsertState)  {
                           if(sr.isSuccess() == True ){
                                 insertedOpptymaxId.add(sr.getId()) ;
                                 system.debug('Record successfully got inserted' + sr.getId());
                           }else{
                                 system.debug('System encountered an issue while performing DML operation' + sr.getErrors());
                           }                           
                      } 
                              
                }catch(DMLException e){
                       System.Debug('There is an issue in the insertion/updation of opptymax records in the database') ;
                }      
            }
            
            for(Custom_Opportunity__c insertedOpptymax : [SELECT Id,
                                                                                                         GE_OG_Standard_Oppty__c
                                                                                                         FROM Custom_Opportunity__c 
                                                                                                         WHERE Id IN : insertedOpptymaxId]) {
                     opptymaxWithOpptyMap.put(insertedOpptymax.GE_OG_Standard_Oppty__c , insertedOpptymax.Id) ;                                                                                    
            }  
                                  
            for(OpportunityLineItem opportunityProductRecords  :opportunityProductList ){                                         
                    if(opptymaxWithOpptyMap.containsKey(opportunityProductRecords.OpportunityId)){
                        GE_OG_Forecast_ServiceProduct__c opptyMaxOLIToInsertOrUpdate = new GE_OG_Forecast_ServiceProduct__c();
                        for(Integer i = 0; i < opptyMaxOliMappingFieldList.size() ; i++){
                            String targetField = String.valueOf(opptyMaxOliMappingFieldList.get(i).Forecast_Service_Product__c);
                            String sourceField = String.ValueOf(opptyMaxOliMappingFieldList.get(i).Opportunity_Line_Item__c);
                            if(opportunityProductRecords.get(sourceField) != null && opportunityProductRecords.get(sourceField) != ''){
                               opptyMaxOLIToInsertOrUpdate.put(targetField,opportunityProductRecords.get(sourceField)) ;
                            }    
                        }
                        opptyMaxOLIToInsertOrUpdate.GE_OG_Product_Name__c = opportunityProductRecords.Product2.Name ;
                        opptyMaxOLIToInsertOrUpdate.GE_OG_Offline_Opportunities__c =opptymaxWithOpptyMap.get(opportunityProductRecords.OpportunityId);
                        opptyMaxOLIToInsertOrUpdate.GE_OG_Sales_Price__c = (opportunityProductRecords.Opportunity.CurrencyIsoCode != 'USD' && isoWithRateMap.containsKey(opportunityProductRecords.Opportunity.CurrencyIsoCode) && opportunityProductRecords.UnitPrice != null) ?
                                                                                                                       opportunityProductRecords.UnitPrice / isoWithRateMap.get(opportunityProductRecords.Opportunity.CurrencyIsoCode).setScale(2) : opportunityProductRecords.UnitPrice ; 
                                                                                                                                      
                        system.debug('Insertion/updation of opptymax OLI Block') ;
                        opptyMaxProductsInsertOrUpdateList.add(opptyMaxOLIToInsertOrUpdate) ;
                    }                       
            }
          
           Schema.SObjectField opptyProductToken = GE_OG_Forecast_ServiceProduct__c.Fields.GE_OG_StandardOpptyProductID__c ;
            if(opptyMaxProductsInsertOrUpdateList.size() > 0 )
            {
             
             Database.upsert(opptyMaxProductsInsertOrUpdateList,opptyProductToken,false) ;
             system.debug('****OfflineProductInserted*****'+opptyMaxProductsInsertOrUpdateList);
             
            }      
                                                    
        }// End of method InsertOfflineOpportunity        
                
        @future
        public static void deleteOpptyMaxProductLine(Set<Id> OliIdSet){
            List<GE_OG_Forecast_ServiceProduct__c> opptyMaxProductsDeleteList = new List<GE_OG_Forecast_ServiceProduct__c>();
            for(GE_OG_Forecast_ServiceProduct__c opptyMaxOliToDelete : [SELECT
                                                                              Id,Name
                                                                              FROM GE_OG_Forecast_ServiceProduct__c
                                                                              WHERE GE_OG_StandardOpptyProductID__c IN : OliIdSet]){
                if(opptyMaxOliToDelete != null){
                    opptyMaxProductsDeleteList.add(opptyMaxOliToDelete) ;
                }                                                               
            }
            
            if(opptyMaxProductsDeleteList.size() > 0){            
               try{     
                   database.delete(opptyMaxProductsDeleteList, false);  
                   System.Debug('There is no issue in the deletion of opptymax Product records in the database') ; 
               }catch (DMLException e) { 
                   System.Debug('There is an issue in the deletion of opptymax Product records in the database') ;
               }
            }             
        }//End of method deleteOpptyMaxProductLine
       
  } // End of apex class GE_OG_OfflineOpportunityInsertHelper