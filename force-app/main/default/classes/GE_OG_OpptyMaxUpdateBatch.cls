Global class GE_OG_OpptyMaxUpdateBatch implements Database.Batchable<sObject>
    {
            
      Id OpptyRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();    
            
      global Database.QueryLocator start(Database.BatchableContext BC)  
      {
           if(!test.isRunningtest()){
                   return Database.getQueryLocator([select Id,Name,GE_OG_Deal_Path__c ,GE_OG_Oppty_NotActive__c,GE_OG_Amount__c,GE_OG_Expected_Order_Date__c,GE_OG_Forecast__c,GE_OG_Customer_Name__c,GE_OG_PO__c,GE_OG_Region__c,
                GE_OG_Opportunity_Currency__c,GE_OG_Opportunity_Summary__c,GE_OG_Stage__c,GE_OG_Tier2_PnL__c,GE_OG_Standard_Oppty__c,
                GE_OG_Tier3_PnL__c,LastModifiedDate,Country__c from Custom_Opportunity__c where GE_OG_Oppty_NotActive__c = false AND GE_OG_Standard_Oppty__c!=null ]);
          
           }
           else{
          return Database.getQueryLocator([select Id,Name,GE_OG_Deal_Path__c ,GE_OG_Oppty_NotActive__c,GE_OG_Amount__c,GE_OG_Expected_Order_Date__c,GE_OG_Forecast__c,GE_OG_Customer_Name__c,GE_OG_PO__c,GE_OG_Region__c,
                GE_OG_Opportunity_Currency__c,GE_OG_Opportunity_Summary__c,GE_OG_Stage__c,GE_OG_Tier2_PnL__c,GE_OG_Standard_Oppty__c,
                GE_OG_Tier3_PnL__c,LastModifiedDate from Custom_Opportunity__c where GE_OG_Oppty_NotActive__c = false AND GE_OG_Standard_Oppty__c!=null Limit 50]);
          }
      }

      global void execute(Database.BatchableContext BC, List<Custom_Opportunity__c> scope) 
      {
        Set<Id> offopptyIdset = new set<Id>();
        Set<Id> opptyIdset = new set<Id>();
        List<Opportunity> updatedOpptyList = new List<Opportunity>(); 
        List<Custom_Opportunity__c> offlineOppty = new List<Custom_Opportunity__c>();
        List<Custom_Opportunity__c> offlineOpptyFList = new List<Custom_Opportunity__c>();
    
        List<OpportunityLineItem> opptyProductList = new  List<OpportunityLineItem>();
        
        List<GE_OG_Forecast_ServiceProduct__c> offlineProdFlist1 = new List<GE_OG_Forecast_ServiceProduct__c>();
        List<GE_OG_Forecast_ServiceProduct__c> offlineProdFlist2 = new List<GE_OG_Forecast_ServiceProduct__c>();
        List<GE_OG_Forecast_ServiceProduct__c> offlineProd = new List<GE_OG_Forecast_ServiceProduct__c>();
          
        for(Custom_Opportunity__c tempoppty : scope) 
        {
            offopptyIdset.add(tempoppty.Id);
            opptyIdset.add(tempoppty.GE_OG_Standard_Oppty__c);
          
        } 
        //added fields OwnerId,oppty_cm_ge_og__c  in the below query as part of R-29385
        updatedOpptyList=[Select Id,Name,amount_ge_og__c,delivery_date_ge_og__c,CloseDate,legal_entity_ge_og__c,ForecastCategoryName,CurrencyIsoCode,AccountId,po_number_ge_og__c,region_ge_og__c,opportunity_number_ge_og__c,
                tier_2_ge_og__c,tier_3_ge_og__c,deal_path_ge_og__c,LastModifiedDate,opportunity_summary_ge_og__c,OwnerId,oppty_cm_ge_og__c, RecordTypeId,StageName, install_country_ge_og__c from Opportunity 
                where Id in:opptyIdset];
        if(opptyIdset.size()>0)
        {
               List<CurrencyType> currencyTypeList = [select id,IsoCode,ConversionRate from CurrencyType where isActive = true] ;
        Map<String , Decimal> isoWithRateMap = new Map<String, Decimal>();
        for(CurrencyType c : currencyTypeList) 
        {
            isoWithRateMap.put(c.IsoCode , c.ConversionRate);
        }
                            
       opptyProductList =[Select Id,x1st_delivery_date_ge_og__c,Product2Id,Quantity,UnitPrice,OpportunityId, Product2.Name,Product2.Field_Service__c, Opportunity.CurrencyIsoCode,LastModifiedDate from OpportunityLineItem WHERE  OpportunityId in: opptyIdset AND Product2.Field_Service__c=TRUE ];
        for(Custom_Opportunity__c offoppty : scope)
        {
                        
        
            for(Opportunity oppty: updatedOpptyList)
            {
            
              integer Days = date.valueof(oppty.LastModifiedDate).daysBetween(Date.today());
              
              String opptyLastMDate =(oppty.LastModifiedDate).format('yyyy-MM-dd', (UserInfo.getTimeZone()).toString());
              String dateToday =(System.now()).format('yyyy-MM-dd', (UserInfo.getTimeZone()).toString());
              Datetime yestDay=Date.Today().addDays(-1);
              String dateyesterday =(yestDay).format('yyyy-MM-dd', (UserInfo.getTimeZone()).toString());
              if(offoppty.GE_OG_Standard_Oppty__c == oppty.Id)
              {
                
                    
                    if(dateToday==opptyLastMDate || opptyLastMDate==dateyesterday)
                    {
                                        
                    if((oppty.Name).length()>80){
                    offoppty.Name = oppty.Name.SubString(0,79);}
                    else
                    offoppty.Name = oppty.Name;
                    
                    offoppty.GE_OG_Customer_Name__c=oppty.AccountId;
                    offoppty.GE_OG_Forecast__c= oppty.ForecastCategoryName;
                    offoppty.GE_OG_Amount__c = oppty.amount_ge_og__c;
                    if(oppty.CurrencyIsoCode != 'USD' && isoWithRateMap.containsKey(oppty.CurrencyIsoCode))
                    {
                        if(oppty.amount_ge_og__c != null)
                        {
                            offoppty.GE_OG_Amount__c = (oppty.amount_ge_og__c / isoWithRateMap.get(oppty.CurrencyIsoCode)).setScale(2);
                        }
                    }
                    offoppty.Country__c= oppty.install_country_ge_og__c; //Added by NS
                    offoppty.GE_OG_LE_Account__c = oppty.legal_entity_ge_og__c;
                    offoppty.GE_OG_Expected_Order_Date__c = oppty.delivery_date_ge_og__c ;
                    offoppty.GE_OG_Opportunity_Number__c=oppty.opportunity_number_ge_og__c;
                    offoppty.GE_OG_Opportunity_Summary__c = oppty.opportunity_summary_ge_og__c ;
                    offoppty.GE_OG_PO__c = oppty.po_number_ge_og__c;
                    offoppty.GE_OG_Deal_Path__c = oppty.deal_path_ge_og__c;
                    offoppty.GE_OG_Region__c = oppty.region_ge_og__c;
                    offoppty.GE_OG_Stage__c = oppty.StageName ;
                    offoppty.GE_OG_Tier2_PnL__c = oppty.tier_2_ge_og__c ;
                    offoppty.GE_OG_Tier3_PnL__c = oppty.tier_3_ge_og__c ;                
                    offoppty.GE_OG_Standard_Oppty__c= oppty.Id; 
                    offoppty.GE_OG_CM__c = oppty.oppty_cm_ge_og__c; //Added as part of R-29385
                    }          
                    
                    if((oppty.StageName =='Closed Lost'||oppty.StageName =='Closed Won' || oppty.StageName=='Cancelled') && (Days>=14))
                     {  
                        
                         offoppty.GE_OG_Oppty_NotActive__c=True;
                      
                     }
                     offlineOpptyFList.add(offoppty);
                }
            }  
               
        }
      
        if(offlineOpptyFList.size()>0)
        {
        Update offlineOpptyFList;
       
        } 
        
        System.debug('Next Level');
        offlineProd= [Select Id, GE_OD_Delivery_Date__c,GE_OG_Offline_Opportunities__c,GE_OG_Product_Name__c,
        GE_OG_Quantity__c,GE_OG_Sales_Price__c,GE_OG_StandardOpptyProductID__c,GE_OG_Product__c from GE_OG_Forecast_ServiceProduct__c where GE_OG_Offline_Opportunities__c in: offopptyIdset ];
        System.debug('OPL'+offlineProd);
        System.debug('OPL List'+opptyProductList);
        List<GE_OG_Forecast_ServiceProduct__c> delforProd = new List<GE_OG_Forecast_ServiceProduct__c>();
        Map<Id,GE_OG_Forecast_ServiceProduct__c> offlineMap = new Map<Id,GE_OG_Forecast_ServiceProduct__c>();
        Map<Id,Id> offOpptyPIdMap = new Map<ID,ID>();
        for(Custom_Opportunity__c offoppty : scope)
        {
            for(GE_OG_Forecast_ServiceProduct__c cOpptyP : offlineProd)
            {
                offOpptyPIdMap.put(cOpptyP.GE_OG_StandardOpptyProductID__c,cOpptyP.Id);
                //offlineMap.put(offoppty.Id,delforProd.add(cOpptyP));
                offlineMap.put(offoppty.GE_OG_Standard_Oppty__c,cOpptyP);
            }  
        }
        
        List<OpportunityLineItem> oppProd = new List<OpportunityLineItem>();
        Map<Id,OpportunityLineItem> oppprodMap = new Map<Id,OpportunityLineItem>();
        Set<Id> oppLine = new set<id>();
        for(Opportunity stdoppty : updatedOpptyList)
        {
            for(OpportunityLineItem opptyProd : opptyProductList)
            {
            
                oppprodMap.put(stdoppty.Id,opptyProd);
                oppLine.add(opptyProd.Id);
                System.debug('Entered OP and OPL');
            }  
        }
        
        for(OpportunityLineItem oppPro :opptyProductList)
        {
              String opptyLastMDate =(oppPro.LastModifiedDate).format('yyyy-MM-dd', (UserInfo.getTimeZone()).toString());
              String dateToday =(System.now()).format('yyyy-MM-dd', (UserInfo.getTimeZone()).toString());
              Datetime yestDay=Date.Today().addDays(-1);
              String dateyesterday =(yestDay).format('yyyy-MM-dd', (UserInfo.getTimeZone()).toString());
        
            if(offOpptyPIdMap.containsKey(oppPro.Id))
            {
            System.debug('OffOppty entered If 1');             
            for(GE_OG_Forecast_ServiceProduct__c cOpptyP : offlineProd)
            {
                System.Debug('Entered For Loop Update');
               if(opptyLastMDate==dateToday || opptyLastMDate ==dateyesterday){
                  System.Debug('Entered For Loop Update');
                if(oppPro.Id==cOpptyP.GE_OG_StandardOpptyProductID__c)
                {
                    System.debug('OffOpptyL entered If 2');  
                    GE_OG_Forecast_ServiceProduct__c temp = new GE_OG_Forecast_ServiceProduct__c();
                    temp.Id=cOpptyP.Id;
                    temp.GE_OG_Quantity__c = oppPro.Quantity;
                    temp.GE_OG_Product_Name__c = oppPro.Product2.Name;
                    temp.GE_OD_Delivery_Date__c = oppPro.x1st_delivery_date_ge_og__c;
                    temp.GE_OG_Sales_Price__c = oppPro.UnitPrice;
                    
                 //Converting into USD Currency 
                    if(OppPro.Opportunity.CurrencyIsoCode != 'USD' && isoWithRateMap.containsKey(OppPro.Opportunity.CurrencyIsoCode))
                    {
                        if(OppPro.UnitPrice != null)
                        {
                            temp.GE_OG_Sales_Price__c = (OppPro.UnitPrice / isoWithRateMap.get(OppPro.Opportunity.CurrencyIsoCode)).setScale(2);
                        }
                    }
                        
                    temp.GE_OG_StandardOpptyProductID__c = oppPro.Id;
                    temp.GE_OG_Product__c = oppPro.Product2Id;
                    offlineProdFlist1.add(temp);
                    System.debug('Update Level'+offlineProdFlist1);
                    } 
                }
            }
           
            }
        
            else
            {
            System.Debug('Entered in Insert Loop');
            for(Custom_Opportunity__c tempOffOppty : scope)
            {
            if(oppPro.OpportunityId==tempOffOppty.GE_OG_Standard_Oppty__c )
            {
            System.debug('OffOpptyL creation entered If 3');  
           GE_OG_Forecast_ServiceProduct__c temp1 = new GE_OG_Forecast_ServiceProduct__c();
                    temp1.GE_OG_Quantity__c = oppPro.Quantity;
                    temp1.GE_OD_Delivery_Date__c = oppPro.x1st_delivery_date_ge_og__c;
                    temp1.GE_OG_Sales_Price__c = oppPro.UnitPrice;
                    
                    //Converting into USD Currency 
                    if(OppPro.Opportunity.CurrencyIsoCode != 'USD' && isoWithRateMap.containsKey(OppPro.Opportunity.CurrencyIsoCode))
                    {
                        if(OppPro.UnitPrice != null)
                        {
                            temp1.GE_OG_Sales_Price__c = (OppPro.UnitPrice / isoWithRateMap.get(OppPro.Opportunity.CurrencyIsoCode)).setScale(2);
                        }
                    }
                    
                    
                    temp1.GE_OG_StandardOpptyProductID__c = oppPro.Id;
                    temp1.GE_OG_Product__c = oppPro.Product2Id;
                    temp1.GE_OG_Product_Name__c = oppPro.Product2.Name;
                    temp1.GE_OG_Offline_Opportunities__c =tempOffOppty.Id ;
                   
                   offlineProdFlist2.add(temp1);
                   System.debug('Insert Level'+offlineProdFlist2);
            }
            }
            }
        }
        Set<Id> delFSPset = new Set<Id>();
        List<GE_OG_Forecast_ServiceProduct__c> delFSP = new List<GE_OG_Forecast_ServiceProduct__c>();
        List<GE_OG_Forecast_ServiceProduct__c> delFSPList = new List<GE_OG_Forecast_ServiceProduct__c>();
        for(Custom_Opportunity__c offoppty : scope){
            if(offlineMap.ContainsKey(offoppty.GE_OG_Standard_Oppty__c))
            {
                for(GE_OG_Forecast_ServiceProduct__c offopptyP : offlineProd)
                {
                    System.debug('OffOpptyL entered Deletion If 4');  
                    if(!delFSPset.Contains(offopptyP.Id))
                    {
                        if(!oppLine.Contains(offopptyp.GE_OG_StandardOpptyProductID__c))
                        {
                        delFSP.add(offopptyp);
                        }
                    }
                    delFSPset.add(offopptyP.Id);
                    System.debug('Delete Level'+delFSPset);
                }
                
            }
        }
        
            if(offlineProdFlist1.size()>0)
            {
                update offlineProdFlist1;
                System.debug('Update Level');
            }  
            if(offlineProdFlist2.size()>0)
            {
                insert offlineProdFlist2;
                System.debug('Insert Level');
            }  
            if(delFSP.size()>0)
            {
                delete delFSP;
                System.debug('Delete Level');
            }                  
    System.debug('Final Level');
       }
   
     
      }

      global void finish(Database.BatchableContext BC)
      {
    
      }
}