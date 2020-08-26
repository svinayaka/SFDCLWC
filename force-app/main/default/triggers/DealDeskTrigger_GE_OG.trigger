/*
Class/Trigger Name     : DealDeskTrigger_GE_OG
Purpose/Overview       : This trigger is called after insert of Deal_Desk_ge_og__c records
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23281
Author                 : Sanath Kumar Dheram
Created Date           : 16/SEP/2015
Test Class Name        : CreateDealDesk_GE_OG_Test
Code Coverage          : 100%
*/
trigger DealDeskTrigger_GE_OG on Deal_Desk_ge_og__c (before insert, before update, after insert,after update) 
{
    DealDeskTriggerHandler_GE_OG objTriggerHandler = new DealDeskTriggerHandler_GE_OG();
    
    if(trigger.isAfter)
    {
        /*  if(trigger.isInsert)
            objTriggerHandler.afterInsertProcess(trigger.new); */
        if(trigger.isUpdate && CheckRecursion_GE_OG.dealDeskRecusrion())
            objTriggerHandler.afterUpdateProcess(trigger.new,trigger.oldMap);
    }
    if(trigger.isBefore)
    {
        if(trigger.isInsert)
            objTriggerHandler.beforeInsertProcess(trigger.new,trigger.oldMap);
        if(trigger.isUpdate)
        {
            //objTriggerHandler.beforeUpdateProcess(trigger.new,trigger.oldMap);
        }
    }
}