@istest(SeeAllData=true)
public class GE_OG_MCS_EventupdateWO_Test{     
    public static testmethod void GE_OG_MCS_EventupdateWO_Method(){
      
        GE_OG_GS_Fit_For_Job__c cs = GE_OG_GS_Fit_For_Job__c.getInstance('Record Types List');
        if(cs == NULL){
            cs = new GE_OG_GS_Fit_For_Job__c();
            cs.Name ='Record Types List';
            cs.GE_OG_GS_Record_Types_To_Apply__c = 'GS-Requirement';
            insert cs;
        }
        
        
        ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
  SVMXC__Service_Group__c servicegroup = new SVMXC__Service_Group__c(
        Name = 'SVMX STName'      
        );
        insert servicegroup;

            //   System.assertEquals(skill.Name,'Test');
 SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = servicegroup.Id,
        Name = 'SVMX Tech',
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '51234567',
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
         
        insert tech;
        
        
       // ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
        // improved code coverage as part of bug 0000022295
        //List<SVMXC__SVMX_Event__c> eventList=new List<SVMXC__SVMX_Event__c>();
        List<SVMXC__SVMX_Event__c> updateeventList=new List<SVMXC__SVMX_Event__c>();
        Set<Id> eventIds = new Set<Id>();
        set<ID>woid=new set<ID>();        
        Map<Id, SVMXC__SVMX_Event__c> newObjectMap=new Map<Id, SVMXC__SVMX_Event__c>();
        SVMXC__Skill__c skill=new SVMXC__Skill__c();
        skill.name='test';
        insert skill;
        SVMXC__Service_Order__c wo=new SVMXC__Service_Order__c();
        wo.SVMXC__Skill__c=skill.id;
        wo.RecordTypeId=Rectype;
        wo.GE_OG_MC_Subject__c='Test';
        woid.add(wo.id);
         Test.StartTest();
        insert wo;
        System.assertEquals(wo.GE_OG_MC_Subject__c,'Test');
        SVMXC__SVMX_Event__c event=new SVMXC__SVMX_Event__c();
        event.Name='test';
        event.SVMXC__WhatId__c=wo.id;
        event.SVMXC__Service_Order__c=wo.id;
         DateTime t = DateTime.newInstance(2017,5,18,12,30,6);
            System.debug('t'+t);            
            event.SVMXC__Technician__c = tech.Id;          
            event.Name = wo.Name;
            event.SVMXC__StartDateTime__c = t;
            event.SVMXC__EndDateTime__c = t.addHours(3);
            event.SVMXC__IsAllDayEvent__c = false;
            event.SVMXC__Location__c = '';            
            event.SVMXC__ActivityDate__c  = Date.today();
            event.SVMXC__ActivityDateTime__c  = t;
            event.SVMXC__DurationInMinutes__c  = 180;            
        upsert event;
        eventIds.add(event.Id);
        //eventList.add(event);
        SVMXC__SVMX_Event__c event2=new SVMXC__SVMX_Event__c();
        event2.Name='test2';
        
            System.debug('t'+t);            
            event2.SVMXC__Technician__c = tech.Id;          
            event2.Name = wo.Name;
            event2.SVMXC__StartDateTime__c = t;
            event2.SVMXC__EndDateTime__c = t.addHours(3);
            event2.SVMXC__IsAllDayEvent__c = false;
            event2.SVMXC__Location__c = '';            
            event2.SVMXC__ActivityDate__c  = Date.today();
            event2.SVMXC__ActivityDateTime__c  = t;
            event2.SVMXC__DurationInMinutes__c  = 180; 
        upsert event2;
        eventIds.add(event2.Id);
        //eventList.add(event2);
     /*   SVMXC__SVMX_Event__c event3=new SVMXC__SVMX_Event__c();
        event3.Name='test3';
        event3.SVMXC__WhatId__c=wo.id;
      
            System.debug('t'+t);            
            event3.SVMXC__Technician__c = tech.Id;          
            event3.Name = wo.Name;
            event3.SVMXC__StartDateTime__c = t;
            event3.SVMXC__EndDateTime__c = t.addHours(3);
            event3.SVMXC__IsAllDayEvent__c = false;
            event3.SVMXC__Location__c = '';            
            event3.SVMXC__ActivityDate__c  = Date.today();
            event3.SVMXC__ActivityDateTime__c  = t;
            event3.SVMXC__DurationInMinutes__c  = 180; 
        upsert event3; 
        eventIds.add(event3.Id); */
                
        // improved code coverage as part of bug 0000022295
        updateeventList = [select Id, Name, SVMXC__Description__c from SVMXC__SVMX_Event__c where Id in :eventIds];
        for(SVMXC__SVMX_Event__c ev : updateeventList){
            ev.SVMXC__Description__c='New Description Yay';
            if(ev.id == event2.Id)
                ev.Name='New Name of event';
        }
        Test.StopTest(); 
        update(updateeventList);
         
        // commented this out as part of bug 0000022295
        //eventList.add(event3);
        //newObjectMap.put(event.id,event);
        //newObjectMap.put(event2.id,event2);
        //newObjectMap.put(event3.id,event3);        
        //GE_OG_MCS_EventupdateWO eventupdate=new GE_OG_MCS_EventupdateWO();
        //eventupdate.afterupdatesvmxevent(eventList,eventList,newObjectMap);
        
      
    }
}