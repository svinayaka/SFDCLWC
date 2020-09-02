@isTest
public class GE_DTS_Non_Home_Territory_Test {
       
       
     @isTest
    public static void Approvedworkordertest(){
    
    Id pid=null;
    Profile p = [SELECT Id FROM Profile WHERE Name='GE_OG_DTS_Service Admin']; 
        Profile q = [SELECT Id FROM PROFILE WHERE NAME='OG_Sales/Comm Ops'];
        UserRole r = [SELECT Id from UserRole Where Name ='SMax - DTS Admin'];
       // UserRole m = [Select id from UserRole where Name ='SMax Global Admin'];
        
        User manager = new User(Alias = 'dmanag', Email='manager@dts.com',CommunityNickname='DTSMan',UserRoleId=r.Id,
                             EmailEncodingKey='UTF-8', LastName='DTSmanager', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = q.Id, 
                             TimeZoneSidKey='America/Los_Angeles', UserName='manager@dts.com'); 
         insert manager;
        
        User home = new User(Alias = 'dmana', Email='home@dts.com',CommunityNickname='DTS',UserRoleId=r.Id,
                             EmailEncodingKey='UTF-8', LastName='DTS', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = p.Id, 
                             TimeZoneSidKey='America/Los_Angeles', UserName='home@dts.com');
                             insert home;
        User nonhome = new User(Alias = 'pkond', Email='nonhome@dts.com',CommunityNickname='DTSNon',UserRoleId=r.Id,
                                EmailEncodingKey='UTF-8', LastName='DTSNon', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id,ManagerId = manager.id, 
                                TimeZoneSidKey='America/Los_Angeles', UserName='nonhome@dts.com');
        insert nonhome;
          
        
        System.runAs(nonhome) {
            // The following code runs as user 'u' 
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            
           //Account 
            Account acc = new Account();
            ID accrecid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            acc.RecordTypeId = accrecid;
            acc.name = 'testaccount';
            acc.Classification__c = 'Strategic';
            acc.OwnerId = '005A0000001ztawIAA';
            insert acc;  
        
           // Service team creation
            SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
            team.Name = 'Test Non Home DTS';
            team.SVMXC__Active__c = true;
            team.GE_HQ_P_L_Level__c = 'O&G>DTS';
            team.GE_HQ_Sub_P_L__c = 'F&PT';
            team.GE_HQ_Region__c = 'India';
            team.GE_HQ_Resource_Director__c = home.id; 
            insert team;
            
            // tecnician creation
            SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();          
            tech.GE_SM_HQ_SSO_ID__c = '502726604';
            Id techrecid = Schema.SObjectType.SVMXC__Service_Group_Members__c .getRecordTypeInfosByName().get('GE OG DTS Technician').getRecordTypeId();
            Id techrectid = Schema.SObjectType.SVMXC__Service_Group_Members__c .getRecordTypeInfosByName().get('Digital Solutions Technician').getRecordTypeId();
            tech.recordtypeid = techrecid;
           tech.recordtypeid = techrectid;
            tech.SVMXC__Service_Group__c = team.Id;
            tech.SVMXC__Enable_Scheduling__c = true;
            tech.GE_SM_HQ_Controls_EmpType__c = 'FSE';
            insert tech;
            system.debug('tech'+tech.Id);
            
             
            //Dispatcher Access
            SVMXC__Dispatcher_Access__c access = new SVMXC__Dispatcher_Access__c();
            access.SVMXC__Dispatcher__c = nonhome.id;
            access.GE_HQ_Not_Home_Territory__c = true;
            access.SVMXC__Service_Team__c = team.Id;
            insert access;
            
                      
            // Workorder creation
            SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
            wo.SVMXC__Company__c = acc.id;
           // wo.RecordTypeId = '012V00000000Sf0';           
            wo.GE_OG_MC_Business_Unit__c = 'F&PT';
            wo.GE_OG_MC_Service_Region__c = 'Coimbatore';
            wo.GE_SS_Customer_PO_number__c = '123123';
            wo.GE_OG_Service_Order__c = '223312';
            wo.GE_OG_GS_Customer_Want_Start_Date__c = System.today();
            wo.GE_OG_GS_Customer_Want_End_Date__c = system.today();
            wo.GE_OG_GS_Work_Scope_Notes__c = 'test';
            wo.GE_SM_HQ_Technician_Home_Dispatcher__c = home.Id;
            wo.GE_PC_Driving_Directions__c = ''+tech.id+';'+team.id+';false;'+'06/09/2017 8:30 AM;06/09/2017 9:30 AM,';
            insert wo;
            system.debug('WO'+wo.RecordTypeId);
            
            //update wo ie assignment
            
            wo.GE_SM_HQ_Dispatched_Outside_Territory__c = true;   
            wo.SVMXC__Service_Group__c = team.Id;
            wo.SVMXC__Group_Member__c = tech.Id;
          
            Test.startTest();
            update wo;     
            
            GE_OG_DTS_EventDetail ed = new GE_OG_DTS_EventDetail();
            ed.woid = wo.id;
            ed.getComments();
            ed.getUrl();
            ed.geteventdetails();           
             Test.stopTest();           
        
          
    }       
    
    }
     
