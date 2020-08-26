/*
Trigger Name                  -   GE_OG_CustomOpportunityTrigger 
Object Name                   -   Custom_Opportunity__c 
Created Date                   -   3/21/2016
Modified Date                  -   24/04/2019
Modified By                      -  Shiv Pratap Singh Bhadauria for R-31943          
Description                       -  Single Trigger on the Custom Opportunity object, Uses a Handler Class GE_OG_CustomOpportunityTriggerHandler.All Logic to be processed in the handler Clases being called from the Trigger.                             
*/

trigger GE_OG_CustomOpportunityTrigger on Custom_Opportunity__c ( before insert , after update ) {   
   if(Trigger.isBefore){
      if(Trigger.isInsert){
         GE_OG_CustomOpportunityTriggerHandler.OnBeforeInsert(Trigger.new) ;
      }   
   }
   
   if(Trigger.isAfter){
        if(Trigger.isUpdate && !SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPostUpdateTimesheets()){ 
           GE_OG_CustomOpportunityTriggerHandler.OnAfterUpdate(Trigger.new) ;
           SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPostUpdateTimesheets() ;           
        }        
   }    
} // End of Trigger Body GE_OG_CustomOpportunityTrigger