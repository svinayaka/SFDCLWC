/*
Class/Trigger Name     : DealDeskController_GE_OG
Used Where ?           : OpportunityTriggerHandler_GE_OG, DealDeskTriggerHandler_GE_OG
Purpose/Overview       : This class will have all the method for functionality on Deal Desk
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23405
Author                 : Nitish Pandey
Created Date           : 09/OCT/2015
Test Class Name        : 
Code Coverage          : 
*/
public without sharing class DealDeskController_GE_OG
{
       
    //method for checking if there are more than 1 Active deal desk for any Oppty
    public void checkActiveDealDesk(List<Deal_Desk_ge_og__c> newListDealDesk, Map<id,Deal_Desk_ge_og__c> oldMapDealDesk,List<aggregateResult> aggrResults){
        
        Map<string,integer> opptyDealCountMap = new Map<string,integer>(); // Map will store Active Deal desk Count against each Oppty
        
        //Putting Value in Map                            
        for (AggregateResult ar : aggrResults){
            opptyDealCountMap.put(string.valueOf(ar.get('oppty')),integer.valueOf(ar.get('totalDealDesk')));
        }
        
        //Checks if there are more than one active record, and adding error in already have an Active Deal Desk
        for(Deal_Desk_ge_og__c dd:newListDealDesk){
            
            if(trigger.isInsert && opptyDealCountMap.get(dd.deal_desk_opportunity_id_ge_og__c)>0){
                
                dd.addError('This Opportunity already has an Active Deal Desk.');
                }
                
            else if(trigger.isUpdate){
                // Error will generate if try to activate another Deal Desk on same oppty
                if(opptyDealCountMap.get(dd.deal_desk_opportunity_id_ge_og__c)==0 && dd.active_deal_desk_ge_og__c && dd.active_deal_desk_ge_og__c!= (oldMapDealDesk.get(dd.id)).active_deal_desk_ge_og__c)
                    dd.addError('This Opportunity already has an Active Deal Desk.');
                // Error will occur if try to deactivate only active Deal Desk
                system.debug('kkkkkkkkkkkkkkkkk '+dd.deal_desk_opportunity_id_ge_og__c+'   '+opptyDealCountMap.get(dd.deal_desk_opportunity_id_ge_og__c));
                if(opptyDealCountMap.get(dd.deal_desk_opportunity_id_ge_og__c)==null && !dd.active_deal_desk_ge_og__c && dd.status_ge_og__c!='Approved' && dd.active_deal_desk_ge_og__c!= (oldMapDealDesk.get(dd.id)).active_deal_desk_ge_og__c)
                    dd.addError('This is only Active Deal Desk. You can not make it inactive');
            }
            
        }
    }
    
    /*
    public void updateDealDeskratingOppty(List<Opportunity> newOppList, Map<String,Integer> opportunityProductCount, Map<Id,Opportunity> oldOppMap,Map<Id,Deal_Desk_ge_og__c> opptyDealMap){
        
        System.debug('\n\n\n\n Entered in Update Deal Desk Rating');
        
        //Initialise variables
        List<Deal_Desk_ge_og__c> updateDDList = new List<Deal_Desk_ge_og__c>();
        string customSettingKey;
        
        // For Loop on Opportunity
        for(Opportunity oppty: newOppList){
            
            //Fetching Deal Desk for this Opportunity
            Deal_Desk_ge_og__c dds = opptyDealMap.get(oppty.id);
            //Checks for Stage, Products and Install Country
            if(dds!=null){
                //For Qualifying Stage, Consider Only Amount
                If(oppty.StageName == 'Qualifying' && opportunityProductCount.get(oppty.Id)>0 && oppty.install_country_ge_og__c!=Null){
                    if(oppty.amount_level_ge_og__c!=null && oppty.amount_level_ge_og__c != (oldOppMap.get(oppty.id)).amount_level_ge_og__c ){
                        customSettingKey = '0' + oppty.amount_level_ge_og__c +'TRUE' ;
                        
                    }
                }
                //For 'Bid In Development' Stage, Consider Amount and Max deviation
                if(oppty.StageName == 'Bid In Development' && oppty.all_risk_checklist_reviewed_ge_og__c){
                    // If risk Checklist Reviewed, Consider only Deviation Level Also
                    if(oppty.amount_level_ge_og__c!=null && oppty.max_deviation_ge_og__c!=null ){
                        customSettingKey = String.valueOf(oppty.max_deviation_ge_og__c) + String.valueOf(oppty.amount_level_ge_og__c) +'TRUE' ;
                    }
                    
                }
                
                if(customSettingKey != null && customSettingKey !=''){
                    //getting value record from Deal Desk Matrix
                    //fetching Deal desk number and then assigning to DD# on Opportunity
                    Deal_Desk_Matrix__c ddm = Deal_Desk_Matrix__c.getValues(customSettingKey);
                    if(ddm!=Null){
                        
                        //Setting DD# on Deal desk, which will be updated on Oppty by workflow
                        dds.dd_ge_og__c = ddm.Deal_Desk_Number__c;
                        system.debug('gggggggggggggggggg'+ customSettingKey +'   '+ddm.Deal_Desk_Number__c);
                        updateDDList.add(dds);
                    }
                }
            }
            
        }
        //Updating Deal Desk List
        update updateDDList;
    
    }
    */
    /*
    public void updateRejectedBy(List<Deal_Desk_ge_og__c> newListDealDesk, Map<Id,Deal_Desk_ge_og__c> mapOldDealDesk){
        List<Deal_Desk_ge_og__c> updateDDList = new list<Deal_Desk_ge_og__c>();
        
        for(Deal_Desk_ge_og__c dd : newListDealDesk){
            if((dd.status_ge_og__c == 'Rejected' || dd.status_ge_og__c == 'Approved') && dd.status_ge_og__c != mapOldDealDesk.get(dd.id).status_ge_og__c){
                dd.approved_rejected_by_ge_og__c = dd.LastModifiedById;
                updateDDList.add(dd);
            }
        }
       
        update updateDDList;
    }
    */
}