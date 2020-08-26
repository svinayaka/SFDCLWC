/*
Class/Trigger Name     : RiskChecklistDeviationTrigger_GE_OG
Purpose/Overview       : This trigger is called before insert and update of Risk Checklist Deviation records
Scrum Team             : Transformation - Deal MGMT
Requirement Number     : R-24234
Author                 : Nitish
Created Date           : 14/Mar/2016
Test Class Name        : CreateDealDesk_GE_OG_Test
Code Coverage          : 100%
*/

trigger RiskChecklistDeviationTrigger_GE_OG on Risk_Checklist_Deviation_ge_og__c (before update, before insert,after update, after insert) {
    riskChecklistDeviationTriggerHandler objTriggerHandler = new riskChecklistDeviationTriggerHandler ();
    if(trigger.isbefore)
    {
        if(trigger.isUpdate|| trigger.isInsert){
            objTriggerHandler.updateDeviationText(trigger.new,trigger.oldMap);
        }
    }
    
}