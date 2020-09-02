/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 04/Sept/2019
Purpose     : To Implement functionlaity / business logic for Schedule and/or Dispatch qualified Personnel to a Job.
              Ref #R-32464
Modified By : VijayaLakshmi Murukutla
Modified On : 05/Sept/2019 - 10/09/2019
Purpose     :
Modified By : VijayaLakshmi Murukutla
Modified On : 26/Nov/2019
Purpose     : Work around Deep clone Issue Fix Update the business logic related to No Of Personnel in Crew (SD_No_Of_Personnel_in_Crew__c ) field update on job
              Method Name : updateJobList(set of Job Ids) 
Last Modified By             - VijayaLakshmi Murukutla
LastModified Date            - Jan/06/2020,Jan/07/2020
Purpose                      - Ref: Story/Requirement R-33390
                                3. If there is a modification on the rotator crew job with regards to crew planning, it should reflect the change in all the jobs with are associated with that job as a rotator crew.


========================================================
*/
/* Object : Crew Planning                      FX5__Crew_Planning__c
         Job                                FX5__Job__c                                 Lookup(Job)
         Crew Member                        FX5__Crew_Member__c                         Lookup(Contact)
         Role Description                   SD_Role_Description__c                      Formula (Text)

Object : Qualification Requirement          FX5__Qualification_Requirement__c
         Job                                FX5__Job__c                                 Lookup(Job)
         No Of FP with Qualification        SD_No_Of_FP_With_Qualification__c           Number(18, 0)
         Qualification                      FX5__Qualification__c                       Master-Detail(Qualification)
         Type                               SD_Type__c                                  Picklist
         Weight Towards Fulfillment         SD_Weight_Towards_Fulfillment__c            Number(18, 0)
         Weight Towards Total Requirements  SD_Weight_Towards_Total_Requirements__c     Formula (Number)

Object : Job                                FX5__Job__c
         No Of Personnel in Crew            SD_No_Of_Personnel_in_Crew__c               Number(18, 0)
         % Qualifications Met               SD_Qualifications_Met__c                    Number(18, 0)

Object : Contact Qualification              FX5__Contact_Qualification__c
         Contact                            FX5__Contact__c                     Master-Detail(Contact)
         Qualification                      FX5__Qualification__c               Master-Detail(Qualification)
            
Object : contact

If member prior value is blank and current value is not blank  and Role <> Trainee   --> Proceed
OR
If Role of Prior value is Trainee and current value is not Trainee -- > Proceed


*****************************************************************************************
*/
public class SD_CrewPlanningTriggerHandler {
        public id objJobId;
        public id objContactId;
        public id objOldJobId;
        public id objOldContactId;
        public SD_QualificationReqTriggerHandler objQRTrgHndlr = new SD_QualificationReqTriggerHandler();
 //Main Method 2 :  Update Job, QR on DELETE Of Crew Planing
    public void updateJobandQROnCPDelete(List<FX5__Crew_Planning__c> lstOldCrewPlan){
    
    Set<id>JobsubIdlist = new Set<id>();
    Set<id>ContactsubIdList = new Set<id>();
    
        System.debug('I am in Main Method 2 related to CP Delete  The Old CP Record is :  ' + lstOldCrewPlan);
        If(lstOldCrewPlan.size()>0){
            for(FX5__Crew_Planning__c objOldCP : lstOldCrewPlan){
                If(objOldCP.SD_Role_Description__c != 'Trainee'&& objOldCP.FX5__Crew_Member__c != null){
                    System.debug('In IF Line 52 Old Record Role, Crew Memeber values are :  '+objOldCP.SD_Role_Description__c+'***'+objOldCP.FX5__Crew_Member__c);
                    objOldJobId = objOldCP.FX5__Job__c;
                    objContactId = objOldCP.FX5__Crew_Member__c;
                    //i.   Subtract 1 from No. of personnel in crew on job
                    System.debug('I am in Main Method 2 related to CP Delete the Job and Contact Ids are: ' + objOldJobId+'******'+objContactId);
                    updateOldJob(objOldJobId);//Method 4
                    //updateQRSubtraction(objOldJobId,objContactId);//Method 3 
                    JobsubIdlist.add(objOldJobId);
                    ContactsubIdList.add(objContactId);
                }
            }
        }
       // if(!JobsubIdlist.IsEmpty()){
            //updateJobList(JobsubIdlist);
       // }
        if(!JobsubIdlist.IsEmpty() && !ContactsubIdList.IsEmpty())
        {
            updateQRSubtraction(JobsubIdlist,ContactsubIdList);
        }
    }
 // a.  If member is added on blank crew planning record or (if role is set to <> Trainee from Trainee)    
 
