@istest
private class Test_GE_OG_Task_TriggerHandlerManager  
{
    static testmethod void testTaskTriggerHandlerManager()
    {
        account a = new account();
        a.name='test';
        insert a;
        System.AssertEquals(a.name, 'test');
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
        //c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        insert c; 
        
        Task t = new Task();
        Id trid= Schema.SObjectType.task.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        t.OwnerId = UserInfo.getUserId();
        t.Subject='Donni';
        t.Status='Not Started';
        t.Priority='Normal';
         t.recordtypeid=trid;
         Date newDate = date.today().addDays(7);
         t.Task_Closure_Forecast_Date__c=newDate;
        
        t.whatId = c.id;
        t.Subject='Test CIR';
        insert t;
        t.Subject='Test1';
        update t;
         //set<Id> taskSet= new set<id>();
        //taskSet.add(c.id);
        
        
    }
    static testmethod void testTaskTriggerHandlerManager1()
    {
        account a = new account();
        a.name='test';
        insert a;
        System.AssertEquals(a.name, 'test');
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
        //c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        insert c; 
        
    Id trid= Schema.SObjectType.task.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        task t = new task();
        t.whatid=c.id;
        t.subject='Call';
         Date newDate = date.today().addDays(7);
        t.activitydate=date.valueof(newDate);
        t.status='In Progress';
        t.recordtypeid=trid;
        insert t;
        
        t.subject='Call1';
        update t;
}

    static testmethod void testTaskTriggerHandlerManager2()
    {
        account a = new account();
        a.name='test';
        insert a;
        System.AssertEquals(a.name, 'test');
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
        //c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        insert c; 
        
    Id trid= Schema.SObjectType.task.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
    Map<id,Task> mapTsk= new Map<Id,Task>();
        List<task> t = new List<task>{ new task(

        WhatID = c.id,

        Subject='Donni',

        Status='Completed',
        recordtypeid = trid,
        Task_Closure_Forecast_Date__c =system.today(),
        ActivityDate = system.today()+3,

        Priority='Normal')};

 

        insert t;
        mapTsk.put(t[0].id,t[0]);
        GE_OG_Task_TriggerHandlerManager OGTask = new GE_OG_Task_TriggerHandlerManager();
       // OGTask.afterinsertforecastupdate(t);  method commented on main class
       // OGTask.afterupdateforecastupdate(t,mapTsk);   method commented on main class
       
        //Added by Kiru for Sep Rel'18
        delete t;
        
        

        
}
static testmethod void testTaskTriggerHandlerManager3()
    {
        account a = new account();
        a.name='test';
        insert a;
        System.AssertEquals(a.name, 'test');
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
        //c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        insert c; 
        
        Task t = new Task();
        Id trid= Schema.SObjectType.task.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        t.OwnerId = UserInfo.getUserId();
        t.Subject='Donni';
        t.Status='Not Started';
        t.Priority='Normal';
         t.recordtypeid=trid;
         Date newDate = date.today().addDays(7);
         t.Task_Closure_Forecast_Date__c=newDate;
        
        t.whatId = c.id;
        t.Subject='Test CIR';
        insert t;
        t.Status='Completed';
        update t;
        t.Task_Closure_Forecast_Date__c = system.today();
        update t;
         //set<Id> taskSet= new set<id>();
        //taskSet.add(c.id);
        
        
    }
    static testmethod void testTaskTriggerHandlerManager4()
    {
        account a = new account();
        a.name='test';
        insert a;
        System.AssertEquals(a.name, 'test');
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
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
        //c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        c.Site_Contact_Information__c='SiteABD';
        insert c; 
        c.Status = 'Open';
        Update c;
        
        Task t = new Task();
        Id trid= Schema.SObjectType.task.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        t.OwnerId = UserInfo.getUserId();
        t.Subject='Donni';
        t.Status='Completed';
        t.Priority='Normal';
         t.recordtypeid=trid;
         Date newDate = date.today().addDays(7);
         t.Task_Closure_Forecast_Date__c=newDate;
        
        t.whatId = c.id;
        t.Subject='Test CIR';
        insert t;
        
         //set<Id> taskSet= new set<id>();
        //taskSet.add(c.id);
        
        
    }
}