trigger RequestTypeTrigger_GE_OG on GE_ES_Request_Type__c (before insert, before update,after insert) {
    
    RequestType_TriggerHandler_GE_OG requesthandler = new RequestType_TriggerHandler_GE_OG();
    
    if(Trigger.isBefore) {
        if(Trigger.isInsert){
            requesthandler.UpdateEquipementDesc(trigger.new,null);
        } 
        if(Trigger.isUpdate){
            requesthandler.UpdateEquipementDesc(trigger.new,trigger.OldMap);
        }
    }
    if(Trigger.isAfter) {
        if(Trigger.isInsert){
            requesthandler.afterInsertFunctionality(trigger.new);
        }
    }  
}