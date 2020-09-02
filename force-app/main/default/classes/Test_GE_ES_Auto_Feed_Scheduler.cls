/*
Type Name [Class/Trigger/Page Name] : Test Class
Used Where ?                        : Test Class for the Main Class - GE_ES_Auto_Feed_Scheduler
Functional Area                     : Chatter
Author                              : Sanjay Kumar Patidar
Created Date                        : Dec 19th 2011
Test Class Name                     : 

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

@isTest
private class Test_GE_ES_Auto_Feed_Scheduler
    {
    static testMethod void Test_GE_ES_Auto_Feed_Scheduler()
        {
            Test.startTest();
            try{
                GE_ES_Auto_Feed_Scheduler Scheduler = new GE_ES_Auto_Feed_Scheduler();
                String sch = '0 0 23 * * ?';
        
                Id jobId = System.schedule('Test Schedule', sch, Scheduler);
  
                   // Get the CronTrigger info prior to the run
                CronTrigger cronTrigger1 = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
                GE_ES_Auto_Feed_Scheduler.start();
            }Catch(Exception ex){}
            
            Test.stopTest();
         }
    }