/*
Class/Trigger Name     : OpportunityProductTrigger_GE_OG 
Used For               : Creating and Deleting CQA checklist(Fulfillment checklist).
Purpose/Overview       : Creating and deleting  CQA checklist(Fulfillment checklist) when product is added or removed after creation of CQA checklist.
Scrum Team             : Transformation - Deal MGMT
Test Class             : CQAChecklistController_GE_OG_Test
Requirement Number     : R-23478
Author                 : Nitish Pandey
Created Date           : 17-Sep-2015

*/



trigger OpportunityProductTrigger_GE_OG on OpportunityLineItem (after Insert, after delete, before Insert, after update) {

    Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'OpportunityProductTrigger_GE_OG' limit 1];
    
    boolean isEnabled = true;
    
    if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
    
    if(isEnabled){
    if(trigger.isBefore){
        if(trigger.isInsert){
            system.debug(' Before Insert 1');
            OpportunityProductTriggerHandler_GE_OG objHandler = new OpportunityProductTriggerHandler_GE_OG();
            objHandler.beforeInsertFunctionality(trigger.new);
            system.debug(' Before Insert 2');
        }
    }
    
    if(trigger.isAfter){
        if(trigger.isInsert){
            system.debug(' Before Insert 3');
            OpportunityProductTriggerHandler_GE_OG objHandler = new OpportunityProductTriggerHandler_GE_OG();
            objHandler.afterInsertFuctionality(trigger.new);           
            system.debug(' Before Insert 4');
        }
    }
        
    if(trigger.isAfter){
        if(trigger.isUpdate){
            system.debug(' After Update 4');
            O_UpdateRevenueScheduleIncludedFlag updateRevSchHandler = new O_UpdateRevenueScheduleIncludedFlag();
            updateRevSchHandler.afterUpdateHandler(trigger.new);
            system.debug(' After Update 5');            
        }
    }
    if(trigger.isAfter){
        if(trigger.isDelete){
            OpportunityProductTriggerHandler_GE_OG objHandler = new OpportunityProductTriggerHandler_GE_OG();
            objHandler.beforeDeleteFuctionality(trigger.old);
            system.debug('After delete 5');
            OLIMulitiTierHandler_GE_OG oliMultiTier = new OLIMulitiTierHandler_GE_OG();
            oliMultiTier.afterDeleteHandler(trigger.old);
            system.debug('After delete 6');
            O_DeleteRevenueLines_GE_OG deleterevLines = new O_DeleteRevenueLines_GE_OG();
            deleterevLines.deleteRevenueLines(trigger.old);
            OpportunityProductTriggerHandler_GE_OG.afterDeleteFunctionality(Trigger.old) ; //R-31943
        }
    }
    }
    else
        System.debug('OpportunityTrigger_GE_OG is disabled via Trigger_Toggle__mdt setting');
}