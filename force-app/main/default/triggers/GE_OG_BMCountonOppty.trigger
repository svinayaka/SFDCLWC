/*
Trigger Name: GE_OG_BMCountonOppty
Used in : GE O&G
Purpose/Overview : Roll-up count of BM Qotes on Oppty upon insertion or deletion
Functional Area : Opportunity Management
Author: Praveena Chintapalli 
Release: 13-Major 2
Test Class Name : batchOpptyArchievedInsertTest


Date Modified    : Developer Name     : Section/PageBlock Modified/Added : Purpose/Overview of Change 
*/

trigger GE_OG_BMCountonOppty on BigMachines__Quote__c (after insert, after delete) {

    Map<String, Integer> opptMap = new Map<String, Integer>();
    List<BigMachines__Quote__c> childList = (Trigger.isInsert || Trigger.isUpdate) ? Trigger.new : Trigger.old;
    List<Id> childIds = new List<Id>();
    
    for (BigMachines__Quote__c b : childList) {
        childIds.add(b.BigMachines__Opportunity__c);
    }
    
    
    for(AggregateResult aggr : [select BigMachines__Opportunity__c, count(Id) from BigMachines__Quote__c where BigMachines__Opportunity__c IN: childIds group by BigMachines__Opportunity__c])           
    {
        System.debug('aggr ***********'+aggr);
        opptMap.put(String.valueOf(aggr.get('BigMachines__Opportunity__c')), Integer.valueOf(aggr.get('expr0')));   
    }
    
    System.debug('^^^^^^^^^^^^^^^^^^^'+opptMap);
    
    List<Opportunity> lstOpportunity = [select id, bigmachines_quotes_ge_og__c from Opportunity where ID IN: opptMap.keySet()];
    List<Opportunity> opptyToUpdate = new List<Opportunity>();
    
    for(Opportunity opp : lstOpportunity) {
        opp.bigmachines_quotes_ge_og__c = opptMap.get(opp.Id);
        System.debug('^^^^^^^^^^^ID'+opp.bigmachines_quotes_ge_og__c);
        opptyToUpdate.add(opp);
    }
    update opptyToUpdate;   
}