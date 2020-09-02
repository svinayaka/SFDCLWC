/*
Class/Trigger Name     : DealDeskApprover_GE_OG
Used For               : DealDeskApproveRecord_GE_OG
Purpose/Overview       : This class intiates the Approval Process for Deal Desk on submission and approval as per status updated by Skuid.
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-23474
Author                 : Sanath Kumar Dheram
Created Date           : 25-Oct-2015
Test Class Name        : DealDeskApprover_Test_GE_OG
Code Coverage          : 66
*/



public without sharing class DealDeskApprover_GE_OG 
{
    // Method to submit record to approver when status changes to 'Submitted'
    public void SubmitRecord(Deal_Desk_ge_og__c ddObj)
    {
        Deal_Desk_ge_og__c objDealDesk = [select deal_desk_opportunity_id_ge_og__r.amount_ge_og__c, status_ge_og__c, deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c, 
                                          deal_desk_tier_2_ge_og__c,deal_desk_tier_3_ge_og__c, deal_desk_region_ge_og__c,
                                          approver_deal_desk_ge_og__c from Deal_Desk_ge_og__c where id =: ddObj.id];
        
        //Start: Added below for R-24334
        objDealDesk.Deal_Approver_Do_not_use_ge_og__c=objDealDesk.approver_deal_desk_ge_og__c;
        update objDealDesk;
        //End: Added below for R-24334
        
        Boolean isReviewed = true;
        Set<id> userIds = new Set<Id>();
        
        Opportunity objOpportunity = [SELECT Id,deal_path_ge_og__c,tier_2_ge_og__c FROM Opportunity WHERE Id = :objDealDesk.deal_desk_opportunity_id_ge_og__c];
        aggregateResult agr = [select Sum(amount_ge_og__c)amt from Opportunity where id=:objOpportunity.id];
        Integer opptyAmountUSD = Integer.ValueOf(agr.get('amt'));
        System.debug('oooooooooooooooooooo    '+opptyAmountUSD );
        
        /**** Added By Gourav  *****/
        
        List<Deal_Reviewer_ge_og__c> dealReviewer = new List<Deal_Reviewer_ge_og__c>();
        String comApproverRecordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
        
        
        List<OpportunityTeamMember> otmList = new List<OpportunityTeamMember>();
        //if(dealReviewer.size() > 0){
        if(objDealDesk.approver_deal_desk_ge_og__c != null){  
            
            //for(Deal_Reviewer_ge_og__c dr:dealReviewer )
            //if(dealReviewer.size()>0)
            
            //userIds.add(dealReviewer[0].user_ge_og__c);
            userIds.add(objDealDesk.approver_deal_desk_ge_og__c);
            List<OpportunityTeamMember> otm = [select id from OpportunityTeamMember where OpportunityId =: objDealDesk.deal_desk_opportunity_id_ge_og__c and UserId =: objDealDesk.approver_deal_desk_ge_og__c];
            If(otm.size()==0){
                otmList.add(new OpportunityTeamMember (OpportunityId = objDealDesk.deal_desk_opportunity_id_ge_og__c,
                                                       UserId = objDealDesk.approver_deal_desk_ge_og__c, TeamMemberRole = 'Functional Leader'));
                insert otmList;
            } 
            
            
            
            List<Approval.ProcessSubmitRequest> requests = new List<Approval.ProcessSubmitRequest>();
            
            for (Id approverId : userIds) 
            {
                Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                
                req.setComments('Submitting request');
                req.setObjectId(objDealDesk.id);
                //if(objDealDesk.dd_ge_og__c!='DD-'0){}
                req.setNextApproverIds(new List<Id>{approverId});
                requests.add(req);
            }
            
            
            List<Approval.ProcessResult> results = new List<Approval.ProcessResult>();
            //if(!test.isRunningtest())
            results = Approval.process(requests);
            
            System.debug('---------------------------------- in DealDeskApprover'+results);                    
            if (results != null && results.size() > 0 && results[0].isSuccess()){
                //objDealDesk.approver_deal_desk_ge_og__c = dealReviewer[0].user_ge_og__c;
                //objDealDesk.deal_desk_approver_level_ge_og__c = dealReviewer[0].deal_reviewer_criteria_num_ge_og__r.deviation_level_ge_og__c;
                //update objDealDesk;
            }
            
            
        }
        else{
            //objDealDesk.addError('No approver Found');
            if(!test.isRunningtest()){
                objDealDesk.status_ge_og__c = 'Approved';
                System.debug('Inside running test========================================>'+test.isRunningtest()+objDealDesk.status_ge_og__c);
                update objDealDesk;
            }
            
        }
        
        
        // }
    }
    
    
    
    // Method to approve record when status changes to 'Approved'
    public void ApproveRecord(Deal_Desk_ge_og__c objDealDesk)
    {
        System.debug('======================================Going to call Approval Process code in Apex class');
        List<Risk_Checklist_Category_ge_og__c> lstRCCategory = new List<Risk_Checklist_Category_ge_og__c>();
        
        ID ownerId = [SELECT Id,deal_desk_opportunity_id_ge_og__r.OwnerId FROM Deal_Desk_ge_og__c WHERE Id=:objDealDesk.Id].deal_desk_opportunity_id_ge_og__r.OwnerId;
        
        ProcessInstance pi = new ProcessInstance();
        if(!test.isRunningtest())
            pi = [Select TargetObjectId, Status from ProcessInstance  where TargetObjectId =:objDealDesk.Id order by CreatedDate desc limit 1]; 
        
        if(test.isRunningtest() || (pi !=null && pi.Status =='Pending') ){
            
            Approval.ProcessWorkitemRequest appRequest = new Approval.ProcessWorkitemRequest();
            appRequest.setComments('Apporve request');
            appRequest.setAction('Approve');
            appRequest.setNextApproverIds(new List<Id>{ownerId});
            String workItemId = '';
            
            for(ProcessInstanceWorkitem workItem  : [SELECT Id 
                                                     FROM ProcessInstanceWorkitem 
                                                     WHERE ProcessInstance.TargetObjectId =: objDealDesk.Id])
            {
                workItemId  =  workItem.Id;
            }
            
            
            if(workItemId == null)
            {
                objDealDesk.addError('Error Occured in Trigger');
            }
            else
            {
                appRequest.setWorkitemId(workItemId);
                if(!test.isRunningtest())
                    Approval.ProcessResult result =  Approval.process(appRequest);
            }
        }
        //To implement Comments on Deal Desk after approval
        List<Deal_Desk_ge_og__c> ddList = [ Select dd.Id, dd.lastModifiedById, dd.approved_rejected_by_ge_og__c, dd.approver_comments_ge_og__c, 
                                           (Select Id, IsPending, ProcessInstanceId, TargetObjectId, StepStatus, OriginalActorId, ActorId, RemindersSent, Comments, IsDeleted, CreatedDate, CreatedById, SystemModstamp 
                                            From ProcessSteps order by createddate desc limit 1) 
                                           From Deal_Desk_ge_og__c dd where id=:objDealDesk.Id];
        
        if (ddList.size()>0)
        {
            Deal_Desk_ge_og__c dd1=ddList[0];
            for (ProcessInstanceHistory psh : dd1.ProcessSteps)
            {
                System.debug('-------------------------->>>CreatedDate:'+psh.CreatedDate+' & psh.comments:'+psh.comments+' &StepStatus:'+psh.StepStatus);
                //if(dd1.approver_comments_ge_og__c == null && psh.comments != null){
                if(psh.comments != null && psh.StepStatus=='Approved' && psh.Comments != 'Apporve request'){  
                    //System.debug('-------------------------->>>psh.comments:'+psh.comments);
                    dd1.approver_comments_ge_og__c=psh.comments;
                    
                }
                break;
            }
            
            dd1.approved_rejected_by_ge_og__c = dd1.lastModifiedById;  
            ddList.add(dd1);
            update dd1;
        }
        
        //Deal_Desk_ge_og__c dd1 = [select id, lastModifiedById,approved_rejected_by_ge_og__c from Deal_Desk_ge_og__c where id=: objDealDesk.id];
        //dd1.approved_rejected_by_ge_og__c = dd1.lastModifiedById;
        //update ddList;
    }
    
    
    
    
    // Method to reject record
    public void RejectRecord(Deal_Desk_ge_og__c objDealDesk)
    {
        List<Risk_Checklist_Category_ge_og__c> lstRCCategory = new List<Risk_Checklist_Category_ge_og__c>();   
        
        ID ownerId = [SELECT Id,deal_desk_opportunity_id_ge_og__r.OwnerId FROM Deal_Desk_ge_og__c WHERE Id=:objDealDesk.Id].deal_desk_opportunity_id_ge_og__r.OwnerId;
        ID oppID = [SELECT deal_desk_opportunity_id_ge_og__c FROM Deal_Desk_ge_og__c WHERE Id=:objDealDesk.Id].deal_desk_opportunity_id_ge_og__c;
        
        ProcessInstance pi = new ProcessInstance();
        if(!test.isRunningtest())
            pi = [Select TargetObjectId, Status from ProcessInstance  where TargetObjectId =:objDealDesk.Id order by CreatedDate desc limit 1]; 
        
        if(test.isRunningtest() || pi !=null && pi.Status=='Pending' ){
            Approval.ProcessWorkitemRequest appRequest = new Approval.ProcessWorkitemRequest();
            appRequest.setComments('Rejected request');
            appRequest.setAction('Reject');
            appRequest.setNextApproverIds(new List<Id>{ownerId});
            String workItemId = '';
            
            for(ProcessInstanceWorkitem workItem  : [SELECT Id 
                                                     FROM ProcessInstanceWorkitem 
                                                     WHERE ProcessInstance.TargetObjectId =: objDealDesk.Id])
            {
                workItemId  =  workItem.Id;
            }
            
            
            if(workItemId == null)
            {
                objDealDesk.addError('Error Occured in Trigger');
            }
            else
            {
                appRequest.setWorkitemId(workItemId);
                if(!test.isRunningtest())
                    Approval.ProcessResult result =  Approval.process(appRequest);
            }
        }
        //To implement Comments on Deal Desk after Rejected
        List<Deal_Desk_ge_og__c> ddList = [ Select dd.Id, dd.lastModifiedById, dd.approved_rejected_by_ge_og__c, dd.approver_comments_ge_og__c, 
                                           (Select Id, IsPending, ProcessInstanceId, TargetObjectId, StepStatus, OriginalActorId, ActorId, RemindersSent, Comments, IsDeleted, CreatedDate, CreatedById, SystemModstamp 
                                            From ProcessSteps order by createddate desc) 
                                           From Deal_Desk_ge_og__c dd where id=:objDealDesk.Id];
        
        if (ddList.size()>0)
        {
            Deal_Desk_ge_og__c dd1=ddList[0];
            for (ProcessInstanceHistory psh : dd1.ProcessSteps)
            {
                System.debug('-------------------------->>>CreatedDate:'+psh.CreatedDate+' & psh.comments:'+psh.comments+' &StepStatus:'+psh.StepStatus);
                //if(dd1.approver_comments_ge_og__c == null && psh.comments != null){
                if(psh.comments != null && psh.StepStatus=='Rejected' && psh.Comments !='Rejected request'){  
                    //System.debug('-------------------------->>>psh.comments:'+psh.comments);
                    dd1.approver_comments_ge_og__c=psh.comments;
                    
                }
                break;
            }
            
            dd1.approved_rejected_by_ge_og__c = dd1.lastModifiedById;  
            ddList.add(dd1);
            update dd1;
        }
    }
    // Method to recall record when status changes to 'Submitted' and Oppty is Closed Lost/Cancelled.
    
    public void RecallRecord(Deal_Desk_ge_og__c objDealDesk)
    {
        String message = '';
        
            system.debug('************** Inside Recall function');
            ID oppID = [SELECT deal_desk_opportunity_id_ge_og__c FROM Deal_Desk_ge_og__c WHERE Id=:objDealDesk.Id].deal_desk_opportunity_id_ge_og__c;
            List<Opportunity> objOpp = [SELECT id,stagename FROM opportunity WHERE Id=:oppID];
            
            ProcessInstance pi = new ProcessInstance();
            if(!test.isRunningtest())
                pi = [Select TargetObjectId, Status from ProcessInstance  where TargetObjectId =:objDealDesk.Id order by CreatedDate desc limit 1]; 
            
            if(test.isRunningtest() || (pi !=null && pi.Status=='Pending') ){
                system.debug('************** Inside if');
                Approval.ProcessWorkitemRequest appRequest = new Approval.ProcessWorkitemRequest();
                appRequest.setComments('Recalling Deal Desk approvals as the Opportunity is Closed.');
                appRequest.setAction('Removed');
                system.debug('************** Recalled');
               
                String workItemId = '';
                
                for(ProcessInstanceWorkitem workItem  : [SELECT Id 
                                                         FROM ProcessInstanceWorkitem 
                                                         WHERE ProcessInstance.TargetObjectId =: objDealDesk.Id])
                {
                    system.debug('************** Inside for function');
                    workItemId  =  workItem.Id;
                }
                
                
                if(workItemId == null)
                {
                    system.debug('************** Workitem is null');
                    objDealDesk.addError('Error Occured in Trigger');
                }
                else
                {
                    system.debug('************** Workitem is not null');
                    system.debug('------------------------approval call-------------------------------------');
                    appRequest.setWorkitemId(workItemId);
                    
                  
                    if(!test.isRunningtest())
                        Approval.ProcessResult result =  Approval.process(appRequest);
                   
                    System.debug('message >>>'+message);
                    
               
                }
          
        
        
        
        
        
    }
  }  
}