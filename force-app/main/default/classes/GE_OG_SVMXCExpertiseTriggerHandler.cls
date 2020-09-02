public  class GE_OG_SVMXCExpertiseTriggerHandler {
    
    public void OnBeforeInsert(List<SVMXC__Service_Group_Skills__c> newObjects){
        GE_OG_GS_PrimaryExpertise.validateSinglePrimarySkill(newObjects, null, true);
    }

    public void OnAfterInsert(List<SVMXC__Service_Group_Skills__c> newObjects){
        GE_PC_ExpertiseTechnicianUpdate TechnicianUpdate = new GE_PC_ExpertiseTechnicianUpdate ();
            TechnicianUpdate.ExperienceUpdate(newObjects);
            
    }

    public void OnBeforeUpdate(List<SVMXC__Service_Group_Skills__c> oldObjects, List<SVMXC__Service_Group_Skills__c> newObjects, Map<Id, SVMXC__Service_Group_Skills__c> newObjectMap){
        GE_OG_GS_PrimaryExpertise.validateSinglePrimarySkill(newObjects, new Map<Id, SVMXC__Service_Group_Skills__c>(oldObjects), false);
    }

    public void OnAfterUpdate(List<SVMXC__Service_Group_Skills__c> oldObjects, List<SVMXC__Service_Group_Skills__c> newObjects, Map<Id, SVMXC__Service_Group_Skills__c> newObjectMap){
         GE_PC_ExpertiseTechnicianUpdate TechnicianUpdate = new GE_PC_ExpertiseTechnicianUpdate ();
            TechnicianUpdate.ExperienceUpdate(newObjects);
            
    }

    public void OnBeforeDelete(List<SVMXC__Service_Group_Skills__c> ObjectsToDelete, Map<Id, SVMXC__Service_Group_Skills__c> oldObjectMap){
        // BEFORE DELETE LOGIC
    }

    public void OnAfterDelete(List<SVMXC__Service_Group_Skills__c> deletedObjects, Map<Id, SVMXC__Service_Group_Skills__c> oldObjectMap){
        // AFTER DELETE LOGIC
    }

    public void OnUndelete(List<SVMXC__Service_Group_Skills__c> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
    
}