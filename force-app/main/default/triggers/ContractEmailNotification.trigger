trigger ContractEmailNotification on Opportunity_Contract_Relationship_GE_OG__c (after insert) {
          Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'Opportunity_Contract_Relationship_GE_OG__c' limit 1];
          boolean isEnabled = true;
          
            if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
    
    if(isEnabled){
          if(trigger.isInsert){
          if(trigger.isAfter){
                EmailToOpptyTeamMembOnContractCreation.SendMailToContractOwner(trigger.new);
                system.debug('call method');
          }
          }
          }
}