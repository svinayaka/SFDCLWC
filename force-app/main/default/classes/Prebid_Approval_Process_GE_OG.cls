/*
Class/Trigger Name     : Prebid_Approval_Process_GE_OG
Used For               : PrebidApproveRecord_GE_OG
Purpose/Overview       : This class intiates the Approval Process for Prebid on submission and approval as per status updated by Skuid.
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-30245
Author                 : Sonali Rathore
Created Date           : 06-Aug-2018
Test Class Name        : Prebid_Approval_Process_GE_OG_Test
Code Coverage          : 66
*/
public class Prebid_Approval_Process_GE_OG 
{
    // Method to submit record to approver when status changes to 'Submitted'
    public void SubmitRecord(Pre_Bid_ge_og__c preBid)
    {
        Pre_Bid_ge_og__c preBidObj = [SELECT Id, pre_bid_active_ge_og__c,competitor_count_ge_og__c,pre_bid_status_ge_og__c,
                                      pre_bid_opportunity_ge_og__r.StageName, 
                                      pre_bid_opportunity_ge_og__r.deal_path_ge_og__c,pre_bid_opportunity_ge_og__r.has_product_value_ge_og__c,
                                      pre_bid_opportunity_ge_og__r.tier_2_ge_og__c,pre_bid_uploaded_ge_og__c,
                                      pre_bid_opportunity_ge_og__r.documents_uploaded_ge_og__c,pre_bid_opportunity_ge_og__r.HasOpportunityLineItem,
                                      pre_bid_approver_ge_og__c,Prebid_Approver_Do_not_use_ge_og__c
                                      FROM Pre_Bid_ge_og__c where id =: preBid.id];
        
        
        preBidObj.Prebid_Approver_Do_not_use_ge_og__c=preBidObj.pre_bid_approver_ge_og__c;
        update preBidObj;
       
        
        Boolean isReviewed = true;
        Set<id> userIds = new Set<Id>();
                
        Opportunity objOpportunity = [SELECT Id,deal_path_ge_og__c,tier_2_ge_og__c FROM Opportunity WHERE Id = :preBidObj.pre_bid_opportunity_ge_og__c];
        aggregateResult agr = [select Sum(amount_ge_og__c)amt from Opportunity where id=:objOpportunity.id];
        Integer opptyAmountUSD = Integer.ValueOf(agr.get('amt'));
        System.debug('oooooooooooooooooooo    '+opptyAmountUSD );
        
       
        
        List<Deal_Reviewer_ge_og__c> dealReviewer = new List<Deal_Reviewer_ge_og__c>();
        String prebidAppRecordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Pre Bid Approver').getRecordTypeId();
        
      
            List<OpportunityTeamMember> otmList = new List<OpportunityTeamMember>();
            //if(dealReviewer.size() > 0){
            if(preBidObj.pre_bid_approver_ge_og__c != null){  
            
                //for(Deal_Reviewer_ge_og__c dr:dealReviewer )
                //if(dealReviewer.size()>0)
               
                    //userIds.add(dealReviewer[0].user_ge_og__c);
                    userIds.add(preBidObj.pre_bid_approver_ge_og__c);
                    List<OpportunityTeamMember> otm = [select id from OpportunityTeamMember where OpportunityId =:preBidObj.pre_bid_opportunity_ge_og__c and UserId =: preBidObj.pre_bid_approver_ge_og__c];
                        If(otm.size()==0){
                            otmList.add(new OpportunityTeamMember (OpportunityId = preBidObj.pre_bid_opportunity_ge_og__c,
                                                             UserId = preBidObj.pre_bid_approver_ge_og__c, TeamMemberRole = 'Functional Leader'));
                            insert otmList;
                        } 
                
            
            
                List<Approval.ProcessSubmitRequest> requests = new List<Approval.ProcessSubmitRequest>();
    
                for (Id approverId : userIds) 
                {
                        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
    
                        req.setComments('Submitting request');
                        req.setObjectId(preBidObj.id);
                        //if(preBidObj.dd_ge_og__c!='DD-'0){}
                        req.setNextApproverIds(new List<Id>{approverId});
                        requests.add(req);
                }
                
                    
                    List<Approval.ProcessResult> results = new List<Approval.ProcessResult>();
                    //if(!test.isRunningtest())
                    results = Approval.process(requests);
                    
          System.debug('---------------------------------- in PrebidApprover'+results);                    
                    if (results != null && results.size() > 0 && results[0].isSuccess()){
                        //preBidObj.pre_bid_approver_ge_og__c = dealReviewer[0].user_ge_og__c;
                        //preBidObj.deal_desk_approver_level_ge_og__c = dealReviewer[0].deal_reviewer_criteria_num_ge_og__r.deviation_level_ge_og__c;
                        //update preBidObj;
                    }
                
                
            }
            else{
                //preBidObj.addError('No approver Found');
                if(!test.isRunningtest()){
                preBidObj.pre_bid_status_ge_og__c = 'Approved';
                System.debug('Inside running test========================================>'+test.isRunningtest()+preBidObj.pre_bid_status_ge_og__c);
                 update preBidObj;
                }
               
            }
            
            
       // }
    }

