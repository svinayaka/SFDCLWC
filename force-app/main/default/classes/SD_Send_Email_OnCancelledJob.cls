public class SD_Send_Email_OnCancelledJob {
    @InvocableMethod(label='Send an email for Cancelled Job' description='sends an email')
    public static void sendEmailForCancelledJob(List<Id> lstId){
        Map<Id,List<Id>> MapListOfUsers = new Map<Id,List<Id>>();
        map<Id,List<Id>> mapMultiPhaseIdToJobPhaseId = new Map<Id,List<Id>>();
        List<Id> joblistIds = new List<Id>(); 
        joblistIds = lstId;
       // mapMultiPhaseIdToJobPhaseId = getMapofMultiPhaseJobIds(joblistIds);
        joblistIds.addAll(mapMultiPhaseIdToJobPhaseId.keyset());
        MapListOfUsers = getListOfJobTeamMember(joblistIds);
        SD_Send_Email_InvocableMethod.EmailNotificationToJobTeamMemebrs(MapListOfUsers,'SD_EmailTemplateForCancelled_VF','servicedeliveryadmins@ge.com');
        List<FX5__Crew_Planning__c> crewPlanningRecord = new List<FX5__Crew_Planning__c>();
        crewPlanningRecord = [Select id from FX5__Crew_Planning__c where FX5__Job__c In :lstId];
        if(!crewPlanningRecord.isEmpty())
            delete crewPlanningRecord;
    }
    
   /* private static map<Id,List<Id>> getMapofMultiPhaseJobIds(List<Id> lstId){
        List<FX5__Job__c> multiPhaseJobIds= new List<FX5__Job__c>();
        map<Id,List<Id>> mapPhaseJobIdToMultiPhaseJobId = new map<Id,List<Id>>();
        multiPhaseJobIds = [Select id,SD_Multi_Phase_Parent_Job__c from FX5__Job__c where Id IN : lstId AND RecordType.Name = 'Job Phase'];
        for(FX5__Job__c jobIds:multiPhaseJobIds){
            if(jobIds.SD_Multi_Phase_Parent_Job__c != null && !mapPhaseJobIdToMultiPhaseJobId.containskey(jobIds.SD_Multi_Phase_Parent_Job__c)){
                mapPhaseJobIdToMultiPhaseJobId.put(jobIds.SD_Multi_Phase_Parent_Job__c,new List<Id>{jobIds.id});
            }else if(jobIds.SD_Multi_Phase_Parent_Job__c != null && mapPhaseJobIdToMultiPhaseJobId.containskey(jobIds.SD_Multi_Phase_Parent_Job__c)){
                mapPhaseJobIdToMultiPhaseJobId.get(jobIds.SD_Multi_Phase_Parent_Job__c).add(jobIds.id);
            }
        }
        return mapPhaseJobIdToMultiPhaseJobId;
    }*/
    
     private static Map<Id, List<Id>> getListOfJobTeamMember(List<Id> lstId)
     {        
        List<SD_JobTeam__c> JobTeamList = new List<SD_JobTeam__c>();
         List<Id> jobIds = new List<ID>();
        JobTeamList = [Select OwnerId,id,SD_Job__r.ID,SD_JobTeam_Member__r.ID,SD_JobTeam_Member__c,SD_Job__r.RecordType.Name from SD_JobTeam__c where SD_Job__c IN :lstId];
        Map<Id, List<Id>> MapListOfUsers = new Map<Id, List<Id>>();    
        for(SD_JobTeam__c newUser : JobTeamList) {
            if(jobIds.contains(newUser.SD_Job__r.ID)) 
               {
                    MapListOfUsers.get(newUser.SD_Job__r.ID).add(newUser.SD_JobTeam_Member__r.ID);
                }
                
            else{
                if(newUser.SD_JobTeam_Member__c != null)
                {
                  
                        MapListOfUsers.put(newUser.SD_Job__r.Id, new List<Id>{newUser.SD_JobTeam_Member__r.ID});
                    }
                    jobIds.add(newUser.SD_Job__r.ID);
                }
            }
        
        return MapListOfUsers; 
    }
}