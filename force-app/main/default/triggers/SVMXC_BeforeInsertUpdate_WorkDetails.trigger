trigger SVMXC_BeforeInsertUpdate_WorkDetails on SVMXC__Service_Order_Line__c (before insert, before update,before delete) 
{
    List<SVMXC__Service_Order_Line__c> newList = new List<SVMXC__Service_Order_Line__c>();
    List<SVMXC__Service_Order_Line__c> oldList = new List<SVMXC__Service_Order_Line__c>();
    Set<ID> woIDs = new Set<Id>();
    String inclusiveRecordTypesLabel = Label.GE_DS_Timesheet_Module_Active_Record_Types;
    List<String> listTokenStrings= inclusiveRecordTypesLabel.split(',', 0);
    Set<String> inclusiveRecordTypes = new Set<String>();
    for(String strToken:listTokenStrings)
    {
        inclusiveRecordTypes.add(strToken);
    }
    
    if (trigger.isInsert || trigger.isUpdate)
    {
        for (SVMXC__Service_Order_Line__c sol : Trigger.new)
        {
            woIDs.add(sol.SVMXC__Service_Order__c);
        }
        
        Map<Id, SVMXC__Service_Order__c> woMap = new Map<Id, SVMXC__Service_Order__c>([Select Id, GE_SS_Field__c, GE_SS_Well_ID__c, RecordTypeId, RecordType.Name from SVMXC__Service_Order__c where Id in :woIDs]);
        if (woMap != null)
        {
            for (SVMXC__Service_Order_Line__c sol : Trigger.new)
            {
                if (woMap.get(sol.SVMXC__Service_Order__c) != null && inclusiveRecordTypes.contains(woMap.get(sol.SVMXC__Service_Order__c).RecordType.Name))
                    newList.add(sol);
            }
        }
        
        if (Trigger.isInsert)
        {
           if (!SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPreInsertTimesheets() || System.Test.isRunningTest()) 
           {
                SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPreInsertTimesheets();
                ServiceMaxTimesheetUtils.checkForWorkDetailOverlap(newLIst,trigger.oldMap, woMap);
           }
           GE_SS_Creating_TaskWorkDtls.updateFieldandWellonSSWD(trigger.New, woMap);  //To update Field and Well on mobilize WD from WO for SubSea    
        }
        else if (Trigger.isUpdate)
        {
           //Added as part of R-26304
           GE_OG_WorkDetailTriggerHandler.OnBeforeUpdate(Trigger.new); //END R-26304
           
           if (!SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPreUpdateTimesheets() || System.Test.isRunningTest()) 
           {
                SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPreUpdateTimesheets();
                ServiceMaxTimesheetUtils.checkForWorkDetailOverlap(newLIst,trigger.oldMap, woMap);      
           }
        }
    }

    if (trigger.isDelete)
    {
        set<Id> idList = new set<Id>();
        for(SVMXC__Service_Order_Line__c wd: trigger.old)
        {
          idList.add(wd.id);
        }
        ServiceMaxTimesheetUtils.removeTimesheetEntriesFromWorkDetails(idList);
    }

}