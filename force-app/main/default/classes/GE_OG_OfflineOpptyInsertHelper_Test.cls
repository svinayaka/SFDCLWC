@isTest(SeeAllData=true)
public class GE_OG_OfflineOpptyInsertHelper_Test{
    public static testMethod void testopptyupdate(){            
            Id prodRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Subsea & Drilling').getRecordTypeId();
            Id OpptyRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();           
            List<Opportunity> oldopptyi = new List<Opportunity>();  
            PriceBookEntry pbEntry ;       
            Opportunity oppty = [Select Id,
                                        Name,CloseDate,
                                        RecordTypeId,
                                        StageName 
                                        FROM Opportunity 
                                        WHERE RecordTypeId =: OpptyRecordTypeId AND 
                                        CurrencyIsoCode = 'USD'AND StageName = 'Bid In Submission' AND 
                                        tier_2_ge_og__c = 'Oil Field Equipment' AND tier_3_ge_og__c='Subsea Drilling Systems' LIMIT 1];   
            
            Product2 Prod = new Product2() ;       
            Prod.Name ='Drilling Test Offline Prod- Field Service';
            Prod.RecordTypeId = prodRecordTypeId ;
            Prod.GE_Tier1_PnL__c = 'Oil & Gas';
            Prod.GE_Tier2_PnL__c = 'Oil Field Equipment';
            Prod.GE_Tier3_PnL__c = 'Subsea Drilling Systems'; 
            Prod.Field_Service__c= TRUE;
            Prod.IsActive = True ; 
            insert Prod;
            
            PriceBook2 Pb2= new PriceBook2();
            PB2.Name = 'TestBook';
            PB2.IsActive= true;    
            insert Pb2;
            
            if(Pb2!=NULL){            
               Id pricebookId = Test.getStandardPricebookId();
               pbEntry = new PriceBookEntry( UnitPrice = 30,PriceBook2Id=pricebookId,Product2Id = Prod.Id,UseStandardPrice = false,IsActive = true);
               insert pbEntry ;  
            }        
            
           OpportunityLineItem oppLI =new OpportunityLineItem();
           oppLI.pricebookentryid= pbEntry.Id;
           oppLI.OpportunityId=oppty.Id;
           oppLI.Quantity = 1;
           oppLI.x1st_delivery_date_ge_og__c=Date.Today()+5;
           oppLI.GE_OG_SS_Oppty_Product_CM__c = 0;
           oppLI.UnitPrice = 100;
           
           Opportunity oppToUpdate = new Opportunity() ;
           oppToUpdate.Id = oppty.Id ; 
           oppToUpdate.StageName= 'Negotiating';
           oppToUpdate.delivery_date_ge_og__c=Date.Today();
           oppToUpdate.BID_DUE_DATE_GE_OG__C = Date.Today()+5;
           oppToUpdate.BID_SENT_DATE_GE_OG__C = Date.Today();
           
           OpportunityLineItem oppLI2 =new OpportunityLineItem();
           oppLI2.pricebookentryid= pbEntry.Id;
           oppLI2.OpportunityId=oppty.Id;
           oppLI2.Quantity = 5;
           oppLI2.x1st_delivery_date_ge_og__c=Date.Today()+5;
           oppLI2.GE_OG_SS_Oppty_Product_CM__c = 0;
           oppLI2.UnitPrice = 100;
                                                                  
           Test.startTest();           
               insert oppLI;          
               update oppToUpdate ;         
               insert oppLI2 ;                
           Test.stopTest();             
         } 
         
        public static testMethod void testopptyupdate1(){            
            Id prodRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Subsea & Drilling').getRecordTypeId();
            Id OpptyRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();           
            List<Opportunity> oldopptyi = new List<Opportunity>();  
            PriceBookEntry pbEntry ;       
            Opportunity oppty = [Select Id,
                                        Name,CloseDate,
                                        RecordTypeId,
                                        StageName 
                                        FROM Opportunity 
                                        WHERE RecordTypeId =: OpptyRecordTypeId AND 
                                        CurrencyIsoCode = 'USD'AND StageName = 'Bid In Submission' AND 
                                        tier_2_ge_og__c = 'Oil Field Equipment' AND tier_3_ge_og__c='Subsea Drilling Systems' LIMIT 1];   
            
            Product2 Prod = new Product2() ;       
            Prod.Name ='Drilling Test Offline Prod- Field Service';
            Prod.RecordTypeId = prodRecordTypeId ;
            Prod.GE_Tier1_PnL__c = 'Oil & Gas';
            Prod.GE_Tier2_PnL__c = 'Oil Field Equipment';
            Prod.GE_Tier3_PnL__c = 'Subsea Drilling Systems'; 
            Prod.Field_Service__c= TRUE;
            Prod.IsActive = True ; 
            insert Prod;
            
            PriceBook2 Pb2= new PriceBook2();
            PB2.Name = 'TestBook';
            PB2.IsActive= true;    
            insert Pb2;
            
            if(Pb2!=NULL){            
               Id pricebookId = Test.getStandardPricebookId();
               pbEntry = new PriceBookEntry( UnitPrice = 30,PriceBook2Id=pricebookId,Product2Id = Prod.Id,UseStandardPrice = false,IsActive = true);
               insert pbEntry ;  
            }        
            
           OpportunityLineItem oppLI =new OpportunityLineItem();
           oppLI.pricebookentryid= pbEntry.Id;
           oppLI.OpportunityId=oppty.Id;
           oppLI.Quantity = 1;
           oppLI.x1st_delivery_date_ge_og__c=Date.Today()+5;
           oppLI.GE_OG_SS_Oppty_Product_CM__c = 0;
           oppLI.UnitPrice = 100;
           
           Opportunity oppToUpdate = new Opportunity() ;
           oppToUpdate.Id = oppty.Id ; 
           oppToUpdate.StageName= 'Negotiating';
           oppToUpdate.delivery_date_ge_og__c=Date.Today();
           oppToUpdate.BID_DUE_DATE_GE_OG__C = Date.Today()+5;
           oppToUpdate.BID_SENT_DATE_GE_OG__C = Date.Today();
           
           OpportunityLineItem oppLI2 =new OpportunityLineItem();
           oppLI2.pricebookentryid= pbEntry.Id;
           oppLI2.OpportunityId=oppty.Id;
           oppLI2.Quantity = 5;
           oppLI2.x1st_delivery_date_ge_og__c=Date.Today()+5;
           oppLI2.GE_OG_SS_Oppty_Product_CM__c = 0;
           oppLI2.UnitPrice = 100;
                                                                  
           Test.startTest();                    
               insert oppLI2 ; 
               delete oppLI2 ; 
           Test.stopTest();             
         }               
 }