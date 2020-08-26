/*
Class/Trigger Name     : O_Campaign_Trig_GE_OG
Used Where ?           : 
Purpose/Overview       : Used for Campaign records
Scrum Team             : OPPTY MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 09/FEB/2017
Test Class Name        : O_Campaign_TestGE_OG
Code Coverage          : 
*/

trigger O_Campaign_Trig_GE_OG on Campaign (before insert, before update, after insert) {
  
 Opportunity_Trigger_Controller_ge_og__c custmObj = Opportunity_Trigger_Controller_ge_og__c.getValues('O_Campaign_Trig_GE_OG');
 //System.debug('------------------------>>> custmObj.Is_Active_ge_og__c:'+custmObj.Is_Active_ge_og__c);      
 if(custmObj !=null && custmObj.Is_Active_ge_og__c && custmObj.Object_ge_og__c=='Campaign'){
       
    O_CampaignHelper_GE_OG  cmpgnHelper = new  O_CampaignHelper_GE_OG();
    O_CampaignMemberHandler_GE_OG cmrHandler = new O_CampaignMemberHandler_GE_OG();
     O_CampaignMemberStatus_GE_OG cmrStatus = new O_CampaignMemberStatus_GE_OG();
    //CampaignHandler chdlr = new CampaignHandler();
    if(trigger.isBefore){
            if(trigger.isInsert && !system.isBatch()){
                System.debug('------------------------Going to update Campaign on Insert Action!');  
                cmpgnHelper.updateParentCmpgnStatusFlds(trigger.new, trigger.oldMap, trigger.isInsert, trigger.isUpdate);
            }
            if(trigger.isUpdate && CheckRecursion_GE_OG.checkRecursionCampaign() && !system.isBatch()) {
              O_CampaignClosureAction closureAction = new O_CampaignClosureAction();
              System.debug('------------------------Going to update Campaign on Update Action!'); 
              closureAction.checkEditCampaignFlds(trigger.new, trigger.oldMap);
              cmpgnHelper.updateParentCmpgn(trigger.new, trigger.oldMap);  
              cmpgnHelper.automateStatusTransition(trigger.new, trigger.oldMap);     
              cmpgnHelper.updateParentCmpgnStatusFlds(trigger.new, trigger.oldMap, trigger.isInsert, trigger.isUpdate);
              cmpgnHelper.validatePrntCmpgnStartDt(trigger.new);  
              //chdlr.beforeUpdateHandler(trigger.new);
                          
            }
        
    } 
    if(trigger.isInsert && trigger.isAfter){
        system.debug('--->Calling O_CampaignMemberHandler_GE_OG from O_Campaign_Trig_GE_OG---');
        cmrStatus.autoInsertCampaignMemberStatus(trigger.new);
    }
          
  }
  else{     
        return;
  }
    
  
   // To create new set of Status for Campaign Members whenever a campaign is created
   
      
}