public with sharing class OpportunityData {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(String oppId){
        return [SELECT Id, StageName, deal_path_ge_og__c, Has_Risk_Region_ge_og__c, tier_2_ge_og__c, tier_3_ge_og__c,isbudgetary_ge_og__c, legal_entity_ge_og__r.Watchlist_Flag_GE_OG__c from opportunity where Id=:oppId];
    }
}