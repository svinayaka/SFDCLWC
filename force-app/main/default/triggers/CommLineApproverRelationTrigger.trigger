trigger CommLineApproverRelationTrigger on Commercial_Line_Apporver_Relation__c (after update) 
{
    if(Trigger.isAfter && Trigger.isUpdate)
    {
        PRM_ApproversTriggerHandler.handleJunctionObjectAfterUpdate(Trigger.New);
    }
}