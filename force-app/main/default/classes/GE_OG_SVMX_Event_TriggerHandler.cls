/*
Class Name                   - GE_OG_SVMX_Event_TriggerHandler  
Object Name                  - SVMXC__SVMX_Event__c
Created Date                 - 8/11/2014
Description                  -  Handler Class GE_OG_SVMX_Event_TriggerHandler  would process all the Trigger requests coming from GE_OG_SVMX_Event_Trigger
All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/
public without sharing class GE_OG_SVMX_Event_TriggerHandler {
    
    public void OnBeforeInsert(List<SVMXC__SVMX_Event__c> newObjects){
   
        /*GE_DS_UpdateDispatcherOnEvent eventupdate = new GE_DS_UpdateDispatcherOnEvent();
          eventupdate.Updatedispatcher(newObjects); */    
    }
    
    public void OnAfterInsert(List<SVMXC__SVMX_Event__c> newObjects){    
        // EXECUTE AFTER INSERT LOGIC
        
        //R-29069 OFS Logic starts
       /* GE_OG_GS_FFJ_Indicators evntHandler = new GE_OG_GS_FFJ_Indicators();
        evntHandler.updateOFS_WO_Status(newObjects);*/
        //R-29069 OFS Logic Ends 
       
        
        /* R-26650 Subsea Logic */
         GE_SS_Calculate_Taining_Days techUpdate = new GE_SS_Calculate_Taining_Days();
         techUpdate.GE_SS_sumOf_TrainingDays(newObjects);
        /* End of Subsea Logic */
         
              // Start of MC- Final Event dates capturing req.-Req: R-23916
        GE_OG_MC_EventDateChanges eventHandler = new GE_OG_MC_EventDateChanges();
        System.debug('From After Insert---->');
        eventHandler.eventDatesExtraction(newObjects);
        //Start: R-22789 : Auto creation of Expertise Records based on Skill field value on WO when Wo is Assigned to Tech       
        GE_OG_PC_WOupdateExpertise.createExpertise(newObjects);         
        //End : R-22789 
        
        //Start: R-23659 : Fit For Job Managment
        GE_OG_GS_FFJ_Indicators handler = new GE_OG_GS_FFJ_Indicators();
        handler.CreateFFJIndicators(newObjects);
        //End : R-23659  
        
        // Start R-24352
        GE_OG_HQ_WO_SetEndDateTime.setEndDateTimeInsertUpdate(newObjects);  
        // End R-24352
         
        // R-22725
        //Commenting as part of R-26370 as not in use anymore
       // GE_SS_Tech_Assignment.manageTechAssignments (newObjects, null, true, false, false);
        // Start R-24278
        GE_OG_Skillmismatchclass.GE_OG_SkillMismatch(newObjects,true,false);
         // End R-24278
         
          //DTS Timesheet helper
           if(!SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPostInsertTimesheets()){                
         GE_OG_DTS_TimesheetHelper.createTimesheetFromSvmxeventinsert(newObjects);
         GE_OG_DTS_TimesheetHelper.updatetimesheetfornewevents(newObjects);
         SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPostInsertTimesheets();
         }
         
         
          /*-----------DTS Event Delete------------*/
         GE_DTS_NON_HOME_TERRITORY dtshelper = new GE_DTS_NON_HOME_TERRITORY();
         dtshelper.nonhomeeventdelete(newObjects);
         /*-----------DTS Event Delete------------*/
        
         
        
    }
    
    public void OnBeforeUpdate(List<SVMXC__SVMX_Event__c> oldObjects, List<SVMXC__SVMX_Event__c> newObjects, Map<Id, SVMXC__SVMX_Event__c> newObjectMap){ 
    
        GE_DS_UpdateDispatcherOnEvent eventupdate = new GE_DS_UpdateDispatcherOnEvent();
          eventupdate.Updatedispatcher(newObjects); 
        
        //start of MCS-Event deletion
      //GE_DS_EventAfterdelete deleteEvent = new GE_DS_EventAfterdelete();
       //deleteEvent.Eventdeletion(newObjects);
        //End of MCS-Event deletion
    }
    
    public void OnAfterUpdate(List<SVMXC__SVMX_Event__c> oldObjects, List<SVMXC__SVMX_Event__c> newObjects, Map<Id, SVMXC__SVMX_Event__c> newObjectMap, Map<Id, SVMXC__SVMX_Event__c> oldObjectMap){
        
        /* R-26650 Commenting Subsea Logic */
        GE_SS_Calculate_Taining_Days techUpdate = new GE_SS_Calculate_Taining_Days();
        techUpdate.GE_SS_sumOf_TrainingDaysupdate(newObjects,oldObjectMap);
        
        // AFTER UPDATE LOGIC
        // Start of MC- Final Event dates capturing req.-Req: R-23916
        GE_OG_MCS_EventupdateWO WOUpdate=new GE_OG_MCS_EventupdateWO();
        WOUpdate.afterupdatesvmxevent(oldObjects,newObjects,newObjectMap);
        GE_OG_MC_EventDateChanges  eventHandler = new GE_OG_MC_EventDateChanges();
        System.debug('From After Update ---->');
        eventHandler.eventDatesExtraction(newObjects);
        
        // Start R-24352
        GE_OG_HQ_WO_SetEndDateTime.setEndDateTimeInsertUpdate(newObjects);  
        // End R-24352
       
        //start of MCS-Event deletion
        GE_DS_RemoveTechnicianforServicemaxevent  deleteEvent = new GE_DS_RemoveTechnicianforServicemaxevent();
        deleteEvent.Eventtechnician(newObjects);
       //End of MCS-Event deletion
      
       GE_DS_EventSubmitForApproval eventapprv = new GE_DS_EventSubmitForApproval();
       eventapprv.EventSubmitForApproval(newObjects);
  
       
        // R-22725
        //Commenting as part of R-26370 as not in use anymore
        //GE_SS_Tech_Assignment.manageTechAssignments (newObjects, null, false, true, false);
        // Start R-24278
        GE_OG_Skillmismatchclass.GE_OG_SkillMismatch(newObjects,false,true);              
        // End R-24278
        
        
         //DTS Timesheet helper
         if((!SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPostUpdateTimesheets() && !SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPostInsertTimesheets()) || Test.isRunningTest()){
         GE_OG_DTS_TimesheetHelper.createTimesheetFromSvmxeventinsert(newObjects);
         GE_OG_DTS_TimesheetHelper.updatetimesheetforoldevents(oldObjects);
         GE_OG_DTS_TimesheetHelper.updatetimesheetfornewevents(newObjects);
         SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPostUpdateTimesheets();
        // SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPostInsertTimesheets();
         } 
        
        System.debug('Final number of script statements used so far : ' + Limits.getDmlStatements());
        
    }
    
    public void OnBeforeDelete(List<SVMXC__SVMX_Event__c> ObjectsToDelete, Map<Id, SVMXC__SVMX_Event__c> oldObjectMap){
        // BEFORE DELETE LOGIC
        //Req: R-23916
        GE_OG_MC_EventDateChanges  eventHandler = new GE_OG_MC_EventDateChanges();
        eventHandler.eventDatesDeletion(ObjectsToDelete);
         //Req: R-24661
          System.debug('in smaxevent handler delete'+ObjectsToDelete);
       GE_HQ_WorkorderTechUnAssignment.getTechnicianEmail(ObjectsToDelete);
        
    }
    
    public void OnAfterDelete(List<SVMXC__SVMX_Event__c> deletedObjects, Map<Id, SVMXC__SVMX_Event__c> oldObjectMap){
        // Start R-24352
        GE_OG_HQ_WO_SetEndDateTime.setEndDateTimeDelete(deletedObjects); 
        // End R-24352
        
        // R-22725
        //Commenting as part of R-26370 as not in use anymore
        //GE_SS_Tech_Assignment.manageTechAssignments (null, oldObjectMap, false, false, true);
        
        //DTS timesheet helper
         GE_OG_DTS_TimesheetHelper.updatetimesheetforoldevents(deletedObjects);
        
        
    }
    
    public void OnUndelete(List<SVMXC__SVMX_Event__c> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
    
    
}