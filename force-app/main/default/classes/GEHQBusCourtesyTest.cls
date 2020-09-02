/* 
Test Class Name: GEHQBusCourtesyTest
Purpose/Overview: A Test class for  GEHQBusCourtesy class
Author : Lakshmi Prasanna
Created Date:2/24/2012
*/

@isTest
private class GEHQBusCourtesyTest {
    static testMethod void myUnitTest() {
    
        List<Account> AccList = new List<Account>();
        RecordType AccRT = [select name,Id from RecordType where Name = : 'CMF Approved' limit 1] ;
        Account Acc= new Account(name='TestAcc',RecordTypeId = AccRT.Id);        AccList.add(Acc);
        Account AccDel= new Account(name='TestAccDel',RecordTypeId = AccRT.Id);  AccList.add(AccDel);
        Insert AccList;  
        GE_HQ_Business_Courtesy__c BCObj = new GE_HQ_Business_Courtesy__c();
        BCObj.GE_HQ_Acc__c = AccList[0].Id ;
        insert BCObj;
        ApexPages.StandardController con= new ApexPages.standardController(BCObj);
        GEHQBusCourtesy  geh= new GEHQBusCourtesy(con);
        geh.doSave();
   }

}