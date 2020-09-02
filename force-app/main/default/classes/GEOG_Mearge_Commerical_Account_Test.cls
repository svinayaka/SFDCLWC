@isTest
public class GEOG_Mearge_Commerical_Account_Test{
   public static testMethod void testInvoc1(){
        
        
        test.startTest();
        List<Account> lstAccounts = new List<Account>();
        //account MasterAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global / HQ','Customer');
        account MasterAcc= new account();
        MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        MasterAcc.name = 'Master Account Global / HQ';
        MasterAcc.Account_Tier_GEOG__c = 'Global';
        MasterAcc.Classification__c= 'Strategic';
        MasterAcc.Type = 'Internal';
        MasterAcc.ShippingCountry = 'India';
        MasterAcc.GE_ES_Primary_Industry__c = 'Marine';
        MasterAcc.SubIndustry_GEOG__c = 'Marine';
        
        account SlaveAcc = new account();
        SlaveAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        SlaveAcc.name = 'Slave Account Global / HQ';
        SlaveAcc.Account_Tier_GEOG__c = 'Global';
        SlaveAcc.Classification__c= 'Strategic';
        SlaveAcc.Type = 'Customer';
        SlaveAcc.ShippingCountry = 'India';
        SlaveAcc.GE_ES_Primary_Industry__c = 'Marine';
        SlaveAcc.SubIndustry_GEOG__c = 'Marine';
        lstAccounts.add(SlaveAcc); 
        lstAccounts.add(MasterAcc);
        insert lstAccounts;
               
        //Account SlaveRegional = AccountTestDataFactory.createRegionalAccount(SlaveAcc.Id,'Slave Account Regional / INDIA','Customer');
        //Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', SlaveAcc.ID);
        CommonTestDataFactory_GE_OG.createOppty('Testopty',SlaveAcc.id);     
        
            
    //Note nott =AccountTestDataFactory.createNote('Unit Test Attachment',SlaveAcc.id);
        
    
        GEOG_Mearge_Commerical_AccountController controller = new GEOG_Mearge_Commerical_AccountController();
       List<String> lstAccTier = new List<String>();
        String masterSlave = MasterAcc.Id+','+SlaveAcc.Id;
        lstAccTier.add(masterSlave);
        GEOG_Mearge_Commerical_AccountController.mergeAct(lstAccTier);
        //controller.back();
        test.stopTest();
    }
    
