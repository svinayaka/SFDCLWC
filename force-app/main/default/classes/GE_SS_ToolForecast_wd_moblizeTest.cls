/*
Created By : Raju Manche
Created Date : 03/05/2018
Requirement Number : R-29757
Class Name : GE_SS_ToolForecast_wd_moblizeTest
Usage: Test Class for the following Class 
1.GE_SS_ToolForecast_workdetails_moblize 
2.GE_SS_Labor_Expense_workdetails_moblize 
3.GE_SS_Labor_Expense_Technician_WL_Ctrl 
Modified By : Raju Manche
Modified Date : 03/05/2018
Test Class : GE_SS_ToolForecast_wd_moblizeTest
*/
@isTest
public class GE_SS_ToolForecast_wd_moblizeTest {
    
    public testMethod static void TestMethod1() {
        Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();
        
        //RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName = 'GE_SS_Daily' AND SObjectType = 'SVMXC__Service_Order__c' LIMIT 1];
        
        SVMXC__Skill__c skill = new SVMXC__Skill__c();
        skill.Name = 'Test';
        insert skill;
        
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.Name = 'test';
        team.GE_HQ_Resource_Director__c = UserInfo.getUserId();
        insert team;
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
        tech.SVMXC__Service_Group__c = team.Id;
        tech.SVMXC__Salesforce_User__c = UserInfo.getUserId();
        tech.GE_OG_DS_Bonus_Rate__c = 500;
        tech.GE_OG_DS_Bonus_Rate_Type__c = 'Daily';
        insert tech;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Skill__c = skill.Id;
        wo.RecordTypeId =rtWOId;
        insert wo;
        List<SVMXC__Service_Order_Line__c> wdList = new List<SVMXC__Service_Order_Line__c > ();
        SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
        wd.RecordTypeId = ServiceMaxTimesheetUtils.getRecordTypeMap('SVMXC__Service_Order_Line__c').get(ServiceMaxTimesheetUtils.recordTypeWDTimeName);
        wd.SVMXC__Line_Type__c = 'Labor';
        wd.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
        wd.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 5, 0, 0);
        wd.SVMXC__Service_Order__c = wo.Id;
        wd.SVMXC__Group_Member__c = tech.Id;  
        wdList.add(wd);
        //insert wd;
        
        SVMXC__Service_Order_Line__c wd2 = new SVMXC__Service_Order_Line__c();
        wd2.RecordTypeId = ServiceMaxTimesheetUtils.getRecordTypeMap('SVMXC__Service_Order_Line__c').get(ServiceMaxTimesheetUtils.recordTypeWDTimeName);
        wd2.SVMXC__Line_Type__c = 'Labor';
        wd2.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
        wd2.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 5, 0, 0);
        wd2.SVMXC__Service_Order__c = wo.Id;
        wd2.SVMXC__Group_Member__c = tech.Id;  
        //insert wd;
        wdList.add(wd2);
        
        SVMXC__Service_Order_Line__c wd3 = new SVMXC__Service_Order_Line__c();
        wd3.RecordTypeId = ServiceMaxTimesheetUtils.getRecordTypeMap('SVMXC__Service_Order_Line__c').get(ServiceMaxTimesheetUtils.recordTypeWDTimeName);
        wd3.SVMXC__Line_Type__c = 'Labor';
        wd3.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
        wd3.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 5, 0, 0);
        wd3.SVMXC__Service_Order__c = wo.Id;
        wd3.SVMXC__Group_Member__c = tech.Id;
        wdList.add(wd3);
        insert wdList;
        
        
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(wd);
        GE_SS_ToolForecast_workdetails_moblize gsClass = new GE_SS_ToolForecast_workdetails_moblize(sc);
        
        ApexPages.StandardController sc2 = new ApexPages.StandardController(wd2);    
        GE_SS_Labor_Expense_workdetails_moblize gelbr = new GE_SS_Labor_Expense_workdetails_moblize(sc2);
        
        ApexPages.StandardController sc3 = new ApexPages.StandardController(wd3);
        GE_SS_Labor_Expense_Technician_WL_Ctrl techCtrl = new GE_SS_Labor_Expense_Technician_WL_Ctrl(sc3);
        
        gsClass.idval = String.valueOf(wd.id);
        gsClass.deleteRec();
        gsClass.redirectURL = '/001';
        System.assertEquals(gsClass.Aid, null);
        gsClass.Aid = wd.Id;
        gsClass.init();
        System.assertNotEquals(gsClass.Aid, null);
        gsClass.allRec = 'true';
        gsClass.init();
        gelbr.idval = String.valueOf(wd2.id);
        //gelbr.deleteRec();
        gelbr.redirectURL = '/001';
        //System.assertEquals(gelbr.Aid, null);
        gelbr.Aid = wd2.Id;
        gelbr.init();
        System.assertNotEquals(gelbr.Aid, null);
        gelbr.allRec = 'true';
        gelbr.init();
        gelbr.deleteRec();
        //Calling GE_SS_Labor_Expense_Technician_WL_Ctrl Class Methods
        techCtrl.idval = String.valueOf(wd3.id);    
        techCtrl.redirectURL = '/001';
        techCtrl.Aid = wd3.Id;
        techCtrl.init();
        System.assertNotEquals(gelbr.Aid, null);
        techCtrl.allRec = 'true';
        techCtrl.init();
        techCtrl.deleteRec();
        test.stopTest();
    }
    
}