 //Main Method 1 :  Update Job, Qualification Requirement Record at INSERT Actions and at Deep Clone  Acion 
    public void updateJobandQROnCPInsert(List<FX5__Crew_Planning__c> lstNewCrewPlan){
        Set<Id> ContactAddIdList= new Set<id>();
        Set<id> JobAddIdlist = new Set<id>();
      System.debug('Vijaya Tesing 28/11, Its in SD_CrewPlanningTriggerHandler --> updateJobandQROnCPInsert');  
      if(lstNewCrewPlan.size()>0){       
            for(FX5__Crew_Planning__c crewPlanRec : lstNewCrewPlan){
                if(crewPlanRec.SD_Role_Description__c != 'Trainee' && crewPlanRec.FX5__Crew_Member__c != null){
                    objJobId = crewPlanRec.FX5__Job__c;
                    objContactId = crewPlanRec.FX5__Crew_Member__c;
                   //adding below two line to update the rawtime on crew plan record on insert for norway email
                    //string newRawTime= gettimeraw(crewPlanRec.SD_Check_in__c);
                    //crewPlanRec.SD_RawCheckinTime__c = newRawTime.right(8);
                   // updateJob(objJobId); // Method 1
                    System.debug('I am in updateJobandQROnCPInsert Method Line 73');
                    //updateQRAddition(objJobId,objContactId);// Method 2
                    JobAddIdlist.add(objJobId);
                    ContactAddIdList.add(objContactId);
                    System.debug('I am in updateJobandQROnCPInsert Method Line 75');
                }          
          }
          
        }
        if(!JobAddIdlist.IsEmpty()){
            updateJobList(JobAddIdlist);// Added by Vijaya on 26/Nov/2019 
        }
        if(!JobAddIdlist.IsEmpty() && !ContactAddIdList.IsEmpty())
        {
            updateQRAddition(JobAddIdlist,ContactAddIdList);
        } 
    } 
    
  //crewPlanRec.SD_Role_Description__c != 'Trainee' && crewPlanRec.FX5__Crew_Member__c != null
  //updateQRAddition(objJobId,objContactId);
    
//Main Method 2 :  Update Job, Qualification Requirement Record  at UPDATE Actions 
    public void updateJobandQROnCPUpdate(List<FX5__Crew_Planning__c> lstNewCrewPlan,List<FX5__Crew_Planning__c> lstOldCrewPlan){
            System.debug('Vijaya Tesing 28/11, Its in SD_CrewPlanningTriggerHandler --> updateJobandQROnCPUpdate');
            Set<Id> ContactAddIdList= new Set<id>();
            Set<id> JobAddIdlist = new Set<id>();
            Set<Id> JobsubIdlist= new Set<id>();
            Set<Id> ContactsubIdList= new Set<id>();
            
        for(FX5__Crew_Planning__c crewPlanRec : lstNewCrewPlan){
            for(FX5__Crew_Planning__c oldCrewPlanRec: lstOldCrewPlan){
                // a.   If member is added on blank crew planning record or (if role is set to <> Trainee from Trainee) 
                if((crewPlanRec.SD_Role_Description__c != 'Trainee' && oldCrewPlanRec.SD_Role_Description__c == 'Trainee') 
                   || 
                   (crewPlanRec.FX5__Crew_Member__c != null && oldCrewPlanRec.FX5__Crew_Member__c == null && 
                    crewPlanRec.SD_Role_Description__c != 'Trainee'))
                {
                    objJobId = crewPlanRec.FX5__Job__c;
                    objContactId = crewPlanRec.FX5__Crew_Member__c;
                    updateJob(objJobId); // Method 1
                    
                    JobAddIdlist.add(objJobId);
                    ContactAddIdList.add(objContactId);
                    
                    //updateQRAddition(objJobId,objContactId);// Method 2
                }
                // b.   If member name is updated to another name
                else If(oldCrewPlanRec.FX5__Crew_Member__c != crewPlanRec.FX5__Crew_Member__c){
                    //i.    Iterate through the job’s qualification requirements to identify match between the new member’s contact qualification and job’s qualification requirements
                    objJobId = crewPlanRec.FX5__Job__c;
                    objContactId = crewPlanRec.FX5__Crew_Member__c;
                    //updateQRAddition(objJobId,objContactId);// Method 2
                    JobAddIdlist.add(objJobId);
                    ContactAddIdList.add(objContactId);
                    //ii.   Iterate through the job’s qualification requirements to identify match between the old member’s contact qualification and job’s qualification requirements
                    objOldJobId = oldCrewPlanRec.FX5__Job__c;
                    objContactId = oldCrewPlanRec.FX5__Crew_Member__c;
                    //updateQRSubtraction(objOldJobId,objContactId);//Method 3
                    JobsubIdlist.add(objOldJobId);
                    ContactsubIdList.add(objContactId);
                    
                }
                //c.    If member name is removed or (if a role is set to “Trainee” from <> Trainee)
                else If((crewPlanRec.SD_Role_Description__c == 'Trainee' && oldCrewPlanRec.SD_Role_Description__c != 'Trainee')
                        ||
                        (crewPlanRec.FX5__Crew_Member__c == null && oldCrewPlanRec.FX5__Crew_Member__c != null)){
                            objOldJobId = oldCrewPlanRec.FX5__Job__c;
                            objContactId = oldCrewPlanRec.FX5__Crew_Member__c;
                            //i.    Subtract 1 from No. of personnel in crew on job
                            updateOldJob(objOldJobId);//Method 4
                            //updateQRSubtraction(objOldJobId,objContactId);//Method 3 
                            JobsubIdlist.add(objOldJobId);
                            ContactsubIdList.add(objContactId);
                            
                        }   
            }  
        } 
       // if(!JobAddIdlist.IsEmpty()){
            //updateJobList(JobAddIdlist);
       // }
       // if(!JobsubIdlist.IsEmpty()){
            //updateJobList(JobsubIdlist);
       // }
        if(!JobAddIdlist.IsEmpty() && !ContactAddIdList.IsEmpty())
        {
           
            updateQRAddition(JobAddIdlist,ContactAddIdList);
        }
        
        if(!JobsubIdlist.IsEmpty() && !ContactsubIdList.IsEmpty())
        {
            updateQRSubtraction(JobsubIdlist,ContactsubIdList);
        }
    }   
 // b.  If member name is updated to another name

