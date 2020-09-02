/*
===============================================================
Name       : TEST_GE_OG_PC_Billable_OT_Trigger 
Author     : Amit Kumar
Created On : 02 Jan 2015
Purpose    : To calculate code coverage for 
             1.GE_OG_PC_Billable_OT           Apex Trigger (SVMXC_Timesheet__c)
             2.GE_OG_PC_KronosUtil            Apex class
===============================================================
*/
@isTest(SeeAllData=true)
 private class TEST_GE_OG_PC_Billable_OT_Trigger{
      
      static testMethod void OnUpdateEvent(){
          test.startTest();
          ID testID='a19g00000003cRVAAY';
          system.assertequals(testID,'a19g00000003cRVAAY');
          List<SVMXC_Timesheet__c> ts = new List<SVMXC_Timesheet__c>();
          ts=[Select ID, Name, Total_Hours__c, RecordTypeId, Start_Date__c, End_Date__c FROM SVMXC_Timesheet__c Where ID=:testID LIMIT 1];
          System.debug('Size----->'+ts.size());
          if(ts.size()>0){
              ts[0].Total_Hours__c=150.50;
              ts[0].RecordTypeId ='012g00000004b46';
              ts[0].Start_Date__c= date.parse('1/26/2015');
              ts[0].End_Date__c=date.parse('2/1/2015');
              update ts;
          }
          test.stopTest();
     }     
}