/*
Class/Trigger Name     : AccountPlanningTrigger_GE_OG 
Purpose/Overview       : This trigger is called after insert & update of Account Planning records
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-29179
Author                 : Sonali Rathore
Created Date           : 10/MAR/2018
*/
trigger AccountPlanningTrigger_GE_OG on Account_Planning__c (after insert) {
    
    AccountPlanningTriggerHandler_GE_OG apObjTriggerHandler = new AccountPlanningTriggerHandler_GE_OG();
    Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'AccountPlanningTrigger_GE_OG' limit 1];
    
    boolean isEnabled = true;
    
    if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
    
    if(isEnabled){
    if(trigger.isAfter)
        if(trigger.isInsert){
            {
            apObjTriggerHandler.plaTierUpdateFunctionality(Trigger.new);
            
        }
    }
    }
    else
        System.debug('AccountPlanningTrigger_GE_OG is disabled via Trigger_Toggle__mdt setting');
}