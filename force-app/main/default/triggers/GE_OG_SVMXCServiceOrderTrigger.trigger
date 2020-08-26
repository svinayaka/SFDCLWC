/*
Trigger Name                 - GE_OG_SVMXCServiceOrderTrigger
Object Name                  - SVMXC__Service_Order__c
Created Date                 - 7/25/2014
Description                  - Single Trigger on the Contact object, Uses a Handler Clas GE_OG_SVMXCServiceOrderTriggerHandler
                               All Logic to be processed in the Handler Class or Helper Clases being called from the Handler Class
*/
trigger GE_OG_SVMXCServiceOrderTrigger on SVMXC__Service_Order__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {

    GE_OG_SVMXCServiceOrderTriggerHandler handler = new GE_OG_SVMXCServiceOrderTriggerHandler();

    /* Before Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        handler.OnBeforeInsert(Trigger.new);
    }
    /* After Insert */
    else if(Trigger.isInsert && Trigger.isAfter){
        handler.OnAfterInsert(Trigger.new);
    }
    /* Before Update */
    else if(Trigger.isUpdate && Trigger.isBefore){
        handler.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap);
    }
    /* After Update */
    else if(Trigger.isUpdate && Trigger.isAfter){
        handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap);
    }
    /* Before Delete */
    else if(Trigger.isDelete && Trigger.isBefore){
        handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);
    }
    /* After Delete */
    else if(Trigger.isDelete && Trigger.isAfter){
        handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
    }

    /* After Undelete */
    else if(Trigger.isUnDelete){
        handler.OnUndelete(Trigger.new);
    }

}