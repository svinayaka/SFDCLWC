global with sharing class GE_OG_MC_POnotReceivedAlertScheduler implements Schedulable{
    public static String sched = '0 0 1 * * ?';  
    
    global static String scheduleGE_OG_MC_POnotReceivedAlert() {
        GE_OG_MC_POnotReceivedAlertScheduler schedule= new GE_OG_MC_POnotReceivedAlertScheduler(); 
        return System.schedule('My batch Job', sched, schedule);
    }
    
    global void execute(SchedulableContext sc) {
        
        GE_OG_MC_POnotReceivedAlert PO= new GE_OG_MC_POnotReceivedAlert();
        ID batchprocessid = Database.executeBatch(PO,10);           
    }
}