trigger SVMXC_BeforeInsertUpdate_TimeEntry on SVMXC_Time_Entry__c (before insert, before update, before delete)
{
      
    //SYSTEM.debug ('CP^0-Entering TE overlap check');
    ServiceMaxTimesheetUtils.checkForTimeEntryOverlap(trigger.new,trigger.oldMap);
    ServiceMaxTimesheetUtils.updateTimeEntryTotal(trigger.new);
    ServiceMaxTimesheetUtils.updateTimesheetOnEntries(trigger.new);
    
}