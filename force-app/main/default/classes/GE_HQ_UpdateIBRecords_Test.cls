/*    
Class Name        : GE_HQ_UpdateIBRecords_Test
Purpose/Overview  : For coverage of Class 'GE_HQ_UpdateIBRecords' and Installed Base trigger 'GE_HQ_UpdateRel_GIB_Unit'
Author            : Jayadev Rath
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 31st Jan 2012 : Jayadev Rath       : Created: Created for the R-7151, BC S-04442 test coverage
                  :03th mar 2012 : Rekha N : Modified for the test code coverage
*/
@isTest
Private class GE_HQ_UpdateIBRecords_Test {
    Public static TestMethod void GE_HQ_UpdateIBRecords_Test() {
        User SysIntUser = [Select Id from User where UserName like '%energy.integration.og@ge.com%' limit 1];  // For covering the trigger        
        Account Acc = new Account(Name ='Test Acc'); Insert Acc;
        System.runAs(SysIntUser) {
            Id IBGenratorId = [Select id from Recordtype where sObjectType = 'GE_Installed_Base__c' and name = 'Generator' limit 1][0].id;
            GE_Installed_Base__c ib1= new GE_Installed_Base__c(Name ='Test999',RecordTypeId=IBGenratorId,Account__c= Acc.Id,GE_ES_GIB_Equipment__c=Null ,GE_ES_GE_Related_S_N__c='Test009');
            GE_Installed_Base__c ib2= new GE_Installed_Base__c(Name ='Test998',RecordTypeId=IBGenratorId,GE_ES_GIB_Equipment__c=Null ,GE_ES_GE_Related_S_N__c='Test008');
            List<GE_Installed_Base__c> IBList = new List<GE_Installed_Base__c>(); //Account__c= Acc.Id,
            IBList.add(ib1); IBList.add(ib2);
            Insert IBList;
            Test.startTest();
            GE_HQ_UpdateIBRecords UIB = new GE_HQ_UpdateIBRecords();
            IBList[1].GE_ES_GE_Related_S_N__c='Test999';
            IBList[0].Account__c=Null;
            Update IBList;
            String CRON_EXP = '0 0 0 3 9 ? 2022';
            String jobId = System.schedule('GE_HQ_UpdateIBRecords_Scheduler',CRON_EXP, new GE_HQ_UpdateIBRecords_Scheduler());
         //if(Test.isRunningTest())
            //Database.ExecuteBatch(UIB,199);
            Test.StopTest();
            
        }
    }
}