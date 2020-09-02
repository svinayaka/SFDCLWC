/*
Class Name : GE_ES_CaseSearchAddProducts
Used Where ? : 
Purpose/Overview : Test class for the controller GE_ES_CaseSearchAddProducts
Functional Area : Service Management (Case)
Author: Jayaraju Nulakachandanam
Created Date: July 13th,2011
Test Class Name : TestGE_ES_CaseSearchAddProducts

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
 
*/

@isTest
private class TestGE_ES_CaseSearchAddProducts
{

    //Test method for Case Products functionality    
     static testMethod void TestGE_ES_CaseSearchAddProducts1()
     {
        /* Profile pro =[select id from profile where name like 'System Administrator' limit 1 ];
         User u =[select id from user where profileId=:pro.id and isActive = true limit 1];
         //Preparing the test data
         GEESGlobalContextController.ESProductFlag = true;
         //Creating new account record
         Account a = new Account();
         //Account a1 = createAccount();
         //Recordtype cmf1 = [select id from Recordtype where  SobjectType = 'Account' and name = 'GE Legal Entity'];
         //a1.recordtypeid = cmf1.id;       
         //System.runas(u){
         //upsert a1;
         //}
            
         a.Name = 'a test account';
         a.GE_HQ_Request_Status__c = 'CMF Approved';        
         a.BillingCountry = 'USA';        
         a.ShippingStreet = '123 Test Ave.';        
         a.ShippingCity = 'Testville';        
         a.ShippingState = 'FL';        
         a.ShippingPostalCode = '32951';        
         a.ShippingCountry = 'Argentina';
         a.GE_HQ_SIC1__c=7359;
         a.GE_HQ_SIC2__c=7363;
         a.GE_HQ_SIC3__c=7370;       
         insert a; 
         a.GE_HQ_SIC1__c=6153;
         a.GE_HQ_SIC2__c=6159;
         a.GE_HQ_SIC3__c=6162;
         update a; */
    
         //Creating new Case record
        /* Case c = createCase(a);

         GE_ES_Sales_Region__c sreg1 = [select id from GE_ES_Sales_Region__c where name = 'India' limit 1]; 

         Product2 p2 = createProduct();
         
         List<GE_Case_Product__c> LstCli = new List<GE_Case_Product__c>();
         
         List<Product2> plist = new List<Product2>();
         for(integer i = 0; i< 50; i++)
         {
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
         } 
         insert plist;
                
         integer j=0;
         for(integer i=0;i<50;i++)
         {
             GE_Case_Product__c cli = new GE_Case_Product__c();
                   
             cli.GE_ES_Case__c = c.Id;
             cli.GE_ES_ProdctName__c = plist[j].id;
             cli.GE_ES_ProdNamHid__c = (string)plist[j].Name;
             cli.GE_ES_P_L_Temp__c = (string)plist[j].GE_ES_P_L__c;
             cli.GE_ES_SubPL_Hid__c = (string)plist[j].GE_ES_Sub_P_L__c;
             cli.GE_ES_OptyDrvHid__c = (string)plist[j].GE_ES_Oppty_Driver__c;
             cli.GE_ES_ProdSerHid__c = (string)plist[j].GE_ES_Product_Service__c;
             cli.GE_ES_OffrngHid__c = (string)plist[j].GE_ES_Offering__c;
             cli.GE_ES_ProdCodHid__c = (string)plist[j].ProductCode;
             cli.GE_ES_ProdDesHid__c= (string)plist[j].Description;

             LstCli.add(cli);
             j++;
               
         } 
            
         PageReference pageRef = Page.GE_ES_SearchAddCaseProducts;
         Test.setCurrentPageReference(pageRef);
                   
         ApexPages.currentPage().getParameters().put('id', c.Id);
         ApexPages.currentPage().getParameters().put('prod', '1');
          
            
         //Construct the standard controller
         ApexPages.StandardController con = new ApexPages.StandardController(c);
            
         //Create the controller
         GE_ES_CaseSearchAddProducts  ext = new GE_ES_CaseSearchAddProducts(con);
         //ext.ListIndex = null;
         ext.populateLineItems();

         insert LstCli; 
         List<GE_Case_Product__c> cliLst = new List<GE_Case_Product__c>();
         List<id> ids = new List<id>();
         for(integer k = 0 ;k<30;k++)
         {
             ids.add(plist[k].id);  
             //cliLst.add(LstCli[k]);                                           
         }
         ext.SearchString = 'testxx';

         ext.ProductSearch(); 
         ext.ProductFilterSearch();               
         ext.populateLineItems();         
         
         PageReference pg31 = ext.populateLineItems();

         // Switch to test context
         
        
         //ext.Selected.add(p2.id);
         //ext.SelectedPnL = p2.GE_ES_P_L__c;
         ext.PBE.GE_ES_P_L__c = p2.GE_ES_P_L__c;
         ext.SubPnlLovs();
         //ext.SelectedSubPnL = p2.GE_ES_Sub_P_L__c;
         ext.PBE.GE_ES_Sub_P_L__c = p2.GE_ES_Sub_P_L__c;
         ext.DriverLovs();
         ext.PBE.GE_ES_Oppty_Driver__c = p2.GE_ES_Oppty_Driver__c;
         ext.ServiceLovs();
         ext.SelectedService = p2.GE_ES_Product_Service__c;
         ext.OfferingLovs();
         ext.SelectedOffering = p2.GE_ES_Offering__c;                  
         ext.ProductFilterSearch();
         ext.SearchString = p2.Name;
         ext.ProductCode = p2.ProductCode;
           
         
         ext.ProductSearch();
    
            
         string[] str = ext.getheaders();
         ext.getPrevious();
         ext.getNext();
         PageReference pg6 = ext.ProcessSelected();
         
         PageReference pg3 = ext.populateLineItems();
         ext.setCaseProdList(cliLst);
         PageReference pg4 = ext.SavenMore();
         
         ApexPages.currentPage().getParameters().put('addTo', c.Id);         
            
         cliLst.clear();
         for(integer k = 0 ;k<30;k++)
         {   
            //LstCli[k].Quantity = 0;             
            cliLst.add(LstCli[k]);                                           
         }
         ext.setCaseProdList(cliLst);
         PageReference pg41 = ext.saveEdit();
           
         cliLst.clear();
         for(integer k = 0 ;k<30;k++)
         {   
             LstCli[k].GE_ES_Serial_Nbr__c = '123456';   
             LstCli[k].GE_ES_Rec_Action__c = 'Credit';     
             cliLst.add(LstCli[k]);                                           
         }
         ext.setCaseProdList(cliLst);
         PageReference pg42 = ext.saveEdit();
            
         cliLst.clear();
         for(integer k = 0 ;k<30;k++)
         {   
             LstCli[k].GE_ES_Serial_Nbr__c = '123456';
             LstCli[k].GE_ES_Rec_Action__c = 'Credit';   
             LstCli[k].GE_ES_Primary__c = true;    
             cliLst.add(LstCli[k]);                                           
         }
         ext.setCaseProdList(cliLst);
         PageReference pg43 = ext.saveEdit();
           
            
         cliLst.clear();
         for(integer k = 0 ;k<30;k++)
         {   
             LstCli[k].GE_ES_Primary__c = true;
             LstCli[k].GE_ES_Rec_Action__c = 'Credit'; 
             LstCli[k].GE_ES_Serial_Nbr__c = '123456';   
             cliLst.add(LstCli[k]);                                           
         }
         ext.setCaseProdList(cliLst);
         PageReference pg44 = ext.saveEdit();
          
         cliLst.clear();
         for(integer k = 0 ;k<30;k++)
         {   
             LstCli[k].GE_ES_Primary__c = true;
             LstCli[k].GE_ES_Rec_Action__c = 'Credit'; 
             LstCli[k].GE_ES_Serial_Nbr__c = '123456'; 
             LstCli[k].GE_ES_ProdctName__c = plist[k].id;  
             LstCli[k].GE_ES_Lead_Time__c = 'Test Time';     
             cliLst.add(LstCli[k]);                                           
         }
         ext.setCaseProdList(cliLst);
         PageReference pg45 = ext.saveEdit();
          
          
         for(integer k = 0 ;k<30;k++)
         {                           
             LstCli[k].GE_ES_ProdctName__c = plist[k].id;                 
             cliLst.add(LstCli[k]);                                           
         }
         ext.setCaseProdList(cliLst);
         PageReference pg46 = ext.saveEdit();
         system.assertequals(cliLst[0].GE_ES_Case__c,c.id);
         ext.ListIndex = 1;
         ext.resultsStartNumber = 2;
         ext.resultsStopNumber = 2;
         //ext.getPrevious();
         ext.ListIndex = 0;
         ext.getNext();
         //ext.SelectedPnL = 'testxyz';
         ext.ProductFilterSearch();     
         update c;        
         cliLst.clear();
         Delete c;
        
         for(integer k = 0 ;k<30;k++)
         {                           
             LstCli[k].GE_ES_ProdctName__c = plist[k].id;                 
             cliLst.add(LstCli[k]);                                           
         }
         ext.setCaseProdList(cliLst);
         PageReference pg47 = ext.saveEdit();
         ext.PBE.GE_Tier1_PnL__c = 'Tier1';
         ext.PBE.GE_Tier2_PnL__c = 'Tier2';
         ext.PBE.GE_Tier3_PnL__c = 'Tier3';
         ext.PBE.GE_Tier4_PnL__c = 'Tier4';
         ext.PBE.GE_Tier5_PnL__c = 'Tier5';
         ext.PBE.GE_Tier6_PnL__c = 'Tier6';
          Test.startTest();
         ext.ProHostLovs();
         
         ext.selectedProHost = 'Host Equip';
         ext.ProTechLovs();
         ext.selectedProTech = 'Tech' ;
         ext.ProLineLovs();
         ext.selectedProLine = 'Line';
         ext.ProOfferingLovs();
         ext.selectedProOffering = 'Offering';
         ext.ProductFilterSearch(); 
         Test.stopTest(); */         
        
    }    
    
