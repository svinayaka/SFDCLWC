trigger CSMC_feed_on_accountplanning on Customer_Strategy_Map_Contacts__c (after insert , after delete) {
 
    if(trigger.isinsert) 
   {
  
    String sObjName = trigger.new.getSObjectType().getDescribe().getName();
    ChatterfeedUtility1.Feed_on_insert(trigger.new , sObjName ) ;
    }

 
       if(trigger.isdelete) 
    {
   String sObjName = trigger.old.getSObjectType().getDescribe().getName();
   system.debug('&&&&&&&&&&&'+sObjName );
   ChatterfeedUtility1.Feed_on_delete(trigger.old , sObjName ) ;
    }
    
 }