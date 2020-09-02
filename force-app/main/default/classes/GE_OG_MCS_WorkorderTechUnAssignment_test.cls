@istest 
public class GE_OG_MCS_WorkorderTechUnAssignment_test
{
 Static TestMethod void WorkorderTechUnAssignment(){
 //List<SVMXC__SVMX_Event__c>  eventSvmx= new List<SVMXC__SVMX_Event__c >();
  ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
  SVMXC__Service_Group__c servicegroup = new SVMXC__Service_Group__c(
        Name = 'SVMX STName'      
        );
        insert servicegroup;
 SVMXC__Skill__c skill=new SVMXC__Skill__c();
               skill.Name='Test';
               
               
               insert skill;
               System.assertEquals(skill.Name,'Test');
 SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = servicegroup.Id,
        Name = 'SVMX Tech',
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '51234567',
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
         
        insert tech;
        
 SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
               wo.GE_SM_HQ_Scheduled_Start_Date_Time__c=system.TODAY();
               wo.GE_SM_HQ_Scheduled_End_Date_Time__c =system.TODAY()+1;
               wo.GE_OG_MC_Service_Region__c='Europe';
               wo.GE_OG_MC_Business_Unit__c='CS';
               wo.RecordTypeId=Rectype;
               wo.SVMXC__Skill__c= skill.id;
               wo.SVMXC__Group_Member__c = Tech.id;
               wo.SVMXC__Service_Group__c = servicegroup.id;
               
               insert wo;
                DateTime t = DateTime.newInstance(2017,5,18,12,30,6);
 SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
           evtOb.Name = wo.Name;
            evtOb.SVMXC__StartDateTime__c = t;
            evtOb.SVMXC__EndDateTime__c = t.addHours(3);
            evtOb.SVMXC__IsAllDayEvent__c = false;
            evtOb.SVMXC__Location__c = '';
          //  evtOb.SVMXC__WhatId__c = wo1.Id;
            evtOb.SVMXC__ActivityDate__c  = Date.today();
            evtOb.SVMXC__ActivityDateTime__c  = t;
            evtOb.SVMXC__DurationInMinutes__c  = 180;  
        insert evtOb;
  SVMXC__SVMX_Event__c evtOb1 = new SVMXC__SVMX_Event__c();
        evtOb1.SVMXC__Service_Order__c = wo.id;
        evtOb1.SVMXC__Technician__c=tech.id;
        evtOb1.SVMXC__WhatId__c= wo.id;
        evtOb1.Name = wo.Name;
            evtOb1.SVMXC__StartDateTime__c = t;
            evtOb1.SVMXC__EndDateTime__c = t.addHours(3);
            evtOb1.SVMXC__IsAllDayEvent__c = false;
            evtOb1.SVMXC__Location__c = '';
          //  evtOb.SVMXC__WhatId__c = wo1.Id;
            evtOb1.SVMXC__ActivityDate__c  = Date.today();
            evtOb1.SVMXC__ActivityDateTime__c  = t;
            evtOb1.SVMXC__DurationInMinutes__c  = 180;
         test.starttest();
        insert evtOb1;
        System.assertEquals(wo.id, evtOb1.SVMXC__WhatId__c);
        
       
       delete evtOb1; 
       test.stoptest();
    
 }
 Static TestMethod void WorkorderTechUnAssignmentForAL(){
 //List<SVMXC__SVMX_Event__c>  eventSvmx= new List<SVMXC__SVMX_Event__c >();
  ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
  SVMXC__Service_Group__c servicegroup = new SVMXC__Service_Group__c(
        Name = 'SVMX STName'      
        );
        insert servicegroup;
 SVMXC__Skill__c skill=new SVMXC__Skill__c();
               skill.Name='Test';
               
               
               insert skill;
               System.assertEquals(skill.Name,'Test');
 SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = servicegroup.Id,
        Name = 'SVMX Tech',
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '503073208',
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
         
        insert tech;
        
 SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
               wo.GE_SM_HQ_Scheduled_Start_Date_Time__c=system.TODAY();
               wo.GE_SM_HQ_Scheduled_End_Date_Time__c =system.TODAY()+1;
               wo.GE_OG_MC_Service_Region__c='Europe';
               wo.GE_OG_MC_Business_Unit__c='CS';
               wo.RecordTypeId=Rectype;
               wo.SVMXC__Skill__c= skill.id;
               wo.SVMXC__Group_Member__c = Tech.id;
               wo.SVMXC__Service_Group__c = servicegroup.id;
               
               insert wo;
                DateTime t = DateTime.newInstance(2017,5,18,12,30,6);
 SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
           evtOb.Name = wo.Name;
            evtOb.SVMXC__StartDateTime__c = t;
            evtOb.SVMXC__EndDateTime__c = t.addHours(3);
            evtOb.SVMXC__IsAllDayEvent__c = false;
            evtOb.SVMXC__Location__c = '';
          //  evtOb.SVMXC__WhatId__c = wo1.Id;
            evtOb.SVMXC__ActivityDate__c  = Date.today();
            evtOb.SVMXC__ActivityDateTime__c  = t;
            evtOb.SVMXC__DurationInMinutes__c  = 180;  
        insert evtOb;
  SVMXC__SVMX_Event__c evtOb1 = new SVMXC__SVMX_Event__c();
        evtOb1.SVMXC__Service_Order__c = wo.id;
        evtOb1.SVMXC__Technician__c=tech.id;
        evtOb1.SVMXC__WhatId__c= wo.id;
        evtOb1.Name = wo.Name;
            evtOb1.SVMXC__StartDateTime__c = t;
            evtOb1.SVMXC__EndDateTime__c = t.addHours(3);
            evtOb1.SVMXC__IsAllDayEvent__c = false;
            evtOb1.SVMXC__Location__c = '';
          //  evtOb.SVMXC__WhatId__c = wo1.Id;
            evtOb1.SVMXC__ActivityDate__c  = Date.today();
            evtOb1.SVMXC__ActivityDateTime__c  = t;
            evtOb1.SVMXC__DurationInMinutes__c  = 180;
         test.starttest();
        insert evtOb1;
        System.assertEquals(wo.id, evtOb1.SVMXC__WhatId__c);
        
       
       delete evtOb1; 
       test.stoptest();
    
 }
 
