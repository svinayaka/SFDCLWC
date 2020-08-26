trigger ContractAmendTrigger on Contract_Amendment_GEOG__c(after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
    ContractAmendTriggerHandler handler = new ContractAmendTriggerHandler();
    
    if(Trigger.isInsert && Trigger.isBefore){
        //handler.OnBeforeInsert(Trigger.new);
    }
    else if(Trigger.isInsert && Trigger.isAfter){
        handler.OnAfterInsert(Trigger.new,Trigger.oldMap);
        
    }
    
    else if(Trigger.isUpdate && Trigger.isBefore){
         if(Trigger.new[0].Contract_Record_Type_Name__c != 'Deal Machine Contract') 
        handler.OnBeforeDelete(Trigger.new, Trigger.OldMap);
    }
    else if(Trigger.isUpdate && Trigger.isAfter){
        handler.OnAfterInsert(Trigger.new,Trigger.oldMap);
       
    }
    
    else if(Trigger.isDelete && Trigger.isBefore){
        if(Trigger.old[0].Contract_Record_Type_Name__c != 'Deal Machine Contract') 
        handler.OnBeforeDelete(Trigger.old, Trigger.OldMap);
    }
    else if(Trigger.isDelete && Trigger.isAfter){
        //handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
        handler.OnAfterInsert(Trigger.old,Trigger.OldMap);
        
    }
    
    else if(Trigger.isUnDelete){
        //handler.OnUndelete(Trigger.new);    
    }
}