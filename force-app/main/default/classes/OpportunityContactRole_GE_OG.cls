/*
Class/Trigger Name     : OpportunityContactRole_GE_OG
Used Where ?           : OpportunityContactRole_GE_OG_Test
Purpose/Overview       : To Check/uncheck "has_opportunitycontactrole_ge_og__c" on oppty
Scrum Team             : Oppty MGMT - Transformation
Requirement Number     : 
Author                 : Sanath Kumar Dheram
Created Date           : 4/JAN/2016
Test Class Name        : OpportunityContactRole_GE_OG_Test
Code Coverage          : 
*/
global  class OpportunityContactRole_GE_OG
{

    @InvocableMethod(label='Update Opportunity Contact Role' description='Check/Uncheck has_opportunitycontactrole_ge_og__c on oppty.')
    public static void updateOpportunityContactRole(List<Id> opptyId)
    {
         Map<Id,Integer> mapOpptyId_CountContactRole =  new Map<Id,Integer>();
         List<Opportunity> lstOpptyToUpdate = new List<Opportunity>();
         
         
         
         for(AggregateResult aggresult:[SELECT COUNT(Id) cnt,OpportunityId oppty 
                                        FROM OpportunityContactRole
                                        WHERE OpportunityId=:opptyId[0]
                                        GROUP BY OpportunityId])
         {
             mapOpptyId_CountContactRole.put((Id) aggresult.get('oppty'), (Integer) aggresult.get('cnt'));
         }
         
         if(!mapOpptyId_CountContactRole.isEmpty())
         {
             for(Id OpportunityId:mapOpptyId_CountContactRole.keyset())
             {
                 if(mapOpptyId_CountContactRole.containskey(OpportunityId) && 
                    mapOpptyId_CountContactRole.get(OpportunityId) != null && 
                    mapOpptyId_CountContactRole.get(OpportunityId) > 0)
                 {
                     lstOpptyToUpdate.add(new Opportunity(Id = OpportunityId , has_opportunitycontactrole_ge_og__c = true));
                 }
                 else
                 {
                      lstOpptyToUpdate.add(new Opportunity(Id = OpportunityId , has_opportunitycontactrole_ge_og__c = false));
                 }
             }
         }
         else{
             if(opptyId.size()>0)
                lstOpptyToUpdate.add(new Opportunity(Id = opptyId[0] , has_opportunitycontactrole_ge_og__c = false));
         }
         
         if(!lstOpptyToUpdate.isEmpty())
             update lstOpptyToUpdate;
           
    }


}