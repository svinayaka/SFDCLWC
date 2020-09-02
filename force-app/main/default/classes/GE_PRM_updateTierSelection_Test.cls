@isTest
public class GE_PRM_updateTierSelection_Test {
    @isTest(seealldata=true)
    public static void test1(){    
    GE_PRM_Recommendation_Approvers__c r = [select id from GE_PRM_Recommendation_Approvers__c where GE_PRM_Country__c != null AND GE_PRM_Tier_1_New__c != null AND GE_PRM_Tier_2__c != null AND GE_PRM_Tier_3__c != null AND GE_PRM_Tier_4__c != null  AND GE_PRM_Role__c != null AND GE_PRM_Region__c != null  limit 1];
    update r;
    GE_PRM_Recommendation_Approvers__c r1 = [select id from GE_PRM_Recommendation_Approvers__c where GE_PRM_Country__c != null AND GE_PRM_Tier_1_New__c != null AND GE_PRM_Tier_2__c != null AND GE_PRM_Tier_3__c != null AND GE_PRM_Tier_4__c != null  AND GE_PRM_Role__c != null AND GE_PRM_Region__c != null AND GE_PRM_Country__c = 'United States' limit 1];
    update r1;    
    }
}