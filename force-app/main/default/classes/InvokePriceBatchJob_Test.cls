@isTest
Public class InvokePriceBatchJob_Test{
    
    public static testmethod void deleteAssociateRecordtest(){
    
        Product2 pd=new Product2();
            pd.name='Test product';
            pd.ProductCode='1234';
            pd.Description='Test description';
            insert pd; 
            
        PriceBookEntry pricebk = new PriceBookEntry();
            pricebk.CurrencyIsoCode = 'USD';
            pricebk.UnitPrice = 1.0;
            pricebk.Pricebook2Id =Test.getStandardPricebookId();
            pricebk.Product2Id = pd.id;
            pricebk.IsActive = true;  
            pricebk.UseStandardPrice = false;   
            insert pricebk;
            
        SVMXC__Activity_Master__c actMaster=new SVMXC__Activity_Master__c();
            actMaster.SVMXC__Activity_Type__c='Service';
            actMaster.SVMXC__Description__c='Test';
            actMaster.Tier_3__c='Artificial Lift';
            insert actMaster;
            
        SVMXC__Activity_Product__c pd1= new SVMXC__Activity_Product__c();
            pd1.SVMXC__Activity__c=actMaster.id;
            pd1.SVMXC__Product__c=pd.id;
            insert pd1;

        SVMXC__Service_Pricebook__c pbk=new SVMXC__Service_Pricebook__c();
            pbk.name='servicepricebook';
            pbk.SVMXC__Description__c='test';
            pbk.SVMXC__Active__c=true;
            insert pbk;
            
             Pricebook2 pb2= new Pricebook2();
            pb2.Name='test';
            pb2.Tier_1__c='Oil & Gas';
            insert pb2;
            

        SVMXC__Service_Pricebook_Entry__c sspe=new SVMXC__Service_Pricebook_Entry__c();
            sspe.SVMXC__Price_Book__c=pbk.id;
            //sspe.SVMXC__Price_Book__c=pbk.id;
            //sspe.SVMXC__Product__c=pd1.id;
            //sspe.ProductCode=1234;
            sspe.SVMXC__Activity_Product__c=pd1.id;
            insert sspe;
                        
        SVMX_MultiPricing__c nmultiObj = new SVMX_MultiPricing__c();
            nmultiObj.List_price__c= 92.12;
            nmultiObj.Service_Pricebook__c= pbk.id;
            nmultiObj.SVMX_Product__c = pd.id;
            //insert nmultiobj;
                                     
        SVMXC__Service_Contract__c sc=new SVMXC__Service_Contract__c();
            sc.Name='Permian - Permian Resources - BHGE OFS AL Customer Pricing';
            sc.CurrencyIsoCode='MXN'; 
            sc.Tier_1__c='Oil & Gas'; 
            sc.SVMXC__Service_Pricebook__c=pbk.id;
            sc.Parts_Pricebook__c=pb2.id;
            sc.Tier_2__c='Digital Solutions';
            sc.SVMXC__Start_Date__c= Date.today();
            sc.SVMXC__End_Date__c= Date.today()+2;    
            insert sc;
            
      
            
                                     
        list<PriceStaging__c> lstprc=  new list<PriceStaging__c>() ;
        PriceStaging__c prc =  new PriceStaging__c() ;
            prc.Product_Description__c='Pricestage';
            prc.Product_Code__c='1234';
            prc.Product_Name__c='Test product';
            prc.Product_Type__c='Parts';
            prc.Price_Deleted__c=true;
            prc.CurrencyIsoCode ='CNY';
            prc.Product__c=pd.id;
            //prc.Service_Pricebook__c=pbk.id;
            prc.Price_Book__c=pb2.id;
            prc.Service_Maintenance_Contract__c=sc.id;
            prc.Tier_2__c='Artificial Lift';
            prc.Tier_3__c='Digital';
            prc.Rate__c =10.0;
            lstprc.add(prc);
            insert lstprc;
                
            
            
            InvokePriceBatchJob.ExecutePriceBatchJob();         
            InvokePriceBatchJob.deleteAssociateRecord(prc.id);

        delete lstprc;          
        
    }
    public static testmethod void deleteAssociateRecordtest1(){
    
        Product2 pd=new Product2();
            pd.name='Test product';
            pd.ProductCode='1234';
            pd.Description='Test description';
            insert pd; 
            
        PriceBookEntry pricebk = new PriceBookEntry();
            pricebk.CurrencyIsoCode = 'USD';
            pricebk.UnitPrice = 1.0;
            pricebk.Pricebook2Id =Test.getStandardPricebookId();
            pricebk.Product2Id = pd.id;
            pricebk.IsActive = true;  
            pricebk.UseStandardPrice = false;   
            insert pricebk;
            
        SVMXC__Activity_Master__c actMaster=new SVMXC__Activity_Master__c();
            actMaster.SVMXC__Activity_Type__c='Service';
            actMaster.SVMXC__Description__c='Test';
            actMaster.Tier_3__c='Artificial Lift';
            insert actMaster;
            
        SVMXC__Activity_Product__c pd1= new SVMXC__Activity_Product__c();
            pd1.SVMXC__Activity__c=actMaster.id;
            pd1.SVMXC__Product__c=pd.id;
            insert pd1;

        SVMXC__Service_Pricebook__c pbk=new SVMXC__Service_Pricebook__c();
            pbk.name='servicepricebook';
            pbk.SVMXC__Description__c='test';
            pbk.SVMXC__Active__c=true;
            insert pbk;
         
         Pricebook2 pb2= new Pricebook2();
            pb2.Name='test';
            pb2.Tier_1__c='Oil & Gas';
            insert pb2;

        SVMXC__Service_Pricebook_Entry__c sspe=new SVMXC__Service_Pricebook_Entry__c();
            sspe.SVMXC__Price_Book__c=pbk.id;
            //sspe.SVMXC__Price_Book__c=pbk.id;
            //sspe.SVMXC__Product__c=pd1.id;
            //sspe.ProductCode=1234;
            sspe.SVMXC__Activity_Product__c=pd1.id;
            insert sspe;
                        
        SVMX_MultiPricing__c nmultiObj = new SVMX_MultiPricing__c();
            nmultiObj.List_price__c= 92.12;
            nmultiObj.Service_Pricebook__c= pbk.id;
            nmultiObj.SVMX_Product__c = pd.id;
            //insert nmultiobj;
                                     
        SVMXC__Service_Contract__c sc=new SVMXC__Service_Contract__c();
            sc.Name='Permian - Permian Resources - BHGE OFS AL Customer Pricing';
            sc.CurrencyIsoCode='MXN'; 
            sc.Tier_1__c='Oil & Gas'; 
            sc.Tier_2__c='Digital Solutions';
            sc.SVMXC__Service_Pricebook__c=pbk.id;
            sc.Parts_Pricebook__c=pb2.id;
            sc.SVMXC__Start_Date__c= Date.today();
            sc.SVMXC__End_Date__c= Date.today()+2;    
            insert sc;
            
      
            
                                     
        list<PriceStaging__c> lstprc=  new list<PriceStaging__c>() ;
        PriceStaging__c prc =  new PriceStaging__c() ;
            prc.Product_Description__c='Pricestage';
            prc.Product_Code__c='1234';
            prc.Product_Name__c='Test product';
            prc.Product_Type__c='Labor';
            prc.Price_Deleted__c=false;
            prc.CurrencyIsoCode ='CNY';
            prc.Product__c=pd.id;
            prc.Service_Pricebook__c=pbk.id;
            //prc.Price_Book__c=pb2.id;
            prc.Service_Maintenance_Contract__c=sc.id;
            prc.Tier_2__c='Artificial Lift';
            prc.Tier_3__c='Digital';
            prc.Rate__c =10.0;
            lstprc.add(prc);
            insert lstprc;
            
            
            
            InvokePriceBatchJob.ExecutePriceBatchJob();         
            InvokePriceBatchJob.deleteAssociateRecord(prc.id);

delete lstprc;  
        
        
    }

}