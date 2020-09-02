/*
Test Class Name: SVMX_CheckWOstatusUpdate_UT
Used For : SVMX_UpdateWOSkill on Work_Order_Skill__c
Purpose/Overview : Test Class to calculate the code coverage for the trigger SVMX_UpdateWOSkill on Work_Order_Skill__c
Functional Area : D&S ServiceMax
Author: 
Created Date: 
Test Class Name : NA
*/


@isTest(SeeAllData=true)
private class SVMX_CheckWOstatusUpdate_UT{
    public static testMethod void WOStatusUpdateTest()
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
            Contact  ct = new Contact(
                                        FirstName='First',
                                        LastName='Last',
                                        AccountId =ac.Id,
                                        MobilePhone= '12345',
                                        GE_OG_Contact_Audience__c ='Technical Support',
                                        Email='test12@ge.com'
                                    ); 
            insert ct;
            
            //String CMFAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        //Contact ct = [Select Id, Name, AccountId from Contact where Account.RecordTypeId =: CMFAccrecType limit 1];
        Account ac1 = [Select Id, Name from Account where RecordTypeId =: CMFAccrecType limit 1];
            
            //Create Case    
            Case cs = new Case(
                                Status ='New', 
                                Priority = 'Medium', 
                                Origin = 'Email',                                       
                                ContactId =ct.Id,
                                AccountId=ac.Id,
                                GE_ES_Sub_Type__c = 'RFQ processing',
  GE_ES_Customer_Request_Date__c = Date.Today().adddays(20)
                                );
                                 
            insert cs;
            
             Case cs1 = new Case(
                                Status ='New', 
                                Priority = 'Medium', 
                                Origin = 'Email',                                       
                                ContactId =ct.Id,
                                AccountId=ac.Id,
                                GE_ES_Sub_Type__c = 'RFQ processing',
  GE_ES_Customer_Request_Date__c = Date.Today().adddays(20)
                                );
                                 
            insert cs1;
            /*Product2 prod = new Product2(
                                Name = 'Test Prod',
                                IsActive = true
                                );
            insert prod;*/
            
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
            list<SVMXC__Skill__c>   lsitSkill=new       list<SVMXC__Skill__c>();            
            
            lsitSkill.add(skill);
            
            SVMXC__Skill__c skill2 = new SVMXC__Skill__c(
                                    Name = 'SVMX Skill2',
                                    SVMXC__Active__c = true,
                                    SVMXC__Skill_Area__c = 'Field Service',
                                    GE_PW_PGS_Country__c = 'US',
                                    GE_PW_PGS_Needs_Visa__c = true,
                                    GE_PW_PGS_Days_to_Get_Visa__c = 60,
                                    GE_OG_DS_In_Country_Duration__c = 30
                                    );
            lsitSkill.add(skill2);
            insert lsitSkill;
            
            SVMXC__Service_Group_Skills__c techexperts = new SVMXC__Service_Group_Skills__c(
                                    SVMXC__Service_Group__c = sg.Id,
                                    SVMXC__Group_Member__c = tech.Id,
                                    SVMXC__Skill__c = skill.Id,
                                    Competency_Level__c = 'Level 1',GE_OG_GS_Root_Qualification_Level__c='SFSE'
                                    );
            insert techexperts;
            
            
            
            //Retriving Work Order 'D&S' Record Type
            Id rtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
            
            //Create Work Order
            SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c (
                                            SVMXC__Case__c = cs.Id ,
                                            SVMXC__Company__c = ac1.Id , 
                                            SVMXC__Contact__c = ct.Id,
                                            SVMXC__Order_Status__c = 'Closed',
                                            SVMXC__Priority__c ='Medium',
                                            SVMXC__Order_Type__c='Field Service',
                                            RecordTypeId = rtId,
                                            SVMXC__Service_Group__c = sg.Id,
                                            SVMXC__Closed_By__c=Userid,
                                            GE_PC_Oracle_FSO__c='ksk123'
                                            //SVMXC__Group_Member__c = tech.Id
                                            );
            insert svo;
            
            //Create Work Order
            SVMXC__Service_Order__c svo1 = new SVMXC__Service_Order__c (
                                            SVMXC__Case__c = cs1.Id ,
                                            SVMXC__Company__c = ac1.Id , 
                                            SVMXC__Contact__c = ct.Id,
                                            SVMXC__Order_Status__c = 'Open',
                                            SVMXC__Priority__c ='Medium',
                                            SVMXC__Order_Type__c='Field Service',
                                            RecordTypeId = rtId,
                                            SVMXC__Service_Group__c = sg.Id,
                                            SVMXC__Closed_By__c=Userid,
                                            GE_PC_Oracle_FSO__c='ksk456'
                                            //SVMXC__Group_Member__c = tech.Id
                                            );
            insert svo1;

            
            
            Test.StartTest();
            svo.SVMXC__Order_Status__c = 'Open';
            update svo;
            
            svo1.SVMXC__Order_Status__c = 'Closed';
             update svo1;
            //Create Work Order Skill 
            Work_Order_Skill__c woskill = new Work_Order_Skill__c(
                                    Work_Order__c = svo.Id,
                                    Skills__c = skill.Id
                                    );
            insert woskill;
            
            Work_Order_Skill__c woskill1 = new Work_Order_Skill__c(
                                    Work_Order__c = svo.Id,
                                    Skills__c = skill2.Id
                                    );
            insert woskill1;
             
            svo.SVMXC__Group_Member__c = tech.Id;
            update svo;
            Test.stopTest();
            
            delete woskill1;
        }
}