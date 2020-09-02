/**
* 
* Class/Trigger Name--: GE_OG_MCS_WOupdateEvent
* Used Where ?--------: When WorkOrder is Assigned or Updated for Subject field on WO
* Purpose/Overview----: To populate the Subject field value of WorkOrder in the related ServiceMax Event for 'subject' field
* Functional Area-----: M&C ServiceMax
* Author--------------: Laxmi V
* Created Date--------: 
* Test Class Name-----: GE_OG_MCS_WOupdateEvent_Test

* Change History -

* Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

**/


@istest(SeeAllData=true)
public class GE_OG_MCS_WOupdateEvent_Test{
    
    /*public static testmethod void GE_OG_MCS_WOupdateEvent_Test_Method(){
    
        List<SVMXC__Service_Order__c> oldWorkOrder=new List<SVMXC__Service_Order__c>();
        List<SVMXC__Service_Order__c> newWorkOrder=new List<SVMXC__Service_Order__c>();
        ID Rtid=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId(); 
        SVMXC__Skill__c skill=new SVMXC__Skill__c();
        skill.name='test';
        insert skill;
        System.assertEquals(skill.name,'test');
        SVMXC__Service_Order__c wo=new SVMXC__Service_Order__c();
        wo.SVMXC__Skill__c=skill.id;
        wo.RecordTypeId=Rtid;
        wo.GE_OG_MC_Subject__c='Test';
        wo.GE_OG_MC_Business_Unit__c='BN';
        wo.GE_OG_MC_Service_Region__c='ANZ';
        
        Test.StartTest();
        
        insert wo;
        oldWorkOrder.add(wo);
        User us=[Select id,email from User where isActive=True and email!=null limit 1];
        SVMXC__Service_Group__c st=new SVMXC__Service_Group__c(SVMXC__Email__c='Somanath.das@ge.com',GE_OG_Director_Email__c='Somanath.das@ge.com',GE_HQ_Resource_Director__c=us.id);insert st;
        SVMXC__Service_Group_Members__c tech=new SVMXC__Service_Group_Members__c(Name='Test',GE_SM_HQ_SSO_ID__c='21jhe32i8',SVMXC__Service_Group__c=st.id);insert tech;
        
        wo.GE_OG_MC_Subject__c='Test11';
        wo.RecordTypeId=rtId;
        wo.SVMXC__Skill__c=skill.id;
        wo.SVMXC__Service_Group__c=st.id;
        wo.SVMXC__Group_Member__c=tech.id;
        
        wo.GE_OG_MC_Business_Unit__c='BN';
        wo.GE_OG_MC_Service_Region__c='ANZ';
        update wo;
        newWorkOrder.add(wo);
       
       list<SVMXC__SVMX_Event__c> eventli=new list<SVMXC__SVMX_Event__c>();
      eventli=[SELECT  Name,Work_Order__c,SVMXC__StartDateTime__c, SVMXC__EndDateTime__c, SVMXC__WhatId__c, SVMXC__Technician__c FROM SVMXC__SVMX_Event__c limit 1];
        eventli[0].SVMXC__WhatId__c=wo.id;
     
       
       SVMXC__SVMX_Event__c eventlists=new SVMXC__SVMX_Event__c();
       eventlists.Name='sampletest1';
       eventlists.SVMXC__WhatId__c=wo.id;
      // eventlists.SVMXC__Service_Order__c=wo.id;
      // eventlists.SVMXC__Technician__c=eventli[0].SVMXC__Technician__c;
       
       insert eventlists;
      
       
       system.debug('$$$$$$$$$$$$ let me see here $$$$$$$$$$ '+eventlists);
       
        GE_OG_MCS_WOupdateEvent Woupdate=new GE_OG_MCS_WOupdateEvent();
        Woupdate.afterupdatewoevent(oldWorkOrder,newWorkOrder);
        
        SVMXC__Dispatcher_Access__c da = new SVMXC__Dispatcher_Access__c(
        SVMXC__Dispatcher__c = userinfo.getuserid(),
        GE_HQ_Not_Home_Territory__c = true,
        SVMXC__Service_Team__c = st.id);
        insert da;
        
        wo.GE_SM_HQ_Dispatched_Outside_Territory__c = true;
        wo.SVMXC__Group_Member__c = tech.id;
        update wo;
        
        SVMXC__SVMX_Event__c eve = new SVMXC__SVMX_Event__c (
        SVMXC__WhatId__c = wo.id,
        SVMXC__Technician__c = tech.id,
        SVMXC__EndDateTime__c = System.now(),
        SVMXC__StartDateTime__c = System.now()
        );
        insert eve;
      
          Test.StopTest(); 
    }
    */
}