trigger DealReviewerTrigger on Deal_Reviewer_ge_og__c (after insert,after update ) {
    
     Assign_O_RiskapproverPS.assignO_RiskApprover_Permission_Set(trigger.new);   
    
}