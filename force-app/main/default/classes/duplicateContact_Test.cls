@isTest
private class duplicateContact_Test{
    Static testMethod void duplicateCon_Test() {
        
        account MasterAcc= new account();
        MasterAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        MasterAcc.name = 'Master Account Global / HQ';
        MasterAcc.Account_Tier_GEOG__c = 'Global';
        MasterAcc.Classification__c= 'Strategic';
        MasterAcc.Type = 'Customer';
        MasterAcc.ShippingCountry = 'India';
        insert MasterAcc;
    
        Account acc = new Account();
        String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.Name='TestAccount1';
        //acc.GE_HQ_DUNS_Number__c='GEGUL9999';
        acc.Type = 'Direct Customer';
        acc.Classification__c = 'Strategic';
        acc.Member_of_GE_OG__c = MasterAcc.Id;
        acc.Account_Tier_GEOG__c ='Country';
        acc.RecordTypeId=recordTypeName;
        insert acc;
        
        Contact con = new Contact();
        con.FirstName='test';
        con.LastName='test';
        con.Email='terst@test.com';
        con.AccountId = acc.Id;
        con.isDuplicate__c = false;
        con.GE_OG_Contact_Audience__c = 'Sales / ITO';
        insert con;
        
        ContactAccountSharing__c shobj = new ContactAccountSharing__c();
        shobj.Account_GEOG__c = con.AccountId;
        shobj.Contact_GEOG__c = con.Id;
        shobj.Primary_Contact_GE_OG__c = con.GE_PRM_Primary_Contact__c;
        insert shobj;

        Contact con1 = new Contact();
        con1.FirstName='testing';
        con1.LastName='testt';
        con1.Email='terstc@test.com';
        con1.AccountId = acc.Id;
        con1.GE_OG_Contact_Audience__c = 'Sales / ITO';
        try{
        insert con1;
        }
        catch (DmlException e){
        System.assert( e.getMessage().contains('This email already exists on the selected Account. This is a duplicate contact. Please update email address or select a different Account.'), 
                e.getMessage() );
           }
    }
    
    Static testMethod void duplicateCon_Test1() {
        /*
        Account acc = new Account();
        String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.Name='TestAccount1';
        acc.GE_HQ_DUNS_Number__c='GEGUL9999';
        acc.Account_Tier_GEOG__c ='Country';
        acc.RecordTypeId=recordTypeName;
        insert acc;
        
        Contact con1 = new Contact();
        con1.FirstName='test';
        con1.LastName='test';
        con1.Email='terst@test.com';
        con1.AccountId = acc.Id;
        insert con1;
        con1.LastName='testt';
        update con1;
        */
        
        Account acc = new Account();
        String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.Name='TestAccount1';
        acc.GE_HQ_DUNS_Number__c='GEGUL9999';
        acc.Account_Tier_GEOG__c ='Country';
        acc.RecordTypeId=recordTypeName;
        acc.Type = 'Direct Customer';
        acc.Classification__c = 'Strategic';
        insert acc;


        Account acc1 = new Account();
        String recordTypeName1 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc1.Name='TestAccount2';
        acc1.GE_HQ_DUNS_Number__c='GEGUL9988';
        acc1.Account_Tier_GEOG__c ='LE';
        acc1.RecordTypeId=recordTypeName1;
        acc1.Type = 'Direct Customer';
        acc1.Classification__c = 'Strategic';
        insert acc1;

        Contact con1 = new Contact();
        con1.FirstName='test';
        con1.LastName='test';
        con1.Email='terstd@test.com';
        con1.AccountId = acc.Id;
        con1.GE_OG_Contact_Audience__c = 'Sales / ITO';
        insert con1;
        con1.LastName='testt';
        update con1;


        Contact con2 = new Contact();
        con2.FirstName='test';
        con2.LastName='test';
        con2.Email='terste@test.com';
        con2.AccountId = acc1.Id;
        con2.GE_OG_Contact_Audience__c = 'Sales / ITO';
        insert con2;
        
        
    }
    
    
    
  }