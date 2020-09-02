@isTest
public class batchForAccountMerge_Test {        
   static testMethod void TestMearge1() {
    
    OG_Trigger_fire_Decision__c tfd1 = new OG_Trigger_fire_Decision__c();
    tfd1.isActive__c = true;
    tfd1.Object_Name__c = 'Account' ;
    tfd1.Trigger_Name__c = 'GE_OG_Update_FinanceUpdateStatus' ;
    tfd1.name = 'GE_OG_Update_FinanceUpdateStatus';
    insert tfd1;
    
    /* account MasterAcc= new account();
    MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasterAcc.name = 'Master Account Global / HQ';
    MasterAcc.Account_Tier_GEOG__c = 'Global';
    MasterAcc.Classification__c= 'Strategic';
    MasterAcc.Type = 'Customer';
    MasterAcc.ShippingCountry = 'India';
    insert MasterAcc; */
    
      Account MasterAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global / HQ','Customer');   
        
        
        
   /* account SlaveAcc = new account();
    SlaveAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveAcc.name = 'Slave Account Global / HQ';
    SlaveAcc.Account_Tier_GEOG__c = 'Global';
    SlaveAcc.Classification__c= 'Strategic';
    SlaveAcc.Type = 'Customer';
    SlaveAcc.ShippingCountry = 'India';
    insert SlaveAcc;*/
    
    
    Account SlaveAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Slave Account Global / HQ','Customer');
    
    //Creating Regional account
   /*  account SlaveRegional = new account();
    SlaveRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveRegional.name = 'Slave Account Regional';
    SlaveRegional.Account_Tier_GEOG__c = 'Regional';
    SlaveRegional.Country_GEOG__c = 'INDIA';
    SlaveRegional.Classification__c= 'Strategic';
    SlaveRegional.Type = 'Customer';
    SlaveRegional.ShippingCountry = 'India';
    SlaveRegional.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveRegional.ParentId = SlaveAcc.Id;
    insert SlaveRegional; */
      
      Account SlaveRegional = AccountTestDataFactory.createRegionalAccount(SlaveAcc.Id,'Slave Account Regional','Customer');
    
    
    //Creating Country account
    /* account SlaveaccCountry = new account();
    SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveaccCountry.name = 'Slave Account Country';
    SlaveaccCountry.Account_Tier_GEOG__c = 'Country';
    SlaveaccCountry.Country_GEOG__c = 'INDIA';
    SlaveaccCountry.Classification__c= 'Strategic';
    SlaveaccCountry.Type = 'Customer';
    SlaveaccCountry.ShippingCountry = 'India';
    SlaveaccCountry.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveaccCountry.ParentId = SlaveRegional.Id;
    insert SlaveaccCountry; */
    
    
    account SlaveaccCountry = AccountTestDataFactory.createCountryaccount(SlaveAcc.Id,SlaveRegional.Id,'Slave Account Country',True,True,'Customer');
    
    //Creating LE account
    /* account SlaveLE = new account();
    SlaveLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
    SlaveLE.name = 'Slave LE';
    SlaveLE.Account_Tier_GEOG__c = 'LE';
    SlaveLE.Country_GEOG__c = 'INDIA';
    SlaveLE.Classification__c= 'Strategic';
    SlaveLE.Type = 'Customer';
    SlaveLE.ShippingCountry = 'India';
    SlaveLE.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveLE.Oil_Gas_Parent_Account__c = SlaveaccCountry.Id;
    //SlaveLE.ParentId = SlaveaccCountry.Id;
    insert SlaveLE; */
    
    account SlaveLE=AccountTestDataFactory.createLegalEntityAccountWithMember('Slave LE',SlaveaccCountry.Id,SlaveAcc.Id);
    
    /* Contact con = new Contact();
    con.FirstName='test';
    con.LastName='test';
    con.Email='terst@test.com';
    con.AccountId = SlaveaccCountry.Id;
    con.isDuplicate__c = false;
    insert con; */
        
         Contact con =AccountTestDataFactory.createContact(SlaveaccCountry.Id,'test','test');
         
   /*  ContactAccountSharing__c conshar = new ContactAccountSharing__c();
    conshar.Account_GEOG__c = SlaveAcc.id;
    conshar.Contact_GEOG__c = con.id;
    insert conshar; */
    
   ContactAccountSharing__c conshar =AccountTestDataFactory.createcontactAccountSharing(SlaveAcc.id,con.id,false);
   
    GE_OG_Merge_Master_Slave_Account__c csdata = new GE_OG_Merge_Master_Slave_Account__c();
    csdata.name = 'test'; 
    csdata.Master_Account_Name__c = MasterAcc.id;
    csdata.Slave_Account_Name__c = SlaveAcc.id;
    insert csdata;
    
    Test.startTest();
    batchForAccountMerge mergeBatch = new batchForAccountMerge();
    Database.executeBatch(mergeBatch);
    Test.stopTest();
    }
    
