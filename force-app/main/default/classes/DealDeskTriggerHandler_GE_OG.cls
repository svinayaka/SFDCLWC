/*
Class/Trigger Name     : DealDeskTriggerHandler_GE_OG
Used Where ?           : DealDeskTrigger_GE_OG trigger
Purpose/Overview       : Used for creating "Risk Checklist Category" and "Risk Checklist Deviation" records
                         after Deal Desk records are inserted
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23281
Author                 : Sanath Kumar Dheram
Created Date           : 16/SEP/2015
Test Class Name        : CreateDealDesk_GE_OG_Test
Code Coverage          : 86
*/
public without sharing class DealDeskTriggerHandler_GE_OG
{
    //Method to be Called before Insertion of Deal Desk Record
    public void beforeInsertProcess(List<Deal_Desk_ge_og__c> newListDealDesk,Map<Id,Deal_Desk_ge_og__c> oldMapDealDesk){
        
        Set<id> dealOpptyIdsSet = new Set<id>(); //Set for storing Opptty's Id from Deal Desk
        DealDeskController_GE_OG ddController = new DealDeskController_GE_OG ();
        //Adding Oppty Id in Set
        for(Deal_Desk_ge_og__c dd:newListDealDesk){
            dealOpptyIdsSet.add(dd.deal_desk_opportunity_id_ge_og__c);
        }
        
        //using Aggregate result for counting active Deal desk on Opportunity
        List<aggregateResult> aggrResults = [select deal_desk_opportunity_id_ge_og__c oppty, count(id) totalDealDesk from 
                                            Deal_Desk_ge_og__c where Deal_desk_opportunity_id_ge_og__c in :dealOpptyIdsSet
                                            and active_deal_desk_ge_og__c = true group by Deal_desk_opportunity_id_ge_og__c ];
        ddController.checkActiveDealDesk(newListDealDesk,oldMapDealDesk,aggrResults);
        
        
        /***** For Calculating DD# ******/
        
        Map<Id,Deal_Desk_ge_og__c> opptyDealMap = new Map<Id,Deal_Desk_ge_og__c>();
        Map<String,Integer> opportunityProductCount = new Map<String,Integer>();
        Set<Id> opptyIds = new Set<Id>();
        
        for(Deal_Desk_ge_og__c dd:newListDealDesk){
            opptyIds.add(dd.deal_desk_opportunity_id_ge_og__c);
            if(dd.active_deal_desk_ge_og__c )
                opptyDealMap.put(dd.deal_desk_opportunity_id_ge_og__c,dd);
        }
        
        //Fetching Oppty List
        List<Opportunity> newOppList = [Select id,StageName,
                                        //all_risk_checklist_reviewed_ge_og__c,amount_level_ge_og__c, 
                                        opportunity_max_deviation_ge_og__c from Opportunity where id in : opptyIds];
        
        //Fetching Oppty Product Count
        List<AggregateResult> opportunityProductCountResult = [select OpportunityId opp, count(Id) productCount from OpportunityLineItem where OpportunityId in : newOppList group by OpportunityId ];
        //Adding Values to Map
        for(AggregateResult agg : opportunityProductCountResult ){
            opportunityProductCount.put(String.valueOf(agg.get('Opp')),Integer.valueOf(agg.get('productCount')));
        }
        //Calling Class for Calculating DD#
        //OpportunityStagesAutomationHandler_GE_OG opphandler = new OpportunityStagesAutomationHandler_GE_OG();
        //opphandler.updateDealDeskratingOppty(newOppList,opportunityProductCount,opptyDealMap);
    
        
    }
    
    
    //Method to be Called after Updation of Deal Desk Record
    public void afterUpdateProcess(List<Deal_Desk_ge_og__c> newListDealDesk, Map<Id,Deal_Desk_ge_og__c> mapOldDealDesk)
    {    
    
    
        Set<id> dealOpptyIdsSet = new Set<id>(); //Set for storing Opptty's Id from Deal Desk
        Set<Id> rccId = new Set<Id>();
         /************** For updating Risk Checklist Deviation when Deal Desk Approved **************/
        /*List<Risk_Checklist_Category_ge_og__c> rccList = new List<Risk_Checklist_Category_ge_og__c>();
               
        Map<id,List<Risk_Checklist_Deviation_ge_og__c>> ddRiskDeviationMap= new Map<id,List<Risk_Checklist_Deviation_ge_og__c>>();
        
         List <Risk_Checklist_Deviation_ge_og__c> riskChecklistDeviationList = [select id, checklist_reference_ge_og__c, rcl_deviation_ge_og__c,
                                                                 risk_checklist_category_id_ge_og__c,
                                                                 //risk_checklist_category_id_ge_og__r.deal_desk_id_ge_og__c,
                                                                 rcl_deviation_level_ge_og__c, deviation_reference_ge_og__c,
                                                                 risk_checklist_deviation_locked_ge_og__c,
                                                                 deviation_reference_ge_og__r.deviation_ge_og__c,
                                                                 checklist_reference_ge_og__r.question_ge_og__c,
                                                                 deviation_reference_ge_og__r.checklist_deviation_level_ge_og__c
                                                                 //,risk_checklist_category_id_ge_og__r.deal_desk_id_ge_og__r.id 
                                                                 from Risk_Checklist_Deviation_ge_og__c limit 10
                                                                 // where risk_checklist_category_id_ge_og__r.deal_desk_id_ge_og__c in : newListDealDesk
                                                                 ];
        
        for(Risk_Checklist_Deviation_ge_og__c rcd : riskChecklistDeviationList){
            rccId.Add(rcd.risk_checklist_category_id_ge_og__c);
            if(ddRiskDeviationMap.containsKey(rcd.risk_checklist_category_id_ge_og__r.deal_desk_id_ge_og__c)){
                ddRiskDeviationMap.get(rcd.risk_checklist_category_id_ge_og__r.deal_desk_id_ge_og__r.id).add(rcd);
            }
            else{
                list<Risk_Checklist_Deviation_ge_og__c>rcdList = new List<Risk_Checklist_Deviation_ge_og__c>();
                rcdList.add(rcd);
                ddRiskDeviationMap.put(rcd.risk_checklist_category_id_ge_og__r.deal_desk_id_ge_og__r.id ,rcdList);
            }
            
        
        }
        rccList = [select id,risk_checklist_locked_ge_og__c from Risk_Checklist_Category_ge_og__c where id=:rccId]; */
        
        /************** Logic Ends **************/
        
        DealDeskController_GE_OG ddController = new DealDeskController_GE_OG ();
        //Adding Oppty Id in Set
        for(Deal_Desk_ge_og__c dd:newListDealDesk){
            dealOpptyIdsSet.add(dd.deal_desk_opportunity_id_ge_og__c);
        }
        
        //using Aggregate result for counting active Deal desk on Opportunity
        List<aggregateResult> aggrResults = [select deal_desk_opportunity_id_ge_og__c oppty, count(id) totalDealDesk from 
                                            Deal_Desk_ge_og__c where Deal_desk_opportunity_id_ge_og__c in :dealOpptyIdsSet
                                            and active_deal_desk_ge_og__c = true group by Deal_desk_opportunity_id_ge_og__c ];
        ddController.checkActiveDealDesk(newListDealDesk,mapOldDealDesk,aggrResults);
    
        //Calling Approval process when Status changes to Submitted
        for(Deal_Desk_ge_og__c objDealDesk:newListDealDesk)
        {
        
            if(objDealDesk.status_ge_og__c == 'Submitted' && mapOldDealDesk.get(objDealDesk.Id).status_ge_og__c != 'Submitted')
            {
                DealDeskApprover_GE_OG objDealDeskApprover = new DealDeskApprover_GE_OG();
                objDealDeskApprover.SubmitRecord(objDealDesk);
                break;
            }
        }
        
        //Calling Approval process when Status changes to Approved
        for(Deal_Desk_ge_og__c objDealDesk:newListDealDesk)
        {
            if(objDealDesk.status_ge_og__c == 'Approved' && mapOldDealDesk.get(objDealDesk.Id).status_ge_og__c != 'Approved')
            {
                DealDeskApprover_GE_OG objDealDeskApprover = new DealDeskApprover_GE_OG();
                objDealDeskApprover.ApproveRecord(objDealDesk);
                
                //RiskChecklistController_GE_OG rcc = new RiskChecklistController_GE_OG();
                //rcc.updateRiskCheckListDeviation(ddRiskDeviationMap,rccList );
                break;
            }
        }
         
        //Calling Approval process when Status changes to Rejected
        for(Deal_Desk_ge_og__c objDealDesk:newListDealDesk)
        {
            if(objDealDesk.status_ge_og__c == 'Rejected' && mapOldDealDesk.get(objDealDesk.Id).status_ge_og__c != 'Rejected')
            {
                DealDeskApprover_GE_OG objDealDeskApprover = new DealDeskApprover_GE_OG();
                objDealDeskApprover.RejectRecord(objDealDesk);
                break;
            }
        }
       
    }
    
}