trigger GE_DS_Timesheet on SVMXC_Timesheet__c (after update) {
    
    ServiceMaxTimesheetUtils.submitTimesheet(trigger.new, trigger.oldMap, trigger.isInsert);
    ServiceMaxTimesheetUtils.approvedTimesheet(trigger.new, trigger.oldMap, trigger.isInsert);

}