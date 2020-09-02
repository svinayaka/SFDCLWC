global class privatereportsdelete_Schedule implements System.Schedulable {
    global void execute(SchedulableContext SC) {
        privatereportsdelete sch = new privatereportsdelete();
        database.executeBatch(sch);
        
    }
}