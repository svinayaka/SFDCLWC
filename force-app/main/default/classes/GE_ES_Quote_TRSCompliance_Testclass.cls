/*
Test Class Name: GE_ES_Quote_TRSCompliance_Testclass
Used In : GE_ES_Quote_TRSCompliance Trigger on Quote Line Item
Purpose/Overview : Test Class to calculate the code coverage for GE_ES_Quote_TRSCompliance Trigger on Quote Line Item
Functional Area : Opportunity Management
Author: Rekha N 
Created Date: 5/23/2011
Test Class Name : 


Change History -
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
15/06/2011    :Prasad Yadala       :                               : Modfied to compare the Install Country with TRS Country Name
07/09/2011    :Prasad Yadala       :                               : Modfied to clear the too many soql query exceptions
28/11/2011    :Sneha Joshi         :                               : Modified to calculate the code coverage for GEPWAeroApproveQuote class
19/12/2011    :Prasad Yadala       :                               : Modfied for the requirement R-5674
*/

@isTest
private class GE_ES_Quote_TRSCompliance_Testclass
{
    /*static testMethod void GE_ES_Quote_TRSCompliance_testmethod() 
    {  
        GE_ES_Sales_Region__c sr = new GE_ES_Sales_Region__c(GE_ES_P_L__c = 'ES',   GE_ES_External_ID__c = 'testsrnew123',Name = 'Test SR');
        insert sr;
        GE_ES_Sales_Region__c sr2 = new GE_ES_Sales_Region__c(GE_ES_P_L__c = 'ES',   GE_ES_External_ID__c = 'testsrnew1243',Name = 'Test SR2');
        insert sr2;
        
        GE_ES_Country_State_Sales_Region__c countryssr = new GE_ES_Country_State_Sales_Region__c();
        countryssr.GE_ES_Country_Code__c = 'testtrs';
        countryssr.GE_ES_Country_Name__c = 'ABU DHABI';
        countryssr.GE_ES_Sales_Region__c = sr.id;
        insert countryssr;
        
        GE_ES_Country_State_Sales_Region__c countryssr2 = new GE_ES_Country_State_Sales_Region__c(GE_ES_Country_Code__c = 'testtrs2',GE_ES_Country_Name__c = 'testtrs12',GE_ES_Sales_Region__c = sr2.id);
        insert countryssr2;
        
        GE_ES_TRS_Compliance__c trs = new GE_ES_TRS_Compliance__c();
        trs.GE_ES_Country_Code__c = 'ABU DHABI';
        trs.GE_ES_Product_Code__c = 'sstestprodcodetersss';
        trs.GE_ES_Country_Name__c = 'ABU DHABI';
        insert trs;
        System.assertEquals(trs.GE_ES_Country_Code__c ,'ABU DHABI');
        GE_ES_TRS_Compliance__c trs2 = new GE_ES_TRS_Compliance__c(GE_ES_Country_Code__c = 'testcountrycode',GE_ES_Product_Code__c = 'testprodcodeters',GE_ES_Country_Name__c = 'testcountrycode');
        insert trs2;
        
        Account testacc = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',testacc.Name);
               
        Opportunity oppty= CommonTestDataFactory_GE_OG.createOppty('Testopportunity',testacc.ID);
        system.assertEquals('Testopportunity',oppty.Name);
        List<Product2> prodList = new List<Product2>();
        Product2 prod = new Product2();
        prod.name = 'testproduct';
       
        prod.GE_ES_P_L__c = 'Lufkin';
        prod.ProductCode = 'testprodcode';
        prodList.add(prod);
    
        Product2 prod2 = new Product2();
        prod2.name = 'testproductt';
       
        prod2.GE_ES_P_L__c = 'Lufkin';
        prod2.ProductCode = 'testprodcodeters';
        prodList.add(prod2);

        Product2 prod3 = new Product2();
        prod3.name = 'testproducttt';
       
        prod3.GE_ES_P_L__c = 'Lufkin';
        prod3.ProductCode = 'sstestprodcodetersss';
        prodList.add(prod3);
        
        Insert prodList;
        Id probookid = [select Id from Pricebook2 where isStandard=true limit 1][0].Id;
        List<PricebookEntry> pbelist = new List<PricebookEntry>();
        PricebookEntry p = new PricebookEntry();        
        p.Product2Id = prod.Id;        
        p.Pricebook2Id = probookid;        
        p.UnitPrice = 100;        
        p.UseStandardPrice = false;        
        p.IsActive = true;        
        pbelist.add(p);        
        
        PricebookEntry p2 = new PricebookEntry();        
        p2.Product2Id = prod2.Id;        
        p2.Pricebook2Id = probookid;        
        p2.UnitPrice = 100;        
        p2.UseStandardPrice = false;        
        p2.IsActive = true;        
        pbelist.add(p2);   
        
        PricebookEntry p3 = new PricebookEntry();        
        p3.Product2Id = prod3.Id;        
        p3.Pricebook2Id = probookid;        
        p3.UnitPrice = 100;        
        p3.UseStandardPrice = false;        
        p3.IsActive = true;        
        pbelist.add(p3);
        
        Insert pbelist;
        
    
        Contact cont = new Contact();
        cont.FirstName = 'Raadhika';
        cont.LastName = 'Reddy';
        cont.accountid =testacc.id;
        cont.GE_ES_I_Agree_picklist__c='Yes';
        cont.MobilePhone = '9999999999';
        insert cont;
        
        Id qtrecid = [select id,name from recordtype where name like 'GE ES DE Quote' and SobjectType = 'Quote'].id;
        List<Quote> quoteList = new List<Quote>();
        Quote quote1 = new Quote();
        quote1.name = 'testquote';
        quote1.opportunityid = oppty.id;
        quote1.Pricebook2Id = probookid; 
        quote1.Recordtypeid = qtrecid ;
        quote1.Contactid = cont.Id;
        
        Quote quote2 = new Quote(name = 'testquote',opportunityid = oppty.id, Pricebook2Id = probookid,Recordtypeid = qtrecid ,Contactid = cont.Id);
        quoteList.add(quote1);
        quoteList.add(quote2);
        
        Id qtrecid1 = [select id,name from recordtype where name like 'GE ES DE Quote' and SobjectType = 'Quote'].id;
        List<Quote> quoteList1 = new List<Quote>();
        Quote qt1 = new Quote();
        qt1.name = 'testquote';
        qt1.opportunityid = oppty.id;
        qt1.Pricebook2Id = probookid; 
        qt1.Recordtypeid = qtrecid1 ;
        qt1.Contactid = cont.Id;
        qt1.GE_PW_Aero_Stage__c = 'R2';
        quoteList.add(qt1);
        
        Quote qt2 = new Quote();
        qt2.name = 'testquote';
        qt2.opportunityid = oppty.id;
        qt2.Pricebook2Id = probookid; 
        qt2.Recordtypeid = qtrecid1 ;
        qt2.Contactid = cont.Id;
        qt2.GE_PW_Aero_Stage__c = 'R1';
        quoteList.add(qt2);
        
        Quote qt3 = new Quote();
        qt3.name = 'testquote';
        qt3.opportunityid = oppty.id;
        qt3.Pricebook2Id = probookid; 
        qt3.Recordtypeid = qtrecid1 ;
        qt3.Contactid = cont.Id;
        qt3.GE_PW_Aero_Stage__c = 'R3';
        quoteList.add(qt3);
          
        insert quoteList;
        
        List<QuoteLineItem> qliList = new List<QuoteLineItem>();
        
        QuoteLineItem quoteline = new QuoteLineItem();
        quoteline.PricebookEntryId = p.id;
        quoteline.quoteid = quote1.id;
        quoteline.UnitPrice = 100;
        quoteline.Quantity = 2;
        qliList.add(quoteline);

        QuoteLineItem quoteline2 = new QuoteLineItem();
        quoteline2.PricebookEntryId = p2.id;
        quoteline2.quoteid = quote1.id;
        quoteline2.UnitPrice = 100;
        quoteline2.Quantity = 2;
        qliList.add(quoteline2);

        QuoteLineItem quoteline4 = new QuoteLineItem();
        quoteline4.PricebookEntryId = p3.id;
        quoteline4.quoteid = quote1.id;
        quoteline4.UnitPrice = 100;
        quoteline4.Quantity = 2;
        qliList.add(quoteline4);          
        

        QuoteLineItem quoteline3 = new QuoteLineItem();
        quoteline3.PricebookEntryId = p.id;
        quoteline3.quoteid = quote2.id;
        quoteline3.UnitPrice = 100;
        quoteline3.Quantity = 2;
        qliList.add(quoteline3);        
       
        
        
        
        List<QuoteLineItem> qliList1 = new List<QuoteLineItem>();
        
        QuoteLineItem quoteline6 = new QuoteLineItem();
        quoteline6.PricebookEntryId = p.id;
        quoteline6.quoteid = qt1.id;
        quoteline6.UnitPrice = 100;
        quoteline6.Quantity = 2;
        qliList.add(quoteline6);

        QuoteLineItem quoteline5 = new QuoteLineItem();
        quoteline5.PricebookEntryId = p2.id;
        quoteline5.quoteid = qt1.id;
        quoteline5.UnitPrice = 100;
        quoteline5.Quantity = 2;
        qliList.add(quoteline5);
        
        insert qliList;
                    
       //GEPWAeroApproveQuote obj = new GEPWAeroApproveQuote();
       //GEPWAeroApproveQuote.ApproveAndClone(qt1.Id);
        
    }
    
    static testMethod void GE_ES_Quote_TRSCompliance_testmethod1() 
    {
       // Account accObj =[select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and GE_HQ_Request_Status__c = 'CMF Approved' limit 1];          
        Account testacc = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',testacc.Name);
        
        Opportunity oppty = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',testacc.ID);
              system.assertEquals('Testopportunity',oppty.Name);
              System.assertEquals(oppty.StageName,'Prospecting');
        List<Product2> prodList = new List<Product2>();
        Product2 prod = new Product2();
        prod.name = 'testproduct';
       
        prod.GE_ES_P_L__c = 'Lufkin';
        prod.ProductCode = 'testprodcode';
        prodList.add(prod);
    
        Product2 prod2 = new Product2();
        prod2.name = 'testproductt';
       
        prod2.GE_ES_P_L__c = 'Lufkin';
        prod2.ProductCode = 'testprodcodeters';
        prodList.add(prod2);

        Product2 prod3 = new Product2();
        prod3.name = 'testproducttt';
       
        prod3.GE_ES_P_L__c = 'Lufkin';
        prod3.ProductCode = 'sstestprodcodetersss';
        prodList.add(prod3);
        
        Insert prodList;
        Id probookid = [select Id from Pricebook2 where isStandard=true limit 1][0].Id; 
        List<PricebookEntry> pbelist = new List<PricebookEntry>();
        PricebookEntry p = new PricebookEntry();        
        p.Product2Id = prod.Id;        
        p.Pricebook2Id = probookid;        
        p.UnitPrice = 100;        
        p.UseStandardPrice = false;        
        p.IsActive = true;        
        pbelist.add(p);        
        
        PricebookEntry p2 = new PricebookEntry();        
        p2.Product2Id = prod2.Id;        
        p2.Pricebook2Id = probookid;        
        p2.UnitPrice = 100;        
        p2.UseStandardPrice = false;        
        p2.IsActive = true;        
        pbelist.add(p2);   
        
        PricebookEntry p3 = new PricebookEntry();        
        p3.Product2Id = prod3.Id;        
        p3.Pricebook2Id = probookid;        
        p3.UnitPrice = 100;        
        p3.UseStandardPrice = false;        
        p3.IsActive = true;        
        pbelist.add(p3);
        
        Insert pbelist;
        
        List<Opportunitylineitem> oliList = new List<Opportunitylineitem>();
        Opportunitylineitem optyline = new Opportunitylineitem();
        optyline.PricebookEntryId  = p.id;
        optyline.opportunityid = oppty.id;
        optyline.Quantity = 1;
        optyline.GE_ES_Primary_Quote__c = true ; 
        optyline.UnitPrice = 100;
        oliList.add(optyline);

        Opportunitylineitem optyline2 = new Opportunitylineitem();
        optyline2.PricebookEntryId  = p2.id;
        optyline2.opportunityid = oppty.id;
        optyline2.Quantity = 1;
        //optyline2.GE_ES_Primary_Quote__c = true ; 
        optyline2.UnitPrice = 100;
        oliList.add(optyline2);

        Opportunitylineitem optyline3 = new Opportunitylineitem();
        optyline3.PricebookEntryId  = p3.id;
        optyline3.opportunityid = oppty.id;
        optyline3.Quantity = 1;
        //optyline2.GE_ES_Primary_Quote__c = true ; 
        optyline3.UnitPrice = 100;
        oliList.add(optyline3);
    
        Contact cont = new Contact();
        cont.FirstName = 'Raadhika';
        cont.LastName = 'Reddy';
        cont.accountid =testacc.id;
        cont.GE_ES_I_Agree_picklist__c='Yes';
        cont.MobilePhone = '9999999999';
        insert cont;
        
                
        Id qtrecid1 = [select id,name from recordtype where name like 'GE ES DE Quote' and SobjectType = 'Quote'].id;
        List<Quote> quoteList1 = new List<Quote>();
        Quote qt1 = new Quote();
        qt1.name = 'testquote';
        qt1.opportunityid = oppty.id;
        qt1.Pricebook2Id = probookid; 
        qt1.Recordtypeid = qtrecid1 ;
        qt1.Contactid = cont.Id;
        qt1.GE_PW_Aero_Stage__c = 'R2';
        quoteList1.add(qt1);
        
        Quote qt2 = new Quote();
        qt2.name = 'testquote';
        qt2.opportunityid = oppty.id;
        qt2.Pricebook2Id = probookid; 
        qt2.Recordtypeid = qtrecid1 ;
        qt2.Contactid = cont.Id;
        qt2.GE_PW_Aero_Stage__c = 'R1';
        quoteList1.add(qt2);
        
        Quote qt3 = new Quote();
        qt3.name = 'testquote';
        qt3.opportunityid = oppty.id;
        qt3.Pricebook2Id = probookid; 
        qt3.Recordtypeid = qtrecid1 ;
        qt3.Contactid = cont.Id;
        qt3.GE_PW_Aero_Stage__c = 'R3';
        quoteList1.add(qt3);
        
        insert quoteList1;
        
        List<QuoteLineItem> qliList1 = new List<QuoteLineItem>();
        
        QuoteLineItem quoteline6 = new QuoteLineItem();
        quoteline6.PricebookEntryId = p.id;
        quoteline6.quoteid = qt1.id;
        quoteline6.UnitPrice = 100;
        quoteline6.Quantity = 2;
        qliList1.add(quoteline6);

        QuoteLineItem quoteline5 = new QuoteLineItem();
        quoteline5.PricebookEntryId = p2.id;
        quoteline5.quoteid = qt1.id;
        quoteline5.UnitPrice = 100;
        quoteline5.Quantity = 2;
        qliList1.add(quoteline5);
        
        insert qliList1;
        
    }
    
    static testMethod void GE_ES_Quote_TRSCompliance_testmethod2() 
    {
        Account accObj =[select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and GE_HQ_Request_Status__c = 'CMF Approved' limit 1];          
        
        Id probookid = [select Id from Pricebook2 where isStandard=true limit 1][0].Id;        
        Opportunity oppty = new Opportunity();
        
        oppty.name = 'Test';
        oppty.accountid =accObj.id;
        oppty.GE_ES_Customer_Type__c = 'Channel-Distributor';
        oppty.RecordTypeId = [select id,name from recordtype where name like 'OG SS Opportunity' and SobjectType = 'Opportunity'].id;
        oppty.install_country_ge_og__c = 'ABU DHABI';
        oppty.StageName = 'Prospect';
        oppty.Pricebook2Id = probookid; 
        oppty.CloseDate = date.today();
        oppty.GE_ES_NRE_Site__c = 'No';
        insert oppty;
        System.assertEquals(oppty.name ,'Test');
        List<Product2> prodList = new List<Product2>();
        Product2 prod = new Product2();
        prod.name = 'testproduct';
       
        prod.GE_ES_P_L__c = 'Lufkin';
        prod.ProductCode = 'testprodcode';
        prodList.add(prod);
    
        Product2 prod2 = new Product2();
        prod2.name = 'testproductt';
       
        prod2.GE_ES_P_L__c = 'Lufkin';
        prod2.ProductCode = 'testprodcodeters';
        prodList.add(prod2);

        Product2 prod3 = new Product2();
        prod3.name = 'testproducttt';
       
        prod3.GE_ES_P_L__c = 'Lufkin';
        prod3.ProductCode = 'sstestprodcodetersss';
        prodList.add(prod3);
        
        Insert prodList;
        
        List<PricebookEntry> pbelist = new List<PricebookEntry>();
        PricebookEntry p = new PricebookEntry();        
        p.Product2Id = prod.Id;        
        p.Pricebook2Id = probookid;        
        p.UnitPrice = 100;        
        p.UseStandardPrice = false;        
        p.IsActive = true;        
        pbelist.add(p);        
        
        PricebookEntry p2 = new PricebookEntry();        
        p2.Product2Id = prod2.Id;        
        p2.Pricebook2Id = probookid;        
        p2.UnitPrice = 100;        
        p2.UseStandardPrice = false;        
        p2.IsActive = true;        
        pbelist.add(p2);   
        
        PricebookEntry p3 = new PricebookEntry();        
        p3.Product2Id = prod3.Id;        
        p3.Pricebook2Id = probookid;        
        p3.UnitPrice = 100;        
        p3.UseStandardPrice = false;        
        p3.IsActive = true;        
        pbelist.add(p3);
        
        Insert pbelist;
        
        List<Opportunitylineitem> oliList = new List<Opportunitylineitem>();
        Opportunitylineitem optyline = new Opportunitylineitem();
        optyline.PricebookEntryId  = p.id;
        optyline.opportunityid = oppty.id;
        optyline.Quantity = 1;
        optyline.GE_ES_Primary_Quote__c = true ; 
        optyline.UnitPrice = 100;
        oliList.add(optyline);

        Opportunitylineitem optyline2 = new Opportunitylineitem();
        optyline2.PricebookEntryId  = p2.id;
        optyline2.opportunityid = oppty.id;
        optyline2.Quantity = 1;
        //optyline2.GE_ES_Primary_Quote__c = true ; 
        optyline2.UnitPrice = 100;
        oliList.add(optyline2);

        Opportunitylineitem optyline3 = new Opportunitylineitem();
        optyline3.PricebookEntryId  = p3.id;
        optyline3.opportunityid = oppty.id;
        optyline3.Quantity = 1;
        //optyline2.GE_ES_Primary_Quote__c = true ; 
        optyline3.UnitPrice = 100;
        oliList.add(optyline3);
    
        Contact cont = new Contact();
        cont.FirstName = 'Raadhika';
        cont.LastName = 'Reddy';
        cont.accountid =accObj.id;
        cont.GE_ES_I_Agree_picklist__c='Yes';
        cont.MobilePhone = '9999999999';
        insert cont;
        
                
        Id qtrecid1 = [select id,name from recordtype where name like 'GE ES DE Quote' and SobjectType = 'Quote'].id;
        List<Quote> quoteList1 = new List<Quote>();
        Quote qt1 = new Quote();
        qt1.name = 'testquote';
        qt1.opportunityid = oppty.id;
        qt1.Pricebook2Id = probookid; 
        qt1.Recordtypeid = qtrecid1 ;
        qt1.Contactid = cont.Id;
        qt1.GE_PW_Aero_Stage__c = 'R2';
        quoteList1.add(qt1);
        
        Quote qt2 = new Quote();
        qt2.name = 'testquote';
        qt2.opportunityid = oppty.id;
        qt2.Pricebook2Id = probookid; 
        qt2.Recordtypeid = qtrecid1 ;
        qt2.Contactid = cont.Id;
        qt2.GE_PW_Aero_Stage__c = 'R1';
        quoteList1.add(qt2);
        
        Quote qt3 = new Quote();
        qt3.name = 'testquote';
        qt3.opportunityid = oppty.id;
        qt3.Pricebook2Id = probookid; 
        qt3.Recordtypeid = qtrecid1 ;
        qt3.Contactid = cont.Id;
        qt3.GE_PW_Aero_Stage__c = 'R3';
        quoteList1.add(qt3);
        
        insert quoteList1;
        
        
        
        //user usr = [select id,name from User where profile.name='GE_PW_Aero_Svcs_Business_Admin' limit 1];
        
        GEPWAeroApproveQuote obj = new GEPWAeroApproveQuote();
        GEPWAeroApproveQuote.ApproveAndClone(qt2.Id);
    }
    
    static testMethod void GE_ES_Quote_TRSCompliance_testmethod3() 
    {
        Account accObj =[select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and GE_HQ_Request_Status__c = 'CMF Approved' limit 1];          
        
        Id probookid = [select Id from Pricebook2 where isStandard=true limit 1][0].Id;        
        Opportunity oppty = new Opportunity();
        
        oppty.name = 'Test';
        oppty.accountid =accObj.id;
        oppty.GE_ES_Customer_Type__c = 'Channel-Distributor';
        oppty.RecordTypeId = [select id,name from recordtype where name like 'OG SS Opportunity' and SobjectType = 'Opportunity'].id;
        oppty.install_country_ge_og__c = 'ABU DHABI';
        oppty.StageName = 'Prospect';
        oppty.Pricebook2Id = probookid; 
        oppty.CloseDate = date.today();
        oppty.GE_ES_NRE_Site__c = 'No';
        insert oppty;
        System.assertEquals(oppty.name ,'Test');
        List<Product2> prodList = new List<Product2>();
        Product2 prod = new Product2();
        prod.name = 'testproduct';
       
        prod.GE_ES_P_L__c = 'Lufkin';
        prod.ProductCode = 'testprodcode';
        prodList.add(prod);
    
        Product2 prod2 = new Product2();
        prod2.name = 'testproductt';
       
        prod2.GE_ES_P_L__c = 'Lufkin';
        prod2.ProductCode = 'testprodcodeters';
        prodList.add(prod2);

        Product2 prod3 = new Product2();
        prod3.name = 'testproducttt';
       
        prod3.GE_ES_P_L__c = 'Lufkin';
        prod3.ProductCode = 'sstestprodcodetersss';
        prodList.add(prod3);
        
        Insert prodList;
        
        List<PricebookEntry> pbelist = new List<PricebookEntry>();
        PricebookEntry p = new PricebookEntry();        
        p.Product2Id = prod.Id;        
        p.Pricebook2Id = probookid;        
        p.UnitPrice = 100;        
        p.UseStandardPrice = false;        
        p.IsActive = true;        
        pbelist.add(p);        
        
        PricebookEntry p2 = new PricebookEntry();        
        p2.Product2Id = prod2.Id;        
        p2.Pricebook2Id = probookid;        
        p2.UnitPrice = 100;        
        p2.UseStandardPrice = false;        
        p2.IsActive = true;        
        pbelist.add(p2);   
        
        PricebookEntry p3 = new PricebookEntry();        
        p3.Product2Id = prod3.Id;        
        p3.Pricebook2Id = probookid;        
        p3.UnitPrice = 100;        
        p3.UseStandardPrice = false;        
        p3.IsActive = true;        
        pbelist.add(p3);
        
        Insert pbelist;
        
        List<Opportunitylineitem> oliList = new List<Opportunitylineitem>();
        Opportunitylineitem optyline = new Opportunitylineitem();
        optyline.PricebookEntryId  = p.id;
        optyline.opportunityid = oppty.id;
        optyline.Quantity = 1;
        optyline.GE_ES_Primary_Quote__c = true ; 
        optyline.UnitPrice = 100;
        oliList.add(optyline);

        Opportunitylineitem optyline2 = new Opportunitylineitem();
        optyline2.PricebookEntryId  = p2.id;
        optyline2.opportunityid = oppty.id;
        optyline2.Quantity = 1;
        //optyline2.GE_ES_Primary_Quote__c = true ; 
        optyline2.UnitPrice = 100;
        oliList.add(optyline2);

        Opportunitylineitem optyline3 = new Opportunitylineitem();
        optyline3.PricebookEntryId  = p3.id;
        optyline3.opportunityid = oppty.id;
        optyline3.Quantity = 1;
        //optyline2.GE_ES_Primary_Quote__c = true ; 
        optyline3.UnitPrice = 100;
        oliList.add(optyline3);
    
        Contact cont = new Contact();
        cont.FirstName = 'Raadhika';
        cont.LastName = 'Reddy';
        cont.accountid =accObj.id;
        cont.GE_ES_I_Agree_picklist__c='Yes';
        cont.MobilePhone = '9999999999';
        insert cont;
        
                
        Id qtrecid1 = [select id,name from recordtype where name like 'GE ES DE Quote' and SobjectType = 'Quote'].id;
        List<Quote> quoteList1 = new List<Quote>();
        Quote qt1 = new Quote();
        qt1.name = 'testquote';
        qt1.opportunityid = oppty.id;
        qt1.Pricebook2Id = probookid; 
        qt1.Recordtypeid = qtrecid1 ;
        qt1.Contactid = cont.Id;
        qt1.GE_PW_Aero_Stage__c = 'R2';
        quoteList1.add(qt1);
        
        Quote qt2 = new Quote();
        qt2.name = 'testquote';
        qt2.opportunityid = oppty.id;
        qt2.Pricebook2Id = probookid; 
        qt2.Recordtypeid = qtrecid1 ;
        qt2.Contactid = cont.Id;
        qt2.GE_PW_Aero_Stage__c = 'R1';
        quoteList1.add(qt2);
        
        Quote qt3 = new Quote();
        qt3.name = 'testquote';
        qt3.opportunityid = oppty.id;
        qt3.Pricebook2Id = probookid; 
        qt3.Recordtypeid = qtrecid1 ;
        qt3.Contactid = cont.Id;
        qt3.GE_PW_Aero_Stage__c = 'R3';
        quoteList1.add(qt3);
        
        insert quoteList1;
        
        
        
        //user usr = [select id,name from User where profile.name='GE_PW_Aero_Svcs_Business_Admin' limit 1];
        
        GEPWAeroApproveQuote obj = new GEPWAeroApproveQuote();
        GEPWAeroApproveQuote.ApproveAndClone(qt1.Id);
    }*/
    
