@isTest(seeAllData = true)
private class INTF_MobileSyncRequestScheduler_UT 
{
    static testMethod void INTF_MobileSchedulerUnitTest()
    {  
        SVMXC__Sync_Request__c syncReq = new SVMXC__Sync_Request__c();
        syncReq.SVMXC__Client_Request_Id__c = 'ABCDEFGHIJKL MNOPQRS TUVWXYZ';
        insert  syncReq;
        
        INTF_MobileSyncRequestScheduler sch = new INTF_MobileSyncRequestScheduler();
        SchedulableContext sc;
        
        system.assert(sch.execute(sc) == null);
        
        INTF_MobileSyncRequestCleanUp batch = new INTF_MobileSyncRequestCleanUp();
        String queryString = 'Select Id from SVMXC__Sync_Request__c where IsDeleted=false AND Id=\'' + syncReq.Id + '\'';
        batch.strSyncSOQL = queryString;
        Database.executebatch(batch);
        
    }
}