 static TestMethod void unassignedEmail(){
     
     List<SVMXC__SVMX_Event__c>  eventSvmxlist = new List<SVMXC__SVMX_Event__c >();
   
    //OFS Commented
        //Id workRecId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('BHGE_OFS').getRecordTypeId();
    //OFS Added 
         
     ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
  SVMXC__Service_Group__c servicegroup = new SVMXC__Service_Group__c(
        Name = 'SVMX STName'      
        );
        insert servicegroup;
 SVMXC__Skill__c skill=new SVMXC__Skill__c();
               skill.Name='Test';
               
               
               insert skill;
               System.assertEquals(skill.Name,'Test');
 SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = servicegroup.Id,
        Name = 'SVMX Tech',
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '51234567',
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
         
        insert tech;
        
 SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
               wo.GE_SM_HQ_Scheduled_Start_Date_Time__c=system.TODAY();
               wo.GE_SM_HQ_Scheduled_End_Date_Time__c =system.TODAY()+1;
               wo.GE_OG_MC_Service_Region__c='Europe';
               wo.GE_OG_MC_Business_Unit__c='CS';
               wo.RecordTypeId=Rectype;
               wo.SVMXC__Skill__c= skill.id;
               wo.SVMXC__Group_Member__c = Tech.id;
               wo.SVMXC__Service_Group__c = servicegroup.id;
               
               insert wo;
                DateTime t = DateTime.newInstance(2017,5,18,12,30,6);
      SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
           evtOb.Name = wo.Name;
            evtOb.SVMXC__StartDateTime__c = t;
            evtOb.SVMXC__EndDateTime__c = t.addHours(3);
            evtOb.SVMXC__IsAllDayEvent__c = false;
            evtOb.SVMXC__Location__c = '';
          //  evtOb.SVMXC__WhatId__c = wo1.Id;
            evtOb.SVMXC__ActivityDate__c  = Date.today();
            evtOb.SVMXC__ActivityDateTime__c  = t;
            evtOb.SVMXC__DurationInMinutes__c  = 180;  
        insert evtOb;
        eventSvmxlist.add(evtOb);
     SVMXC__SVMX_Event__c evtOb1 = new SVMXC__SVMX_Event__c();
        evtOb1.SVMXC__Service_Order__c = wo.id;
        evtOb1.SVMXC__Technician__c=tech.id;
        evtOb1.SVMXC__WhatId__c= wo.id;
        evtOb1.Name = wo.Name;
            evtOb1.SVMXC__StartDateTime__c = t;
            evtOb1.SVMXC__EndDateTime__c = t.addHours(3);
            evtOb1.SVMXC__IsAllDayEvent__c = false;
            evtOb1.SVMXC__Location__c = '';
          //  evtOb.SVMXC__WhatId__c = wo1.Id;
            evtOb1.SVMXC__ActivityDate__c  = Date.today();
            evtOb1.SVMXC__ActivityDateTime__c  = t;
            evtOb1.SVMXC__DurationInMinutes__c  = 180;
            
         test.starttest();
        insert evtOb1;
        map<id,SVMXC__Service_Order__c>womap = new map<id,SVMXC__Service_Order__c>();
        womap.put(wo.id, wo);
        map<id,SVMXC__Service_Group_Members__c>techmap = new map<id,SVMXC__Service_Group_Members__c>();
        techmap.put(tech.id,tech);
        eventSvmxlist.add(evtOb1);
        
        //OFS Commented
        //GE_HQ_WorkorderTechUnAssignment.sendOFSUnassignEmail(eventSvmxlist,womap,techmap);        
     
     
 }
   
 
 Static TestMethod void sendCancellationEmail_Test(){
 //List<SVMXC__SVMX_Event__c>  eventSvmx= new List<SVMXC__SVMX_Event__c >();
  ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('GE OG DTS').getRecordTypeId();
  SVMXC__Service_Group__c servicegroup = new SVMXC__Service_Group__c(
        Name = 'SVMX STName'      
        );
        insert servicegroup;
 SVMXC__Skill__c skill=new SVMXC__Skill__c();
               skill.Name='Test';
               
               
               insert skill;
               System.assertEquals(skill.Name,'Test');
 SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = servicegroup.Id,
        Name = 'SVMX Tech',
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '51234567',
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
         
        insert tech;
        ID acctype=Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        
        Account acc = new account();
        acc.Name='Test';
        acc.Classification__c='Gold';
        acc.Type='Direct Customer';
        acc.RecordTypeId=acctype;
        insert acc;
        
 SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
               wo.GE_SM_HQ_Scheduled_Start_Date_Time__c=system.TODAY();
               wo.GE_SM_HQ_Scheduled_End_Date_Time__c =system.TODAY()+1;
               wo.GE_OG_MC_Service_Region__c='Europe';
               wo.GE_OG_MC_Business_Unit__c='CS';
               wo.RecordTypeId=Rectype;
               wo.SVMXC__Skill__c= skill.id;
               wo.SVMXC__Group_Member__c = Tech.id;
               wo.SVMXC__Service_Group__c = servicegroup.id;
               wo.GE_OG_Service_Order__c='123456';
               wo.GE_SS_Customer_PO_number__c='123456';
               wo.GE_OG_GS_Customer_Want_Start_Date__c=system.TODAY();
               wo.GE_OG_GS_Customer_Want_End_Date__c=system.TODAY()+1;
               wo.GE_OG_GS_Work_Scope_Notes__c='work scope notes';
               wo.SVMXC__Order_Type__c='Field Service';   
               wo.SVMXC__Company__c = acc.ID;   
               insert wo;
               
               DateTime t = DateTime.newInstance(2017,5,18,12,30,6);
               
 SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
           
            //evtOb.SVMXC__Service_Team__c =team.Id;
           // evtOb.SVMXC__Technician__c = tech.Id;
           // evtOb.SVMXC__Service_Order__c = wo1.Id;
            evtOb.Name = wo.Name;
            evtOb.SVMXC__StartDateTime__c = t;
            evtOb.SVMXC__EndDateTime__c = t.addHours(3);
            evtOb.SVMXC__IsAllDayEvent__c = false;
            evtOb.SVMXC__Location__c = '';
          //  evtOb.SVMXC__WhatId__c = wo1.Id;
            evtOb.SVMXC__ActivityDate__c  = Date.today();
            evtOb.SVMXC__ActivityDateTime__c  = t;
            evtOb.SVMXC__DurationInMinutes__c  = 180;            
           
               
        insert evtOb;
        
        SVMXC__SVMX_Event__c evtOb1 = new SVMXC__SVMX_Event__c();        
        evtOb1.SVMXC__Service_Order__c = wo.id;
        evtOb1.SVMXC__Technician__c=tech.id;
        evtOb1.SVMXC__WhatId__c= wo.id;
         evtOb1.Name = wo.Name;
            evtOb1.SVMXC__StartDateTime__c = t;
            evtOb1.SVMXC__EndDateTime__c = t.addHours(3);
            evtOb1.SVMXC__IsAllDayEvent__c = false;
            evtOb1.SVMXC__Location__c = '';
          //  evtOb.SVMXC__WhatId__c = wo1.Id;
            evtOb1.SVMXC__ActivityDate__c  = Date.today();
            evtOb1.SVMXC__ActivityDateTime__c  = t;
            evtOb1.SVMXC__DurationInMinutes__c  = 180;
         
         test.starttest();
         
        insert evtOb1;
        System.assertEquals(wo.id, evtOb1.SVMXC__WhatId__c);
        
       
       delete evtOb1; 
       test.stoptest();
    
 } 
 
 }