     @isTest
    public static void approvalTestForNonHomeWorkOrder(){
        Profile p = [SELECT Id FROM Profile WHERE Name='GE_OG_DTS_Service Admin']; 
        Profile q = [SELECT Id FROM PROFILE WHERE NAME='OG_Sales/Comm Ops'];
        Profile s = [SELECT Id FROM PROFILE WHERE NAME='System Administrator'];
        UserRole r = [SELECT Id from UserRole Where Name ='SMax - DTS Admin'];
       // UserRole m = [Select id from UserRole where Name ='SMax Global Admin'];
        
        User manager = new User(Alias = 'dmanag', Email='manager@dts.com',CommunityNickname='DTSMan',UserRoleId=r.Id,
                             EmailEncodingKey='UTF-8', LastName='DTSmanager', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = q.Id, 
                             TimeZoneSidKey='America/Los_Angeles', UserName='manager@dts.com'); 
         insert manager;
        
        User home = new User(Alias = 'dmana', Email='home@dts.com',CommunityNickname='DTS',UserRoleId=r.Id,
                             EmailEncodingKey='UTF-8', LastName='DTS', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = s.Id, 
                             TimeZoneSidKey='America/Los_Angeles', UserName='home@dts.com');
                             insert home;
        User nonhome = new User(Alias = 'pkond', Email='nonhome@dts.com',CommunityNickname='DTSNon',UserRoleId=r.Id,
                                EmailEncodingKey='UTF-8', LastName='DTSNon', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id,ManagerId = manager.id, 
                                TimeZoneSidKey='America/Los_Angeles', UserName='nonhome@dts.com');
        insert nonhome;
          
        
        System.runAs(nonhome) {
            // The following code runs as user 'u' 
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            
           //Account 
            Account acc = new Account();
            ID accrecid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            acc.RecordTypeId = accrecid;
            acc.name = 'testaccount';
            acc.Classification__c = 'Strategic';
          acc.OwnerId = '005A0000001ztawIAA';
            insert acc;  
        
           // Service team creation
            SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
            team.Name = 'Test Non Home DTS';
            team.SVMXC__Active__c = true;
            team.GE_HQ_P_L_Level__c = 'O&G>DTS';
            team.GE_HQ_Sub_P_L__c = 'F&PT';
            team.GE_HQ_Region__c = 'India';
            team.GE_HQ_Resource_Director__c = home.id; 
            insert team;
            
            // tecnician creation
            SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();          
            tech.GE_SM_HQ_SSO_ID__c = '502726604';
             Id techrecid = Schema.SObjectType.SVMXC__Service_Group_Members__c .getRecordTypeInfosByName().get('GE OG DTS Technician').getRecordTypeId();
             Id techrectid = Schema.SObjectType.SVMXC__Service_Group_Members__c .getRecordTypeInfosByName().get('Digital Solutions Technician').getRecordTypeId(); 
            tech.recordtypeid = techrecid;
            tech.recordtypeid = techrectid;
            tech.SVMXC__Service_Group__c = team.Id;
            tech.SVMXC__Enable_Scheduling__c = true;
            tech.GE_SM_HQ_Controls_EmpType__c = 'FSE';
            insert tech;
            system.debug('tech'+tech.Id);
            
            //Dispatcher Access
            SVMXC__Dispatcher_Access__c access = new SVMXC__Dispatcher_Access__c();
            access.SVMXC__Dispatcher__c = nonhome.id;
            access.GE_HQ_Not_Home_Territory__c = true;
            access.SVMXC__Service_Team__c = team.Id;
            insert access;
                                 
           
           Test.startTest();
             SVMXC__Service_Order__c wo1 = new SVMXC__Service_Order__c();
            wo1.SVMXC__Company__c = acc.id;
                  
            wo1.GE_OG_MC_Business_Unit__c = 'F&PT';
            wo1.GE_OG_MC_Service_Region__c = 'Coimbatore';
            wo1.GE_SS_Customer_PO_number__c = '123123';
            wo1.GE_OG_Service_Order__c = '223312';
            wo1.GE_OG_GS_Customer_Want_Start_Date__c = System.today();
            wo1.GE_OG_GS_Customer_Want_End_Date__c = system.today();
            wo1.GE_OG_GS_Work_Scope_Notes__c = 'test';
            wo1.GE_SM_HQ_Technician_Home_Dispatcher__c = home.Id;
            
            insert wo1;
                       
           
            // assign wo, create servicemax event
            SVMXC__SVMX_Event__c  event = new SVMXC__SVMX_Event__c ();
            DateTime t = DateTime.newInstance(2017,5,18,12,30,6);
            System.debug('t'+t);
            event.SVMXC__Service_Team__c =team.Id;
            event.SVMXC__Technician__c = tech.Id;
            event.SVMXC__Service_Order__c = wo1.Id;
            event.Name = wo1.Name;
            event.SVMXC__StartDateTime__c = t;
            event.SVMXC__EndDateTime__c = t.addHours(3);
            event.SVMXC__IsAllDayEvent__c = false;
            event.SVMXC__Location__c = '';
            event.SVMXC__WhatId__c = wo1.Id;
            event.SVMXC__ActivityDate__c  = Date.today();
            event.SVMXC__ActivityDateTime__c  = t;
            event.SVMXC__DurationInMinutes__c  = 180;            
            insert event;
            
            
              
            Test.stopTest();
          
        }
        
        
        
    } 
    
    
    @isTest
    public static void unassignmentemailtest(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='GE_OG_DTS_Service Admin']; 
        Profile q = [SELECT Id FROM PROFILE WHERE NAME='OG_Sales/Comm Ops'];
        UserRole r = [SELECT Id from UserRole Where Name ='SMax - DTS Admin'];
       // UserRole m = [Select id from UserRole where Name ='SMax Global Admin'];
        
