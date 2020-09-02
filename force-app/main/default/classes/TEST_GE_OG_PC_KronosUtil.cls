/*
=======================================================================================================================================
Name       : TEST_GE_OG_PC_KronosUtil 
Author     : Amit Kumar
Created On : 13th May 2015
Purpose    : To calculate code coverage for "GE_OG_PC_KronosUtil"  Apex class
======================================================================================================================================
*/
@isTest(SeeAllData=true)
public class TEST_GE_OG_PC_KronosUtil{
    static testMethod void GE_OG_PC_KronosUtil(){
    	   test.startTest();
           try
           {   
               //ServiceTeam Helper data
               SVMXC__Service_Group__c srTeam = new SVMXC__Service_Group__c();
               srTeam.Name='Test Service Team';
               insert srTeam;   
               
               //Technician Helper Data
               SVMXC__Service_Group_Members__c tech1 = new SVMXC__Service_Group_Members__c();
               tech1.SVMXC__Service_Group__c=srTeam.Id;
               tech1.Name='Test Name';
               tech1.SVMCX_Status__c='Submitted';
               tech1.SVMXC__Salesforce_User__c=UserInfo.getUserId();
               tech1.GE_SM_HQ_SSO_ID__c='111222333';
               insert tech1;                 
                           
               //TimeSheet Helper Data
               SVMXC_Timesheet__c tS1 = new SVMXC_Timesheet__c();
               Id recTypeID = Schema.SObjectType.SVMXC_Timesheet__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
               tS1.recordtypeid = recTypeID;
               tS1.Start_Date__c=date.newInstance(system.today().year(), system.today().month(), system.today().day());
               tS1.GE_PC_Start_Time__c=Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
               tS1.Kronos_Billable_Hours__c=0.00;
               tS1.Kronos_OverTime_Hours__c=0.00;
               tS1.Kronos_Others_Hours__c=0.00;
               tS1.Total_Hours__c=40.00;
               insert tS1;
               SVMXC_Timesheet__c retTS = [SELECT Id, Name, Kronos_Billable_Hours__c, Kronos_OverTime_Hours__c, Kronos_Others_Hours__c FROM SVMXC_Timesheet__c WHERE id=:tS1.Id];
               System.debug('Time Sheet--> '+retTS);
                                           
               //TimeEntry Helper Data
               SVMXC_Time_Entry__c tE1 = new SVMXC_Time_Entry__c();
               Id recTypeID1 = Schema.SObjectType.SVMXC_Time_Entry__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
               tE1.recordtypeid = recTypeID1;
               tE1.Start_Date_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
               tE1.End_Date_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);                 
               tE1.Technician__c = tech1.ID;
               tE1.Timesheet__c = retTS.Id;
               tE1.GE_PC_Job_Code__c = 'OTJ Training';
               tE1.GE_PC_Earnings_Code__c = '';
               tE1.Total_Time__c = 30.00;
               insert tE1; 
               SVMXC_Time_Entry__c rettE1 = [SELECT Id, Name, Timesheet__r.id FROM SVMXC_Time_Entry__c WHERE Id=:tE1.Id];
               System.debug('TimeEntry 1-->'+rettE1);
			   
               SVMXC_Time_Entry__c tE2 = new SVMXC_Time_Entry__c();
               Id recTypeID2 = Schema.SObjectType.SVMXC_Time_Entry__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
               tE2.recordtypeid = recTypeID2;
               tE2.Start_Date_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
               tE2.End_Date_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);                 
               tE2.Technician__c = tech1.ID;
               tE2.Timesheet__c = retTS.Id;
               tE2.GE_PC_Job_Code__c = '';
               tE2.GE_PC_Earnings_Code__c  = '';
               tE2.Total_Time__c = 10.00;
               insert tE2;  
               SVMXC_Time_Entry__c rettE2 = [SELECT Id, Name, Timesheet__r.id FROM SVMXC_Time_Entry__c WHERE Id=:tE2.Id];
               System.debug('TimeEntry 2-->'+rettE2);
               
               SVMXC_Time_Entry__c tE3 = new SVMXC_Time_Entry__c();
               Id recTypeID3 = Schema.SObjectType.SVMXC_Time_Entry__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
               tE3.recordtypeid = recTypeID3;
               tE3.Start_Date_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
               tE3.End_Date_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);                 
               tE3.Technician__c = tech1.ID;
               tE3.Timesheet__c = retTS.Id;
               tE3.GE_PC_Job_Code__c = '';
               tE3.GE_PC_Earnings_Code__c = 'Vacation VA';
               tE3.Total_Time__c = 40.00;
               insert tE3; 
               SVMXC_Time_Entry__c rettE3 = [SELECT Id, Name, Timesheet__r.id FROM SVMXC_Time_Entry__c WHERE Id=:tE3.Id];  
               System.debug('TimeEntry 3-->'+rettE3);
         
               List<SVMXC_Time_Entry__c> teList = new List<SVMXC_Time_Entry__c>();
               teList.add(rettE1);
               teList.add(rettE2);
               teList.add(rettE3);
               GE_OG_PC_KronosUtil.calBillableOverTimeHrs(teList);
               delete rettE3;
               test.stopTest();
               
           }
           catch(Exception e){
            	System.debug('Exception :'+e.getMessage());
           }   
    }  
}