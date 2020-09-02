global class deleteTechnicianRecords_ScheduleBatch implements Schedulable{
    
    global void execute(SchedulableContext sc ){
          deleteTechnicianRecords  delBatch = new deleteTechnicianRecords ();
          Database.executeBatch(delBatch,200);
        
    }   
}