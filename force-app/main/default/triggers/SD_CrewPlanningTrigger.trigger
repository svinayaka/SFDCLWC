/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 04/Sept/2019
Purpose     : To Implement functionlaity / business logic for Schedule and/or Dispatch qualified Personnel to a Job.
              Ref #R-32464
Modified By : VijayaLakshmi Murukutla
Modified On : 26/Nov/2019
Purpose     : Work around Deep clone Issue Fix

Last Modified By             - VijayaLakshmi Murukutla
LastModified Date            - Jan/06/2020,Jan/07/2020
Purpose                      - Ref: Story/Requirement R-33390
                                3. If there is a modification on the rotator crew job with regards to crew planning, 
                                   it should reflect the change in all the jobs with are associated with that job as a rotator crew.
/*
========================================================
Author      : Bhavani Potlapally
Created On  : 19/Mar/2020
Purpose     : To Implement functionlaity / business logic for Role Qual% on Job Page related list Crew Planning.
              Ref #R-33396
                - Trigger on UPSERT of qualification requirement:
                    Update the Role Qual% on the Job object.
                Logic :  Role Qual%: To be calculated as a percent of relationship between role and qualification ID. 
Apex Class : SD_CrewPlanningUpdateHandler.
Modified By : Bhavani Potlapally
Modified On : 23/Mar/2020

========================================================
Last Modified By    : Raghavendra MPV
Modified On         : 08/APR/2020
Purpose             : To Implement functionlaity of R-33532 ( Field Personnel: most recent job (FIFO) )
Apex Class          : SD_MostRecentJobonCrew
========================================================
*/

trigger SD_CrewPlanningTrigger on FX5__Crew_Planning__c (before insert,before update,after insert,after update,before delete) {
    SD_CrewPlanningTriggerHandler objCPHandler = new SD_CrewPlanningTriggerHandler();
    //SD_CrewPlanningUpdateHandler objCPUHandler = new SD_CrewPlanningUpdateHandler();
 
    List<FX5__Crew_Planning__c> newCPFinalList = new List<FX5__Crew_Planning__c>();
    List<FX5__Crew_Planning__c> oldCPFinalList = new List<FX5__Crew_Planning__c>();
    
    /* Adding before update  logic to get checkin date for Norway email template 10/1/2020 */
    
    If(Trigger.isInsert && Trigger.isBefore)
    
    {
      for(FX5__Crew_Planning__c crewobj: trigger.new)
      {
        if(crewobj.SD_Check_in__c != Null)
        {
        objCPHandler.OnBeforeInsert_or_BeforeUpdate(Trigger.new);
        }
      }
      
      //objCPUHandler.updateCrewonInsert(Trigger.New); 
      SD_MostRecentJobonCrew.crewPlanning(Trigger.New,null,true,false);
    }
       
    If(Trigger.isInsert && Trigger.isAfter){
       System.debug('Vijaya Testing : I am in After Insert CP trigger');
            objCPHandler.updateJobandQROnCPInsert(Trigger.New); 
           //objCPUHandler.updateJobOnInsert(Trigger.New);
    }
    
    /* Adding before update  logic to get checkin date for Norway email template 10/1/2020 */
    
     If(Trigger.isUpdate && Trigger.isBefore)
     {
       for(FX5__Crew_Planning__c crewobj: trigger.new)
        {
        if(crewobj.SD_Check_in__c!= trigger.oldMap.get(crewobj.id).SD_Check_in__c)
        {
          objCPHandler.OnBeforeInsert_or_BeforeUpdate(Trigger.new);
        }
      }
         //objCPUHandler.updateCrewonupdate(Trigger.New);
         SD_MostRecentJobonCrew.crewPlanning(Trigger.New,Trigger.oldMap,false,false);
     }
    
    If(Trigger.isUpdate && Trigger.isAfter){
        System.debug('Vijaya Testing: I am in After update CP trigger');
      
        For(FX5__Crew_Planning__c newCP : Trigger.New){     
            IF(newCP.SD_Role_Description__c != Trigger.Oldmap.get(newCP.id).SD_Role_Description__c || newCP.FX5__Crew_Member__c != Trigger.Oldmap.get(newCP.id).FX5__Crew_Member__c){
                newCPFinalList.add(newCP);
                oldCPFinalList.add(Trigger.Oldmap.get(newCP.id));
            }       
        }
        system.debug('Vijaya Testing -->  In Crew Planing After Update -----' +newCPFinalList+'----->'+ oldCPFinalList);
        If(newCPFinalList.size() > 0){
            objCPHandler.updateJobandQROnCPUpdate(newCPFinalList, oldCPFinalList);
        }            
        
        // Method : Its related to Rotator Crew 
        objCPHandler.autoUpdateRotatorCrewRelatedCPs(Trigger.Oldmap,Trigger.new);
        //objCPUHandler.updateJobOnUpdate(Trigger.New);
    }
    If(Trigger.isDelete && Trigger.isBefore){
        System.debug('I am in Crew Planning BeforeDelete Trigger');
        objCPHandler.updateJobandQROnCPDelete(Trigger.old);
        SD_MostRecentJobonCrew.crewPlanning(Trigger.old,null,false,true);
        
    }
}