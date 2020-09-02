/*
Class/Trigger Name     : O_DeleteRevenueLines_GE_OG
Purpose/Overview       : Delete Revenue Lines associated to a particular Opportunity Product
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-26624
Author                 : Rupal Seth
Created Date           : 08/JAN/18
Test Class Name        : O_deleteRevenueLines_GE_OG_Test
Code Coverage          : 
*/

public class O_DeleteRevenueLines_GE_OG {

    public void deleteRevenueLines (List<OpportunityLineItem> deletedOpportunityLines){
        List<Id> oliId = new List<Id>{};
        for(OpportunityLineItem oli: deletedOpportunityLines){
    		oliId.add(oli.id);
 		}
    Revenue_Schedule_ge_og__c[] deleteRevenueLineIds = [select id from Revenue_Schedule_ge_og__c where OpportunityLineItemID_ge_og__c IN :oliId];

	delete deleteRevenueLineIds;
    }
}