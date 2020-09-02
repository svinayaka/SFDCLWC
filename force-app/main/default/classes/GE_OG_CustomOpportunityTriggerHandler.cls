/*
Class Name                    - GE_OG_CustomOpportunityTriggerHandler 
Object Name                   - Custom Opportunity
Created Date                   - 3/21/2016
Modified By                      -  Shiv Pratap Singh Bhadauria for R-31943
Description                       -   Handler Class GE_OG_CustomOpportunityTriggerHandler would process all the Trigger requests coming from GE_OG_CustomOpportunityTrigger 
                                            All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/
Public without sharing class GE_OG_CustomOpportunityTriggerHandler {  
    public static void OnBeforeInsert(List<Custom_Opportunity__c> newObjects){       
        GE_OG_CustomOpportunityHelper.updateCustomOpportunity(newObjects) ;
    }//End of OnBeforeInsert method  
   
    public static void OnAfterUpdate(List<Custom_Opportunity__c> newObjects){        
          ID Rectype=Schema.SObjectType.Custom_Opportunity__c.getRecordTypeInfosByName().get('O&G').getRecordTypeId(); 
          Set<Id> recordIdSet = new Set<Id>() ;
          for(Custom_Opportunity__c  opptyMaxRecord: newObjects){
              if(opptyMaxRecord.RecordtypeId == Rectype && ( opptyMaxRecord.GE_OG_Customer_Name__c != null || opptyMaxRecord.GE_OG_Customer_Name__c != '') &&  String.IsBlank(opptyMaxRecord.GE_OG_Standard_Oppty__c )  && opptyMaxRecord.GE_OG_Opportunity_Elgible_Status__c == 'Approved' ){
                 recordIdSet.add(opptyMaxRecord.Id) ;
              }
          }          
          if(recordIdSet.size() > 0){            
              GE_OG_CustomOpportunityHelper.insertStandardOpportunity(recordIdSet) ;
          } 
    }//End of OnAfterUpdate method 
}