    // Method 1: To Update related Job Record
    public void updateJob(id objJobId){                
        List<FX5__Job__c> lstJob = new List<FX5__Job__c>();
        List<FX5__Job__c> lstJobToUpdate = new List<FX5__Job__c>();
        Set<Id> setJobIds = new Set<Id>();
        lstJob = [Select id,Name,SD_No_Of_Personnel_in_Crew__c,Cloned__c from FX5__Job__c where id =: objJobId];
        
        Decimal ExistingnoofFieldPersonnel = lstJob[0].SD_No_Of_Personnel_in_Crew__c;
        boolean isCloned= lstJob[0].Cloned__c;
        system.debug('+++++ExistingnoofFieldPersonnel'+ExistingnoofFieldPersonnel);

        System.debug('In Job Addition : Related Job List :lstJob '+lstJob);
        if(lstJob.size()>0){
            
            for(FX5__Job__c objJob : lstJob){ 
                if(objJob.SD_No_Of_Personnel_in_Crew__c != null){
                    
                    objJob.SD_No_Of_Personnel_in_Crew__c = objJob.SD_No_Of_Personnel_in_Crew__c+1;      
                }
                else{
                    objJob.SD_No_Of_Personnel_in_Crew__c = 1;                    
               }
                lstJobToUpdate.add(objJob);
            }
        }
        system.debug('lstJobToUpdate******'+lstJobToUpdate);
        if(lstJobToUpdate.size()>0){
            system.debug('IN if******'+lstJobToUpdate);
            system.debug('JOB : SD_No_Of_Personnel_in_Crew__c : BEFORE---->  ******'+lstJob[0].SD_No_Of_Personnel_in_Crew__c );
            //Update lstJobToUpdate;
           //system.debug('JOB : SD_No_Of_Personnel_in_Crew__c : AFTER---->  ******'+lstJobToUpdate[0].SD_No_Of_Personnel_in_Crew__c );            
          // if(ExistingnoofFieldPersonnel !=lstJobToUpdate[0].SD_No_Of_Personnel_in_Crew__c & isCloned == True)
  
            Database.SaveResult[] srList = Database.update(lstJobToUpdate, false);
             system.debug('Vijaya entering if ');
            for (Database.SaveResult sr : srList) {
               if (sr.isSuccess()) { 
                  System.debug('Successfully updated Job. Job ID is : ' + sr.getId());
                  setJobIds.add(sr.getId());
                  objQRTrgHndlr.updateJobOnCPchanges(setJobIds);
               } else {                  
                  for(Database.Error objErr : sr.getErrors()) {
                     System.debug('The following error has occurred.');
                     System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                     System.debug('Job object field which are affected by the error:' 
                        + objErr.getFields());
                  } 
               }
            }
            
            system.debug('Updated ******'+lstJobToUpdate);
        }        
    }

