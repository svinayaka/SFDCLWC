/*
Class/Trigger Name     : RiskChecklistReviewer_GE_OG
Used For               : RiskChecklistController_GE_OG
Purpose/Overview       : This class initiates the Approval Process for Risk Checklist Category on submission and approval
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-24331
Author                 : Madhuri Sharma
Created Date           : 15-Mar-2016
Test Class Name        : RiskChecklistReviewer_GE_OG_Test
Code Coverage          : 
*/

public class RiskChecklistReviewer_GE_OG {  
   
    
    // Method to submit record to Risk Checklist Reviewer 
    public void submitRecord(Risk_Checklist_Category_ge_og__c  rccObject ,String dealReviewerId,Map<Id,Id> rccOpptyMap){
        
        //Initialise variables
        Map<String,Deal_Reviewer_ge_og__c> riskChecklistReviewerMap= new Map<String,Deal_Reviewer_ge_og__c>();
        List<OpportunityTeamMember> otmList = new List<OpportunityTeamMember>();
        Set<id> userIds = new Set<Id>();
        
        Risk_Checklist_Category_ge_og__c rcc = [select id, rcl_reviewer_ge_og__c,rcl_category_ge_og__c,tier_2_ge_og__c,risk_checklist_tier_3_ge_og__c,region_ge_og__c,
                                max_deviation_ge_og__c,RCC_Opportunity_ge_og__c from Risk_Checklist_Category_ge_og__c where id=:rccObject.id];
       //Added below for R-24334
       rcc.Risk_Reviewer_Do_not_use_ge_og__c=rcc.rcl_reviewer_ge_og__c;
       update rcc;
       //End added below for R-24334 
             
        if(dealReviewerId != null && dealReviewerId != ''){
                    
            List<OpportunityTeamMember> otm = [select id from OpportunityTeamMember where OpportunityId =: rcc.RCC_Opportunity_ge_og__c and UserId =: dealReviewerId];
            userIds.add(dealReviewerId);
            System.debug('n\n User Id '+userIds);
            
            if(otm.size()==0){
                otmList.add(new OpportunityTeamMember (OpportunityId = rcc.RCC_Opportunity_ge_og__c,
                                                     UserId = dealReviewerId, TeamMemberRole = 'Reviewer'));
            }
            
            List<Approval.ProcessSubmitRequest> requests = new List<Approval.ProcessSubmitRequest>();

            for (Id reviewerId : userIds) 
            {
                    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();

                    req.setComments('Submitting request');
                    req.setObjectId(rccObject.id);
                    req.setNextApproverIds(new List<Id>{reviewerId});
                    requests.add(req);
            }
            
            List<Approval.ProcessResult> results;
            if(!test.isRunningtest())
             results = Approval.process(requests);
        }
      
       
        if(otmList.size()>0){
            insert otmList;
        }
        
        
    }
    
    // Method to ApproveRecord record 
    public void approveRecord(Risk_Checklist_Category_ge_og__c  rccObject)
    {
        ID ownerId = [SELECT Id, rcl_reviewer_ge_og__c,rcl_category_ge_og__c,tier_2_ge_og__c,risk_checklist_tier_3_ge_og__c,region_ge_og__c,
                                max_deviation_ge_og__c from Risk_Checklist_Category_ge_og__c where id=:rccObject.Id].rcl_reviewer_ge_og__c ;
        
      ProcessInstance pi = new ProcessInstance();
        if(!test.isRunningtest())
        pi = [Select TargetObjectId, Status from ProcessInstance  where TargetObjectId =:rccObject.Id order by CreatedDate desc limit 1]; 
      
      Boolean isSkuidCall=False;  
      if(test.isRunningtest() || (pi !=null && pi.Status =='Pending')){  
        isSkuidCall=true;  
        Approval.ProcessWorkitemRequest appRequest = new Approval.ProcessWorkitemRequest();
        appRequest.setComments('Apporve request');
        appRequest.setAction('Approve');
        appRequest.setNextApproverIds(new List<Id>{ownerId});
        String workItemId = '';
        
        for(ProcessInstanceWorkitem workItem  : [SELECT Id FROM ProcessInstanceWorkitem 
                                                 WHERE ProcessInstance.TargetObjectId =: rccObject.Id])
        {
            workItemId  =  workItem.Id;
        }
        
        appRequest.setWorkitemId(workItemId);
        if(!test.isRunningtest())
            Approval.ProcessResult result =  Approval.process(appRequest);
      }  
        //To implement Comments on Risk modules after approval
        List<Risk_Checklist_Category_ge_og__c> rccList = [ Select dd.Id, dd.lastModifiedById, dd.Risk_Reviewer_Do_not_use_ge_og__c, dd.reviewer_comments_ge_og__c, 
                                           (Select Id, IsPending, ProcessInstanceId, TargetObjectId, StepStatus, OriginalActorId, ActorId, RemindersSent, Comments, IsDeleted, CreatedDate, CreatedById, SystemModstamp 
                                                     From ProcessSteps order by createddate desc limit 1) 
                      From Risk_Checklist_Category_ge_og__c dd where id=:rccObject.Id];
        
        if (rccList.size()>0)
        {
            Risk_Checklist_Category_ge_og__c dd1=rccList[0];
            for (ProcessInstanceHistory psh : dd1.ProcessSteps)
            {
                System.debug('-------------------------->>>CreatedDate:'+psh.CreatedDate+' & psh.comments:'+psh.comments+' &StepStatus:'+psh.StepStatus);
                //if(dd1.approver_comments_ge_og__c == null && psh.comments != null){
                if(psh.comments != null && psh.StepStatus=='Approved' && psh.Comments != 'Apporve request'){  
                //System.debug('-------------------------->>>psh.comments:'+psh.comments);
                      dd1.reviewer_comments_ge_og__c=psh.comments;
                      
                }
                break;
            }
            
            if(!isSkuidCall)
                update dd1;
         }
       
    }
    
