/*
Class                  : Deal_Approver_GE_OG
Used Where ?           : Called by SKUID when 'Sent for Approval' link is clicked to submit the Deal Desk 
Purpose/Overview       : Used to get the list of approvers/reviewers of Deal Desk/ Risk Checklist record for approval
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-24384
Author                 : Madhuri Sharma
Created Date           : 17/MAR/2016
Test Class Name        : Deal_Approver_GE_OG_Test
Code Coverage          : 87%
*/

@RestResource(urlMapping='/Deal_Approver_GE_OG/*')
global class Deal_Approver_GE_OG {
    
    // Method to return the list of Deal Commerical Approver
    @HttpGet
    global static List<ApproverWrapper> retrieveDealCommericalApprovers()
    {
        
        List<String> dealCommericalApproverIds = new List<String>();
        ApproverWrapper approverWrapper;
        List<ApproverWrapper> approverWrapperList = new List<ApproverWrapper>();
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        String ddId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug('\n\n ==== DD ID : ==== '+ddId);
        
        if(!String.isBlank(ddId)){
            
            system.debug('\n\n ==== INSIDE: DD ID : ==== '+ddId);
            
            //Fetching Deal Desk records
            Deal_Desk_ge_og__c objDealDesk = [select deal_desk_opportunity_id_ge_og__r.amount_ge_og__c, deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c, 
                                              deal_desk_tier_2_ge_og__c,deal_desk_tier_3_ge_og__c, deal_desk_region_ge_og__c,deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c,
                                              // dd_max_deviation_ge_og__c,
                                              approver_deal_desk_ge_og__c,deal_desk_opportunity_id_ge_og__r.TPS_Segment__c,deal_desk_opportunity_id_ge_og__r.quote_type_ge_og__c,
                                              deal_desk_opportunity_id_ge_og__r.F_AND_PT_Segment_GE_OG__c from Deal_Desk_ge_og__c where id =: ddId];
            
            //Logic for converting amount in USD
            String IWS = Label.Tier_IWS;
            String tps = Label.Tier_TPS;
            Opportunity objOpportunity = [SELECT Id,deal_path_ge_og__c,tier_2_ge_og__c,tier_3_ge_og__c,MultiTier3_ge_og__c,Amount_USD_ge_og__c,TPS_Segment__c,quote_type_ge_og__c  FROM Opportunity WHERE Id = :objDealDesk.deal_desk_opportunity_id_ge_og__c];
            aggregateResult agr = [Select Sum(amount_ge_og__c)amt from Opportunity where id=:objOpportunity.id];
            Integer opptyAmountUSD = 0;
            Double tpsOptyAmount = 0;
            if(objOpportunity.tier_2_ge_og__c != tps){
                system.debug('inside non tps block    '+objOpportunity.tier_2_ge_og__c);
                opptyAmountUSD = Integer.ValueOf(agr.get('amt'));
            }else{
                System.debug('inside Tps block');
                tpsOptyAmount  = objOpportunity.Amount_USD_ge_og__c;
                System.debug('objOpportunity.Amount_USD_ge_og__c >>> '+objOpportunity.Amount_USD_ge_og__c);
                System.debug('tpsOptyAmount >>'+tpsOptyAmount);
            }
            
            System.debug('opptyAmountUSD >>>'+opptyAmountUSD);
            
            String offertype = '';
            String tpssegment = '';
            //Getting Record Type Id
            String comApproverRecordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
            //Added by Harsha for R-31527
            
            String tPScomApproverRecordTypeId = Util_GE_OG.getRecordTypeDetails('TPS_Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
            List<Deal_Reviewer_ge_og__c> dealReviewerList = new List<Deal_Reviewer_ge_og__c>();
            List<TPS_Deal_Reviewer_ge_og__c> tps_dealReviewerList =new List<TPS_Deal_Reviewer_ge_og__c>();
            List<TPS_F_PT_Deal_Reviewer_ge_og__c> fpt_dealReviewerList = new List<TPS_F_PT_Deal_Reviewer_ge_og__c>();
            //Getting Deviation Level for approver as per new DOA changes
            String approver_Level = '';
            String fptsegment = '';
            
            
            //Added by Sonali- R-30247
            //  If(objOpportunity.tier_2_ge_og__c =='Oil Field Services'&& objOpportunity.MultiTier3_ge_og__c ){ ** commented by Harsha C for R- 31373
            If(objOpportunity.tier_2_ge_og__c =='Oil Field Services'){
                
                //Getting Deviation Level for approver as per new DOA changes
                //String approver_Level = '';
                //First Query DRC for Approval Level
                
                // Added by Harsha C for R- 31373
                if(objOpportunity.tier_3_ge_og__c == IWS){
                    for(Deal_Reviewer_Criteria_ge_og__c drc : [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
                                                               deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
                                                               and deal_reviewer_criteria_tier_3_ge_og__c=:IWS 
                                                               and (threshold_lower_limit_ge_og__c <=: opptyAmountUSD 
                                                                    AND threshold_upper_limit_ge_og__c >=: opptyAmountUSD) 
                                                               and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
                                                                    AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
                                                                   )
                                                               and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
                                                                    AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
                                                                   ) 
                                                               and RecordTypeId =:comApproverRecordTypeId]){
                                                                   approver_Level =   drc.deviation_level_ge_og__c;
                                                                   System.debug('Inside OFS block------------->> Id:'+drc.Id+' and Approver Level:'+approver_Level);                                                           
                                                               }    
                }
                else if(objOpportunity.tier_3_ge_og__c != IWS && objOpportunity.MultiTier3_ge_og__c ){
                    for(Deal_Reviewer_Criteria_ge_og__c drc : [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
                                                               deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
                                                               and deal_reviewer_criteria_tier_3_ge_og__c='HQ' 
                                                               and (threshold_lower_limit_ge_og__c <=: opptyAmountUSD 
                                                                    AND threshold_upper_limit_ge_og__c >=: opptyAmountUSD) 
                                                               and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
                                                                    AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
                                                                   )
                                                               and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
                                                                    AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
                                                                   ) 
                                                               and RecordTypeId =:comApproverRecordTypeId]){
                                                                   approver_Level =   drc.deviation_level_ge_og__c;
                                                                   System.debug('Inside OFS block------------->> Id:'+drc.Id+' and Approver Level:'+approver_Level);                                                           
                                                               }
                    //  System.debug('drc  >>>'+drc);
                }
                else {
                    for(Deal_Reviewer_Criteria_ge_og__c drc : [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
                                                               deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
                                                               and deal_reviewer_criteria_tier_3_ge_og__c=:objDealDesk.deal_desk_tier_3_ge_og__c  
                                                               and (threshold_lower_limit_ge_og__c <=: opptyAmountUSD 
                                                                    AND threshold_upper_limit_ge_og__c >=: opptyAmountUSD) 
                                                               and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
                                                                    AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
                                                                   )
                                                               and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
                                                                    AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
                                                                   ) 
                                                               and RecordTypeId =:comApproverRecordTypeId]){
                                                                   approver_Level =   drc.deviation_level_ge_og__c;
                                                                   System.debug('Inside OFS block------------->> Id:'+drc.Id+' and Approver Level:'+approver_Level);                                                           
                                                               }
                    
                    
                }
                
                //New Logic after DOA table changes
                if(objOpportunity.tier_3_ge_og__c != IWS && !objOpportunity.MultiTier3_ge_og__c ){
                    dealReviewerList = [Select id, user_ge_og__c,user_ge_og__r.IsActive, user_ge_og__r.Name,
                                        user_ge_og__r.GE_HQ_SSO_ID__c ,DR_Approver_Level_ge_og__c
                                        from Deal_Reviewer_ge_og__c 
                                        where DR_Tier_2_ge_og__c =: objDealDesk.deal_desk_tier_2_ge_og__c
                                        and DR_Tier_3_ge_og__c =:objDealDesk.deal_desk_tier_3_ge_og__c 
                                        and DR_Region_ge_og__c =: objDealDesk.deal_desk_region_ge_og__c
                                        and DR_Approver_Level_ge_og__c =: approver_Level
                                        and DR_Category_ge_og__c = 'Commercial Deal'                
                                       ]; 
                    System.debug('dealReviewerList >>> 149 '+dealReviewerList+' Reviewer list size >>>> '+dealReviewerList.size());
                }else if(objOpportunity.tier_3_ge_og__c != IWS && objOpportunity.MultiTier3_ge_og__c ){
                    dealReviewerList = [Select id, user_ge_og__c,user_ge_og__r.IsActive, user_ge_og__r.Name,
                                        user_ge_og__r.GE_HQ_SSO_ID__c ,DR_Approver_Level_ge_og__c
                                        from Deal_Reviewer_ge_og__c 
                                        where DR_Tier_2_ge_og__c =: objDealDesk.deal_desk_tier_2_ge_og__c
                                        and DR_Tier_3_ge_og__c =:'HQ' 
                                        and DR_Region_ge_og__c =: objDealDesk.deal_desk_region_ge_og__c
                                        and DR_Approver_Level_ge_og__c =: approver_Level
                                        and DR_Category_ge_og__c = 'Commercial Deal'                
                                       ]; 
                    System.debug('dealReviewerList >>> 150 '+dealReviewerList+' Reviewer list size >>>> '+dealReviewerList.size());
                }else{
                    dealReviewerList = [Select id, user_ge_og__c,user_ge_og__r.IsActive, user_ge_og__r.Name,
                                        user_ge_og__r.GE_HQ_SSO_ID__c ,DR_Approver_Level_ge_og__c
                                        from Deal_Reviewer_ge_og__c 
                                        where DR_Tier_2_ge_og__c =: objDealDesk.deal_desk_tier_2_ge_og__c
                                        and DR_Tier_3_ge_og__c =: IWS 
                                        and DR_Region_ge_og__c =: objDealDesk.deal_desk_region_ge_og__c
                                        and DR_Approver_Level_ge_og__c =: approver_Level
                                        and DR_Category_ge_og__c = 'Commercial Deal'                
                                       ];
                    System.debug('dealReviewerList >>> 160 '+dealReviewerList +' Reviewer list size >>>> '+dealReviewerList.size());
                    
                }
                
            }
            else  If(objOpportunity.tier_2_ge_og__c == tps){
                //Added by Harsha C
                if(objOpportunity.tier_3_ge_og__c == 'Flow & Process Technologies'){
                    for(TPS_F_PT_Deal_Reviewer_Criteria_ge_og__c  tpsdrc : [Select Id,deviation_level_ge_og__c,Offer_Type_Ge_Og__c,TPS_Segment_ge_og__c,deal_Reviewer_Criteria_F_PT_Segment_geog__c from TPS_F_PT_Deal_Reviewer_Criteria_ge_og__c where 
                                                                            deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
                                                                            and deal_reviewer_criteria_tier_3_ge_og__c =:objDealDesk.deal_desk_tier_3_ge_og__c
                                                                            and (threshold_lower_limit_ge_og__c <=: tpsOptyAmount 
                                                                                 AND threshold_upper_limit_ge_og__c >=: tpsOptyAmount) 
                                                                            and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
                                                                                 AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
                                                                                )
                                                                            and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
                                                                                 AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
                                                                                ) 
                                                                            //and RecordTypeId =:tPScomApproverRecordTypeId
                                                                            and TPS_Segment_ge_og__c =: objDealDesk.deal_desk_opportunity_id_ge_og__r.TPS_Segment__c
                                                                            and deal_Reviewer_Criteria_F_PT_Segment_geog__c =: objDealDesk.deal_desk_opportunity_id_ge_og__r.F_AND_PT_Segment_GE_OG__c
                                                                            and Offer_Type_Ge_Og__c =: objDealDesk.deal_desk_opportunity_id_ge_og__r.quote_type_ge_og__c]){
                                                                                approver_Level =   tpsdrc.deviation_level_ge_og__c;
                                                                                offertype = tpsdrc.Offer_Type_Ge_Og__c ;
                                                                                tpssegment = tpsdrc.TPS_Segment_ge_og__c;
                                                                                fptsegment = tpsdrc.deal_Reviewer_Criteria_F_PT_Segment_geog__c;
                                                                                 System.debug('tpsdrc >>> tpsdrc 202  '+tpsdrc);
                   
                                                                            }
                    fpt_dealReviewerList = [Select id, user_ge_og__c,user_ge_og__r.IsActive, user_ge_og__r.Name,DR_Region_ge_og__c,DR_Category_ge_og__c,Offer_Type_Ge_Og__c,
                                            user_ge_og__r.GE_HQ_SSO_ID__c ,DR_Approver_Level_ge_og__c,TPS_Segment_ge_og__c,F_PT_Segment_ge_og__c
                                            from TPS_F_PT_Deal_Reviewer_ge_og__c 
                                            where DR_Tier_2_ge_og__c =: objDealDesk.deal_desk_tier_2_ge_og__c
                                            and DR_Tier_3_ge_og__c =: objDealDesk.deal_desk_tier_3_ge_og__c                                          
                                            and DR_Region_ge_og__c =: objDealDesk.deal_desk_region_ge_og__c
                                            and DR_Approver_Level_ge_og__c =: approver_Level
                                            and DR_Category_ge_og__c = 'Commercial Deal'  
                                            and Offer_Type_Ge_Og__c  =: offertype 
                                            and TPS_Segment_ge_og__c  =: tpssegment
                                            and F_PT_Segment_ge_og__c =: fptsegment
                                           ];                                                                                                                                                              
                    System.debug('fpt_dealReviewerList >>> '+fpt_dealReviewerList);
                       
                }
                
                //Getting Deviation Level for approver as per new DOA changes
                //String approver_Level = '';
                // Added by Harsha C for R- 31373
                else{
                    for(TPS_Deal_Reviewer_Criteria_ge_og__c tpsdrc : [Select Id,deviation_level_ge_og__c,Offer_Type_Ge_Og__c,TPS_Segment_ge_og__c from TPS_Deal_Reviewer_Criteria_ge_og__c where 
                                                                      deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
                                                                      and deal_reviewer_criteria_tier_3_ge_og__c =:objDealDesk.deal_desk_tier_3_ge_og__c
                                                                      and (threshold_lower_limit_ge_og__c <=: tpsOptyAmount 
                                                                           AND threshold_upper_limit_ge_og__c >=: tpsOptyAmount) 
                                                                      and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
                                                                           AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
                                                                          )
                                                                      and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
                                                                           AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
                                                                          ) 
                                                                      and RecordTypeId =:tPScomApproverRecordTypeId
                                                                      and TPS_Segment_ge_og__c =: objDealDesk.deal_desk_opportunity_id_ge_og__r.TPS_Segment__c
                                                                      and Offer_Type_Ge_Og__c =: objDealDesk.deal_desk_opportunity_id_ge_og__r.quote_type_ge_og__c]){
                                                                          approver_Level =   tpsdrc.deviation_level_ge_og__c;
                                                                          offertype = tpsdrc.Offer_Type_Ge_Og__c ;
                                                                          tpssegment = tpsdrc.TPS_Segment_ge_og__c;
                                                                          System.debug('Inside tps block------------->> Id:'+tpsdrc.Id+' and Approver Level:'+approver_Level);                                                           
                                                                      }    
                    
               
                
                //New Logic after DOA table changes
                
                    tps_dealReviewerList = [Select id, user_ge_og__c,user_ge_og__r.IsActive, user_ge_og__r.Name,
                                            user_ge_og__r.GE_HQ_SSO_ID__c ,DR_Approver_Level_ge_og__c,TPS_Segment_ge_og__c
                                            from TPS_Deal_Reviewer_ge_og__c 
                                            where DR_Tier_2_ge_og__c =: objDealDesk.deal_desk_tier_2_ge_og__c
                                            and DR_Tier_3_ge_og__c =: objDealDesk.deal_desk_tier_3_ge_og__c                                          
                                            and DR_Region_ge_og__c =: objDealDesk.deal_desk_region_ge_og__c
                                            and DR_Approver_Level_ge_og__c =: approver_Level
                                            and DR_Category_ge_og__c = 'Commercial Deal'  
                                            and Offer_Type_Ge_Og__c  =: offertype 
                                            and TPS_Segment_ge_og__c  =: tpssegment
                                           ];
                    System.debug('tps_dealReviewerList >>> '+tps_dealReviewerList);
                    
                }
                
            }
            else{
                //Getting Deviation Level for approver as per new DOA changes
                //String approver_Level = '';
                //First Query DRC for Approval Level
                for(Deal_Reviewer_Criteria_ge_og__c drc : [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
                                                           deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
                                                           and deal_reviewer_criteria_tier_3_ge_og__c=:objDealDesk.deal_desk_tier_3_ge_og__c 
                                                           and (threshold_lower_limit_ge_og__c <=: opptyAmountUSD 
                                                                AND threshold_upper_limit_ge_og__c >=: opptyAmountUSD) 
                                                           and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
                                                                AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
                                                               )
                                                           and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
                                                                AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
                                                               ) 
                                                           and RecordTypeId =:comApproverRecordTypeId]){
                                                               approver_Level =   drc.deviation_level_ge_og__c;
                                                               System.debug('------------->> Id:'+drc.Id+' and Approver Level:'+approver_Level);                                                           
                                                           }
                
                //New Logic after DOA table changes
                dealReviewerList = [Select id, user_ge_og__c,user_ge_og__r.IsActive, user_ge_og__r.Name,
                                    user_ge_og__r.GE_HQ_SSO_ID__c ,DR_Approver_Level_ge_og__c
                                    from Deal_Reviewer_ge_og__c 
                                    where DR_Tier_2_ge_og__c =: objDealDesk.deal_desk_tier_2_ge_og__c
                                    and DR_Tier_3_ge_og__c =: objDealDesk.deal_desk_tier_3_ge_og__c 
                                    and DR_Region_ge_og__c =: objDealDesk.deal_desk_region_ge_og__c
                                    and DR_Approver_Level_ge_og__c =: approver_Level
                                    and DR_Category_ge_og__c = 'Commercial Deal'                
                                   ];
                
            } 
            
            // Added by Harsha C for  
            if(objDealDesk.deal_desk_tier_2_ge_og__c == tps){
                if(objDealDesk.deal_desk_tier_3_ge_og__c == 'Flow & Process Technologies'){
                    for(TPS_F_PT_Deal_Reviewer_ge_og__c fpt:fpt_dealReviewerList){
                        ////Displaying deviation level and active & inactive users byGourav
                        String usrStatus='';
                        if(fpt.user_ge_og__c != null ){
                            if(fpt.user_ge_og__r.IsActive)
                                usrStatus='Active';
                            else
                                usrStatus='InActive';
                            dealCommericalApproverIds.add(fpt.user_ge_og__c);
                            approverWrapper = new ApproverWrapper('Approver Found' , fpt.user_ge_og__c,fpt.user_ge_og__r.name,usrStatus,fpt.user_ge_og__r.GE_HQ_SSO_ID__c
                                                                  ,approver_Level);
                            approverWrapperList.add(approverWrapper);
                        }
                    }   
                }else{
                    for(TPS_Deal_Reviewer_ge_og__c dr:tps_dealReviewerList){
                        ////Displaying deviation level and active & inactive users byGourav
                        String userStatus='';
                        if(dr.user_ge_og__c != null ){
                            if(dr.user_ge_og__r.IsActive)
                                userStatus='Active';
                            else
                                userStatus='InActive';
                            dealCommericalApproverIds.add(dr.user_ge_og__c);
                            approverWrapper = new ApproverWrapper('Approver Found' , dr.user_ge_og__c,dr.user_ge_og__r.name,userStatus,dr.user_ge_og__r.GE_HQ_SSO_ID__c
                                                                  ,approver_Level);
                            approverWrapperList.add(approverWrapper);
                        }
                    } 
                }
            }
            else{
                for(Deal_Reviewer_ge_og__c dr:dealReviewerList){
                    ////Displaying deviation level and active & inactive users byGourav
                    //if(dr.user_ge_og__c != null && dr.user_ge_og__r.IsActive){
                    String userStatus='';
                    if(dr.user_ge_og__c != null ){
                        if(dr.user_ge_og__r.IsActive)
                            userStatus='Active';
                        else
                            userStatus='InActive';
                        dealCommericalApproverIds.add(dr.user_ge_og__c);
                        approverWrapper = new ApproverWrapper('Approver Found' , dr.user_ge_og__c,dr.user_ge_og__r.name,userStatus,dr.user_ge_og__r.GE_HQ_SSO_ID__c
                                                              ,approver_Level);
                        approverWrapperList.add(approverWrapper);
                    }
                }
            }
            
        }
        
        if(approverWrapperList.size() == 0){
            approverWrapper = new ApproverWrapper('Approver Not Found' , null,'','','','');
            approverWrapperList.add(approverWrapper);
        }
        System.debug('\n\n ApproverIds JSON '+approverWrapperList);
        return approverWrapperList;
    }
    
    global class ApproverWrapper
    {
        public String Status {get;set;}
        public String Id {get;set;}
        public String ApproverName {get;set;}
        public String approverStatus {get;set;}
        public String SSO {get;set;}
        public String deviationLev{get;set;}
        
        public ApproverWrapper(String status,String id,String apprvName,String apprvrStatus,String ssoID,String devtnLev)
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