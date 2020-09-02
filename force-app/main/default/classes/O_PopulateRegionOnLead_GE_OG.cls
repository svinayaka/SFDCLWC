/*
Class/Trigger Name	:	O_PopulateRegionOnLead_GE_OG 
Purpose/Overview	: 	Used to Populate the region field on Lead
Scrum Team			: 	OPPTY MGMT
Requirement Number	: 
Author				: 	Rupal Seth
Created Date		: 	28/FEB/2018
Test Class Name		: 	O_Campaign_GE_OG_Test
Code Coverage		: 
*/

public class O_PopulateRegionOnLead_GE_OG {
    public void updateRegionOnLead(List<Lead> LeadList){
        for (Lead lead : LeadList){
            if(lead.Country_ge_og__c != ''){
                lead.sales_region_ge_og__c = Util_GE_OG.regionPopulateByCountry(lead.Country_ge_og__c);
            }
        } 
    }      
}