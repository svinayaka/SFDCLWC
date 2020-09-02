/*
Description : Test Class for the GEESPopulatePL_SRegion_eTax_CTC_CFM Trigger for 100%
Functional Area : Risk Management
Created By : Raj Burugupally 
Release : Ironman Release
last modified history:
02/05/2013    :himaja siddhanthi:                : for requirement R-11538
04/09/2014 : REmoved refrences for OLD opportunity record types as part of R-18673
*/



// Test Coverage done in Test Class : GE_OG_TM_ScopeofSupply_Tgr_Test_V2

@isTest
private class GEESPopulatePL_SRegion_eTax_CTC_CFM_Test {

/****

    Static TestMethod void populateRegion_Test() 
    {


   //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        Account le1 = [select id,ShippingCountry from Account where Name = 'TestClassAccount-LegalEntity' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
        //Energy Management
        Opportunity o=new Opportunity();
        o.AccountID = le.Id;        
        o.StageName = 'Prospect';        
        o.CloseDate = Date.today().addDays(10);        
        //o.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o.Name='Test Opportunity';
        o.GE_ES_GE_Bid_Legal_Entity_Name__c=le1.Id;
        o.GE_Tier2_ARegion__c='Rest2';
        o.RecordTypeId=optyRecordTypes.get('MCS').getRecordTypeId();
        optyList.add(o);

        //Turbo Machinery
        Opportunity o1=new Opportunity();
        o1.AccountID = le.Id;        
        o1.StageName = 'Prospect';        
        o1.CloseDate = Date.today().addDays(10);        
        //o.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o1.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o1.Name='Test Opportunity';
        o1.GE_OG_TM_Commercial_Center__c='USA';
       // o1.RecordTypeId=optyRecordTypes.get('OG TM Opportunity').getRecordTypeId();
       o1.RecordTypeId=optyRecordTypes.get('OG TMS Unit Opportunity').getRecordTypeId();
        o1.GE_OG_TM_Product_Line__c = 'Gas Turbine & Compressors';
        optyList.add(o1);        
        
        //PII Pipeline Solutions
        Opportunity o2=new Opportunity();
        o2.AccountID = le.Id;        
        o2.StageName = 'Prospect';        
        o2.CloseDate = Date.today().addDays(10);        
        //o2.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o2.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o2.Name='Test Opportunity';
        //o2.GE_OG_TM_Commercial_Center__c='USA'
        o2.RecordTypeId=optyRecordTypes.get('OG PII Opportunity').getRecordTypeId();
        optyList.add(o2);

        //OG GS Opportunity
        Opportunity o4=new Opportunity();
        o4.AccountID = le.Id;        
        //o4.End_User__c = le.Id;
        o4.StageName = 'Prospect';        
        o4.CloseDate = Date.today().addDays(10);        
        //o4.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o4.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o4.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o4.Name='Test Opportunity';
        //o4.GE_OG_TM_Commercial_Center__c='USA'
       // o4.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o4.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
       // optyList.add(o4);
        

        //OG D&P Opportunity
        Opportunity o5=new Opportunity();
        o5.AccountID = le.Id;        
        o5.StageName = 'Prospect';        
        o5.CloseDate = Date.today().addDays(10);        
        //o5.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o5.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o5.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o5.Name='Test Opportunity';
        //o5.GE_OG_TM_Commercial_Center__c='USA'
        o5.RecordTypeId=optyRecordTypes.get('OG D&S Opportunity').getRecordTypeId();
        optyList.add(o5);
        
        //OG SS Opportunity
        Opportunity o25=new Opportunity();
        o25.AccountID = le.Id;        
        o25.StageName = 'Prospect';        
        o25.CloseDate = Date.today().addDays(10);        
        //o5.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o5.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o25.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o25.Name='Test Opportunity';
        //o5.GE_OG_TM_Commercial_Center__c='USA'
        o25.RecordTypeId=optyRecordTypes.get('OG SS Opportunity').getRecordTypeId();
        optyList.add(o25);
       
        
       
        insert optyList; 
         System.assertEquals(o25.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).GE_Tier2_ARegion__c='Rest21';
        update optyList;
    }
    
    Static TestMethod void PartnerUserOppty_Test() 
    {


        //Create an Opportunity of Energy
        Account le = [select id from Account where Name = 'TestClassAccount-EndUser' limit 1]; 
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
        
        List<User> usrObj=[select Id,Name,isActive,UserType from User where Profile.Name like '%Partner Profile - Custom%' and isActive=true];
        List<Account> insAcc = new List<Account>(); 
        if(usrObj!=null && usrObj.size()>0)
        {
            System.runAs(usrObj[0])
            { 
                //Energy Management
                Opportunity o1=new Opportunity();
                o1.AccountID = le.Id; 
                o1.StageName = 'Prospect'; 
                o1.CloseDate = Date.today().addDays(10); 
                //o.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id; 
                //o.GE_HQ_Business_Tier1__c = 'Energy Management (EM)'; 
                o1.GE_OG_TM_Quote_Type__c = 'Engineering'; 
                o1.Name='Test Opportunity';
                //o1.GE_OG_TM_Commercial_Center__c='USA';
                //o1.RecordTypeId=optyRecordTypes.get('OG TM Opportunity').getRecordTypeId();
                o1.RecordTypeId=optyRecordTypes.get('OG TMS Unit Opportunity').getRecordTypeId();
                optyList.add(o1);
                
                Opportunity o2=new Opportunity();
                o2.AccountID = le.Id; 
                o2.StageName = 'Prospect'; 
                o2.CloseDate = Date.today().addDays(10); 
                //o2.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id; 
                //o2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)'; 
                o2.GE_OG_TM_Quote_Type__c = 'Engineering'; 
                o2.Name='Test Opportunity';
                //o2.GE_OG_TM_Commercial_Center__c='USA'
                o2.RecordTypeId=optyRecordTypes.get('OG PII Opportunity').getRecordTypeId(); 
                optyList.add(o2);
                
                try{ 
                insert optyList;
                update optyList;
                 System.assertEquals(o2.StageName,'Prospect');
                }catch(Exception exp) { System.debug('------exp-----'+exp);} 
            } 
        }
    }
    
    Static TestMethod void populateRegion_Test_OGGS1() 
    {


   //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
        //Energy Management
                              
        //OG GS Opportunity
        Opportunity o8=new Opportunity();
        o8.AccountID = le.Id;        
        o8.End_User__c=le.Id;
        o8.StageName = 'Prospect';        
        o8.CloseDate = Date.today().addDays(10);        
        //o8.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o8.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o8.GE_OG_TM_Quote_Type__c = 'Engineering';
        o8.GE_ES_PGS_Sub_P_L__c='Contractual Services (CS)';
        o8.GE_OG_GS_Prod_Srvc__c='Field Services'; 
        o8.Name='Test Opportunity';
        //o8.GE_OG_TM_Commercial_Center__c='USA'
       // o8.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o8.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o8);
        
        insert optyList; 
        System.assertEquals(o8.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }
    
    Static TestMethod void populateRegion_Test_OGGS2() 
    {


   //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
        //Energy Management
                              
        //OG GS Opportunity
        Opportunity o8=new Opportunity();
        o8.AccountID = le.Id;        
        o8.End_User__c=le.Id;
        o8.StageName = 'Prospect';        
        o8.CloseDate = Date.today().addDays(10);        
        //o8.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o8.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o8.GE_OG_TM_Quote_Type__c = 'Engineering';
        o8.GE_ES_PGS_Sub_P_L__c='Contractual Services (CS)';
        o8.GE_OG_GS_Prod_Srvc__c='Field Services'; 
        o8.Name='Test Opportunity';
        //o8.GE_OG_TM_Commercial_Center__c='USA'
       // o8.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o8.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o8);
        
        insert optyList; 
        System.assertEquals(o8.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }
    
    Static TestMethod void populateRegion_Test_OGGS3() 
    {


   //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o9=new Opportunity();
        o9.AccountID = le.Id;        
        o9.End_User__c=le.Id;
        o9.StageName = 'Prospect';        
        o9.CloseDate = Date.today().addDays(10);        
        //o9.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o9.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o9.GE_OG_TM_Quote_Type__c = 'Engineering';
        o9.GE_ES_PGS_Sub_P_L__c='Contractual Services (CS)';
        o9.GE_OG_GS_Prod_Srvc__c='Frame Agreements';
        o9.Name='Test Opportunity';
        //o9.GE_OG_TM_Commercial_Center__c='USA'
      //  o9.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
      o9.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o9);
        
        
        insert optyList; 
       System.assertEquals(o9.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }       
    
 Static TestMethod void populateRegion_Test_OGGS4() 
    {


   //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o10=new Opportunity();
        o10.AccountID = le.Id;        
        o10.End_User__c=le.Id;
        o10.StageName = 'Prospect';        
        o10.CloseDate = Date.today().addDays(10);        
        //o10.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o10.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o10.GE_OG_TM_Quote_Type__c = 'Engineering';
        o10.GE_ES_PGS_Sub_P_L__c='Contractual Services (CS)';
        o10.GE_OG_GS_Prod_Srvc__c='Maintenance Contracts'; 
        o10.Name='Test Opportunity';
        //o10.GE_OG_TM_Commercial_Center__c='USA'
      //  o10.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
      o10.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o10);
        
        insert optyList; 
        System.assertEquals(o10.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }   
    
    
    Static TestMethod void populateRegion_Test_OGGS5() 
    {


    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o11=new Opportunity();
        o11.AccountID = le.Id;        
        o11.End_User__c=le.Id;
        o11.StageName = 'Prospect';        
        o11.CloseDate = Date.today().addDays(10);        
        //o11.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o11.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o11.GE_OG_TM_Quote_Type__c = 'Engineering';
        o11.GE_ES_PGS_Sub_P_L__c='Core';
        o11.GE_OG_GS_Prod_Srvc__c='Training'; 
        o11.Name='Test Opportunity';
        //o11.GE_OG_TM_Commercial_Center__c='USA'
       // o11.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o11.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o11);

        
        insert optyList; 
        System.assertEquals(o11.Name,'Test Opportunity');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }
    
    Static TestMethod void populateRegion_Test_OGGS6() 
    {


    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o12=new Opportunity();
        o12.AccountID = le.Id;        
        o12.End_User__c=le.Id;
        o12.StageName = 'Prospect';        
        o12.CloseDate = Date.today().addDays(10);        
        //o12.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o12.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o12.GE_OG_TM_Quote_Type__c = 'Engineering';
        o12.GE_ES_PGS_Sub_P_L__c='Core';
        o12.GE_OG_GS_Prod_Srvc__c='Frame Agreements'; 
        o12.Name='Test Opportunity';
        //o12.GE_OG_TM_Commercial_Center__c='USA'
       // o12.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o12.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o12);

        
        insert optyList; 
        System.assertEquals(o12.StageName , 'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }   
    
    Static TestMethod void populateRegion_Test_OGGS7() 
    {


    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o13=new Opportunity();
        o13.AccountID = le.Id;        
        o13.End_User__c=le.Id;
        o13.StageName = 'Prospect';        
        o13.CloseDate = Date.today().addDays(10);        
        //o13.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o13.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o13.GE_OG_TM_Quote_Type__c = 'Engineering';
        o13.GE_ES_PGS_Sub_P_L__c='Core';
        o13.GE_OG_GS_Prod_Srvc__c='MMP'; 
        o13.Name='Test Opportunity';
        //o13.GE_OG_TM_Commercial_Center__c='USA'
       // o13.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o13.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o13);
        
        insert optyList; 
        System.assertEquals(o13.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }
    
    Static TestMethod void populateRegion_Test_OGGS8() 
    {


    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o14=new Opportunity();
        o14.AccountID = le.Id;        
        o14.End_User__c=le.Id;
        o14.StageName = 'Prospect';        
        o14.CloseDate = Date.today().addDays(10);        
        //o14.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o14.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o14.GE_OG_TM_Quote_Type__c = 'Engineering';
        o14.GE_ES_PGS_Sub_P_L__c='Global Services (GS) Multi P&L';
        o14.GE_OG_GS_Prod_Srvc__c='Frame Agreements'; 
        o14.Name='Test Opportunity';
        //o14.GE_OG_TM_Commercial_Center__c='USA'
       // o14.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o14.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o14);   
        
        insert optyList; 
        System.assertEquals(o14.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }  
    
    Static TestMethod void populateRegion_Test_OGGS9() 
    {


    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o15=new Opportunity();
        o15.AccountID = le.Id;        
        o15.End_User__c=le.Id;
        o15.StageName = 'Prospect';        
        o15.CloseDate = Date.today().addDays(10);        
        //o15.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o15.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o15.GE_OG_TM_Quote_Type__c = 'Engineering';
        o15.GE_ES_PGS_Sub_P_L__c='Processing';
        o15.GE_OG_GS_Prod_Srvc__c='Frame Agreements'; 
        o15.Name='Test Opportunity';
        //o15.GE_OG_TM_Commercial_Center__c='USA'
       // o15.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o15.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o15);    
        
        insert optyList; 
        System.assertEquals(o15.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }  
    
    Static TestMethod void populateRegion_Test_OGGS10() 
    {


    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o16=new Opportunity();
        o16.AccountID = le.Id;
        o16.End_User__c=le.Id;        
        o16.StageName = 'Prospect';        
        o16.CloseDate = Date.today().addDays(10);        
        //o16.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o16.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o16.GE_OG_TM_Quote_Type__c = 'Engineering';
        o16.GE_ES_PGS_Sub_P_L__c='Processing';
        o16.GE_OG_GS_Prod_Srvc__c='MMP';
        o16.Name='Test Opportunity';
        //o16.GE_OG_TM_Commercial_Center__c='USA'
        //o16.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
        o16.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o16);     
        
        insert optyList; 
        System.assertEquals(o16.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }  
    
    Static TestMethod void populateRegion_Test_OGGS11() 
    {


    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o17=new Opportunity();
        o17.AccountID = le.Id;
        o17.End_User__c=le.Id;        
        o17.StageName = 'Prospect';        
        o17.CloseDate = Date.today().addDays(10);        
        //o17.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o17.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o17.GE_OG_TM_Quote_Type__c = 'Engineering';
        o17.GE_ES_PGS_Sub_P_L__c='Processing';
        o17.GE_OG_GS_Prod_Srvc__c='Training'; 
        o17.Name='Test Opportunity';
        //o17.GE_OG_TM_Commercial_Center__c='USA'
        //o17.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
        o17.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o17);     
        
        insert optyList; 
        System.assertEquals(o17.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }     
    
    Static TestMethod void populateRegion_Test_OGGS12() 
    {


    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o18=new Opportunity();
        o18.AccountID = le.Id;   
        o18.End_User__c=le.Id;     
        o18.StageName = 'Prospect';        
        o18.CloseDate = Date.today().addDays(10);        
        //o18.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o18.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o18.GE_OG_TM_Quote_Type__c = 'Engineering';
        o18.GE_ES_PGS_Sub_P_L__c='Processing';
        o18.GE_OG_GS_Prod_Srvc__c='Upgrades'; 
        o18.Name='Test Opportunity';
        //o18.GE_OG_TM_Commercial_Center__c='USA'
       // o18.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o18.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o18);  
        
        insert optyList; 
        System.assertEquals(o18.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    } 
    
    Static TestMethod void populateRegion_Test_OGGS13() 
    {


    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o19=new Opportunity();
        o19.AccountID = le.Id;  
        o19.End_User__c=le.Id;      
        o19.StageName = 'Prospect';        
        o19.CloseDate = Date.today().addDays(10);        
        //o19.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o19.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o19.GE_OG_TM_Quote_Type__c = 'Engineering';
        o19.GE_ES_PGS_Sub_P_L__c='Solution';
        o19.GE_OG_GS_Prod_Srvc__c='Training'; 
        o19.Name='Test Opportunity';
        //o19.GE_OG_TM_Commercial_Center__c='USA'
        //o19.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
        o19.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o19);   
        
        insert optyList; 
        System.assertEquals(o19.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    } 
    
    Static TestMethod void populateRegion_Test_OGGS14() 
    {
    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o20=new Opportunity();
        o20.AccountID = le.Id;
        o20.End_User__c=le.Id;        
        o20.StageName = 'Prospect';        
        o20.CloseDate = Date.today().addDays(10);        
        //o20.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o20.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o20.GE_OG_TM_Quote_Type__c = 'Engineering';
        o20.GE_ES_PGS_Sub_P_L__c='Solution';
        o20.GE_OG_GS_Prod_Srvc__c='Frame Agreements'; 
        o20.Name='Test Opportunity';
        //o20.GE_OG_TM_Commercial_Center__c='USA'
       // o20.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o20.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o20);    
        
        insert optyList; 
        System.assertEquals(o20.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }
    
    Static TestMethod void populateRegion_Test_OGGS15() 
    {
    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //OG GS Opportunity
        Opportunity o20=new Opportunity();
        o20.AccountID = le.Id;
        o20.End_User__c=le.Id;        
        o20.StageName = 'Prospect';        
        o20.CloseDate = Date.today().addDays(10);        
        //o20.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o20.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o20.GE_OG_TM_Quote_Type__c = 'Engineering';
        o20.GE_ES_PGS_Sub_P_L__c='Solution';
        o20.GE_OG_GS_Prod_Srvc__c='Field Services'; 
        o20.Name='Test Opportunity';
        //o20.GE_OG_TM_Commercial_Center__c='USA'
       // o20.RecordTypeId=optyRecordTypes.get('OG GS Opportunity').getRecordTypeId();
       o20.RecordTypeId=optyRecordTypes.get('OG TMS Service Opportunity').getRecordTypeId();
        optyList.add(o20);    
        
        insert optyList; 
        System.assertEquals(o20.StageName,'Prospect');
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls','New State','Brezil'); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }     
    
    Static TestMethod void populateRegion_Test_PII() 
    {
    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //PII Pipeline Solutions
        Opportunity o2=new Opportunity();
        o2.AccountID = le.Id;        
        o2.StageName = 'Prospect';        
        o2.CloseDate = Date.today().addDays(10);        
        //o2.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o2.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o2.Name='Test Opportunity';
        //o2.GE_OG_TM_Commercial_Center__c='USA'
        o2.RecordTypeId=optyRecordTypes.get('OG PII Opportunity').getRecordTypeId();
        optyList.add(o2); 
        
        insert optyList; 
        System.assertEquals(o2.Name,'Test Opportunity');
        Pricebook2  prcbk=GEESEntityController.createPricebook();
        Product2 prd=GEESEntityController.createProduct();
        prd.GE_ES_Prd_Typ__c='Svcs';
        update prd;
        PricebookEntry  entry=GEESEntityController.createPricebookEntry(prd,prcbk);
        
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls',null,null); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
    }
    
    
    
    Static TestMethod void populateRegion_Test_MCS() 
    {
    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //PII Pipeline Solutions
        Opportunity o2=new Opportunity();
        o2.AccountID = le.Id;        
        o2.StageName = 'Prospect';        
        o2.CloseDate = Date.today().addDays(10);        
        //o2.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o2.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o2.Name='Test Opportunity';
        //o2.GE_OG_TM_Commercial_Center__c='USA'
        o2.RecordTypeId=optyRecordTypes.get('MCS').getRecordTypeId();
        optyList.add(o2); 
        
        insert optyList; 
        System.assertEquals(o2.Name,'Test Opportunity');
        Pricebook2  prcbk=GEESEntityController.createPricebook();
        Product2 prd=GEESEntityController.createProduct();
        prd.GE_ES_Prd_Typ__c='Svcs';
        update prd;
        PricebookEntry  entry=GEESEntityController.createPricebookEntry(prd,prcbk);
        OpportunityLineItem oli=GEESEntityController.createOpportunityLineItem(optyList.get(0),entry,10000);
        
        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls',null,null); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
        delete oli;
    }  
    
    Static TestMethod void populateRegion_Test_MCS1() 
    {
    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        Account le1 = [select id,ShippingCountry from Account where Name = 'TestClassAccount-LegalEntity' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //PII Pipeline Solutions
        Opportunity o2=new Opportunity();
        o2.AccountID = le.Id;        
        o2.StageName = 'Prospect';        
        o2.CloseDate = Date.today().addDays(10);        
        //o2.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o2.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o2.Name='Test Opportunity';
        //o2.GE_OG_TM_Commercial_Center__c='USA'
        o2.GE_ES_GE_Bid_Legal_Entity_Name__c=le1.Id;
        o2.RecordTypeId=optyRecordTypes.get('MCS').getRecordTypeId();
        optyList.add(o2); 
        
        insert optyList; 
        System.assertEquals(o2.Name,'Test Opportunity');
        Pricebook2  prcbk=GEESEntityController.createPricebook();
        List<String> strTypes=new List<String>();
        strTypes.add('Equipment');
        strTypes.add('Svcs');
        strTypes.add('');  
        
        List<Product2> prds=GEESEntityController.createProducts(strTypes);
        List<PricebookEntry> entries=GEESEntityController.createPricebookEntries(prds,prcbk);
        List<OpportunityLineItem> oliList=GEESEntityController.createOpportunityLineItems(optyList.get(0),entries,10000);
        

        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls',null,null); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
        delete oliList.get(1);
    }
    
    Static TestMethod void populateRegion_Test_MCS2() 
    {
    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        Account le1 = [select id,ShippingCountry from Account where Name = 'TestClassAccount-LegalEntity' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //PII Pipeline Solutions
        Opportunity o2=new Opportunity();
        o2.AccountID = le.Id;        
        o2.StageName = 'Prospect';        
        o2.CloseDate = Date.today().addDays(10);        
        //o2.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o2.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o2.Name='Test Opportunity';
        //o2.GE_OG_TM_Commercial_Center__c='USA'
        o2.GE_ES_GE_Bid_Legal_Entity_Name__c=le1.Id;
        o2.RecordTypeId=optyRecordTypes.get('MCS').getRecordTypeId();
        optyList.add(o2); 
        
        insert optyList; 
        System.assertEquals(o2.Name,'Test Opportunity');
        Pricebook2  prcbk=GEESEntityController.createPricebook();
        List<String> strTypes=new List<String>();
        strTypes.add('Equipment');
        //strTypes.add('Svcs');
        //strTypes.add('');  
        
        List<Product2> prds=GEESEntityController.createProducts(strTypes);
        List<PricebookEntry> entries=GEESEntityController.createPricebookEntries(prds,prcbk);
        List<OpportunityLineItem> oliList=GEESEntityController.createOpportunityLineItems(optyList.get(0),entries,10000);
        

        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls',null,null); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
        delete oliList.get(0);
    }
    
    Static TestMethod void populateRegion_Test_MCS3() 
    {
    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        Account le1 = [select id,ShippingCountry from Account where Name = 'TestClassAccount-LegalEntity' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
                             
        //PII Pipeline Solutions
        Opportunity o2=new Opportunity();
        o2.AccountID = le.Id;        
        o2.StageName = 'Prospect';        
        o2.CloseDate = Date.today().addDays(10);        
        //o2.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o2.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o2.Name='Test Opportunity';
        //o2.GE_OG_TM_Commercial_Center__c='USA'
        o2.GE_ES_GE_Bid_Legal_Entity_Name__c=le1.Id;
        o2.RecordTypeId=optyRecordTypes.get('MCS').getRecordTypeId();
        optyList.add(o2); 
        
        insert optyList; 
        System.assertEquals(o2.Name,'Test Opportunity');
        Pricebook2  prcbk=GEESEntityController.createPricebook();
        List<String> strTypes=new List<String>();
        //strTypes.add('Equipment');
        strTypes.add('Svcs');
        //strTypes.add('');  
        
        List<Product2> prds=GEESEntityController.createProducts(strTypes);
        List<PricebookEntry> entries=GEESEntityController.createPricebookEntries(prds,prcbk);
        List<OpportunityLineItem> oliList=GEESEntityController.createOpportunityLineItems(optyList.get(0),entries,10000);
        

        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls',null,null); 
        optyList.get(0).End_User__c=a1.Id;
        update optyList;
        delete oliList.get(0);
    } 
    
    Static TestMethod void populateRegion_Test_Env1() 
    {
    //Create an Opportunity of Energy
        Account le = [select id,ShippingCountry from Account where Name = 'TestClassAccount-EndUser' limit 1];
        Account le1 = [select id,ShippingCountry from Account where Name = 'TestClassAccount-LegalEntity' limit 1];
        System.debug('-----le------'+le.ShippingCountry);        
        List<Opportunity> optyList=new List<opportunity>();
        Map<String, Schema.RecordTypeInfo> optyRecordTypes=Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName();
        
        // Test.startTest();                     
        //PII Pipeline Solutions
        Opportunity o2=new Opportunity();
        o2.AccountID = le.Id;        
        o2.StageName = 'Prospect';        
        o2.CloseDate = Date.today().addDays(10);        
        //o2.GE_ES_GE_Bid_Legal_Entity_Name__c = le.Id;        
        //o2.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';        
        o2.GE_OG_TM_Quote_Type__c = 'Engineering';        
        o2.Name='Test Opportunity';
        //o2.GE_OG_TM_Commercial_Center__c='USA'
        o2.GE_ES_GE_Bid_Legal_Entity_Name__c=le1.Id;
       o2.GE_Tier2_ERegion__c='Test';
       o2.GE_Tier2_ARegion__c='Rest2';
        o2.RecordTypeId=optyRecordTypes.get('MCS').getRecordTypeId();
        optyList.add(o2); 
        // Test.startTest();
        insert optyList; 
        System.assertEquals(o2.Name,'Test Opportunity');
        Pricebook2  prcbk=GEESEntityController.createPricebook();
        List<String> strTypes=new List<String>();
        strTypes.add('Equipment');
        //strTypes.add('Svcs');
        //strTypes.add('');  
        
        List<Product2> prds=GEESEntityController.createProducts(strTypes);
        List<PricebookEntry> entries=GEESEntityController.createPricebookEntries(prds,prcbk);
        List<OpportunityLineItem> oliList=GEESEntityController.createOpportunityLineItems(optyList.get(0),entries,10000);
        

        Test.startTest();
        Account a1=GEESEntityFactory.createAccount('TestClsAcc-TestCls',null,null); 
        optyList.get(0).End_User__c=a1.Id;
optyList.get(0).GE_Tier2_ERegion__c='Test1';
optyList.get(0).GE_Tier2_ARegion__c='Rest21';
        update optyList;
        delete oliList.get(0);
         Test.stopTest();
    } 
    
    *******/ 
                                                                                 
}