/*
Type Name [Class/Trigger/Page Name] : Apex Trigger
Used Where ?                        : Used in Recommendation Approver object
Purpose/Overview                    : This trigger is used to update the finalTier and final tier selections fields.
                                      Final Tier field will be updated with the last selected tier value. For Example, we have tier fields in 6 level.
                                      If user fills till tier 4 then tier 4 value will be updated on this final tier field.                      
                                      And all the Tier values selected by the user will be concatenated with one another and
                                      will be updated in final tier selections field.
Functional Area                     : PRM (I release -> R-7552 and R-7553)
Author                              : Elavarasan Nagarathinam
Created Date                        : 15 March 2012
Test Class Name                     : 

Change History -
Date Modified   : Developer Name    : Method/Section Modified/Added     : Purpose/Overview of Change
*/

trigger GE_PRM_updateTierSelection on GE_PRM_Recommendation_Approvers__c (before insert, before update) {
    
    // Below block will be executed on on before events
    if(Trigger.isBefore){

        
            for(GE_PRM_Recommendation_Approvers__c recommendationApprovers : Trigger.New){
                               
                // String variables declaration and initialisation
                String strFinalTierSelections = '';
                String strFinalTier = '';
                
                if(recommendationApprovers.GE_PRM_Country__c != null){
                //Update the string values if Tier 1 is not null
                if(recommendationApprovers.GE_PRM_Tier_1_New__c != null){
                    strFinalTierSelections = strFinalTierSelections + recommendationApprovers.GE_PRM_Tier_1_New__c + ' - ';
                    strFinalTier = recommendationApprovers.GE_PRM_Tier_1_New__c;
                }
                
                //Update the string values if Tier 2 is not null
                if(recommendationApprovers.GE_PRM_Tier_2__c != null){
                    strFinalTierSelections = strFinalTierSelections + recommendationApprovers.GE_PRM_Tier_2__c + ' - ';
                    strFinalTier = recommendationApprovers.GE_PRM_Tier_2__c;
                }   

                //Update the string values if Tier 3 is not null
                if(recommendationApprovers.GE_PRM_Tier_3__c != null){
                    strFinalTierSelections = strFinalTierSelections + recommendationApprovers.GE_PRM_Tier_3__c + ' - ';
                    strFinalTier = recommendationApprovers.GE_PRM_Tier_3__c;
                }    
                
                //Update the string values if Tier 4 is not null
                if(recommendationApprovers.GE_PRM_Tier_4__c != null){
                    strFinalTierSelections = strFinalTierSelections + recommendationApprovers.GE_PRM_Tier_4__c + ' - ';
                    strFinalTier = recommendationApprovers.GE_PRM_Tier_4__c;
                } 
                    
                //Update the string values if Tier 5 is not null
               /* if(recommendationApprovers.GE_PRM_Tier_5__c != null){
                    strFinalTierSelections = strFinalTierSelections + recommendationApprovers.GE_PRM_Tier_5__c + ' - ';
                    strFinalTier = recommendationApprovers.GE_PRM_Tier_5__c;
                }
                
                else {
                    strFinalTierSelections = strFinalTierSelections + 'T5' + ' - ';                    
                }*/
                    
                //Update the string values if Tier 6 is not null
               /* if(recommendationApprovers.GE_PRM_Tier_6__c != null){
                    strFinalTierSelections = strFinalTierSelections + recommendationApprovers.GE_PRM_Tier_6__c;                                                            
                    strFinalTier = recommendationApprovers.GE_PRM_Tier_6__c;
                }                
                else {
                    strFinalTierSelections = strFinalTierSelections + 'T6' + ' - ';                      
                }*/
                
                if(recommendationApprovers.GE_PRM_Role__c != null) {
                    strFinalTierSelections = strFinalTierSelections + recommendationApprovers.GE_PRM_Role__c + ' - ';
                }              
                if(recommendationApprovers.GE_PRM_Country__c != null) {
                    strFinalTierSelections = strFinalTierSelections + recommendationApprovers.GE_PRM_Country__c+ ' - ';
                }
                
                if(recommendationApprovers.GE_PRM_Region__c != null) {
                    strFinalTierSelections = strFinalTierSelections + recommendationApprovers.GE_PRM_Region__c;
                } 
                 system.debug('Recommondation strFinalTierSelections'+strFinalTierSelections);
                
                //Update the GE_PRM_Final_Tier_Selections__c field with the concatenated string value
                if(strFinalTierSelections != null && strFinalTierSelections != '')
                {
                    recommendationApprovers.GE_PRM_Final_Tier_Selections__c =  strFinalTierSelections;  
                    //recommendationApprovers.GE_HQ_SFDC_LEGACY_ID__c =  strFinalTierSelections;
                }    
                    
                //Update the GE_PRM_Final_P_L__c field with the deep level tier selected
                if(strFinalTier != null && strFinalTier != '')                    
                    recommendationApprovers.GE_PRM_P_L__c =  strFinalTier;   
             }                                        

        }
    }
}