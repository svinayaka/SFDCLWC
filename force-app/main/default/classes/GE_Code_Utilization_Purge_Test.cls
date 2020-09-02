/*
Class/Trigger Name      : GE_Code_Utilization_Purge_Test
Used Where ?            : Code Utlization
Purpose/Overview        : To delete the code utilization records older than 180 days
Functional Area         : Innovation & Simplification
Author                  : Prasad Yadala
Created Date            : 12/30/2014
Test Class Name         : 
Code Coverage           : 

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/
@isTest
private class GE_Code_Utilization_Purge_Test
{
    static testMethod void testConstructor1()
    {
        //inserting test record for code utilization
        GE_Code_Utilization__c  CU = new GE_Code_Utilization__c(GE_COMPONENT_NAME__C = 'Test Controller',GE_COMPONENT_TYPE__C = 'Controller',GE_DATE_REFERENCED__C = DateTime.Now(),GE_REFERENCED_BY__C=UserInfo.getUserId());
        insert CU;

        
        GE_Code_Utilization_Purge.Duration = 0;
        DateTime dt = Datetime.now().addSeconds(3);
        String hour = String.valueOf(dt.hour());
        String min = String.valueOf(dt.minute());       
        String ss = String.valueOf(dt.second());

        //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
        Test.startTest();
        GE_Code_Utilization_Purge GCU = new GE_Code_Utilization_Purge(); 
        System.schedule('Job Started At ' + String.valueOf(Datetime.now()), nextFireTime, GCU);
        Test.stopTest();
        
        List<GE_Code_Utilization__c> CULst = [select id,GE_COMPONENT_NAME__C from GE_Code_Utilization__c];
        system.assertequals(CULst.size(),1);
        
    }

}