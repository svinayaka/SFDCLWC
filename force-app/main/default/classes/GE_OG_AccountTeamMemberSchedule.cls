global class GE_OG_AccountTeamMemberSchedule implements Schedulable 
{
    global boolean isRunForAll= false;
    global void execute(SchedulableContext SC)
    {
        Set<Id> accId = new Set<Id>();
        GE_OG_AccountTeamMemberUpdate_Batch batch = new GE_OG_AccountTeamMemberUpdate_Batch();
        batch.isRunForAll = isRunForAll;
        batch.setAccId = accId;
        database.executeBatch(batch, 10);
    }
}