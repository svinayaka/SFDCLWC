/*
Class/Trigger Name     : IWS_Qualifying_Checklist_Record_CrtnTest
Purpose/Overview       : Test Class to calculate the code coverage for the IWS_Qualifying_Checklist_RecordCreation Class               
Requirement Number     : R-32187
Author                 : Harsha C
Created Date           : 01-july-2019
Used For               : IWS_Qualifying_Checklist_RecordCreation - 94%
*/ 

@isTest
public class IWS_Qualifying_Checklist_Record_CrtnTest {
    public static testMethod void testProspectingChecklistRecordCreation(){
        test.startTest(); 
        // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        
        //Createing an Account 
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        Opportunity opp = CommonTestDataFactory_GE_OG.createOpptyOFSIWS('Testopportunity',acc.ID);
        //system.assertEquals('Testopportunity',opp.Name);
        List<id> optyId = new List<Id>();
        optyId.add(opp.Id);
        
        IWS_Qualifying_Checklist_Record_Creation.recordsOfIWSQualifyingChecklist(optyId);
        test.stopTest(); 
    }
}