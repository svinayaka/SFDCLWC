trigger PRM_ChannelAppointmentApprover_Tigger on PRM_Channel_Appointment_Approver__c (before insert, before update, after insert, after update) 
{
    if(Trigger.isBefore && Trigger.isInsert)
    {
        PRM_ApproversTriggerHandler.handleApproverBeforeInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        PRM_ApproversTriggerHandler.handleApproverBeforeUpdate(Trigger.oldMap,Trigger.newMap);
    }
    
    if(Trigger.isAfter && Trigger.isInsert)
    {
        PRM_ApproversTriggerHandler.handleAfterInsert(Trigger.newMap);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        PRM_ApproversTriggerHandler.handleAfterUpdate(Trigger.newMap);
    }
}