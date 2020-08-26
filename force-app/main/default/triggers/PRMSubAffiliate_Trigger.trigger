trigger PRMSubAffiliate_Trigger on PRM_Sub_Affiliate__c (after insert,after update) {
    PRMSubAffiliateHandler prm_subAff = new PRMSubAffiliateHandler();
    
    if(trigger.isInsert){
        if(trigger.isAfter){
            prm_subAff.subAffiliateOnInsert(trigger.new);
        }
    }
    
    if(trigger.isUpdate){
        if(trigger.isAfter){
            prm_subAff.subAffiliateBranchUpdate(trigger.new,trigger.oldMap);
            prm_subAff.subAffiliateDealerUpdate(trigger.new,trigger.oldMap);
        }
    }
}