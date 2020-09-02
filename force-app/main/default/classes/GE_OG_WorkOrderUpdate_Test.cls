@isTest(SeeAllData=True)
public class GE_OG_WorkOrderUpdate_Test {
    static testmethod void test1()
    {
        Test.StartTest();        
        Set<id> woIdset = new Set<id>();
        
        //List<EmailTemplate> etList= new List<EmailTemplate>([select id from EmailTemplate where name='GE_OG_MC_WorkOrderTechAssignedForMCS']);
        EmailTemplate et = new EmailTemplate(Name='GE_OG_MC_WorkOrderTechAssignedForMCS',Subject='hi',Body='Body content of Email');       
        
        
        //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='PC Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        team.GE_HQ_Resource_Director__c=UserInfo.getUserId();
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
        
        //WorkOrder Insert
        SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
        woObj.RecordTypeId=wortid;
        woObj.SVMXC__Order_Status__c = 'Open';
        woObj.SVMXC__Group_Member__c = tech.id;
        woObj.SVMXC__Service_Group__c = team.id;
        woObj.GE_PC_Branch__c = 'Test Team';
        woObj.SVMXC__Order_Type__c = 'Completion';
        woObj.GE_PC_Job_Type__c = 'MTH';        
        insert woObj;
        
        //ServiceMax Event Insert
             
        List<SVMXC__SVMX_Event__c> eventList = new List<SVMXC__SVMX_Event__c>();
        SVMXC__SVMX_Event__c smax_event = new SVMXC__SVMX_Event__c();       
        smax_event.SVMXC__Technician__c  = tech.id;
        smax_event.SVMXC__WhatId__c = woObj.id;
        smax_event.SVMXC__EndDateTime__c = System.now().addMinutes(30);
        smax_event.SVMXC__StartDateTime__c = System.now();
        insert smax_event;
        eventList.add(smax_event);
        
        //Skill Insert
        SVMXC__Skill__c sk = new SVMXC__Skill__c();
        sk.Name='Testing';
        sk.GE_OG_Job_Type__c='B-02';
        insert sk;
        
        //String mailadd = 'test@ge.com';
        //String  []mailaddress = new String[]{mailadd};
        
        Id Userid = UserInfo.getUserId(); 
        //ID templateId;
       // for (EmailTemplate etid:etList)
             //templateId= etid.id;

        ID WOId = woObj.id;
        
        //Updating WorkOrder
        woIdset.add(woObj.id);
        woObj.GE_PC_Safety_Answer__c = '1-Poor Performance (Job problems/failures)'; 
        woObj.GE_PC_Quality_Answer__c = '1-Poor Performance (Job problems/failures)';
        woObj.GE_PC_Deliver_Answer__c = '1-Poor Performance (Job problems/failures)';
        woObj.SVMXC__Order_Type__c = 'Completion';
        woObj.GE_PC_Job_Type__c = 'B-02';
        update woObj;                        
        woIdset.add(woObj.id);
        test.stopTest();
    }
}