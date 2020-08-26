/*
Trigger Name                 - GE_AL_PullTrigger
Object Name                  - P__c
Created Date                 - 9/1/2016
Description                  - Single Trigger on the Pull object, Uses a Handler Clas GE_AL_PullTriggerHandler
                               All Logic to be processed in the Handler Class or Helper Clases being called from the Handler Class
Test Class                   -                               
*/

trigger GE_AL_PullTrigger on P__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
 GE_AL_PullTriggerHandler handler = new GE_AL_PullTriggerHandler();

    /* Before Insert */
   /*if(Trigger.isInsert && Trigger.isBefore){
        handler.OnBeforeInsert(Trigger.new);
    }*/
    /* After Insert */
    if(Trigger.isInsert && Trigger.isAfter){
        handler.OnAfterInsert(Trigger.new);
    }
    /* Before Update */
   /* else if(Trigger.isUpdate && Trigger.isBefore){
        handler.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap);
    }*/
    /* After Update */
   /* else if(Trigger.isUpdate && Trigger.isAfter){
        handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap);
    }*/
    /* Before Delete */
   /* else if(Trigger.isDelete && Trigger.isBefore){
        handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);
    }*/
    /* After Delete */
   /* else if(Trigger.isDelete && Trigger.isAfter){
        handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
    }*/

    /* After Undelete */
    /*else if(Trigger.isUnDelete){
        handler.OnUndelete(Trigger.new);
    }*/
}