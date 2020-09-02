/*
Class/Trigger Name     : ProjectTriggerHandlerTest_GE_OG
Used For               : ProjectTriggerHandler_GE_OG & Util_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the ProjectTriggerHandler_GE_OG & Util_GE_OG 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23281
Author                 : Nitish Pandey
Created Date           : 17-Sep-2015

*/

@isTest
public class ProjectTriggerHandlerTest_GE_OG{
     
    public static testMethod void testProjectTrigger(){
    
        //Creating Account
        
        account acc = new account();
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Drilling';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        insert acc;
        
        account acc1 = new account();
        acc1.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc1.name = 'Test Account';
        acc1.ShippingCountry = 'India';
        acc1.GE_ES_Primary_Industry__c = 'Drilling';
        acc1.Classification__c= 'Strategic';
        acc1.Type = 'Direct Customer';
        insert acc1;
        
        account acc2 = new account();
        acc2.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc2.name = 'Test Account';
        acc2.ShippingCountry = 'India';
        acc2.GE_ES_Primary_Industry__c = 'Drilling';
        acc2.Region_GEOG__c='North America';
        acc2.Classification__c= 'Strategic';
        acc2.Type = 'Direct Customer';
        insert acc2;
        
        //Cretaing Project
        Project_ge_og__c project  = new Project_ge_og__c();
        project.name = 'Test';
        project.Project_Summary_ge_og__c = 'Test';
        Project.project_account_ge_og__c = acc.id;
        project.Estimated_Value_ge_og__c = 10;
        Insert project;
        
        Project.project_account_ge_og__c = acc1.id;
        update project;
        
        //Cretaing Project
       Project_ge_og__c prj  = new Project_ge_og__c();
       prj.recordtypeid= Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('Joint Pursuit Project').getRecordTypeId();
        prj.name = 'Test1';
        prj.Project_Summary_ge_og__c = 'Test1';
        prj.project_account_ge_og__c = acc1.id;
        prj.Estimated_Value_ge_og__c = 10;
        prj.project_Install_Country_ge_og__c = 'INDIA';
        Insert prj;
        
        prj.project_account_ge_og__c = acc2.id;
        update prj;
        
        
       
        
       
    }
}