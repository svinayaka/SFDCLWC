global with sharing class INTF_MobileSyncRequestCleanUp implements Database.Batchable<sObject>
{
	public string strSyncSOQL = 'Select Id from SVMXC__Sync_Request__c where IsDeleted=false AND LastModifiedDate <=: dtToDelete';
    
    //Query Sync Request Records
	global Database.QueryLocator start(Database.BatchableContext BC)
	{
		DateTime dtToDelete = Datetime.now().addHours(-2);
		system.debug(LoggingLevel.Debug, 'In Start');        
		system.debug(LoggingLevel.Debug, 'Query prepared to delete Sync Request:- ' + strSyncSOQL);
		return Database.getQueryLocator(strSyncSOQL);
    }

	//Execute Delete
	global void execute(Database.BatchableContext BC, List<SVMXC__Sync_Request__c> lstSyncRequestToDelete)
	{
        String toggle;
        try{
        toggle = Label.SMax_Sync_Request_Batch_toggle;
        }
        catch (Exception e){
            System.debug('Cought an exception trying to access the custom label: ' + e.getMessage());
            toggle = 'off';
        }
        if(toggle != null){
            if(toggle == 'on'){
                system.debug(LoggingLevel.Debug, 'In execute');
                system.debug(LoggingLevel.Debug, 'No of records of SVMXC__Sync_Request__c object in current batch  = ' + lstSyncRequestToDelete.size());
                if(lstSyncRequestToDelete != null && lstSyncRequestToDelete.size() > 0){
                    Database.DeleteResult[] delResult = Database.delete(lstSyncRequestToDelete, false);
                    for(Database.DeleteResult eachDelRecord : delResult){
                        if(!eachDelRecord.isSuccess()){
                            system.debug(LoggingLevel.Debug, 'Delete Failed');
                            for(Database.Error err : eachDelRecord.getErrors())
                                system.debug(LoggingLevel.Debug, 'Delete of SVMXC__Sync_Request__c Failed:' + err);
                        }
                    }
                }
            }
            else
                System.debug('Toggle is set to off, not running cleanup');
        }
	}

	global void finish(Database.BatchableContext BC)
	{
		system.debug(LoggingLevel.Debug, 'In finish');
	}
}