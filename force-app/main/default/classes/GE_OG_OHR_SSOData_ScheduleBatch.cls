global class GE_OG_OHR_SSOData_ScheduleBatch implements Schedulable{
    
    global void execute(SchedulableContext sc ){
        batchUsrUpdate batch = new batchUsrUpdate();
        Database.executeBatch(batch, 10);
    }   
}