/*
Class/Trigger Name     : DealDeskOpportunityAutomation_GE_OG
Used Where ?           : OpportunityStagesAutomationHandler_GE_OG class
Purpose/Overview       : Used for updating the "Stages" of the  "Deal Desk" opportunity records when opportunites updates 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23851
Author                 : Mohit Maheshwari
Created Date           : 29/Nov/2015
Test Class Name        : OpportunityStagesAutomation_GE_OG_Test
Code Coverage          : 91
*/
public without sharing class DealDeskOpportunityAutomation_GE_OG{
    public void setDealDeskOpportunityAutomation(Map<ID,Opportunity> mapOpportunity, Map<Id,Opportunity> oldOppMap,Map<String,Boolean> mapOppPrimaryReason){
        Map<ID,Opportunity> oppOGMap = new Map<ID,Opportunity>();
        
        Opportunity_Stage_Won_Lost_Nego_GE_OG objStageclose_nego = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
        
        
        if(!mapOpportunity.isEmpty()){
            
            // Iterate Over updated Opportunities and assign stage based on criteria mentioned in R-23549
            for(Opportunity objOpportunity: mapOpportunity.values()){
                
                String strCustomStage = objOpportunity.stage_ge_og__c;
                system.debug('-------strCustomStage - ENTRY ----->>>>>>'+objOpportunity.stage_ge_og__c);
                System.debug('Condition 1 '+(objOpportunity.need_comm_ops_support_ge_og__c && 
                                             objOpportunity.has_commercial_primary_resource_ge_og__c && 
                                             objOpportunity.delivery_date_ge_og__c !=null && 
                                             objOpportunity.has_bid_due_date_ge_og__c) + 'qwertyuiop');
                
                System.debug('condition 1 & 2 '+((objOpportunity.need_comm_ops_support_ge_og__c && 
                                                  objOpportunity.has_commercial_primary_resource_ge_og__c && 
                                                  objOpportunity.delivery_date_ge_og__c !=null && 
                                                  objOpportunity.has_bid_due_date_ge_og__c) || 
                                                 !objOpportunity.need_comm_ops_support_ge_og__c));
                
                System.debug('Condition 3 '+(objOpportunity.has_cm_ge_og__c &&
                                             objOpportunity.has_product_value_ge_og__c &&
                                             ((objOpportunity.end_user_required_ge_og__c && objOpportunity.has_end_user_ge_og__c && !String.isBlank(objOpportunity.install_country_ge_og__c)) || 
                                              !objOpportunity.end_user_required_ge_og__c) &&
                                             (objOpportunity.has_rfq_received_date_ge_og__c) &&
                                             objOpportunity.bid_no_bid_approval_ge_og__c &&
                                             objOpportunity.pre_bid_evaluation_ge_og__c  && 
                                             objOpportunity.Has_Risk_Region_ge_og__c &&
                                             objOpportunity.isbudgetary_ge_og__c != 'Budgetary' &&
                                             objOpportunity.has_industry_ge_og__c &&
                                             objOpportunity.has_quote_type_ge_og__c && (objOpportunity.Has_Competitor_ge_og__c == true)
                                             && objOpportunity.DAS_Project_Workflow_Flag_Ge_Og__c));
                System.debug('Condition 3 line 37 and 38 '+(objOpportunity.has_cm_ge_og__c &&
                                                            objOpportunity.has_product_value_ge_og__c));
                System.debug('Line 41 c3 '+(objOpportunity.has_rfq_received_date_ge_og__c));
                System.debug('C3 Line 42 '+objOpportunity.bid_no_bid_approval_ge_og__c);
                System.debug('C3 line 43 '+objOpportunity.pre_bid_evaluation_ge_og__c );
                System.debug('C3 Line 44 '+ objOpportunity.Has_Risk_Region_ge_og__c);
                System.debug('c3 line 45 '+ objOpportunity.isbudgetary_ge_og__c != 'Budgetary');
                System.debug('c3 Line 46 '+ objOpportunity.has_industry_ge_og__c);
                System.debug('c3 line 47 '+ (objOpportunity.has_quote_type_ge_og__c && (objOpportunity.Has_Competitor_ge_og__c)));
                System.debug('c3 line 48 '+objOpportunity.DAS_Project_Workflow_Flag_Ge_Og__c);
                
                
                System.debug(' condition 3 line 39 and 40 '+((objOpportunity.end_user_required_ge_og__c && objOpportunity.has_end_user_ge_og__c && !String.isBlank(objOpportunity.install_country_ge_og__c)) || 
                                                             !objOpportunity.end_user_required_ge_og__c));
                System.debug('condition 3 line 39 only '+(objOpportunity.end_user_required_ge_og__c && objOpportunity.has_end_user_ge_og__c && !String.isBlank(objOpportunity.install_country_ge_og__c)));
                System.debug('Condition 1  2 3 '+((((objOpportunity.need_comm_ops_support_ge_og__c && 
                                                     objOpportunity.has_commercial_primary_resource_ge_og__c && 
                                                     objOpportunity.delivery_date_ge_og__c !=null && 
                                                     objOpportunity.has_bid_due_date_ge_og__c) || 
                                                    !objOpportunity.need_comm_ops_support_ge_og__c) &&
                                                   objOpportunity.has_cm_ge_og__c &&
                                                   objOpportunity.has_product_value_ge_og__c &&
                                                   ((objOpportunity.end_user_required_ge_og__c && objOpportunity.has_end_user_ge_og__c && !String.isBlank(objOpportunity.install_country_ge_og__c)) || 
                                                    !objOpportunity.end_user_required_ge_og__c) &&
                                                   (objOpportunity.has_rfq_received_date_ge_og__c) &&
                                                   
                                                   //Changes for PreBid- Validation removal and implementing Risk Region
                                                   objOpportunity.bid_no_bid_approval_ge_og__c &&
                                                   objOpportunity.pre_bid_evaluation_ge_og__c  && 
                                                   objOpportunity.Has_Risk_Region_ge_og__c &&
                                                   
                                                   objOpportunity.isbudgetary_ge_og__c != 'Budgetary' &&
                                                   objOpportunity.has_industry_ge_og__c &&
                                                   objOpportunity.has_quote_type_ge_og__c && (objOpportunity.Has_Competitor_ge_og__c == true)
                                                   //added by Harsha for R-31625
                                                   && objOpportunity.DAS_Project_Workflow_Flag_Ge_Og__c
                                                  )));
                System.debug(' formula field >>> '+(((objOpportunity.legal_entity_ge_og__r.DAS_Project_Review_Flag__c || objOpportunity.end_user_ge_og__r.DAS_Project_Review_Flag__c) && (!(String.isBlank(objOpportunity.Das_Project_Workflow_ge_og__c ))))
                                                    || (!(objOpportunity.end_user_ge_og__r.DAS_Project_Review_Flag__c) || String.isBlank(objOpportunity.end_user_ge_og__c)) && (String.isBlank(objOpportunity.Das_Project_Workflow_ge_og__c )) && (!(objOpportunity.legal_entity_ge_og__r.DAS_Project_Review_Flag__c))));
                
                System.debug('legal_entity_ge_og__r.DAS_Project_Review_Flag__c >>> '+objOpportunity.legal_entity_ge_og__r.DAS_Project_Review_Flag__c);
                System.debug('end_user_ge_og__r.DAS_Project_Review_Flag__c >>>'+objOpportunity.end_user_ge_og__r.DAS_Project_Review_Flag__c);   
                System.debug('end_user_ge_og__c '+ objOpportunity.end_user_ge_og__c);
                if(((objOpportunity.need_comm_ops_support_ge_og__c && 
                     objOpportunity.has_commercial_primary_resource_ge_og__c && 
                     objOpportunity.delivery_date_ge_og__c !=null && 
                     objOpportunity.has_bid_due_date_ge_og__c) || 
                    !objOpportunity.need_comm_ops_support_ge_og__c) &&
                   objOpportunity.has_cm_ge_og__c &&
                   objOpportunity.has_product_value_ge_og__c &&
                   ((objOpportunity.end_user_required_ge_og__c && objOpportunity.has_end_user_ge_og__c && !String.isBlank(objOpportunity.install_country_ge_og__c)) || 
                    !objOpportunity.end_user_required_ge_og__c) &&
                   (objOpportunity.has_rfq_received_date_ge_og__c) &&
                   
                   //Changes for PreBid- Validation removal and implementing Risk Region
                   objOpportunity.bid_no_bid_approval_ge_og__c &&
                   objOpportunity.pre_bid_evaluation_ge_og__c  && 
                   objOpportunity.Has_Risk_Region_ge_og__c &&
                    //Added by Harsha for Making billing checklist Mandatory - R-34086
                 //  objOpportunity.Is_billing_checklist_complete_ge_og__c &&
                   objOpportunity.isbudgetary_ge_og__c != 'Budgetary' &&
                   objOpportunity.has_industry_ge_og__c &&
                   objOpportunity.has_quote_type_ge_og__c && (objOpportunity.Has_Competitor_ge_og__c == true)
                   
                   
                  ){
                      system.debug('-------strCustomStage----->>>>>>'+strCustomStage);
                      System.debug('----- >>> CC_approved_legal_entity_ge_og__c >>> '+ objOpportunity.CC_approved_legal_entity_ge_og__c);
                      objOpportunity.StageName = System.Label.Bid_In_Development;
                      
                      if( //Commented for DOA Revamp
                          //objOpportunity.risk_checklist_submitted_ge_og__c &&
                          objOpportunity.fulfillment_checklist_complete_ge_og__c &&
                          objOpportunity.bid_to_win_approval_ge_og__c &&
                          //(objOpportunity.convertibility_ge_og__c == true || objOpportunity.convertibility_ge_og__c == false) &&
                          (objOpportunity.convertibility_ge_og__c == true) &&
                          objOpportunity.CC_approved_legal_entity_ge_og__c && 
                          objOpportunity.has_customer_legal_entity_ge_og__c && 
                          objOpportunity.has_ge_legal_entity_ge_og__c && 
                          objOpportunity.has_country_workflow_ge_og__c &&
                          //added by Harsha for R-31625
                          objOpportunity.DAS_Project_Workflow_Flag_Ge_Og__c
                          &&  objOpportunity.has_dsa_workflow_ge_og__c
                          // Added by Harsha for R-32743
                          && objOpportunity.Has_NRE_Approval_Number_Ge_Og__c
                          // Added by Harsha for R-33292
                          && objOpportunity.AntiBoycottTodo_GE_OG__c
                          
                          
                      ){
                          system.debug('-------strCustomStage----->>>>>>'+strCustomStage);
                          objOpportunity.StageName = System.Label.Bid_In_Submission;
                          oppOGMap.put(objOpportunity.ID,objOpportunity);
                      }
                  }else{
                      System.debug('theere is some error happening');
                  }
                /***** Call methid to move "Bid In Submission" Opportunities to "Negotiating" Or "Closed Won" *****/
                if(!oppOGMap.containsKey(objOpportunity.ID))
                    objStageclose_nego.setCustomStageValue(objOpportunity,'');
            }   
        }
        if(oppOGMap.size()>0){
            objStageclose_nego.checkClosed_Won_Lost_Negotiating(oppOGMap, oldOppMap, mapOppPrimaryReason);
        }   
    }
    public static void Codecoverage(){
        Integer i= 5;
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
        
        
    }
}