    //Test method for Case Products functionality    
    static testMethod void TestGE_ES_SearchAddCaseProducts2()
    {
        /*Profile pro =[select id from profile where name like 'System Administrator' limit 1 ];
         User u =[select id from user where profileId=:pro.id and isActive = true limit 1];
        //preparing the test data
        GEESGlobalContextController.ESProductFlag = true;
        Account a = new Account();
        //Account a1 = createAccount();
        //Recordtype cmf1 = [select id from Recordtype where  SobjectType = 'Account' and name = 'GE Legal Entity'];
        //a1.recordtypeid = cmf1.id; 
        //system.runas(u){      
        //upsert a1;
        //}
        
        a.Name = 'a test account';
        a.GE_HQ_Request_Status__c = 'CMF Approved';        
        a.BillingCountry = 'USA';        
        a.ShippingStreet = '123 Test Ave.';        
        a.ShippingCity = 'Testville';        
        a.ShippingState = 'FL';        
        a.ShippingPostalCode = '32951';        
        a.ShippingCountry = 'Argentina';
        a.GE_HQ_SIC1__c=7359;
        a.GE_HQ_SIC2__c=7363;
        a.GE_HQ_SIC3__c=7370;       
        insert a; 
        a.GE_HQ_SIC1__c=6153;
        a.GE_HQ_SIC2__c=6159;
        a.GE_HQ_SIC3__c=6162;
        update a;

        Case c = createCase(a);

        GE_ES_Sales_Region__c sreg1 = [select id from GE_ES_Sales_Region__c where name = 'India' limit 1]; 

        Product2 p2 = createProduct();
        
        List<GE_Case_Product__c> LstCli = new List<GE_Case_Product__c>();
        
        List<Product2> plist = new List<Product2>();
        for(integer i = 0; i< 100; i++)
          {
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
            p.Isactive = true;
            plist.add(p);
          } 
          insert plist;

        integer j=0;
        //system.assertequals(LstCli[0].GE_ES_Case__c,c.Id);
     
        
        PageReference pageRef = Page.GE_ES_SearchAddCaseProducts;
        Test.setCurrentPageReference(pageRef);
                
        ApexPages.currentPage().getParameters().put('id', c.Id);
        ApexPages.currentPage().getParameters().put('prod', '1');
        
        
        //Construct the standard controller
        ApexPages.StandardController con = new ApexPages.StandardController(c);
        
        //create the controller
        GE_ES_CaseSearchAddProducts  ext = new GE_ES_CaseSearchAddProducts(con);
        
        insert LstCli; 
        List<id> ids = new List<id>();
        for(integer k = 0 ;k<30;k++)
        {
            ids.add(plist[k].id);                                             
        }
        
        // Switch to test context
        Test.startTest();
        
        ext.PBE.GE_ES_P_L__c = '21554zz';
                
        ext.ProductFilterSearch();

        system.debug('****298***');
        ext.SearchString = '%';        
        ext.ProductSearch();
        ext.callpopulateitems();
        string[] str = ext.getheaders();
        ext.getPrevious();
        ext.getNext();
        ext.ProductSearch();
        ext.callpopulateitems();
        
        PageReference pg98 = ext.populateLineItems();
        PageReference pg6 = ext.ProcessSelected();
        PageReference pg99 = ext.populateLineItems();
        ext.chkFlag = true;
        
              
        ext.ProductFilterSearch();
        
        
        ext.getCaseResolDate();
        ext.setCaseResolDate('test');
        ext.getCaseResolDate();
        ext.getprodRes();
        
        ext.PBE.GE_ES_Sub_P_L__c = 'Test Sub Env';   
        
        ext.PBE.GE_ES_Oppty_Driver__c = 'Test Driver';
        ext.ServiceLovs();
        
        ext.PBE.GE_ES_Product_Service__c = 'Test Service';  
        ext.OfferingLovs();
        ext.PBE.GE_ES_Offering__c = 'Test Offering'; 
        ext.ProductFilterSearch();
        
        ext.PBE.GE_ES_Oppty_Driver__c = 'All';
        ext.SelectedDriver = 'Test Driver';
        ext.ServiceLovs();
        
        Test.stopTest();*/
        
        
        
    } 
    
