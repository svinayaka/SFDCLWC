/*
Trigger Name                 - GE_OG_SVMX_Event_Trigger
Object Name                  - SVMXC__SVMX_Event__c 
Created Date                 - 8/11/2014
Description                  - Single Trigger on the Contact object, Uses a Handler Clas GE_OG_SVMX_Event_TriggerHandler
                               All Logic to be processed in the Handler Class or Helper Clases being called from the Handler Class

            ******* DO NOT TOUCH THIS TRIGGER ****  GO TO CLASS GE_OG_SVMX_Event_TriggerHandler AND CALL YOUR CLASS FROM THERE
*/
trigger GE_OG_SVMX_Event_Trigger on SVMXC__SVMX_Event__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {

    GE_OG_SVMX_Event_TriggerHandler handler = new GE_OG_SVMX_Event_TriggerHandler ();

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
        handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap);
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

    /* Calls to this method are moved into the handler class  tied to R-24188
     Code written by Subsea for tech assignment for ServiceMax Event
    if(Trigger.isAfter)
        if (trigger.isInsert || trigger.isUpdate || trigger.isDelete)
            GE_SS_Tech_Assignment.manageTechAssignments (Trigger.new, Trigger.oldMap, Trigger.isInsert, Trigger.isUpdate, Trigger.isDelete);
    */
    
    
}