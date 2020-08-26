/*
Trigger Name                 - GE_OG_AccountTrigger
Object Name                  - Account
Created Date                 - 7/22/2014
Description                  - Single Trigger on the Account object, Uses a Handler Clas GE_OG_AccountTriggerHandler
                               All Logic to be processed in the Handler Class or Helper Clases being called from the Handler Class
*/
trigger GE_OG_AccountTrigger on Account (after delete, after insert, after undelete, after update, before delete, before insert, before update) {

  //Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_OG_AccountTrigger');
       
    if((lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account') || GEOG_SkipTriggerFromClass.Var_GE_OG_AccountTrigger == True){
      
        return;  
    }
    else{
    GE_OG_AccountTriggerHandler handler = new GE_OG_AccountTriggerHandler();

    /* Before Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        handler.OnBeforeInsert(Trigger.new);
    }
    //After Insert
    else if(Trigger.isInsert && Trigger.isAfter){
      handler.OnAfterInsert(Trigger.old, Trigger.new, Trigger.newMap);
        
        
        
    }
    //Before Update
    else if(Trigger.isUpdate && Trigger.isBefore){
        handler.beforeCheckOppty(Trigger.new, Trigger.oldMap);
        handler.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.OldMap);
        //handler.OnBeforeUpdate(Trigger.new);
    }
    //After Update
    else if(Trigger.isUpdate && Trigger.isAfter){
        handler.OnAfterUpdate(Trigger.old, Trigger.new, trigger.oldMap);
    }
   /*
    //Before Delete
    else if(Trigger.isDelete && Trigger.isBefore){
        handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);
    }
    //After Delete
    else if(Trigger.isDelete && Trigger.isAfter){
        handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
    }

    //After Undelete 
    else if(Trigger.isUnDelete){
        handler.OnUndelete(Trigger.new);
     }
  */
    }   
}