    // Method 1.1: To Update related Job list 
    // Added by Vijaya on 26/Nov/2019 
    public void updateJobList(set<id> setJobIds){ 

        map<Id,Integer > maptoUpdateJob = new map<Id,Integer>();
        List<FX5__Job__c> lsttoUpdateJob = new List<FX5__Job__c>();
        FX5__Job__c objtoUpdateJob = new FX5__Job__c();
        Integer count = 0;
        List<FX5__Crew_Planning__c> lstCPs = new List<FX5__Crew_Planning__c>();
        lstCPs = [SELECT ID,FX5__Crew_Member__c,FX5__Job__c,SD_Role_Description__c FROM FX5__Crew_Planning__c 
                  WHERE SD_Role_Description__c != 'Trainee' AND FX5__Crew_Member__c != null AND FX5__Job__c IN :setJobIds];
        for (ID key: setJobIds){
            count = 0;
            for (FX5__Crew_Planning__c objCP: lstCPs) {
                if(key.equals(objCP.FX5__Job__c)){
                    count++;
                }
            }
            maptoUpdateJob.put(key, count);      
           System.debug('Vijaya Test on CPs count per each job on 26/Nov'+maptoUpdateJob);            
        } 
        for(FX5__Job__c objJob:[Select id,SD_No_Of_Personnel_in_Crew__c from FX5__Job__c where id IN : maptoUpdateJob.keyset()]){
            If(objJob.SD_No_Of_Personnel_in_Crew__c == maptoUpdateJob.get(objJob.id) && maptoUpdateJob.containsKey(objJob.id)){
                system.debug('IN if******Line 269'+maptoUpdateJob+'------> objJob.SD_No_Of_Personnel_in_Crew__c :  '+objJob.SD_No_Of_Personnel_in_Crew__c+'--> maptoUpdateJob.get(objJob.id)'+maptoUpdateJob.get(objJob.id));
                System.debug('IN if******Line 270 updateJobList Method : Vijaya Test on Same Value on 28/Nov'+maptoUpdateJob);   
            }
            else{
                system.debug('IN else****** --> Line 273'+maptoUpdateJob);
                System.debug('Line 274 : --> updateJobList Method IN Else  : Vijaya Test on New Value on 28/Nov  : --> maptoUpdateJob'+maptoUpdateJob);
                System.debug('Line 275 : --> updateJobList Method IN Else  : Vijaya Test on New Value on 28/Nov  : --> lsttoUpdateJob size'+lsttoUpdateJob.size()); 
                objtoUpdateJob.id = objJob.id;
                objtoUpdateJob.SD_No_Of_Personnel_in_Crew__c = maptoUpdateJob.get(objJob.id);
                lsttoUpdateJob.add(objtoUpdateJob); 
                System.debug('Line 279: --> updateJobList Method IN Else  : Vijaya Test on New Value on 28/Nov  : --> lsttoUpdateJob size'+lsttoUpdateJob.size());
                System.debug('Line 280 : --> updateJobList Method IN Else  : Vijaya Test on New Value on 28/Nov  : --> lsttoUpdateJob size'+lsttoUpdateJob); 
            }
        }
         System.debug('Before If : Vijaya Test on lsttoUpdateJob on 28/Nov'+lsttoUpdateJob);  
        if(lsttoUpdateJob.size()>0){
            System.debug('After If:Vijaya Test on lsttoUpdateJob on 28/Nov'+lsttoUpdateJob);  
            
            Database.SaveResult[] srList = Database.update(lsttoUpdateJob, false);
             system.debug('Vijaya entering if ');
            for (Database.SaveResult sr : srList) {
               if (sr.isSuccess()) { 
                  System.debug('Successfully updated Job. Job ID is : ' + sr.getId());
                  setJobIds.add(sr.getId());
                  objQRTrgHndlr.updateJobOnCPchanges(setJobIds);
               } else {                  
                  for(Database.Error objErr : sr.getErrors()) {
                     System.debug('The following error has occurred.');
                     System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                     System.debug('Job object field which are affected by the error:' 
                        + objErr.getFields());
                  } 
               }
            }
            system.debug('Updated ******'+lsttoUpdateJob);
        }
    }

