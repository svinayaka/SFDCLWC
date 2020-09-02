global class massCancelSchedulerClass implements Schedulable {
    global void execute(SchedulableContext sc) {
        Mass_Cancel_Opportunities_Batch b = new Mass_Cancel_Opportunities_Batch(); 
        database.executebatch(b);
    }
}