    // Method to Reject record 
   public void rejectRecord(Risk_Checklist_Category_ge_og__c  rccObject)
    {
        ID ownerId = [SELECT Id, rcl_category_ge_og__c, rcl_reviewer_ge_og__c, tier_2_ge_og__c,risk_checklist_tier_3_ge_og__c,region_ge_og__c,
                                max_deviation_ge_og__c from Risk_Checklist_Category_ge_og__c where id=:rccObject.Id].rcl_reviewer_ge_og__c ;
      
        ProcessInstance pi = new ProcessInstance();
        if(!test.isRunningtest())
        pi = [Select TargetObjectId, Status from ProcessInstance  where TargetObjectId =:rccObject.Id order by CreatedDate desc limit 1]; 
       
       if(test.isRunningtest() || (pi !=null && pi.Status =='Pending')){    
        
        Approval.ProcessWorkitemRequest appRequest = new Approval.ProcessWorkitemRequest();
        appRequest.setComments('Rejected request');
        appRequest.setAction('Reject');
        appRequest.setNextApproverIds(new List<Id>{ownerId});
        String workItemId = '';
        
        for(ProcessInstanceWorkitem workItem  : [SELECT Id 
                                                 FROM ProcessInstanceWorkitem 
                                                 WHERE ProcessInstance.TargetObjectId =: rccObject.Id])
        {
            workItemId  =  workItem.Id;
        }


        appRequest.setWorkitemId(workItemId);
        if(!test.isRunningtest())
        Approval.ProcessResult result =  Approval.process(appRequest);
      }
      //To implement Comments on Risk modules after approval
        List<Risk_Checklist_Category_ge_og__c> rccList = [ Select dd.Id, dd.lastModifiedById, dd.Risk_Reviewer_Do_not_use_ge_og__c, dd.reviewer_comments_ge_og__c, 
                                           (Select Id, IsPending, ProcessInstanceId, TargetObjectId, StepStatus, OriginalActorId, ActorId, RemindersSent, Comments, IsDeleted, CreatedDate, CreatedById, SystemModstamp 
                                                     From ProcessSteps order by createddate desc limit 1) 
                      From Risk_Checklist_Category_ge_og__c dd where id=:rccObject.Id];
        
        if (rccList.size()>0)
        {
            Risk_Checklist_Category_ge_og__c dd1=rccList[0];
            for (ProcessInstanceHistory psh : dd1.ProcessSteps)
            {
                System.debug('-------------------------->>>CreatedDate:'+psh.CreatedDate+' & psh.comments:'+psh.comments+' &StepStatus:'+psh.StepStatus);
                //if(dd1.approver_comments_ge_og__c == null && psh.comments != null){
                if(psh.comments != null && psh.StepStatus=='Rejected' && psh.Comments != 'Rejected request'){  
                //System.debug('-------------------------->>>psh.comments:'+psh.comments);
                      dd1.reviewer_comments_ge_og__c=psh.comments;
                      
                }
                break;
            }
            
            dd1.Risk_Reviewer_Do_not_use_ge_og__c = dd1.lastModifiedById;   
            //ddList.add(dd1);
            update dd1;
         }  
       
    }
    
     // Method to Recall record 
   public void recallRecord(List<Risk_Checklist_Category_ge_og__c>  rccObject)
    {
    Set<Id> rccId = new Set<Id>();
    For(Risk_Checklist_Category_ge_og__c rcc:rccObject){
    
    rccId.add(rcc.Id); 
    }   
     System.debug('Risk Checklist Category Ids******************'+rccId);
       ProcessInstance PI = new ProcessInstance();
       List<ProcessInstance> PIlist = new List<ProcessInstance>();
        
        PIlist  = [Select TargetObjectId, Status from ProcessInstance  where TargetObjectId =:rccId AND Status = 'Pending' order by CreatedDate desc]; 
       String workItemId = '';
      // if(test.isRunningtest() || (pi !=null && pi.Status =='Pending')){    
        
        Approval.ProcessWorkitemRequest appRequest = new Approval.ProcessWorkitemRequest();
        appRequest.setComments('Recalling Risk approvals as the Opportunity is Closed.');
        appRequest.setAction('Removed');
        //appRequest.setNextApproverIds(new List<Id>{ownerId});
        
       
        for(ProcessInstanceWorkitem workItem  : [SELECT Id 
                                                 FROM ProcessInstanceWorkitem 
                                                 WHERE ProcessInstance.TargetObjectId =: rccId AND ProcessInstance.Id =: PIlist ])
        {
            workItemId  =  workItem.Id;
            appRequest.setWorkitemId(workItemId);
            Approval.ProcessResult result =  Approval.process(appRequest);
        }

    System.debug('workItemId  ******************'+workItemId  );
        
        
        
       
    }
    

}