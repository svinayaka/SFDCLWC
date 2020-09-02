/*
Class/Trigger Name     : Opportunity_Stage_Won_Lost_Nego_GE_OG
Used Where ?           : Opportunity_Stages_Automation_GE_OG trigger
Purpose/Overview       : Used for updating the "Stages" of the opportunity "Cancelled, Negotiating, Closed Won/Lost" records when opportunites updates 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23405
Author                 : Mohit Maheshwari
Created Date           : 29-October-2015
Test Class Name        : OpportunityStagesAutomation_GE_OG_Test
Code Coverage          : 
*/
public without sharing class Opportunity_Stage_Won_Lost_Nego_GE_OG{
   Id userId = UserInfo.getUserId();
   // User u = [Select Id,Disable_validations_for_MERGE__c from User where Id =:userId ];*/
    User u = UserUtil.getUser(userId);
   
    public void checkedCancelled(List<Opportunity> newOppList, Map<Id,Opportunity> oldOppMap,Map<String,Boolean> mapOppPrimaryReason){
         System.debug('User U in line no 18 >> '+u);
        if(newOppList.Size()>0){
            // Iterate Over updated Opportunities and assign stage based on criteria mentioned in R-23549
            for(Opportunity objOpportunity: newOppList){
                String strCustomStage = objOpportunity.stage_ge_og__c;
                String prvStage = oldOppMap.get(objOpportunity.Id).stage_ge_og__c;
                System.debug('---------Opportunity_Stage_Won_Lost_Nego_GE_OG.checkedCancelled------Earlier stage before updating='+prvStage);
                String stage_primary_reason = '';
                if(!String.IsBlank(strCustomStage)){
                    stage_primary_reason = strCustomStage + '-' + (String.isBlank(objOpportunity.primary_reason_code_ge_og__c)?'':objOpportunity.primary_reason_code_ge_og__c);
                    stage_primary_reason = stage_primary_reason.ToUpperCase();
                }
                
                if(strCustomStage==System.Label.Cancelled){
                    if(String.isBlank(objOpportunity.primary_reason_code_ge_og__c) || (!String.isBlank(objOpportunity.primary_reason_code_ge_og__c) && mapOppPrimaryReason!=null && mapOppPrimaryReason.size()>0 && (!mapOppPrimaryReason.containsKey(stage_primary_reason) || (mapOppPrimaryReason.get(stage_primary_reason) && String.isBlank(objOpportunity.primary_sub_reason_code_ge_og__c))))){
                        objOpportunity.addError(System.Label.Cancelled_Error_Message);
                    }
                    else{
                        objOpportunity.StageName = System.Label.Cancelled;                        objOpportunity.stage_ge_og__c = System.Label.Cancelled;
                    }
                }
                else if(strCustomStage == System.Label.Closed_Lost){
                    if(!u.Disable_validations_for_MERGE__c){ 
                        if(strCustomStage == System.Label.Closed_Lost && (String.isBlank(objOpportunity.primary_reason_code_ge_og__c) || ((!String.isBlank(objOpportunity.primary_reason_code_ge_og__c) && mapOppPrimaryReason!=null && mapOppPrimaryReason.size()>0 && (!mapOppPrimaryReason.containsKey(stage_primary_reason) || (mapOppPrimaryReason.get(stage_primary_reason) && String.isBlank(objOpportunity.primary_sub_reason_code_ge_og__c))))))){
                            objOpportunity.addError('To move the stage to \'Closed Lost\', Primary Reason Code and respected Primary Sub Reason Code should be populated.');
                        }
                        else if(prvStage!=strCustomStage && strCustomStage == System.Label.Closed_Lost && (objOpportunity.competitor_required_ge_og__c && !objOpportunity.competitor_ge_og__c) ){
                            //objOpportunity.addError('Competitor is required when the risk path = “Deal Desk” and Opportunity is Closed Lost');
                            objOpportunity.addError(System.Label.Competitor_Required_Closed_Lost_Error_Message);
                            system.debug('\n\n Stage Error Closed Lost === \n\n');
                        }
                        else if(strCustomStage == System.Label.Closed_Lost && (!objOpportunity.competitor_required_ge_og__c || (objOpportunity.competitor_required_ge_og__c && objOpportunity.competitor_ge_og__c)) && !String.isBlank(objOpportunity.primary_reason_code_ge_og__c) && ((!String.isBlank(objOpportunity.primary_reason_code_ge_og__c) && mapOppPrimaryReason!=null && mapOppPrimaryReason.size()>0 && mapOppPrimaryReason.containsKey(stage_primary_reason) && mapOppPrimaryReason.get(stage_primary_reason) && !String.isBlank(objOpportunity.primary_sub_reason_code_ge_og__c))|| String.isBlank(objOpportunity.primary_sub_reason_code_ge_og__c))){
                            objOpportunity.StageName = System.Label.Closed_Lost;       objOpportunity.stage_ge_og__c = System.Label.Closed_Lost;
                        }
                        
                    }
                }
                if(objOpportunity.StageName!= System.Label.Closed_Lost && objOpportunity.StageName!= System.Label.Cancelled && objOpportunity.stage_ge_og__c != System.Label.Closed_Won && objOpportunity.StageName != objOpportunity.stage_ge_og__c)
                    setCustomStageValue(objOpportunity,'');        
            }
            
        }   
    }   
    
    public void checkClosed_Won_Lost_Negotiating(Map<ID,Opportunity> mapOpportunity, Map<Id,Opportunity> oldOppMap,Map<String,Boolean> mapOppPrimaryReason){
        if(!mapOpportunity.isEmpty()){
            // Iterate Over updated Opportunities and assign stage based on criteria mentioned in R-23549
            for(Opportunity objOpportunity: mapOpportunity.values()){
                String strCustomStage = objOpportunity.stage_ge_og__c;
                String prvStage = oldOppMap.get(objOpportunity.Id).stage_ge_og__c;
                String stage_primary_reason = '';
                if(!String.IsBlank(strCustomStage)){
                    stage_primary_reason = strCustomStage + '-' + (String.isBlank(objOpportunity.primary_reason_code_ge_og__c)?'':objOpportunity.primary_reason_code_ge_og__c);
                    stage_primary_reason = stage_primary_reason.ToUpperCase();
                }
                system.debug('===checkClosed_Won_Lost_Negotiating: Validate Stage '+objOpportunity.StageName+' strCustomStage:'+strCustomStage);
                if(objOpportunity.StageName == System.Label.Bid_In_Submission){           
                    
                    if(objOpportunity.StageName == System.Label.Bid_In_Submission && objOpportunity.bid_sent_date_ge_og__c!=null){
                        objOpportunity.StageName = System.Label.Negotiating;
                    }
                    if(!u.Disable_validations_for_MERGE__c && strCustomStage == System.Label.Closed_Won && objOpportunity.StageName == System.Label.Negotiating && (String.isBlank(objOpportunity.primary_reason_code_ge_og__c) || ((!String.isBlank(objOpportunity.primary_reason_code_ge_og__c) && mapOppPrimaryReason!=null && mapOppPrimaryReason.size()>0  && (!mapOppPrimaryReason.containsKey(stage_primary_reason) || (mapOppPrimaryReason.get(stage_primary_reason) && String.isBlank(objOpportunity.primary_sub_reason_code_ge_og__c))))))){
                        objOpportunity.addError('To move the stage to \'Closed Won\', Primary Reason Code and respected Primary Sub Reason Code should be populated.');
                    }
                    else if(!u.Disable_validations_for_MERGE__c && prvStage!=strCustomStage && strCustomStage == System.Label.Closed_Won && (objOpportunity.competitor_required_ge_og__c && !objOpportunity.competitor_ge_og__c) ){
                        objOpportunity.addError(System.Label.Competitor_Required_Closed_Won_Error_Message);
                        system.debug('\n\n Stage Error Closed Won === \n\n');
                    }
                    else if(strCustomStage == System.Label.Closed_Won && (!objOpportunity.competitor_required_ge_og__c || (objOpportunity.competitor_required_ge_og__c && objOpportunity.competitor_ge_og__c)) && objOpportunity.StageName == System.Label.Negotiating && !String.isBlank(objOpportunity.primary_reason_code_ge_og__c) && ((!String.isBlank(objOpportunity.primary_reason_code_ge_og__c) && mapOppPrimaryReason!=null && mapOppPrimaryReason.size()>0 && mapOppPrimaryReason.containsKey(stage_primary_reason) && mapOppPrimaryReason.get(stage_primary_reason) && !String.isBlank(objOpportunity.primary_sub_reason_code_ge_og__c))|| String.isBlank(objOpportunity.primary_sub_reason_code_ge_og__c)) && objOpportunity.Has_Revenue_Forecast_ge_og__c){
                        objOpportunity.StageName = System.Label.Closed_Won;                        objOpportunity.stage_ge_og__c = System.Label.Closed_Won;
                        system.debug('\n\n Stage Closed === \n\n');
                    }
                    
                    
                }
                if(objOpportunity.StageName!= System.Label.Closed_Lost && objOpportunity.StageName!= System.Label.Closed_Won && objOpportunity.StageName!= System.Label.Cancelled)
                    setCustomStageValue(objOpportunity,'');
            }
        }
    }
    
    public void setCustomStageValue(Opportunity objOpportunity, String customStage){
        objOpportunity.stage_ge_og__c = customStage;
        objOpportunity.primary_reason_code_ge_og__c = '';
        objOpportunity.primary_sub_reason_code_ge_og__c = '';
    }
}