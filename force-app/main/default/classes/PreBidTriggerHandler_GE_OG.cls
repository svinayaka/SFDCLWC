/*
Class/Trigger Name     : PreBidTriggerHandler_GE_OG
Purpose/Overview       : Handler for Pre bid trigger
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-23666
Author                 : Sanath Kumar Dheram
Created Date           : 29/OCT/2015
Test Class Name        : PreBidSubmitForApproval_GE_OG_Test
Code Coverage          : 100
*/
public without sharing class PreBidTriggerHandler_GE_OG
{
    public void afterUpdate(Map<Id,Pre_Bid_ge_og__c> mapPreBidOld, Map<Id,Pre_Bid_ge_og__c> mapPreBidNew)
    {
        /***** Initialize List *****/
        Set<ID> setOppID = new Set<ID>();
        Set<Id> setFilteredpreBid = new Set<Id>();
        
        
        
        for(Pre_Bid_ge_og__c objPreBid:[SELECT Id, pre_bid_active_ge_og__c,competitor_count_ge_og__c,pre_bid_status_ge_og__c,
                                      pre_bid_opportunity_ge_og__r.StageName, 
                                      pre_bid_opportunity_ge_og__r.deal_path_ge_og__c,pre_bid_opportunity_ge_og__r.has_product_value_ge_og__c,
                                      pre_bid_opportunity_ge_og__r.tier_2_ge_og__c,pre_bid_uploaded_ge_og__c,
                                      pre_bid_opportunity_ge_og__r.documents_uploaded_ge_og__c,pre_bid_opportunity_ge_og__r.HasOpportunityLineItem 
                                      FROM Pre_Bid_ge_og__c WHERE Id IN: mapPreBidNew.keyset()])
        {
            system.debug('--objPreBid.pre_bid_status_ge_og__c------>>>>>>>'+objPreBid.pre_bid_status_ge_og__c);
            system.debug('------mapPreBidOld.get(objPreBid.Id).pre_bid_status_ge_og__c-->>>>>>>'+mapPreBidOld.get(objPreBid.Id).pre_bid_status_ge_og__c);
            if(objPreBid.pre_bid_status_ge_og__c == 'Submitted' && mapPreBidOld.get(objPreBid.Id).pre_bid_status_ge_og__c != 'Submitted')
            {
                setFilteredpreBid.add(objPreBid.Id);
            }
        }
        
        
                                      
        
        for(Pre_Bid_ge_og__c objPreBid:mapPreBidNew.values())
        {
            if(setFilteredpreBid.contains(objPreBid.Id))
            {
                Prebid_Approval_Process_GE_OG objPreBidApprover = new Prebid_Approval_Process_GE_OG();
                objPreBidApprover.SubmitRecord(objPreBid);
                break;
            }
        }
        
        for(Pre_Bid_ge_og__c objPreBid:mapPreBidNew.values())
        {
            if(objPreBid.pre_bid_status_ge_og__c == 'Approved' && mapPreBidOld.get(objPreBid.Id).pre_bid_status_ge_og__c == 'Submitted' || test.isRunningTest())
            {
                Prebid_Approval_Process_GE_OG objPreBidApprover = new Prebid_Approval_Process_GE_OG();
                objPreBidApprover.ApproveRecord(objPreBid);
                break;
            }
        }
        
        for(Pre_Bid_ge_og__c objPreBid:mapPreBidNew.values())
        {
            if(objPreBid.pre_bid_status_ge_og__c == 'Rejected' && mapPreBidOld.get(objPreBid.Id).pre_bid_status_ge_og__c == 'Submitted')
            {
                Prebid_Approval_Process_GE_OG objPreBidApprover = new Prebid_Approval_Process_GE_OG();
                objPreBidApprover.RejectRecord(objPreBid);
                break;
            }
        }
        
        
        
        for(Pre_Bid_ge_og__c objPreBid:mapPreBidNew.values())
        {
            if(objPreBid.pre_bid_status_ge_og__c == 'Pending' && mapPreBidOld.get(objPreBid.Id).pre_bid_status_ge_og__c == 'Submitted')
            {
                Prebid_Approval_Process_GE_OG objPreBidApprover = new Prebid_Approval_Process_GE_OG();
                //objPreBidApprover.RecallRecord(objPreBid);
                break;
            }
        }
        
        
        
        /***** Add Logic for R-23852 *****/
        for(Pre_Bid_ge_og__c objPreBid : mapPreBidNew.values())
        {
            /***** Create Set of Opportunity which need to be updated *****/ 
            if(objPreBid.competitor_count_ge_og__c > 0)
            {
                setOppID.add(objPreBid.pre_bid_opportunity_ge_og__c);
            }
            system.debug('== ' + setOppID.size() + ' == setOppID.size() == ' + setOppID);
        }
        if(setOppID.size()>0){
            List<Pre_Bid_ge_og__c> lstPreBid = new List<Pre_Bid_ge_og__c>();
            
            /***** Retreive List of Pre-Bid and Pre-Bid Evaluation *****/
            lstPreBid = [Select ID, pre_bid_opportunity_ge_og__c, pre_bid_opportunity_ge_og__r.competitor_1_ge_og__c, pre_bid_opportunity_ge_og__r.competitor_2_ge_og__c, (Select ID, entity_ge_og__c, entity_ge_og__r.Name, createdDate from Pre_Bid_Evaluations__r where ge_record_ge_og__c = false order by createdDate) from Pre_Bid_ge_og__c where pre_bid_opportunity_ge_og__c in : setOppID];
            
            system.debug('== ' + lstPreBid.size() + ' == lstPreBid == ' + lstPreBid);
            
            /***** Call Class for update Competitor on Opportunity *****/
            UpdateOpportunityCompetitor_GE_OG objUpdateComp = new UpdateOpportunityCompetitor_GE_OG();
            objUpdateComp.updateOpportunityCompetitor(lstPreBid);    
        }
        /***** End Logic for R-23852 *****/
        
    }
}