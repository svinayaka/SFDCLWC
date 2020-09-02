@isTest
public class GE_OG_DTS_TimesheetHelper_Test{

    @isTest
    public static void eventinserttest(){
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        UserRole r = [SELECT Id from UserRole Where Name ='GE Energy Admin'];
    
            //Account 
            Account acc = new Account();
            ID accrecid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            acc.RecordTypeId = accrecid;
            acc.name = 'testaccount';
            acc.Classification__c = 'Strategic';
            acc.OwnerId = '005A0000001ztawIAA';
            insert acc;  
        
            //Service team creation
            SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
            team.Name = 'Test Non Home DTS';           
            insert team;
            
            //Technician creation
            SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();          
            tech.GE_SM_HQ_SSO_ID__c = '502726604';
            Id techrecid = Schema.SObjectType.SVMXC__Service_Group_Members__c .getRecordTypeInfosByName().get('GE OG DTS Technician').getRecordTypeId();
             tech.recordtypeid = techrecid;
            tech.SVMXC__Service_Group__c = team.Id;
            tech.SVMXC__Enable_Scheduling__c = true;
            tech.GE_SM_HQ_Controls_EmpType__c = 'FSE';
            insert tech;
            system.debug('tech'+tech.Id);
            
            Test.startTest();         
            // Workorder creation
            SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
            wo.SVMXC__Company__c = acc.id;
            Id worecid =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('GE OG DTS').getRecordTypeId();
            wo.recordtypeid = worecid;
            wo.GE_OG_MC_Business_Unit__c = 'F&PT';
            wo.GE_OG_MC_Service_Region__c = 'Coimbatore';
            wo.GE_SS_Customer_PO_number__c = '123123';
            wo.GE_OG_Service_Order__c = '223312';
            wo.GE_OG_GS_Customer_Want_Start_Date__c = System.today();
            wo.GE_OG_GS_Customer_Want_End_Date__c = system.today();
            wo.GE_OG_GS_Work_Scope_Notes__c = 'test';           
            wo.SVMXC__Order_Type__c = 'Field Service';
            insert wo;
            system.debug('WO'+wo.RecordTypeId);
            
            SVMXC__SVMX_Event__c  event = new SVMXC__SVMX_Event__c ();
            DateTime t = system.now();
            System.debug('t'+t);
            event.SVMXC__Service_Team__c =team.Id;
            event.SVMXC__Technician__c = tech.Id;
            event.SVMXC__Service_Order__c = wo.Id;
            event.Name = wo.Name;
            event.SVMXC__StartDateTime__c = t;
            event.SVMXC__EndDateTime__c = t.addDays(15);
            event.SVMXC__IsAllDayEvent__c = false;
            event.SVMXC__Location__c = '';
            event.SVMXC__WhatId__c = wo.Id;
            event.SVMXC__ActivityDate__c  = Date.today();
            event.SVMXC__ActivityDateTime__c  = t;
            event.SVMXC__DurationInMinutes__c  = 180;            
            insert event;
            
            Test.stopTest();
            
            event.SVMXC__StartDateTime__c = t.addDays(-8);
            event.SVMXC__EndDateTime__c = t.addDays(20);
            update event;             
            
            List<SVMXC__SVMX_Event__c> evelist = new List<SVMXC__SVMX_Event__c>();
            evelist.add(event);
            GE_OG_DTS_TimesheetHelper.updatetimesheetforoldevents(evelist);
            GE_OG_DTS_TimesheetHelper.createTimesheetFromSvmxeventinsert(evelist);           
            
      }
    
    @isTest
    public static void test1(){
    
            //Account 
            Account acc = new Account();
            ID accrecid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            acc.RecordTypeId = accrecid;
            acc.name = 'testaccount';
            acc.Classification__c = 'Strategic';
            acc.OwnerId = '005A0000001ztawIAA';
            insert acc;  
        
            //Service team creation
            SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
            team.Name = 'Test Non Home DTS';             
            insert team;
            
            //Technician creation
            SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();          
            tech.GE_SM_HQ_SSO_ID__c = '502726604';
            Id techrecid = Schema.SObjectType.SVMXC__Service_Group_Members__c .getRecordTypeInfosByName().get('GE OG DTS Technician').getRecordTypeId();
             tech.recordtypeid = techrecid;
            tech.SVMXC__Service_Group__c = team.Id;
            tech.SVMXC__Enable_Scheduling__c = true;
            tech.GE_SM_HQ_Controls_EmpType__c = 'FSE';
            insert tech;
            system.debug('tech'+tech.Id);
            
            // insert timesheet            
            SVMXC_Timesheet__c ts = new SVMXC_Timesheet__c();
            ts.Technician__c = tech.id;
            ts.Start_Date__c = system.today();
            ts.End_Date__c = ts.Start_Date__c.addDays(6);
            insert ts;
            
            List<GE_DS_Daily_Time_Summary__c> dtsList = new List<GE_DS_Daily_Time_Summary__c>();
                Date cDate = ts.Start_Date__c;
                GE_DS_Daily_Time_Summary__c dts = new GE_DS_Daily_Time_Summary__c();
                dts.GE_DS_Technician__c = ts.Technician__c;
                dts.GE_DS_Timesheet__c = ts.Id;
                dts.GE_DS_Total_Billable_Day__c = 0;
                
                while (cDate <= ts.End_Date__c)
                {
                    System.debug('cDate value is : '+cDate);
                    GE_DS_Daily_Time_Summary__c newDts = dts.clone(false,false,false,false);
                    newDts.GE_DS_Date__c = cDate;                           
                    dtsList.add(newDts);
                    cDate = cDate.addDays(1);
                }
                
            insert dtsList; 
           
            Test.startTest();           
            SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
            wo.SVMXC__Company__c = acc.id;
            Id worecid =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('GE OG DTS').getRecordTypeId();
            wo.recordtypeid = worecid;
            wo.GE_OG_MC_Business_Unit__c = 'F&PT';
            wo.GE_OG_MC_Service_Region__c = 'Coimbatore';
            wo.GE_SS_Customer_PO_number__c = '123123';
            wo.GE_OG_Service_Order__c = '223312';
            wo.GE_OG_GS_Customer_Want_Start_Date__c = System.today();
            wo.GE_OG_GS_Customer_Want_End_Date__c = system.today();
            wo.GE_OG_GS_Work_Scope_Notes__c = 'test';           
            wo.SVMXC__Order_Type__c = 'Field Service';
            insert wo;
            system.debug('WO'+wo.RecordTypeId);
            
            SVMXC__SVMX_Event__c  event = new SVMXC__SVMX_Event__c ();
            DateTime t = system.now();
            System.debug('t'+t);
            event.SVMXC__Service_Team__c =team.Id;
            event.SVMXC__Technician__c = tech.Id;
            event.SVMXC__Service_Order__c = wo.Id;
            event.Name = wo.Name;
            event.SVMXC__StartDateTime__c = t;
            event.SVMXC__EndDateTime__c = t.addDays(15);
            event.SVMXC__IsAllDayEvent__c = false;
            event.SVMXC__Location__c = '';
            event.SVMXC__WhatId__c = wo.Id;
            event.SVMXC__ActivityDate__c  = Date.today();
            event.SVMXC__ActivityDateTime__c  = t;
            event.SVMXC__DurationInMinutes__c  = 180;            
            insert event;
            
            delete event;
            
            undelete event;
            
            Test.stopTest();            
    }
    
}