    static testMethod void TestMearge2() {

   /*  account MasterAcc= new account();
    MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasterAcc.name = 'Master Account Global';
    MasterAcc.Account_Tier_GEOG__c = 'Global';
    MasterAcc.Classification__c= 'Strategic';
    MasterAcc.Type = 'Customer';
    MasterAcc.ShippingCountry = 'India';
    insert MasterAcc; */
    
    Account MasterAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global / HQ','Customer');
    
    
        
    /* account SlaveAcc = new account();
    SlaveAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveAcc.name = 'Slave Account Global';
    SlaveAcc.Account_Tier_GEOG__c = 'Global';
    SlaveAcc.Classification__c= 'Strategic';
    SlaveAcc.Type = 'Customer';
    SlaveAcc.ShippingCountry = 'India';
    insert SlaveAcc; */
    
    Account SlaveAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Slave Account Global / HQ','Customer');
    
    
    GE_OG_Merge_Master_Slave_Account__c csdata = new GE_OG_Merge_Master_Slave_Account__c();
    csdata.name = 'test'; 
    csdata.Master_Account_Name__c = MasterAcc.id;
    csdata.Slave_Account_Name__c = SlaveAcc.id;
    insert csdata;
    
    Test.startTest();
    batchForAccountMerge mergeBatch = new batchForAccountMerge();
    Database.executeBatch(mergeBatch);
    Test.stopTest();
    }
    
