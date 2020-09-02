/*
Class/Trigger Name     : OLIMulitiTierHandler_GE_OG
Used Where ?           : OpportunityProductTrigger_GE_OG
Purpose/Overview       : Helper Class for Trigger on OpportunityLineItem
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-26476
Author                 : Rupal Seth
Created Date           : 18/JAN/2018
Test Class Name        : CQAChecklistController_GE_OG_Test
Code Coverage          : 91%
*/

public class OLIMulitiTierHandler_GE_OG {

    public void afterDeleteHandler(List<OpportunityLineItem> deletedOppItemList){

Set<Id> parentOppIdSet = new Set<Id>();
Set<Id> workingOppIdmismatchSet = new Set<Id>();
Set<Id> workingOppIdmatchSet = new Set<Id>();
List<Opportunity> updateOpportunityList = new List<Opportunity>();

for(OpportunityLineItem oppLineItem: deletedOppItemList){
    system.debug('Inside deletedOppItemList'+deletedOppItemList);
      parentOppIdSet.add(oppLineItem.opportunityId);
    system.debug('Inside deletedOppItemList after adding to set'+parentOppIdSet);
}

for(OpportunityLineItem oppLineItem: [ Select Id,opportunityId,opportunity.tier_3_ge_og__c,GE_PTier3_PL__c,opportunity.MultiTier3_ge_og__c,opportunity.hasOpportunityLineItem from OpportunityLineItem Where opportunityId In:parentOppIdSet]){
    system.debug('After query for oppLineItem'+oppLineItem);
    System.debug('opportunity.tier_3_ge_og__c' +opportunity.tier_3_ge_og__c);
    system.debug('oppLineItem.GE_PTier3_PL__c'+oppLineItem.GE_PTier3_PL__c);
    system.debug('oppLineItem.Id' +oppLineItem.opportunity.hasOpportunityLineItem);
    if((oppLineItem.opportunity.tier_3_ge_og__c!=oppLineItem.GE_PTier3_PL__c) && oppLineItem.opportunity.hasOpportunityLineItem){
                   system.debug('Inside multitier mismatch loop');
                  workingOppIdmismatchSet.add(oppLineItem.opportunityId);
    }
    else if (oppLineItem.opportunity.tier_3_ge_og__c == oppLineItem.GE_PTier3_PL__c || oppLineItem.opportunity.hasOpportunityLineItem){
        system.debug('Inside multitier match loop');
                  workingOppIdmatchSet.add(oppLineItem.opportunityId);
    }
}

if(!workingOppIdmismatchSet.isEmpty()){
    system.debug('Inside workingOppIdSet not empty loop');
   for(Opportunity opp:[Select Id,tier_3_ge_og__c,MultiTier3_ge_og__c From Opportunity Where Id In:workingOppIdmismatchSet]){
       system.debug('opp.MultiTier3_ge_og__c'+opp.MultiTier3_ge_og__c);
       opp.MultiTier3_ge_og__c = true;
       updateOpportunityList.add(opp);
   }

   if(!updateOpportunityList.isEmpty())
       system.debug('Inside updateOpportunityList not empty loop');
      Database.update(updateOpportunityList,false);
}
else if(!workingOppIdmatchSet.isEmpty()){
    system.debug('Inside workingOppIdSet not empty loop');
   for(Opportunity opp:[Select Id,tier_3_ge_og__c,MultiTier3_ge_og__c From Opportunity Where Id In:workingOppIdmatchSet]){
       system.debug('opp.MultiTier3_ge_og__c'+opp.MultiTier3_ge_og__c);
       opp.MultiTier3_ge_og__c = false;
       updateOpportunityList.add(opp);
   }

   if(!updateOpportunityList.isEmpty())
       system.debug('Inside updateOpportunityList not empty loop');
      Database.update(updateOpportunityList,false);
}

}
}