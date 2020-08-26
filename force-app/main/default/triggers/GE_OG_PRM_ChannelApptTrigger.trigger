/*
Trigger Name                 - GE_OG_PRM_ChannelApptTrigger
Object Name                  - Channel Appointmnet
Created Date                 - 7/23/2014
Testclass                    - Test_PRM_Oldclasses
Description                  - Single Trigger on the Channel Appointmnet object, Uses a Handler Class GE_OG_PRM_TriggerHandler
                               All Logic to be processed in the Handler Class or Helper Clases being called from the Handler Class
*/

trigger GE_OG_PRM_ChannelApptTrigger on GE_PRM_Channel_Appointment__c (after delete, after insert, after undelete, after update, before delete, before insert, before update)
 
 {
 GE_OG_PRM_TriggerHandler  handler =new GE_OG_PRM_TriggerHandler ();
 GE_PRM_GenerateContracts trghndler =new GE_PRM_GenerateContracts();
 /* Before Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        handler.OnBeforeInsert(Trigger.new);
    }
    /* After Insert */
    if(Trigger.isInsert && Trigger.isAfter){
        handler.OnAfterInsert(Trigger.new);
       // handler.updateIPIPOnLEAccount(trigger.new, trigger.oldMap);
       // handler.updateWasEverHigh(trigger.new, trigger.oldMap);
       }
    /* Before Update */
    if(Trigger.isUpdate && Trigger.isBefore){
        handler.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap);
    }
    /* After Update */
    if(Trigger.isUpdate && Trigger.isAfter){
        handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.oldMap);
        trghndler.updatecontract1(Trigger.New);
        handler.updateWasEverHigh(trigger.new, trigger.oldMap);
        handler.updateIPIPOnLEAccount(trigger.new, trigger.oldMap);
     }
    /* Before Delete */
     if(Trigger.isDelete && Trigger.isBefore){
        handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);
    }
    /* After Delete */
     if(Trigger.isDelete && Trigger.isAfter){
        handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
    }
    /* After Undelete */
     if(Trigger.isUnDelete){
        handler.OnUndelete(Trigger.new);
    }

}