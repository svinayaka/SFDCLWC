/*
Class Name                   - GE_OG_SVMX_Service_Group_TriggerHandler 
Object Name                  - SVMXC__Service_Group__c 
Created Date                 - 12/24/2018
Description                  -  Handler Class GE_OG_SVMX_Service_Group_TriggerHandler would process all the Trigger requests coming from GE_OG_SVMX_Service_Group_Trigger
All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/
    public without sharing class GE_OG_SVMX_Service_Group_TriggerHandler {
    
    public void OnBeforeInsert(List<SVMXC__Service_Group__c > newObjects)
    {
     // EXECUTE BEFORE INSERT LOGIC
     }
    
    public void OnAfterInsert(List<SVMXC__Service_Group__c > newObjects)
    {    
        // EXECUTE AFTER INSERT LOGIC
         
        }
    
    public void OnBeforeUpdate(List<SVMXC__Service_Group__c > oldObjects, List<SVMXC__Service_Group__c > newObjects, Map<Id, SVMXC__Service_Group__c > newObjectMap)
    { 
    
         // EXECUTE BEFORE UPDATE LOGIC
        
    }
    
    public void OnAfterUpdate(List<SVMXC__Service_Group__c > oldObjects, List<SVMXC__Service_Group__c > newObjects, Map<Id, SVMXC__Service_Group__c > newObjectMap, Map<Id, SVMXC__Service_Group__c > oldObjectMap)
    {
        // EXECUTE AFTER UPDATE LOGIC
        GE_DS_Update_ManagerEmail mgnremailupdate = new GE_DS_Update_ManagerEmail();
        mgnremailupdate.UpdateManageremail(newObjects);
    }
    
    public void OnBeforeDelete(List<SVMXC__Service_Group__c > ObjectsToDelete, Map<Id, SVMXC__Service_Group__c > oldObjectMap)
    {
        // EXECUTE BEFORE DELETE LOGIC
        
    }
    
    public void OnAfterDelete(List<SVMXC__Service_Group__c > deletedObjects, Map<Id, SVMXC__Service_Group__c > oldObjectMap)
    {
        
        // EXECUTE AFTER DELETE LOGIC
    }
    
    public void OnUndelete(List<SVMXC__Service_Group__c > restoredObjects)
    {
        // AFTER UNDELETE LOGIC
    }
    
    
}