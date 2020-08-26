trigger SVMXC_AfterInsertUpdateDelete_CaseLines on SVMXC__Case_Line__c (after delete, after insert, after update, before delete) {
    // for Marge before and after trigger in one trigger me(Sharad) adding this if clause for checking the contest of running this trigger
    if(Trigger.isAfter)
    {
        //Begin Subsea Code
        Map<Id, Schema.RecordTypeInfo> clRecordType = Schema.SObjectType.SVMXC__Case_Line__c.getRecordTypeInfosById(); 
        Set<String> subSeaRecordTypes = new Set<String>();
        subSeaRecordTypes.add('Spares');
        
        if (Trigger.isInsert || Trigger.isUpdate) {
                
            List<SVMXC__Case_Line__c> subSeaRecordsList = new List<SVMXC__Case_Line__c>();
            Set<Id> IPSet = new Set<Id>();
            Map<Id, String> subSeaRTLookupMap = new Map<Id, String>();
                      
            for (SVMXC__Case_Line__c cl : Trigger.new) {
                RecordTypeInfo recTypeInfo = clRecordType.get(cl.recordTypeId);
                
                if (recTypeInfo != null && subSeaRecordTypes.contains(recTypeInfo.getName()) && cl.GE_SS_Serial_Number__c != null) {
                    
                    subSeaRecordsList.add(cl);
                    if (!IPSet.contains(cl.GE_SS_Serial_Number__c))
                        IPSet.add(cl.GE_SS_Serial_Number__c);    
                    subSeaRTLookupMap.put(cl.Id, recTypeInfo.getName());        
                }
            }
            
            if (!subSeaRecordsList.isEmpty()) {
                SVMXC_CaseLinesAfter.syncCaseLineswithIP(subSeaRecordsList, trigger.oldMap, Trigger.isInsert, Trigger.isUpdate, IPSet, subSeaRTLookupMap);
            }
        }
        
        if(Trigger.isUpdate)
            SVMXC_CaseLinesAfter.syncWOLineswithCaseLines(Trigger.new);
            
        if(Trigger.isInsert)
            SVMXC_CaseLinesAfter.syncWOLineswithCaseLinesInsert(Trigger.new);
            
        if(Trigger.isInsert || Trigger.isUpdate)
            SVMXC_CaseLinesAfter.updateFSProjectInIB(Trigger.new);
    }
    if(Trigger.isBefore)
    {
        if(Trigger.isDelete)
        SVMXC_CaseLinesAfter.syncWOLineswithCaseLinesDelete(Trigger.old);
    }
}