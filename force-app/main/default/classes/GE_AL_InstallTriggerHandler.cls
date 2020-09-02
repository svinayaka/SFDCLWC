/*
Class Name                   - GE_AL_InstallTriggerHandler 
Object Name                  - Install
Created Date                 - 11/9/2016
Description                  -  Handler Class GE_AL_InstallTriggerHandler would process all the Trigger requests coming from GE_AL_InstallTrigger 
                                All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
Test Class                   -  GE_AL_InstallHelper_Test                                
*/
public without sharing class GE_AL_InstallTriggerHandler {

    /*public void OnBeforeInsert(List<I__c> newObjects){
        // EXECUTE BEFORE INSERT LOGIC
       
    }*/
    public void OnAfterInsert(List<I__c> newObjects){
        // EXECUTE AFTER INSERT LOGIC
        
        GE_AL_InstallHelper installHelper = new GE_AL_InstallHelper();
        installHelper.CreateEquipmentRunData(newObjects);         
        
    }
   /* public void OnBeforeUpdate(List<I__c> oldObjects, List<I__c> newObjects, Map<Id, I__c> newObjectMap){
        // BEFORE UPDATE LOGIC
    }
    public void OnAfterUpdate(List<I__c> oldObjects, List<I__c> newObjects, Map<Id, I__c> newObjectMap){
        // AFTER UPDATE LOGIC
    } 
    public void OnBeforeDelete(List<I__c> ObjectsToDelete, Map<Id, I__c> oldObjectMap){
        // BEFORE DELETE LOGIC
    }
    
    public void OnAfterDelete(List<I__c> deletedObjects, Map<Id, I__c> oldObjectMap){
        // AFTER DELETE LOGIC
    }
    
    public void OnUndelete(List<I__c> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
    */
}