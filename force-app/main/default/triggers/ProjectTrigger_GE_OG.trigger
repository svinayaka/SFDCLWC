/*
Class/Trigger Name     : ProjectTrigger_GE_OG
Purpose/Overview       : Project_ge_og__c
Scrum Team             : Transformation - Project MGMT
Requirement Number     : R-23831
Created Date           : 27/June/2017
Test Class Name        : ProjectTriggerHandlerTest_GE_OG
Code Coverage          : 
*/



trigger ProjectTrigger_GE_OG on Project_ge_og__c (Before Insert, Before Update,After Insert, After Update) {
    
    ProjectTriggerHandler_GE_OG objProjHandler = new ProjectTriggerHandler_GE_OG();
    //ProjectStageAutomation_Helper projstageautomationhandler = new ProjectStageAutomation_Helper();
    
    Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'ProjectTrigger_GE_OG' limit 1];
    
    boolean isEnabled = true;
    
    if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
    
    if(isEnabled){
        if(trigger.isBefore){
            if(trigger.isInsert || trigger.isUpdate){
                objProjHandler.beforeIsnertUpdateFunctionality(trigger.new, trigger.oldMap);
            }
        }
        
        if(trigger.isAfter && trigger.isInsert){  
            objProjHandler.after_Insert_Functionality(trigger.new,trigger.newMap);
            
            
        }
        
        if(trigger.isAfter && trigger.isUpdate){ 
            if(CheckRecursion_GE_OG.runOnce()){ // added by Harsha C 
                objProjHandler.after_Update_Functionality(trigger.new,trigger.newMap, trigger.old, trigger.oldMap);
            }
            
        }
    }
    else
        System.debug('ProjectTrigger_GE_OG is disabled via Trigger_Toggle__mdt setting');
    
    
}