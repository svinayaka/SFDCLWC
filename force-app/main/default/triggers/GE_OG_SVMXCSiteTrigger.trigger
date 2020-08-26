/*
Trigger Name                 - GE_OG_SVMXCSiteTrigger 
Object Name                  - SVMXC__Site__c 
Created Date                 - 04-Oct-2016
Description                  - Trigger on the Location object, Uses a Handler Clas GE_OG_SVMXCServiceOrderTriggerHandler
                               All Logic to be processed in the Handler Class or Helper Clases being called from the Handler Class
*/
trigger GE_OG_SVMXCSiteTrigger on SVMXC__Site__c (before insert, before update) {

    GE_OG_SVMXCSiteTriggerHandler handler = new GE_OG_SVMXCSiteTriggerHandler();
    
    
/* After Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        handler.OnBeforeInsert(Trigger.new);
    }
    
    
 /* After Update */
   else if(Trigger.isUpdate && Trigger.isBefore){
        handler.OnBeforeUpdate(Trigger.new);
    }  

}