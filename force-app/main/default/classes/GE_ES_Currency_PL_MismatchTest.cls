/*
Test Class Name: GE_ES_Currency_PL_MismatchTest
Used For : GE_ES_Currency_PL_Mismatch Trigger on Opportunity
Purpose/Overview : Test Class to calculate the code coverage for GE_ES_Currency_PL_Mismatch Trigger on Opportunity
Functional Area : Opportunity Management
Author: Mahaboob Basha 
Created Date: 4/19/2011
Test Class Name : 

Change History -
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
11/16/2011    : Prasad Yadala      :                               : To fix the errors which are due to the new validations
*/

@isTest
private class GE_ES_Currency_PL_MismatchTest{
    static testMethod void insertaccount(){
        Set<Id> AccIds  = new Set<Id>(); 
        List<Account> SOSDList2 = new List<Account>();
        List<Account> SOSDList = new List<Account>();
        List<opportunity> opplist = new List<opportunity>();
        List<Account> ParentIdsList = new List<Account>();
        
        //Retrieve the record types for account
        List<RecordType> CRecType= [Select Name, Id From RecordType where sObjectType='Account'];  
        Map<String,String> accRecordTypes = new Map<String,String>{}; 
        
        //adding record type Id's in a map
        for(RecordType rt: CRecType)   
        accRecordTypes.put(rt.Name,rt.Id);
 
        User u = [select id from User where profile.Name = 'System Integration GE OG' and  IsActive = true limit 1];
        system.runAs(u){
        List<Account> accLst = new List<Account>();
        //Inserting Account record    
        Account Pacc = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testacc',Type = 'Direct Customer',Classification__c = 'Strategic',GE_HQ_DUNS_Number__c = '84590131',GE_ES_Functional_Currency__c='EUR');
        accLst.add(Pacc);
        
        //Inserting Account record 
        Account Pacc1 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSO',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Office',GE_HQ_HQ_Parent_Duns__c = '84590131',GE_HQ_DUNS_Number__c = '8441',GE_ES_Functional_Currency__c='EUR');
        accLst.add(Pacc1);  
        
        OG_Trigger_fire_Decision__c tfd = new OG_Trigger_fire_Decision__c();
        tfd.isActive__c = true;
        tfd.Object_Name__c = 'Account' ;
        tfd.Trigger_Name__c = 'GE_OG_InsertTeamMember' ;
        tfd.name = 'GE_OG_InsertTeamMember';
        insert tfd;
        
        OG_Trigger_fire_Decision__c tfd1 = new OG_Trigger_fire_Decision__c();
        tfd1.isActive__c = true;
        tfd1.Object_Name__c = 'Account' ;
        tfd1.Trigger_Name__c = 'GE_OG_Update_FinanceUpdateStatus' ;
        tfd1.name = 'GE_OG_Update_FinanceUpdateStatus';
        insert tfd1;
         
        Account Bidacc = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '8441',GE_HQ_DUNS_Number__c = '6771',GE_ES_Functional_Currency__c='EUR');
        accLst.add(Bidacc);
        
        Account Bidacc2 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD2',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '8441',GE_HQ_DUNS_Number__c = '6781',GE_ES_Functional_Currency__c='EUR');
        accLst.add(Bidacc2); 
        Account Bidacc5 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD2',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '8441',GE_HQ_DUNS_Number__c = '678121',GE_ES_Functional_Currency__c='EUR',ParentId = Pacc1.Id,GE_HQ_STR03_PRT_COM_NAME__c = 'ES ENV');
        accLst.add(Bidacc5); 
        
        Account Bidacc6 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD2',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '8441',GE_HQ_DUNS_Number__c = '678141',GE_ES_Functional_Currency__c='USD',ParentId = Pacc1.Id,GE_HQ_STR03_PRT_COM_NAME__c = 'ES ENV');
        accLst.add(Bidacc6);
        insert accLst;
        
        List<Account> accuLst = new List<Account>();
        //Updating the account LE Type to 'Statutory Office'
        Pacc1.GE_ES_LE_Type__c = 'Statutory Office';
        accuLst.add(Pacc1);
        
        Bidacc.ParentId = Pacc1.Id;
        Bidacc.GE_ES_LE_Type__c = 'Statutory Department';
        accuLst.add(Bidacc);
        
        AccIds.add(Pacc1.id);
        Bidacc2.ParentId = Pacc1.Id;
        accuLst.add(Bidacc2);
        