    static testMethod void TestGE_ES_SearchAddCaseProducts3(){
    /*Profile pro =[select id from profile where name like 'System Administrator' limit 1 ];
         User u =[select id from user where profileId=:pro.id and isActive = true limit 1];
        //preparing the test data
        GEESGlobalContextController.ESProductFlag = true;
        Account a = new Account();
        //Account a1 = createAccount();
        //Recordtype cmf1 = [select id from Recordtype where  SobjectType = 'Account' and name = 'GE Legal Entity'];
        //a1.recordtypeid = cmf1.id; 
        //system.runas(u){      
        //upsert a1;
        //}
        
        a.Name = 'a test account';
        a.GE_HQ_Request_Status__c = 'CMF Approved';        
        a.BillingCountry = 'USA';        
        a.ShippingStreet = '123 Test Ave.';        
        a.ShippingCity = 'Testville';        
        a.ShippingState = 'FL';        
        a.ShippingPostalCode = '32951';        
        a.ShippingCountry = 'Argentina';
        a.GE_HQ_SIC1__c=7359;
        a.GE_HQ_SIC2__c=7363;
        a.GE_HQ_SIC3__c=7370;       
        insert a; 
        a.GE_HQ_SIC1__c=6153;
        a.GE_HQ_SIC2__c=6159;
        a.GE_HQ_SIC3__c=6162;
        update a;

        Case c = createCase(a);

        GE_ES_Sales_Region__c sreg1 = [select id from GE_ES_Sales_Region__c where name = 'India' limit 1]; 

        Product2 p2 = createProduct();
        
        List<GE_Case_Product__c> LstCli = new List<GE_Case_Product__c>();
        
        List<Product2> plist = new List<Product2>();
        for(integer i = 0; i< 100; i++)
          {
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
            p.GE_Tier1_PnL__c='Energy Management (EM)';
            p.GE_Tier2_PnL__c='Digital Energy (DE)';
            p.GE_Tier3_PnL__c='Smart Grid';
            p.GE_Tier4_PnL__c='Metering & Sensing Systems';
            p.GE_Tier5_PnL__c='Meters';
            p.GE_Tier6_PnL__c='ANSI';              
            p.Isactive = true;
            plist.add(p);
          } 
          insert plist;

        integer j=0;
        //system.assertequals(LstCli[0].GE_ES_Case__c,c.Id);
        Test.startTest();
        
        PageReference pageRef = Page.GE_ES_SearchAddCaseProducts;
        Test.setCurrentPageReference(pageRef);
                
        ApexPages.currentPage().getParameters().put('id', c.Id);
        ApexPages.currentPage().getParameters().put('prod', '1');
        
        
        //Construct the standard controller
        ApexPages.StandardController con = new ApexPages.StandardController(c);
        
    //create the controller
        GE_ES_CaseSearchAddProducts  ext = new GE_ES_CaseSearchAddProducts(con);
        
        //ext.ProHostLovs();
        ext.ProTechLovs();
        ext.ProLineLovs();
        ext.ProOfferingLovs();
        Test.stopTest(); */
    } 
    
