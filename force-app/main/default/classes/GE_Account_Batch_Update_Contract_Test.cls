@istest
Public class GE_Account_Batch_Update_Contract_Test {


    @testsetup
    static void createData(){
                 
        account Racc = new account();
        Racc.name = 'Test1';
        Racc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Racc.ShippingCountry = 'India';
        Racc.Type = 'Direct Customer';
        Racc.Classification__c = 'Strategic';
        Racc.Account_Tier_GEOG__c = 'Country';
        insert Racc;
        
        
        account Cacc = new account();
        Cacc.name = 'Test2';
        Cacc.Account_Tier_GEOG__c='LE';
        Cacc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        Cacc.ShippingCountry = 'India';
        //Cacc.Account_Tier_GEOG__c = 'Global';
        Cacc.Oil_Gas_Parent_Account__c = Racc.Id; 
       // Cacc.Member_of_GE_OG__c='India/HQ';
        insert Cacc;
        
        
     /*   GE_PRM_Channel_Appointment__c ca = New GE_PRM_Channel_Appointment__c();
        ca.GE_PRM_Appointment_Type__c = 'New';
        ca.GE_PRM_Tier_2_P_L__c = 'DTS';
        ca.GE_PRM_Account_Name__c = Cacc.Id;
        Insert ca;*/
        
  
  /*      
         Apttus__APTS_Agreement__c ag = new Apttus__APTS_Agreement__c();
         ag.Name = 'Test Agreement';
         ag.Apttus__Account__c = Cacc.Id;
         ag.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
         //ag.CurrencyIsoCode = 'AED - UAE Dirham';
         ag.recordtypeid= Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();             
         insert ag;
  */       
         Contract c = new Contract(); 
         c.Name = 'Test Con';
         c.AccountId = Cacc.Id;
        // c.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
         c.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
         c.GE_HQ_Buss_Tier1__c = 'PII';
         c.GE_HQ_Buss_Tier2__c = 'Reuter Stokes';
         c.GE_OG_Legal_Entity__c = 'ALGESCO SPA';
         c.StartDate =  Date.Today();
         c.GE_OG_Contract_End_Date__c = Date.Today() +8 ;
         c.Status  =  'Generate Draft'; 
         c.GE_OG_FA_Type__c = 'Discount';
         //c.GE_PRM_Commercial_Account__c = null;
         c.GE_PRM_Commercial_Account__c=Cacc.Oil_Gas_Parent_Account__c;
        c.GE_Commercial_Member_Of_GE_OG__c= Cacc.Member_of_GE_OG__c;
         //c.recordtypeid= Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId(); 
         c.recordtypeid= Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Master Frame Agreement').getRecordTypeId();      
         insert c;
         }
         
        public static testMethod void GE_PRM_Batch_Update_CAgr_test1()
        {
         Test.StartTest(); 
           GE_Account_Batch_Update_Contract batchApex = new GE_Account_Batch_Update_Contract();
           ID jobID = Database.executeBatch(batchApex);
           Test.StopTest();
           }
// Adding piece of code to cover  GE_PRM_Batch_AccType_Scheduler  class .
    
 static testmethod void schedulerTest() 
    {
        GE_PRM_Batch_AccType_Scheduler schedule_apex = new GE_PRM_Batch_AccType_Scheduler();
        String CRON_EXP = '0 0 0 15 3 ? *';

        Test.startTest();

            String jobId = System.schedule('ScheduleApexClassTest',  CRON_EXP, schedule_apex);
          //  CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
          //  System.assertEquals(CRON_EXP, ct.CronExpression);
           // System.assertEquals(0, ct.TimesTriggered);

        Test.stopTest();
        
    }
    
   // code end for scheduler test class 
    
}