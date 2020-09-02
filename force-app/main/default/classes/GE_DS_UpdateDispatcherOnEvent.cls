public class GE_DS_UpdateDispatcherOnEvent
  {
    public static Boolean isFirstTime = false;
    public void Updatedispatcher(list<SVMXC__SVMX_Event__c> levents)
    {
        set<Id>sTechnicianIds = new set<Id>();
       //set<Id>TeamTechnicianId = new set<Id>();
        map<Id,Id> ldispatchraccess = new map<Id, Id>();
        map<Id,Id> mEventServiceTeam = new map<Id,Id>();
        map<Id,Id> eventTeamleader = new map<Id,Id>();
        map<Id,Id> Leaderserviceevnt = new map<Id,Id>();
      ID rectypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('Digital Solutions Technician').getRecordTypeId(); 
      if(!GE_DS_UpdateDispatcherOnEvent.isFirstTime){
      GE_DS_UpdateDispatcherOnEvent.isFirstTime = true;
      list<SVMXC__SVMX_Event__c>lstevnts=[select id,SVMXC__Technician__r.SVMXC__Service_Group__c,SVMXC__Technician__c,SVMXC__Technician__r.RecordTypeId,GE_DS_Dispatcher_Not_Home_Territory__c from SVMXC__SVMX_Event__c where id in:levents and SVMXC__Technician__r.RecordTypeId=:rectypeId];
      for(SVMXC__SVMX_Event__c SEvent : lstevnts){
      system.debug('SEvent.SVMXC__Technician__r.RecordTypeId'+SEvent.SVMXC__Technician__r.RecordTypeId);
      sTechnicianIds.add(SEvent.SVMXC__Technician__r.SVMXC__Service_Group__c);   
      mEventServiceTeam.put(SEvent.Id,SEvent.SVMXC__Technician__r.SVMXC__Service_Group__c);
      Leaderserviceevnt.put(SEvent.Id,SEvent.SVMXC__Technician__c);
         }
      list<SVMXC__Dispatcher_Access__c>dispaccess=[select id,Name,SVMXC__Dispatcher__c,SVMXC__Service_Team__c,GE_HQ_Not_Home_Territory__c from SVMXC__Dispatcher_Access__c where SVMXC__Service_Team__c in:sTechnicianIds and GE_HQ_Not_Home_Territory__c = true Limit 1];
      for(SVMXC__Dispatcher_Access__c dis: dispaccess)
      {
       ldispatchraccess.put(dis.SVMXC__Service_Team__c,dis.Id);
        } 
      list<SVMXC__Service_Group_Members__c>techmembr=[select id,SVMXC__Service_Group__r.GE_HQ_Resource_Director__c from SVMXC__Service_Group_Members__c where id in: Leaderserviceevnt.values()]; 
      for(SVMXC__Service_Group_Members__c tech: techmembr)
       {
        eventTeamleader.put(tech.id,tech.SVMXC__Service_Group__r.GE_HQ_Resource_Director__c);    
        }       
      for(SVMXC__SVMX_Event__c SEvent : levents)
      {       
      if(mEventServiceTeam.containsKey(SEvent.ID) && ldispatchraccess.containsKey(mEventServiceTeam.get(SEvent.ID)))
       {
         SEvent.GE_DS_Dispatcher__c=ldispatchraccess.get(mEventServiceTeam.get(SEvent.ID));
        }
      if(Leaderserviceevnt.containsKey(SEvent.ID) && eventTeamleader.containsKey(Leaderserviceevnt.get(SEvent.ID)))
         {
          SEvent.GE_DS_Service_Team_Leader__c= eventTeamleader.get(Leaderserviceevnt.get(SEvent.ID));
          system.debug('++++Event+++++'+SEvent.GE_DS_Service_Team_Leader__c);
           }
          system.debug('+++SEvent.GE_DS_Dispatcher__c++++'+ SEvent.GE_DS_Dispatcher__c);
         }       
     }  
   } 
}