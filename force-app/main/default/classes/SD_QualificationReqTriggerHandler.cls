/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 06/Sept/2019
Purpose     : To Implement functionlaity / business logic for Schedule and/or Dispatch qualified Personnel to a Job.
              Ref #R-32464
                - Trigger on deletion, UPSERT of qualification requirement:
                    Update the % qualifications met on the Job object.
                Logic :  % Qualifications met: To be calculated as a summation of weight towards fulfilment/summation of weight towards total requirements*100
Modified By : Vijaya Lakshmi Murukutla
Modified On : 20 / 09 /2019
Purpose     : Modify the logic on crew planning to take into consideration only the contact qualifications which have “Active” status. 

Modified By : Vijaya Lakshmi Murukutla
Modified On : 07/Oct/2019
Purpose     : If job have 0 Fundamental Qualification then Job Object related checkboxs should auto update as per the requirment.

========================================================
*/
public class SD_QualificationReqTriggerHandler { 
    public Id objJobID;
    public Id objQRId;
    public Set<Id> setContactIds = new Set<id>();
    public Map<Id,Id> MapQRJobIds = new Map<Id,Id>();     
    
   // Method 1: Qualification Requirement Record Values Set  ON BEFORE INSERT
    public void setQRValuesOnQRbInsert(List<FX5__Qualification_Requirement__c> lstNewQR){
        // Declarations
        SET<ID> setJobIds = new SET<ID>();
        LIST<FX5__Crew_Planning__c> getRelatedCP = new List<FX5__Crew_Planning__c>();
        SET<ID> setContactIds = new SET<ID>();
        LIST<FX5__Contact_Qualification__c> getRelatedConQuas = new List<FX5__Contact_Qualification__c>();
        SET<ID> setMatchedQRsJobIds = new SET<ID>();
        LIST<FX5__Qualification_Requirement__c> lstMatchedQR = new LIST<FX5__Qualification_Requirement__c>();
        
        // Logic
        FOR(FX5__Qualification_Requirement__c objNewQR : lstNewQR){            
            setJobIds.add(objNewQR.FX5__Job__c);
        }
        System.Debug('Before INSERT:  Qr related Job Ids SET --> '+setJobIds);
        IF(setJobIds.size() > 0){
            getRelatedCP = [SELECT ID,FX5__Crew_Member__c,SD_Role_Description__c,FX5__Job__c
                             FROM FX5__Crew_Planning__c WHERE FX5__Job__c IN:setJobIds];
            System.Debug('Before INSERT : QR related Crew Planing Reocrds List(getRelatedCP)  -->' +getRelatedCP);
            IF(getRelatedCP.size()>0){
                FOR(FX5__Crew_Planning__c objCP :getRelatedCP){
                  setContactIds.add(objCP.FX5__Crew_Member__c);                     
                }
                System.Debug('Before INSERT :Crews related Contact IDS Set(setContactIds)--> '+setContactIds);
                IF(setContactIds.size()>0){
                  getRelatedConQuas = [SELECT ID,Name,FX5__Contact__c,FX5__Qualification__c 
                                       FROM FX5__Contact_Qualification__c WHERE FX5__Contact__c in: setContactIds AND SD_Status__c = 'Active'];
                  System.Debug('Before INSERT : Crew related Contact Qualifications Reocrds List(getRelatedConQuas)-->' +getRelatedConQuas);
                }
                // Match verification between Contact Qualification and Current QR records
                IF(getRelatedConQuas.size()>0 && lstNewQR.size()>0){
                    FOR(FX5__Qualification_Requirement__c objNewQR : lstNewQR){
                        FOR(FX5__Contact_Qualification__c objCQ :getRelatedConQuas){
                            IF(objNewQR.FX5__Qualification__c == objCQ.FX5__Qualification__c){
                                lstMatchedQR.add(objNewQR); 
                                setMatchedQRsJobIds.add(objNewQR.FX5__Job__c); 
                            }                            
                        }
                    }
                    System.Debug('Before INSERT : Matched Qualifications Reocrds List(lstMatchedQR) ===>'+lstMatchedQR);
                }
                
                IF(lstMatchedQR.size()>0){
                    FOR(FX5__Crew_Planning__c objCPs : getRelatedCP){
                        FOR(FX5__Qualification_Requirement__c objMatchQR : lstMatchedQR){                          
                          IF(objCPs.SD_Role_Description__c != 'Trainee' && objCPs.FX5__Crew_Member__c != null){
                                //1.    If qualification requirement is Fundamental 
                                if(objMatchQR.SD_Type__c == 'Fundamental'){                                
                                  System.debug('In Fundamental Type Block Line 64 '+objMatchQR.SD_No_Of_FP_With_Qualification__c+' '+objMatchQR.SD_Weight_Towards_Fulfillment__c);                                
                                  objMatchQR.SD_No_Of_FP_With_Qualification__c = objMatchQR.SD_No_Of_FP_With_Qualification__c+1;
                                  objMatchQR.SD_Weight_Towards_Fulfillment__c = objMatchQR.SD_Weight_Towards_Fulfillment__c+1;
                                  System.debug('In Fundamental Type Block Line 67 '+objMatchQR.SD_No_Of_FP_With_Qualification__c+' '+objMatchQR.SD_Weight_Towards_Fulfillment__c);
                                }
                                // 2.   If qualification requirement is Type1/Type 2
                                else if((objMatchQR.SD_Type__c == 'Type 1') || (objMatchQR.SD_Type__c == 'Type 2')){                                
                                    System.debug('In Type 1 Type Block Line 77');                                
                                    objMatchQR.SD_No_Of_FP_With_Qualification__c = objMatchQR.SD_No_Of_FP_With_Qualification__c+1;
                                    if(objMatchQR.SD_Weight_Towards_Fulfillment__c == 0){
                                        objMatchQR.SD_Weight_Towards_Fulfillment__c = 1;
                                    } 
                                }      
                            }                           
                        }
                    }                   
                }                
            }          
        }
    } 
   
