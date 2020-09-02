/*
Class/Trigger Name     : PreBidApprover_GE_OG
Used Where ?           : Called by SKUID when 'Sent for Approval' link is clicked to submit the Prebid
Purpose/Overview       : Used to get the list of approvers/reviewers of Prebid record for approval
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-30245
Author                 : Sonali Rathore
Created Date           : 03/Aug/2018
Test Class Name        : PreBid_GE_OG_Test
Code Coverage          : 63
*/

@RestResource(urlMapping='/PreBidApprover_GE_OG/*')
global class PreBidApprover_GE_OG 
{
    // Method to submit Prebid record to approval
    @HttpGet
    global static List<PrebidApproverWrapper> retrievePrebidApprovers()
    {
        Set<String> tier2Set = new Set<String>{'All'};
            List<String> dealPrebidIds = new List<String>();
        PrebidApproverWrapper PrebidApproverWrapper;
        List<PrebidApproverWrapper> PrebidApproverWrapperList = new List<PrebidApproverWrapper>();
        Set<id> userIds = new Set<Id>();
        List<Deal_Reviewer_ge_og__c> dealReviewer = new List<Deal_Reviewer_ge_og__c>();
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        String prebidId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug('prebidId : ==== '+prebidId);
        
        if(!String.isBlank(prebidId)){
            
            system.debug('INSIDE: PrebidId : ==== '+prebidId);
            
            //Fetching Prebid records
            Pre_Bid_ge_og__c  preBid = [select id, pre_bid_opportunity_ge_og__r.tier_2_ge_og__c  , pre_bid_opportunity_ge_og__r.tier_3_ge_og__c ,pre_bid_region_ge_og__c,
                                        pre_bid_opportunity_ge_og__r.amount_ge_og__c from Pre_Bid_ge_og__c where id=:prebidId];
            
            //Logic for converting amount in USD        
            Opportunity objOpportunity = [SELECT Id,MultiTier3_ge_og__c,tier_2_ge_og__c,tier_3_ge_og__c FROM Opportunity WHERE Id = :preBid.pre_bid_opportunity_ge_og__c];
            tier2Set.add(objOpportunity.tier_2_ge_og__c);
            aggregateResult agr = [select Sum(amount_ge_og__c)amt from Opportunity where id=:objOpportunity.id];
            Integer opptyAmountUSD = Integer.ValueOf(agr.get('amt'));
            system.debug('Opportunity Amount'+opptyAmountUSD);
            
            //Getting Record Type Id
            string prApproverRecordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Pre Bid Approver').getRecordTypeId();
            
            //Getting Deviation Level for approver as per new DOA changes
            String approver_Level = '';
            system.debug('Prebid Details'+ prApproverRecordTypeId  +'    '+ preBid.pre_bid_region_ge_og__c +'     '+ preBid.pre_bid_opportunity_ge_og__r.tier_2_ge_og__c+'    & Tier3:'+ preBid.pre_bid_opportunity_ge_og__r.tier_3_ge_og__c);
            
            //Added by Sonali- R-30247
            //Modified by Harsha C for R-32411   
            If(objOpportunity.tier_2_ge_og__c =='Oil Field Services' && objOpportunity.tier_3_ge_og__c =='Integrated Well Services' ){   
                //Added by Harsha C for R-32411   
                
                for(Deal_Reviewer_Criteria_ge_og__c drc : [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
                                                           deal_reviewer_criteria_tier_2_ge_og__c=: preBid.pre_bid_opportunity_ge_og__r.tier_2_ge_og__c
                                                           and deal_reviewer_criteria_tier_3_ge_og__c='Integrated Well Services'
                                                           and (threshold_lower_limit_ge_og__c <=: opptyAmountUSD 
                                                                AND threshold_upper_limit_ge_og__c >=: opptyAmountUSD) 
                                                           and RecordTypeId =:prApproverRecordTypeId]){
                                                               approver_Level =   drc.deviation_level_ge_og__c;
                                                               System.debug('------------->> Id:'+drc.Id+' and Approver Level:'+approver_Level);                                                           
                                                           }
                
                dealReviewer = [select id,user_ge_og__c,user_ge_og__r.IsActive,user_ge_og__r.name,user_ge_og__r.GE_HQ_SSO_ID__c from Deal_Reviewer_ge_og__c 
                                where DR_Tier_2_ge_og__c =: preBid.pre_bid_opportunity_ge_og__r.tier_2_ge_og__c
                                and DR_Tier_3_ge_og__c ='Integrated Well Services'
                                and DR_Region_ge_og__c =: preBid.pre_bid_region_ge_og__c
                                and DR_Approver_Level_ge_og__c =: approver_Level
                                and DR_Category_ge_og__c = 'PreBid Assesment'];
                
                
                
                
                //First Query DRC for Approval Level
                /* for(Deal_Reviewer_Criteria_ge_og__c drc : [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
deal_reviewer_criteria_tier_2_ge_og__c=: preBid.pre_bid_opportunity_ge_og__r.tier_2_ge_og__c
and deal_reviewer_criteria_tier_3_ge_og__c='HQ'
and (threshold_lower_limit_ge_og__c <=: opptyAmountUSD 
AND threshold_upper_limit_ge_og__c >=: opptyAmountUSD) 
and RecordTypeId =:prApproverRecordTypeId]){
approver_Level =   drc.deviation_level_ge_og__c;
System.debug('------------->> Id:'+drc.Id+' and Approver Level:'+approver_Level);                                                           
}

dealReviewer = [select id,user_ge_og__c,user_ge_og__r.IsActive,user_ge_og__r.name,user_ge_og__r.GE_HQ_SSO_ID__c from Deal_Reviewer_ge_og__c 
where DR_Tier_2_ge_og__c =: preBid.pre_bid_opportunity_ge_og__r.tier_2_ge_og__c
and DR_Tier_3_ge_og__c ='HQ'
and DR_Region_ge_og__c =: preBid.pre_bid_region_ge_og__c
and DR_Approver_Level_ge_og__c =: approver_Level
and DR_Category_ge_og__c = 'PreBid Assesment'
limit 1];*/
                
                system.debug('Tier2 Set & Deal Reviewer Size'+tier2Set +'    '+dealReviewer.size() );
                system.debug('dealReviewer  '+dealReviewer );                                                      
            }
            else if(objOpportunity.tier_2_ge_og__c =='Oil Field Services' && objOpportunity.tier_3_ge_og__c != 'Integrated Well Services' && objOpportunity.MultiTier3_ge_og__c){
                
                for(Deal_Reviewer_Criteria_ge_og__c drc : [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
                                                           deal_reviewer_criteria_tier_2_ge_og__c=: preBid.pre_bid_opportunity_ge_og__r.tier_2_ge_og__c
                                                           and deal_reviewer_criteria_tier_3_ge_og__c='HQ'
                                                           and (threshold_lower_limit_ge_og__c <=: opptyAmountUSD 
                                                                AND threshold_upper_limit_ge_og__c >=: opptyAmountUSD) 
                                                           and RecordTypeId =:prApproverRecordTypeId]){
                                                               approver_Level =   drc.deviation_level_ge_og__c;
                                                               System.debug('------------->> Id:'+drc.Id+' and Approver Level:'+approver_Level);                                                           
                                                           }
                
                dealReviewer = [select id,user_ge_og__c,user_ge_og__r.IsActive,user_ge_og__r.name,user_ge_og__r.GE_HQ_SSO_ID__c from Deal_Reviewer_ge_og__c 
                                where DR_Tier_2_ge_og__c =: preBid.pre_bid_opportunity_ge_og__r.tier_2_ge_og__c
                                and DR_Tier_3_ge_og__c ='HQ'
                                and DR_Region_ge_og__c =: preBid.pre_bid_region_ge_og__c
                                and DR_Approver_Level_ge_og__c =: approver_Level
                                and DR_Category_ge_og__c = 'PreBid Assesment'];
                
            }
            else{
                //First Query DRC for Approval Level
                for(Deal_Reviewer_Criteria_ge_og__c drc : [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
                                                           deal_reviewer_criteria_tier_2_ge_og__c=: preBid.pre_bid_opportunity_ge_og__r.tier_2_ge_og__c
                                                           and deal_reviewer_criteria_tier_3_ge_og__c=: preBid.pre_bid_opportunity_ge_og__r.tier_3_ge_og__c
                                                           and (threshold_lower_limit_ge_og__c <=: opptyAmountUSD 
                                                                AND threshold_upper_limit_ge_og__c >=: opptyAmountUSD) 
                                                           and RecordTypeId =:prApproverRecordTypeId]){
                                                               approver_Level =   drc.deviation_level_ge_og__c;
                                                               System.debug('------------->> Id:'+drc.Id+' and Approver Level:'+approver_Level);                                                           
                                                           }
                
                
                dealReviewer = [select id,user_ge_og__c,user_ge_og__r.IsActive,user_ge_og__r.name,user_ge_og__r.GE_HQ_SSO_ID__c from Deal_Reviewer_ge_og__c 
                                where DR_Tier_2_ge_og__c =: preBid.pre_bid_opportunity_ge_og__r.tier_2_ge_og__c
                                and DR_Tier_3_ge_og__c =: preBid.pre_bid_opportunity_ge_og__r.tier_3_ge_og__c
                                and DR_Region_ge_og__c =: preBid.pre_bid_region_ge_og__c
                                and DR_Approver_Level_ge_og__c =: approver_Level
                                and DR_Category_ge_og__c = 'PreBid Assesment'
                               ];
                
                system.debug('Tier2 Set & Deal Reviewer Size'+tier2Set +'    '+dealReviewer.size() );
                system.debug('dealReviewer  '+dealReviewer );                 
            }
            
            
            for(Deal_Reviewer_ge_og__c dr:dealReviewer){
                
                ////Displaying deviation level and active & inactive users byGourav
                //if(dr.user_ge_og__c != null && dr.user_ge_og__r.IsActive){
                String userStatus='';
                if(dr.user_ge_og__c != null ){
                    if(dr.user_ge_og__r.IsActive)
                        userStatus='Active';
                    else
                        userStatus='InActive';
                    dealPrebidIds.add(dr.user_ge_og__c);
                    PrebidApproverWrapper = new PrebidApproverWrapper('Approver Found' , dr.user_ge_og__c,dr.user_ge_og__r.name,userStatus,dr.user_ge_og__r.GE_HQ_SSO_ID__c
                                                                      ,approver_Level);
                    System.debug('PrebidApproverWrapper'+PrebidApproverWrapper );                                                  
                    PrebidApproverWrapperList.add(PrebidApproverWrapper);
                }
            }
        }
        if(PrebidApproverWrapperList.size() == 0){
            PrebidApproverWrapper = new PrebidApproverWrapper('Approver Not Found' , null,'','','','');
            PrebidApproverWrapperList.add(PrebidApproverWrapper);
        }
        System.debug('\n\n ApproverIds JSON '+PrebidApproverWrapperList);
        return PrebidApproverWrapperList;
    }
    
    global class PrebidApproverWrapper
    {
        public String Status {get;set;}
        public String Id {get;set;}
        public String ApproverName {get;set;}
        public String approverStatus {get;set;}
        public String SSO {get;set;}
        public String deviationLev{get;set;}
        
        public PrebidApproverWrapper(String status,String id,String apprvName,String apprvrStatus,String ssoID,String devtnLev)
        {
            this.Status =status;
            this.Id =id;
            this.ApproverName =apprvName;
            this.approverStatus=apprvrStatus;
            this.SSO =ssoID;
            this.deviationLev=devtnLev;
            
        }
    }
}