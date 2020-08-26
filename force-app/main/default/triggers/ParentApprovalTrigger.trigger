trigger ParentApprovalTrigger on PRM_Channel_Appointment_Parent_Approval__c (before insert, before update, after insert, after update) {
    
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        PRM_ApproversTriggerHandler.handleParentBeforeUpdate(Trigger.newMap);
        
    }
    
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        PRM_ApproversTriggerHandler.handleParentStatusOnUpdate(Trigger.newMap, Trigger.oldMap);
    }
    
   /** if(Trigger.isAfter && Trigger.isUpdate)
    {
        //PRM_ApproversTriggerHandler.handleParentAfterUpdate(Trigger.New);
    } **/
}