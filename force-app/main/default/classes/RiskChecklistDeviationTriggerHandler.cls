/*
Class/Trigger Name     : RiskChecklistDeviationTriggerHandler
Used Where ?           : RiskChecklistDeviationTrigger_GE_OG
Purpose/Overview       : it will contains all the functionality around Risk Checklist Deiation to Populate Text Fields on the basis of reference
Scrum Team             : Transformation - Deal MGMT
Requirement Number     : R-23494
Author                 : Nitish Pandey
Created Date           : 09/OCT/2015
Test Class Name        : CreateDealDesk_GE_OG_Test
Code Coverage          : 100%
*/


public class RiskChecklistDeviationTriggerHandler{
    
    public void updateDeviationText(List<Risk_Checklist_Deviation_ge_og__c> newListDeviation, Map<Id,Risk_Checklist_Deviation_ge_og__c> oldMapDeviation){
        
        //Initializing Variable
        Map<id, Checklist_Deviation_ge_og__c> deviationMap = new Map<id,Checklist_Deviation_ge_og__c>();
        List<Risk_Checklist_Deviation_ge_og__c> updateRCDList = new List<Risk_Checklist_Deviation_ge_og__c>();
        Set<Id> clDeviationSet = new Set<Id>();
        
        //for loops for Adding unique Checkklist Deviation,later be used in SOQL to fetch details
        for(Risk_Checklist_Deviation_ge_og__c rcd : newListDeviation){
            System.debug('----Into RiskChecklistDeviationTrigger Handler.updateDeviationText --------->'+rcd.deviation_reference_ge_og__c);
            clDeviationSet.add(rcd.deviation_reference_ge_og__c);
        }
        
        //Getting Checklist Deviation details and using in for loop to put value in Map
        for(Checklist_Deviation_ge_og__c cdList : [select id, deviation_ge_og__c, checklist_deviation_level_ge_og__c, checklist_id_ge_og__r.question_ge_og__c from Checklist_Deviation_ge_og__c where id in : clDeviationSet]){
           
            deviationMap.put(cdList.id, cdList);
        }
        
        //for loop in RIsk Checklist Deviation for populating text Feilds
        for(Risk_Checklist_Deviation_ge_og__c rcd : newListDeviation){
            System.debug('----Into RiskChecklistDeviationTrigger Handler deviationMap --------->'+newListDeviation.size());
            if(deviationMap.get(rcd.deviation_reference_ge_og__c) != null){
                System.debug('----Into RiskChecklistDeviationTrigger Handler deviationMap --------->'+Integer.ValueOf(deviationMap.get(rcd.deviation_reference_ge_og__c).checklist_deviation_level_ge_og__c));
                rcd.rcl_deviation_level_ge_og__c = Integer.ValueOf(deviationMap.get(rcd.deviation_reference_ge_og__c).checklist_deviation_level_ge_og__c);
                rcd.risk_checklist_ge_og__c = deviationMap.get(rcd.deviation_reference_ge_og__c).checklist_id_ge_og__r.question_ge_og__c;
                rcd.rcl_deviation_ge_og__c = deviationMap.get(rcd.deviation_reference_ge_og__c).deviation_ge_og__c;
            }
            //Added to nullify answer if deviation reference is removed by user
           /*  else if (rcd.risk_checklist_category_id_ge_og__r.deal_desk_id_ge_og__r.deal_desk_opportunity_id_ge_og__r.isClosed == FALSE && rcd.deviation_reference_ge_og__c == null){
                 System.debug('----Into RiskChecklistDeviationTrigger Handler deviationMap --------->'+rcd.rcl_deviation_ge_og__c);
                 rcd.rcl_deviation_ge_og__c = null;
            } */
           
            
        }
        
    }

}