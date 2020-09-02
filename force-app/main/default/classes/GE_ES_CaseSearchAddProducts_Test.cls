@isTest
public class GE_ES_CaseSearchAddProducts_Test {

      testmethod static void runCaseSearchAddProducts(){
     GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
        
        ApexPages.StandardController stdContr;
        test.startTest();
        GE_ES_CaseSearchAddProducts l_cs = new GE_ES_CaseSearchAddProducts(stdContr);
        List<SelectOption> svalues = new List<SelectOption>{};
        sValues.add(new SelectOption('Blank','Blank'));
        l_cs.ServiceValues = svalues;
        List<SelectOption> ovalues = new List<SelectOption>{};
        ovalues.add(new SelectOption('Blank','Blank'));
        l_cs.OfferingValues = ovalues;
        l_cs.PBE = new Product2(Name='Test Prod1',IsActive=TRUE,GE_ES_Oppty_Driver__c = 'Test Driver',GE_Tier1_PnL__c = 'Tier1',GE_Tier2_PnL__c = 'Tier2',GE_Tier3_PnL__c = 'Tier3',GE_Tier4_PnL__c = 'Tier4',GE_Tier5_PnL__c = 'Tier5',GE_Tier6_PnL__c = 'Tier6');
        l_cs.ProFamilyValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProHostValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProTechValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProLineValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProOfferingValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        List<id> idList = new List<id>{};
        List<GE_ES_CaseSearchAddProducts.ProductsWrapper> PW = new List<GE_ES_CaseSearchAddProducts.ProductsWrapper>();
        
        GE_ES_CaseSearchAddProducts.ProductsWrapper Pw1 = new GE_ES_CaseSearchAddProducts.ProductsWrapper();
        Product2 product1 = new Product2();
             product1.Name = 'a test product';        
             product1.ProductCode = 'xyz123'; 
             product1.GE_ES_P_L__c = 'Env'; 
             product1.GE_ES_Sub_P_L__c = 'Test Sub Env';    
             product1.GE_ES_Product_Service__c = 'Test Service';  
             product1.GE_ES_Offering__c = 'Test Offering'; 
             product1.GE_ES_Oppty_Driver__c = 'Test Driver';
             product1.Description = 'a description';        
             product1.Family = 'a test family';
             product1.GE_Tier1_PnL__c = 'Tier1';
             product1.GE_Tier2_PnL__c = 'Tier2';
             product1.GE_Tier3_PnL__c = 'Tier3';
             product1.GE_Tier4_PnL__c = 'Tier4';
             product1.GE_Tier5_PnL__c = 'Tier5';
             product1.GE_Tier6_PnL__c = 'Tier6';
             product1.GEEM_HstEqpmt__c = 'Host Equip';
             product1.Technology__c = 'Tech' ;
             product1.GEEM_ProLn__c = 'Line';
             product1.GEEM_ProOffng__c = 'Offering';  
             product1.isactive = true;
             product1.CurrencyIsoCode = 'USD';
             product1.BigMachines__Part_Number__c = '';
             product1.isactive= true;
        insert product1;   
        
        
         Account buyer = new Account();
     
        User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
        
        buyer.Name='TestClassAccount';  
        buyer.GE_HQ_Request_Status__c='CMF Approved';
        buyer.GE_HQ_KYC_Complete__c=TRUE;
        buyer.GE_PRM_KYC_Completed__c=TRUE;
        buyer.GE_HQ_DUNS_Number__c='555123459';  
        buyer.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        buyer.GE_OG_Buss_Tier2__c='Lufkin';
        buyer.GE_OG_Buss_Tier3__c='Oilfield';
        buyer.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        buyer.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        buyer.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        buyer.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        buyer.GE_PW_Country_Bill_To__c='UNITED STATES';
        buyer.GE_PW_City_Bill_To__c='United States';
        buyer.GE_PW_State_Province_Bill_To__c='state';
        buyer.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
        buyer.GE_PW_Country_Ship_To__c='UNITED STATES';
        buyer.GE_PW_City_Ship_To__c='city';
        buyer.GE_PW_State_Province_Ship_To__c='state';
        buyer.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        buyer.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        buyer.GE_HQ_Nts_Comments__c='Test';

       
        Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc1=rtByName_acc1.getRecordTypeId();
        buyer.RecordTypeId=acc1;
        buyer.GE_OG_AccFin_Status__c='In Progress';
        buyer.GE_HQ_Request_Status__c ='CMF Approved';
        buyer.ShippingCountry ='ARGENTINA';
        buyer.GE_PW_Phone_New_Request__c='(111)111-1111';
        insert buyer;
        
       
        
        Case caseobj = new Case();
        
        caseobj.RecordTypeId =[select id,name from recordtype where name like 'CIR' limit 1].id;
        caseobj.Accountid = buyer.id;      
        caseobj.GE_ES_Resolution_Date__c= date.today();
        caseobj.GE_HQ_Business_Tier2__c = 'GE Hitachi Nuclear Energy (GEH)';
        caseobj.CurrencyIsoCode = 'USD';
        caseobj.status = 'New';
        caseobj.GE_OG_EHS_Product_Safety_CIR__c = 'No Impact';
        caseobj.GE_OG_Customer_Impact_CIR__c = 'Low';
        caseobj.GE_OG_CIR_Impact_on_Customer_Description__c = ' test';
        caseobj.GE_OG_Customer_Escalation_CIR__c = 'No';
        caseobj.GE_OG_GE_Executive_Request_CIR__c = 'No';
        caseobj.GE_OG_Business_CIR__c = 'DTS';
        caseobj.Subject = 'testsub';
        caseobj.GE_OG_Item_Description_CIR__c = 'tst';
        //caseobj.GE_ES_Manufacturing_Site_Name__c = 'New';
        caseobj.GE_OG_Actions_Taken_To_Resolve_befor_CIR__c = 'test';
        caseobj.GE_OG_CIR_Specific_Deliverable_Required__c = 'test';
        caseobj.GE_OG_Issue_Event_Date_CIR__c = date.today();
        caseobj.GE_OG_CIR_Site_Country__c = 'ARUBA';
        caseobj.GE_OG_CIR_Site_Name__c = 'testsite';
        
        
        
        insert caseobj;
        
        //GE_ES_CaseSearchAddProducts.ProductsWrapper Pw2 = new GE_ES_CaseSearchAddProducts.ProductsWrapper(product1);
        //PW.getprodRes();
        //List<PW> PWList = new List<PW>{};
        l_cs.pids = idList;
        //l_cs.pagingRecordsList = PWList;
        
        List<Product2> plist = new List<Product2>();
        Product2 p = new Product2();        
             p.Name = 'a test product';        
             p.ProductCode = 'xyz123'; 
             p.GE_ES_P_L__c = 'Env'; 
             p.GE_ES_Sub_P_L__c = 'Test Sub Env';    
             p.GE_ES_Product_Service__c = 'Test Service';  
             p.GE_ES_Offering__c = 'Test Offering'; 
             p.GE_ES_Oppty_Driver__c = 'Test Driver';
             p.Description = 'a description';        
             p.Family = 'a test family';
              p.GE_Tier1_PnL__c = 'Tier1';
             p.GE_Tier2_PnL__c = 'Tier2';
             p.GE_Tier3_PnL__c = 'Tier3';
             p.GE_Tier4_PnL__c = 'Tier4';
             p.GE_Tier5_PnL__c = 'Tier5';
             p.GE_Tier6_PnL__c = 'Tier6';
             p.GEEM_HstEqpmt__c = 'Host Equip';
             p.Technology__c = 'Tech' ;
             p.GEEM_ProLn__c = 'Line';
             p.GEEM_ProOffng__c = 'Offering';  
             p.isactive = true;
             p.CurrencyIsoCode = 'USD';
             p.BigMachines__Part_Number__c = '';
             p.isactive= true;
             plist.add(p);
             insert plist;
        
        
        system.debug('>>>>>>>>>'+ l_cs.PBE.GE_ES_Oppty_Driver__c );
   
        l_cs.PBE = product1;
   
        l_cs.resultsStartNumber = 2;
        l_cs.resultsStopNumber = 1;
        l_cs.isPreviousRender = False;
        l_cs.isNextRender = false;
        l_cs.isResultFound = false;
        l_cs.proBook = false;
        l_cs.ListIndex = 3;
        l_cs.totalResults =4;
        l_cs.limitrows = 5;
        l_cs.selectedDriver = 'Hello';
        l_cs.selectedService = 'Hello';
        l_cs.selectedOffering = 'Hello';
        l_cs.ProductCode = '123';
        l_cs.PartNumber = '123';
        l_cs.chkFlag = False;
        l_cs.selectedProFamily = 'Hello';
        l_cs.selectedProHost = 'Hello';
        l_cs.selectedProTech = 'Hello';
        l_cs.selectedProLine = 'Hello';
        l_cs.selectedProOffering = 'Hello';
        l_cs.errorStatus = false;
        l_cs.PriceBookId ='Hello';
        l_cs.SearchString ='Hello';
    
        l_cs.ServiceLovs();
        l_cs.SubPnlLovs();
        l_cs.DriverLovs();
        
        system.debug('>>>>>>>>>'+ l_cs.PBE.GE_ES_Oppty_Driver__c );
        l_cs.selectedService = 'Hello';
        l_cs.OfferingLovs();
        l_cs.ProductSearch();
        l_cs.ProcessSelected();
        l_cs.getheaders();
        l_cs.populateLineItems();
        //l_cs.SavenMore();
         l_cs.pagingRecordsList = new  List<List<GE_ES_CaseSearchAddProducts.ProductsWrapper>>();
        l_cs.getNext();
         l_cs.pagingRecordsList = new  List<List<GE_ES_CaseSearchAddProducts.ProductsWrapper>>();
        l_cs.getPrevious();
        l_cs.ProTechLovs();
        l_cs.ProLineLovs();
        l_cs.ProOfferingLovs();
        
        l_cs.pagingRecordsList = new  List<List<GE_ES_CaseSearchAddProducts.ProductsWrapper>>();
        l_cs.caseobj= caseobj;
        l_cs.ProductFilterSearch();
        l_cs.saveEdit();
        l_cs.setCaseResolDate('Hello');
        l_cs.ProHostLovs();
       // l_cs.pagingRecordsList = new  List<List<GE_ES_CaseSearchAddProducts.ProductsWrapper>>();
        //GE_ES_CaseSearchAddProducts.ProductsWrapper Pw2 = new GE_ES_CaseSearchAddProducts.ProductsWrapper(p);
       // l_cs.callpopulateitems();
        l_cs.pagingRecordsList = new  List<List<GE_ES_CaseSearchAddProducts.ProductsWrapper>>();
        l_cs.getprodRes();
        test.stopTest();
        
      //  l_cs.setCaseProdList(LstCli);
    }
    
    
    testmethod static void runCaseSearchAddProducts3(){
        
        ApexPages.StandardController stdContr;
        test.startTest();
        GE_ES_CaseSearchAddProducts l_cs = new GE_ES_CaseSearchAddProducts(stdContr);
        List<SelectOption> svalues = new List<SelectOption>{};
        sValues.add(new SelectOption('Blank','Blank'));
        l_cs.ServiceValues = svalues;
        List<SelectOption> ovalues = new List<SelectOption>{};
        ovalues.add(new SelectOption('Blank','Blank'));
        l_cs.OfferingValues = ovalues;
        l_cs.PBE = new Product2(Name='TestProduct',IsActive=TRUE,GE_ES_Oppty_Driver__c = 'All',GE_Tier1_PnL__c = 'Tier1',GE_Tier2_PnL__c = 'Tier2',GE_Tier3_PnL__c = 'Tier3',GE_Tier4_PnL__c = 'Tier4',GE_Tier5_PnL__c = 'Tier5',GE_Tier6_PnL__c = 'Tier6');
        l_cs.ProFamilyValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProHostValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProTechValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProLineValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProOfferingValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        List<id> idList = new List<id>{};
        //List<ProductsWrapper> PW = new List<ProductsWrapper>();
        //List<PW> PWList = new List<PW>{};
        l_cs.pids = idList;
        //l_cs.pagingRecordsList = PWList;
   
        system.debug('>>>>>>>>>'+ l_cs.PBE.GE_ES_Oppty_Driver__c );
   
        l_cs.resultsStartNumber = 2;
        l_cs.resultsStopNumber = 1;
        l_cs.isPreviousRender = False;
        l_cs.isNextRender = false;
        l_cs.isResultFound = false;
        l_cs.proBook = false;
        l_cs.ListIndex = 3;
        l_cs.totalResults =4;
        l_cs.limitrows = 5;
        l_cs.selectedDriver = 'Hello';
        l_cs.selectedService = 'Hello';
        l_cs.selectedOffering = 'Hello';
        l_cs.ProductCode = '123';
        l_cs.PartNumber = '123';
        l_cs.chkFlag = False;
        l_cs.selectedProFamily = 'Hello';
        l_cs.selectedProHost = 'Hello';
        l_cs.selectedProTech = 'Hello';
        l_cs.selectedProLine = 'Hello';
        l_cs.selectedProOffering = 'Hello';
        l_cs.errorStatus = false;
        l_cs.PriceBookId ='Hello';
        l_cs.SearchString ='Hello';
        
        l_cs.ServiceLovs();
        l_cs.SubPnlLovs();
        l_cs.DriverLovs();
        
        system.debug('>>>>>>>>>'+ l_cs.PBE.GE_ES_Oppty_Driver__c );
        l_cs.OfferingLovs();
        l_cs.ProductSearch();
        l_cs.ProcessSelected();
        l_cs.getheaders();
        l_cs.populateLineItems();
       // l_cs.SavenMore();
       // l_cs.getNext();
       // l_cs.getPrevious();
        
        l_cs.ProLineLovs();
        l_cs.ProOfferingLovs();
       // l_cs.ProductFilterSearch();
        l_cs.saveEdit();
        l_cs.setCaseResolDate('Hello');
        l_cs.ProHostLovs();
        //l_cs.callpopulateitems();
        //l_cs.getprodRes();
        test.stopTest();
        
      //  l_cs.setCaseProdList(LstCli);
    }
    
