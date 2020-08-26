/*
Class/Trigger Name     : O_CampaignMember_Trig_GE_OG
Purpose/Overview       : Used for creating CMR record and updating Leads/Contacts 
Scrum Team             : OPPORTUNITY MGMT
Requirement Number     : R-25269
Author                 : Gourav Anand
Created Date           : 01/Feb/2017
Test Class Name        : O_CampaignMember_Trig_GE_OG_Test
Code Coverage          : 
*/

trigger O_CampaignMember_Trig_GE_OG on CampaignMember (before insert, before update, after update, after insert, after delete) {
    
 Opportunity_Trigger_Controller_ge_og__c custmObj = Opportunity_Trigger_Controller_ge_og__c.getValues('O_CampaignMember_Trig_GE_OG');
       
 if(custmObj !=null && custmObj.Is_Active_ge_og__c && custmObj.Object_ge_og__c=='CampaignMember'){  
    
    O_CampaignMemberHandler_GE_OG cmrHandler = new O_CampaignMemberHandler_GE_OG();
    if(trigger.isInsert && trigger.isBefore){
        System.debug('------------------------Entering into O_CampaignMember_Trig_GE_OG.beforeInsert-->');
        cmrHandler.updateContactLeadDetails(trigger.new);
        
    }
    if(trigger.isUpdate && trigger.isBefore ) {
        System.debug('------------------------Entering into O_CampaignMember_Trig_GE_OG.automateCMRstatus-->');
        CheckRecursion_GE_OG.cmrRecusrion();
            IF(CheckRecursion_GE_OG.taskRun==true && !system.isBatch()){
                 System.debug('------------------------Entering into O_CampaignMember_Before lOOP-->');
                cmrHandler.automateCMRstatusTransition(trigger.new,trigger.oldMap);
                 System.debug('------------------------Entering into O_CampaignMember_Trig_GE_OG After Loop-->');
            }
    }
    /** Event Management code -- start **/
    if(trigger.isInsert && trigger.isAfter)
    {
        eventManagementHandler.processInsertCMRs(trigger.new);
    }
    if(trigger.isUpdate && trigger.isAfter)
    {
        eventManagementHandler.processCMRsOnUpdate(trigger.new, false);
    }
    if(trigger.isDelete && trigger.isAfter)
    {
        system.debug('HERE+++>>>>>>>> CMR DELETE TRIGGER');
        eventManagementHandler.processCMRsOnUpdate(trigger.old, true);
    }
     
  /** Event Management code -- end**/
  
  
  }
  else{     
        return;
  }  
}