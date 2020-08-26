/*
Class/Trigger Name     : O_Lead_Trig_GE_OG
Used Where ?           : 
Purpose/Overview       : Used for Lead records to update the CMRs status
Scrum Team             : OPPTY MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 22/FEB/2017
Test Class Name        : O_Lead_Test_GE_OG
Code Coverage          : 
*/

trigger O_Lead_Trig_GE_OG on Lead (before insert,before update) {
   Opportunity_Trigger_Controller_ge_og__c custmObj = Opportunity_Trigger_Controller_ge_og__c.getValues('O_Lead_Trig_GE_OG');
   if(custmObj !=null && custmObj.Is_Active_ge_og__c && custmObj.Object_ge_og__c=='Lead'){ 
   
       O_LeadHandler_GE_OG leadHandler = new O_LeadHandler_GE_OG();
       O_PopulateRegionOnLead_GE_OG leadRegionHandler = new O_PopulateRegionOnLead_GE_OG();
       if(trigger.isBefore ){
           if(trigger.isUpdate && CheckRecursion_GE_OG.leadRecusrion()){
              System.debug('----------In O_Lead_Trig_GE_OG Updating CMRs as per Blaclisted Lead');
              leadHandler.updateBlacklistedLeadCMR(trigger.new, trigger.oldMap);
              leadRegionHandler.updateRegionOnLead(trigger.new);
           }
       }
       if(trigger.isBefore ){
           if(trigger.isInsert && CheckRecursion_GE_OG.leadRecusrion()){
              leadRegionHandler.updateRegionOnLead(trigger.new);
           }
       }
    }
    else{   
        return;
    }  
}