    testmethod static void runCaseSearchAddProducts4(){
        
        ApexPages.StandardController stdContr;
        test.startTest();
        GE_ES_CaseSearchAddProducts l_cs = new GE_ES_CaseSearchAddProducts(stdContr);
        List<SelectOption> svalues = new List<SelectOption>{};
        sValues.add(new SelectOption('Blank','Blank'));
        l_cs.ServiceValues = svalues;
        List<SelectOption> ovalues = new List<SelectOption>{};
        ovalues.add(new SelectOption('Blank','Blank'));
        l_cs.OfferingValues = ovalues;
        l_cs.PBE = new Product2(Name='TestProduct',IsActive=TRUE,GE_ES_Oppty_Driver__c = 'All',GE_Tier1_PnL__c = 'Tier1',GE_Tier2_PnL__c = 'Tier2',GE_Tier3_PnL__c = 'Tier3',GE_Tier4_PnL__c = 'Tier4',GE_Tier5_PnL__c = 'Tier5',GE_Tier6_PnL__c = 'Tier6');
        l_cs.ProFamilyValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProHostValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProTechValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProLineValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProOfferingValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        List<id> idList = new List<id>{};
        //List<ProductsWrapper> PW = new List<ProductsWrapper>();
        //List<PW> PWList = new List<PW>{};
        l_cs.pids = idList;
        //l_cs.pagingRecordsList = PWList;
   
        system.debug('>>>>>>>>>'+ l_cs.PBE.GE_ES_Oppty_Driver__c );
   
        l_cs.resultsStartNumber = 2;
        l_cs.resultsStopNumber = 1;
        l_cs.isPreviousRender = False;
        l_cs.isNextRender = false;
        l_cs.isResultFound = false;
        l_cs.proBook = false;
        l_cs.ListIndex = 3;
        l_cs.totalResults =4;
        l_cs.limitrows = 5;
        l_cs.selectedDriver = 'Hello';
        l_cs.selectedService = 'Hello';
        l_cs.selectedOffering = 'Hello';
        l_cs.ProductCode = '123';
        l_cs.PartNumber = '123';
        l_cs.chkFlag = False;
        l_cs.selectedProFamily = 'Hello';
        l_cs.selectedProHost = 'Hello';
        l_cs.selectedProTech = 'Hello';
        l_cs.selectedProLine = 'Hello';
        l_cs.selectedProOffering = 'Hello';
        l_cs.errorStatus = false;
        l_cs.PriceBookId ='Hello';
        l_cs.SearchString ='Hello';
        
        l_cs.ServiceLovs();
        l_cs.SubPnlLovs();
        l_cs.DriverLovs();
        
        system.debug('>>>>>>>>>'+ l_cs.PBE.GE_ES_Oppty_Driver__c );
        l_cs.OfferingLovs();
        l_cs.ProductSearch();
        l_cs.ProcessSelected();
        l_cs.getheaders();
        l_cs.populateLineItems();
       // l_cs.SavenMore();
       // l_cs.getNext();
       // l_cs.getPrevious();
  
        l_cs.ProOfferingLovs();
       // l_cs.ProductFilterSearch();
        l_cs.saveEdit();
        l_cs.setCaseResolDate('Hello');
        l_cs.ProHostLovs();
        //l_cs.callpopulateitems();
        //l_cs.getprodRes();
        test.stopTest();
        
      //  l_cs.setCaseProdList(LstCli);
    }
    
