global class GE_OG_scheduledOfflineopptyUpdate implements Schedulable 
{
    global void execute(SchedulableContext SC) 
    {
       //MODIFIED THE CODE AS PART OF BUG 0000025574 ADDED A NEW CLASS GE_OG_OpptyMaxUpdateBatch
       GE_OG_OpptyMaxUpdateBatch opptyBatch = new GE_OG_OpptyMaxUpdateBatch();
       Database.executeBatch(opptyBatch,50);
               
    }
}