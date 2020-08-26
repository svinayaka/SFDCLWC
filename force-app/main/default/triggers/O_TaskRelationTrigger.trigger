/*
Class/Trigger Name     : Task_Relation_ge_og__c
Purpose/Overview       : This trigger is called after insert of Task Relation invitee records
Scrum Team             : Opportunity MGMT
Requirement Number     : R-24402
Author                 : Gourav Anand
Created Date           : 20/Dec/2016
Test Class Name        : LastActivityDateOpportunityTrg_Test 
Code Coverage          : 90
*/

trigger O_TaskRelationTrigger on Task_Relation_ge_og__c (after insert) {

Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'O_TaskRelationTrigger' limit 1];
    
    boolean isEnabled = true;
    
    if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
    
    
    if(trigger.isInsert && trigger.isAfter ){
    System.debug('---------Entering into O_TaskRelationTrigger after Insert');
    //Initializing Variable
    List<String> inviteeIds = new List<String>();
    
            
    //For loop to identify whether task is related to any Opportunity or not.
    for(Task_Relation_ge_og__c tRel:trigger.new) {
        if(tRel.Invitee_ID_ge_og__c !=null || tRel.Invitee_ID_ge_og__c !=''){
            inviteeIds.add(tRel.Invitee_ID_ge_og__c);
            
        }
     }
    System.debug('--------- inviteeIds.size()'+inviteeIds.size());  
    if(isEnabled){  
    if(inviteeIds.size()>0){  
        EmailToOpptyTeamMemebrs_GE_OG taskEmailDMTeamNotify = new EmailToOpptyTeamMemebrs_GE_OG();
        taskEmailDMTeamNotify.emailToTaskInviteeOnAdd(trigger.new);  
    }
    }
  }  
}