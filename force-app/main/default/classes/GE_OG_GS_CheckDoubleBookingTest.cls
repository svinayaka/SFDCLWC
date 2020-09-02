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
@isTest(SeeAllData=true)
private class GE_OG_GS_CheckDoubleBookingTest {

    static testMethod void checkDoubleBookingSVMXEvent() {
    	SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
    	team.Name = 'Test';
    	insert team;
    	
    	
    	SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
    	tech.SVMXC__Service_Group__c = team.Id;
    	tech.SVMXC__Enable_Scheduling__c = true;
    	tech.Name = 'Test Tech';
    	insert tech;
    	
    	Id rtId = [SELECT Id FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c' AND NAme = 'GS-Requirement' LIMIT 1].Id;
    	
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Group_Member__c = tech.Id;
        wo.RecordTypeId = rtId;
        insert wo;
        
        SVMXC__SVMX_Event__c e1 = new SVMXC__SVMX_Event__c();
        e1.SVMXC__Service_Order__c = wo.Id;
        e1.SVMXC__EndDateTime__c = DateTime.newInstanceGmt(system.today().addDays(2), Time.newInstance(0, 0, 0, 0));
        e1.SVMXC__WhatId__c = String.valueOf(wo.Id);
        e1.SVMXC__StartDateTime__c = DateTime.newInstanceGmt(system.today(), Time.newInstance(0, 0, 0, 0));
        e1.SVMXC__Technician__c = tech.Id;
        insert e1;
        
        SVMXC__Service_Order__c wo2 = new SVMXC__Service_Order__c();
        wo2.SVMXC__Group_Member__c = tech.Id;
        wo2.RecordTypeId = rtId;
        insert wo2;
        
        SVMXC__SVMX_Event__c e = new SVMXC__SVMX_Event__c();
        e.SVMXC__Service_Order__c = wo2.Id;
        e.SVMXC__WhatId__c = String.valueOf(wo2.Id);
        e.SVMXC__EndDateTime__c = DateTime.newInstanceGmt(system.today().addDays(4), Time.newInstance(0, 0, 0, 0));
        e.SVMXC__StartDateTime__c = DateTime.newInstanceGmt(system.today().addDays(2), Time.newInstance(0, 0, 0, 0));
        e.SVMXC__Technician__c = tech.Id;
        insert e;

        system.debug([SELECT Id,SVMXC__EndDateTime__c,SVMXC__StartDateTime__c FROM SVMXC__SVMX_Event__c WHERE ID = :e.Id  ]);
        system.debug([SELECT Id,SVMXC__EndDateTime__c,SVMXC__StartDateTime__c FROM SVMXC__SVMX_Event__c WHERE ID = :e1.Id  ]);
        
        system.debug([SELECT Id FROM SVMXC__SVMX_Event__c WHERE SVMXC__Service_Order__c = :wo.Id]);
        Test.startTest();
        
        SVMXC.SFM_WrapperDef.SFM_TargetRecord request = new SVMXC.SFM_WrapperDef.SFM_TargetRecord();
        SVMXC.SFM_WrapperDef.SFM_TargetRecordObject header = new SVMXC.SFM_WrapperDef.SFM_TargetRecordObject();
        header.objName = 'SVMXC__Service_Order__c';
        List<SVMXC.SFM_WrapperDef.SFM_StringMap> recordsAsKeyValue = new List<SVMXC.SFM_WrapperDef.SFM_StringMap>();
        SVMXC.SFM_WrapperDef.SFM_Record record = new SVMXC.SFM_WrapperDef.SFM_Record();
        
        recordsAsKeyValue.add(new SVMXC.SFM_WrapperDef.SFM_StringMap('Id', wo.Id));
        record.setTargetRecordAsKeyValue(recordsAsKeyValue);
        header.setRecords(new List<SVMXC.SFM_WrapperDef.SFM_Record> {record});
        request.headerRecord = header;
        
        SVMXC.SFM_WrapperDef.SFM_PageData pageData = GE_OG_GS_CheckDoubleBooking.checkDoubleBooking(request);
        
        Test.stopTest();
        system.assert(pageData.pageDataSet.sobjectinfo.get('GE_OG_GS_Assignment_Warnings__c') != null);
    }

    static testMethod void checkDoubleBookingSVMXEventAssignmentRevision() {
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.Name = 'Test';
        insert team;
        
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
        tech.SVMXC__Service_Group__c = team.Id;
        tech.SVMXC__Enable_Scheduling__c = true;
        tech.Name = 'Test Tech';
        insert tech;
        
        Id rtId = [SELECT Id FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c' AND NAme = 'GS-Requirement' LIMIT 1].Id;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Group_Member__c = tech.Id;
        wo.GE_OG_GS_Accept_Revision__c = 'Assignment Revision';
        wo.GE_OG_GS_Planned_End_Date__c = system.today().addDays(2);
        wo.GE_OG_GS_Planned_Start_Date__c = system.today();
        wo.RecordTypeId = rtId;
        insert wo;
        
        SVMXC__SVMX_Event__c e1 = new SVMXC__SVMX_Event__c();
        e1.SVMXC__Service_Order__c = wo.Id;
        e1.SVMXC__EndDateTime__c = DateTime.newInstanceGmt(system.today().addDays(2), Time.newInstance(0, 0, 0, 0));
        e1.SVMXC__WhatId__c = String.valueOf(wo.Id);
        e1.SVMXC__StartDateTime__c = DateTime.newInstanceGmt(system.today(), Time.newInstance(0, 0, 0, 0));
        e1.SVMXC__Technician__c = tech.Id;
        insert e1;
        
        SVMXC__Service_Order__c wo2 = new SVMXC__Service_Order__c();
        wo2.SVMXC__Group_Member__c = tech.Id;
        wo2.RecordTypeId = rtId;
        insert wo2;
        
        SVMXC__SVMX_Event__c e = new SVMXC__SVMX_Event__c();
        e.SVMXC__Service_Order__c = wo2.Id;
        e.SVMXC__WhatId__c = String.valueOf(wo2.Id);
        e.SVMXC__EndDateTime__c = DateTime.newInstanceGmt(system.today().addDays(4), Time.newInstance(0, 0, 0, 0));
        e.SVMXC__StartDateTime__c = DateTime.newInstanceGmt(system.today().addDays(2), Time.newInstance(0, 0, 0, 0));
        e.SVMXC__Technician__c = tech.Id;
        insert e;

        system.debug([SELECT Id,SVMXC__EndDateTime__c,SVMXC__StartDateTime__c FROM SVMXC__SVMX_Event__c WHERE ID = :e.Id  ]);
        system.debug([SELECT Id,SVMXC__EndDateTime__c,SVMXC__StartDateTime__c FROM SVMXC__SVMX_Event__c WHERE ID = :e1.Id  ]);
        
        system.debug([SELECT Id FROM SVMXC__SVMX_Event__c WHERE SVMXC__Service_Order__c = :wo.Id]);
        Test.startTest();
        
        SVMXC.SFM_WrapperDef.SFM_TargetRecord request = new SVMXC.SFM_WrapperDef.SFM_TargetRecord();
        SVMXC.SFM_WrapperDef.SFM_TargetRecordObject header = new SVMXC.SFM_WrapperDef.SFM_TargetRecordObject();
        header.objName = 'SVMXC__Service_Order__c';
        List<SVMXC.SFM_WrapperDef.SFM_StringMap> recordsAsKeyValue = new List<SVMXC.SFM_WrapperDef.SFM_StringMap>();
        SVMXC.SFM_WrapperDef.SFM_Record record = new SVMXC.SFM_WrapperDef.SFM_Record();
        
        recordsAsKeyValue.add(new SVMXC.SFM_WrapperDef.SFM_StringMap('Id', wo.Id));
        record.setTargetRecordAsKeyValue(recordsAsKeyValue);
        header.setRecords(new List<SVMXC.SFM_WrapperDef.SFM_Record> {record});
        request.headerRecord = header;
        
        SVMXC.SFM_WrapperDef.SFM_PageData pageData = GE_OG_GS_CheckDoubleBooking.checkDoubleBookingAssignmentRevision(request);
        
        Test.stopTest();
        system.assert(pageData.pageDataSet.sobjectinfo.get('GE_OG_GS_Assignment_Warnings__c') != null);
    }

    static testMethod void checkDoubleBookingSFDCEvent() {
    	//Create Service Team
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c(
        Name = 'SVMX STName'
        );
        insert sg;
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = sg.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
    	
    	Id rtId = [SELECT Id FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c' AND NAme = 'GS-Requirement' LIMIT 1].Id;
    	
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Group_Member__c = tech.Id;
        wo.RecordTypeId = rtId;
        insert wo;
        
        Event eve = new Event (
        WhatId = wo.id,
        OwnerId = UserInfo.getUserId(),
        EndDateTime = DateTime.newInstanceGmt(system.today().addDays(2), Time.newInstance(0, 0, 0, 0)),
        StartDateTime = DateTime.newInstanceGmt(system.today(), Time.newInstance(0, 0, 0, 0))
        );
        insert eve;
        
        SVMXC__Service_Order__c wo2 = new SVMXC__Service_Order__c();
        wo2.SVMXC__Group_Member__c = tech.Id;
        wo2.RecordTypeId = rtId;
        insert wo2;
        
        eve = new Event (
        WhatId = wo2.id,
        OwnerId = UserInfo.getUserId(),
        EndDateTime = DateTime.newInstanceGmt(system.today().addDays(4), Time.newInstance(0, 0, 0, 0)),
        StartDateTime = DateTime.newInstanceGmt(system.today().addDays(2), Time.newInstance(0, 0, 0, 0))
        );
        insert eve;
        
        Test.startTest();
        SVMXC.SFM_WrapperDef.SFM_TargetRecord request = new SVMXC.SFM_WrapperDef.SFM_TargetRecord();
        SVMXC.SFM_WrapperDef.SFM_TargetRecordObject header = new SVMXC.SFM_WrapperDef.SFM_TargetRecordObject();
        header.objName = 'SVMXC__Service_Order__c';
        List<SVMXC.SFM_WrapperDef.SFM_StringMap> recordsAsKeyValue = new List<SVMXC.SFM_WrapperDef.SFM_StringMap>();
        SVMXC.SFM_WrapperDef.SFM_Record record = new SVMXC.SFM_WrapperDef.SFM_Record();
        
        recordsAsKeyValue.add(new SVMXC.SFM_WrapperDef.SFM_StringMap('Id', wo.Id));
        record.setTargetRecordAsKeyValue(recordsAsKeyValue);
        header.setRecords(new List<SVMXC.SFM_WrapperDef.SFM_Record> {record});
        request.headerRecord = header;
        
        SVMXC.SFM_WrapperDef.SFM_PageData pageData = GE_OG_GS_CheckDoubleBooking.checkDoubleBooking(request);
        
        Test.stopTest();
        
        system.assert(pageData.pageDataSet.sobjectinfo.get('GE_OG_GS_Assignment_Warnings__c') != null);
    }

    static testMethod void checkDoubleBookingSFDCEventAssignmentRevision() {
        //Create Service Team
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c(
        Name = 'SVMX STName'
        );
        insert sg;
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = sg.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        
        Id rtId = [SELECT Id FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c' AND NAme = 'GS-Requirement' LIMIT 1].Id;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Group_Member__c = tech.Id;
        wo.RecordTypeId = rtId;        
        wo.GE_OG_GS_Accept_Revision__c = 'Assignment Revision';
        wo.GE_OG_GS_Planned_End_Date__c = system.today().addDays(2);
        wo.GE_OG_GS_Planned_Start_Date__c = system.today();
        insert wo;
        
        Event eve = new Event (
        WhatId = wo.id,
        OwnerId = UserInfo.getUserId(),
        EndDateTime = DateTime.newInstanceGmt(system.today().addDays(2), Time.newInstance(0, 0, 0, 0)),
        StartDateTime = DateTime.newInstanceGmt(system.today(), Time.newInstance(0, 0, 0, 0))
        );
        insert eve;

        system.debug(eve);
        
        SVMXC__Service_Order__c wo2 = new SVMXC__Service_Order__c();
        wo2.SVMXC__Group_Member__c = tech.Id;
        wo2.RecordTypeId = rtId;
        insert wo2;
        
        eve = new Event (
        WhatId = wo2.id,
        OwnerId = UserInfo.getUserId(),
        EndDateTime = DateTime.newInstanceGmt(system.today().addDays(4), Time.newInstance(0, 0, 0, 0)),
        StartDateTime = DateTime.newInstanceGmt(system.today().addDays(2), Time.newInstance(0, 0, 0, 0))
        );
        insert eve;
        
        Test.startTest();
        SVMXC.SFM_WrapperDef.SFM_TargetRecord request = new SVMXC.SFM_WrapperDef.SFM_TargetRecord();
        SVMXC.SFM_WrapperDef.SFM_TargetRecordObject header = new SVMXC.SFM_WrapperDef.SFM_TargetRecordObject();
        header.objName = 'SVMXC__Service_Order__c';
        List<SVMXC.SFM_WrapperDef.SFM_StringMap> recordsAsKeyValue = new List<SVMXC.SFM_WrapperDef.SFM_StringMap>();
        SVMXC.SFM_WrapperDef.SFM_Record record = new SVMXC.SFM_WrapperDef.SFM_Record();
        
        recordsAsKeyValue.add(new SVMXC.SFM_WrapperDef.SFM_StringMap('Id', wo.Id));
        record.setTargetRecordAsKeyValue(recordsAsKeyValue);
        header.setRecords(new List<SVMXC.SFM_WrapperDef.SFM_Record> {record});
        request.headerRecord = header;
        
        SVMXC.SFM_WrapperDef.SFM_PageData pageData = GE_OG_GS_CheckDoubleBooking.checkDoubleBookingAssignmentRevision(request);
        
        Test.stopTest();
        
        system.assert(pageData.pageDataSet.sobjectinfo.get('GE_OG_GS_Assignment_Warnings__c') != null);
    }
}