    static testMethod void TestMearge3() {

    /* account MasterAcc= new account();
    MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasterAcc.name = 'Master Account Global';
    MasterAcc.Account_Tier_GEOG__c = 'Global';
    MasterAcc.Classification__c= 'Strategic';
    MasterAcc.Type = 'Customer';
    MasterAcc.ShippingCountry = 'India';
    insert MasterAcc;
     */
    Account MasterAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global','Customer');

    //Creating Regional account
  /*   account MasterRegional = new account();
    MasterRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasterRegional.name = 'Master Account Regional';
    MasterRegional.Account_Tier_GEOG__c = 'Regional';
    MasterRegional.Country_GEOG__c = 'INDIA';
    MasterRegional.Classification__c= 'Strategic';
    MasterRegional.Type = 'Customer';
    MasterRegional.ShippingCountry = 'India';
    MasterRegional.Member_of_GE_OG__c = MasterAcc.Id;
    MasterRegional.ParentId = MasterAcc.Id;
    insert MasterRegional; */
    
      Account MasterRegional = AccountTestDataFactory.createRegionalAccount(MasterAcc.Id,'Master Account Regional','Customer');
    
    //Creating Country account
    /* account MasteraccCountry = new account();
    MasteraccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasteraccCountry.name = 'Master Account Country';
    MasteraccCountry.Account_Tier_GEOG__c = 'Country';
    MasteraccCountry.Country_GEOG__c = 'INDIA';
    MasteraccCountry.Classification__c= 'Strategic';
    MasteraccCountry.Type = 'Customer';
    MasteraccCountry.ShippingCountry = 'India';
    MasteraccCountry.Member_of_GE_OG__c = MasterAcc.Id;
    MasteraccCountry.ParentId = MasterRegional.Id;
    insert MasteraccCountry; */
    
    
    account MasteraccCountry = AccountTestDataFactory.createCountryaccount(MasterAcc.Id,MasterRegional.Id,'SlaveaccCountry',True,True,'Customer');
    
   /*  account SlaveAcc = new account();
    SlaveAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveAcc.name = 'Slave Account Global';
    SlaveAcc.Account_Tier_GEOG__c = 'Global';
    SlaveAcc.Classification__c= 'Strategic';
    SlaveAcc.Type = 'Customer';
    SlaveAcc.ShippingCountry = 'India';
    insert SlaveAcc; */
    
      Account SlaveAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Slave Account Global','Customer');
      
    //Creating Regional account
   /*  account SlaveRegional = new account();
    SlaveRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveRegional.name = 'Slave Account Regional';
    SlaveRegional.Account_Tier_GEOG__c = 'Regional';
    SlaveRegional.Country_GEOG__c = 'INDIA';
    SlaveRegional.Classification__c= 'Strategic';
    SlaveRegional.Type = 'Customer';
    SlaveRegional.ShippingCountry = 'India';
    SlaveRegional.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveRegional.ParentId = SlaveAcc.Id;
    insert SlaveRegional; */
    
     Account SlaveRegional = AccountTestDataFactory.createRegionalAccount(SlaveAcc.Id,'Slave Account Regional','Customer');
    
    //Creating Country account
   /*  account SlaveaccCountry = new account();
    SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveaccCountry.name = 'Slave Account Country';
    SlaveaccCountry.Account_Tier_GEOG__c = 'Country';
    SlaveaccCountry.Country_GEOG__c = 'INDIA';
    SlaveaccCountry.Classification__c= 'Strategic';
    SlaveaccCountry.Type = 'Customer';
    SlaveaccCountry.ShippingCountry = 'India';
    SlaveaccCountry.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveaccCountry.ParentId = SlaveRegional.Id;
    insert SlaveaccCountry; */
    
    account SlaveaccCountry = AccountTestDataFactory.createCountryaccount(SlaveAcc.Id,SlaveRegional.Id,'Slave Account Country',True,True,'Customer');
    
    //Creating Country account
  /*   account SlaveLE = new account();
    SlaveLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
    SlaveLE.name = 'Slave LE';
    SlaveLE.Account_Tier_GEOG__c = 'LE';
    SlaveLE.Country_GEOG__c = 'INDIA';
    SlaveLE.Classification__c= 'Strategic';
    SlaveLE.Type = 'Customer';
    SlaveLE.ShippingCountry = 'India';
    SlaveLE.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveLE.Oil_Gas_Parent_Account__c = SlaveaccCountry.Id;
    insert SlaveLE; */
    
    account SlaveLE = AccountTestDataFactory.createCountryaccount(SlaveAcc.Id,SlaveaccCountry.Id,'Slave LE',True,True,'Customer');
/*  
    Contact con1 = new Contact();
    con1.FirstName='test';
    con1.LastName='test';
    con1.Email='terst@test.com';
    con1.AccountId = SlaveRegional.Id;
    con1.isDuplicate__c = false;
    insert con1; */
    
    Contact con1 = AccountTestDataFactory.createContact(SlaveRegional.Id,'test','test');
    
    Task tsk = new Task();
    tsk.subject ='testing';
    tsk.whoid = con1.id;
    tsk.WhatId = SlaveRegional.id;
    tsk.Type = 'call';
    tsk.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();
   // insert tsk;
    
    GE_OG_Merge_Master_Slave_Account__c csdata = new GE_OG_Merge_Master_Slave_Account__c();
    csdata.name = 'test'; 
    csdata.Master_Account_Name__c = MasterRegional.id;
    csdata.Slave_Account_Name__c = SlaveRegional.id;
    insert csdata;
    
    Test.startTest();
    batchForAccountMerge mergeBatch = new batchForAccountMerge();
    Database.executeBatch(mergeBatch);
    Test.stopTest();
    
    }
    