    // Method 2: Related Job Record Values Update on AFTER INSERT ACTION
    public void UpdateJobOnQRaInsert(List<FX5__Qualification_Requirement__c> lstNewQR){
      
        // Declarations
        SET<ID> setJobIds = new SET<ID>();        
        LIST<FX5__Job__c> getRelatedJobs= new LIST<FX5__Job__c>();
        LIST<FX5__Job__c> lstJobToUpdate= new LIST<FX5__Job__c>();
       
        List<FX5__Qualification_Requirement__c> getAllQRList = new List<FX5__Qualification_Requirement__c>();
        // Logic
        FOR(FX5__Qualification_Requirement__c objNewQR : lstNewQR){            
            setJobIds.add(objNewQR.FX5__Job__c);
        }
        System.Debug('AFTER INSERT:  Qr related Job Ids SET --> '+setJobIds);
        IF(setJobIds.size() > 0){ 
            getAllQRList = [SELECT ID,Name,FX5__Job__c,SD_Weight_Towards_Fulfillment__c,SD_Type__c,
                            SD_Weight_Towards_Total_Requirements__c,FX5__Qualification__c,SD_No_Of_FP_With_Qualification__c 
                            FROM FX5__Qualification_Requirement__c WHERE FX5__Job__c in:setJobIds];
            System.Debug('AFTER INSERT : All Qualifications Reocrds List(getAllQRList) ===>'+getAllQRList); 
            IF(getAllQRList.Size()>0){
                getRelatedJobs = [SELECT ID,Name,SD_Qualifications_Met__c FROM FX5__Job__c WHERE ID =: setJobIds];
                System.debug('AFTER INSERT :Related Job List (getRelatedJobs) -->  '+getRelatedJobs);
                
                // %Qualification Met Field Update Logic
                Decimal dWTF = 0;
                Decimal dWTTR= 0;
                Decimal dCalculation = 0;
                Map<id,Decimal> mapWithFinalJobValues = new Map<id,Decimal>();
                FOR(FX5__Job__c objJob: getRelatedJobs){
                    FOR(FX5__Qualification_Requirement__c objQR:getAllQRList){
                        IF(objJob.id == objQR.FX5__Job__c){
                            dWTF = dWTF + objQR.SD_Weight_Towards_Fulfillment__c;
                            dWTTR = dWTTR + objQR.SD_Weight_Towards_Total_Requirements__c;
                        }                
                    }
                    System.debug('AFTER INSERT : Final Value of dWTF--> '+dWTF);
                    System.debug('AFTER INSERT :Final Value of-->'+dWTTR);
                    If(dWTTR !=0){
                        dCalculation = dWTF/dWTTR*100;
                        if(dCalculation > 100){
                            dCalculation = 100;
                        }
                        else{
                           dCalculation = dWTF/dWTTR*100; 
                        }
                        mapWithFinalJobValues.put(objJob.Id,dCalculation);
                    }        
                    dWTF = 0;
                    dWTTR = 0;
                    dCalculation = 0;
                }
                System.debug('AFTER INSERT : mapWithFinalJobValues to UPDATE -->'+mapWithFinalJobValues);
                FOR (Id key : mapWithFinalJobValues.keySet()) {
                 FX5__Job__c objUJob = new FX5__Job__c();
                    objUJob.id = key;
                    objUJob.SD_Qualifications_Met__c = mapWithFinalJobValues.get(Key);
                    lstJobToUpdate.add(objUJob);
                }
                System.debug('lstJobToUpdate' + lstJobToUpdate);
                IF(lstJobToUpdate.size()>0){
                    System.debug('AFTER INSERT : Final Update JOB List (lstJobToUpdate) '+lstJobToUpdate);                               
                    Database.SaveResult[] srList = Database.update(lstJobToUpdate, false);
                    FOR (Database.SaveResult sr : srList) {
                       IF (sr.isSuccess()) { 
                          System.debug('Successfully updated Job. Job ID is : ' + sr.getId());                  
                       } 
                       ELSE {                  
                          FOR(Database.Error objErr : sr.getErrors()) {
                             System.debug('The following error has occurred.');
                             System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                             System.debug('Job object field which are affected by the error:'+ objErr.getFields());
                          }
                       }
                    }           
                    System.Debug('SD_Qualifications_Met__c **************UPDATED');
                }
            }              
                
            }           
            
        }
        
