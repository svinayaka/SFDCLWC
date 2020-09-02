@isTest(SeeAllData=true)
private class SVMX_ValidateWODispatch_UT{
    public static testMethod void ValidateWODispatchTest()
    {

        Id Userid = UserInfo.getUserId();
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
                                    RecordTypeId = AccrecType,
                                    Classification__c='Key Account',
                                    Type='Direct Customer'
                                ); 
        insert ac;    
        
        //Create Contact
        Contact  ct = new Contact(
                                    FirstName='First',
                                    LastName='Last',
                                    AccountId =ac.Id,
                                    MobilePhone= '12345',
                                    GE_OG_Contact_Audience__c ='Technical Support',
                                    Email='test12345@ge.com'
                                ); 
        insert ct;
        
        //Contact ct = [Select Id, Name, AccountId from Contact where Account.RecordTypeId =: CMFAccrecType limit 1];
        Account ac1 = [Select Id, Name from Account where RecordTypeId=:CMFAccrecType limit 1];
        
        //Create Case 
        Id DSCase =  Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();
   
        Case cs = new Case(
                            Status ='New', 
                            Priority = 'Medium', 
                            Origin = 'Email',                                       
                            ContactId =ct.Id,
                            AccountId=ac.Id,
                            RecordTypeId= DSCase,
                            //GE_OG_DS_PO_Override__c = true
                            GE_PW_PO__c = '123'
                            ); 
        insert cs;
        
        Product2 prod = new Product2(
                            Name = 'Test Prod',
                            IsActive = true
                            );
        
        insert prod;
        
        //Service Team Record Type Id
        Id strtId = Schema.SObjectType.SVMXC__Service_Group__c.getRecordTypeInfosByName().get('Technician').getRecordTypeId();  
        
        //test.startTest();
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
        
        //Retriving Work Order 'D&S' Record Type
        Id rtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
        
        //Create Work Order
        test.starttest();
        SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c (
                                        SVMXC__Case__c = cs.Id ,
                                        SVMXC__Company__c = ac1.Id , 
                                        SVMXC__Contact__c = ct.Id,
                                        SVMXC__Order_Status__c = 'Open',
                                        SVMXC__Priority__c ='Medium',
                                        SVMXC__Order_Type__c='Field Service',
                                        RecordTypeId = rtId
                                        //SVMXC__Service_Group__c = sg.Id
                                        //SVMXC__Group_Member__c = tech.Id
                                        );
        insert svo;
        //test.stopTest();
        SVMXC__Skill__c sk = new SVMXC__Skill__c(
                                        Name = 'SVMX Test skill',
                                        SVMXC__Active__c = true,
                                        SVMXC__Skill_Area__c = 'Field Service',
                                        GE_PW_PGS_Country__c = 'Mexico',
                                        GE_PW_PGS_Needs_Visa__c = true,
                                        GE_PW_PGS_Days_to_Get_Visa__c = 15,
                                        GE_OG_DS_In_Country_Duration__c = 1
                                        );
        insert sk;
        
        SVMXC__Service_Group_Skills__c expertise = new SVMXC__Service_Group_Skills__c(
                                        SVMXC__Service_Group__c = sg.Id,
                                        SVMXC__Group_Member__c = tech.Id,
                                        SVMXC__Skill__c = sk.id,
                                        SVMXC__Skill_Level__c = 3,
                                        GE_OG_DS_FSCC_Skill_Name__c = sk.id,
                                        SVMXC__Availability_Start_Date__c = System.Today(),
                                        SVMXC__Availability_End_Date__c = System.Today(),
                                        GE_OG_GS_Root_Qualification_Level__c='SFSE'
                                        );
        insert expertise;
        
        SVMXC__Service_Group_Skills__c expertise2 = new SVMXC__Service_Group_Skills__c(
                                        SVMXC__Service_Group__c = sg.Id,
                                        SVMXC__Group_Member__c = tech.Id,
                                        SVMXC__Skill__c = sk.id,
                                        SVMXC__Skill_Level__c = 1,
                                        GE_OG_DS_FSCC_Skill_Name__c = sk.id,
                                        SVMXC__Availability_Start_Date__c = System.Today(),
                                        SVMXC__Availability_End_Date__c = System.Today(),
                                        GE_OG_GS_Root_Qualification_Level__c='SFSE'
                                        );
        insert expertise2;
        
        Work_Order_Skill__c woskill = new Work_Order_Skill__c(
                                        Work_Order__c = svo.id,
                                        Skills__c = sk.id
                                        );
        insert woskill;
        
        SVMXC__SVMX_Event__c ev = new SVMXC__SVMX_Event__c(
                                        Name = 'SVMX Test Event',
                                        SVMXC__Technician__c = tech.Id,
                                        SVMXC__StartDateTime__c =  System.Today(),
                                        SVMXC__EndDateTime__c = System.Today().addDays(2),
                                        SVMXC__WhatId__c = svo.Id,
                                        GE_OG_DS_Assignment_Type__c = 'Deployed'
                                        );
        insert ev;
            
        test.stoptest();
        
        Work_Order_Skill__c woskill2 = new Work_Order_Skill__c(
                                        Work_Order__c = svo.id,
                                        Skills__c = sk.id
                                        );
        insert woskill2;        
        
        delete woskill2;

        
        //Retriving Work Order 'D&S' Record Type
        Id wdrtId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Usage/Consumption').getRecordTypeId();
        
        SVMXC__Service_Order_Line__c wdline = new SVMXC__Service_Order_Line__c(
                                        SVMXC__Service_Order__c = svo.Id,
                                        RecordTypeId = wdrtId,
                                        SVMXC__Line_Type__c = 'Labor',
                                        SVMXC__Is_Billable__c = true,
                                        SVMXC__Group_Member__c = tech.Id
                                        );
        insert wdline;
        
        /*SVMXC__Service_Order_Line__c wdline2 = new SVMXC__Service_Order_Line__c(
                                        SVMXC__Service_Order__c = svo.Id,
                                        RecordTypeId = wdrtId,
                                        SVMXC__Line_Type__c = 'Labor',
                                        SVMXC__Is_Billable__c = false,
                                        SVMXC__Group_Member__c = tech.Id
                                        );
        insert wdline2;*/
         
    }
}