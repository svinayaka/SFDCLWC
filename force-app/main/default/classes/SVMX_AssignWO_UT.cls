@isTest(SeeAllData=true)
private class SVMX_AssignWO_UT {
    static testMethod void Test1()
    {
        Id Userid = UserInfo.getUserId();
        //String userEmail = UserInfo.getUserEmail();
         Id CMFAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
         Id AccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        //Create Account
        Account ac = new Account(
        Name ='Account',
        ShippingStreet='ABC',
        ShippingCity='PQR ',
        ShippingState = 'XYZ',
        ShippingPostalCode='111',
        ShippingCountry='XYZ',
        Classification__c='Key Account',
        Type='Direct Customer',
        RecordTypeId = AccrecType
        ); 
        insert ac; 

        //Create Contact
        Contact ct = new Contact(
        FirstName='First',
        LastName='Last',
        AccountId =ac.Id,
        MobilePhone= '12345',
        GE_OG_Contact_Audience__c = 'Technical Support',
        Email = 'test12345@ge.com'
        
        ); 
        insert ct;
        
        //String CMFAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        //Contact ct = [Select Id, Name, AccountId from Contact where Account.RecordTypeId =: CMFAccrecType limit 1];
         Account ac1 = [Select Id, Name from Account where RecordTypeId =: CMFAccrecType limit 1];

        //Create Case 
        /*Case cs = new Case(
        Status ='New', 
        Priority = 'Medium', 
        Origin = 'Email', 
        ContactId =ct.Id,
        AccountId=ac.Id
        ); 
        insert cs;*/

        Product2 prod = new Product2(
        Name = 'Test Prod',
        IsActive = true
        );
        insert prod;

        //Service Team Record Type Id
        Id strtId = Schema.SObjectType.SVMXC__Service_Group__c.getRecordTypeInfosByName().get('Technician').getRecordTypeId();

        //Create Service Team
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c(
        RecordTypeId = strtId,
        Name = 'SVMX STName',
        GE_HQ_Resource_Director__c = Userid,
        SVMXC__Active__c = true,
        GE_HQ_P_L_Level__c = 'O&G > D&S',
        GE_HQ_Sub_P_L__c = 'Drilling',
        GE_HQ_Region__c = 'NAM',
        GE_OG_DS_Billing_Admin_Email__c = 'test.abc@xyz.com' 
        );
        insert sg;

        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = sg.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '1234567',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer' 
        );
        insert tech;

        SVMXC__Skill__c skill = new SVMXC__Skill__c(
        Name = 'SVMX Skill',
        SVMXC__Active__c = true,
        SVMXC__Skill_Area__c = 'Field Service',
        GE_PW_PGS_Country__c = 'Brazil',
        GE_PW_PGS_Needs_Visa__c = true,
        GE_PW_PGS_Days_to_Get_Visa__c = 60,
        GE_OG_DS_In_Country_Duration__c = 30
        );
        insert skill;

        SVMXC__Skill__c skill2 = new SVMXC__Skill__c(
        Name = 'SVMX Skill2',
        SVMXC__Active__c = true,
        SVMXC__Skill_Area__c = 'Field Service',
        GE_PW_PGS_Country__c = 'US',
        GE_PW_PGS_Needs_Visa__c = true,
        GE_PW_PGS_Days_to_Get_Visa__c = 60,
        GE_OG_DS_In_Country_Duration__c = 30
        );
        insert skill2;

        SVMXC__Service_Group_Skills__c techexperts = new SVMXC__Service_Group_Skills__c();
        techexperts.SVMXC__Service_Group__c = sg.Id;
        techexperts.SVMXC__Group_Member__c = tech.Id;
        techexperts.SVMXC__Skill__c = skill.Id;
        techexperts.Competency_Level__c = 'Level 1';
        techexperts.GE_OG_GS_Root_Qualification_Level__c='SFSE';
        
        insert techexperts;



        //Retriving Work Order 'D&S' Record Type
        Id rtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();

        //Create Work Order
        SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c (
        //SVMXC__Case__c = cs.Id ,
        SVMXC__Company__c = ac1.Id , 
        SVMXC__Contact__c = ct.Id,
        SVMXC__Group_Member__c=tech.Id,
        SVMXC__Order_Status__c = 'Awaiting Dispatch Approval',
        SVMXC__Priority__c ='Medium',
        SVMXC__Order_Type__c='Field Service',
        GE_SM_HQ_Dispatched_Outside_Territory__c=True,
        SVMXC__Skill__c=skill.Id,
        GE_OG_MC_Service_Region__c = 'China',
            GE_OG_MC_Business_Unit__c='BN',
        RecordTypeId = rtId,
        SVMXC__Service_Group__c = sg.Id,
        GE_SM_HQ_Scheduled_Start_Date_Time__c = System.now(),
        GE_SM_HQ_Borrowed_Technician_Approved_On__c=null,
        GE_SM_HQ_Scheduled_End_Date_Time__c = System.now()
        );
        insert svo;

        svo.SVMXC__Group_Member__c = tech.id;
        update svo;
        
        SVMXC__Service_Order__c svo1 = new SVMXC__Service_Order__c (
        //SVMXC__Case__c = cs.Id ,
        SVMXC__Company__c = ac1.Id , 
        SVMXC__Contact__c = ct.Id,
        SVMXC__Order_Status__c = 'Awaiting Dispatch Approval',
        SVMXC__Priority__c ='Medium',
        SVMXC__Order_Type__c='Field Service',
        RecordTypeId = rtId,
        SVMXC__Skill__c=skill.Id,
         GE_OG_MC_Service_Region__c = 'China',
            GE_OG_MC_Business_Unit__c='BN',
        SVMXC__Service_Group__c = sg.Id,
        SVMXC__Group_Member__c=tech.Id,
        GE_SM_HQ_Scheduled_Start_Date_Time__c = System.now(),
        GE_SM_HQ_Scheduled_End_Date_Time__c = System.now()
        );
        insert svo1;
        
        SVMXC__Dispatcher_Access__c da = new SVMXC__Dispatcher_Access__c(
        SVMXC__Dispatcher__c = userinfo.getuserid(),
        GE_HQ_Not_Home_Territory__c = true,
        SVMXC__Service_Team__c = sg.id);
        insert da;
        
        svo.GE_SM_HQ_Dispatched_Outside_Territory__c = true;
        svo.SVMXC__Group_Member__c = tech.id;
        update svo1;
        
        SVMXC__SVMX_Event__c eve = new SVMXC__SVMX_Event__c (
        SVMXC__WhatId__c = svo.id,
        SVMXC__Technician__c = tech.id,
        SVMXC__EndDateTime__c = System.now()+1,
        SVMXC__StartDateTime__c = System.now()
        );
        insert eve;
        EmailTemplate emailtempid=[Select id from EmailTemplate limit 1];
        
        Contact u=[Select id,email from Contact where email!=null limit 1];
       // SVMX_Utility svs = new SVMX_Utility();
        SVMX_Utility.sendEmail(svo.id,emailtempid.id,u.id,'Hello@Hello.com' );
        SVMX_Utility.sendApprovalEmail(svo.id);
        /*Approval.ProcessSubmitRequest req1 = 
            new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(svo.id);
           Approval.ProcessResult result = Approval.process(req1);*/


    }
    
}