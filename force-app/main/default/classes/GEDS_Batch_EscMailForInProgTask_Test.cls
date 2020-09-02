@isTest
public class GEDS_Batch_EscMailForInProgTask_Test{
    public static TestMethod void TestMethod1(){
        case c=new case(GE_OG_Customer_Impact_CIR__c ='test',GE_ES_Sub_Type__c='ORDER CHANGE REQUEST');
        insert c;
        Id DSId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('DS').getRecordTypeId();
        Task t= new Task(Subject ='Testing',Status = 'In Progress',ActivityDate=System.Today(),WhatId=c.Id,recordTypeId=DSId);
        insert t;
        Test.startTest();
            GEDS_Schedule_EscMailForInProgTask sc = new  GEDS_Schedule_EscMailForInProgTask();
            SchedulableContext scCon;
            sc.execute(scCon);   
        Test.stopTest();
        }
        
    }