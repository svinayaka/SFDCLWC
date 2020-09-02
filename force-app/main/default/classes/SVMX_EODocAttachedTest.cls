/*
================================================================
Type Name   : SVMX_EODocAttachedTest
Author      : Raja Kumar M
Created Date: 10/12/2013
Reason      : Test Class for controller SVMX_EODocAttached_Cntrl
================================================================
*/

@isTest(seealldata = true)

public class SVMX_EODocAttachedTest{
    //Commented as part of requirement R-26296
    public static TestMethod void SVMX_EODocAttached_CntrlTest(){
        Id DSRecordtype =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
        Id DSCase =  Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();
        
        case cas = new case();
        cas.RecordTypeId=DSCase;
        cas.GE_ES_Sub_Type__c = 'RFQ processing';
  cas.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
        
        insert cas;
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(RecordTypeId = DSRecordtype,SVMXC__Case__c = cas.id,SVMXC__Order_Status__c = 'open',GE_DS_Country_WkPerformed__c = 'India');
        insert wo;
        Test.startTest();
            ApexPages.StandardController stdcontroller = new ApexPages.StandardController(wo); 
            SVMX_EODocAttached_Cntrl EoDoc = new SVMX_EODocAttached_Cntrl(stdcontroller);
            //EoDoc.messageAction();
        Test.stopTest();    
    }
}