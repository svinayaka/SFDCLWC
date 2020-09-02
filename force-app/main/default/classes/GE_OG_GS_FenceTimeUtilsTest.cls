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
private class GE_OG_GS_FenceTimeUtilsTest {

    static testMethod void TestFenceTimeWithRecord() {
        GE_OG_GS_Fence_Time__c fTime = new GE_OG_GS_Fence_Time__c();
        fTime.Name = 'Test Time';
        fTime.GE_OG_GS_Country__c = 'Test Country';
        fTime.GE_OG_GS_Active__c = true;
        fTime.GE_OG_GS_Fence_Time_Days__c = 69;
        insert fTime;
        
        
        Id rtId = [SELECT Id FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c' AND NAme = 'GS-Requirement' LIMIT 1].Id;
    	
    	Test.startTest();
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId = rtId;
        wo.SVMXC__Country__c = 'Test Country';
        insert wo; 
        Test.stopTest();
        
        wo = [SELECT Id, GE_OG_GS_Fence_Time_Days__c FROM SVMXC__Service_Order__c WHERE Id = :wo.Id LIMIT 1];
        system.assertEquals(69, wo.GE_OG_GS_Fence_Time_Days__c);
       
    }
    
    static testMethod void TestFenceTimeWithOutRecord() {
       
        
        Id rtId = [SELECT Id FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c' AND NAme = 'GS-Requirement' LIMIT 1].Id;
    	
    	Test.startTest();
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId = rtId;
        wo.SVMXC__Country__c = 'Test Country';
        insert wo; 
        Test.stopTest();
        
        wo = [SELECT Id, GE_OG_GS_Fence_Time_Days__c FROM SVMXC__Service_Order__c WHERE Id = :wo.Id LIMIT 1];
        system.assertEquals(999, wo.GE_OG_GS_Fence_Time_Days__c);
       
    }
}