/*
Class/Trigger Name     : Deal_Reviewer_GE_OG
Used Where ?           : RiskChecklistCategoryHandler_GE_OG
Purpose/Overview       : Used to get the list of reviewers of Risk Checklist record for approval
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-24384
Author                 : Madhuri Sharma
Created Date           : 17/MAR/2016
Test Class Name        : Deal_Reviewer_GE_OG_Test
Code Coverage          : 85%
*/

@RestResource(urlMapping='/Deal_Reviewer_GE_OG/*')
global class Deal_Reviewer_GE_OG {
    
    // Method to return the list of Risk  Reviewers
    @HttpGet
    global static List<ReviewerWrapper> retrieveRiskReviewers()
    {
        List<String> reviewerIds = new List<String>();
        ReviewerWrapper reviewerWrapper;
        List<ReviewerWrapper> reviewerWrapperList = new List<ReviewerWrapper>();
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        String rccId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        system.debug('==== '+rccId);
    
        if(!String.isBlank(rccId)){
        
            system.debug('===  Inside   == '+ rccId);
             //Initialise variables
            List<String> tier2Values = new List<String>();
            List<String> tier3Values = new List<String>();
            List<String> regionValues = new List<String>();
            List<String> deviationValues = new List<String>();
            Set<String> categoryValues = new Set<String>();
            Map<Id,Id> rccOpptyMap = new Map<Id,Id>();
            
            
        
            String dealReviewerRecordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Deal Reviewer').getRecordTypeId();
            //addning values in different list, later be used in query
            /* for (Risk_Checklist_Category_ge_og__c rcc : [Select Id,tier_2_ge_og__c,risk_checklist_tier_3_ge_og__c,region_ge_og__c,max_deviation_ge_og__c,rcl_category_ge_og__c from Risk_Checklist_Category_ge_og__c where Id =:rccId])
            {
            
                system.debug('===  Inside For 1  == '+ rcc.id);
               
                tier2Values.add(rcc.tier_2_ge_og__c);
                tier3Values.add(rcc.risk_checklist_tier_3_ge_og__c);
                regionValues.add(rcc.region_ge_og__c);
                deviationValues.add(String.valueOf(rcc.max_deviation_ge_og__c));
                categoryValues.add(rcc.rcl_category_ge_og__c);
				
            } */
            
            Risk_Checklist_Category_ge_og__c rcc = [Select Id,tier_2_ge_og__c,risk_checklist_tier_3_ge_og__c,region_ge_og__c
                                                    ,max_deviation_ge_og__c,rcl_category_ge_og__c from Risk_Checklist_Category_ge_og__c where Id =:rccId];
            
            //Query on Deal Reviewer, it will fetch the approver based on Teir 2, region and Deviation
            List<Deal_Reviewer_ge_og__c> dealReviewerList = [Select id, user_ge_og__c,user_ge_og__r.IsActive, user_ge_og__r.Name,
                                                             user_ge_og__r.GE_HQ_SSO_ID__c ,DR_Approver_Level_ge_og__c
                                                             from Deal_Reviewer_ge_og__c 
                                                             where DR_Tier_2_ge_og__c =: rcc.tier_2_ge_og__c
                                                              and DR_Tier_3_ge_og__c =: rcc.risk_checklist_tier_3_ge_og__c
                                                              and DR_Region_ge_og__c =: rcc.region_ge_og__c
                                                             and DR_Approver_Level_ge_og__c =: String.valueOf(rcc.max_deviation_ge_og__c)
                                                             and DR_Category_ge_og__c =: rcc.rcl_category_ge_og__c
                                                             ];
             
             system.debug('===  dealReviewerList  == '+ dealReviewerList);                                       
                                                    
            for(Deal_Reviewer_ge_og__c dr:dealReviewerList){
                
                system.debug('===  Inside for 2  == '+ dr); 
                
                //Displaying active and inactive users byGourav
                //if(dr.user_ge_og__c != null && dr.user_ge_og__r.IsActive){
                if(dr.user_ge_og__c != null ){  
                    String userStatus='';
                    system.debug('===  Inside IF 3  == '+ dr); 
                    reviewerIds.add(dr.user_ge_og__c);
                    if(dr.user_ge_og__r.IsActive)
                        userStatus='Active';
                    else
                        userStatus='InActive';
                    reviewerWrapper = new ReviewerWrapper('Reviewer Found' , dr.user_ge_og__c,dr.user_ge_og__r.name,userStatus,dr.user_ge_og__r.GE_HQ_SSO_ID__c);
                    reviewerWrapperList.add(reviewerWrapper);
                }
            }
          
        }
        
        if(reviewerWrapperList.size() == 0){
                reviewerWrapper = new ReviewerWrapper('Reviewer Not Found' , null, '','','');
                reviewerWrapperList.add(reviewerWrapper);
        }
        
        String reviewerIdsJSON = JSON.serialize(reviewerWrapperList ); 
        System.debug('\n\n ReviewerIds JSON '+reviewerIdsJSON);
        
        return reviewerWrapperList;
        //return reviewerIdsJSON;
    }
    
    global class ReviewerWrapper
    {
          public String Status {get;set;}
          public String Id {get;set;}
          public String ReviewerName {get;set;}
          public String reviewerStatus {get;set;}
          public String SSO {get;set;}
          
          public ReviewerWrapper(String status,String id,String revName,String revwrStatus,String ssoID)
          {
            this.Status =status;
            this.Id =id;
            this.ReviewerName =revName;
            this.reviewerStatus= revwrStatus;
            this.SSO =ssoID;
             
            
          }
    }
   
}