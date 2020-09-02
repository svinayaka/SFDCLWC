/*
Class/Trigger Name     : ValidateOpportunityLineItem
Used Where ?           : OpportunityProductTrigger_GE_OG
Purpose/Overview       : validate Opportunity Product.
Scrum Team             : Transformation - OPPTY MGMT
Requirement/Bug Number :             : 
Author                 : Mohit Maheshwari
Created Date           : 08/Nov/2015
Test Class Name        : 
Code Coverage          : 
*/
public without sharing class ValidateOpportunityLineItem_GE_OG{
    public void validateOpportunityLineItemTier(List<OpportunityLineItem> opptyProductList){
        //Initializing Variable
        Set<id> opptyid = new Set<ID>();
        Map<ID,String> mapTier2 = new Map<ID,String>();
        
        // logic to validate same Tier 2 for Opportunity Products
        for(OpportunityLineItem objOLI : opptyProductList){
            system.debug('\n\n Oppty Product Tier 2 '+objOLI.GE_PTier2_PL__c+'\n\n');
            system.debug('\n\n Oppty Product Oppty ID '+objOLI.OpportunityID+'\n\n');
            if(opptyid.contains(objOLI.OpportunityID)){
                if(mapTier2!=null && mapTier2.size()>0 && mapTier2.get(objOLI.OpportunityID)!=objOLI.GE_PTier2_PL__c){
                    objOLI.addError('Please select Product with same Tier 2 values.' );
                }
            }
            else if(!opptyid.contains(objOLI.OpportunityId)){
                if(String.isBlank(objOLI.GE_PTier2_PL__c))
                    objOLI.addError('Please select a valid product with tier 2 value.' );
                else{    
                    opptyid.add(objOLI.OpportunityID);
                    mapTier2.put(objOLI.OpportunityID,objOLI.GE_PTier2_PL__c);
                }                      
            }
        }
    }
}