    // Method 2: Update Qualification (Addition)    
    public void updateQRAddition(Set<Id> objJobId, Set<Id> objContactId){
     // To Update Qualification Requirement Record 
        // ii.  Iterate through the job’s qualification requirements to identify match between the member’s contact qualification and job’s qualification requirements       
        System.debug('I am in Method 2 : QR Addition : Job and Contact Ids are :  '+objJobId+'******'+objContactId);
        
        List<FX5__Contact_Qualification__c> lstConQua = new List<FX5__Contact_Qualification__c>();        
       List<FX5__Qualification_Requirement__c> lst1QR = new List<FX5__Qualification_Requirement__c>();
        Set<FX5__Qualification_Requirement__c> lstQRToUpdate = new Set<FX5__Qualification_Requirement__c>();
        List<FX5__Qualification_Requirement__c> lstQR= new List<FX5__Qualification_Requirement__c>();
        List<FX5__Qualification_Requirement__c> lstMatchedQR = new List<FX5__Qualification_Requirement__c>();    
        Set<Id> setMatchedQRsJobIds = new Set<Id>();
        
        lstConQua = [SELECT Id,Name,FX5__Contact__c,FX5__Qualification__c 
                     FROM FX5__Contact_Qualification__c WHERE FX5__Contact__c IN: objContactId AND SD_Status__c = 'Active'];         
        lstQR = [SELECT Id,name,FX5__Qualification__c,FX5__Job__c,SD_Type__c,SD_No_Of_FP_With_Qualification__c,SD_Weight_Towards_Fulfillment__c
                 FROM FX5__Qualification_Requirement__c WHERE FX5__Job__c IN:objJobId]; 
        
        System.debug('ContactQualification (lstConQua) List  and Qualification Requirement List(lstQR)  '+lstConQua+'******'+lstQR);
        
        for(FX5__Contact_Qualification__c objCQ:lstConQua){
            for(FX5__Qualification_Requirement__c objQR:lstQR){               
                if(objCQ.FX5__Qualification__c == objQR.FX5__Qualification__c){
                    lstMatchedQR.add(objQR); 
                    setMatchedQRsJobIds.add(objQR.FX5__Job__c); 
                }
            }
        }
        
        System.debug('Qualification Value Matched List : lstMatchedQR ********'+lstMatchedQR);
        
        if(lstMatchedQR.size()>0){
        for(FX5__Qualification_Requirement__c objQRRec:lstMatchedQR){            
            //1.    If qualification requirement is Fundamental 
            if(objQRRec.SD_Type__c == 'Fundamental'){
                
                System.debug('In Fundamental Type Block Line 184');
                
                objQRRec.SD_No_Of_FP_With_Qualification__c = objQRRec.SD_No_Of_FP_With_Qualification__c+1;
                objQRRec.SD_Weight_Towards_Fulfillment__c = objQRRec.SD_Weight_Towards_Fulfillment__c+1;
            }
            // 2.   If qualification requirement is Type1/Type 2
            else if((objQRRec.SD_Type__c == 'Type 1')|| (objQRRec.SD_Type__c == 'Type 2')) {
                
                System.debug('In Type 1 Type Block Line 192');
                
                objQRRec.SD_No_Of_FP_With_Qualification__c = objQRRec.SD_No_Of_FP_With_Qualification__c+1;
                if(objQRRec.SD_Weight_Towards_Fulfillment__c == 0){
                    objQRRec.SD_Weight_Towards_Fulfillment__c = 1;
                }                    
            }
            lstQRToUpdate.add(objQRRec);   
        } 
    }
        System.debug('Addition QR List to Update : lstQRToUpdate  ********'+lstQRToUpdate);
        if(lstQRToUpdate.size()>0){
            system.debug('SD_Weight_Towards_Fulfillment__c *** Before Update'+lstMatchedQR[0].SD_Weight_Towards_Fulfillment__c);
            //Update lstQRToUpdate; 
          
        Map<Id,FX5__Qualification_Requirement__c> mapQualificationRequirement = new Map<Id,FX5__Qualification_Requirement__c>();
          
          for(FX5__Qualification_Requirement__c qualificationRequirement : lstQRToUpdate)
          {
          mapQualificationRequirement.put(qualificationRequirement.Id,qualificationRequirement);
          }   
             
            //system.debug('SD_Weight_Towards_Fulfillment__c *** After Update'+lstQRToUpdate[0].SD_Weight_Towards_Fulfillment__c);            
            
            Database.SaveResult[] srList = Database.update(mapQualificationRequirement.values(), false);
            for (Database.SaveResult sr : srList) {
               if (sr.isSuccess()) { 
                  System.debug('Successfully updated QR. QR ID is : ' + sr.getId()+' and Related JOB ID: '+objJobId);                  
                  objQRTrgHndlr.updateJobOnCPchanges(setMatchedQRsJobIds); 
               } else {                  
                  for(Database.Error objErr : sr.getErrors()) {
                     System.debug('The following error has occurred.');
                     System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                     System.debug('QR object field which are affected by the error:' 
                        + objErr.getFields());
                  }
               }
            }            
            System.debug('Updated*************Qualification_Requirement List********'+lstQRToUpdate);
            
        }   
    }   
    
