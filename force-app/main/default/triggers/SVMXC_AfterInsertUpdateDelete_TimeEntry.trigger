trigger SVMXC_AfterInsertUpdateDelete_TimeEntry on SVMXC_Time_Entry__c (after delete, after insert, after update) {

    if (trigger.isDelete)
    {
        ServiceMaxTimesheetUtils.updateTimesheetTotals(trigger.old);
        ServiceMaxTimesheetUtils.updateDailyTimeSummary(trigger.old);
        // comment out related to R-21813  ServiceMaxTimesheetUtils.deleteRelatedEvents(trigger.old);
        // Added for Bug#0000020897
        GE_OG_PC_KronosUtil.calBillableOverTimeHrs(trigger.old);
    }
    else
    {
        ServiceMaxTimesheetUtils.updatetimesheetTotals(trigger.new);
        ServiceMaxTimesheetUtils.updateDailyTimeSummary(trigger.new);
        // comment out related to R-21813  ServiceMaxTimesheetUtils.updateRelatedEvents(trigger.new);
        // Added for Bug#0000020897
        GE_OG_PC_KronosUtil.calBillableOverTimeHrs(trigger.new);
    }
    
}