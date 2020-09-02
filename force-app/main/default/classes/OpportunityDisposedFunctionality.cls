/*
Class/Trigger Name     : OpportunityDisposedFunctionality
Used Where ?           : OpportunityTriggerHandler_GE_OG
Purpose/Overview       : Removing Refrences from Fulfillment Checklist and Risk Checklist when Opportunity is Disposed
Scrum Team             : Transformation - Deal MGMT
Requirement Number     : R-24236
Author                 : Nitish Pandey
Created Date           : 16/Mar/2016
Test Class Name        : RiskChecklistController_GE_OG_Test
Code Coverage          : 88%
*/


public class OpportunityDisposedFunctionality{

    public void removeRefrences(List<Opportunity>disposedOpportunities){
        System.debug('---------- OpportunityDisposedFunctionality.removeRefrences'+disposedOpportunities.size());
        //Defining Variables
        List<Fulfillment_Checklist_Deviation_ge_og__c> updateFFChecklistDeviationList = new List<Fulfillment_Checklist_Deviation_ge_og__c>();
        List<Risk_Checklist_Deviation_ge_og__c> updateRiskChecklist = new List<Risk_Checklist_Deviation_ge_og__c>();
        
        //For Loop on Fulfillment Checklist Deviation associated with Opportunities
        for( Fulfillment_Checklist_Deviation_ge_og__c ffChecklistDeviation : [select id, ff_checklist_reference_ge_og__c from 
                                                                                Fulfillment_Checklist_Deviation_ge_og__c where 
                                                                                ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c in : disposedOpportunities]){
            //Removing refrences
            ffChecklistDeviation.ff_checklist_reference_ge_og__c = null;
            UpdateffChecklistDeviationList.add(ffChecklistDeviation);
        }
        
        //Updating Fulfillment Checklist Deviation after removing refrences
        if(UpdateffChecklistDeviationList !=null)
            update UpdateffChecklistDeviationList;
        
        // Fetching Deal Desk related to Opportunities
        List<Deal_Desk_ge_og__c> ddList = [Select id from Deal_Desk_ge_og__c where deal_desk_opportunity_id_ge_og__c in : disposedOpportunities];
        
        //For Loops on RIsk Checklist deviation related with Deal Desk
        if(ddList != null){
            for(Risk_Checklist_Deviation_ge_og__c rcDeviation : [select id, checklist_reference_ge_og__c, deviation_reference_ge_og__c from 
                                                                Risk_Checklist_Deviation_ge_og__c where 
                                                                risk_checklist_category_id_ge_og__r.RCC_Opportunity_ge_og__c in : disposedOpportunities]){
                //removing References
                rcDeviation.checklist_reference_ge_og__c = null;
                rcDeviation.deviation_reference_ge_og__c = null;
                updateRiskChecklist.add(rcDeviation);
            }
        }
        //Updating Risk Checklist Deviation after removing refrences
        if(updateRiskChecklist != null)
            update updateRiskChecklist;
    }
}