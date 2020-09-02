/*
Class/Trigger Name     : Assign_O_RiskapproverPS
Used Where ?           : TPS_DealReviewerTrigger,DealReviewerTrigger
Purpose/Overview       : Helper Class for Trigger Deal_Reviewer_ge_og__c and TPS_Deal_Reviewer_ge_og__c
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-33379
Author                 : Harsha C
Created Date           : 27/DEC/2019
Test Class Name        : Assign_O_RiskapproverPS_Test
Code Coverage          : 
*/

public class Assign_O_RiskapproverPS {
    
    public static void assignO_RiskApprover_Permission_Set(List<Deal_Reviewer_ge_og__c> dealreviewer ){
        Set<Id> userIds = new Set<Id>();
        
        for(Deal_Reviewer_ge_og__c dealRevieweriteration : dealreviewer ){
            userIds.add(dealRevieweriteration.user_ge_og__c);
        }
        System.debug('userIds Assign_O_RiskapproverPS >>> '+userIds);
        assignpermissionset(userIds);
        
    }
    public static void assignO_RiskApprover_Permission_Set_TPS(List<TPS_Deal_Reviewer_ge_og__c> tpsdealreviewer ){
        Set<Id> userIds = new Set<Id>();
        
        for(TPS_Deal_Reviewer_ge_og__c tpsdealRevieweriteration : tpsdealreviewer ){
            userIds.add(tpsdealRevieweriteration.user_ge_og__c);
        }
        assignpermissionset(userIds);
    }
   @future
    public static void assignpermissionset(Set<Id> userIds){
        
        Set<Id> userIdsforpsassignment = new Set<Id>();
        Set<Id> alreadyPresent = new Set<Id>();
        Id psId ;
        List<PermissionSetAssignment> psa = [SELECT Id, PermissionSetId,PermissionSet.Name, PermissionSetGroupId, AssigneeId
                                             FROM PermissionSetAssignment where PermissionSet.Name='O_risk_approver_ge_og' AND AssigneeId IN:userIds];
        
        if(psa.size() > 0){
            for(PermissionSetAssignment ps:psa){
                psId = ps.PermissionSetId;
                if(userIds.contains(ps.AssigneeId)){
                    alreadyPresent.add(ps.AssigneeId);  
                }
            }
        }else{
            PermissionSet ps = [SELECT Id, Name FROM PermissionSet where Name='O_risk_approver_ge_og'];
            psId = ps.Id;
            userIdsforpsassignment.addAll(userIds);
        }
        for(Id userId : userIds){
            if(alreadyPresent.size() > 0){
                if(alreadyPresent.contains(userId)){
                    
                }else{
                   
                    userIdsforpsassignment.add(userId);  
                }
            }
        }
        List<PermissionSetAssignment> psaList = new List<PermissionSetAssignment>();
        if(userIdsforpsassignment.size() > 0){
            for(Id assignPS :userIdsforpsassignment ){
                System.debug('inside permission set >>> assignPs '+assignPS);
                PermissionSetAssignment ps= new PermissionSetAssignment(); 
                ps.AssigneeId = assignPS;
                ps.PermissionSetId = psId;
                psaList.add(ps);
            }
        }
        if(psaList.size() > 0){
            System.debug('psaList >>> '+psaList);
            insert psaList;
        }
    } 
}