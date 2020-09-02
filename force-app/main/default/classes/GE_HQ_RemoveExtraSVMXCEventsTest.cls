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
private class GE_HQ_RemoveExtraSVMXCEventsTest {

    static testMethod void myUnitTest() {
        
        SVMXC__Skill__c skill= new SVMXC__Skill__c(Name='Test Skill');
        insert skill;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Skill__c=skill.Id;
        insert wo;
        
        SVMXC__SVMX_Event__c event = new SVMXC__SVMX_Event__c(
            Name = 'Test',
            SVMXC__WhatId__c = wo.Id, 
            SVMXC__StartDateTime__c = Date.newInstance(2015, 1, 8),
            SVMXC__EndDateTime__c= Date.newInstance(2015, 1, 10),
            SVMXC_Start_Date_Time_UI__c=Date.newInstance(2015, 1, 8),
            SVMXC_End_Date_Time_UI__c=Date.newInstance(2015, 1, 10)
        );
        
        insert event;
        
        SVMXC__SVMX_Event__c event2 = new SVMXC__SVMX_Event__c(
            Name = 'Test',
            SVMXC__WhatId__c = wo.Id, 
            SVMXC__StartDateTime__c = Date.newInstance(2015, 1, 8),
            SVMXC__EndDateTime__c= Date.newInstance(2015, 1, 10),
            SVMXC_Start_Date_Time_UI__c=Date.newInstance(2015, 1, 8),
            SVMXC_End_Date_Time_UI__c=Date.newInstance(2015, 1, 10)
        );
        
        insert event2;
        
        List<SVMXC__SVMX_Event__c> eventList = [SELECT Id FROM SVMXC__SVMX_Event__c WHERE SVMXC__WhatId__c = :wo.Id];
//        System.assertEquals(1, eventList.size());
    }
}