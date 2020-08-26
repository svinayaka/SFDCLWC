/*
Class/Trigger Name     : PreBidTrigger_GE_OG
Purpose/Overview       : This trigger is called after update of Pre_Bid_ge_og__c records
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-23666
Author                 : Sanath Kumar Dheram
Created Date           : 29/OCT/2015
Test Class Name        :  
Code Coverage          : 
*/
trigger PreBidTrigger_GE_OG on Pre_Bid_ge_og__c (after update) 
{
    PreBidTriggerHandler_GE_OG objTriggerHandler = new PreBidTriggerHandler_GE_OG();
    
    if(trigger.isAfter) 
    {
        if(trigger.isUpdate && CheckRecursion_GE_OG.prebidRecursion())
        {
            objTriggerHandler.afterUpdate(trigger.oldMap,trigger.newMap);
        } 
    }
    /*
    if(trigger.isBefore)
    {
        if(trigger.isUpdate)
        {
            objTriggerHandler.beforeUpdate(trigger.oldMap,trigger.newMap);
        } 
    }*/
}