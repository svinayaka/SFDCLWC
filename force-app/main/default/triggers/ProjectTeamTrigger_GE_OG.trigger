/*
Class/Trigger Name     : ProjectTeamTrigger_GE_OG
Purpose/Overview       : Whenever new team member has beed added to the team , All the team member will get email notification
Scrum Team             : Transformation - Project MGMT
Created Date           : 14/July/2017
Test Class Name        : TestProjectTeamTriggerHandler_GE_OG
Code Coverage          : 
*/

trigger ProjectTeamTrigger_GE_OG  on Project_Team_Member_GE_OG__c (before insert,before update, After Insert, After Update) {

    ProjectTeamTriggerHandler_GE_OG objProjHandler = new ProjectTeamTriggerHandler_GE_OG();
    
    Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'ProjectTeamTrigger_GE_OG' limit 1];
    
    boolean isEnabled = true;
    
    if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
    
    if(isEnabled){
   
      if(trigger.isAfter && trigger.isInsert){  
                objProjHandler.after_Insert_Functionality(trigger.new); 
           }
              
      if(trigger.isAfter && trigger.isUpdate){  
               objProjHandler.after_Update_Functionality(trigger.new,trigger.oldmap); 
       }
    }
    else
        System.debug('ProjectTeamTrigger_GE_OG is disabled via Trigger_Toggle__mdt setting');

}