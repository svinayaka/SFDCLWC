trigger ReparentingRequestTrigger on Re_Parenting_LE_Request__c (after update) 
{
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        ReparentingRequestTriggerHandler.handleAfterUpdate(Trigger.New);
    }
}