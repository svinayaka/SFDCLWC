trigger GE_OG_ProductAndPriceBookEnrty on Product2 (after insert,after Update, after Delete, before Update) {
    
  /*  map<id, profile> adminAndDeveloperProfiles = new map<id,profile>([select id, name from profile where name = 'GE_ES Developer' or name = 'System Administrator' or name = 'System Integration GE OG']);
    if (( trigger.isinsert || trigger.isupdate ||trigger.isdelete) && !adminAndDeveloperProfiles.containskey(userinfo.getprofileid() )){
        for (Product2 p: trigger.new)
            p.addError('You have insufficient permissions to create or edit products.');
        return;
    }*/
        
    Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'GE_OG_ProductAndPriceBookEnrty' limit 1];
     boolean isEnabled = true;
     
      if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
        
        if(isEnabled){
    
    // create instance of class 'GE_OG_ProductToProductBookMapping'
    GE_OG_ProductToProductBookMapping objPBEmap = new GE_OG_ProductToProductBookMapping();
    O_MarkDigitalProductOnOLIFalse_GE_OG setdigitalFlagonOLI = new O_MarkDigitalProductOnOLIFalse_GE_OG();
    
    if(trigger.isInsert){
        objPBEmap.ProductBookEntryAutomation(trigger.New,trigger.OldMap,True);           
    }
    if(trigger.IsUpdate && Trigger.isBefore){
        system.debug('Inside GE_OG_ProductAndPriceBookEnrty before update');
        setdigitalFlagonOLI.afterUpdateHandler(trigger.New, trigger.OldMap);
    }
    if(trigger.IsUpdate && Trigger.isAfter){
         if(CheckRecursion_GE_OG.runOnce()){
        objPBEmap.ProductBookEntryAutomation(trigger.New,trigger.OldMap,False);
       // Added by Harsha C for R-31551 -  Stale deal Logic.
              mark_ProductActive_ge_og.markProductActiveOLI(trigger.New);
         }
     
    }
    
    if(trigger.IsDelete){
        objPBEmap.ProductBookEntryAutomationDelete(trigger.Old);
    }
    }
}