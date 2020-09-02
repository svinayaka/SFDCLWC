/*
Class/Trigger Name     : ProspectingChecklistRecordCreation_Test
Purpose/Overview       : Test Class to calculate the code coverage for the ProspectingChecklistRecordCreation Class               
Requirement Number     : R-31184
Author                 : Harsha C
Created Date           : 02-Feb-2019
Used For               : ProspectingChecklistRecordCreation - 92%
*/ 
@IsTest
public class ProspectingChecklistRecordCreation_Test {
    public static testMethod void testProspectingChecklistRecordCreation(){
        Project_ge_og__c project =  CommonTestDataFactory_GE_OG.createProject('Test Project');  
        List<Id> projectId = new List<Id>();
        projectId.add(project.Id);
        test.startTest();
        ProspectingChecklistRecordCreation.recordsOfProspectingChecklist(projectId);
        test.stopTest();
      }
}