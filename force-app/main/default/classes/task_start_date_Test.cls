@isTest 
private class task_start_date_Test {
    static testMethod void TastStartTest() {
       
        
        Account acnt = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        
        Contact con = new Contact();
        con.FirstName= 'Test';
        con.LastName = 'test';
        con.AccountId = acnt.id;
        con.Email = 'test@abc.com';
        insert con;

        Task t = new Task();
        t.Status = 'Completed';
        t.WhatId = acnt.Id; 
        t.Subject= 'Run Test Trigger';
        t.ActivityDate= Date.today();
        t.RecordTypeId= Schema.SObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeId();
        insert t;
        
        Task tsk = new Task();
        tsk.Status = 'Completed';
        tsk.WhoId= con.Id; 
        tsk.WhatId = acnt.Id; 
        tsk.Subject= 'Run Test Trigger';
        tsk.ActivityDate= Date.today();
        tsk.RecordTypeId= Schema.SObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeId();
        insert tsk;
       
    }
}