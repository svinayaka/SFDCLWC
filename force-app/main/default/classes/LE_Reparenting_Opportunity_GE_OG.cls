/*
Class Name			: LE_Reparenting_Opportunity_GE_OG
Used Where ? 		: Used for Mass cancel Opportunities Automation.
Purpose/Overview	: Automates the manual process of cancelling the opportunities.
Author				: Harsha C
Created Date		: 05/AUG/2019
Requirement			: R-32605
Test Class Name		: LE_Reparenting_Opportunity_GE_OG_Test
Code Coverage  		:
*/
public class LE_Reparenting_Opportunity_GE_OG {
    public static List<Sobject> reParentLEforoppty(List<Opportunity> opportunityList,Account newParent){
        
        List<SObject> lstReturn = new List<Sobject>();
        for(Opportunity opp: opportunityList){
            if(opp.Account.Account_Tier_GEOG__c == 'Country'){                 opp.AccountId = newParent.Id;
            }
            if(opp.Account.Account_Tier_GEOG__c == 'Regional'){                if(newParent.ParentId != null){                    opp.AccountId = newParent.ParentId;                  }else{                     opp.AccountId = newParent.Id; 
                                                                                                                                                                                            }
                                                               
                                                              }
            if(opp.Account.Account_Tier_GEOG__c == 'Global'){                 if(newParent.Member_of_GE_OG__c != null){                    opp.AccountId = newParent.Member_of_GE_OG__c;                 }else if(newParent.ParentId != null && newParent.Member_of_GE_OG__c == null){                    opp.AccountId = newParent.ParentId;                  }else if(newParent.Member_of_GE_OG__c == null && newParent.ParentId == null ){                     opp.AccountId = newParent.Id;
                    
                }
            }
            if(newParent.Type == 'Internal'){                opp.Type = 'Internal to Company';
            }else{
                opp.Type = 'External'; 
            }
        }
        lstReturn.addAll(opportunityList);
        return lstReturn;
    }
}