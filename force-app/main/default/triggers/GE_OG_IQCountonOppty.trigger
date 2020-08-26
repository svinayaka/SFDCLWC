/*
Trigger Name: GE_OG_IQCountonOppty
Purpose/Overview : Roll-up count of IQ Qotes on Oppty upon insertion or deletion (R-22794)
Functional Area : Opportunity Management
Author: Naveen Vuppu 
Test Class Name : GE_OG_IQCountonOppty_Test

Date Modified    : Developer Name     : Section/PageBlock Modified/Added : Purpose/Overview of Change 
*/

trigger GE_OG_IQCountonOppty on IFE__iQuote__c (after insert, after delete) {

    Map<String, Integer> opptMap = new Map<String, Integer>();
    List<IFE__iQuote__c> childList = (Trigger.isInsert || Trigger.isUpdate) ? Trigger.new : Trigger.old;
    List<Id> childIds = new List<Id>();
    
    for (IFE__iQuote__c b : childList) {
        childIds.add(b.IFE__Opportunity__c);
    }
    
    
    for(AggregateResult aggr : [select IFE__Opportunity__c, count(Id) from IFE__iQuote__c where IFE__Opportunity__c IN: childIds group by IFE__Opportunity__c])           
    {
        opptMap.put(String.valueOf(aggr.get('IFE__Opportunity__c')), Integer.valueOf(aggr.get('expr0')));   
    }
    
    List<Opportunity> lstOpportunity = [select id, GE_OG_IQ_Quotes__c from Opportunity where ID IN: opptMap.keySet()];
    List<Opportunity> opptyToUpdate = new List<Opportunity>();
    
    for(Opportunity opp : lstOpportunity) {
        opp.GE_OG_IQ_Quotes__c = opptMap.get(opp.Id);
        opptyToUpdate.add(opp);
    } 
    update opptyToUpdate;   
}