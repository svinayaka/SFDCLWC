public class SD_getCrewDetails {

     public Id CrewId {get;set;}
    public List<FX5__Crew_Planning__c> getCrewData()
        {
            List<FX5__Crew_Planning__c> lstCPs;
            lstCPs = [SELECT Id,Name,FX5__Job__r.id,FX5__Crew_Member__r.Name,FX5__Planned_Start_Date__c,SD_Check_in__c,SD_Departed_from_Rig__c,
                      FX5__Planned_End_Date__c,FX5__Job__r.SD_Customer_Name__c,FX5__Job__r.Name,
                      FX5__Job__r.FX5__Directions__c,FX5__Job__r.FX5__Well__r.Name,FX5__Job__r.FX5__Site_Latitude__c,
                      FX5__Job__r.FX5__Site_Longitude__c,SD_Name_Coming_In__r.Name,FX5__Job__r.SD_Rig_Name__r.Name,
                      FX5__Job__r.SD_Job_Summary_New__c,SD_Heliport__c,SD_RawCheckinTime__c,SDCourse_Link__c,
                      SDRawDate__c,FX5__Job__r.SD_Driving_Direction__c,FX5__Job__r.SD_Rig_Name__c, LastModifiedBy.Name,
                      BaseURL__c, SD_Crew_Member_Manager__c, SD_Crew_Member__c
                      
                      FROM FX5__Crew_Planning__c WHERE ID =: CrewId];
            system.debug('---------ABhishek-----::===');
            return lstCPs;
             
                 } 
 
    
    }