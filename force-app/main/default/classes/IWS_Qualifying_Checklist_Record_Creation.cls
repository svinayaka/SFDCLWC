/*
Class/Trigger Name     : IWS_Qualifying_Checklist_Record_Creation
Used Where ?           : Process builder to create records
Purpose/Overview       : Used to create IWS Qualifying Checklist  records for the predefined data available in Custom metadata. 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-32187
Author                 : Harsha C
Created Date           : 13/June/2019
Test Class Name        : 
Code Coverage          : 
*/
global class IWS_Qualifying_Checklist_Record_Creation {
      @InvocableMethod(label='IWS Qualifying Checklist creation' description='TO create IWS Qualifying Checklist Records')
  public Static void recordsOfIWSQualifyingChecklist(List<Id> OpportunityId){
        List<IWS_Qualifying_Checklist_GE_OG__c> listIWSQualifyingChecklist = new List<IWS_Qualifying_Checklist_GE_OG__c>();
        IWS_Qualifying_Checklist_CustomSetting__mdt[] iwsQualifyingChecklist =  [SELECT Category__c,Order_ge_og__c,Percentage_weight_ge_og__c,Reward_Risk_Factor_GE_OG__c,Reward_Risk_Guidance_GE_OG__c,Label FROM IWS_Qualifying_Checklist_CustomSetting__mdt] ;
      System.debug('iwsQualifyingChecklist >>> '+iwsQualifyingChecklist);  
      try{
            for(Id optyId : OpportunityId){
                for (IWS_Qualifying_Checklist_CustomSetting__mdt checklist : iwsQualifyingChecklist) {
                    IWS_Qualifying_Checklist_GE_OG__c iwsqualifyingchklist = new IWS_Qualifying_Checklist_GE_OG__c();
                    iwsqualifyingchklist.Category_GE_OG__c= checklist.Category__c;
                    iwsqualifyingchklist.Order_ge_og__c = checklist.Order_ge_og__c;
                    iwsqualifyingchklist.Objective__c = checklist.Label;
                    iwsqualifyingchklist.Reward_Risk_Guidance_GE_OG__c = checklist.Reward_Risk_Guidance_GE_OG__c;
                    iwsqualifyingchklist.opportunity_ge_og__c  = optyId;
                    iwsqualifyingchklist.Percentage_weight_ge_og__c = checklist.Percentage_weight_ge_og__c;
                    System.debug('iwsqualifyingchklist.Percentage_weight_ge_og__c >>> '+iwsqualifyingchklist.Percentage_weight_ge_og__c);
                    iwsqualifyingchklist.Reward_Risk_Factor_GE_OG__c = checklist.Reward_Risk_Factor_GE_OG__c;
                    listIWSQualifyingChecklist.add(iwsqualifyingchklist);
                }
            } 
            Database.insert(listIWSQualifyingChecklist);
        }
        catch(Exception e){
            System.debug('Exception occured in line number : '+e.getLineNumber());
            System.debug('Exception Message : '+e.getMessage());
            System.debug('Exception cause :'+e.getCause());
        }
    }
    
}