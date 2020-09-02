/*
=======================================================================================================================================
Name       : Test_GE_OG_PCIntegration 
Author     : Amit Kumar
Created On : 13th May 2015
Purpose    : To calculate code coverage for "GE_OG_PC_TS_Kronos"  Apex class
======================================================================================================================================
*/
@isTest(SeeAllData=true)
public class TEST_GE_OG_PC_TS_Kronos {
    static testMethod void GE_OG_PC_TS_Kronos(){
           test.startTest();
           Id recTypeID= Schema.SObjectType.SVMXC_Timesheet__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
           try
           {
               Profile p = [SELECT Id FROM Profile WHERE Name='GE_PC_Titanium Service Manager']; 
               //User Helper data
               User usr = new User(Alias = 'PSM', Email='test@test.com', 
                                   EmailEncodingKey='UTF-8',FirstName='test', LastName='Testing', LanguageLocaleKey='en_US', 
                                   LocaleSidKey='en_US', ProfileId = p.Id, 
                                   TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
               
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
               SVMXC__Service_Group_Members__c tech2 = new SVMXC__Service_Group_Members__c();
               tech2.SVMXC__Service_Group__c=srTeam.Id;
               tech2.Name='Test Name 2';
               tech2.SVMCX_Status__c='Approved';
               tech2.SVMXC__Salesforce_User__c=UserInfo.getUserId();
               tech2.GE_SM_HQ_SSO_ID__c='000222333';
               insert tech2;  
               
               //TimeSheet Helper Data
               SVMXC_Timesheet__c tS1 = new SVMXC_Timesheet__c();
               tS1.Start_Date__c=date.newInstance(system.today().year(), system.today().month(), system.today().day());
               tS1.GE_PC_Start_Time__c=Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
               tS1.GE_OG_DS_Status__c='Submitted';
               tS1.Total_Hours__c=40.00;
               tS1.recordtypeid=recTypeID;
               insert tS1;
               //SVMXC_Timesheet__c rettS1 = [SELECT Id, Name FROM SVMXC_Timesheet__c WHERE id=:tS1.Id];
                            
               SVMXC_Timesheet__c tS2 = new SVMXC_Timesheet__c();
               tS2.Start_Date__c=date.newInstance(system.today().year(), system.today().month(), system.today().day());
               tS2.GE_PC_Start_Time__c=Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
               tS2.GE_OG_DS_Status__c='Approved';
               tS2.Total_Hours__c=40.00;
               tS2.recordtypeid=recTypeID;
               insert tS2;
               //SVMXC_Timesheet__c rettS2 = [SELECT Id, Name FROM SVMXC_Timesheet__c WHERE id=:tS2.Id];
               
               //Id recTypeID= Schema.SObjectType.SVMXC_Timesheet__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
               //List<SVMXC_Timesheet__c> rettS3 = [SELECT Id, Name  FROM SVMXC_Timesheet__c where recordtypeid=:recTypeID LIMIT 1];
               //System.debug('TimeSheet 3-->'+rettS3[0].Name);
                                            
               //TimeEntry Helper Data
               System.debug('---Insert Time Entry ---');
               SVMXC_Time_Entry__c tE1 = new SVMXC_Time_Entry__c();
               tE1.Start_Date_Time__c=Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
               tE1.End_Date_Time__c=Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);                 
               tE1.Technician__c=tech1.ID;
               tE1.Timesheet__c=tS1.Id;
               tE1.GE_OG_PC_Status__c='Submitted';
               insert tE1;
               //SVMXC_Time_Entry__c rettE1 = [SELECT Id, Name, Timesheet__c FROM SVMXC_Time_Entry__c WHERE id=:tE1.id];
                                           
               SVMXC_Time_Entry__c tE2 = new SVMXC_Time_Entry__c();
               tE2.Start_Date_Time__c=Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
               tE2.End_Date_Time__c=Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);                 
               tE2.Technician__c=tech2.ID;
               tE2.Timesheet__c=tS2.Id;
               tE2.GE_OG_PC_Status__c='Approved';
               insert tE2; 
               //SVMXC_Time_Entry__c rettE2 = [SELECT Id, Name, Timesheet__c FROM SVMXC_Time_Entry__c WHERE id=:tE2.id];
                                                                                                        
               System.debug('--TimeSheets--'+tE1  +'\t ' +tE2);
               //System.debug('---Time Entry Inserted Successfully ---');
               String result1=GE_OG_PC_TS_Kronos.PC_ApproveTimeSheet(tS1.Id); 
               String result2=GE_OG_PC_TS_Kronos.PC_ApproveTimeSheet(tS2.Id); 
               String result3=GE_OG_PC_TS_Kronos.PC_ApproveTimeSheet(null);
               Id dummyID='a19000000000000';  
               String result4=GE_OG_PC_TS_Kronos.PC_ApproveTimeSheet(dummyID);
               System.debug('---Kronos Apex executed Successfully ---');
               test.stopTest();                 
           }
           catch(Exception e){
               System.debug('Exception :'+e.getMessage());
          }  
      }
}