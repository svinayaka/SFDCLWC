/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(SeeAllData=true)
private class GE_DS_BonusSheetTest {

    static testMethod void ControllerTest() {
        
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c(
            Name = 'test',  GE_OG_DS_Billing_Admin_Email__c = 'test@test.com'
        );
        
        SVMXC__Skill__c skill = new SVMXC__Skill__c();
        skill.Name = 'Test';
        insert skill;
        
        insert team;
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
            SVMXC__Service_Group__c = team.Id,
            SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        
        insert tech;
        System.assertEquals(team.Id, tech.SVMXC__Service_Group__c);
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Skill__c = skill.Id;
        wo.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'D&S' AND SOBjectType = 'SVMXC__Service_Order__c' LIMIT 1].Id;
        insert wo;
        
        SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
        wd.RecordTypeId = ServiceMaxTimesheetUtils.getRecordTypeMap('SVMXC__Service_Order_Line__c').get(ServiceMaxTimesheetUtils.recordTypeWDTimeName);
        wd.SVMXC__Line_Type__c = 'Labor';
        wd.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
        wd.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 5, 0, 0);
        wd.SVMXC__Service_Order__c = wo.Id;
        wd.SVMXC__Group_Member__c = tech.Id;
        
        Test.startTest();
        
       
        try {
        insert wd;
        } catch (Exception e) {
       System.debug('An error occurred');
        }
        
        //insert wd;
        System.assertEquals(tech.Id, wd.SVMXC__Group_Member__c);
        List<SVMXC_Time_Entry__c> teList = [SELECT Id, Total_Time__c, Timesheet__r.Total_Hours__c, Timesheet__c FROM SVMXC_Time_Entry__c WHERE Work_Details__c = :wd.Id];
        
        
        PageReference pageRef = new PageReference('/apex/GE_DS_BonusSheet?id=' + teList.get(0).Timesheet__c);
        Test.setCurrentPageReference(pageRef);

        GE_DS_BonusSheetController controller = new GE_DS_BonusSheetController();
                
        Test.stopTest();
    }
    
   static testMethod void BonusSheetGenerationTest() {
    Profile chnlMagrId = [select id from Profile where name = 'GE_DS_Titanium Service Manager'];
   User chnlManr = new User(IsActive=true,firstname = 'channel1', lastname = 'manager1', email = 'chnmanager@bhge.com', alias = 'chnUsr', profileId = chnlMagrId.Id, Title = 'Channel Manager', Username = 'channelmagr@bhge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
       
       Test.startTest();
       
        try {
        insert chnlManr;
    } catch (Exception e) {
       System.debug('An error occurred');
    }
      
        
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c(
            Name = 'test',GE_OG_DS_Billing_Admin__c=chnlManr.Id ,GE_OG_DS_Billing_Admin_Email__c = 'test@test.com'
            
        ); 
        
    try {
        insert team;
    } catch (Exception e) {
       System.debug('An error occurred');
    }
    
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
            SVMXC__Service_Group__c = team.Id,
            SVMXC__Salesforce_User__c = UserInfo.getUserId(),
            GE_OG_DS_Bonus_Rate__c = 500,
            GE_OG_DS_Bonus_Rate_Type__c = 'Daily',
            GE_DS_Min_Hours_In_Day__c = 7
        );
        
        try{
        insert tech;
        } catch (Exception e){
       System.debug('An error occurred');
        }
        //Test.stopTest();
       
        System.assertEquals(team.Id, tech.SVMXC__Service_Group__c);
        
        SVMXC__Skill__c skill = new SVMXC__Skill__c();
        skill.Name = 'Test';
        
        try {
        insert skill;
        } catch (Exception e) {
       System.debug('An error occurred');
        }
        
        //insert skill;
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Skill__c = skill.Id;
        wo.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'D&S' AND SOBjectType = 'SVMXC__Service_Order__c' LIMIT 1].Id;
        try {
        insert wo;
        } catch (Exception e) {
        System.debug('An error occurred');
        }
        
        //insert wo;
        
        SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
        wd.RecordTypeId = ServiceMaxTimesheetUtils.getRecordTypeMap('SVMXC__Service_Order_Line__c').get(ServiceMaxTimesheetUtils.recordTypeWDTimeName);
        wd.SVMXC__Line_Type__c = 'Labor';
        wd.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
        wd.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 5, 0, 0);
        wd.SVMXC__Service_Order__c = wo.Id;
        wd.SVMXC__Group_Member__c = tech.Id;
        
        //Test.startTest();
        
        try {
        insert wd;
        } catch (Exception e) {
        System.debug('An error occurred');
        }
        //insert wd;
        System.assertEquals(tech.Id, wd.SVMXC__Group_Member__c);
        List<SVMXC_Time_Entry__c> teList = [SELECT Id, Total_Time__c, Timesheet__r.Total_Hours__c, Timesheet__c FROM SVMXC_Time_Entry__c WHERE Work_Details__c = :wd.Id];
        
        //GE_DS_BonusSheet.sendEmail(new List<Id> {teList.get(0).Timesheet__c});
        
        Test.stopTest();
    }
    
    
    
    static testMethod void ServiceTest() {
     id SendtoEmailList;
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c(
            Name = 'test',
            GE_OG_DS_Billing_Admin_Email__c = 'test@test.com'
        );
        
        SVMXC__Skill__c skill = new SVMXC__Skill__c();
        skill.Name = 'Test';
        insert skill;
        
        insert team;
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
            SVMXC__Service_Group__c = team.Id,
            SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        
        insert tech;
        System.assertEquals(team.Id, tech.SVMXC__Service_Group__c);
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Skill__c = skill.Id;
        wo.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'D&S' AND SOBjectType = 'SVMXC__Service_Order__c' LIMIT 1].Id;
        insert wo;
        
        SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
        wd.RecordTypeId = ServiceMaxTimesheetUtils.getRecordTypeMap('SVMXC__Service_Order_Line__c').get(ServiceMaxTimesheetUtils.recordTypeWDTimeName);
        wd.SVMXC__Line_Type__c = 'Labor';
        wd.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
        wd.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 5, 0, 0);
        wd.SVMXC__Service_Order__c = wo.Id;
        wd.SVMXC__Group_Member__c = tech.Id;
        
        Test.startTest();
        
        insert wd;
        System.assertEquals(tech.Id, wd.SVMXC__Group_Member__c);
         
       List<SVMXC_Time_Entry__c> teList = [SELECT Id, Total_Time__c, Timesheet__r.Total_Hours__c, Timesheet__c FROM SVMXC_Time_Entry__c WHERE Work_Details__c = :wd.Id];
        
        GE_DS_BonusSheetService.LogInfo a = new GE_DS_BonusSheetService.LogInfo();
        GE_DS_BonusSheetService.AllowFieldTruncationHeader_element b = new GE_DS_BonusSheetService.AllowFieldTruncationHeader_element();
        GE_DS_BonusSheetService.DebuggingHeader_element c = new GE_DS_BonusSheetService.DebuggingHeader_element();
        GE_DS_BonusSheetService.CallOptions_element d = new GE_DS_BonusSheetService.CallOptions_element();
        GE_DS_BonusSheetService.sendEmailResponse_element e = new GE_DS_BonusSheetService.sendEmailResponse_element();
        GE_DS_BonusSheetService.sendEmail_element g = new GE_DS_BonusSheetService.sendEmail_element();
        GE_DS_BonusSheetService.SessionHeader_element f = new GE_DS_BonusSheetService.SessionHeader_element();
        GE_DS_BonusSheetService.DebuggingInfo_element h = new GE_DS_BonusSheetService.DebuggingInfo_element();
        GE_DS_BonusSheetService.GE_DS_BonusSheet call = new GE_DS_BonusSheetService.GE_DS_BonusSheet();
        call.sendEmail(new List<Id> { teList.get(0).Timesheet__c });
            
    }
    
    static testMethod void BonusAttTest() {
    Profile chnlMagrId = [select id from Profile where name = 'GE_DS_Titanium Service Manager'];
   User chnlManr = new User(firstname = 'channel1', 
   lastname = 'manager1', Isactive=true,
   email = 'chnmanager@bhge.com', 
   alias = 'chnUsr', profileId = chnlMagrId.Id, 
   Title = 'Channel Manager', Username = 'channelmagr@bhge.com', 
   CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', 
   LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
       insert chnlManr;
        
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c(
            Name = 'test',GE_OG_DS_Billing_Admin__c=chnlManr.Id, GE_OG_DS_Billing_Admin_Email__c = 'test@test.com'
            
        );
        
        SVMXC__Skill__c skill = new SVMXC__Skill__c();
        skill.Name = 'Test';
        
         try {
        insert skill;
        } catch (Exception e) {
        System.debug('An error occurred');
        }
        //insert skill;
        
        try {
        insert team;
        } catch (Exception e) {
        System.debug('An error occurred');
        }
        //insert team;
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
            SVMXC__Service_Group__c = team.Id,
            SVMXC__Salesforce_User__c = UserInfo.getUserId(),
            GE_OG_DS_Bonus_Rate__c = 500,
            GE_OG_DS_Bonus_Rate_Type__c = 'Daily',
            GE_DS_Min_Hours_In_Day__c = 7
        );
        
        
        try {
        insert tech;
        } catch (Exception e) {
        System.debug('An error occurred');
        }
        //insert tech;
        System.assertEquals(team.Id, tech.SVMXC__Service_Group__c);
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Skill__c = skill.Id;
        wo.RecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'D&S' AND SOBjectType = 'SVMXC__Service_Order__c' LIMIT 1].Id;
        //insert wo;
        
        try {
        insert wo;
        } catch (Exception e) {
        System.debug('An error occurred');
        }
        
        List<SVMXC_Timesheet__c> tsList = [SELECT Id,Start_Date__c,End_Date__c,Total_Billable_Hours__c FROM SVMXC_Timesheet__c Limit 4];
     Set<SVMXC_Timesheet__c> tId= new Set<SVMXC_Timesheet__c>();
       // GE_DS_BonusSheet gdb= new GE_DS_BonusSheet();
       // gdb.sendEmail(tech.Id);
        
     SVMXC_Timesheet__c tis = new SVMXC_Timesheet__c();
      tis.Total_Billable_Hours__c = 8;
        tis.Total_Hours__c=10;
        tis.Start_Date__c=date.newInstance(2014, 2, 17);
        tis.End_Date__c=tis.Start_Date__c.addDays(2);
        //insert tis;
        
        try {
        insert tis;
        } catch (Exception e) {
        System.debug('An error occurred');
        }
        
        id SendtoEmailList;
        
        SendtoEmailList = tis.Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin__r.Id;
        
        Attachment attach=new Attachment();       
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=tis.id;
        //insert attach;
        
         try {
        insert attach;
        } catch (Exception e) {
        System.debug('An error occurred');
        }
        
        //System.assertequals(attach.parentId,csobj.Id);
        
        
        
        SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
        wd.RecordTypeId = ServiceMaxTimesheetUtils.getRecordTypeMap('SVMXC__Service_Order_Line__c').get(ServiceMaxTimesheetUtils.recordTypeWDTimeName);
        wd.SVMXC__Line_Type__c = 'Labor';
        wd.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
        wd.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 5, 0, 0);
        wd.SVMXC__Service_Order__c = wo.Id;
        wd.SVMXC__Group_Member__c = tech.Id;
        
        //Test.startTest();
         try {
        insert wd;
        } catch (Exception e) {
        System.debug('An error occurred');
        }
        //insert wd;
        System.assertEquals(tech.Id, wd.SVMXC__Group_Member__c);
        
       
        
        
        
        List<SVMXC_Time_Entry__c> teList = [SELECT Id, Total_Time__c, Timesheet__r.Total_Hours__c, Timesheet__c FROM SVMXC_Time_Entry__c WHERE Work_Details__c = :wd.Id Limit 3];
        //List<SVMXC_Timesheet__c> tsList = [SELECT Id,Start_Date__c,End_Date__c,Total_Billable_Hours__c FROM SVMXC_Timesheet__c WHERE Work_Details__c = :wd.Id];
        
        //GE_DS_BonusSheet.sendEmail(new List<Id> {teList.get(0).Timesheet__c});
        
        //Test.stopTest();
    
    
    
    
    }
}