    static testMethod void TestMeargeInvoc2() {
    
    account MasterAcc= new account();
    MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasterAcc.name = 'Master Account Global';
    MasterAcc.Account_Tier_GEOG__c = 'Global';
    MasterAcc.Classification__c= 'Strategic';
    MasterAcc.Type = 'Internal';
    MasterAcc.ShippingCountry = 'India';
    insert MasterAcc;
    
    
    //Creating Regional account
    account MasterRegional = new account();
    MasterRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasterRegional.name = 'Master Account Regional / INDIA';
    MasterRegional.Account_Tier_GEOG__c = 'Regional';
    MasterRegional.Region_GEOG__c = 'MENAT';
    MasterRegional.Country_GEOG__c = 'INDIA';
    MasterRegional.Classification__c= 'Strategic';
    MasterRegional.Type = 'Customer';
    MasterRegional.ShippingCountry = 'India';
    MasterRegional.Member_of_GE_OG__c = MasterAcc.Id;
    MasterRegional.ParentId = MasterAcc.Id;
    MasterRegional.Compliance_Ready__c = false;
    insert MasterRegional;
    
    //Creating Country account
    account MasteraccCountry = new account();
    MasteraccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasteraccCountry.name = 'Master Account Country / INDIA';
    MasteraccCountry.Account_Tier_GEOG__c = 'Country';
    MasteraccCountry.Country_GEOG__c = 'INDIA';
    MasteraccCountry.Classification__c= 'Strategic';
    MasteraccCountry.Type = 'Customer';
    MasteraccCountry.ShippingCountry = 'India';
    MasteraccCountry.Member_of_GE_OG__c = MasterAcc.Id;
    MasteraccCountry.ParentId = MasterRegional.Id;
    insert MasteraccCountry;
    
    account SlaveAcc = new account();
    SlaveAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveAcc.name = 'Slave Account Global';
    SlaveAcc.Account_Tier_GEOG__c = 'Global';
    SlaveAcc.Classification__c= 'Strategic';
    SlaveAcc.Type = 'Customer';
    SlaveAcc.ShippingCountry = 'India';
    insert SlaveAcc;
    
    //Creating Regional account
    account SlaveRegional = new account();
    SlaveRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveRegional.name = 'Slave Account Regional / INDIA';
    SlaveRegional.Account_Tier_GEOG__c = 'Regional';
    SlaveRegional.Region_GEOG__c = 'MENAT';
    SlaveRegional.Country_GEOG__c = 'INDIA';
    SlaveRegional.Classification__c= 'Strategic';
    SlaveRegional.Type = 'Customer';
    SlaveRegional.ShippingCountry = 'India';
    SlaveRegional.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveRegional.ParentId = SlaveAcc.Id;
    SlaveRegional.GE_ES_Primary_Industry__c = 'Marine';
    SlaveRegional.SubIndustry_GEOG__c = 'Marine';
    
    SlaveRegional.Compliance_Ready__c = true;
    insert SlaveRegional;

    //Creating Country account
    account SlaveaccCountry = new account();
    SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveaccCountry.name = 'Slave Account Country / INDIA';
    SlaveaccCountry.Account_Tier_GEOG__c = 'Country';
    SlaveaccCountry.Country_GEOG__c = 'INDIA';
    SlaveaccCountry.Classification__c= 'Strategic';
    SlaveaccCountry.Type = 'Customer';
    SlaveaccCountry.ShippingCountry = 'India';
    SlaveaccCountry.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveaccCountry.ParentId = SlaveRegional.Id;
    insert SlaveaccCountry;
    
    
    account SlaveLE = AccountTestDataFactory.createCountryaccount(SlaveAcc.Id,SlaveaccCountry.Id,'Slave LE',True,True,'Customer');
    
     
        Contact objContact = new Contact();
        objContact.FirstName ='test1';
        objContact.LastName= 'test1';
        objContact.Salutation='Mr.';
        objContact.Email='blabla@ge.com';
        objContact.Phone='111111111';
        objContact.Fax='1212121212';
        objContact.GE_ES_I_Agree_flag__c = TRUE;
        objContact.AccountId= SlaveAcc.Id;
        objContact.GE_OG_Contact_Audience__c ='Sales / ITO';
        
        insert objContact;
    
    
    Task tsk = new Task();
    tsk.subject ='testing';
    tsk.whoid = objContact.id;
    tsk.WhatId = SlaveRegional.id;
    tsk.recordtypeid= Schema.SObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeId();
    tsk.Type = 'call';
  //  insert tsk;
  
 
   
    GEOG_Mearge_Commerical_AccountController controller = new GEOG_Mearge_Commerical_AccountController();
    test.starttest(); 
     List<String> lstAccTier = new List<String>();
    String masterSlave = MasterRegional.Id+','+SlaveRegional.Id;
    lstAccTier.add(masterSlave);
    GEOG_Mearge_Commerical_AccountController.mergeAct(lstAccTier);
    //controller.back();
    test.stoptest();
    }
    
    
    static testMethod void TestMeargeInvoc3() {
        test.startTest();
         account SlaveaccCountry = new account();
        SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        SlaveaccCountry.name = 'Slave Account Country / INDIA';
        SlaveaccCountry.Account_Tier_GEOG__c = 'Country';
        SlaveaccCountry.Country_GEOG__c = 'INDIA';
        SlaveaccCountry.Classification__c= 'Strategic';
        SlaveaccCountry.Type = 'Customer';
        SlaveaccCountry.ShippingCountry = 'India';
        //SlaveaccCountry.ParentId = SlaveRegional.Id;
        insert SlaveaccCountry;
        
        account MasteraccCountry = new account();
        MasteraccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        MasteraccCountry.name = 'Master Account Country / INDIA';
        MasteraccCountry.Account_Tier_GEOG__c = 'Country';
        MasteraccCountry.Country_GEOG__c = 'INDIA';
        MasteraccCountry.Classification__c= 'Strategic';
        MasteraccCountry.Type = 'Customer';
        MasteraccCountry.ShippingCountry = 'India';
       //MasteraccCountry.ParentId = MasterRegional.Id;
        insert MasteraccCountry;
        
       
        Contract ctrct1= new Contract();
        ctrct1.AccountId = MasteraccCountry.Id;
        Id chmasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
        ctrct1.recordTypeId = chmasterId;
        ctrct1.ContractTerm =10;
        insert ctrct1;
        
        List<String> lstAccTier = new List<String>();
        String masterSlave = MasteraccCountry.Id+','+SlaveaccCountry.Id;
        lstAccTier.add(masterSlave);
        GEOG_Mearge_Commerical_AccountController.mergeAct(lstAccTier);
        
    
        test.stopTest();
    }
    
