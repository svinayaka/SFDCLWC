@isTest
global class GE_Price_BatchMethod_Test{
    
    
  
    public static  testmethod  void GE_Price_BatchMethod(){

        Product2 pd=new Product2();
        pd.name='Test product';
        pd.ProductCode='1234';
        pd.Description='Test description';
        pd.IsActive = true;
        pd.CurrencyIsoCode='USD';       
        insert pd;
        
        pricebook2 pb2=new pricebook2();
        pb2.name='test';
        pb2.IsActive = true;
        pb2.CurrencyIsoCode='USD';
        pb2.Tier_1__c='Oil & Gas';       
        insert pb2;
        
        SVMXC__Service_Pricebook__c spbk=new SVMXC__Service_Pricebook__c();
        spbk.name='servicepricebook';
        spbk.SVMXC__Description__c='test';
        spbk.SVMXC__Active__c=true;
        insert spbk;

        SVMXC__Service_Contract__c sc=new SVMXC__Service_Contract__c();
        sc.Name='Permian - Permian Resources - BHGE OFS AL Customer Pricing';
        sc.Parts_Pricebook__c=pb2.id;
        sc.SVMXC__Service_Pricebook__c=spbk.id;
        sc.CurrencyIsoCode='MXN'; 
        sc.Tier_1__c='Oil & Gas'; 
        sc.Tier_2__c='Digital Solutions';
        sc.SVMXC__Start_Date__c= Date.today();
        sc.SVMXC__End_Date__c= Date.today()+2;    
        insert sc;
                       
        list<PriceStaging__c> lstprc=  new list<PriceStaging__c>() ;                     
        PriceStaging__c prc =  new PriceStaging__c() ;
        prc.Product_Description__c='Pricestage';
        prc.Product_Code__c='1234';
        prc.Product_Name__c='Test product';
        prc.Product_Type__c='Labor';
        prc.Service_Pricebook__c=spbk.id;
        prc.Price_Book__c=null;
        prc.Service_Maintenance_Contract__c=sc.id;
        prc.Tier_2__c='Artificial Lift';
        prc.Tier_3__c='Digital';
        prc.Rate__c =10.0;
        lstprc.add(prc);
        insert lstprc;        
                                 
        Test.starttest();
        
        GE_Price_Batch mpse=new GE_Price_Batch();
        Database.QueryLocator ql = mpse.start(null);
        mpse.execute(null,lstprc);
        mpse.Finish(null);
        database.executebatch(mpse);
        
        Test.stoptest();
    }
    public static  testmethod  void GE_partsPrice_BatchMethod(){
        
        Product2 pd=new Product2();
        pd.name='Test product';
        pd.ProductCode='1234';
        pd.Description='Test description';
        pd.IsActive = true;
        pd.CurrencyIsoCode='MXN';        
        insert pd;
        
        pricebook2 pb2=new pricebook2();
        pb2.name='test';
        pb2.IsActive = true;
        pb2.CurrencyIsoCode='USD';
        pb2.Tier_1__c='Oil & Gas';       
        insert pb2;
      
        ID standardPBID = Test.getStandardPricebookId();
        system.debug('Standard:::::'+standardPBID);
        
        PricebookEntry sspe=new PricebookEntry();       
        sspe.UseStandardPrice=false;
       //sspe.StandardPrice=1.02;
        sspe.CurrencyIsoCode='MXN';
        //sspe.ProductCode=1234;
        sspe.Product2Id=pd.id;
        sspe.Pricebook2Id=standardPBID;
        sspe.isActive=true;
        sspe.UnitPrice=1.02;
        insert sspe;
        
        SVMXC__Service_Pricebook__c spbk=new SVMXC__Service_Pricebook__c();
        spbk.name='servicepricebook';
        spbk.SVMXC__Description__c='test';
        spbk.SVMXC__Active__c=true;
        insert spbk;
        
        SVMXC__Service_Contract__c sc=new SVMXC__Service_Contract__c();
        sc.Name='Permian - Permian Resources - BHGE OFS AL Customer Pricing';
        sc.Parts_Pricebook__c=pb2.id;
        sc.SVMXC__Service_Pricebook__c=spbk.id;
        sc.CurrencyIsoCode='MXN'; 
        sc.Tier_1__c='Oil & Gas'; 
        sc.Tier_2__c='Digital Solutions';
        sc.SVMXC__Start_Date__c= Date.today();
        sc.SVMXC__End_Date__c= Date.today()+2;    
        insert sc;
                       
        list<PriceStaging__c> lstprc=  new list<PriceStaging__c>() ;
        PriceStaging__c prcparts =  new PriceStaging__c() ;
        prcparts.Product_Description__c='Pricestage';
        prcparts.Product_Code__c='1234';
        prcparts.Product_Name__c='Test product';
        prcparts.Product_Type__c='Parts';
        prcparts.Service_Pricebook__c=null;
        prcparts.Price_Book__c=pb2.id;
        prcparts.Service_Maintenance_Contract__c=sc.id;
        prcparts.Tier_2__c='Artificial Lift';
        prcparts.Tier_3__c='Digital';
        prcparts.Rate__c =10.0;
        lstprc.add(prcparts);        
        insert lstprc;        
                                 
        Test.starttest();
        
        GE_Price_Batch mpse=new GE_Price_Batch();
        //Database.QueryLocator ql = mpse.start(null);
        //mpse.execute(null,lstprc);
        //mpse.Finish(null);
        database.executebatch(mpse);
        
        Test.stoptest();
    }
   public static testMethod void method1(){
    
    id rid = Schema.SObjectType.PriceStaging__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
    id prodrid=Schema.SObjectType.Product2.getRecordTypeInfosByName().get('ServiceMax').getRecordTypeId();
    id pricebookrid=Schema.SObjectType.Pricebook2.getRecordTypeInfosByName().get('AL').getRecordTypeId();
    id sercontractrid=Schema.SObjectType.SVMXC__Service_Contract__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
    
    
        Product2 prd2= new Product2(
        Name = 'NS10001',
        ProductCode = 'NS10001',
        Description = 'Naveen Part Testing1',
        CanUseQuantitySchedule = false,
        CanUseRevenueSchedule = false,
        IsActive = true,
        CurrencyIsoCode = 'USD',
        RecordTypeId =prodrid ,
        Field_Service__c = false,
        Product_Discount_Percent_ge_og__c = 0.0,
        Must_Move_Inventory_ge_og__c = false,
        GE_ES_BM_Product__c = false,
        GE_Tier1_PnL__c = 'Oil & Gas',
        GE_Tier2_PnL__c = 'Oil Field Services',
        GE_Tier3_PnL__c = 'Artificial Lift',
        SVMXC__Enable_Serialized_Tracking__c = false,
        SVMXC__Inherit_Parent_Warranty__c = false,
        SVMXC__Replacement_Available__c = false,
        SVMXC__Select__c = false,
        SVMXC__Stockable__c = false,
        SVMXC__Unit_Of_Measure__c = 'Each',
        digital_ge_og__c = false,
        SVMXC__Product_Type__c = 'Parts'
        //MultiPricing_Included__c = false
        );
        insert prd2;
            
        Pricebook2 pricebook2 = new Pricebook2(
        Name = 'Naveen Testing',
        CurrencyIsoCode = 'USD',
        RecordTypeId = pricebookrid,
        IsActive = true,
        Description = 'Naveen Testing',
        Tier_1__c = 'Oil & Gas',
        Tier_2__c = 'Oil Field Services',
        Tier_3__c = 'Artificial Lift');
        insert pricebook2;
        
        SVMXC__Service_Pricebook__c spb = new SVMXC__Service_Pricebook__c(
       // OwnerId = '005A0000004JzrZIAS',
        Name = 'Christie NAM Service test',
        CurrencyIsoCode = 'USD',
        SVMXC__Active__c = false,
        Tier_1__c = 'Oil & Gas',
        Tier_2__c = 'Oil Field Services',
        Tier_3__c = 'Artificial Lift');
        insert spb;
        
        SVMXC__Service_Contract__c ssc= new SVMXC__Service_Contract__c(
       // OwnerId = '005A0000004JzrZIAS',
        Name = 'Ch Test Contract',
        CurrencyIsoCode = 'USD',
        RecordTypeId = sercontractrid,
        SVMXC__Active__c = true,
        SVMXC__All_Contacts_Covered__c = true,
        SVMXC__All_Products_Covered__c = true,
        SVMXC__All_Services_Covered__c = true,
        SVMXC__All_Sites_Covered__c = true,
        SVMXC__End_Date__c = Date.newInstance(2023,10,31),
        SVMXC__Select__c = false,
        SVMXC__Start_Date__c = Date.newInstance(2018,10,17),
        //SVMXC__Default_Parts_Price_Book__c = '01se0000000CD7kAAG',
        Parts_Pricebook__c=pricebook2.Id,
        SVMXC__Service_Pricebook__c=spb.Id,
        SVMXC__Labor_Rounding_Type__c = 'Actuals',
        Tier_1__c='Oil & Gas',
        Tier_2__c='Oil Field Services',
        Tier3__c = 'Artificial Lift',
        Region__c = 'North America',
        Branch__c = 'Permian');     
        insert ssc;
        
        PriceStaging__c pricestaging = new PriceStaging__c(
       // OwnerId = '005e0000004LEQCAA4',
        CurrencyIsoCode = 'USD',
        RecordTypeId = rid,
        Price_Book__c = pricebook2.Id,
        Processed__c = false,
        Product_Code__c = 'NS10001',
        Product_Description__c = 'Naveen Part Testing',
        Product_Name__c = 'NS10001',
        Product_Type__c = 'Parts',
        Product__c = prd2.Id,
        Rate_Unit__c = 'Per Unit',
        Rate__c = 23.56,
        Service_Maintenance_Contract__c =ssc.Id,
        Tier_1__c = 'Oil & Gas',
        Tier_2__c = 'Oil Field Services',
        Tier_3__c = 'Artificial Lift',
        Price_Deleted__c = true);
        insert pricestaging;
                
        PriceStaging__c pricestaging1 = new PriceStaging__c(
        Service_Maintenance_Contract__c=ssc.id,
        Product_Type__c='Labor',                                                        
        Product_Name__c='10472240',                                                     
        Product_Code__c='10472240',                                                     
        Service_Pricebook__c = spb.Id,                                         
        Product_Description__c = 'Install - ESP TECH HOURS BHGE is not the Spooler M-F',  
        Rate_Unit__c = 'Per Hour',                                                        
        Tier_1__c = 'Oil & Gas',                                                          
        Rate__c = 76.00,                                                                
        Tier_2__c = 'Oil Field Services',                                                 
        //RecordTypeId = 'undefined',                                                       
        Tier_3__c = 'Artificial Lift',                                                    
        Processed__c = false,                                                              
        Product__c = prd2.id,                                                   
        Price_Deleted__c = false,CurrencyIsoCode='USD');
        insert pricestaging1;
        ID standardPBID = Test.getStandardPricebookId();
        
        pricebookentry pbe=new pricebookentry();          
        pbe.UseStandardPrice=false;
        //prbookEntry.StandardPrice=1.02;
        pbe.CurrencyIsoCode='MXN';
        //prbookEntry.ProductCode=1234;
        pbe.Product2Id=prd2.id;
        pbe.Pricebook2Id=standardPBID;
        pbe.isActive=true;
        pbe.UnitPrice=1.02;
        /*pbe.pricebook2Id=standardPBID; 
        pbe.product2Id=prd2.id;
        pbe.IsActive = true; 
        pbe.UnitPrice =23.56;
        pbe.CurrencyIsoCode=pricestaging.CurrencyIsoCode;*/      
        insert pbe; 
        
                
        Test.startTest(); 
        
        GE_Price_Batch gpb=new GE_Price_Batch();
        Database.executeBatch(gpb);
        
        Test.stopTest();
    }
    static testMethod void method2(){
       id prodrid=Schema.SObjectType.Product2.getRecordTypeInfosByName().get('ServiceMax').getRecordTypeId();  
      SVMXC__Service_Pricebook__c sobj1 = new SVMXC__Service_Pricebook__c(
      Name = 'BHGE OFS AL Chevron Customer Pricing Services  - Permian',          
      SVMXC__Description__c = 'Chevron -Customer specific Labor Price Book in South West GE AL Region',
      SVMXC__Active__c = true,CurrencyIsoCode='USD');
            try{     
                insert sobj1;
                }Catch(Exception e){
                    e.setMessage('Test Cause error'); 
                }
      Pricebook2 sobj2 = new Pricebook2(
      Name = 'BHGE OFS AL Chevron Customer Pricing Parts  - Permian',                        
      Description = 'Chevron -Customer specific Parts Price Book in South West GE AL Region',CurrencyIsoCode='USD', 
      // RecordTypeId = 'undefined',                                                             
      IsActive = false);
            try{
                insert sobj2;
                }Catch(Exception e){
                    e.setMessage('Test Cause error'); 
                }
       
      SVMXC__Service_Contract__c sobj3= new SVMXC__Service_Contract__c(
      Name = 'Permian - Chevron - BHGE OFS AL Customer Pricing',
      SVMXC__Active__c = true,CurrencyIsoCode='USD',                                    
      Tier_1__c = 'Oil & Gas',                                    
      Tier_2__c = 'Oil Field Services',                           
      Tier3__c = 'Artificial Lift',                               
      // RecordTypeId = 'undefined',                                 
      Parts_Pricebook__c =sobj2.id,                     
      //SVMXC__Default_Parts_Price_Book__c = '01se0000000CD7rAAG',  
      SVMXC__Service_Pricebook__c =sobj1.id,            
      SVMXC__Start_Date__c = Date.newInstance(2018,10,17),          
      SVMXC__End_Date__c = Date.newInstance(2023,10,31),            
      SVMXC__All_Products_Covered__c = true,                      
      SVMXC__All_Contacts_Covered__c = true,                      
      SVMXC__All_Services_Covered__c = true,                      
      SVMXC__All_Sites_Covered__c = true);
      
            try{
                insert sobj3;
                }Catch(Exception e){
                    e.setMessage('Test Cause error');
                }
      List<Product2> prd2=new List<Product2>();       
      Product2 sobj5 = new Product2(
      Name = '10472240',                                                   
      ProductCode = '10472240', 
      RecordTypeId =prodrid,
      IsActive = true,                                                     
      GE_ES_BM_Product__c = false,                                         
      GE_Tier1_PnL__c = 'Oil & Gas',                                       
      Must_Move_Inventory_ge_og__c = false,                                  
      GE_Tier2_PnL__c = 'Oil Field Services',                                
      digital_ge_og__c = false,                                              
      GE_Tier3_PnL__c = 'Artificial Lift',                                   
      Field_Service__c = true,CurrencyIsoCode='USD',                                               
      Product_Discount_Percent_ge_og__c = 0.00,                              
      Description = 'Install - ESP TECH HOURS BHGE is not the Spooler M-F'  
      );
      insert sobj5;        
      prd2.add(sobj5);
       
      PriceStaging__c pricestaging = new PriceStaging__c(
      Service_Maintenance_Contract__c=sobj3.id,
      Product_Type__c='Labor',                                                        
      Product_Name__c='10472240',                                                     
      Product_Code__c='10472240',                                                     
      Service_Pricebook__c = sobj1.Id,                                         
      Product_Description__c = 'Install - ESP TECH HOURS BHGE is not the Spooler M-F',  
      Rate_Unit__c = 'Per Hour',                                                        
      Tier_1__c = 'Oil & Gas',                                                          
      Rate__c = 76.00,                                                                
      Tier_2__c = 'Oil Field Services',                                                 
      //RecordTypeId = 'undefined',                                                       
      Tier_3__c = 'Artificial Lift',                                                    
      Processed__c = false,                                                              
      Product__c = sobj5.id,                                                   
      Price_Deleted__c = false,CurrencyIsoCode='USD');
            
      //insert pricestaging;
      
      Database.SaveResult result2 = Database.insert(pricestaging, true);
      System.assert(result2.isSuccess());
      System.assert(result2.getErrors().size()==0);
                        
      SVMXC__Activity_Master__c sobj6 = new SVMXC__Activity_Master__c(
      SVMXC__Activity_Type__c = 'Bonus',Tier_3__c='Artificial Lift',SVMXC__Description__c='Install - ESP TECH HOURS BHGE is not the Spooler M-F');
      insert sobj6;

      List<SVMXC__Activity_Product__c> lstact=new List<SVMXC__Activity_Product__c>();        
      SVMXC__Activity_Product__c sobj7 = new SVMXC__Activity_Product__c(
      SVMXC__Product__c =sobj5.Id,
      SVMXC__Activity__c =sobj6.id);
      insert sobj7;       
        //    Database.SaveResult result1 = Database.insert(sobj7, true);
         //   System.assert(result1.isSuccess());
         //   System.assert(result1.getErrors().size()== 0);
      lstact.add(sobj7);       
            
      SVMXC__Service_Pricebook_Entry__c sobj8 = new SVMXC__Service_Pricebook_Entry__c(
      SVMXC__Price_Book__c =sobj1.Id ,        
      SVMXC__Activity_Product__c =sobj7.Id ,  
      SVMXC__Entry_Type__c = 'Labor',                  
      SVMXC__Unit__c = 'Per Hour',                     
      MultiPricingExisted__c = true,                   
      SVMXC__Regular_Rate__c = 76.00,CurrencyIsoCode='USD'                  
      );
     /*        try{        
     insert sobj8;
            }Catch(Exception e){
                e.setMessage('Test Cause error');
            }*/
       
      Database.SaveResult result = Database.insert(sobj8, true);
      System.assert(result.isSuccess());
      System.assert(result.getErrors().size()== 0);        
            
      Test.startTest();
      
      GE_Price_Batch gpb=new GE_Price_Batch();
      Database.executeBatch(gpb);
      
      Test.stopTest();
                
    } 
    static testMethod void method5(){
      SVMXC__Service_Pricebook__c sobj1 = new SVMXC__Service_Pricebook__c(
      Name = 'BHGE OFS AL Chevron Customer Pricing Services  - Permian',          
      SVMXC__Description__c = 'Chevron -Customer specific Labor Price Book in South West GE AL Region',
      SVMXC__Active__c = true,CurrencyIsoCode='USD');
            try{     
                insert sobj1;
                }Catch(Exception e){
                    e.setMessage('Test Cause error'); 
                }
      Pricebook2 sobj2 = new Pricebook2(
      Name = 'BHGE OFS AL Chevron Customer Pricing Parts  - Permian',                        
      Description = 'Chevron -Customer specific Parts Price Book in South West GE AL Region',CurrencyIsoCode='USD', 
      // RecordTypeId = 'undefined',                                                             
      IsActive = false);
            try{
                insert sobj2;
                }Catch(Exception e){
                    e.setMessage('Test Cause error'); 
                }
       
      SVMXC__Service_Contract__c sobj3= new SVMXC__Service_Contract__c(
      Name = 'Permian - Chevron - BHGE OFS AL Customer Pricing',
      SVMXC__Active__c = true,CurrencyIsoCode='USD',                                    
      Tier_1__c = 'Oil & Gas',                                    
      Tier_2__c = 'Oil Field Services',                           
      Tier3__c = 'Artificial Lift',                               
      // RecordTypeId = 'undefined',                                 
      Parts_Pricebook__c =sobj2.id,                     
      //SVMXC__Default_Parts_Price_Book__c = '01se0000000CD7rAAG',  
      SVMXC__Service_Pricebook__c =sobj1.id,            
      SVMXC__Start_Date__c = Date.newInstance(2018,10,17),          
      SVMXC__End_Date__c = Date.newInstance(2023,10,31),            
      SVMXC__All_Products_Covered__c = true,                      
      SVMXC__All_Contacts_Covered__c = true,                      
      SVMXC__All_Services_Covered__c = true,                      
      SVMXC__All_Sites_Covered__c = true);
      
            try{
                insert sobj3;
                }Catch(Exception e){
                    e.setMessage('Test Cause error');
                }
      
       
      PriceStaging__c pricestaging = new PriceStaging__c(
      Service_Maintenance_Contract__c=sobj3.id,
      Product_Type__c='Labor',                                                        
      Product_Name__c='10472240',                                                     
      Product_Code__c='10472240',                                                     
      Service_Pricebook__c = sobj1.Id,                                         
      Product_Description__c = 'Install - ESP TECH HOURS BHGE is not the Spooler M-F',  
      Rate_Unit__c = 'Per Hour',                                                        
      Tier_1__c = 'Oil & Gas',                                                          
      Rate__c = 76.00,                                                                
      Tier_2__c = 'Oil Field Services',                                                 
      //RecordTypeId = 'undefined',                                                       
      Tier_3__c = 'Artificial Lift',                                                    
      Processed__c = false,                                                              
      //Product__c = sobj5.id,                                                   
      Price_Deleted__c = false,CurrencyIsoCode='USD');
            
      //insert pricestaging;
      
      Database.SaveResult result2 = Database.insert(pricestaging, true);
      System.assert(result2.isSuccess());
      System.assert(result2.getErrors().size()==0);
                        
      SVMXC__Activity_Master__c sobj6 = new SVMXC__Activity_Master__c(
      SVMXC__Activity_Type__c = 'Bonus',Tier_3__c='Artificial Lift',SVMXC__Description__c='Install - ESP TECH HOURS BHGE is not the Spooler M-F');
      insert sobj6;

             
            
              
            
      Test.startTest();
      
      GE_Price_Batch gpb=new GE_Price_Batch();
      Database.executeBatch(gpb);
      
      Test.stopTest();
                
    }   
}