    static testMethod void TestMearge4() {
        
  /*   account MasterAcc= new account();
    MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasterAcc.name = 'Master Account Global';
    MasterAcc.Account_Tier_GEOG__c = 'Global';
    MasterAcc.Classification__c= 'Strategic';
    MasterAcc.Type = 'Customer';
    MasterAcc.ShippingCountry = 'India';
    insert MasterAcc; */
    
     Account MasterAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global','Customer');
    
    //Creating Regional account
/*     account MasterRegional = new account();
    MasterRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasterRegional.name = 'Master Account Regional';
    MasterRegional.Account_Tier_GEOG__c = 'Regional';
    MasterRegional.Country_GEOG__c = 'INDIA';
    MasterRegional.Classification__c= 'Strategic';
    MasterRegional.Type = 'Customer';
    MasterRegional.ShippingCountry = 'India';
    MasterRegional.Member_of_GE_OG__c = MasterAcc.Id;
    MasterRegional.ParentId = MasterAcc.Id;
    insert MasterRegional; */
    
    account MasterRegional =AccountTestDataFactory.createRegionalAccount(MasterAcc.Id,'Master Account Regional','Customer');
    
    
    
    //Creating Country account
    /* account MasteraccCountry = new account();
    MasteraccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasteraccCountry.name = 'Master Account Country';
    MasteraccCountry.Account_Tier_GEOG__c = 'Country';
    MasteraccCountry.Country_GEOG__c = 'INDIA';
    MasteraccCountry.Classification__c= 'Strategic';
    MasteraccCountry.Type = 'Customer';
    MasteraccCountry.ShippingCountry = 'India';
    MasteraccCountry.Member_of_GE_OG__c = MasterAcc.Id;
    MasteraccCountry.ParentId = MasterRegional.Id;
    insert MasteraccCountry; */
    
    account MasteraccCountry = AccountTestDataFactory.createCountryaccount(MasterAcc.Id,MasterRegional.Id,'Master Account Country',True,True,'Customer');
    
   
   /*  account SlaveAcc = new account();
    SlaveAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveAcc.name = 'Slave Account Global';
    SlaveAcc.Account_Tier_GEOG__c = 'Global';
    SlaveAcc.Classification__c= 'Strategic';
    SlaveAcc.Type = 'Customer';
    SlaveAcc.ShippingCountry = 'India';
    insert SlaveAcc;
     */
     Account SlaveAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global','Customer');
    
    
    //Creating Regional account
    /* account SlaveRegional = new account();
    SlaveRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveRegional.name = 'Slave Account Regional';
    SlaveRegional.Account_Tier_GEOG__c = 'Regional';
    SlaveRegional.Country_GEOG__c = 'INDIA';
    SlaveRegional.Classification__c= 'Strategic';
    SlaveRegional.Type = 'Customer';
    SlaveRegional.ShippingCountry = 'India';
    SlaveRegional.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveRegional.ParentId = SlaveAcc.Id;
    insert SlaveRegional;
     */
    account SlaveRegional =AccountTestDataFactory.createRegionalAccount(SlaveAcc.Id,'Slave Account Regional','Customer');
    
    
    
     
    //Creating Country account
   /*  account SlaveaccCountry = new account();
    SlaveaccCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveaccCountry.name = 'Slave Account Country';
    SlaveaccCountry.Account_Tier_GEOG__c = 'Country';
    SlaveaccCountry.Country_GEOG__c = 'INDIA';
    SlaveaccCountry.Classification__c= 'Strategic';
    SlaveaccCountry.Type = 'Customer';
    SlaveaccCountry.ShippingCountry = 'India';
    SlaveaccCountry.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveaccCountry.ParentId = SlaveRegional.Id;
    insert SlaveaccCountry; */
    
    
     account SlaveaccCountry = AccountTestDataFactory.createCountryaccount(SlaveAcc.Id,SlaveRegional.Id,'Slave Account Country',True,True,'Customer');
    
    //Creating Country account
   /*  account SlaveLE = new account();
    SlaveLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
    SlaveLE.name = 'Slave LE';
    SlaveLE.Account_Tier_GEOG__c = 'LE';
    SlaveLE.Country_GEOG__c = 'INDIA';
    SlaveLE.Classification__c= 'Strategic';
    SlaveLE.Type = 'Customer';
    SlaveLE.ShippingCountry = 'India';
    SlaveLE.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveLE.Oil_Gas_Parent_Account__c = SlaveaccCountry.Id;
    //SlaveLE.ParentId = SlaveaccCountry.Id;
    insert SlaveLE; */
    
     account SlaveLE = AccountTestDataFactory.createCountryaccount(SlaveAcc.Id,SlaveaccCountry.Id,'Slave LE',True,True,'Customer');
    
    Note nott=new Note();     
    nott.Title='Unit Test Attachment';
    //Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
    //nott.body=bodyBlob1;
    nott.parentId=SlaveaccCountry.id;
    insert nott;
    
    Attachment attach=new Attachment();     
    attach.Name='Unit Test Attachment';
    Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    attach.body=bodyBlob;
    attach.parentId=SlaveaccCountry.id;
    insert attach;
    
    GE_OG_Merge_Master_Slave_Account__c csdata = new GE_OG_Merge_Master_Slave_Account__c();
    csdata.name = 'test'; 
    csdata.Master_Account_Name__c = MasteraccCountry.id;
    csdata.Slave_Account_Name__c = SlaveaccCountry.id;
    insert csdata;
    
    Test.startTest();
    batchForAccountMerge mergeBatch = new batchForAccountMerge();
    Database.executeBatch(mergeBatch);
    Test.stopTest();
    }
    
