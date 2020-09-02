public class CountContactsCasesActivityOnAccountBatch implements Database.Batchable<Sobject>
{
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([select Id, Contact_Count__c,Activity_Count__c,Case_Count__c from Account Where RecordType.DeveloperName = 'Relationship_Account' AND Type != 'Competitor']);
    }
    
    public void execute(Database.BatchableContext context, List<Account> scope)
    {
        Map<Id,Integer> contactCountMap = new Map<Id,Integer>();
        Map<Id,Integer> caseCountMap = new Map<Id,Integer>();
        Map<Id,Integer> activityCountMap = new Map<Id,Integer>();
        
        for(AggregateResult ar : [select AccountId a, count(Id) c from Contact where AccountId in :scope group by AccountId ])
        {
            contactCountMap.put((Id) ar.get('a'),(Integer) ar.get('c'));
        }
        for(AggregateResult ar : [select AccountId a, count(Id) c from Case where AccountId in :scope group by AccountId] )
        {
            caseCountMap.put((Id) ar.get('a'),(Integer) ar.get('c'));
        }
        for(AggregateResult ar : [select WhatId a, count(Id) c from Task where WhatId in :scope group by WhatId] )
        {
            activityCountMap.put((Id) ar.get('a'),(Integer) ar.get('c'));
        }
        for( Account acc : scope)
        {
            acc.Contact_Count__c = contactCountMap.get(acc.Id);
            acc.Case_Count__c = caseCountMap.get(acc.Id);
            acc.Activity_Count__c = activityCountMap.get(acc.Id);
        }
        
        update scope;
        
    }
    public void finish(Database.BatchableContext context) 
    {/**
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:context.getJobId()];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Apex Sharing Recalculation ' + a.Status);
        mail.setPlainTextBody
        ('The batch Apex job processed ' + a.TotalJobItems +
        ' batches with '+ a.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  **/
    }
}