/*
Class/Trigger Name     : OpportunityStagesAutomationHandler_GE_OG
Used Where ?           : Opportunity_Stages_Automation_GE_OG trigger
Purpose/Overview       : Used for updating the "Stages" of the opportunity records when opportunites updates 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23405
Author                 : Madhuri Sharma
Created Date           : 01/OCT/2015
Test Class Name        : OpportunityStagesAutomation_GE_OG_Test
Code Coverage          : 90%
*/
public without sharing class OpportunityStagesAutomationHandler_GE_OG
{
    public void updateOpportunityStage(List<Opportunity> newOppList,Map<Id,Opportunity> oldOppMap)
    {
        //Initialise variables
        Map<Id,Opportunity> oppOGMapDealDesk = new Map<Id,Opportunity>();
        Map<Id,Opportunity> oppOGMapExpress = new Map<Id,Opportunity>();
        Map<String,Boolean> mapOppPrimaryReason = new Map<String,Boolean>();
        
        List<Opportunity_Primary_Reason_Has_Code__c> lstOppPrimaryReason = Opportunity_Primary_Reason_Has_Code__c.getAll().values();
        for(Opportunity_Primary_Reason_Has_Code__c primaryreason : lstOppPrimaryReason){
            mapOppPrimaryReason.put(primaryreason.primary_reason_code_ge_og__c.ToUpperCase(),primaryreason.has_primary_sub_reason_code_ge_og__c);
        }
        
        //Get the RecordTypeId of O&G recordtype
        Id oppOGRecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','O&G').getRecordTypeId();
        
        Opportunity_Stage_Won_Lost_Nego_GE_OG objStageclose_nego = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
        objStageclose_nego.checkedCancelled(newOppList, oldOppMap, mapOppPrimaryReason);
        
        for(Opportunity opp: newOppList){
            
            if(opp.RecordTypeId == oppOGRecordTypeId){
                if(opp.need_comm_ops_support_ge_og__c && opp.delivery_date_ge_og__c == null)
                    opp.delivery_date_ge_og__c = opp.CloseDate;
                if(opp.stage_ge_og__c != System.Label.Cancelled && opp.stage_ge_og__c != System.Label.Closed_Lost){
                    if((opp.has_opportunitycontactrole_ge_og__c || (opp.type !=null && opp.type !='' && (opp.type).contains('Internal'))) && (opp.region_ge_og__c!=null && opp.region_ge_og__c!='') && opp.has_amount_ge_og__c){
                        opp.StageName = System.Label.Qualifying;
                        system.debug('\n\n Old Stage 1  '+oldOppMap.get(opp.Id).stage_ge_og__c +'  --- Custom Stage 2 --- '+opp.stage_ge_og__c);
                        if(opp.RecordTypeId == oppOGRecordTypeId && String.valueOf(opp.deal_path_ge_og__c) == 'Express'){
                            oppOGMapExpress.put(opp.Id,opp);
                        }
                        else if(opp.RecordTypeId == oppOGRecordTypeId && (String.valueOf(opp.deal_path_ge_og__c) == 'Deal Desk')){
                            oppOGMapDealDesk.put(opp.Id,opp);
                        }
                    }
                    else{
                        opp.stage_ge_og__c = '';
                        opp.primary_reason_code_ge_og__c = '';
                        opp.primary_sub_reason_code_ge_og__c = '';
                        opp.StageName = System.Label.Prospecting;
                    }           
                }   
            }
        }
        if(!oppOGMapDealDesk.isEmpty())
            updateOppStageForDealDesk(oppOGMapDealDesk,oldOppMap,mapOppPrimaryReason);
        
        if(!oppOGMapExpress.isEmpty())    
            updateOpportunityStageForExpress(oppOGMapExpress,oldOppMap,mapOppPrimaryReason);
        
    }
    
    
    // Method to update Opportunity stage for deal desk
    private void updateOppStageForDealDesk(Map<Id,Opportunity> oppOGMap, Map<Id,Opportunity> oldOppMap,Map<String,Boolean> mapOppPrimaryReason)
    {
       if(!oppOGMap.isEmpty()){
            DealDeskOpportunityAutomation_GE_OG objDealOpportunity = new DealDeskOpportunityAutomation_GE_OG();
            objDealOpportunity.setDealDeskOpportunityAutomation(oppOGMap, oldOppMap, mapOppPrimaryReason);
        }
    
    }
    
    // Method to assign stage to Opportunity for express
    public void updateOpportunityStageForExpress(Map<ID,Opportunity> oppOGMap, Map<Id,Opportunity> oldOppMap,Map<String,Boolean> mapOppPrimaryReason){
        if(!oppOGMap.isEmpty()){
            ExpressOpportunityAutomation_GE_OG objExpOpportunity = new ExpressOpportunityAutomation_GE_OG();
            objExpOpportunity.setExpressOpportunityAutomation(oppOGMap, oldOppMap, mapOppPrimaryReason);
        }
    }
    /*
   public void updateDealDeskratingOppty(List<Opportunity> newOppList, Map<String,Integer> opportunityProductCount, Map<Id,Deal_Desk_ge_og__c> opptyDealMap){
        
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
                If(oppty.StageName == 'Qualifying' && opportunityProductCount.get(oppty.Id)>0){
                        customSettingKey = '0' + oppty.amount_level_ge_og__c +'TRUE' ;
                }
                //For 'Bid In Development' Stage, Consider Amount and Max deviation
                if(oppty.StageName == 'Bid In Development' && oppty.all_risk_checklist_reviewed_ge_og__c){
                    // If risk Checklist Reviewed, Consider only Deviation Level Also
                    
                    if(oppty.amount_level_ge_og__c!=null && oppty.opportunity_max_deviation_ge_og__c!=null ){
                        customSettingKey = String.valueOf(oppty.opportunity_max_deviation_ge_og__c) + String.valueOf(oppty.amount_level_ge_og__c) +'TRUE' ;
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
        if(!trigger.isInsert && !trigger.isBefore)
            update updateDDList;
    
    }
    */
}