    static testMethod void TestMeargeInvoc4() {
        test.startTest();
         account SlaveaccCountry = new account();
        SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        SlaveaccCountry.name = 'Slave Account Country / INDIA';
        SlaveaccCountry.Account_Tier_GEOG__c = 'Country';
        SlaveaccCountry.Country_GEOG__c = 'INDIA';
        SlaveaccCountry.Classification__c= 'Strategic';
        SlaveaccCountry.Type = 'Customer';
        SlaveaccCountry.ShippingCountry = 'India';
        //SlaveaccCountry.ParentId = SlaveRegional.Id;
        insert SlaveaccCountry;
        
        account MasteraccCountry = new account();
        MasteraccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        MasteraccCountry.name = 'Master Account Country / INDIA';
        MasteraccCountry.Account_Tier_GEOG__c = 'Country';
        MasteraccCountry.Country_GEOG__c = 'INDIA';
        MasteraccCountry.Classification__c= 'Strategic';
        MasteraccCountry.Type = 'Customer';
        MasteraccCountry.ShippingCountry = 'India';
       //MasteraccCountry.ParentId = MasterRegional.Id;
        insert MasteraccCountry;
        
        Case csc = new Case();
        csc.status='new';
        csc.AccountId = SlaveaccCountry.id;
        insert csc;
        
        //Opportunity oppty=new AccountTestDataFactory.createOppty('test opp',SlaveaccCountry.id);
        
        
        
        List<String> lstAccTier = new List<String>();
        String masterSlave = MasteraccCountry.Id+','+SlaveaccCountry.Id;
        lstAccTier.add(masterSlave);
        GEOG_Mearge_Commerical_AccountController.mergeAct(lstAccTier);
        
    
        test.stopTest();
    }
    
    public static testMethod void testMergeMethod1(){
        test.startTest();
        account SlaveaccCountry = new account();
        SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        SlaveaccCountry.name = 'Slave Account Country / INDIA';
        SlaveaccCountry.Account_Tier_GEOG__c = 'Country';
        SlaveaccCountry.Country_GEOG__c = 'INDIA';
        SlaveaccCountry.Classification__c= 'Strategic';
        SlaveaccCountry.Type = 'Customer';
        SlaveaccCountry.ShippingCountry = 'India';
        insert SlaveaccCountry;
        
        account MasterAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global / HQ','Customer');
        
        List<String> lstAccTier = new List<String>();
        String masterSlave = MasterAcc.Id+','+SlaveaccCountry.Id;
        lstAccTier.add(masterSlave);
        GEOG_Mearge_Commerical_AccountController.mergeAct(lstAccTier);
           
        test.stopTest();
    }
    
    public static testMethod void testMergeMethod2(){
        test.startTest();
        account SlaveaccCountry = new account();
        SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        SlaveaccCountry.name = 'Slave Account Countryxyxyqqa / INDIA';
        SlaveaccCountry.Account_Tier_GEOG__c = 'Country';
        SlaveaccCountry.Country_GEOG__c = 'INDIA';
        SlaveaccCountry.Classification__c= 'Strategic';
        SlaveaccCountry.Type = 'Customer';
        SlaveaccCountry.ShippingCountry = 'India';
        insert SlaveaccCountry;
        
        account MasterAcc = new account();
        MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        MasterAcc.name = 'Slave Account Countryxyxyqq / INDIA';
        MasterAcc.Account_Tier_GEOG__c = 'Country';
        MasterAcc.Country_GEOG__c = 'INDIA';
        MasterAcc.Classification__c= 'Strategic';
        MasterAcc.Type = 'Customer';
        MasterAcc.ShippingCountry = 'India';
        insert MasterAcc;
        
        Contact objContact = new Contact();
        objContact.FirstName ='test1';
        objContact.LastName= 'test1';
        objContact.Salutation='Mr.';
        objContact.Email='blabla@ge.com';
        objContact.Phone='111111111';
        objContact.Fax='1212121212';
        objContact.GE_ES_I_Agree_flag__c = TRUE;
        objContact.AccountId= SlaveaccCountry.Id;
        objContact.GE_OG_Contact_Audience__c ='Sales / ITO';
        insert objContact;
        
        AccountContactRelation acRel = new AccountContactRelation();
        acRel.AccountId = MasterAcc.id;
        acRel.ContactId = objContact.id;
        acRel.Roles = 'Other';
        insert acRel;
        
        List<String> lstAccTier = new List<String>();
        String masterSlave = MasterAcc.Id+','+SlaveaccCountry.Id;
        lstAccTier.add(masterSlave);
        GEOG_Mearge_Commerical_AccountController.mergeAct(lstAccTier);
        test.stopTest();   
       
    }
    
