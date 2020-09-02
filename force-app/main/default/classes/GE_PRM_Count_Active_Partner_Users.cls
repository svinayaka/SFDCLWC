/*
Type Name [Class/Trigger/Page Name] : Class - GE_PRM_Count_Active_Partner_Users
Used Where ?                        : To count the active Partner Users (PRM)
Purpose/Overview                    : To count the active Partner Users
Functional Area                     : PRM
Author                              : Arpita Sarangee
Created Date                        : 5th July 2012
Test Class Name                     : 

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

global class GE_PRM_Count_Active_Partner_Users implements Schedulable
    {
    global void execute(SchedulableContext ctx)
        {
        Set<Integer> partnerCount = new Set<Integer>();
        List<AggregateResult> groupPartnerAccs = new List<AggregateResult>();        
        Map<Id,Account> partnerAccounts = new Map<Id,Account>([Select Id, GE_PRM_Active_PRM_Users__c FROM Account WHERE IsPartner = true]);
        system.debug('*****HelooPartnerAccs***'+partnerAccounts.size());    
        groupPartnerAccs = [select AccountId,count(id) partnercount from User WHERE IsActive = true AND AccountId IN: partnerAccounts.keySet() AND AccountId != null group by AccountId];
        system.debug('Hi*****'+groupPartnerAccs.size());
            
        if(groupPartnerAccs.size() > 0)
            {
            for(AggregateResult agg : groupPartnerAccs)
                {
                system.debug('*****aggpartneraccId*****'+(partnerAccounts.get(String.valueOf(agg.get('AccountId')))));
                if(partnerAccounts.get(String.valueOf(agg.get('AccountId')))!=null)
                    {
                    partnerAccounts.get(String.valueOf(agg.get('accountId'))).GE_PRM_Active_PRM_Users__c = Integer.valueOf(String.valueOf(agg.get('partnercount'))); 
                    system.debug('***partnerActiveUserNo***'+partnerAccounts.get(String.valueOf(agg.get('accountId'))).GE_PRM_Active_PRM_Users__c);
                    }
                }
            update partnerAccounts.values();            
            }    
        
        }
    }