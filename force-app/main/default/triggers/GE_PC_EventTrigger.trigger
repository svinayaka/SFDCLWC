/*
Trigger Name                 - GE_PC_EventTrigger
Object Name                  - Event
Created Date                 - 02/24/2015
Description                  - Trigger for PC business, Uses a Handler Class GE_OG_PC_EventTriggerHandler
                               All Logic to be processed in the Handler Class or Helper Class being called from the Handler Class
*/
trigger GE_PC_EventTrigger on Event (after delete, after insert, after undelete, after update, before delete, before insert, before update) {

    GE_PC_EventTriggerHandler handler = new GE_PC_EventTriggerHandler();

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