@isTest
public class OpportunityGFSExceAutomation_GE_OG_Test{

    
     public static testMethod void testGFSDate(){
     
     
      Test.startTest();
      CommonTestDataFactory_GE_OG objCTDF =  new CommonTestDataFactory_GE_OG ();
      
      //creating 'Country Region Mapping' for 'INDIA'
      Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
           insert objcustom;
      
      // Create Relational Account
      Account objacc = CommonTestDataFactory_GE_OG.createRelationshipAccount('test account');
     system.assertEquals('test account',objacc.Name);
     
     //Creating an Opportunity
      Opportunity objopp = CommonTestDataFactory_GE_OG.createOppty('TestOppty',objacc.id);
      system.assertEquals('TestOppty',objopp.Name);
      objopp.delivery_date_ge_og__c = system.today().addDays(30);
      objopp.CloseDate =system.today().addDays(45);
      objopp.install_country_ge_og__c = 'CANADA';
      objopp.has_opportunitycontactrole_ge_og__c = true;
      objopp.delivery_date_ge_og__c= system.today().addDays(45);
      objopp.is_turn_key_ge_og__c = true;
      update objopp;
      
      //Creating a Product
      Product2 objprod = CommonTestDataFactory_GE_OG.createProduct('TestProduct1');
      system.assertEquals('TestProduct1',objprod.Name);
      objprod.GE_ES_Product_Service__c = 'Turn Key';
      objprod.isActive = True;
      update objprod;
     
      //Creating a PriceBookEntry
      //PriceBookEntry objpbe = CommonTestDataFactory_GE_OG.createPriceBookEntry(objprod);
      //system.assertEquals(objprod.ID,objpbe.Product2ID);
      //Creating a PriceBookEntry
       //PriceBookEntry PBE=  CommonTestDataFactory_GE_OG.createPriceBookEntry(prod1);
       //system.assertEquals(prod1.ID,PBE.Product2ID);
       List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
       lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
       //lstPBE.add(PBE);
       
       
       //Create OpportunityLineItem 
       if(lstPBE.size()==0){
            PricebookEntry objPBE = new PricebookEntry();
            objPBE.Product2Id = objprod.Id;
            objPBE.UseStandardPrice = False;
            objPBE.UnitPrice = 0;
            objPBE.CurrencyIsoCode = 'USD';
            objPBE.IsActive = objprod.IsActive;
            objPBE.Pricebook2Id = Test.getStandardPricebookID();
            insert  objPBE;
            lstPBE = new List<PriceBookEntry>();
            lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
       }
       system.assertEquals(1,lstPBE.size());
       if(lstPBE.size()>0){
            List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
            lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(objopp, lstPBE);
            if(lstOLI.size()>0){
                insert lstOLI;
            }
       }
      
     // OpportunityLineItem objoli = CommonTestDataFactory_GE_OG.createOpportunityLineItem(objopp,lstPBE);
        
      //Create Request Type
        GE_ES_Request_Type__c objRequestType = new GE_ES_Request_Type__c();
        objRequestType.Name = 'Test';
        objRequestType.Opportunity__c = objOpp.Id;
        objRequestType.RecordTypeId = Util_GE_OG.getRecordTypeDetails('GE_ES_Request_Type__c','TPS- FSE Check List').getRecordTypeId();
        objRequestType.GE_OG_Intervent_Description__c = 'Test desc';
        objRequestType.GE_OG_Week_Duration_days_week__c = 1;
        objRequestType.GE_OG_Shift_Duration_hours_day__c = 2;
        objRequestType.GE_OG_Shifts__c = 'Single';
        objRequestType.GE_OG_Offshore__c = 'N';
        objRequestType.GE_OG_Board_Lodging__c = 'GE';
        objRequestType.GE_OG_Lodging_Type__c = 'Hotel';
        objRequestType.GE_OG_Local_Transportation__c = 'GE';
        objRequestType.GE_OG_Emergency_Flag__c = 'N';
        objRequestType.GE_OG_Overlap_Days__c = 1;
        objRequestType.GE_OG_Execution_Date_GFS__c = Date.today();
        objRequestType.GE_OG_Expected_Delivery_Date__c = Date.today();
        objRequestType.export_to_erp_ge_og__c = true;
        objRequestType.GE_OG_OG_Primary_Country__c  = 'India';
        insert objRequestType;
        
      
      Test.stopTest();
     }
     public static testMethod void testGFSDate2(){
     
     
      Test.startTest();
      CommonTestDataFactory_GE_OG objCTDF =  new CommonTestDataFactory_GE_OG ();
     
      //creating 'Country Region Mapping' for 'INDIA'
      Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
      insert objcustom;
           
      // Create Relational Account
      Account objacc = CommonTestDataFactory_GE_OG.createRelationshipAccount('test account');
     system.assertEquals('test account',objacc.Name);
     
     //Creating an Opportunity
      Opportunity objopp = CommonTestDataFactory_GE_OG.createOppty('TestOppty',objacc.id);
      system.assertEquals('TestOppty',objopp.Name);
      objopp.primary_country_iso_ge_og__c = '';
      update objopp;
      
      //Creating a Product       
      Product2 objprod = CommonTestDataFactory_GE_OG.createProduct('TestProduct1');
      system.assertEquals('TestProduct1',objprod.Name);
      objprod.GE_ES_Product_Service__c = '';
      update objprod;
      
      //Creating a PriceBookEntry
     // PriceBookEntry objpbe = CommonTestDataFactory_GE_OG.createPriceBookEntry(objprod);
     // system.assertEquals(objprod.ID,objpbe.Product2ID);
      List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
      lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];  
        
        
     //Create OpportunityLineItem 
      List<OpportunityLineItem> objoli = new List<OpportunityLineItem>();
      objoli = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(objopp, lstPBE);
      delete objoli;
      
      
      Test.stopTest();
     }
     

}