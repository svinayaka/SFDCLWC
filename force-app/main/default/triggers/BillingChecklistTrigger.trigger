/*
Class/Trigger Name     : BillingChecklistTrigger 
Purpose/Overview       : update last modified date and last modified user on opportunity.
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-33748
Author                 : Harsha C
Created Date           : 26/02/2020
Test Class Name        : BillingChecklistTriggerHandler_Test
Code Coverage          : 
*/
trigger BillingChecklistTrigger on Billing_Checklist_GE_OG__c (after update) {
    BillingChecklistTriggerHandler.updateLastModifiedOnOpportunity(Trigger.New);
}