        list<account> acc = [select id,name from account where Name = 'testSD2' and GE_ES_LE_Type__c = 'Statutory Department' and GE_HQ_HQ_Parent_Duns__c = '8441'];
        
        //Inserting project record        
       // Project_ge_og__c prj = new Project_ge_og__c();
        //prj.Name = 'TestProject1';
        //prj.project_account_ge_og__c = acc[0].id;
       // insert prj;
        
        Opportunity oppty = new Opportunity();
        //retrieving the record type Id for ENV
        Id RecId=Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        oppty.RecordTypeId =RecId;
        //oppty.RecordTypeId = '012T00000000Xjd';
        oppty.Name= 'Test Oppty1';
        //oppty.opportunity_project_ge_og__c = prj.Id;
        oppty.AccountId = Pacc.Id;
        oppty.Type = 'External';
        oppty.StageName = 'Prospecting';
        //Changing to latest Tier
        oppty.tier_2_ge_og__c = 'Digital Solutions';
        oppty.tier_3_ge_og__c = 'Bently Nevada';
        //oppty.GE_OG_DP_Cmptitr__c = acc[0].id;
        oppty.amount_ge_og__c = 98764;
        oppty.CurrencyIsoCode = 'EUR';
        oppty.bid_due_date_ge_og__c = Date.today();
        oppty.CloseDate= Date.today();
        //oppty.GE_ES_GE_Bid_Legal_Entity_Name__c = Pacc1.Id;     
        oppty.oppty_cm_ge_og__c = 35;
        insert oppty;        
                 
        oppty.CurrencyIsoCode = 'USD';  
        opplist.add(oppty); 
        update accuLst;
        accuLst.clear();
        Bidacc2.GE_ES_Functional_Currency__c = 'USD';
        accuLst.add(Bidacc2);     
        
        Pacc1.GE_ES_Functional_Currency__c = 'USD';
        accuLst.add(Pacc1); 
        
        List<Account> AccList = new List<Account>();
        
        //Retrieving the account details where LE Type is 'Statutory Department'
        AccList = [select id,name,GE_HQ_P_L_Type__c,parentid,GE_HQ_HQ_Parent_Duns__c,GE_ES_LE_Type__c,GE_ES_Functional_Currency__c from Account where ParentId in :AccIds and GE_ES_LE_Type__c = 'Statutory Department']; 
        system.debug('***SD List ****'+ AccList);
        update opplist;
        //update SOSDList2 ;
        system.assertequals(Pacc.id,oppty.accountid);
       
        Bidacc5.ParentId = Pacc1.Id;
        Bidacc5.GE_ES_LE_Type__c = 'Statutory Department';
        accuLst.add(Bidacc5);
         