    // Method 3: Update Qualification Requirement (Subtraction)
        public void updateQRSubtraction(Set<Id> objOldJobId, Set<id> objOldContactId){
        // To Update Qualification Requirement Record 
        // ii.  Iterate through the job’s qualification requirements to identify match between the member’s contact qualification and job’s qualification requirements
        
        System.debug('I am in Method 3 : QR Subtraction : Job and Contact Ids are :  '+objOldJobId+'******'+objOldContactId);
       
        List<FX5__Contact_Qualification__c> lstConQua = new List<FX5__Contact_Qualification__c>();        
        List<FX5__Qualification_Requirement__c> lstQR = new List<FX5__Qualification_Requirement__c>();
        Set<FX5__Qualification_Requirement__c> lstQRToUpdate = new Set<FX5__Qualification_Requirement__c>();
        List<FX5__Qualification_Requirement__c> lstMatchedQR = new List<FX5__Qualification_Requirement__c>();    
        Set<Id> setMatchedQRsJobIds = new Set<Id>();
        lstConQua = [SELECT Id,Name,FX5__Contact__c,FX5__Qualification__c 
                     FROM FX5__Contact_Qualification__c WHERE FX5__Contact__c IN: objOldContactId AND SD_Status__c = 'Active'];
        
        lstQR = [SELECT Id,name,FX5__Qualification__c,FX5__Job__c,SD_Type__c,SD_No_Of_FP_With_Qualification__c,SD_Weight_Towards_Fulfillment__c
                 FROM FX5__Qualification_Requirement__c WHERE FX5__Job__c IN :objOldJobId]; 
       
        System.debug('ContactQualification (lstConQua) List  and Qualification Requirement List(lstQR)  '+lstConQua+'******'+lstQR);
        
          for(FX5__Contact_Qualification__c objCQ:lstConQua){
            for(FX5__Qualification_Requirement__c objQR:lstQR){               
                if(objCQ.FX5__Qualification__c == objQR.FX5__Qualification__c){
                    lstMatchedQR.add(objQR);
                    setMatchedQRsJobIds.add(objQR.FX5__Job__c);                    
                }
            }
        }
            
        System.debug('Qualification Value Matched List and Related Job Ids : lstMatchedQR ********'+lstMatchedQR+'Jobs IDS***'+setMatchedQRsJobIds); 
            
        if(lstMatchedQR.size()>0){
        for(FX5__Qualification_Requirement__c objQRRec:lstMatchedQR){            
            //1.    If qualification requirement is Fundamental 
            if(objQRRec.SD_Type__c == 'Fundamental'){
                
                System.debug('In Fundamental Type Block in QR Subtraction');                
                objQRRec.SD_No_Of_FP_With_Qualification__c = objQRRec.SD_No_Of_FP_With_Qualification__c-1;
                objQRRec.SD_Weight_Towards_Fulfillment__c = objQRRec.SD_Weight_Towards_Fulfillment__c-1;
            }
            // 2.   If qualification requirement is Type1/Type 2
            else if((objQRRec.SD_Type__c == 'Type 1') || (objQRRec.SD_Type__c == 'Type 2')){                
                System.debug('In *Type 1* Type Block in QR Subtraction');                
                objQRRec.SD_No_Of_FP_With_Qualification__c = objQRRec.SD_No_Of_FP_With_Qualification__c-1;
                if(objQRRec.SD_No_Of_FP_With_Qualification__c == 0){
                    objQRRec.SD_Weight_Towards_Fulfillment__c = 0;
                }                    
            }
            lstQRToUpdate.add(objQRRec);   
        } 
    }
        System.debug('Subtracted QR List to Update : lstQRToUpdate  ********'+lstQRToUpdate);
        if(lstQRToUpdate.size()>0){
            system.debug('SD_Weight_Towards_Fulfillment__c *** Before Update'+lstMatchedQR[0].SD_Weight_Towards_Fulfillment__c);
            //Update lstQRToUpdate;  
            // lstQR = new List<FX5__Qualification_Requirement__c>(lstQRToUpdate); 
             Map<Id,FX5__Qualification_Requirement__c> mapQualificationRequirement = new Map<Id,FX5__Qualification_Requirement__c>();
          
          for(FX5__Qualification_Requirement__c qualificationRequirement : lstQRToUpdate)
          {
          mapQualificationRequirement.put(qualificationRequirement.Id,qualificationRequirement);
          }             
            Database.SaveResult[] srList = Database.update(mapQualificationRequirement.values(), false);
            for (Database.SaveResult sr : srList) {
               if (sr.isSuccess()) { 
                  System.debug('Successfully updated QR. QR ID is : ' + sr.getId()+' and Related JOB ID: '+objJobId);                  
                  objQRTrgHndlr.updateJobOnCPchanges(setMatchedQRsJobIds); 
               } else {                  
                  for(Database.Error objErr : sr.getErrors()) {
                     System.debug('The following error has occurred.');
                     System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                     System.debug('QR object field which are affected by the error:' 
                        + objErr.getFields());
                  }
               }
            }  
            //system.debug('SD_Weight_Towards_Fulfillment__c *** After Update'+lstQRToUpdate[0].SD_Weight_Towards_Fulfillment__c);
            System.debug('*************UPDATED********');
        }
    }
     // Method 4: To Update related Job Record with SubTraction Action
    public void updateOldJob(id objOldJobId){                
        List<FX5__Job__c> lstJob = new List<FX5__Job__c>();
        List<FX5__Job__c> lstJobToUpdate = new List<FX5__Job__c>();
        Set<Id> setJobIds = new Set<Id>();
        lstJob = [Select id,Name,SD_No_Of_Personnel_in_Crew__c from FX5__Job__c where id =: objOldJobId];        
        if(lstJob.size()>0){ 
            System.debug('In Method4: Related Job List -- lstJob  '+lstJob);
            for(FX5__Job__c objJob : lstJob){ 
                if(objJob.SD_No_Of_Personnel_in_Crew__c != null){
                    objJob.SD_No_Of_Personnel_in_Crew__c = objJob.SD_No_Of_Personnel_in_Crew__c-1;      
                }
                else{
                    objJob.SD_No_Of_Personnel_in_Crew__c = null;                    
               }
                lstJobToUpdate.add(objJob);
            }
        }
        system.debug('Job List to Update fileds --- lstJobToUpdate******'+lstJobToUpdate);
        if(lstJobToUpdate.size()>0){
            system.debug('IN if******'+lstJobToUpdate);
            system.debug('OLDJOB : SD_No_Of_Personnel_in_Crew__c : BEFORE---->  ******'+lstJob[0].SD_No_Of_Personnel_in_Crew__c );
            //Update lstJobToUpdate;            
            Database.SaveResult[] srList = Database.update(lstJobToUpdate, false);
            for (Database.SaveResult sr : srList) {
               if (sr.isSuccess()) { 
                  System.debug('Successfully updated Job. Job ID is : ' + sr.getId());
                  setJobIds.add(sr.getId());
                  objQRTrgHndlr.updateJobOnCPchanges(setJobIds);
               } else {                  
                  for(Database.Error objErr : sr.getErrors()) {
                     System.debug('The following error has occurred.');
                     System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                     System.debug('Job object field which are affected by the error:' 
                        + objErr.getFields());
                  }
               }
            }         
            system.debug('OLD Job Updated ******'+lstJobToUpdate);
        }        
    }
    
