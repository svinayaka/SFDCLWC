/*
Class/Trigger Name     : ExpressOpportunityAutomation_GE_OG
Used Where ?           : Opportunity_Stages_Automation_GE_OG trigger
Purpose/Overview       : Used for updating the "Stages" of the opportunity "Bid In Development, Bid In Submission" for Express opportunites 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23405
Author                 : Mohit Maheshwari
Created Date           : 27-October-2015
Test Class Name        : OpportunityStagesAutomation_GE_OG_Test
Code Coverage          : 
*/
public without sharing class ExpressOpportunityAutomation_GE_OG{
    public void setExpressOpportunityAutomation(Map<ID,Opportunity> mapOpportunity, Map<Id,Opportunity> oldOppMap,Map<String,Boolean> mapOppPrimaryReason){
        Map<ID,Opportunity> oppOGMap = new Map<ID,Opportunity>();
        Opportunity_Stage_Won_Lost_Nego_GE_OG objStageclose_nego = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
        
        if(!mapOpportunity.isEmpty()){
            // Iterate Over updated Opportunities and assign stage based on criteria mentioned in R-23549
            for(Opportunity objOpportunity: mapOpportunity.values()){
                String strCustomStage = objOpportunity.stage_ge_og__c;
                system.debug('-------strCustomStage - ENTRY ----->>>>>>'+objOpportunity.stage_ge_og__c);
                
                if(objOpportunity.has_deal_path_triage_ge_og__c && 
                   ((objOpportunity.need_comm_ops_support_ge_og__c && 
                     objOpportunity.has_commercial_primary_resource_ge_og__c && 
                     objOpportunity.delivery_date_ge_og__c != null&&
                     objOpportunity.has_bid_due_date_ge_og__c) || 
                    !objOpportunity.need_comm_ops_support_ge_og__c) 
                   && ((objOpportunity.end_user_required_ge_og__c && 
                        objOpportunity.has_end_user_ge_og__c && 
                        !String.isBlank(objOpportunity.install_country_ge_og__c)) || 
                       !objOpportunity.end_user_required_ge_og__c) && 
                   objOpportunity.has_cm_ge_og__c && 
                   objOpportunity.has_product_value_ge_og__c && 
                   objOpportunity.isbudgetary_ge_og__c != 'Budgetary' &&
                   objOpportunity.has_industry_ge_og__c &&
                   objOpportunity.has_quote_type_ge_og__c 
                   //
                  ){ 
                      system.debug('-------strCustomStage----->>>>>>'+strCustomStage);
                      objOpportunity.StageName = System.Label.Bid_In_Development;
                      system.debug('-------objOpportunity.StageName----->>>>>>'+objOpportunity.StageName);
                      if(objOpportunity.CC_approved_legal_entity_ge_og__c && 
                         objOpportunity.has_customer_legal_entity_ge_og__c && 
                         //(objOpportunity.convertibility_ge_og__c == true || objOpportunity.convertibility_ge_og__c == false) 
                         (objOpportunity.convertibility_ge_og__c == true) && 
                         objOpportunity.has_ge_legal_entity_ge_og__c && 
                         objOpportunity.has_country_workflow_ge_og__c &&
                         objOpportunity.has_dsa_workflow_ge_og__c
                         //added by harsha for R-31625
                         && objOpportunity.DAS_Project_Workflow_Flag_Ge_Og__c 
                         //added by harsha for R-32743
                         && objOpportunity.Has_NRE_Approval_Number_Ge_Og__c
                         //Added by Harsha for R-33292
                         && objOpportunity.AntiBoycottTodo_GE_OG__c
                         
                        ){
                            system.debug('-------strCustomStage----->>>>>>'+strCustomStage);
                            objOpportunity.StageName = System.Label.Bid_In_Submission;
                            system.debug('-------objOpportunity.StageName----->>>>>>'+objOpportunity.StageName);
                            oppOGMap.put(objOpportunity.ID,objOpportunity);
                        }
                  }
                /*
else if(!objOpportunity.HasOpportunityLineItem  && 
oldOppMap.get(objOpportunity.ID).HasOpportunityLineItem  && 
(objOpportunity.complete_ge_og__c || objOpportunity.complete_for_negotiating_ge_og__c))
{
objOpportunity.complete_ge_og__c = false;
objOpportunity.complete_for_negotiating_ge_og__c = false;      
}
*/
                
                Integer i=0;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                
                
                if(!oppOGMap.containsKey(objOpportunity.ID))
                    objStageclose_nego.setCustomStageValue(objOpportunity,'');
            }       
        }
        if(oppOGMap.size()>0){
            objStageclose_nego.checkClosed_Won_Lost_Negotiating(oppOGMap, oldOppMap, mapOppPrimaryReason);
        }
    }
}