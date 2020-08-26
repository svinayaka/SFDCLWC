/*
Trigger Name                 - GE_OG_User_Trigger
Object Name                  - User
Created Date                 - 8/11/2014
Description                  - Single Trigger on the User object, Uses a Handler Clas GE_OG_User_TriggerHandler
                               All Logic to be processed in the Handler Class or Helper Clases being called from the Handler Class
*/
trigger GE_OG_User_Trigger on User (after delete, after insert, after undelete, after update, before delete, before insert, before update) {

 
    GE_OG_User_TriggerHandler handler = new GE_OG_User_TriggerHandler();
    
// added for R-26652
    
    if(trigger.isBefore ){
           if(trigger.isInsert ){
              handler.updateRegionOnUser(trigger.new);
           }
       }
       
       if(trigger.isBefore ){
           if(trigger.isUpdate){
      handler.updateRegionOnUser(trigger.new);
           }
       }

    // Sean to Add If condition to check for a Custom Label that is set to True or False (Text).  If True, run the code, else don't run the code and print a Debug Statement
    // Create a custom Label called User Trigger Toggle
    // The Value will be text and put True for now
    
    // System.label(UserTriggerToggle) == 'True'
    
    /* Before Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        handler.OnBeforeInsert(Trigger.new);
        
        
    }
    /* After Insert */
    else if(Trigger.isInsert && Trigger.isAfter){
        handler.OnAfterInsert(Trigger.new);
        
        
    }
        
    // Before Update 
    else if(Trigger.isUpdate && Trigger.isBefore){
        handler.OnBeforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        
        
    }

    // After Update
    else if(Trigger.isUpdate && Trigger.isAfter){
        handler.OnAfterUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
       
    }
    /* uncomment as needed
    // Before Delete
    else if(Trigger.isDelete && Trigger.isBefore){
        handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);
    }
    // After Delete
    else if(Trigger.isDelete && Trigger.isAfter){
        handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
    }

    // After Undelete
    else if(Trigger.isUnDelete){
        handler.OnUndelete(Trigger.new);
    }

    */

}