    /*  
    ==============================
    Modified By : VijayaLakshmi M
    Modified On : 06/Jan/2020
    Purpose     : Making a business logic for Rotator Crew Job.Ref: Story/Requirement R-33390
    ============================== 
   */
    private static Id getRotatorCrewRecordTypeId(){
        return Schema.SObjectType.FX5__Job__c.getRecordTypeInfosByDeveloperName().get('SD_Rotator_Crew').getRecordTypeId();
    }
    // Method: To set IsRCCrewPlan field on Crew Planing Record
    /*public void setRCCrewPlanData(List<FX5__Crew_Planning__c> lstNewCrewPlans){
      
        ID RotatorCrewRecordTypeId = getRotatorCrewRecordTypeId();
        system.debug('rectype'+RotatorCrewRecordTypeId);
        For(FX5__Crew_Planning__c ObjNewCP : lstNewCrewPlans){
            System.debug('Vijaya Testing : in setRCCrewPlanData () method -->ObjNewCP.FX5__Job__r.RecordTypeId==>:'+ObjNewCP.FX5__Job__r.RecordTypeId);
            System.debug('Vijaya Testing : in setRCCrewPlanData () method -->RotatorCrewRecordTypeId==>:+'+RotatorCrewRecordTypeId);
            IF(ObjNewCP.FX5__Job__c.RecordTypeId == RotatorCrewRecordTypeId){
                ObjNewCP.SD_IsRCJobCrewPlan__c = true;           
            }
          System.debug('Vijaya Testing : in setRCCrewPlanData () method -->ObjNewCP.SD_IsRCJobCrewPlan__c==>:+'+ObjNewCP.SD_IsRCJobCrewPlan__c);  
        }        
        
    }*/
    
    // Method: Auto Update the Crew Planing Reocrds which are created through selected Rotator Crew Value on Job Records.
    