    static testMethod void GE_ES_Quote_TRSCompliance_testmethod4() 
    {
        /*Account accObj =[select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and GE_HQ_Request_Status__c = 'CMF Approved' limit 1];          
        
        Id probookid = [select Id from Pricebook2 where isStandard=true limit 1][0].Id;        
        Opportunity oppty = new Opportunity();
        
        oppty.name = 'Test';
        oppty.accountid =accObj.id;
        oppty.GE_ES_Customer_Type__c = 'Channel-Distributor';
        oppty.RecordTypeId = [select id,name from recordtype where name like 'OG SS Opportunity' and SobjectType = 'Opportunity'].id;
        oppty.install_country_ge_og__c = 'ABU DHABI';
        oppty.StageName = 'Prospect';
        oppty.Pricebook2Id = probookid; 
        oppty.CloseDate = date.today();
        oppty.GE_ES_NRE_Site__c = 'No';
        insert oppty;
        System.assertEquals(oppty.name ,'Test');
        List<Product2> prodList = new List<Product2>();
        Product2 prod = new Product2();
        prod.name = 'testproduct';
       
        prod.GE_ES_P_L__c = 'Lufkin';
        prod.ProductCode = 'testprodcode';
        prodList.add(prod);
    
        Product2 prod2 = new Product2();
        prod2.name = 'testproductt';
       
        prod2.GE_ES_P_L__c = 'Lufkin';
        prod2.ProductCode = 'testprodcodeters';
        prodList.add(prod2);

        Product2 prod3 = new Product2();
        prod3.name = 'testproducttt';
       
        prod3.GE_ES_P_L__c = 'Lufkin';
        prod3.ProductCode = 'sstestprodcodetersss';
        prodList.add(prod3);
        
        Insert prodList;
        
        List<PricebookEntry> pbelist = new List<PricebookEntry>();
        PricebookEntry p = new PricebookEntry();        
        p.Product2Id = prod.Id;        
        p.Pricebook2Id = probookid;        
        p.UnitPrice = 100;        
        p.UseStandardPrice = false;        
        p.IsActive = true;        
        pbelist.add(p);        
        
        PricebookEntry p2 = new PricebookEntry();        
        p2.Product2Id = prod2.Id;        
        p2.Pricebook2Id = probookid;        
        p2.UnitPrice = 100;        
        p2.UseStandardPrice = false;        
        p2.IsActive = true;        
        pbelist.add(p2);   
        
        PricebookEntry p3 = new PricebookEntry();        
        p3.Product2Id = prod3.Id;        
        p3.Pricebook2Id = probookid;        
        p3.UnitPrice = 100;        
        p3.UseStandardPrice = false;        
        p3.IsActive = true;        
        pbelist.add(p3);
        
        Insert pbelist;
        
        List<Opportunitylineitem> oliList = new List<Opportunitylineitem>();
        Opportunitylineitem optyline = new Opportunitylineitem();
        optyline.PricebookEntryId  = p.id;
        optyline.opportunityid = oppty.id;
        optyline.Quantity = 1;
        optyline.GE_ES_Primary_Quote__c = true ; 
        optyline.UnitPrice = 100;
        oliList.add(optyline);

        Opportunitylineitem optyline2 = new Opportunitylineitem();
        optyline2.PricebookEntryId  = p2.id;
        optyline2.opportunityid = oppty.id;
        optyline2.Quantity = 1;
        //optyline2.GE_ES_Primary_Quote__c = true ; 
        optyline2.UnitPrice = 100;
        oliList.add(optyline2);

        Opportunitylineitem optyline3 = new Opportunitylineitem();
        optyline3.PricebookEntryId  = p3.id;
        optyline3.opportunityid = oppty.id;
        optyline3.Quantity = 1;
        //optyline2.GE_ES_Primary_Quote__c = true ; 
        optyline3.UnitPrice = 100;
        oliList.add(optyline3);*/
        
        account acc = CommonTestDataFactory_GE_OG.createRelationshipAccount ('Test Account');
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        //Create Product
        Product2 product = CommonTestDataFactory_GE_OG.createProduct('Test Product');
        
        //Create Price Book Entry
        PriceBookEntry prBook= CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
        
        //Craete oppty Product
        OpportunityLineItem oti = CommonTestDataFactory_GE_OG.createOpportunityLineItem(opp,prBook);
        
        
    
        Contact cont = new Contact();
        cont.FirstName = 'Raadhika';
        cont.LastName = 'Reddy';
        cont.accountid =acc.id;
        cont.GE_ES_I_Agree_picklist__c='Yes';
        cont.MobilePhone = '9999999999';
        //insert cont;
        
        Test.startTest();
        Id qtrecid1 = [select id,name from recordtype where name like 'GE ES DE Quote' and SobjectType = 'Quote'].id;
        List<Quote> quoteList1 = new List<Quote>();
        Quote qt1 = new Quote();
        qt1.name = 'testquote';
        qt1.opportunityid = opp.id;
        qt1.Pricebook2Id =  test.getStandardPricebookId();  
        qt1.Recordtypeid = qtrecid1 ;
        qt1.Contactid = cont.Id;
        qt1.GE_PW_Aero_Stage__c = 'R2';
        quoteList1.add(qt1);
        
        Quote qt2 = new Quote();
        qt2.name = 'testquote';
        qt2.opportunityid = opp.id;
        qt2.Pricebook2Id =  test.getStandardPricebookId();  
        qt2.Recordtypeid = qtrecid1 ;
        qt2.Contactid = cont.Id;
        qt2.GE_PW_Aero_Stage__c = 'R1';
        quoteList1.add(qt2);
        
        
        
        
        Quote qt3 = new Quote();
        qt3.name = 'testquote';
        qt3.opportunityid = opp.id;
        qt3.Pricebook2Id  = test.getStandardPricebookId(); 
        qt3.Recordtypeid = qtrecid1 ;
        qt3.Contactid = cont.Id;
        qt3.GE_PW_Aero_Stage__c = 'R3';
        quoteList1.add(qt3); 
        
        insert quoteList1;
        
        qt3.GE_PW_Aero_Stage__c = 'R2';
        Update quoteList1;
        //user usr = [select id,name from User where profile.name='GE_PW_Aero_Svcs_Business_Admin' limit 1];
        
        GEPWAeroApproveQuote obj = new GEPWAeroApproveQuote();
        try{
        GEPWAeroApproveQuote.ApproveAndClone(qt3.Id);
        
        }
        catch(Exception ex)
        {
        }
        Test.stopTest();
    }
    