    // Method 3: Related Job Record Values Update on AFTER DELETE ACTION  
    public void UpdateJobOnQRaDelete(List<FX5__Qualification_Requirement__c> lstOldQR){      
        // Declarations
        SET<ID> setJobIds = new SET<ID>();        
        LIST<FX5__Job__c> getRelatedJobs= new LIST<FX5__Job__c>();
        //LIST<FX5__Job__c> lstJobToUpdate= new LIST<FX5__Job__c>();
        FX5__Job__c objUJob = new FX5__Job__c();
        List<FX5__Qualification_Requirement__c> getAllQRList = new List<FX5__Qualification_Requirement__c>();
        List<FX5__Qualification_Requirement__c> getFundaQRList = new List<FX5__Qualification_Requirement__c>();
        // Logic
        FOR(FX5__Qualification_Requirement__c objOldQR : lstOldQR){            
            setJobIds.add(objOldQR.FX5__Job__c);
        }
        System.Debug('AFTER DELETE:  Qr related Job Ids SET --> '+setJobIds);
        IF(setJobIds.size() > 0){ 
            getAllQRList = [SELECT ID,Name,FX5__Job__c,SD_Weight_Towards_Fulfillment__c,SD_Type__c,
                            SD_Weight_Towards_Total_Requirements__c,FX5__Qualification__c,SD_No_Of_FP_With_Qualification__c 
                            FROM FX5__Qualification_Requirement__c WHERE FX5__Job__c in:setJobIds];

            getFundaQRList = [SELECT ID,Name,FX5__Job__c,SD_Weight_Towards_Fulfillment__c,SD_Type__c,
                            SD_Weight_Towards_Total_Requirements__c,FX5__Qualification__c,SD_No_Of_FP_With_Qualification__c 
                            FROM FX5__Qualification_Requirement__c WHERE FX5__Job__c in:setJobIds AND SD_Type__c = 'Fundamental'];             
            System.Debug('AFTER DELETE : All Qualifications Reocrds List(getAllQRList) ===>'+getAllQRList); 
            IF(getAllQRList.Size()>0){
                getRelatedJobs = [SELECT ID,Name,SD_Qualifications_Met__c FROM FX5__Job__c WHERE ID =: setJobIds];
                System.debug('AFTER DELETE :Related Job List (getRelatedJobs) -->  '+getRelatedJobs);
                
                // %Qualification Met Field Update Logic
                Decimal dWTF = 0;
                Decimal dWTTR= 0;
                Decimal dCalculation = 0;
                List<FX5__Job__c> lstWithFinalJobValues =new List<FX5__Job__c>(); 
                Map<id,Decimal> mapWithFinalJobValues = new Map<id,Decimal>();
                FX5__Job__c objFinalJobValue = new FX5__Job__c();
                FOR(FX5__Job__c objJob: getRelatedJobs){
                    FOR(FX5__Qualification_Requirement__c objQR:getAllQRList){
                        IF(objJob.id == objQR.FX5__Job__c){
                            dWTF = dWTF + objQR.SD_Weight_Towards_Fulfillment__c;
                            dWTTR = dWTTR + objQR.SD_Weight_Towards_Total_Requirements__c;
                        }                
                    }
                    System.debug('AFTER DELETE : Final Value of dWTF--> '+dWTF);
                    System.debug('AFTER DELETE :Final Value of-->'+dWTTR);
                    If(dWTTR !=0){
                        dCalculation = dWTF/dWTTR*100; 
                        if(dCalculation > 100){
                            dCalculation = 100;
                        }
                        else{
                           dCalculation = dWTF/dWTTR*100; 
                        }
                        //FX5__Job__c objFinalJobValue = new FX5__Job__c();
                        objFinalJobValue.id = objJob.Id;
                        objFinalJobValue.SD_Qualifications_Met__c = dCalculation;
                        lstWithFinalJobValues.add(objFinalJobValue);
                        //mapWithFinalJobValues.put(objJob.Id,dCalculation);
                    }        
                    dWTF = 0;
                    dWTTR = 0;
                    dCalculation = 0;
                }
                System.debug('AFTER DELETE : mapWithFinalJobValues to UPDATE -->'+lstWithFinalJobValues);
                /*System.debug('AFTER DELETE : mapWithFinalJobValues to UPDATE -->'+mapWithFinalJobValues.keySet());
                LIST<FX5__Job__c> lstJobToUpdate= new LIST<FX5__Job__c>();
                FOR (Id key : mapWithFinalJobValues.keySet()) {                    
                    objUJob.id = key;
                    objUJob.SD_Qualifications_Met__c = mapWithFinalJobValues.get(Key);
                    lstJobToUpdate.add(objUJob);
                    System.debug('AFTER DELETE : lstJobToUpdate in FOR Loop to UPDATE -->'+mapWithFinalJobValues.get(Key)+'-----'+lstJobToUpdate);
                }

                
                LIST<FX5__Job__c> lstJobToUpdate= new LIST<FX5__Job__c>();
                FOR (FX5__Job__c objJobToUpdate : lstWithFinalJobValues) {                    
                    objUJob.id = objJobToUpdate.id;
                    objUJob.SD_Qualifications_Met__c = objJobToUpdate.SD_Qualifications_Met__c;
                    lstJobToUpdate.add(objUJob);
                    System.debug('AFTER DELETE : lstJobToUpdate in FOR Loop to UPDATE -->'+objUJob+'-----'+lstJobToUpdate);
                } */
                IF(lstWithFinalJobValues.size()>0){
                    System.debug('AFTER DELETE : Final Update JOB List (lstWithFinalJobValues) '+lstWithFinalJobValues);                               
                    Database.SaveResult[] srList = Database.update(lstWithFinalJobValues, false);
                    FOR (Database.SaveResult sr : srList) {
                       IF (sr.isSuccess()) { 
                          System.debug('AFTER DELETE :Successfully updated Job. Job ID is : ' + sr.getId());                  
                       } 
                       ELSE {                  
                          FOR(Database.Error objErr : sr.getErrors()) {
                             System.debug('AFTER DELETE :The following error has occurred.');
                             System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                             System.debug('AFTER DELETE :Job object field which are affected by the error:'+ objErr.getFields());
                          }
                       }
                    }           
                    System.Debug('AFTER DELETE :SD_Qualifications_Met__c **************UPDATED');
                }
            } 
            System.debug('getFundaQRList.size() -->'+getFundaQRList.size());
            IF(getFundaQRList.size() == 0){
                    LIST<FX5__Job__c> lstJobswithNoQRs= new LIST<FX5__Job__c>();
                    LIST<FX5__Job__c> lstJobswithNoQRsToUpdate= new LIST<FX5__Job__c>();
                    /*SET<ID> setNoFundaJobIds = new SET<ID>();
                    FOR(FX5__Qualification_Requirement__c objOldFundaQR : getFundaQRList){            
                        setNoFundaJobIds.add(objOldFundaQR.FX5__Job__c);
                    }*/
                    lstJobswithNoQRs = [SELECT ID,SD_NoFundaQRs__c,SD_Fundamentals_Added__c,SD_Fundamentals_To_Be_Added__c,SD_Job_Items_Added__c 
                                        FROM FX5__Job__c WHERE ID IN:setJobIds];
                    System.debug('lstJobswithNoQRs  -->'+lstJobswithNoQRs);
                    FOR(FX5__Job__c objJob : lstJobswithNoQRs){
                        FX5__Job__c objUpdateJob = new FX5__Job__c(); 
                        IF(objJob.SD_Job_Items_Added__c == true){
                            objUpdateJob.Id = objJob.Id;
                            objUpdateJob.SD_Fundamentals_To_Be_Added__c = true;
                            objUpdateJob.SD_Fundamentals_Added__c = false;
                            objUpdateJob.SD_NoFundaQRs__c = True;
                            lstJobswithNoQRsToUpdate.add(objUpdateJob);
                            system.debug('underif');
                        }
                        else{
                            objUpdateJob.Id = objJob.Id;
                            objUpdateJob.SD_NoFundaQRs__c = True;
                            objUpdateJob.SD_Fundamentals_To_Be_Added__c = false;
                            objUpdateJob.SD_Fundamentals_Added__c = false; 
                            lstJobswithNoQRsToUpdate.add(objUpdateJob);
                             system.debug('underelse');
                        }
                    }
                System.debug('lstJobswithNoQRsToUpdate  -->'+lstJobswithNoQRsToUpdate);
                Update lstJobswithNoQRsToUpdate;              
                    
            }
                
            }           
            
        }     
 