    public void autoUpdateRotatorCrewRelatedCPs(Map<Id,FX5__Crew_Planning__c> mapOldCrewPlan,List<FX5__Crew_Planning__c> lstNewCrewPlan){
        ID RotatorCrewRecordTypeId = Schema.SObjectType.FX5__Job__c.getRecordTypeInfosByDeveloperName().get('SD_Rotator_Crew').getRecordTypeId();      
        FX5__Crew_Planning__c objRCCP = new FX5__Crew_Planning__c();
        List<FX5__Crew_Planning__c> lstExistedRCCPs = new List<FX5__Crew_Planning__c>();
        List<FX5__Crew_Planning__c> lstRCCPsToUpdate = new List<FX5__Crew_Planning__c>();
        Map<Id,FX5__Crew_Planning__c> mapRCCrewPlans = new Map<Id,FX5__Crew_Planning__c>();
        
        System.debug('Vijaya Testing : In autoUpdateRotatorCrewRelatedCPs ------> lstNewCrewPlan'+lstNewCrewPlan);
        
        For(FX5__Crew_Planning__c objNewCP : lstNewCrewPlan){         
            System.debug('Vijaya Testing : In autoUpdateRotatorCrewRelatedCPs ------> objNewCP.SD_RCJob_CrewPlan_Reference__c:==> '+objNewCP.SD_RCJob_CrewPlan_Reference__c);
            System.debug('Vijaya Testing : In autoUpdateRotatorCrewRelatedCPs ------> objNewCP.FX5__Job__r.RecordTypeID:==> '+objNewCP.FX5__Job__r.RecordTypeID);          
            IF(objNewCP.SD_IsRCJobCrewPlan__c == true){                
                mapRCCrewPlans.put(objNewCP.ID,objNewCP);                
            }   
        }
        System.debug('Vijaya Testing----> mapRCCrewPlans:==> '+mapRCCrewPlans);
        IF(mapRCCrewPlans.size() > 0){
            lstExistedRCCPs = [SELECT ID,NAME,FX5__Crew_Member__c,FX5__Job__c,SD_Shift__c,FX5__Planned_Start_Date__c,
                                 FX5__Planned_End_Date__c,FX5__Role_on_Job__c,SD_Role_Description__c,SD_Pre_Job_Brief__c,
                                 SD_Dispatch__c,SD_Heliport__c,SD_Check_in__c,SD_Name_Coming_In__c,SD_Rotator_Crew_Job_Reference__c,SD_RCJob_CrewPlan_Reference__c 
                                 FROM FX5__Crew_Planning__c
                                 WHERE SD_RCJob_CrewPlan_Reference__c IN : mapRCCrewPlans.keySet() 
                                ];
             System.debug('Vijaya Testing----> Before data maping ---> lstExistedRCCPs:==> '+lstExistedRCCPs);
            IF(lstExistedRCCPs.size() > 0){
                FOR(FX5__Crew_Planning__c objExistRCCP : lstExistedRCCPs){
                    IF(mapRCCrewPlans.containsKey(objExistRCCP.SD_RCJob_CrewPlan_Reference__c)){
                        objExistRCCP.FX5__Crew_Member__c = mapRCCrewPlans.get(objExistRCCP.SD_RCJob_CrewPlan_Reference__c).FX5__Crew_Member__c;
                        objExistRCCP.SD_Shift__c  = mapRCCrewPlans.get(objExistRCCP.SD_RCJob_CrewPlan_Reference__c).SD_Shift__c;
                        objExistRCCP.FX5__Planned_Start_Date__c = mapRCCrewPlans.get(objExistRCCP.SD_RCJob_CrewPlan_Reference__c).FX5__Planned_Start_Date__c;
                        objExistRCCP.FX5__Planned_End_Date__c = mapRCCrewPlans.get(objExistRCCP.SD_RCJob_CrewPlan_Reference__c).FX5__Planned_End_Date__c;
                        objExistRCCP.FX5__Role_on_Job__c =  mapRCCrewPlans.get(objExistRCCP.SD_RCJob_CrewPlan_Reference__c).FX5__Role_on_Job__c;
                        objExistRCCP.SD_Pre_Job_Brief__c = mapRCCrewPlans.get(objExistRCCP.SD_RCJob_CrewPlan_Reference__c).SD_Pre_Job_Brief__c;
                        objExistRCCP.SD_Dispatch__c  = mapRCCrewPlans.get(objExistRCCP.SD_RCJob_CrewPlan_Reference__c).SD_Dispatch__c;
                        objExistRCCP.SD_Check_in__c  = mapRCCrewPlans.get(objExistRCCP.SD_RCJob_CrewPlan_Reference__c).SD_Check_in__c;
                        objExistRCCP.SD_Name_Coming_In__c  = mapRCCrewPlans.get(objExistRCCP.SD_RCJob_CrewPlan_Reference__c).SD_Name_Coming_In__c;                          
                    }
                    
                }
                 System.debug('Vijaya Testing----> After data maping ---> lstExistedRCCPs:==> '+lstRCCPsToUpdate);
                Update lstExistedRCCPs;
            }  
        }
    }
    
    
    // Adding the logic to get check in time for Norway emails added on 1/10/2020 
    
    public string gettimeraw( Datetime startDate)        
    {
        String timeZone = UserInfo.getTimeZone().getID();
        Datetime dateGMT= startDate;
        Datetime d1=Datetime.valueOf(dateGMT);
        string s1=d1.format();
        return s1;
        
    }
    
    
     public void OnBeforeInsert_or_BeforeUpdate(List<FX5__Crew_Planning__c> newObjects)
   {
     for(FX5__Crew_Planning__c crewobj : newObjects)
     {
       {
       string newRawTime= gettimeraw(crewobj.SD_Check_in__c);
       crewobj.SD_RawCheckinTime__c = newRawTime.right(8);
       crewobj.SDRawDate__c=newRawTime.left(9);
       }
     }
   }  
    
    
    
}