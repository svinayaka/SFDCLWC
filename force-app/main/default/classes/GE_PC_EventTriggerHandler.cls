/*
Class Name                   - GE_PC_EventTriggerHandler 
Object Name                  - Event
Created Date                 - 2/24/2015
Description                  -  Handler Class GE_PC_EventTriggerHandler would process all the Trigger requests coming for PC WorkOrder
All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/

public without sharing class GE_PC_EventTriggerHandler{
       
    public void OnBeforeInsert(List<Event> newObjects){
        // EXECUTE BEFORE INSERT LOGIC        
    }
    
    public void OnAfterInsert(List<Event> newObjects){          
        // EXECUTE AFTER INSERT LOGIC         
        //Created class GE_OG_PC_EventHelper 
        GE_PC_EventHelper eventHelper = new GE_PC_EventHelper();
        eventHelper.afterInsertEvent(newObjects);
    }
    
    public void OnBeforeUpdate(List<Event> oldObjects, List<Event> newObjects, Map<Id, Event> newObjectMap){
        // BEFORE UPDATE LOGIC      
     }
    
    public void OnAfterUpdate(List<Event> oldObjects, List<Event> newObjects, Map<Id, Event> newObjectMap){
         // AFTER UPDATE LOGIC      
    }
    
    public void OnBeforeDelete(List<Event> ObjectsToDelete, Map<Id, Event> oldObjectMap){
        // BEFORE DELETE LOGIC
    }
    
    public void OnAfterDelete(List<Event> deletedObjects, Map<Id, Event> oldObjectMap){
        // AFTER DELETE LOGIC
    }
    
    public void OnUndelete(List<Event> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
    
}