/*
Class/Trigger Name     : RevenueScheduleTrigger_GE_OG 
Purpose/Overview       : This trigger is called before insert & update of Revenue Schedule records
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-26544
Author                 : Sonali Rathore
Created Date           : 01/16/2018
Test Class Name        : RevenueScheduleTrigger_GE_OG_Test
*/
trigger RevenueScheduleTrigger_GE_OG on Revenue_Schedule_ge_og__c (before insert, before update) {
    
    RevenueScheduleTriggerHandler_GE_OG rsObjTriggerHandler = new RevenueScheduleTriggerHandler_GE_OG();
    
    if(trigger.isbefore)
        if(trigger.isInsert || trigger.isUpdate){
            {
            rsObjTriggerHandler.tierUpdateFunctionality(Trigger.new);
            
        }
    }
    
    
    if(trigger.isbefore)
        if(trigger.isInsert || trigger.isUpdate){
            {
                //This method is to update the Rev Schedule currency to Oppty Currency
                rsObjTriggerHandler.updatecurrecnyoncreateorupdate(Trigger.new);
                
            }
        }
    
}