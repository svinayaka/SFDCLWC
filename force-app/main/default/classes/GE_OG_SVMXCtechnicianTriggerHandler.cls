/*
Class Name                   - GE_OG_SVMXCtechnicianTriggerHandler 
Object Name                  - SVMXC__Service_Group_Members__c
Created Date                 - 7/22/2014
LastModifiedDate             -7/12/2016
LastModifiedOwner            -Nehal
Description                  -  Handler Class GE_OG_SVMXCtechnicianTriggerHandler would process all the Trigger requests coming from GE_OG_ContactTrigger
All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/
public without sharing class GE_OG_SVMXCtechnicianTriggerHandler {
    
    public void OnBeforeInsert(List<SVMXC__Service_Group_Members__c> newObjects){
        // EXECUTE BEFORE INSERT LOGIC
        //GE_OG_MCS_UniqueTechncian UnqTech=new GE_OG_MCS_UniqueTechncian();
        //UnqTech.beforeinsertTech(newObjects);
        //R-24803 added by Nehal 
         TechnicianRegionUpdate_GE_OG Techregion = new TechnicianRegionUpdate_GE_OG();
         Techregion.updateTechRegion(newObjects);
        
        Set<Id> resultIds = new set<Id>();
        //set<Id>(new Map<Id,SVMXC__Service_Group_Members__c>(newObjects).keySet());
        Map<Id, id> mapTech = new Map<Id, id>();
        Map<Id, integer> MapTechnician = new Map<Id, integer>();
        List<id> lstServiceTeamId = new List<id>();
        for(SVMXC__Service_Group_Members__c tmpRec : newObjects)
        {
            resultIds.add(tmpRec.id);
            
        }
        system.debug('resultIds--->' + resultIds);
        for(SVMXC__Service_Group_Members__c objTechToTeam: [select name, id , SVMXC__Service_Group__c from SVMXC__Service_Group_Members__c where id IN : resultIds]) //get all service team ids where technicians are assigned
        {
            //mapTech.Put(objTechToTeam.id, objTechToTeam.SVMXC__Service_Group__c);// ids of all tech to Service team
            //mapTechician.Put(objTech.id, objTech); //map of all technician (child)
            //system.debug('mapTech--->' + mapTech);
            if(objTechToTeam.SVMXC__Active__c = true)
            lstServiceTeamId.add(objTechToTeam.SVMXC__Service_Group__c);
        }
        //for each service team count technicians
        if(lstServiceTeamId.size() > 0 )
        {
        AggregateResult[] countTechInTeam = [select count(Id) numTech, SVMXC__Service_Group__c from SVMXC__Service_Group_Members__c where SVMXC__Service_Group__c IN : lstServiceTeamId AND SVMXC__Active__c = true Group by SVMXC__Service_Group__c];
             for(AggregateResult ar:countTechInTeam)
             {
                 integer intCount = (integer)ar.get('numTech');
                 Id objServiceTeam = (ID)ar.get('SVMXC__Service_Group__c');
                 MapTechnician.put(objServiceTeam, intCount);
                             system.debug('MapTechnician--->' + MapTechnician);
                             system.debug('intCount--->' + intCount);
                 //mapTechician.get(SVMXC__Service_Group__c)
             }               
        for(SVMXC__Service_Group_Members__c objTech : newObjects)
        {
            objTech.Total_technicians_in_service_team__c = MapTechnician.get(objTech.SVMXC__Service_Group__c);
           // if(objTech.SVMXC__Active__c == true)
               // objTech.Total_technicians_in_service_team__c = objTech.Total_technicians_in_service_team__c + 1;
            system.debug('objTech--->' + objTech);
        }
            //integer a = 1/0;
        }
    }
    
    public void OnAfterInsert(List<SVMXC__Service_Group_Members__c> newObjects){
        // EXECUTE AFTER INSERT LOGIC
        
        
    }
    
    public void OnBeforeUpdate(List<SVMXC__Service_Group_Members__c> oldObjects, List<SVMXC__Service_Group_Members__c> newObjects, Map<Id, SVMXC__Service_Group_Members__c> newObjectMap){
        // BEFORE UPDATE LOGIC
        //GE_OG_MCS_UniqueTechncian UnqTech=new GE_OG_MCS_UniqueTechncian();
        //UnqTech.beforeupdateTech(oldObjects,newObjects,newObjectMap);
        
          //R-24803 added by Nehal 
        TechnicianRegionUpdate_GE_OG Techregion = new TechnicianRegionUpdate_GE_OG();
         Techregion.updateTechRegion(newObjects);
        
         Set<Id> resultIds = new set<Id>(new Map<Id,SVMXC__Service_Group_Members__c>(newObjects).keySet());
        Map<Id, id> mapTech = new Map<Id, id>();
        Map<Id, integer> MapTechnician = new Map<Id, integer>();
        List<id> lstServiceTeamId = new List<id>();
        system.debug('resultIds--->' + resultIds);
        for(SVMXC__Service_Group_Members__c objTechToTeam: [select name, id , SVMXC__Service_Group__c from SVMXC__Service_Group_Members__c where id IN : resultIds]) //get all service team ids where technicians are assigned
        {
            //mapTech.Put(objTechToTeam.id, objTechToTeam.SVMXC__Service_Group__c);// ids of all tech to Service team
            //mapTechician.Put(objTech.id, objTech); //map of all technician (child)
            //system.debug('mapTech--->' + mapTech);
            if(objTechToTeam.SVMXC__Active__c = true)
            lstServiceTeamId.add(objTechToTeam.SVMXC__Service_Group__c);
            system.debug('lstServiceTeamId--->' + lstServiceTeamId);
        }
        //for each service team count technicians
        if(lstServiceTeamId.size() > 0 )
        {
        AggregateResult[] countTechInTeam = [select count(Id) numTech, SVMXC__Service_Group__c from SVMXC__Service_Group_Members__c where SVMXC__Service_Group__c IN : lstServiceTeamId  AND SVMXC__Active__c = true Group by SVMXC__Service_Group__c];
             for(AggregateResult ar:countTechInTeam)
             {
                 integer intCount = (integer)ar.get('numTech');
                 Id objServiceTeam = (ID)ar.get('SVMXC__Service_Group__c');
                 MapTechnician.put(objServiceTeam, intCount);
                             system.debug('MapTechnician--->' + MapTechnician);
                             system.debug('intCount--->' + intCount);
                 //mapTechician.get(SVMXC__Service_Group__c)
             }           
        ///for(SVMXC__Service_Group_Members__c objAllTech   :[select id, SVMXC__Active__c, SVMXC__Service_Group__c from SVMXC__Service_Group_Members__c where SVMXC__Service_Group__c IN : lstServiceTeamId])
    /// {
    ///     objAllTech.Total_technicians_in_service_team__c = MapTechnician.get(objAllTech.SVMXC__Service_Group__c);
    ///     system.debug('objAllTech--->' + objAllTech);
    /// }
        for(SVMXC__Service_Group_Members__c objTech : newObjects)
        {
           objTech.Total_technicians_in_service_team__c = MapTechnician.get(objTech.SVMXC__Service_Group__c);
            if(objTech.SVMXC__Active__c == true)
              //  objTech.Total_technicians_in_service_team__c = objTech.Total_technicians_in_service_team__c + 1;
            //else
               // objTech.Total_technicians_in_service_team__c = objTech.Total_technicians_in_service_team__c - 1;
            system.debug('objTech--->' + objTech);
        }
            //integer a = 1/0;
        }
    }
    
    public void OnAfterUpdate(List<SVMXC__Service_Group_Members__c> oldObjects, List<SVMXC__Service_Group_Members__c> newObjects, Map<Id, SVMXC__Service_Group_Members__c> newObjectMap){
        // AFTER UPDATE LOGIC
        
    }
    
    public void OnBeforeDelete(List<SVMXC__Service_Group_Members__c> ObjectsToDelete, Map<Id, SVMXC__Service_Group_Members__c> oldObjectMap){
        // BEFORE DELETE LOGIC
    }
    
    public void OnAfterDelete(List<SVMXC__Service_Group_Members__c> deletedObjects, Map<Id, SVMXC__Service_Group_Members__c> oldObjectMap){
        // AFTER DELETE LOGIC
    }
    
    public void OnUndelete(List<SVMXC__Service_Group_Members__c> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
    

     
    
}