    // Method to approve record when status changes to 'Approved'
    public void ApproveRecord(Pre_Bid_ge_og__c preBidObj)
    {
        System.debug('======================================Going to call Approval Process code in Apex class');
        ID ownerId = [SELECT Id,pre_bid_opportunity_ge_og__r.OwnerId FROM Pre_Bid_ge_og__c WHERE Id=:preBidObj.Id].pre_bid_opportunity_ge_og__r.OwnerId;
        
        ProcessInstance pi = new ProcessInstance();
        if(!test.isRunningtest())
        pi = [Select TargetObjectId, Status from ProcessInstance  where TargetObjectId =:preBidObj.Id order by CreatedDate desc limit 1]; 
        
      if(test.isRunningtest() || (pi !=null && pi.Status =='Pending') ){
                
        Approval.ProcessWorkitemRequest appRequest = new Approval.ProcessWorkitemRequest();
        appRequest.setComments('Apporve request');
        appRequest.setAction('Approve');
        appRequest.setNextApproverIds(new List<Id>{ownerId});
        String workItemId = '';
        
        for(ProcessInstanceWorkitem workItem  : [SELECT Id 
                                                 FROM ProcessInstanceWorkitem 
                                                 WHERE ProcessInstance.TargetObjectId =: preBidObj.Id])
        {
            workItemId  =  workItem.Id;
        }


        if(workItemId == null)
        {
            preBidObj.addError('Error Occured in Trigger');
        }
        else
        {
            appRequest.setWorkitemId(workItemId);
            if(!test.isRunningtest())
            Approval.ProcessResult result =  Approval.process(appRequest);
        }
    }
        //To implement Comments on Deal Desk after approval
        List<Pre_Bid_ge_og__c> PrebidList = [ Select pd.Id, pd.lastModifiedById, pd.pre_bid_approval_comments_ge_og__c, 
                                           (Select Id, IsPending, ProcessInstanceId, TargetObjectId, StepStatus, OriginalActorId, ActorId, RemindersSent, Comments, IsDeleted, CreatedDate, CreatedById, SystemModstamp 
                                                     From ProcessSteps order by createddate desc limit 1) 
                      From Pre_Bid_ge_og__c pd where id=:preBidObj.Id];
    
      if (PrebidList.size()>0)
      {
        Pre_Bid_ge_og__c pd1=PrebidList[0];
         for (ProcessInstanceHistory psh : pd1.ProcessSteps)
         {
                System.debug('-------------------------->>>CreatedDate:'+psh.CreatedDate+' & psh.comments:'+psh.comments+' &StepStatus:'+psh.StepStatus);
          //if(pd1.approver_comments_ge_og__c == null && psh.comments != null){
                if(psh.comments != null && psh.StepStatus=='Approved' && psh.Comments != 'Apporve request'){  
                //System.debug('-------------------------->>>psh.comments:'+psh.comments);
                      pd1.pre_bid_approval_comments_ge_og__c=psh.comments;
                      
                }
                break;
         }
            
        //pd1.approved_rejected_by_ge_og__c = pd1.lastModifiedById;  
      PrebidList.add(pd1);
            update pd1;
       }
    
        //Pre_Bid_ge_og__c pd1 = [select id, lastModifiedById,approved_rejected_by_ge_og__c from Deal_Desk_ge_og__c where id=: preBidObj.id];
        //pd1.approved_rejected_by_ge_og__c = pd1.lastModifiedById;
        //update PrebidList;
    }
    
    
    
    
    // Method to reject record
    public void RejectRecord(Pre_Bid_ge_og__c preBidObj)
    {
        ID ownerId = [SELECT Id,pre_bid_opportunity_ge_og__r.OwnerId FROM Pre_Bid_ge_og__c WHERE Id=:preBidObj.Id].pre_bid_opportunity_ge_og__r.OwnerId;
        ID oppID = [SELECT pre_bid_opportunity_ge_og__c FROM Pre_Bid_ge_og__c WHERE Id=:preBidObj.Id].pre_bid_opportunity_ge_og__c;

        ProcessInstance pi = new ProcessInstance();
        if(!test.isRunningtest())
        pi = [Select TargetObjectId, Status from ProcessInstance  where TargetObjectId =:preBidObj.Id order by CreatedDate desc limit 1]; 
      
      if(test.isRunningtest() || pi !=null && pi.Status=='Pending' ){
        Approval.ProcessWorkitemRequest appRequest = new Approval.ProcessWorkitemRequest();
        appRequest.setComments('Rejected request');
        appRequest.setAction('Reject');
        appRequest.setNextApproverIds(new List<Id>{ownerId});
        String workItemId = '';
        
        for(ProcessInstanceWorkitem workItem  : [SELECT Id 
                                                 FROM ProcessInstanceWorkitem 
                                                 WHERE ProcessInstance.TargetObjectId =: preBidObj.Id])
        {
            workItemId  =  workItem.Id;
        }


        if(workItemId == null)
        {
            preBidObj.addError('Error Occured in Trigger');
        }
        else
        {
            appRequest.setWorkitemId(workItemId);
            if(!test.isRunningtest())
            Approval.ProcessResult result =  Approval.process(appRequest);
        }
    }
        //To implement Comments on Prebid after Rejected
        List<Pre_Bid_ge_og__c> PrebidList = [ Select pd.Id, pd.lastModifiedById,pd.pre_bid_approval_comments_ge_og__c, 
                                           (Select Id, IsPending, ProcessInstanceId, TargetObjectId, StepStatus, OriginalActorId, ActorId, RemindersSent, Comments, IsDeleted, CreatedDate, CreatedById, SystemModstamp 
                                                     From ProcessSteps order by createddate desc) 
                      From Pre_Bid_ge_og__c pd where id=:preBidObj.Id];
    
      if (PrebidList.size()>0)
      {
        Pre_Bid_ge_og__c pd1=PrebidList[0];
         for (ProcessInstanceHistory psh : pd1.ProcessSteps)
         {
                System.debug('-------------------------->>>CreatedDate:'+psh.CreatedDate+' & psh.comments:'+psh.comments+' &StepStatus:'+psh.StepStatus);
          //if(pd1.approver_comments_ge_og__c == null && psh.comments != null){
                if(psh.comments != null && psh.StepStatus=='Rejected' && psh.Comments !='Rejected request'){  
                //System.debug('-------------------------->>>psh.comments:'+psh.comments);
                      pd1.pre_bid_approval_comments_ge_og__c=psh.comments;
                      
                }
                break;
         }
            
       // pd1.approved_rejected_by_ge_og__c = pd1.lastModifiedById;  
      PrebidList.add(pd1);
            update pd1;
       }
    }   
}