    //Method to create an account               
    public static void createAccount() 
    {        
        /*Account a = new Account();        
        a.Name = 'a test account';        
        a.BillingCountry = 'USA';        
        a.ShippingStreet = '123 Test Ave.';        
        a.ShippingCity = 'Testville';        
        a.ShippingState = 'FL';        
        a.ShippingPostalCode = '32951';        
        a.ShippingCountry = 'USA';        
        insert a;  */      
                  
    }
    
    //Method to create Case
    public static void createCase(Account a) 
    {        
        /*Case c = new Case();        
        c.GE_ES_INDSCasePL__c = 'IN PSS';        
        c.AccountID = a.Id;        
        c.Status = 'New';        
        //c.ClosedDate = Date.today().addDays(10);
        c.GE_ES_PO__c = 'Test PO';
        c.GE_ES_Shop_Order__c = 'Test GE Reference Order';
        c.GE_ES_Resolution_Date__c = Date.today().addDays(10);
         
        insert c;        
         */   
    }
     

    
    //Method to Create Product
    public static void createProduct() 
    {        
       /* Product2 p = new Product2();        
        p.Name = 'a test product';        
        p.ProductCode = 'xyz123'; 
        p.GE_ES_P_L__c = 'Env'; 
        p.GE_ES_Sub_P_L__c = 'Test Sub Env';    
        p.GE_ES_Product_Service__c = 'Test Service';  
        p.GE_ES_Offering__c = 'Test Offering'; 
        p.GE_ES_Oppty_Driver__c = 'Test Driver';
        p.IsActive = true;
        p.Description = 'a description';        
        p.Family = 'a test family';        
        insert p;        
          */ 
    }        
    

    
    //Method to create Case line item
    /*public static GE_Case_Product__c createCaseLineItem(Case c, Product2 p, Decimal price) 
    {        
        GE_Case_Product__c cli = new GE_Case_Product__c();
        //Set<Id> selectedIds = new Set<id>();
                
        cli.GE_ES_Case__c = c.Id;        
        cli.GE_ES_ProdctName__c = p.id;
        cli.GE_ES_ProdNamHid__c = (string)p.Name;
        cli.GE_ES_P_L_Temp__c = (string)p.GE_ES_P_L__c;
        cli.GE_ES_SubPL_Hid__c = (string)p.GE_ES_Sub_P_L__c;
        cli.GE_ES_OptyDrvHid__c = (string)p.GE_ES_Oppty_Driver__c;
        cli.GE_ES_ProdSerHid__c = (string)p.GE_ES_Product_Service__c;
        cli.GE_ES_OffrngHid__c = (string)p.GE_ES_Offering__c;
        cli.GE_ES_ProdCodHid__c = (string)p.ProductCode;
        cli.GE_ES_ProdDesHid__c= (string)p.Description;       
      
        insert cli;        
           
    }*/

}