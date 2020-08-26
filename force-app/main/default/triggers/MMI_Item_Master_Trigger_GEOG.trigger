trigger MMI_Item_Master_Trigger_GEOG on MMI_Item_Master_ge_og__c (before Insert, before update, after Insert, after Update) {

/*
Class/Trigger Name     : MMI_Item_Master_Trigger_GEOG
Scrum Team             : GRID - MMI
Author                 : Geetha Karmarkar
Created Date           : 27/06/2018
Code Coverage          : 
*/
    MMI_Item_Master_TriggerHandler_GE_OG objTriggerHandler = new MMI_Item_Master_TriggerHandler_GE_OG();
    
    if(trigger.isInsert){
      if(trigger.isBefore){
          objTriggerHandler.beforeInsertCall(trigger.new);
      }  
      if(trigger.isAfter){
          objTriggerHandler.afterInsertCall();
      }
    }
    
    if(trigger.isUpdate){
        if(trigger.isBefore){
          objTriggerHandler.beforeUpdateCall(trigger.new,trigger.oldMap);
      }  
      if(trigger.isAfter){
          objTriggerHandler.afterUpdateCall();
      }
    }
    
}