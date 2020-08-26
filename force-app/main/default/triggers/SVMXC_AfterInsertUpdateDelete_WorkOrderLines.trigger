trigger SVMXC_AfterInsertUpdateDelete_WorkOrderLines on SVMXC__Service_Order_Line__c (after insert, after update) {
    if(Trigger.isAfter)
    {  
        if(Trigger.isUpdate)
        {  
            SVMXC_WorkOrderLinesAfter.syncTripWOLineswithMobWOLines(Trigger.new);
            // SVMXC_WorkOrderLinesAfter.updateInstalledProductonWOLineUpdate(Trigger.new); // Commented by NS for 0000026288 and code is merged with SVMXC_WorkOrderLinesAfter.updateFSProjectInIB
             system.debug('entered update trigger');
        } 
        if(Trigger.isInsert)
        {
             SVMXC_WorkOrderLinesAfter.syncWOLineswithMobWOLinesInsert(Trigger.new);
             system.debug('entered insert trigger');
        }
        
        if(Trigger.isInsert || Trigger.isUpdate)
            SVMXC_WorkOrderLinesAfter.updateInstalledProducts(Trigger.new,Trigger.oldMap);
    }    
}