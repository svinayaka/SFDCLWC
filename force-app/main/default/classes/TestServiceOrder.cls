/*****************
Author: ForeFront/Ryan Cerankowski
GE OG D&S
Summary: This test class is responsible for testing the following triggers and classes:
Trigger GE_DS_SVMX_Technician_Email_Address
Trigger GE_DS_SVMX_SMEventAfter
Trigger GE_DS_WorkOrderBillable
Class GE_DS_SVMX_ServiceOrder
*****************/

@isTest(seeAllData = true)
private class TestServiceOrder {
    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
        //1/28/2014 - Change made by Ryan C, ForeFront, based on GE request
        
        /*
        List<RecordType> workOrders = new List<RecordType>();
        try{
            workOrders = [SELECT Id, Name FROM RecordType WHERE Name = 'D&S' AND SobjectType = 'SVMXC__Service_Order__c' Limit 1];
        }catch(QueryException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        List<RecordType> workDetails = new List<RecordType>();   
        try{
            workDetails = [SELECT Id, Name FROM RecordType WHERE Name = 'Usage/Consumption' AND SobjectType = 'SVMXC__Service_Order_Line__c' Limit 1];
        }catch(QueryException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        */
        
        List<Id> workOrders = new List<Id>();
        List<Id> workDetails = new List<Id>();

        Schema.SObjectType s = SVMXC__Service_Order__c.sObjectType;
        Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); //getting all Recordtype for the Sobject
        Id rtId = recordTypeInfo.get('D&S').getRecordTypeId();//particular RecordId by  Name
        
        workOrders.add(rtId);
        
        Schema.SObjectType sLine = SVMXC__Service_Order_Line__c.sObjectType;
        Schema.DescribeSObjectResult resSchemaLine = sLine.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> recordLineTypeInfo = resSchemaLine.getRecordTypeInfosByName(); //getting all Recordtype for the Sobject
        Id rtLineId = recordLineTypeInfo.get('Usage/Consumption').getRecordTypeId();//particular RecordId by  Name
        
        workDetails.add(rtLineId);
        //End Change 1/28/2014
        //Commented as part of requirement R-26296
        /* SVMXC__Service_Order__c workOrder = new SVMXC__Service_Order__c(GE_DS_Entire_Work_Order_Billable__c = true, GE_SM_HQ_Scheduled_Start_Date_Time__c = Datetime.now(),
        GE_SM_HQ_Scheduled_End_Date_Time__c = Datetime.now());*/
        SVMXC__Service_Order__c workOrder = new SVMXC__Service_Order__c(GE_SM_HQ_Scheduled_Start_Date_Time__c = Datetime.now(),
        GE_SM_HQ_Scheduled_End_Date_Time__c = Datetime.now());
        workOrder.RecordTypeId = workOrders[0];
        
        try{
            insert workOrder;
        }catch(Exception e){
            System.debug(e);
        }
        Event sfEvent = new Event(WhatId = workOrder.Id, DurationInMinutes = 5, ActivityDateTime = Datetime.now());
        try{
        insert sfEvent;
        }catch(Exception e){
            System.debug(e);
        }
        
        List<SVMXC__Service_Group_Members__c> technicians = [select Id, Name, SVMXC__Email__c FROM SVMXC__Service_Group_Members__c Limit 1];
        
        SVMXC__Service_Order_Line__c workLine = new SVMXC__Service_Order_Line__c(SVMXC__Service_Order__c = workOrder.Id, SVMXC__Line_Type__c = 'Labor',
        SVMXC__Activity_Type__c = 'Installation', SVMXC__Start_Date_and_Time__c = Datetime.now().addYears(10), SVMXC__End_Date_and_Time__c = Datetime.now().addYears(10).addMinutes(10),
        SVMXC__Actual_Quantity2__c = 1, RecordTypeId = workDetails[0], SVMXC__Group_Member__c = technicians[0].Id);
        try{
            insert workLine;
        }catch(Exception e){
            System.debug(e);
        }
        Test.startTest();
        
        if(technicians.size() > 0){
            technicians[0].SVMXC__Email__c = 'test123@faketest.com';
        }
        try{
        update technicians;
        }catch(Exception e){
            System.debug(e);
        }
            
        workLine.SVMXC__End_Date_and_Time__c = workLine.SVMXC__End_Date_and_Time__c.addHours(1);
        try{
        update workLine;
        }catch(Exception e){
            System.debug(e);
        }
            
        workOrder.SVMXC__Group_Member__c = technicians[0].Id;
        //workOrder.GE_DS_Entire_Work_Order_Billable__c = false; Commented as part of requirement R-26296
        workOrder.GE_SM_HQ_Scheduled_Start_Date_Time__c = workOrder.GE_SM_HQ_Scheduled_Start_Date_Time__c + 3;
        try{
        update workOrder;
        }catch(Exception e){
            System.debug(e);
        }
            
        //workOrder.GE_DS_Entire_Work_Order_Billable__c = true; Commented as part of requirement R-26296
        try{
        update workOrder;
        }catch(Exception e){
            System.debug(e);
        }
        
        Test.stopTest();
        
        List<SVMXC_Time_Entry__c> timeEntry = [Select Id, Name, Is_Billable__c, Work_Details__c FROM SVMXC_Time_Entry__c WHERE Work_Details__c = :workLine.Id];
        System.debug(workLine.Id);
        if(timeEntry.size() != 0){
            System.debug(timeEntry[0].Work_Details__c);
        }
        for(SVMXC_Time_Entry__c entry : timeEntry){
            System.assert(entry.Is_Billable__c == true, 'Test failed, Time Entry was not set to billable.');            
        }
        
    }
}