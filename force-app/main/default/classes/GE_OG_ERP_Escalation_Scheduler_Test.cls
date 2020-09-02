@isTest
      
      private class GE_OG_ERP_Escalation_Scheduler_Test{
      static testmethod void  testschedule(){
       Test.StartTest();
        
       Account acc = new Account(name='test');
       insert acc;
         
        GE_OG_ERP_Escalation_Scheduler Escsch = new GE_OG_ERP_Escalation_Scheduler();
        GE_OG_ERP_Detail__c sh1 =  new GE_OG_ERP_Detail__c();
        sh1.GE_OG_Advance_User__c = 'shikha.chandra@ge.com';
        sh1.GE_OG_ERP_Advance_Input_Pending__c = true;
        datetime dt =system.now();
        dt = dt.adddays(-2);
        sh1.GE_OG_ERP_Outbound_Timestamp__c = string.valueof(dt);
        insert sh1;
        Datetime startDate = system.now();// Start date
             
              
        
       String sch = '0 0 0 * * ?'; 
        system.schedule('Test Territory Check', sch, Escsch ); 
   
    Test.stopTest();
    }
    }