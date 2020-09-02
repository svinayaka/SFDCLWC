/*
Description     : This test class is used to test the GE_MCS_OpenActivitiesOnCase trigger


*/
@isTest
private class GE_MCS_OpenActivitiesOnCaseTest{
    
    static testMethod void runOpenActivitiesTest(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Account insAcc = new Account();
        insAcc.Name = 'Test';
        insAcc.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        insAcc.RecordtypeId = CommAccrecType ;
        insAcc.Classification__c='Test';
        insAcc.type='test';
        insert insAcc;
        
        Contact insCon = new Contact();
        insCon.FirstName = 'fName';
        insCon.LastName = 'lName';
        insCon.Email = 'test@test.com';
        insCon.AccountId = insAcc.id;
        insert insCon;
        
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
        //List<RecordType> recName = [SELECT Id, Name FROM RecordType WHERE Name =: 'MCS - CS'];
        Test.startTest();
        Case insCase = new Case();
        insCase.RecordtypeId = r;
        insCase.AccountId = insAcc.id;
        insCase.GE_ES_Sub_Type__c = 'RFQ processing';
        insCase.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
        insert insCase;
        
        Task insTask = new Task();
        insTask.Subject = 'Call';
        insTask.WhatId = insCase.Id;
        insTask.Status = 'Not Started';
        insert insTask;
        
        insCase.GE_MCS_Open_Activity__c = 'Yes';
        update insCase;
        Test.stopTest();
        insTask.Status = 'Completed';
        update insTask;
        
    }
}