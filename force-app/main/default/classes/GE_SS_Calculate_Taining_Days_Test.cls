@isTest
public class GE_SS_Calculate_Taining_Days_Test{
 static testMethod void event_Vacation() 
    {
        Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        insert sg;
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId =rtWOId;
        wo.SVMXC__Group_Member__c = tech.id; 
        wo.SVMXC__Skill_Set__c = '[{"skillName":"8100 Casing Cutting","skillLevel":0,"skillId":"a3S12000004Y33rEAC","isSkillMandatory":false}]';
        insert wo;
        
        SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        DateTime t = system.now();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
        evtOb.SVMXC__StartDateTime__c = t;
        evtOb.SVMXC__EndDateTime__c = t.addDays(15);
        evtOb.SVMXC__ActivityDate__c  = Date.today();
        evtOb.SVMXC__ActivityDateTime__c  = t;  
        evtOb.GE_OG_SS_Event_Type__c='Vacation';     
        insert evtOb;
        evtOb.GE_OG_SS_Event_Type__c='Training';
        update evtOb;                                         
    }
    static testMethod void event_VacationaddDays() 
    {
        Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        insert sg;
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId =rtWOId;
        wo.SVMXC__Group_Member__c = tech.id; 
        wo.SVMXC__Skill_Set__c = '[{"skillName":"8100 Casing Cutting","skillLevel":0,"skillId":"a3S12000004Y33rEAC","isSkillMandatory":false}]';
        insert wo;
        
        SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        DateTime t = system.now();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
        evtOb.SVMXC__StartDateTime__c = t;
        evtOb.SVMXC__EndDateTime__c = t.addDays(370);
        evtOb.SVMXC__ActivityDate__c  = Date.today();
        evtOb.SVMXC__ActivityDateTime__c  = t;  
        evtOb.GE_OG_SS_Event_Type__c='Vacation';     
        insert evtOb;
        evtOb.GE_OG_SS_Event_Type__c='Training';
        update evtOb;                                         
    }
     static testMethod void event_Training() 
    {
        Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        insert sg;
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId =rtWOId;
        wo.SVMXC__Group_Member__c = tech.id; 
        wo.SVMXC__Skill_Set__c = '[{"skillName":"8100 Casing Cutting","skillLevel":0,"skillId":"a3S12000004Y33rEAC","isSkillMandatory":false}]';
        insert wo;
        
        SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        DateTime t = system.now();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
        evtOb.SVMXC__StartDateTime__c = t;
        evtOb.SVMXC__EndDateTime__c = t.addDays(15);
        //evtOb.SVMXC__EndDateTime__c = t.addDays(370);
        evtOb.SVMXC__ActivityDate__c  = Date.today();
        evtOb.SVMXC__ActivityDateTime__c  = t;  
        evtOb.GE_OG_SS_Event_Type__c='Training';  
        insert evtOb;
        evtOb.GE_OG_SS_Event_Type__c='Vacation';
        update evtOb;                                         
    }
    static testMethod void event_TrainingaddDays() 
    {
        Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        insert sg;
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId =rtWOId;
        wo.SVMXC__Group_Member__c = tech.id; 
        wo.SVMXC__Skill_Set__c = '[{"skillName":"8100 Casing Cutting","skillLevel":0,"skillId":"a3S12000004Y33rEAC","isSkillMandatory":false}]';
        insert wo;
        
        SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        DateTime t = system.now();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
        evtOb.SVMXC__StartDateTime__c = t;
        //evtOb.SVMXC__EndDateTime__c = t.addDays(15);
        evtOb.SVMXC__EndDateTime__c = t.addDays(370);
        evtOb.SVMXC__ActivityDate__c  = Date.today();
        evtOb.SVMXC__ActivityDateTime__c  = t;  
        evtOb.GE_OG_SS_Event_Type__c='Training';  
        insert evtOb;
        evtOb.GE_OG_SS_Event_Type__c='Vacation';
        update evtOb;                                         
    }
    static testMethod void event_Null() 
    {
        Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        insert sg;
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId =rtWOId;
        wo.SVMXC__Group_Member__c = tech.id; 
        wo.SVMXC__Skill_Set__c = '[{"skillName":"8100 Casing Cutting","skillLevel":0,"skillId":"a3S12000004Y33rEAC","isSkillMandatory":false}]';
        insert wo;
        
        SVMXC__SVMX_Event__c evtOb = new SVMXC__SVMX_Event__c();
        DateTime t = system.now();
        evtOb.SVMXC__Service_Order__c = wo.id;
        evtOb.SVMXC__Technician__c=tech.id;
        evtOb.SVMXC__WhatId__c= wo.id;
        evtOb.SVMXC__StartDateTime__c = t;
        evtOb.SVMXC__EndDateTime__c = t.addDays(15);
        evtOb.SVMXC__ActivityDate__c  = Date.today();
        evtOb.SVMXC__ActivityDateTime__c  = t;  
        evtOb.GE_OG_SS_Event_Type__c='';  
        insert evtOb;
        //evtOb.GE_OG_SS_Event_Type__c='Vacation';
        update evtOb;                                         
    }
}