      testmethod static void runCaseSearchAddProducts6(){
        
        ApexPages.StandardController stdContr;
        test.startTest();
        GE_ES_CaseSearchAddProducts l_cs = new GE_ES_CaseSearchAddProducts(stdContr);
        List<SelectOption> svalues = new List<SelectOption>{};
        sValues.add(new SelectOption('Blank','Blank'));
        l_cs.ServiceValues = svalues;
        List<SelectOption> ovalues = new List<SelectOption>{};
        ovalues.add(new SelectOption('Blank','Blank'));
        l_cs.OfferingValues = ovalues;
        l_cs.PBE = new Product2(Name='TestProduct',IsActive=TRUE,GE_ES_Oppty_Driver__c = 'All',BigMachines__Part_Number__c = '',GE_Tier1_PnL__c = 'Tier1',GE_Tier2_PnL__c = 'Tier2',GE_Tier3_PnL__c = 'Tier3',GE_Tier4_PnL__c = 'Tier4',GE_Tier5_PnL__c = 'Tier5',GE_Tier6_PnL__c = 'Tier6');
        l_cs.ProFamilyValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProHostValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProTechValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProLineValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProOfferingValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        List<id> idList = new List<id>{};
       // List<ProductsWrapper> PW = new List<ProductsWrapper>();
        //List<PW> PWList = new List<PW>{};
        l_cs.pids = idList;
        //l_cs.pagingRecordsList = PWList;
        string SearchString = '';
        string ProductCode = '';
        system.debug('>>>>>>>>>'+ l_cs.PBE.GE_ES_Oppty_Driver__c );
   
        l_cs.resultsStartNumber = 2;
        l_cs.resultsStopNumber = 1;
        l_cs.isPreviousRender = False;
        l_cs.isNextRender = false;
        l_cs.isResultFound = false;
        l_cs.proBook = false;
        l_cs.ListIndex = 3;
        l_cs.totalResults =4;
        l_cs.limitrows = 5;
        l_cs.selectedDriver = 'Hello';
        l_cs.selectedService = 'Hello';
        l_cs.selectedOffering = 'Hello';
        l_cs.ProductCode = '123';
        l_cs.PartNumber = '123';
        l_cs.chkFlag = False;
        l_cs.selectedProFamily = 'Hello';
        l_cs.selectedProHost = 'Hello';
        l_cs.selectedProTech = 'Hello';
        l_cs.selectedProLine = 'Hello';
        l_cs.selectedProOffering = 'Hello';
        l_cs.errorStatus = false;
        l_cs.PriceBookId ='Hello';
        l_cs.SearchString ='Hello';
    
       // l_cs.getNext();
        //l_cs.SavenMore();
      //  l_cs.ProductFilterSearch();
        l_cs.saveEdit();
        l_cs.setCaseResolDate('Hello');
        l_cs.ProHostLovs();
        //l_cs.callpopulateitems();
        //l_cs.getprodRes();
        test.stopTest();
        
      //  l_cs.setCaseProdList(LstCli);
    }
    testmethod static void runCaseSearchAddProducts5(){
        
        ApexPages.StandardController stdContr;
        test.startTest();
        GE_ES_CaseSearchAddProducts l_cs = new GE_ES_CaseSearchAddProducts(stdContr);
        List<SelectOption> svalues = new List<SelectOption>{};
        sValues.add(new SelectOption('Blank','Blank'));
        l_cs.ServiceValues = svalues;
        List<SelectOption> ovalues = new List<SelectOption>{};
        ovalues.add(new SelectOption('Blank','Blank'));
        l_cs.OfferingValues = ovalues;
        l_cs.PBE = new Product2(Name='TestProduct',IsActive=TRUE,GE_ES_Oppty_Driver__c = 'All',BigMachines__Part_Number__c = '',GE_Tier1_PnL__c = 'Tier1',GE_Tier2_PnL__c = 'Tier2',GE_Tier3_PnL__c = 'Tier3',GE_Tier4_PnL__c = 'Tier4',GE_Tier5_PnL__c = 'Tier5',GE_Tier6_PnL__c = 'Tier6');
        l_cs.ProFamilyValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProHostValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProTechValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProLineValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        l_cs.ProOfferingValues = new List<SelectOption>{new SelectOption('Blank','Blank')};
        List<id> idList = new List<id>{};
       // List<ProductsWrapper> PW = new List<ProductsWrapper>();
        //List<PW> PWList = new List<PW>{};
        l_cs.pids = idList;
        //l_cs.pagingRecordsList = PWList;
        string SearchString = '';
        string ProductCode = '';
        system.debug('>>>>>>>>>'+ l_cs.PBE.GE_ES_Oppty_Driver__c );
   
        l_cs.resultsStartNumber = 2;
        l_cs.resultsStopNumber = 1;
        l_cs.isPreviousRender = False;
        l_cs.isNextRender = false;
        l_cs.isResultFound = false;
        l_cs.proBook = false;
        l_cs.ListIndex = 3;
        l_cs.totalResults =4;
        l_cs.limitrows = 5;
        l_cs.selectedDriver = 'Hello';
        l_cs.selectedService = 'Hello';
        l_cs.selectedOffering = 'Hello';
        l_cs.ProductCode = '123';
        l_cs.PartNumber = '123';
        l_cs.chkFlag = False;
        l_cs.selectedProFamily = 'Hello';
        l_cs.selectedProHost = 'Hello';
        l_cs.selectedProTech = 'Hello';
        l_cs.selectedProLine = 'Hello';
        l_cs.selectedProOffering = 'Hello';
        l_cs.errorStatus = false;
        l_cs.PriceBookId ='Hello';
        l_cs.SearchString ='Hello';
        
        l_cs.ServiceLovs();
        l_cs.SubPnlLovs();
        l_cs.DriverLovs();
        
        system.debug('>>>>>>>>>'+ l_cs.PBE.GE_ES_Oppty_Driver__c );
        l_cs.OfferingLovs();
        l_cs.ProductSearch();
        l_cs.ProcessSelected();
        l_cs.getheaders();
        l_cs.populateLineItems();
       // l_cs.SavenMore();
        //l_cs.getNext();
       // l_cs.getPrevious();
       // l_cs.ProductFilterSearch();
        l_cs.saveEdit();
        l_cs.setCaseResolDate('Hello');
        l_cs.ProHostLovs();
        //l_cs.callpopulateitems();
        //l_cs.getprodRes();
        test.stopTest();
        
      //  l_cs.setCaseProdList(LstCli);
    }
    
    
    testmethod static void runCaseSearchAddProducts1(){
    List<Product2> plist = new List<Product2>();
           Product2 p = new Product2();
             p.Name = 'a test product';        
             p.ProductCode = 'xyz123'; 
             p.GE_ES_P_L__c = 'Env'; 
             p.GE_ES_Sub_P_L__c = 'Test Sub Env';    
             p.GE_ES_Product_Service__c = 'Test Service';  
             p.GE_ES_Offering__c = 'Test Offering'; 
             p.GE_ES_Oppty_Driver__c = 'Test Driver';
             p.Description = 'a description';        
             p.Family = 'a test family';
             p.GE_Tier1_PnL__c = 'Tier1';
             p.GE_Tier2_PnL__c = 'Tier2';
             p.GE_Tier3_PnL__c = 'Tier3';
             p.GE_Tier4_PnL__c = 'Tier4';
             p.GE_Tier5_PnL__c = 'Tier5';
             p.GE_Tier6_PnL__c = 'Tier6';
             p.GEEM_HstEqpmt__c = 'Host Equip';
             p.Technology__c = 'Tech' ;
             p.GEEM_ProLn__c = 'Line';
             p.GEEM_ProOffng__c = 'Offering';  
             plist.add(p);
             insert plist;
             
              GE_Case_Product__c cli = new GE_Case_Product__c();
             List<GE_Case_Product__c> LstCli = new List<GE_Case_Product__c>();
                  
            // cli.GE_ES_Case__c = c.Id;
             cli.GE_ES_ProdctName__c = plist[0].id;
             cli.GE_ES_ProdNamHid__c = (string)plist[0].Name;
             cli.GE_ES_P_L_Temp__c = (string)plist[0].GE_ES_P_L__c;
             cli.GE_ES_SubPL_Hid__c = (string)plist[0].GE_ES_Sub_P_L__c;
             cli.GE_ES_OptyDrvHid__c = (string)plist[0].GE_ES_Oppty_Driver__c;
             cli.GE_ES_ProdSerHid__c = (string)plist[0].GE_ES_Product_Service__c;
             cli.GE_ES_OffrngHid__c = (string)plist[0].GE_ES_Offering__c;
             cli.GE_ES_ProdCodHid__c = (string)plist[0].ProductCode;
             cli.GE_ES_ProdDesHid__c= (string)plist[0].Description;

             LstCli.add(cli);
        
         PageReference pageRef = Page.GE_ES_SearchAddCaseProducts;
         Test.setCurrentPageReference(pageRef);
                   
        // ApexPages.currentPage().getParameters().put('id', c.Id); 
         ApexPages.currentPage().getParameters().put('prod', '1'); 
    }
    
