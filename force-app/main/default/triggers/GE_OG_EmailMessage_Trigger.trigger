/*
Trigger Name                 - GE_OG_EmailMessage_Trigger
Object Name                  - EmailMessage
Created Date                 - 3/29/2016
Description                  - Single Trigger on the EmailMessage object, Uses a Handler Clas GE_OG_EmailMessageTrigger_Handler
                               DON'T PUT ANY LOGIC OR NEW METHOD CALLS IN THIS TRIGGER
Related to:		R-24487
*/
trigger GE_OG_EmailMessage_Trigger on EmailMessage (before insert) {

    GE_OG_EmailMessageTrigger_Handler handler = new GE_OG_EmailMessageTrigger_Handler();

    /* Before Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        handler.OnBeforeInsert(Trigger.new);
    }
/*   After Insert 
    else if(Trigger.isInsert && Trigger.isAfter){
        handler.OnAfterInsert(Trigger.new);
    }    
     Before Delete 
    else if(Trigger.isDelete && Trigger.isBefore){
        handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);
    }
     After Delete 
    else if(Trigger.isDelete && Trigger.isAfter){
        handler.OnAfterDelete(Trigger.old, Trigger.oldMap);
    }

     After Undelete
    else if(Trigger.isUnDelete){
        handler.OnUndelete(Trigger.new);
    }
*/
}