    //Method 4: To Update SD_Qualifications_Met__c field on JOB on changes of Crew Planing.
    public void updateJobOnCPchanges(Set<Id> setRelatedJobIds){

        List<FX5__Job__c> getJobList = [Select Id,Name,SD_Qualifications_Met__c from FX5__Job__c where Id =: setRelatedJobIds];
        System.debug('Related Job List  '+getJobList);
        
        List<FX5__Crew_Planning__c> getRelatedCP = [Select id,FX5__Crew_Member__c from FX5__Crew_Planning__c where FX5__Job__c in:setRelatedJobIds];
        System.debug('Related CP Records List of the Jobs  '+getRelatedCP);
        if(getRelatedCP.size()>0){   
            for(FX5__Crew_Planning__c objCP:getRelatedCP){
                setContactIds.add(objCP.FX5__Crew_Member__C);                
            }
        }        
        List<FX5__Contact_Qualification__c> getRelatedCQs = [SELECT Id,Name,FX5__Contact__c,FX5__Qualification__c 
                                                             FROM FX5__Contact_Qualification__c WHERE FX5__Contact__c in:setContactIds AND SD_Status__c = 'Active'];
         
        set<id> objChildQRs = new Set<id>();
        For(FX5__Job__c objJob: getJobList){
            objChildQRs.add(objJob.Id);
        }
        
        List<FX5__Qualification_Requirement__c> getQRList = [Select Id,Name,FX5__Job__c,SD_Weight_Towards_Fulfillment__c,SD_Type__c,
                                                            SD_Weight_Towards_Total_Requirements__c,FX5__Qualification__c,SD_No_Of_FP_With_Qualification__c 
                                                            from FX5__Qualification_Requirement__c where FX5__Job__c in:objChildQRs];
        
        System.debug('ContactQualification (getRelatedCQs) List  and Qualification Requirement List(getQRList)  '+getRelatedCQs+'******'+getQRList);
        
        List<FX5__Qualification_Requirement__c> lstMatchedQR = new List<FX5__Qualification_Requirement__c>();
        
        for(FX5__Contact_Qualification__c objCQ:getRelatedCQs){
            for(FX5__Qualification_Requirement__c objQR:getQRList){               
                if(objCQ.FX5__Qualification__c == objQR.FX5__Qualification__c){
                    lstMatchedQR.add(objQR);                    
                }
            }
        }        
        System.debug('Qualification Value Matched List : lstMatchedQR ********'+lstMatchedQR);
        if(lstMatchedQR.size()>0){
        Decimal dWTF = 0;
        Decimal dWTTR= 0;
        Decimal dCalculation = 0;
        Map<id,Decimal> mapWithFinalJobValues = new Map<id,Decimal>();
        for(FX5__Job__c objJob: getJobList){
            for(FX5__Qualification_Requirement__c objQR:getQRList){
                if(objJob.id == objQR.FX5__Job__c){
                    dWTF = dWTF + objQR.SD_Weight_Towards_Fulfillment__c;
                    dWTTR = dWTTR + objQR.SD_Weight_Towards_Total_Requirements__c;
                }                
            }
            System.debug('Final Value of dWTF '+dWTF);
            System.debug('Final Value of'+dWTTR);
            If(dWTTR !=0){
                dCalculation = dWTF/dWTTR*100; 
                if(dCalculation > 100){
                            dCalculation = 100;
                        }
                        else{
                           dCalculation = dWTF/dWTTR*100; 
                        }
                mapWithFinalJobValues.put(objJob.Id,dCalculation);
            }        
            dWTF = 0;
            dWTTR = 0;
            dCalculation = 0;
        }
        System.debug('mapWithFinalJobValues to UPDATE ');
        
        List<FX5__Job__c> lstJobToUpdate = new List<FX5__Job__c>();
        FX5__Job__c objJob = new FX5__Job__c();
        for (Id key : mapWithFinalJobValues.keySet()) {
            objJob.id = key;
            objJob.SD_Qualifications_Met__c = mapWithFinalJobValues.get(Key);
            lstJobToUpdate.add(objJob);
        }
        If(lstJobToUpdate.size()>0){
            System.debug('Final Update List '+lstJobToUpdate);
            //update lstJobToUpdate;            
            Database.SaveResult[] srList = Database.update(lstJobToUpdate, false);
            for (Database.SaveResult sr : srList) {
               if (sr.isSuccess()) { 
                  System.debug('Successfully updated Job. Job ID is : ' + sr.getId());                  
               } else {                  
                  for(Database.Error objErr : sr.getErrors()) {
                     System.debug('The following error has occurred.');
                     System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
                     System.debug('Job object field which are affected by the error:' 
                        + objErr.getFields());
                  }
               }
            }           
            System.Debug('SD_Qualifications_Met__c **************UPDATED');
        }
    }   
    } 
   
}