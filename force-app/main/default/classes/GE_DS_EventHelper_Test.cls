/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(SeeAllData=True)
private class GE_DS_EventHelper_Test {

    static testMethod void myUnitTest() {
        SVMXC__Site__c loc = new SVMXC__Site__c();
        loc.Name = 'Rig Loc 11112222';
        loc.GE_DS_Rig_ID__c = '4535345236A';
        
        insert loc;
        
        Id Userid = UserInfo.getUserId();
        //String userEmail = UserInfo.getUserEmail();
        
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        Id relRcty = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        //String LEAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        //Create Account
        Account ac = new Account(
        Name ='Account',
        ShippingStreet='ABC',
        ShippingCity='PQR ',
        ShippingState = 'XYZ',
        ShippingPostalCode='111',
        ShippingCountry='XYZ'
        ); 
        //ac.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        ac.RecordtypeId = CommAccrecType ;
        insert ac; 
        
        Account ac2 = new Account(
        Name ='Account',
        ShippingStreet='ABC',
        ShippingCity='PQR ',
        ShippingState = 'XYZ',
        ShippingPostalCode='111',
        ShippingCountry='XYZ'
        ); 
        ac2.GE_HQ_DUNS_Number__c = 'GE00test';
        ac2.Classification__c='Key Account';
        ac2.Type= 'GE Internal';
        ac2.RecordtypeId = relRcty;
        insert ac2; 
        
        /*Account ac1 = new Account(
        Name ='Account',
        ShippingStreet='ABC',
        ShippingCity='PQR ',
        ShippingState = 'XYZ',
        ShippingPostalCode='111',
        ShippingCountry='XYZ'
        ); 
        //ac.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        ac.RecordtypeId = LEAccrecType ;
        insert ac1;*/
        
        //Create Contact
        Contact ct = new Contact(
        FirstName='First',
        LastName='Last',
        AccountId =ac2.Id,
        Email = 'test12345@ge.com',
        MobilePhone= '12345',
        GE_OG_Contact_Audience__c='Field Service'
        ); 
        insert ct;
        
        Id DSCase =  Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();
 
        //Create Case 
        Case cs = new Case(
        Status ='New', 
        Priority = 'Medium', 
        Origin = 'Email', 
        //ContactId =ct.Id,
        AccountId=ac.Id,
        RecordTypeId= DSCase,GE_PW_PO__c='345543996345345'      
        );
         // 
        insert cs;
        
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
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        test.starttest();
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
        SVMXC__Company__c = ac.Id , 
        SVMXC__Contact__c = ct.Id,
        SVMXC__Order_Status__c = 'Open',
        SVMXC__Priority__c ='Medium',
        SVMXC__Order_Type__c='Field Service',
        RecordTypeId = rtId,
        SVMXC__Service_Group__c = sg.Id,
        GE_SM_HQ_Scheduled_Start_Date_Time__c = System.now(),
        GE_SM_HQ_Scheduled_End_Date_Time__c = System.now(),SVMXC__Group_Member__c = tech.id,
        SVMXC__Site__c = loc.Id,
        GE_SS_No_of_Drilling_Personnel__c = 3
        );
        insert svo;
        
        
            
        Event eve = new Event (
        WhatId = svo.id,
        OwnerId = UserInfo.getUserId(),
        EndDateTime = System.now().addMinutes(30),
        StartDateTime = System.now()
        );
        insert eve;
        
        delete eve;
        
        tech.SVMXC__Salesforce_User__c = null;
        update tech;
        
        //Retriving Work Order 'SS-Mobilize' Record Type
        Id rtId2 = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();        
        
        //Create Work Order
        SVMXC__Service_Order__c svo2 = new SVMXC__Service_Order__c (
        SVMXC__Case__c = cs.Id ,
        SVMXC__Company__c = ac.Id , 
        SVMXC__Contact__c = ct.Id,
        SVMXC__Order_Status__c = 'Open',
        SVMXC__Priority__c ='Medium',
        SVMXC__Order_Type__c='Field Service',
        RecordTypeId = rtId2,
        SVMXC__Service_Group__c = sg.Id,
        GE_SM_HQ_Scheduled_Start_Date_Time__c = System.now(),
        GE_SM_HQ_Scheduled_End_Date_Time__c = System.now(),
        GE_SS_No_of_Drilling_Personnel__c = 3
        );
        insert svo2;
        
        Event eve2 = new Event (
        WhatId = svo2.id,
        OwnerId = UserInfo.getUserId(),
        EndDateTime = System.now().addMinutes(30),
        StartDateTime = System.now()
        );
        insert eve2;
        
        //eve2.EndDateTime = System.now().addMinutes(100);
        //update eve2;
        
        delete eve2;
        
        Test.stopTest();
    }
}