trigger FSProjectDetail_AllEventsTrigger on GE_OG_FS_Project_Detail__c (before update, after update , before delete) {
       if(Trigger.isAfter && Trigger.isUpdate){
             GE_SS_FS_Project_Trigger_Helper.invokeFSProjectDetailUpdateSubmitToOracle(Trigger.new,Trigger.oldmap) ;
       }
       
       if(Trigger.isBefore && Trigger.isUpdate){
             GE_SS_FS_Project_Trigger_Helper.onBeforeUpdate(Trigger.new,Trigger.oldmap) ;
       }
       
       if(Trigger.isBefore && Trigger.isDelete){
            GE_SS_FS_Project_Trigger_Helper.preventFSProjectLineDeletion(Trigger.old) ;
       }
}