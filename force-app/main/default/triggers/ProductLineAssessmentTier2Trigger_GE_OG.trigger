/*
Class/Trigger Name     : ProductLineAssessmentTier2Trigger_GE_OG 
Purpose/Overview       : This trigger is called after insert of Product Line Assessment Tier 2 records
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-29179
Author                 : Sonali Rathore
Created Date           : 10/MAR/2018
*/
trigger ProductLineAssessmentTier2Trigger_GE_OG on Product_Line_Assessment_Tier_2_ge_og__c (after insert) {
    
    PLATier2TriggerHandler_GE_OG plaObjTriggerHandler = new PLATier2TriggerHandler_GE_OG();
    
     Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'Product_Line_Assessment_Tier_2_ge_og__c' limit 1];
    
    boolean isEnabled = true;
    
    if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
    
    if(isEnabled){
    if(trigger.isAfter)
        if(trigger.isInsert){
            {
            plaObjTriggerHandler.plaTier2UpdateFunctionality(Trigger.new);
            
        }
    }
    }
    else
        System.debug('Product_Line_Assessment_Tier_2_ge_og__c is disabled via Trigger_Toggle__mdt setting');
 }