    static testMethod void TestMearge5() {
    
   /*  account MasterAcc= new account();
    MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    MasterAcc.name = 'Master Account Global / HQ';
    MasterAcc.Account_Tier_GEOG__c = 'Global';
    MasterAcc.Classification__c= 'Strategic';
    MasterAcc.Type = 'Customer';
    MasterAcc.ShippingCountry = 'India';
    insert MasterAcc; */
    
    Account MasterAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global / HQ','Customer');
    
   /*  account SlaveAcc = new account();
    SlaveAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveAcc.name = 'Slave Account Global / HQ';
    SlaveAcc.Account_Tier_GEOG__c = 'Global';
    SlaveAcc.Classification__c= 'Strategic';
    SlaveAcc.Type = 'Customer';
    SlaveAcc.ShippingCountry = 'India';
    insert SlaveAcc; */
    
     Account SlaveAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Slave Account Global / HQ','Customer');
    
    //Creating Regional account
    /* account SlaveRegional = new account();
    SlaveRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    SlaveRegional.name = 'Slave Account Regional';
    SlaveRegional.Account_Tier_GEOG__c = 'Regional';
    SlaveRegional.Country_GEOG__c = 'INDIA';
    SlaveRegional.Classification__c= 'Strategic';
    SlaveRegional.Type = 'Customer';
    SlaveRegional.ShippingCountry = 'India';
    SlaveRegional.Member_of_GE_OG__c = SlaveAcc.Id;
    SlaveRegional.ParentId = SlaveAcc.Id;
    insert SlaveRegional;
     */
    
    Account SlaveRegional = AccountTestDataFactory.createRegionalAccount(SlaveAcc.Id,'Slave Account Regional','Customer');
    
    GE_OG_Merge_Master_Slave_Account__c csdata = new GE_OG_Merge_Master_Slave_Account__c();
    csdata.name = 'test'; 
    csdata.Master_Account_Name__c = MasterAcc.id;
    csdata.Slave_Account_Name__c = SlaveRegional.id;
    insert csdata;
    
    Test.startTest();
    batchForAccountMerge mergeBatch = new batchForAccountMerge();
    Database.executeBatch(mergeBatch);
    Test.stopTest();
    }
}