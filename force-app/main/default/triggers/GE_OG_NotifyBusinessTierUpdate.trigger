trigger GE_OG_NotifyBusinessTierUpdate on GE_HQ_P_L__c (after insert, after update, after delete) {
    
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            GE_HQ_Get_Region.NotifyUsersOnInsertBusinessTier(Trigger.new);
        } 
        else if(Trigger.isUpdate){
            GE_HQ_Get_Region.NotifyUsersOnUpdateBusinessTier(Trigger.new,Trigger.old);
        }       
        else if(Trigger.isDelete) {
            GE_HQ_Get_Region.NotifyUsersOnDeleteBusinessTier(Trigger.old);
        }
    }
    
}