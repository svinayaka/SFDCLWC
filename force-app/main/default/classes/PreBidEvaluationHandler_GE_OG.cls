/*
Class/Trigger Name     : PreBidEvaluationHandler_GE_OG
Used Where ?           : OpportunityTriggerHandler_GE_OG class
Purpose/Overview       : Used for creating pre bid evaluation record 
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-23666
Author                 : Sanath Kumar Dheram
Created Date           : 29/OCT/2015
Test Class Name        : 
Code Coverage          : 
*/
public without sharing class PreBidEvaluationHandler_GE_OG 
{
    // Method to create new pre bid records
    public void createPreBidRecord(List<Opportunity> lstNewOpportunity)
    {
        List<Pre_Bid_ge_og__c> lstPreBidToInsert = new List<Pre_Bid_ge_og__c>();
        
        // Create data for pre bid from opportunity
        for(Opportunity objOpportunity:lstNewOpportunity)
        {
            lstPreBidToInsert.add
            (
                new Pre_Bid_ge_og__c
                (
                    pre_bid_active_ge_og__c = true, pre_bid_opportunity_ge_og__c = objOpportunity.Id, pre_bid_status_ge_og__c = 'Pending'
                )
            );
        }
        
        // insert pre bid
        if(!lstPreBidToInsert.isEmpty())
            insert lstPreBidToInsert;
        
        if(!lstPreBidToInsert.isEmpty())
            createPreBidEvaluationRecord(lstPreBidToInsert);
    }
    
    // Method to create new pre bid evaluation records
    private void createPreBidEvaluationRecord(List<Pre_Bid_ge_og__c> lstPreBidInserted)
    {
        List<Pre_Bid_Evaluation_ge_og__c> lstPreBidEvaluationToInsert = new List<Pre_Bid_Evaluation_ge_og__c>();
          
         Id accId = Id.ValueOf(System.Label.GE_Oil_Gas);
         
        for(Pre_Bid_ge_og__c objPreBid:lstPreBidInserted)
        {
            lstPreBidEvaluationToInsert.add(new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = objPreBid.Id, ge_record_ge_og__c = true,
                    entity_ge_og__c = accId));
        }
        
        if(!lstPreBidEvaluationToInsert.isEmpty())
           insert lstPreBidEvaluationToInsert;  
    }
    
    // Method to prevent deletion of Pre_Bid_Evaluation_ge_og__c record  with  ge_record_ge_og__c = true
    public void preventDeletionOfGERecord(List<Pre_Bid_Evaluation_ge_og__c> lstPreBidEvaluation)
    {
        Map<Id,Boolean> mapPreBidEvaluationIdToPreBidActive = new Map<Id,Boolean>();
        Map<Id,String> mapPreBidEvaluationIdToPreBidStatus = new Map<Id,String>();
        
        // Query since parent fieldfsd cannot be directly fetched from trigger.new values
        for(Pre_Bid_Evaluation_ge_og__c objPreBidEvaluation:[SELECT Id,pre_bid_name_ge_og__r.pre_bid_active_ge_og__c, pre_bid_name_ge_og__r.pre_bid_status_ge_og__c
                                                             FROM Pre_Bid_Evaluation_ge_og__c
                                                             WHERE ID IN:lstPreBidEvaluation])
        {
            mapPreBidEvaluationIdToPreBidActive.put(objPreBidEvaluation.Id, objPreBidEvaluation.pre_bid_name_ge_og__r.pre_bid_active_ge_og__c);
            mapPreBidEvaluationIdToPreBidStatus.put(objPreBidEvaluation.Id, objPreBidEvaluation.pre_bid_name_ge_og__r.pre_bid_status_ge_og__c);
        }
        
        
        for(Pre_Bid_Evaluation_ge_og__c objPreBidEvaluation:lstPreBidEvaluation)
        {
            if(mapPreBidEvaluationIdToPreBidActive.containskey(objPreBidEvaluation.Id) && mapPreBidEvaluationIdToPreBidActive.get(objPreBidEvaluation.Id) == true
               && mapPreBidEvaluationIdToPreBidStatus.containskey(objPreBidEvaluation.Id) && mapPreBidEvaluationIdToPreBidStatus.get(objPreBidEvaluation.Id) == 'Pending'
               && objPreBidEvaluation.ge_record_ge_og__c)
            {
                objPreBidEvaluation.addError('Cannot Delete GE Record');
            }
        }
    }
}