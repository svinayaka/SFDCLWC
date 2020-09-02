/*
Class/Trigger Name     : Assign_O_RiskapproverPS
Used Where ?           : TPS_DealReviewerTrigger,DealReviewerTrigger
Purpose/Overview       : Helper Class for Trigger Deal_Reviewer_ge_og__c and TPS_Deal_Reviewer_ge_og__c
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-33379
Author                 : Harsha C
Created Date           : 27/DEC/2019
Test Class Name        : Assign_O_RiskapproverPS_Test
Code Coverage          : 81%
*/
@IsTest
public class Assign_O_RiskapproverPS_Test {
    @testSetup static void setup() {
        // Create common test user
        List<User> testUsers = new List<User>();
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg13579.com');
        testUsers.add(u); 
        
        insert testUsers;        
    }
    public static testMethod void assign_O_risk_Permission_Set_Deal_ReviewerTable(){
        test.startTest();
        User u = [Select Id,LastName from User where LastName='Testing'];
        Deal_Reviewer_ge_og__c dealreviewer = new Deal_Reviewer_ge_og__c();
        dealreviewer.user_ge_og__c = u.Id;
        dealreviewer.DR_Approver_Level_ge_og__c = '5';
        dealreviewer.DR_Region_ge_og__c = 'North America';
        dealreviewer.DR_Tier_2_ge_og__c = 'Digital Solutions';
        dealreviewer.DR_Tier_3_ge_og__c = 'Bently Neveda';
        insert dealreviewer;
        test.stopTest();
    }
    public static testMethod void assign_O_risk_Permission_Set_TPSDeal_ReviewerTable(){
        test.startTest();
        /* Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
LocaleSidKey='en_US', ProfileId = p.Id, 
TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');*/
        User u = [Select Id,LastName from User where LastName='Testing'];
        
        TPS_Deal_Reviewer_ge_og__c dealreviewer = new TPS_Deal_Reviewer_ge_og__c();
        dealreviewer.user_ge_og__c = u.Id;
        dealreviewer.DR_Approver_Level_ge_og__c = '5';
        dealreviewer.DR_Region_ge_og__c = 'North America';
        dealreviewer.DR_Tier_2_ge_og__c = 'Turbomachinery & Process Solutions';
        dealreviewer.DR_Tier_3_ge_og__c = 'Upgrades';
        dealreviewer.TPS_Segment_ge_og__c ='On & Offshore Production';
        dealreviewer.Offer_Type_Ge_Og__c = 'Engineering / Feasibility';
        insert dealreviewer;
        test.stopTest();
    }
    
    
}