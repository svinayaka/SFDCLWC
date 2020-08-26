/**
* 
* Class/Trigger Name--: GE_PRM_CAA_TriggerHandler
* Used Where ?--------: Trigger on Channel Appointment Approver
* Purpose/Overview----: Execute Business logic in Non-Renew/Termination Process
* Functional Area-----: PRM
* Author--------------: Pradeep Rao Yadagiri
* Created Date--------: 10/9/2014
* Test Class Name-----: Test_GE_PRM_Channel_Appointment_Class
* Change History -
* Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
**/

trigger GE_PRM_CAA_TriggerHandler on GE_PRM_Channel_Appointment_Approver__c (before Insert, after Insert, before Update, after Update, before Delete, after Delete ) {
    
     
     
    //** Before Insert 
     if(Trigger.isInsert && Trigger.isBefore) {
     }
      
    //** After Insert
     if(Trigger.isInsert && Trigger.isAfter) {
     }
    //** Before Update 
     if(Trigger.isUpdate && Trigger.isBefore) {
     }
    
    //** after Update
    // calls the handlerclass method to check if all approvers of a commerical line are approved for NRT
     if(Trigger.isUpdate && Trigger.isAfter) {
     
       // checking the static variable to prevent recursion   
       if (!GE_PRM_TriggerhelperClass.sendmailToPublicgroup()){   
        GE_PRM_CAA_TriggerhelperClass.sendmailToPublicgroupAfterUpdate(Trigger.newMap);
        GE_PRM_TriggerhelperClass.setsendmailToPublicgroup();    
        }    
    }
    
     
    //** Before Delete 
     if(Trigger.isDelete && Trigger.isBefore) {
     }
      
    //** After Delete 
     if(Trigger.isDelete && Trigger.isAfter) {
     }
}