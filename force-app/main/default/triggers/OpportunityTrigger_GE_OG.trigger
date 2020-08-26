/*
Class/Trigger Name     : OpportunityTrigger_GE_OG
Purpose/Overview       : This trigger is called before and after update of Opportunity records
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23405
Author                 : Madhuri Sharma
Created Date           : 01/OCT/2015
Test Class Name        :  OpportunityStagesAutomation_GE_OG_Test
Code Coverage          : 
*/
trigger OpportunityTrigger_GE_OG on Opportunity (before update, after update,before insert,after insert,after delete,after undelete) 
{
    
    OpportunityTriggerHandler_GE_OG objTriggerHandler = new OpportunityTriggerHandler_GE_OG();
    AddOpportunityToAsset_GE_OG addoptytoAsset = new AddOpportunityToAsset_GE_OG();
    
    Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'OpportunityTrigger_GE_OG' limit 1];
    
    boolean isEnabled = true;
    //Kiru - stop running trigger for MMI WS call
    Boolean wscall = MMIDemandWebService.stoptrigger;
    system.debug('wscall===='+wscall);
    if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
    
    if(isEnabled && !wscall){
        if(trigger.isInsert){
            if(trigger.isBefore){
                objTriggerHandler.beforeInsertFunctionality(trigger.new,trigger.oldMap);
                //Added by Madhuri - 25/02
                //objTriggerHandler.beforeUpdateFunctionality(trigger.new,trigger.oldMap);
            }
            if(trigger.isAfter){
                objTriggerHandler.afterInsertFunctionality(trigger.new,trigger.oldMap);
                //added by Harsha C, R-30035
                // addoptytoAsset.after_Insert_Functionality(trigger.new);   
            }
        }
        
        if(trigger.isUpdate){
            if(trigger.isAfter)
            {
                if(trigger.isUpdate){
                    if(CheckRecursion_GE_OG.runOnce()){
                        //objTriggerHandler.afterUpdateFunctionality(trigger.new,trigger.oldMap); 
                        //R-24778 : Above line is commented to modify as below:
                        objTriggerHandler.afterUpdateFunctionality(trigger.new,trigger.oldMap,trigger.old);  
                        
                        //added by Shanu Aggarwal, R-23908
                        for(opportunity opp : trigger.new){
                            system.debug('yyyyyyyyyyyyyyyyyyyy     ' + opp.stagename);
                        }
                        //added by Harsha C, R-30035
                        addoptytoAsset.after_Update_Functionality(trigger.new, trigger.oldMap,Trigger.newmap);
                        //objTriggerHandler.afterupdateeradCreation(Trigger.new,Trigger.newmap,Trigger.oldmap);
                    }
                }
                if(CheckRecursion_GE_OG.eRadCreation())
                    objTriggerHandler.afterupdateeradCreation(Trigger.new,Trigger.newmap,Trigger.oldmap);
                
                if(CheckRecursion_GE_OG.runDeliveryDate()){
                    objTriggerHandler.afterUpdataeDeliveryDateOnOLI(Trigger.new, Trigger.oldmap);
                }
                
            }
            if(trigger.isAfter)
            {
                if(trigger.isInsert || trigger.isUpdate || trigger.isDelete || trigger.isUndelete)
                {
                    objTriggerHandler.oppAmountSummationForAsset(trigger.new,trigger.old,trigger.oldMap);
                }
            }
            if(trigger.isAfter)
            {
                if(trigger.isInsert || trigger.isUpdate|| trigger.isDelete || trigger.isUndelete){
                    system.debug('Entered update part');
                    objTriggerHandler.oppAmountSummationForProject(trigger.new,trigger.old,trigger.oldMap);
                }
            }
            if(trigger.isBefore){
                if(trigger.isUpdate){
                    objTriggerHandler.beforeUpdateFunctionality(trigger.new,trigger.oldMap);
                }
            }   
        }
    }
    else
        System.debug('OpportunityTrigger_GE_OG is disabled via Trigger_Toggle__mdt setting');
}