    testmethod static void runCaseSearchAddProducts7()
    {
        ApexPages.StandardController stdContr;
        
        test.startTest();
        GE_ES_CaseSearchAddProducts objCaseSerachAddProducts = new GE_ES_CaseSearchAddProducts(stdContr);
        
        Case objCase = new Case(Status = 'New', CurrencyIsoCode = 'USD');
        insert objCase;
        
        objCaseSerachAddProducts.CaseObj = objCase;
        
        Product2 p = new Product2();
        p.Name = 'a test product';        
        p.ProductCode = 'xyz123'; 
        p.GE_ES_P_L__c = 'Env'; 
        p.GE_ES_Sub_P_L__c = 'Test Sub Env';    
        p.GE_ES_Product_Service__c = 'Test Service';  
        p.GE_ES_Offering__c = 'Test Offering'; 
        p.GE_ES_Oppty_Driver__c = 'Test Driver';
        p.Description = 'a description';        
        p.Family = 'a test family';
        p.GE_Tier1_PnL__c = 'Tier1';
        p.GE_Tier2_PnL__c = 'Tier2';
        p.GE_Tier3_PnL__c = 'Tier3';
        p.GE_Tier4_PnL__c = 'Tier4';
        p.GE_Tier5_PnL__c = 'Tier5';
        p.GE_Tier6_PnL__c = 'Tier6';
        p.GEEM_HstEqpmt__c = 'Host Equip';
        p.Technology__c = 'Tech' ;
        p.GEEM_ProLn__c = 'Line';
        p.GEEM_ProOffng__c = 'Offering';
        p.CurrencyIsoCode = 'USD';
        p.IsActive = true;
        insert p;
        
        objCaseSerachAddProducts.PBE = p;
        objCaseSerachAddProducts.pids = new List<Id>();
        objCaseSerachAddProducts.pids.add(p.id);
        objCaseSerachAddProducts.pagingRecordsList = new List<List<GE_ES_CaseSearchAddProducts.ProductsWrapper>>();
        objCaseSerachAddProducts.ProductFilterSearch();
        objCaseSerachAddProducts.ListIndex = 2;
        GE_ES_CaseSearchAddProducts.ProductsWrapper objProductsWrapper = new GE_ES_CaseSearchAddProducts.ProductsWrapper(p);
        List<GE_ES_CaseSearchAddProducts.ProductsWrapper> lst1 = new List<GE_ES_CaseSearchAddProducts.ProductsWrapper>();
        lst1.add(objProductsWrapper);
        objCaseSerachAddProducts.pagingRecordsList.add(lst1);
        objCaseSerachAddProducts.resultsStartNumber = 0;
        objCaseSerachAddProducts.resultsStopNumber = 100;
        objCaseSerachAddProducts.totalResults = 100;
        objCaseSerachAddProducts.getPrevious();
        objCaseSerachAddProducts.getNext();
        objCaseSerachAddProducts.SavenMore();
        
        GE_Case_Product__c cli = new GE_Case_Product__c();
        List<GE_Case_Product__c> LstCli = new List<GE_Case_Product__c>();
        cli.GE_ES_ProdctName__c = p.id;
        cli.GE_ES_ProdNamHid__c = (string)p.Name;
        cli.GE_ES_P_L_Temp__c = (string)p.GE_ES_P_L__c;
        cli.GE_ES_SubPL_Hid__c = (string)p.GE_ES_Sub_P_L__c;
        cli.GE_ES_OptyDrvHid__c = (string)p.GE_ES_Oppty_Driver__c;
        cli.GE_ES_ProdSerHid__c = (string)p.GE_ES_Product_Service__c;
        cli.GE_ES_OffrngHid__c = (string)p.GE_ES_Offering__c;
        cli.GE_ES_ProdCodHid__c = (string)p.ProductCode;
        cli.GE_ES_ProdDesHid__c= (string)p.Description;
        cli.GE_ES_Case__c = objCase.Id;
        LstCli.add(cli);
        insert LstCli;
        objCaseSerachAddProducts.callpopulateitems();
         
        objCaseSerachAddProducts.setCaseProdList(LstCli); 
        objCaseSerachAddProducts.SavenMore(); 
        test.stopTest();      
    }
}