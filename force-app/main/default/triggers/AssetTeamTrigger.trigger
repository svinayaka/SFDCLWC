/*
Class/Trigger Name     : OpportunityTrigger_GE_OG
Purpose/Overview       : This trigger is called after Insert and update of Asset Team  records
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-30035.
Author                 : Harsha C
Created Date           : 20/NOV/2018
Test Class Name        :  
Code Coverage          : 
*/
trigger AssetTeamTrigger on BHGE_Asset_Team_ge_og__c (after insert,after update) {
    AssetTeamTriggerHandler_GE_OG assetteamtrgrhndlr = new AssetTeamTriggerHandler_GE_OG();
    if(trigger.isInsert && trigger.isAfter){
         assetteamtrgrhndlr.after_Insert_Functionality(trigger.new);
    }
    else if(trigger.isUpdate && trigger.isAfter){
       assetteamtrgrhndlr.after_Update_Functionality(trigger.new,trigger.oldmap);
    } 
    
}