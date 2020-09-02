public class updateTotalRegistrationFieldForEvents implements Database.Batchable<sObject>
{
    List<Id> AccountHQ = new List<Id>();
    List<Id> CampaignList = new List<Id>();
    Map<Id,Integer> totRegMap = new Map<Id,Integer>();
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
         return Database.getQueryLocator([Select Id,Account_HQ__c,Total_Registrations__c,Event_Name__c From Account_Event_Relation__c Where Type__c = 'Event' AND Events_and_Sessions_on_Account_HQ__c != null AND Account_HQ__c != null]);
    }
    
    public void execute(Database.BatchableContext BC, List<Account_Event_Relation__c> scope)
    {
        for(Account_Event_Relation__c aer :  scope)
        {
            AccountHQ.add(aer.Account_HQ__c);
            CampaignList.add(aer.Event_Name__c);
        }
        
        for(AggregateResult ar : [Select Member_of_Account__c m , count(Id) c From CampaignMember Where CampaignMember.Campaign.Type = 'Event' AND Campaign.Cvent_Link__c!= null AND Member_of_Account__c IN :AccountHQ AND CampaignId IN : CampaignList group by Member_of_Account__c ])
        {
            totRegMap.put((Id) ar.get('m'),(Integer) ar.get('c'));
        }
        
        for(Account_Event_Relation__c aer :  scope)
        {
            aer.Total_Registrations__c = totRegMap.get(aer.Account_HQ__c);
        }
        
        update scope;
 
    }
    
    public void finish(Database.BatchableContext BC){}
}