@isTest
Public Class GE_PRM_Batch_AccountType_Update_Test{
  
 /*   
    @testsetup
    static void createData(){
    
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@ge.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser1@ge.com');
                 
        account Racc = new account();
        Racc.name = 'Test1';
        Racc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Racc.ShippingCountry = 'India';
        Racc.Account_Tier_GEOG__c = 'Global';
        Racc.Type = 'Direct Customer';
        Racc.Classification__c = 'Strategic';
        insert Racc;
        
        
        account Cacc = new account();
        Cacc.name = 'Test2';
        Cacc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        Cacc.ShippingCountry = 'India';
        Cacc.Account_Tier_GEOG__c = 'LE';
        Cacc.Member_of_GE_OG__c = Racc.Id; 
        insert Cacc;
        
        
        GE_PRM_Channel_Appointment__c ca = New GE_PRM_Channel_Appointment__c();
        ca.GE_PRM_Appointment_Type__c = 'New';
        ca.GE_PRM_Tier_2_P_L__c = 'DTS';
        ca.GE_PRM_Account_Name__c = Cacc.Id;
        Insert ca;
        
  
        
         Apttus__APTS_Agreement__c ag = new Apttus__APTS_Agreement__c();       
         ag.Name = 'Test Agreement';
         ag.Apttus__Account__c = Cacc.Id;
         ag.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
         //ag.CurrencyIsoCode = 'AED - UAE Dirham';

         insert ag;
         
         
         Contract c = new Contract();  
         c.recordtypeid= Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();     
         c.Name = 'Test Con';
         c.AccountId = Cacc.Id;
         c.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
         c.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
         c.GE_HQ_Buss_Tier1__c = 'PII';
         c.GE_HQ_Buss_Tier2__c = 'Reuter Stokes';
         
         c.GE_OG_Legal_Entity__c = 'ALGESCO SPA';
         c.StartDate =  Date.Today();
         c.GE_OG_Contract_End_Date__c = Date.Today() +8 ;
         c.Status  =  'Generate Draft'; 
         c.GE_PRM_Contract_specialist__c=u.Id;
         c.GE_PRM_ERP_Contact__c=u.id;
         c.GE_OG_Legal_Entity__c='ALGESCO SPA';
         c.GE_OG_FA_Type__c = 'Discount';
         c.GE_PRM_For_Cause__c='Upon Notice';
         c.GE_PRM_Contract_Draft_date__c=date.today();
         c.GE_PRM_GE_Confirmed_Date__c=date.today();
         c.GE_PRM_Contract_Sent_to_CP__c=date.today();
         c.GE_PRM_ASC_Signed_contarct_received__c=date.today();
         c.GE_PRM_ASC_Signed_contract_received__c=date.today();
         c.GE_PRM_GE_Signatures_completed__c=date.today();   
         c.GE_PRM_Close_out__c=date.today();    
         c.GE_OG_Contract_End_Date__c=date.today();
         c.GE_PRM_Governing_Law__c='State of New York';
         c.GE_PRM_Arbitration_location__c='Houston, Texas';
         c.GE_PRM_Without_Cause__c='30 days';
         
         c.Change_in_law_clau_includes_taxes_GE_OG__c ='Yes';
         c.GE_Contract_Specialist__c = userinfo.getuserid();
         c.GE_PRM_For_Cause__c  ='30 days';
         c.CurrencyIsoCode ='INR';
         c.GE_PRM_Governing_Law__c = 'State of New York';
         c.Hold_Flag__c  =false;
         c.Red_Line__c  = false;
          insert c;
          
          
         
    }
   
    static testmethod void  createTest(){
           Test.StartTest();   
         
          // GE_PRM_Batch_AccountType_Update cc = new GE_PRM_Batch_AccountType_Update();
           //Database.ExecuteBatch(cc,100);
           GE_PRM_Batch_AccType_Scheduler schedulerApex  = new GE_PRM_Batch_AccType_Scheduler();
           SchedulableContext SC ;
           schedulerApex.execute(sc);
           Test.StopTest();
                 
   
   }
   
  */ 
}