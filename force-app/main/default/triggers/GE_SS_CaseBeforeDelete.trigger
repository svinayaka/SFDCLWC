trigger GE_SS_CaseBeforeDelete on SVMXC__Case_Line__c (before delete) {
    if(Trigger.isDelete)
        SVMXC_CaseLinesAfter.syncWOLineswithCaseLinesDelete(Trigger.old);
}