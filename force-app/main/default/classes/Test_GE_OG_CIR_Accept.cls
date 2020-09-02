/*
Type Name [Class/Trigger/Page Name] : Class - Test_GE_OG_CIR_Accept
Purpose                             : Code coverage for GE_OG_CIR_Accept
Functional Area                     : Service
Author                              : CaseTeam
Created Date                        : 6 August 2014

*/

@istest
private class Test_GE_OG_CIR_Accept {
    
    static testmethod void method1()
    {
     //Profile p = [SELECT Id FROM Profile WHERE Name='GE_OG_CIR_Initiator']; 
    //User user = new User(firstname = 'channel', lastname = 'manager', email = 'chnmanager@ge.com', alias = 'chnUsr', profileId = p.Id, Title = 'Channel Manager', Username = 'channelmagr@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
      //  insert user;
       test.starttest();
        account a = new account();
        a.name='test';
        insert a;
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        insert gi;
        
        system.assertequals(gi.name,'test');
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C.GE_OG_Business_CIR__c='TMS'; 
        c.GE_OG_EHS_Product_Safety_CIR__c='Accident';
        c.GE_OG_Customer_Impact_CIR__c='High';
        c.GE_OG_Customer_Escalation_CIR__c='High';
        //c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        c.setOptions(dmlOpts);
        insert c; 
        apexpages.currentpage().getparameters().put('CaseId',c.id);
        
        GE_OG_CIR_Accept ge = new GE_OG_CIR_Accept();
        ge.ChangeOwnerName();
    
        
        test.stoptest();
    }
    static testmethod void method2()
    {
        test.starttest();
        Profile sProfileID = [select id from profile where name ='GE_OG_Super User'  limit 1];
        User superuser= [select id ,name from user where profileid=:sProfileID.id And Isactive = true limit 1];
        System.runas(superuser){
     
        account a = new account();
        a.name='test';
        insert a;
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        insert gi;
    
        
      
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C.GE_OG_Business_CIR__c='TMS'; 
        c.GE_OG_EHS_Product_Safety_CIR__c='Accident';
        c.GE_OG_Customer_Impact_CIR__c='High';
        c.GE_OG_Customer_Escalation_CIR__c='High';
        c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';  
     
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        c.setOptions(dmlOpts);
        insert c; 
        apexpages.currentpage().getparameters().put('CaseId',c.id);
     
        GE_OG_CIR_Accept ge = new GE_OG_CIR_Accept();
        ge.ChangeOwnerName();
        ge.ChangeOwnerName();
        
        
         case c1 = new case();        
        c1.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C1.GE_OG_Business_CIR__c='TMS'; 
        c1.GE_OG_EHS_Product_Safety_CIR__c='Accident';
        c1.GE_OG_Customer_Impact_CIR__c='High';
        c1.GE_OG_Customer_Escalation_CIR__c='High';
        c1.GE_OG_Sub_Business_CIR__c='Trees';    
        c1.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c1.GE_ES_Sub_Type__c='MCS Sub Status';  
     
        c1.accountid=a.id;   
        c1.recordtypeid=r;
        c1.status='Waiting for Customer';
        c1.GE_OG_CIR_Site_Name__c='sdf';
        c1.GE_OG_CIR_Unit_Serial_number__c=gi.id;
         insert c1;
        test.stoptest();}
    }
    
     static testmethod void method3()
    {
        test.starttest();
       
        Group testGroup = new Group(Name = 'Queue', Type = 'Queue');
        insert testGroup;
        
        User objUser =  [Select id,name from User where id = :UserInfo.getUserID()];
        
        
        QueueSobject testQueue = new QueueSObject(QueueId = testGroup.Id, SobjectType = 'Case');
        insert testQueue;
        
        GroupMember grpmem = new GroupMember(GroupId=testGroup.Id, UserOrGroupId=objUser.Id);
        insert grpmem;
  
System.runAs(objUser) {   
   

        account a = new account();
        a.name='test';
        insert a;
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        insert gi;
    
        
      
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C.GE_OG_Business_CIR__c='TMS'; 
        c.GE_OG_EHS_Product_Safety_CIR__c='Accident';
        c.GE_OG_Customer_Impact_CIR__c='High';
        c.GE_OG_Customer_Escalation_CIR__c='High';
        c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';  
     
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        c.setOptions(dmlOpts);
        insert c; 
        apexpages.currentpage().getparameters().put('CaseId',c.id);
     
        GE_OG_CIR_Accept ge = new GE_OG_CIR_Accept();
        String uid = ge.userid;
        ge.ChangeOwnerName();
        ge.ChangeOwnerName();
        
     
        
        }
           test.stoptest();
    }
}