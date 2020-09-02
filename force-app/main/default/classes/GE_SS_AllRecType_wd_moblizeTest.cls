@isTest

public class GE_SS_AllRecType_wd_moblizeTest{

public testMethod static void TestMethod1(){

    RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName = 'GE_SS_Daily' AND SObjectType = 'SVMXC__Service_Order__c' LIMIT 1];
    
    SVMXC__Skill__c skill = new SVMXC__Skill__c();
    skill.Name = 'Test';
    insert skill;
    
    SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
    wo.SVMXC__Skill__c = skill.Id;
    wo.RecordTypeId =rt.id;
    insert wo;
    
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
    
    SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
    wd.RecordTypeId = ServiceMaxTimesheetUtils.getRecordTypeMap('SVMXC__Service_Order_Line__c').get(ServiceMaxTimesheetUtils.recordTypeWDTimeName);
    wd.SVMXC__Line_Type__c = 'Labor';
    wd.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
    wd.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 5, 0, 0);
    wd.SVMXC__Service_Order__c = wo.Id;
    wd.SVMXC__Group_Member__c = tech.Id;  
    insert wd;
    
    
    test.startTest();
    ApexPages.StandardController sc = new ApexPages.StandardController(wd);
    GE_SS_AllRecType_workdetails_moblize geClass = new GE_SS_AllRecType_workdetails_moblize(sc);
    geClass.idval = String.valueOf(wd.id);
    geClass.deleteRec();
    geClass.redirectURL = '/001';
    System.assertEquals(geClass.Aid, null);
    geClass.Aid = wd.Id;
    geClass.init();
    System.assertNotEquals(geClass.Aid, null);
    geClass.allRec = 'true';
    geClass.init();
    test.stopTest();
}    
}