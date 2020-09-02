/*
Class/Trigger Name     : PreBidSubmit_GE_OG
Used Where ?           : "Submit" button on Pre Bid
Purpose/Overview       : Used to submit pre Bid record for approval
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-24385
Author                 : Sanath Kumar Dheram
Created Date           : 28/MAR/2016
Test Class Name        : PreBid_GE_OG_Test
*/
global without sharing class PreBidSubmit_GE_OG 
{
    webservice static string submitPreBid(String preBidId)
    {
        Pre_Bid_ge_og__c objPreBid = [SELECT Id, pre_bid_active_ge_og__c,competitor_count_ge_og__c,pre_bid_status_ge_og__c,
                                      pre_bid_opportunity_ge_og__r.StageName, 
                                      pre_bid_opportunity_ge_og__r.deal_path_ge_og__c,pre_bid_opportunity_ge_og__r.has_product_value_ge_og__c,
                                      pre_bid_opportunity_ge_og__r.tier_2_ge_og__c,pre_bid_uploaded_ge_og__c,
                                      pre_bid_opportunity_ge_og__r.documents_uploaded_ge_og__c,pre_bid_opportunity_ge_og__r.HasOpportunityLineItem 
                                      FROM Pre_Bid_ge_og__c WHERE Id =: preBidId] ;
        
        try 
        {
            if(!objPreBid.pre_bid_uploaded_ge_og__c)
            {
                return 'Please upload Pre-Bid documents and check box before submitting.' ;
            }
            else if(!objPreBid.pre_bid_opportunity_ge_og__r.HasOpportunityLineItem )
            {
                return 'Please Add Products before submitting.';
            }
            else if(objPreBid.pre_bid_status_ge_og__c == 'Approved' || objPreBid.pre_bid_status_ge_og__c == 'Submitted')
            {
                return 'Pre Bid is already submitted.';
            }
            else
            {
                objPreBid.pre_bid_status_ge_og__c = 'Submitted';
                //Start: Added below for R-24334
                objPreBid.Prebid_Approver_Do_not_use_ge_og__c=objPreBid.pre_bid_approver_ge_og__c;
                //End: Added below for R-24334
                update objPreBid;
                return 'Pre bid submitted for approval successfully';
            }
            
        }
        catch(Exception ex)
        {
             system.debug('-----Exception----->>>>>>>>'+ex);
             return 'No Approver found for this Pre Bid';
        }
    }
}