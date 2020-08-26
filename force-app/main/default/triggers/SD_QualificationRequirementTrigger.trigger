/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 06/Sept/2019
Purpose     : To Implement functionlaity / business logic for Schedule and/or Dispatch qualified Personnel to a Job.
              Ref #R-32464
                - Trigger on deletion,UPSERT of qualification requirement:
                    Update the % qualifications met on the Job object.
                Logic :  % Qualifications met: To be calculated as a summation of weight towards fulfilment/summation of weight towards total requirements*100
Modified By :
Modified On :
Purpose     :
========================================================
*/
trigger SD_QualificationRequirementTrigger on FX5__Qualification_Requirement__c (before insert,after insert,before update,after Delete) {
   SD_QualificationReqTriggerHandler objQRTrgHndlr = new SD_QualificationReqTriggerHandler();
     if(Trigger.isBefore && Trigger.isInsert){
        System.debug('VM Test : I am In Qualification Requirement Before Insert Trigger');
        objQRTrgHndlr.setQRValuesOnQRbInsert(Trigger.New); 
    }
    if(Trigger.isAfter && Trigger.isInsert){
        System.debug('VM Test :I am In Qualification Requirement After Insert Trigger');
        objQRTrgHndlr.UpdateJobOnQRaInsert(Trigger.New); 
        
    }
     if(Trigger.isBefore && Trigger.isUpdate){
       System.debug('I am In Qualification Requirement Before Update Trigger');        
       for(FX5__Qualification_Requirement__c NewQRMap : Trigger.New) {      
                if(NewQRMap.FX5__Qualification__c != Trigger.OldMap.get(NewQRMap.id).FX5__Qualification__c) {
                    NewQRMap.addError('Qualification value can not be modified on qualification Requirment Record - If need to change, Delete exist one and recreate new Qualification Record');
                }           
        } 
   }
   if(Trigger.isAfter && Trigger.isDelete){
        System.debug('VM Test : I am In Qualification Requirement After Delete Trigger');    
        objQRTrgHndlr.UpdateJobOnQRaDelete(Trigger.old);
    }
}