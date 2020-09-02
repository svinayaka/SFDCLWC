/*
Class Name                   - GE_AL_PullTriggerHandler 
Object Name                  - Pull
Created Date                 - 9/1/2016
Description                  -  Handler Class GE_AL_PullTriggerHandler would process all the Trigger requests coming from GE_AL_PullTrigger 
                                All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/
public without sharing class GE_AL_PullTriggerHandler {

    /*public void OnBeforeInsert(List<P__c> newObjects){
        // EXECUTE BEFORE INSERT LOGIC
       
    }*/
    public void OnAfterInsert(List<P__c> newObjects){
        // EXECUTE AFTER INSERT LOGIC
        
        GE_AL_PullHelper pullHelper = new GE_AL_PullHelper();
        pullHelper.UpdateWellRunData(newObjects);
        //Added part of the R-25001
        pullHelper.UpdateEquipmentrundata(newObjects);         
        
    }
   /* public void OnBeforeUpdate(List<P__c> oldObjects, List<P__c> newObjects, Map<Id, P__c> newObjectMap){
        // BEFORE UPDATE LOGIC
    }
    public void OnAfterUpdate(List<P__c> oldObjects, List<P__c> newObjects, Map<Id, P__c> newObjectMap){
        // AFTER UPDATE LOGIC
    } 
    public void OnBeforeDelete(List<P__c> ObjectsToDelete, Map<Id, P__c> oldObjectMap){
        // BEFORE DELETE LOGIC
    }
    
    public void OnAfterDelete(List<P__c> deletedObjects, Map<Id, P__c> oldObjectMap){
        // AFTER DELETE LOGIC
    }
    
    public void OnUndelete(List<P__c> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
    */
}