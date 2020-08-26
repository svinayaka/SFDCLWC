/*
Class/Trigger Name     : O_SynergyDetail_Trig_GE_OG
Used Where ?           : To check for duplicate year synergy entry into Campaign
Purpose/Overview       : To check for duplicate year synergy entry into Campaign
Scrum Team             : OPPTY MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 06/JUN/2017
Test Class Name        : O_SynergyDetail_Handler_GE_OG_Test
Code Coverage          : 80
Changes                :                   
*/

trigger O_SynergyDetail_Trig_GE_OG on Synergy_Detail_ge_og__c (before insert,before update) {

  O_SynergyDetail_Handler_GE_OG synDetHandler = new O_SynergyDetail_Handler_GE_OG();
  Opportunity_Trigger_Controller_ge_og__c custmObj = Opportunity_Trigger_Controller_ge_og__c.getValues('O_SynergyDetail_Trig_GE_OG');
  System.debug('------------------------>>> custmObj.Is_Active_ge_og__c:'+custmObj.Is_Active_ge_og__c);      
  if(custmObj !=null && custmObj.Is_Active_ge_og__c && custmObj.Object_ge_og__c=='Synergy_Detail_ge_og__c'){
    if(trigger.isInsert || trigger.isUpdate ){  
    	
        synDetHandler.createSynergyDetailName(trigger.new);
        synDetHandler.checkDuplicateYearEntry(trigger.new);
    }
    
  }
  else{     
        System.debug('------------------------Synergy Detail Trigger is Off');
        return;
  }
	   
}