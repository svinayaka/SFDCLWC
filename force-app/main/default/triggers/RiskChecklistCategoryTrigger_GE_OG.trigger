/*
Class/Trigger Name     : OpportunityTrigger_GE_OG
Purpose/Overview       : This trigger is called before and after update of Opportunity records
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23494
Author                 : Madhuri Sharma
Created Date           : 01/OCT/2015
Test Class Name        :  OpportunityStagesAutomation_GE_OG_Test
Code Coverage          : 
*/

trigger RiskChecklistCategoryTrigger_GE_OG on Risk_Checklist_Category_ge_og__c (before update,after update) {
    RiskChecklistCategoryHandler_GE_OG objTriggerHandler = new RiskChecklistCategoryHandler_GE_OG ();
    if(trigger.isBefore)
    {
        if(trigger.isUpdate){
            System.debug('\n\n ------ Before Update Block ENTERED ----- ');
            objTriggerHandler.beforeUpdateFunctionality(trigger.new,trigger.oldMap);
        }
    }
    if(trigger.isAfter)
    {
        if(trigger.isUpdate){
            objTriggerHandler.afterUpdateFunctionality(trigger.new,trigger.oldMap);
        }
    }
   
    
}