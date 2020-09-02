@isTest(seealldata = true)
public class GE_OG_PC_WOupdateExpertise_Test 
{
    static testmethod void test1()
    {
        Test.StartTest();        
        Set<id> woIdset = new Set<id>();
        
        
        //JobType Skill Insert
        SVMXC__Skill__c jobTypeSkill= new SVMXC__Skill__c();
        jobTypeSkill.name = 'Test JobType';
        jobTypeSkill.GE_OG_PC_Complexity__c='High';
        jobTypeSkill.SVMXC__Skill_Category__c = 'PC Skills';
        jobTypeSkill.GE_OG_Job_Type__c = 'W2';
        insert jobTypeSkill;
        
        
        //Skill Insert
        SVMXC__Skill__c skill = new SVMXC__Skill__c();
        skill.name = 'Test JobType';
        skill.GE_OG_PC_Complexity__c='High';
        insert skill;
        
        //Skill1 Insert
        SVMXC__Skill__c skill1 = new SVMXC__Skill__c();
        skill1.name = 'Test JobType1';
        skill1.GE_OG_PC_Complexity__c='High';
        insert skill1;
        
        //Skill2 Insert
        SVMXC__Skill__c skill2 = new SVMXC__Skill__c();
        skill2.name = 'Test JobType2';
        skill2.GE_OG_PC_Complexity__c='Medium';
        insert skill2;
        
        //Skill3 Insert
        SVMXC__Skill__c skill3 = new SVMXC__Skill__c();
        skill3.name = 'Test JobType3';
        skill3.GE_OG_PC_Complexity__c='Low';
        insert skill3;
        
        //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;
        
        //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '123456737',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        
        //Expertise Insert
        SVMXC__Service_Group_Skills__c techexperts = new SVMXC__Service_Group_Skills__c(
        SVMXC__Service_Group__c = team.Id,
        SVMXC__Group_Member__c = tech.Id,
        SVMXC__Skill__c = skill.Id,
        Expertise_Level__c = 'Level 1',
        GE_OG_GS_Root_Qualification_Level__c='SFSE',
        GE_DS_Expertise_Status__c='Expired'
        );
        insert techexperts;
        
        SVMXC__Service_Group_Skills__c techexperts1 = new SVMXC__Service_Group_Skills__c(
        SVMXC__Service_Group__c = team.Id,
        SVMXC__Group_Member__c = tech.Id,
        SVMXC__Skill__c = skill3.Id,
        GE_PC_WorkOrders_Completed__c=0,
        Expertise_Level__c = 'Level 1',
        GE_OG_GS_Root_Qualification_Level__c='SFSE'
        );
        insert techexperts1;

        SVMXC__Service_Group_Skills__c techexperts11 = new SVMXC__Service_Group_Skills__c(
        SVMXC__Service_Group__c = team.Id,
        SVMXC__Group_Member__c = tech.Id,
        SVMXC__Skill__c = skill3.Id,
        GE_PC_WorkOrders_Completed__c=1,
        Expertise_Level__c = 'Level 1',
        GE_OG_GS_Root_Qualification_Level__c='SFSE'
        );
        insert techexperts11;

        SVMXC__Service_Group_Skills__c techexperts12 = new SVMXC__Service_Group_Skills__c(
        SVMXC__Service_Group__c = team.Id,
        SVMXC__Group_Member__c = tech.Id,
        SVMXC__Skill__c = skill3.Id,
        GE_PC_WorkOrders_Completed__c=2,
        Expertise_Level__c = 'Level 1',
        GE_OG_GS_Root_Qualification_Level__c='SFSE'
        );
        insert techexperts12;
                        
        SVMXC__Service_Group_Skills__c techexperts2 = new SVMXC__Service_Group_Skills__c(
        SVMXC__Service_Group__c = team.Id,
        SVMXC__Group_Member__c = tech.Id,
        SVMXC__Skill__c = skill2.Id,
        Expertise_Level__c = 'Level 1',
        GE_PC_WorkOrders_Completed__c=2,
        GE_OG_GS_Root_Qualification_Level__c='SFSE'
        );
        insert techexperts2;

        SVMXC__Service_Group_Skills__c techexperts21 = new SVMXC__Service_Group_Skills__c(
        SVMXC__Service_Group__c = team.Id,
        SVMXC__Group_Member__c = tech.Id,
        SVMXC__Skill__c = skill2.Id,
        GE_PC_WorkOrders_Completed__c=2,
        Expertise_Level__c = 'Level 1',
        GE_OG_GS_Root_Qualification_Level__c='SFSE'
        );
        insert techexperts21;

        SVMXC__Service_Group_Skills__c techexperts22 = new SVMXC__Service_Group_Skills__c(
        SVMXC__Service_Group__c = team.Id,
        SVMXC__Group_Member__c = tech.Id,
        SVMXC__Skill__c = skill2.Id,
        GE_PC_WorkOrders_Completed__c=5,
        Expertise_Level__c = 'Level 1',
        GE_OG_GS_Root_Qualification_Level__c='SFSE'
        );
        insert techexperts22;
                                             
        //WorkOrder Insert
        SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
        woObj.RecordTypeId=wortid;
        woObj.SVMXC__Order_Status__c = 'Open';
        woObj.Region__c = 'MENAT';  
        woObj.GE_SM_HQ_Scheduled_Start_Date_Time__c = datetime.now();
        woObj.GE_SM_HQ_Scheduled_End_Date_Time__c = datetime.now();       
        woObj.GE_PC_Job_Type__c='Test JobType';
        woObj.SVMXC__Group_Member__c = tech.id;
        woObj.SVMXC__Service_Group__c = team.id;
        woObj.SVMXC__Skill__c=skill.Id;
        woObj.GE_OG_MC_Skill1__c=skill1.Id;
        woObj.GE_OG_MC_Skill2__c=skill2.Id;
        woObj.GE_OG_PC_Skill3__c=skill3.Id;
        woObj.GE_PC_Job_Type__c ='W2';
        insert woObj;
                               
        //Event Insert
        List<Event> eveList = new List<Event>();
        Event eve = new Event (
        WhatId = woObj.id,
        OwnerId = UserInfo.getUserId(),
        EndDateTime = System.now().addMinutes(30),
        StartDateTime = System.now()
        );
        insert eve;
        
        List<SVMXC__SVMX_Event__c> evList = new List<SVMXC__SVMX_Event__c>();
        Map<Id, SVMXC__SVMX_Event__c> newObjectMap=new Map<Id, SVMXC__SVMX_Event__c>();
        SVMXC__SVMX_Event__c ev = new SVMXC__SVMX_Event__c (
        Name=woObj.Name,
        SVMXC__WhatId__c = woObj.id,
        SVMXC__Technician__c=tech.id,
        SVMXC__Service_Order__c= woObj.id,
        Work_Order__c= woObj.id,
        GE_OG_DS_Assignment_Type__c='Deployed',
        OwnerId = UserInfo.getUserId(),
        SVMXC__ActivityDateTime__c=System.now(),
        SVMXC__ActivityDate__c=Date.Today(),
        SVMXC__EndDateTime__c = System.now().addMinutes(30),
        SVMXC__StartDateTime__c = System.now()
        );  
        evList.add(ev);
        insert evList;      
        
                     
        //updating WorkOrder
        woIdset.add(woObj.id);
        woObj.GE_PC_Oracle_FSO__c = '1234';
        woObj.SVMXC__Order_Status__c = 'Closed';        
        update woObj;                        
        woIdset.add(woObj.id);
        
        //Updating Expertise
        techexperts.GE_PC_WorkOrders_Completed__c= 3;
        update techexperts;
        
        //Test Code for createExpertise method
                //Event Insert
        /*List<SVMXC__SVMX_Event__c> evList = new List<SVMXC__SVMX_Event__c>();
        Map<Id, SVMXC__SVMX_Event__c> newObjectMap=new Map<Id, SVMXC__SVMX_Event__c>();
        SVMXC__SVMX_Event__c ev = new SVMXC__SVMX_Event__c (
        Name=woObj.Name,
        SVMXC__WhatId__c = woObj.id,
        SVMXC__Technician__c=tech.id,
        SVMXC__Service_Order__c= woObj.id,
        Work_Order__c= woObj.id,
        GE_OG_DS_Assignment_Type__c='Deployed',
        OwnerId = UserInfo.getUserId(),
        SVMXC__ActivityDateTime__c=System.now(),
        SVMXC__ActivityDate__c=Date.Today(),
        SVMXC__EndDateTime__c = System.now().addMinutes(30),
        SVMXC__StartDateTime__c = System.now()
        );
        evList.add(ev);
        insert evList;
*/      
        newObjectMap.put(ev.id,ev);   
        GE_OG_SVMX_Event_TriggerHandler obj=new GE_OG_SVMX_Event_TriggerHandler();
        //obj.OnBeforeInsert(evList);
        obj.OnAfterInsert(evList);
        //obj.OnBeforeUpdate(evList,evList,newObjectMap);
        //obj.OnAfterUpdate(evList,evList,newObjectMap);
       // obj.OnBeforeDelete(evList,newObjectMap);
       // obj.OnAfterDelete(evList,newObjectMap);
       // obj.OnUndelete(evList);
        Map<ID,ID> mapTechVsWO=new Map<ID,ID>();
        mapTechVsWO.put(tech.id,woObj.id);
        List<SVMXC__Service_Order__c>lstWOs=new List<SVMXC__Service_Order__c>();
        lstWOs.add(woObj);
        GE_OG_PC_WOupdateExpertise.createExpertise(evList);
        
        test.stopTest();
    }
    
}