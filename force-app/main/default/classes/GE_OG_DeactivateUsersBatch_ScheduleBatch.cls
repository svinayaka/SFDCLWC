global class GE_OG_DeactivateUsersBatch_ScheduleBatch implements Schedulable{
    
    global void execute(SchedulableContext sc ){
        GE_OG_DeactivateUsersBatch OGDB=new GE_OG_DeactivateUsersBatch();
        Database.executeBatch(OGDB,50);
        
    }   
}