        User manager = new User(Alias = 'dmanag', Email='manager@dts.com',CommunityNickname='DTSMan',UserRoleId=r.Id,
                             EmailEncodingKey='UTF-8', LastName='DTSmanager', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = q.Id, 
                             TimeZoneSidKey='America/Los_Angeles', UserName='manager@dts.com'); 
         insert manager;
        
        User home = new User(Alias = 'dmana', Email='home@dts.com',CommunityNickname='DTS',UserRoleId=r.Id,
                             EmailEncodingKey='UTF-8', LastName='DTS', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = p.Id, 
                             TimeZoneSidKey='America/Los_Angeles', UserName='home@dts.com');
                             insert home;
        User nonhome = new User(Alias = 'pkond', Email='nonhome@dts.com',CommunityNickname='DTSNon',UserRoleId=r.Id,
                                EmailEncodingKey='UTF-8', LastName='DTSNon', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id,ManagerId = manager.id, 
                                TimeZoneSidKey='America/Los_Angeles', UserName='nonhome@dts.com');
        insert nonhome;
          
        
        System.runAs(home) {
            // The following code runs as user 'u' 
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            
           //Account 
            Account acc = new Account();
            ID accrecid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            acc.RecordTypeId = accrecid;
            acc.name = 'testaccount';
            acc.Classification__c = 'Strategic';
          acc.OwnerId = '005A0000001ztawIAA';
            insert acc;  
        
           // Service team creation
            SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
            team.Name = 'Test Non Home DTS';
            team.SVMXC__Active__c = true;
            team.GE_HQ_P_L_Level__c = 'O&G>DTS';
            team.GE_HQ_Sub_P_L__c = 'F&PT';
            team.GE_HQ_Region__c = 'India';
            team.GE_HQ_Resource_Director__c = home.id; 
            insert team;
            
            // tecnician creation
            SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();          
            tech.GE_SM_HQ_SSO_ID__c = '502726604';
            Id techrecid = Schema.SObjectType.SVMXC__Service_Group_Members__c .getRecordTypeInfosByName().get('GE OG DTS Technician').getRecordTypeId();
            Id techrectid = Schema.SObjectType.SVMXC__Service_Group_Members__c .getRecordTypeInfosByName().get('Digital Solutions Technician').getRecordTypeId();
            tech.recordtypeid = techrecid;
            tech.recordtypeid = techrectid;
            tech.SVMXC__Service_Group__c = team.Id;
            tech.SVMXC__Enable_Scheduling__c = true;
            tech.GE_SM_HQ_Controls_EmpType__c = 'FSE';
            insert tech;
            system.debug('tech'+tech.Id);
            
            
            
            //Dispatcher Access
            SVMXC__Dispatcher_Access__c access = new SVMXC__Dispatcher_Access__c();
            access.SVMXC__Dispatcher__c = nonhome.id;
            access.GE_HQ_Not_Home_Territory__c = false;
            access.SVMXC__Service_Team__c = team.Id;
            insert access;
            
                      
            // Workorder creation
            SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
            wo.SVMXC__Company__c = acc.id;
                     
            wo.GE_OG_MC_Business_Unit__c = 'F&PT';
            wo.GE_OG_MC_Service_Region__c = 'Coimbatore';
            wo.GE_SS_Customer_PO_number__c = '123123';
            wo.GE_OG_Service_Order__c = '223312';
            wo.GE_OG_GS_Customer_Want_Start_Date__c = System.today();
            wo.GE_OG_GS_Customer_Want_End_Date__c = system.today();
            wo.GE_OG_GS_Work_Scope_Notes__c = 'test';
            wo.GE_SM_HQ_Technician_Home_Dispatcher__c = home.Id;
            wo.SVMXC__Order_Type__c = 'Field Service';
            insert wo;
            system.debug('WO'+wo.RecordTypeId);
            
            //update wo ie assignment
            Test.startTest();
           
            wo.SVMXC__Service_Group__c = team.Id;
            wo.SVMXC__Group_Member__c = tech.Id;
         
            update wo;  
            
            SVMXC__SVMX_Event__c  event = new SVMXC__SVMX_Event__c ();
            DateTime t = DateTime.newInstance(2017,5,18,12,30,6);
            System.debug('t'+t);
            event.SVMXC__Service_Team__c =team.Id;
            event.SVMXC__Technician__c = tech.Id;
            event.SVMXC__Service_Order__c = wo.Id;
            event.Name = wo.Name;
            event.SVMXC__StartDateTime__c = t;
            event.SVMXC__EndDateTime__c = t.addHours(3);
            event.SVMXC__IsAllDayEvent__c = false;
            event.SVMXC__Location__c = '';
            event.SVMXC__WhatId__c = wo.Id;
            event.SVMXC__ActivityDate__c  = Date.today();
            event.SVMXC__ActivityDateTime__c  = t;
            event.SVMXC__DurationInMinutes__c  = 180;
            //event.SVMXC__Technician__c ='';            
            insert event;
            
           
            
          /*  GE_DS_RemoveTechnicianforServicemaxevent removetech = new GE_DS_RemoveTechnicianforServicemaxevent();
            GE_DS_RemoveTechnicianforServicemaxevent.Eventtechnician(event); */
            
            GE_HQ_WorkorderTechUnAssignment wounassign = new GE_HQ_WorkorderTechUnAssignment();
            List<GE_HQ_WorkorderTechUnAssignment.SMaxEventEmailBean> smaxevents = new List<GE_HQ_WorkorderTechUnAssignment.SMaxEventEmailBean>();
            GE_HQ_WorkorderTechUnAssignment.SMaxEventEmailBean e = new GE_HQ_WorkorderTechUnAssignment.SMaxEventEmailBean(event,'tech@mail.com');
            smaxevents.add(e);
            GE_HQ_WorkorderTechUnAssignment.sendMCSUnassignedEmail(smaxevents);
            GE_HQ_WorkorderTechUnAssignment.sendCancellationEmail(smaxevents);
            
            delete event;
            Test.stopTest();
    }
    }  
    
    @isTest
    public static void test1(){
         Profile p = [SELECT Id FROM Profile WHERE Name='GE_OG_DTS_Service Admin']; 
        Profile q = [SELECT Id FROM PROFILE WHERE NAME='OG_Sales/Comm Ops'];
        Profile s = [SELECT Id FROM PROFILE WHERE NAME='System Administrator'];
        UserRole r = [SELECT Id from UserRole Where Name ='SMax - DTS Admin'];
       // UserRole m = [Select id from UserRole where Name ='SMax Global Admin'];
        
        User manager = new User(Alias = 'dmanag', Email='manager@dts.com',CommunityNickname='DTSMan',UserRoleId=r.Id,
                             EmailEncodingKey='UTF-8', LastName='DTSmanager', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = q.Id, 
                             TimeZoneSidKey='America/Los_Angeles', UserName='manager@dts.com'); 
         insert manager;
        
        User home = new User(Alias = 'dmana', Email='home@dts.com',CommunityNickname='DTS',UserRoleId=r.Id,
                             EmailEncodingKey='UTF-8', LastName='DTS', LanguageLocaleKey='en_US', 
                             LocaleSidKey='en_US', ProfileId = s.Id, 
                             TimeZoneSidKey='America/Los_Angeles', UserName='home@dts.com');
                             insert home;
        User nonhome = new User(Alias = 'pkond', Email='nonhome@dts.com',CommunityNickname='DTSNon',UserRoleId=r.Id,
                                EmailEncodingKey='UTF-8', LastName='DTSNon', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id,ManagerId = manager.id, 
                                TimeZoneSidKey='America/Los_Angeles', UserName='nonhome@dts.com');
        insert nonhome;
          
        
        System.runAs(nonhome) {
            // The following code runs as user 'u' 
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            
           //Account 
            Account acc = new Account();
            ID accrecid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            acc.RecordTypeId = accrecid;
            acc.name = 'testaccount';
            acc.Classification__c = 'Strategic';
            acc.OwnerId = '005A0000001ztawIAA';
            insert acc;  
        
           // Service team creation
            SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
            team.Name = 'Test Non Home DTS';
            team.SVMXC__Active__c = true;
            team.GE_HQ_P_L_Level__c = 'O&G>DTS';
            team.GE_HQ_Sub_P_L__c = 'F&PT';
            team.GE_HQ_Region__c = 'India';
            team.GE_HQ_Resource_Director__c = home.id; 
            insert team;
            
            // tecnician creation
            SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();          
            tech.GE_SM_HQ_SSO_ID__c = '502726604';
             Id techrecid = Schema.SObjectType.SVMXC__Service_Group_Members__c .getRecordTypeInfosByName().get('GE OG DTS Technician').getRecordTypeId();
             tech.recordtypeid = techrecid;
            tech.SVMXC__Service_Group__c = team.Id;
            tech.SVMXC__Enable_Scheduling__c = true;
            tech.GE_SM_HQ_Controls_EmpType__c = 'FSE';
            insert tech;
            system.debug('tech'+tech.Id);
            
            //Dispatcher Access
            SVMXC__Dispatcher_Access__c access = new SVMXC__Dispatcher_Access__c();
            access.SVMXC__Dispatcher__c = nonhome.id;
            access.GE_HQ_Not_Home_Territory__c = true;
            access.SVMXC__Service_Team__c = team.Id;
            insert access;
                                 
           
           Test.startTest();
             SVMXC__Service_Order__c wo1 = new SVMXC__Service_Order__c();
            wo1.SVMXC__Company__c = acc.id;
                  
            wo1.GE_OG_MC_Business_Unit__c = 'F&PT';
            wo1.GE_OG_MC_Service_Region__c = 'Coimbatore';
            wo1.GE_SS_Customer_PO_number__c = '123123';
            wo1.GE_OG_Service_Order__c = '223312';
            wo1.GE_OG_GS_Customer_Want_Start_Date__c = System.today();
            wo1.GE_OG_GS_Customer_Want_End_Date__c = system.today();
            wo1.GE_OG_GS_Work_Scope_Notes__c = 'test';
            wo1.GE_SM_HQ_Technician_Home_Dispatcher__c = home.Id;
            wo1.SVMXC__Service_Group__c = team.Id;
            insert wo1;                      
            
           
           try{ 
            wo1.GE_PC_Driving_Directions__c = ''+tech.id+';'+team.id+';false;'+'06/09/2017 8:30 AM;06/09/2017 9:30 AM,';
         
            wo1.GE_SM_HQ_Borrowed_Technician_Approved_On__c = system.today();
            
            update wo1;
            }
            catch(exception e){
            system.debug('error'+e);
            }
             
            
            try{
            GE_DTS_Non_Home_Territory dts = new GE_DTS_Non_Home_Territory();
            dts.sendEmail(wo1.id,wo1.GE_SM_HQ_Technician_Home_Dispatcher__c);
            }
            catch(Exception e){
            system.debug('error'+e);
            }
            Test.stopTest();
          
        }
    
    }
    
               
}