Public class GE_OG_WorkDetailTriggerHandler{
    public static void OnBeforeInsert(List<SVMXC__Service_Order_Line__c> newObjects){
    }
    
    public static void OnAfterInsert(List<SVMXC__Service_Order_Line__c> newObjects){
    }    
    public static void OnBeforeUpdate(List<SVMXC__Service_Order_Line__c> newObjects){
        Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        List<SVMXC__Service_Order_Line__c> wdlbrlst = new List<SVMXC__Service_Order_Line__c>();
        Set<ID> woIDs = new Set<Id>();
        for (SVMXC__Service_Order_Line__c sol : newObjects){
            woIDs.add(sol.SVMXC__Service_Order__c);
        }
        
        Map<Id, SVMXC__Service_Order__c> woMap = new Map<Id, SVMXC__Service_Order__c>([Select Id, RecordTypeId, RecordType.Name from SVMXC__Service_Order__c where Id in :woIDs]);
        
        for(SVMXC__Service_Order_Line__c newlbr : newObjects){
            //If condition modified as a part of R-30043
            if(woMap.get(newlbr.SVMXC__Service_Order__c) != null && woMap.get(newlbr.SVMXC__Service_Order__c).RecordTypeId==rtWOId
               && newlbr.SVMXC__Line_Type__c=='Labor'){
                wdlbrlst.add(newlbr);
            }
        }      
        
        GE_SS_Creating_TaskWorkDtls.updateCalculation(wdlbrlst);
    }
    
    public static void OnAfterUpdate(List<SVMXC__Service_Order_Line__c> oldObjects, List<SVMXC__Service_Order_Line__c> newObjects, Map<Id, SVMXC__Service_Order_Line__c> newObjectMap){
    }
    
    public static void OnBeforeDelete(List<SVMXC__Service_Order_Line__c> ObjectsToDelete){
        
        //Below Code is Added for the Subsea - R-29773
        Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        Id drlrtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
        Id rtESTMId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId();
        ID drlWdrt=Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Drilling RecordType').getRecordTypeId();
        List<SVMXC__Service_Order_Line__c> wdlbrlst = new List<SVMXC__Service_Order_Line__c>();
        List<SVMXC__Service_Order_Line__c> drlwdlbrlst = new List<SVMXC__Service_Order_Line__c>();
        Set<ID> woIDs = new Set<Id>();
        for (SVMXC__Service_Order_Line__c sol : ObjectsToDelete){
            woIDs.add(sol.SVMXC__Service_Order__c);
        }
        
        Map<Id, SVMXC__Service_Order__c> woMap = new Map<Id, SVMXC__Service_Order__c>([Select Id, RecordTypeId, RecordType.Name from SVMXC__Service_Order__c where Id in :woIDs]);
        
        for(SVMXC__Service_Order_Line__c newlbr : ObjectsToDelete){
            if(woMap.get(newlbr.SVMXC__Service_Order__c) != null && woMap.get(newlbr.SVMXC__Service_Order__c).RecordTypeId==rtWOId && newlbr.SVMXC__Line_Type__c=='Labor' && newlbr.RecordTypeId==rtESTMId ){
                wdlbrlst.add(newlbr);
            }
            //Added below if as part of R-29684
            if(woMap.get(newlbr.SVMXC__Service_Order__c) != null && woMap.get(newlbr.SVMXC__Service_Order__c).RecordTypeId==drlrtWOId && newlbr.SVMXC__Line_Type__c=='Labor' && newlbr.RecordTypeId==drlWdrt){
              drlwdlbrlst.add(newlbr);
            }//END of R-29684
        }                             
        GE_SS_Creating_TaskWorkDtls.deleteTaskWL(wdlbrlst);  
        //Ended code for Subsea - R-29773 
        
        GE_DS_WO_LinesUpdate.deleteTasklines(drlwdlbrlst); //Added as part of R-29684

    }
    
    
    public void OnAfterDelete(List<SVMXC__Service_Order_Line__c> deletedObjects, Map<Id, SVMXC__Service_Order_Line__c> oldObjectMap){
        // AFTER DELETE LOGIC
    }
    
    public void OnUndelete(List<SVMXC__Service_Order_Line__c> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
    
}