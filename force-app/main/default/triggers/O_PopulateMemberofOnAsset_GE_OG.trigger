/*
Class/Trigger Name  :   O_PopulateMemberofOnAsset_GE_OG 
Purpose/Overview    :   Used to carry different calculations on Asset & BHGE Asset Team
Scrum Team          :   OPPTY MGMT
Requirement Number  : 
Author              :   Rupal Seth
Created Date        :   27/MAR/2018
Test Class Name     :   
Code Coverage       : 
*/

trigger O_PopulateMemberofOnAsset_GE_OG on Asset (before insert, after insert, after update, before update) {
    
    O_AssetTriggerHandler_GE_OG objAssetHandler = new O_AssetTriggerHandler_GE_OG();
    
    O_PopulateMemberofOnAssetHandler_GE_OG assetHandler = new O_PopulateMemberofOnAssetHandler_GE_OG();
    
    KeyAssetEdit_GE_OG keyassetedit = new KeyAssetEdit_GE_OG();
    
    Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'O_PopulateMemberofOnAsset_GE_OG' limit 1];
    
    boolean isEnabled = true;
    
    if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
    
    if(isEnabled){
        if(trigger.isInsert && trigger.isBefore){
            assetHandler.populateMemberOf(trigger.new);               
        }
        
        //Added - Kiru
        if(trigger.isUpdate && trigger.isBefore){
            assetHandler.populateMemberOfonupdate(trigger.new, trigger.oldmap);
          }
        
        if(trigger.isAfter && trigger.isInsert){  
            objAssetHandler.after_Insert_Functionality(trigger.new,trigger.newMap);
        }
        
        if(trigger.isAfter && trigger.isUpdate){  
            objAssetHandler.after_Update_Functionality(trigger.new,trigger.newMap, trigger.old, trigger.oldMap);
             //Added by Harsha C - R-30237
            keyassetedit.removeKeyasset(trigger.new, trigger.newmap, trigger.old, trigger.oldmap);
       
        }
    }
    else
        System.debug('O_PopulateMemberofOnAsset_GE_OG is disabled via Trigger_Toggle__mdt setting');
}