    public static testMethod void testUtilSplit(){
        test.startTest();
        account SlaveaccCountry = new account();
        SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        SlaveaccCountry.name = 'Slave Accountqq Countryxyxyqqa / INDIA';
        SlaveaccCountry.Account_Tier_GEOG__c = 'Country';
        SlaveaccCountry.Country_GEOG__c = 'INDIA';
        SlaveaccCountry.Classification__c= 'Strategic';
        SlaveaccCountry.Type = 'Customer';
        SlaveaccCountry.ShippingCountry = 'India';
        insert SlaveaccCountry;
        
        account MasterAcc = new account();
        MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        MasterAcc.name = 'Slave Accountqq Countryxyxyqq / INDIA';
        MasterAcc.Account_Tier_GEOG__c = 'Country';
        MasterAcc.Country_GEOG__c = 'INDIA';
        MasterAcc.Classification__c= 'Strategic';
        MasterAcc.Type = 'Customer';
        MasterAcc.ShippingCountry = 'India';
        insert MasterAcc;
        
        List<SObject> lstRecords = new List<SObject>();
        lstRecords.add(SlaveaccCountry);
        lstRecords.add(MasterAcc);
        
        UtilityListSplit.spliceListBySize(lstRecords, 1);
        test.stopTest();
    }
    
    public static testMethod void testMergeWithLE(){
        test.startTest();
        Account Masterobj = AccountTestDataFactory.createCommercialParentAccount('MasterAcc');
        Account Slaveobj = AccountTestDataFactory.createCommercialParentAccount('SlaveAcc');
        Account leObj = AccountTestDataFactory.createLegalEntityAccountWithMember('slaveLE',Slaveobj .id,null);
        
        List<String> lstAccTier = new List<String>();
        String masterSlave = Masterobj.Id+','+Slaveobj.Id;
        lstAccTier.add(masterSlave);
        GEOG_Mearge_Commerical_AccountController.mergeAct(lstAccTier);
        test.stopTest(); 
    }
    
    static testMethod void countryCheck(){
        Account SlaveAcc = new Account();
        //SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        SlaveAcc.name = 'Slave Accountqq Countryxyxyqqa / INDIA';
        SlaveAcc.Account_Tier_GEOG__c = 'Country';
        SlaveAcc.Country_GEOG__c = 'USA';
        SlaveAcc.Classification__c= 'Strategic';
        SlaveAcc.Type = 'Customer';
        SlaveAcc.ShippingCountry = 'India';
        insert SlaveAcc;
        
        Account MasterAcc = new Account();
        //MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        MasterAcc.name = 'Slave Accountqq Countryxyxyqq / INDIA';
        MasterAcc.Account_Tier_GEOG__c = 'Country';
        MasterAcc.Country_GEOG__c = 'INDIA';
        MasterAcc.Classification__c= 'Strategic';
        MasterAcc.Type = 'Customer';
        MasterAcc.ShippingCountry = 'India';
        insert MasterAcc;
        
        List<String> lstAccTier = new List<String>();
        String masterSlave = MasterAcc.Id+','+SlaveAcc.Id;
        lstAccTier.add(masterSlave);
                
        Test.startTest();
        GEOG_Mearge_Commerical_AccountController.mergeAct(lstAccTier);
        Test.stopTest();
    }    
}