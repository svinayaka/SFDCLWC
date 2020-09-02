global class batchTechnicianUpdate_ScheduleBatch implements Schedulable{
    
    global void execute(SchedulableContext sc ){
        batchTechnicianUpdate  Techupdatebatch=new batchTechnicianUpdate ();
        Database.executeBatch(Techupdatebatch,10);
        
    }   
}