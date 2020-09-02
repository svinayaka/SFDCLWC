/*
    This class deletes all the Sync Request and SVMX Job Logs records created during the 
    Incremental data sync 
    Initial Sync 
    Config Sync
*/
global class INTF_MobileSyncRequestScheduler implements Schedulable
{
    global void execute(SchedulableContext scScheduler)
    {
    	INTF_MobileSyncRequestCleanUp objCleanUp = new INTF_MobileSyncRequestCleanUp(); 
		Database.executebatch(objCleanUp, 2000);
    }
}