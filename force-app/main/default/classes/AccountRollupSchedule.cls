global class AccountRollupSchedule implements Schedulable 
{
    global boolean isRunForAll= false;
    global void execute(SchedulableContext SC) {
       
        batchForAccounts batch = new batchForAccounts();
        batch.isRunForAll = isRunForAll;
        database.executeBatch(batch ,20);
       
    }
}