        Bidacc6.ParentId = Pacc1.Id;
        Bidacc6.GE_ES_LE_Type__c = 'Statutory Department';
        accuLst.add(Bidacc6);
        update accuLst;
       } 
    }
  
    static testMethod void insertaccount2()
    {
        Set<Id> AccIds  = new Set<Id>(); 
        List<Account> SOSDList2 = new List<Account>();
        List<Account> SOSDList = new List<Account>();
        List<opportunity> opplist = new List<opportunity>();
        List<Account> ParentIdsList = new List<Account>();
        List<Account> AccLst = new List<Account>();
        //Retrieve the record types for account
        List<RecordType> CRecType= [Select Name, Id From RecordType where sObjectType='Account'];  
        Map<String,String> accRecordTypes = new Map<String,String>{};
         
        //adding the record type records in a map
        for(RecordType rt: CRecType)   
        accRecordTypes.put(rt.Name,rt.Id);
        
        User u = [select id from User where profile.Name = 'System Integration GE OG' and  IsActive = true limit 1];
        system.runAs(u){
        Account Pacc = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testacc',Type = 'Direct Customer',Classification__c = 'Strategic',GE_HQ_DUNS_Number__c = '22590131',GE_ES_Functional_Currency__c='EUR');
        AccLst.add(Pacc);
        
        Account Pacc1 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSO',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Office',GE_HQ_HQ_Parent_Duns__c = '22590131',GE_HQ_DUNS_Number__c = '66441',GE_ES_Functional_Currency__c='EUR');
        AccLst.add(Pacc1);        
        
        //Project_ge_og__c prj = new Project_ge_og__c();
       // prj.Name = 'TestProject1';
        //prj.project_account_ge_og__c = AccLst[0].id;
        //insert prj;          
   
        Account acc = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testxze',Type = 'Direct Customer',Classification__c = 'Strategic',GE_HQ_DUNS_Number__c = '3453111',GE_ES_Functional_Currency__c='EUR');
        AccLst.add(acc);
        Account Pacc2 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testxyz',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Office',GE_HQ_HQ_Parent_Duns__c = '3453111',GE_HQ_DUNS_Number__c = '10099',GE_ES_Functional_Currency__c='EUR');
        AccLst.add(Pacc2); 
        Account Bidacc1 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD3',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '10099',GE_HQ_DUNS_Number__c = '333991232',GE_ES_Functional_Currency__c='EUR',GE_HQ_STR03_PRT_COM_NAME__c = 'ES ENV');
        AccLst.add(Bidacc1);
        
        Account Bidacc2 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD4',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '10099',GE_HQ_DUNS_Number__c = '222991232',GE_ES_Functional_Currency__c='EUR',GE_HQ_STR03_PRT_COM_NAME__c = 'ES MCS');
        AccLst.add(Bidacc2);
        
        Account Bidacc3 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD3',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '10099',GE_HQ_DUNS_Number__c = '33399',GE_ES_Functional_Currency__c='EUR',GE_HQ_STR03_PRT_COM_NAME__c = 'ES ENV');
        AccLst.add(Bidacc3);
        
        Account Bidacc4 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD4',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '10099',GE_HQ_DUNS_Number__c = '22299',GE_ES_Functional_Currency__c='EUR',GE_HQ_STR03_PRT_COM_NAME__c = 'ES MCS');
        AccLst.add(Bidacc4);  
        
        Account Bidacc7 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD4',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '66441',GE_HQ_DUNS_Number__c = '722991232',GE_ES_Functional_Currency__c='EUR',GE_HQ_STR03_PRT_COM_NAME__c = 'ES MCS');
        AccLst.add(Bidacc7);  
        insert AccLst;
        //Bidacc3.ParentId = Pacc2.Id;
        //Bidacc3.GE_ES_LE_Type__c = 'Statutory Department';
        //SOSDList2.add(Bidacc3);
        
        Bidacc4.ParentId = Pacc2.Id;
        Bidacc4.GE_ES_LE_Type__c = 'Statutory Department';
        SOSDList2.add(Bidacc4);
        
        AccIds.add(Pacc2.id);

        list<account> acc1 = [select id,name from account where Name = 'testSD4' and GE_ES_LE_Type__c = 'Statutory Department' and GE_HQ_HQ_Parent_Duns__c = '10099'];
        
        Opportunity oppty2 = new Opportunity();
        //retrieve the record type Id for ENV
        Id RecId=Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        oppty2.RecordTypeId =RecId;
        oppty2.Name= 'Test Oppty1';
        //oppty2.opportunity_project_ge_og__c = prj.Id;
        oppty2.AccountId = acc.Id;
        oppty2.Type = 'External';
        oppty2.StageName = 'Prospecting';
        oppty2.tier_2_ge_og__c = 'Digital Solutions';
        oppty2.tier_3_ge_og__c = 'Bently Nevada';
        oppty2.amount_ge_og__c = 98764;
        //oppty2.GE_OG_DP_Cmptitr__c = acc1[0].id;
        oppty2.CurrencyIsoCode = 'USD';
        oppty2.bid_due_date_ge_og__c = Date.today();
        oppty2.CloseDate= Date.today();
        //oppty2.GE_ES_GE_Bid_Legal_Entity_Name__c = Pacc2.Id;     
        oppty2.oppty_cm_ge_og__c = 35;
        List<Opportunity> lstopp = new List<opportunity>();
        lstopp.add(oppty2);  
        
        Opportunity oppty3 = new Opportunity();
        //retrieve the record type Id for MCS
        Id RecId1=Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        oppty3.RecordTypeId =RecId1;
        //oppty3.RecordTypeId =[select id,name from recordtype where name like 'MCS' AND SobjectType = 'Opportunity' ].id;
        //oppty.RecordTypeId = '012T00000000Xjd';
        oppty3.Name= 'Test Oppty1';
        //oppty3.GE_HQ_Project__c = prj.Id;
        oppty3.AccountId = acc.Id;
        oppty3.Type = 'External';
        oppty3.StageName = 'Prospecting';
        oppty3.tier_2_ge_og__c = 'Digital Solutions';
        oppty3.tier_3_ge_og__c = 'Bently Nevada';
        oppty3.amount_ge_og__c = 98764;
        //oppty3.GE_OG_DP_Cmptitr__c = acc1[0].id;
        oppty3.CurrencyIsoCode = 'EUR';
        oppty3.bid_due_date_ge_og__c = Date.today();
        oppty3.CloseDate= Date.today();
        //oppty3.GE_ES_GE_Bid_Legal_Entity_Name__c = Pacc1.Id;     
        oppty3.oppty_cm_ge_og__c = 35;
        lstopp.add(oppty3);
        insert lstopp;
        
        oppty2.CurrencyIsoCode = 'EUR';  
        opplist.add(oppty2); 
        
        //oppty3.GE_ES_GE_Bid_Legal_Entity_Name__c = Pacc2.Id;
        opplist.add(oppty3);
        Bidacc3.ParentId = Pacc2.Id;
        Bidacc3.GE_ES_LE_Type__c = 'Statutory Department';
        Bidacc3.GE_ES_Functional_Currency__c = 'USD';
        SOSDList2.add(Bidacc3);
      
        Pacc2.GE_ES_Functional_Currency__c = 'USD';
        SOSDList2.add(Pacc2);
        
        List<Account> AccList = new List<Account>();
       
        //Retrieving the account details for LE Type 'Statutory Department'        
        AccList = [select id,name,GE_HQ_P_L_Type__c,parentid,GE_HQ_HQ_Parent_Duns__c,GE_ES_LE_Type__c,GE_ES_Functional_Currency__c from Account where ParentId in :AccIds and GE_ES_LE_Type__c = 'Statutory Department']; 
        system.debug('***SD List Try 1 Size****'+ AccList.size());
        system.debug('***SD List Try 2****'+ AccList);
        update opplist;
        
        update SOSDList2 ;
        
        Bidacc1.ParentId = Pacc2.Id;
        Bidacc1.GE_ES_LE_Type__c = 'Statutory Department';        
        SOSDList.add(Bidacc1);
                 
        Bidacc2.ParentId = Pacc2.Id;
        Bidacc2.GE_ES_LE_Type__c = 'Statutory Department';
        SOSDList.add(Bidacc2);
        
        Account Bidacc6 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD3',Type = 'Direct Customer',Classification__c = 'Strategic',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '66441',GE_HQ_DUNS_Number__c = '733991232',GE_ES_Functional_Currency__c='EUR',GE_HQ_STR03_PRT_COM_NAME__c = 'ES ENV');
        insert Bidacc6;
        Bidacc6.ParentId = Pacc1.Id;
        Bidacc6.GE_ES_LE_Type__c = 'Statutory Department';
        SOSDList.add(Bidacc6);
        
        Bidacc7.ParentId = Pacc1.Id;
        Bidacc7.GE_ES_LE_Type__c = 'Statutory Department';
        SOSDList.add(Bidacc7);
        
        system.assertequals(acc.Id,oppty3.accountid);
        
        acc.currencyisocode = 'USD';
        SOSDList.add(acc);
        update SOSDList;
       }     
    }
  
    /*static testMethod void insertaccount3()
    {try{
        Set<Id> AccIds  = new Set<Id>(); 
        List<Account> SOSDList2 = new List<Account>();
        List<Account> SOSDList = new List<Account>();
        List<opportunity> opplist = new List<opportunity>();
        List<Account> ParentIdsList = new List<Account>();
        
        //retrieve the record types for Account
        List<RecordType> CRecType= [Select Name, Id From RecordType where sObjectType='Account'];  
        Map<String,String> accRecordTypes = new Map<String,String>{}; 
        //adding the record type records in a map
        for(RecordType rt: CRecType)   
        accRecordTypes.put(rt.Name,rt.Id);
      
        User u = [select id from User where profile.Name = 'GE_ES System Integration' and  IsActive = true limit 1];
        system.runAs(u){
        Account acc = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testxze',GE_HQ_DUNS_Number__c = '345999',GE_ES_Functional_Currency__c='EUR');
        insert acc;
        Account Pacc2 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testxyz',GE_ES_LE_Type__c = 'Statutory Office',GE_HQ_HQ_Parent_Duns__c = '345999',GE_HQ_DUNS_Number__c = '89977',GE_ES_Functional_Currency__c='EUR');
        insert Pacc2; 
     
        AccIds.add(Pacc2.id);
    
        //Project_ge_og__c prj = new Project_ge_og__c();
       // prj.Name = 'TestProject1';
        //prj.project_account_ge_og__c = AccIds[0].id;
        //insert prj;
        
        Opportunity oppty2 = new Opportunity();
        //retrieve the record type id for ENV
        Id RecId=Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        oppty2.RecordTypeId =RecId;
        //oppty2.RecordTypeId =[select id,name from recordtype where name like 'Env' and SobjectType = 'Opportunity' limit 1].id;
        //oppty.RecordTypeId = '012T00000000Xjd';
        oppty2.Name= 'Test Oppty1';
        //oppty2.GE_HQ_Project__c = prj.Id;
        oppty2.AccountId = acc.Id;
        oppty2.Type = 'Primary';
        oppty2.tier_2_ge_og__c = 'Digital Solutions';
        oppty2.tier_3_ge_og__c = 'Bently Nevada';
        oppty2.StageName = 'Prospecting';
        oppty2.amount_ge_og__c = 98764;
        //oppty2.GE_OG_DP_Cmptitr__c = acc.id;
        oppty2.CurrencyIsoCode = 'USD';
        oppty2.bid_due_date_ge_og__c = Date.today();
        oppty2.CloseDate= Date.today();
        //oppty2.GE_ES_GE_Bid_Legal_Entity_Name__c = Pacc2.Id;     
        oppty2.oppty_cm_ge_og__c = 35;
        
        List<opportunity> lstopp = new List<Opportunity>();            
        lstopp.add(oppty2);  
        Opportunity oppty3 = new Opportunity();
        //retrieve the record type id for MCS
        oppty3.RecordTypeId =[select id,name from recordtype where name like 'O&G' AND SobjectType = 'Opportunity' ].id;
        //oppty.RecordTypeId = '012T00000000Xjd';
        oppty3.Name= 'Test Oppty1';
        //oppty3.GE_ES_Project__c = prj.Id;
        oppty3.AccountId = acc.Id;
        oppty3.Type = 'Primary';
        oppty3.tier_2_ge_og__c = 'Digital Solutions';
        oppty3.tier_3_ge_og__c = 'Bently Nevada';
        oppty3.StageName = 'Prospecting';
        oppty3.amount_ge_og__c = 98764;
        oppty3.CurrencyIsoCode = 'EUR';
        oppty3.bid_due_date_ge_og__c = Date.today();
        oppty3.CloseDate= Date.today();
        //oppty3.GE_ES_GE_Bid_Legal_Entity_Name__c = Pacc2.Id;     
        oppty3.oppty_cm_ge_og__c = 35;
        lstopp.add(oppty3);
        insert lstopp;      
        Account Bidacc3 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD3',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '89977',GE_HQ_DUNS_Number__c = '33399123',GE_ES_Functional_Currency__c='EUR',GE_HQ_STR03_PRT_COM_NAME__c = 'ES ENV');
        insert Bidacc3;
        Bidacc3.ParentId = Pacc2.Id;
        Bidacc3.GE_ES_LE_Type__c = 'Statutory Department';
        SOSDList.add(Bidacc3);
        
        Account Bidacc4 = new Account(RecordTypeId = (Id)accRecordTypes.get('Relationship Account'),Name = 'testSD4',GE_ES_LE_Type__c = 'Statutory Department',GE_HQ_HQ_Parent_Duns__c = '89977',GE_HQ_DUNS_Number__c = '22299123',GE_ES_Functional_Currency__c='EUR',GE_HQ_STR03_PRT_COM_NAME__c = 'ES MCS');
        insert Bidacc4;  
        Bidacc4.ParentId = Pacc2.Id;
        Bidacc4.GE_ES_LE_Type__c = 'Statutory Department';
        SOSDList.add(Bidacc4);
        update SOSDList;
        List<Opportunity> opplst = new List<Opportunity>(); 
        //oppty3.GE_ES_GE_Bid_Legal_Entity_Name__c = null;
        opplst.add(oppty3);
         
        //oppty2.GE_ES_GE_Bid_Legal_Entity_Name__c = null;
        opplst.add(oppty2);
        update opplst;
         
        //inserting exception record 
        GE_ES_Exception__c ex = new GE_ES_Exception__c(GE_ES_Opportunity_Name__c = oppty3.id,GE_ES_Is_SD_Not_Exists__c = true);
        insert ex;
         
        GE_ES_Exception__c ex2 = new GE_ES_Exception__c(GE_ES_Opportunity_Name__c = oppty2.id,GE_ES_Is_SD_Not_Exists__c = true);
        insert ex2;
         
        acc.currencyIsoCode = 'USD';
        system.debug('test final***'+acc.id);
        update acc;
         
        acc.currencyIsoCode = 'EUR';
        system.debug('test final***'+acc.id);
        update acc;
        system.assertequals(ex2.GE_ES_Opportunity_Name__c,oppty2.id);
       } 
          }catch(Exception ex){} 
     }    */           
}