    static testMethod void GE_ES_Quote_TRSCompliance_testmethod5() 
    {
     account acc = CommonTestDataFactory_GE_OG.createRelationshipAccount ('Test Account');
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        //Create Product
        Product2 product = CommonTestDataFactory_GE_OG.createProduct('Test Product');
        
        //Create Price Book Entry
        PriceBookEntry prBook= CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
        
        //Craete oppty Product
        OpportunityLineItem oti = CommonTestDataFactory_GE_OG.createOpportunityLineItem(opp,prBook);
        
        
    
        Contact cont = new Contact();
        cont.FirstName = 'Raadhika';
        cont.LastName = 'Reddy';
        cont.accountid =acc.id;
        cont.GE_ES_I_Agree_picklist__c='Yes';
        cont.MobilePhone = '9999999999';
        //insert cont;
        
        Test.startTest();     
        Id qtrecid1 = [select id,name from recordtype where name like 'GE ES DE Quote' and SobjectType = 'Quote'].id;
        List<Quote> quoteList1 = new List<Quote>();
        Quote qt1 = new Quote();
        qt1.name = 'testquote';
        qt1.opportunityid = opp.id;
        qt1.Pricebook2Id =  test.getStandardPricebookId();  
        qt1.Recordtypeid = qtrecid1 ;
        qt1.Contactid = cont.Id;
        qt1.GE_PW_Aero_Stage__c = 'R2';
        quoteList1.add(qt1);
        
        Quote qt2 = new Quote();
        qt2.name = 'testquote';
        qt2.opportunityid = opp.id;
        qt2.Pricebook2Id =  test.getStandardPricebookId();  
        qt2.Recordtypeid = qtrecid1 ;
        qt2.Contactid = cont.Id;
        qt2.GE_PW_Aero_Stage__c = 'R1';
        quoteList1.add(qt2);
        
        
        
        
        Quote qt3 = new Quote();
        qt3.name = 'testquote';
        qt3.opportunityid = opp.id;
        qt3.Pricebook2Id  = test.getStandardPricebookId(); 
        qt3.Recordtypeid = qtrecid1 ;
        qt3.Contactid = cont.Id;
        qt3.GE_PW_Aero_Stage__c = 'R3';
        quoteList1.add(qt3); 
        
        insert quoteList1;
      
        //user usr = [select id,name from User where profile.name='GE_PW_Aero_Svcs_Business_Admin' limit 1];
        /*
        GEPWAeroApproveQuote obj = new GEPWAeroApproveQuote();
        try{
        GEPWAeroApproveQuote.ApproveAndClone(qt3.Id);
        
        }
        catch(Exception ex)
        {
        }
        */
        
        Test.stopTest();    
     }
}