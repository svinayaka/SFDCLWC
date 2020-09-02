/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 10/Sept/2019
Purpose     : To Implement functionlaity / business logic for Schedule and/or Dispatch qualified Personnel to a Job.
              Ref #R-32464              
                Logic :  When dispatched, each crew member will be sent a notification (as per given template )
Modified By :
Modified On :
Purpose     :
========================================================
Notification email to Field Personnel should read:

You have been assigned to Job xxxxxxxx.

Your assignment is scheduled to start (start date/time) and end on (end date/time)

Customer: xxxxxx

Well Name: xxxxxxx

Well Directions: xxxxxxx

Well Latitude: xxxxx 
Well Longitude: xxxxxxxx


*/
public class SD_getCrewPlanAndJobDetails {

    //public String CP { get; set; }
    public Id CrewMemberId {get;set;}
    public List<FX5__Crew_Planning__c> getCrewPlanData()
        {
            List<FX5__Crew_Planning__c> lstCPs;
            lstCPs = [SELECT Id,Name,FX5__Job__r.id,FX5__Crew_Member__r.Name,FX5__Planned_Start_Date__c,SD_Check_in__c,SD_Departed_from_Rig__c,
                      FX5__Planned_End_Date__c,FX5__Job__r.SD_Customer_Name__c,FX5__Job__r.Name,
                      FX5__Job__r.FX5__Directions__c,FX5__Job__r.FX5__Well__r.Name,FX5__Job__r.FX5__Site_Latitude__c ,
                      FX5__Job__r.FX5__Site_Longitude__c ,SD_Name_Coming_In__r.Name,FX5__Job__r.SD_Rig_Name__r.Name,
                      FX5__Job__r.SD_Job_Summary_New__c,SD_Heliport__c,SD_RawCheckinTime__c,SDCourse_Link__c,SDRawDate__c,FX5__Job__r.SD_Driving_Direction__c,FX5__Job__r.SD_Rig_Name__c FROM FX5__Crew_Planning__c WHERE ID  =: CrewMemberId];
            
            return lstCPs; 
                 } 
            
    public List<SDJob_Items__c> getJobItems()
        {
            List<SDJob_Items__c> lstJIs = new List<SDJob_Items__c>();
            lstJIs = [Select id,Name,SD_JI_Description__c,SD_JI_Tier_3__c from SDJob_Items__c where SD_Job__c IN (SELECT FX5__Job__c FROM FX5__Crew_Planning__c WHERE ID  =: CrewMemberId)];
            
            return lstJIs; 
                 } 
            
            
}