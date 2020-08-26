trigger GE_OG_Task_Trigger on Task (before insert,before update,before delete,after insert,after update,after delete) {
    GE_OG_Task_TriggerHandlerManager triggerhandler = new GE_OG_Task_TriggerHandlerManager ();
    
     /* Before Insert */
    if(Trigger.isInsert && Trigger.isBefore){
        triggerhandler.setRelatedObject(trigger.new);
        //triggerhandler.checkMCTSCaseStatus(trigger.new);
    }
    
      
    
    /* After Update */
    if(Trigger.isupdate && Trigger.isafter) 
    {
        triggerhandler.afterupdatciremailalert(trigger.new,trigger.oldmap);
    }
    
    /* After Insert */
    if(Trigger.isInsert && Trigger.isAfter) {
    // below line commented by Avinash Choubey as this functionality is already implemented in GEOGCIRTaskforecastUpdate Trigger
       // triggerhandler.afterinsertforecastupdate(trigger.new);
        triggerhandler.afterinsertsendemail(Trigger.newMap);

        // Method is related to R-25011 to block non secure related attachments
        triggerhandler.validateAttachments(Trigger.new);
        
        //added for R-28937
        triggerhandler.afterinsertpostchatter(Trigger.newMap);
        

    }
    
    /* Before Update */
    if(Trigger.isUpdate && Trigger.isBefore) {
    }
    
    /* After Update */
    if(Trigger.isUpdate && Trigger.isAfter) {
    // below line commented by Avinash Choubey as this functionality is already implemented in GEOGCIRTaskforecastUpdate Trigger
       // triggerhandler.afterupdateforecastupdate(trigger.new,trigger.oldmap);
        triggerhandler.afterupdatesendemail(Trigger.oldMap,Trigger.newMap);
        triggerhandler.afterUpdateTskStatusChangngMailToOwner(Trigger.New,Trigger.newMap,Trigger.oldMap);

        // Method is related to R-25011 to block non secure related attachments
        triggerhandler.validateAttachments(Trigger.new);
    }
    
  /* Before Delete */
    if(Trigger.isDelete && Trigger.isBefore) {
    //Added by Kiru for R-29632
    
    triggerhandler.beforedelete(Trigger.old, trigger.oldmap);
    
    }
    
    /* After Delete */
    if(Trigger.isDelete && Trigger.isAfter) {
    }
}