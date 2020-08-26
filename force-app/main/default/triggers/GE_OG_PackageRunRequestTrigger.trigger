trigger GE_OG_PackageRunRequestTrigger on Package_Run_Request__c (before insert, after insert) {

	/* Before Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        //GE_OG_PackageRunRequestHandler.disableSMaxTrigger(Trigger.new, false);
        GE_OG_PackageRunRequestHandler.runPackageLicenseBatchJob(Trigger.new);
    }
    
    
}