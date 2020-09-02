/*
Class/Trigger Name     : BillingChecklistTriggerHandler
Used Where ?           : BillingChecklistTrigger
Purpose/Overview       : Helper Class for Trigger on Billing Checklist
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-33748
Author                 : Harsha C
Created Date           : 30/03/2020
Test Class Name        : OpportunityStagesAutomation_GE_OG_Test
Code Coverage          : 91%
*/
@isTest
public class BillingChecklistTriggerHandler_Test {
    @testsetup
    static void createRecord()
    {
        
        //creating 'Country Region Mapping' for 'INDIA'
        Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
        insert objcustom;
        
        /* Create Opportunity Reason Code Custom Setting */
        List<Opportunity_Primary_Reason_Has_Code__c> lstReasonCode = CommonTestDataFactory_GE_OG.createPrimaryReasonCustomSetting();
        insert lstReasonCode;
        
        
        // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        
        //Createing an Account 
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        //Creating an Opportunity
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',opp.Name);
        
        //  Test.startTest();
    }
    public static testMethod void testOpportunityStages1(){
        test.startTest();
        Opportunity_Generic_Checklist_ge_og__c opg= new Opportunity_Generic_Checklist_ge_og__c();
        opg.Question_ge_og__c = 'Question';
        opg.Active_GE_OG__c = true;
        insert opg;
        Opportunity oppty = [select id, Name from opportunity where Name = 'Testopportunity'];
        oppty.deal_path_ge_og__c = 'Deal Desk';
        
        List<Id> opplist = new List<Id>();
        opplist.add(oppty.Id);
        update oppty;
        Optional_BillingChecklist.create_BillingChecklist_Records(opplist);
        List<Billing_Checklist_GE_OG__c> bclupdate = new List<Billing_Checklist_GE_OG__c>();
        List<Billing_Checklist_GE_OG__c> bcl = new List<Billing_Checklist_GE_OG__c>();
        bcl = [SELECT Id, IsDeleted, Name,  Question_ge_og__c, Answer_ge_og__c, opportunity_ge_og__c FROM Billing_Checklist_GE_OG__c where opportunity_ge_og__c =:oppty.Id ];
        for(Billing_Checklist_GE_OG__c billingchklist : bcl){
            billingchklist.Answer_ge_og__c = 'Yes';
            bclupdate.add(billingchklist);
        }
        
        update bclupdate;
        BillingChecklistTriggerHandler.updateLastModifiedOnOpportunity(bclupdate);
        test.stopTest();
        
    }
    
}