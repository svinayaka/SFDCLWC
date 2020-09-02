/*
Class/Trigger Name     : BillingChecklistTriggerHandler 
Used Where ?           : BillingChecklistTrigger
Purpose/Overview       : update last modified date and last modified user on opportunity.
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-33748
Author                 : Harsha C
Created Date           : 26/02/2020
Test Class Name        : BillingChecklistTriggerHandler_Test
Code Coverage          : 
*/
public class BillingChecklistTriggerHandler {
    public static void updateLastModifiedOnOpportunity(List<Billing_Checklist_GE_OG__c> billingchklist){
        Map<Id,Opportunity> optylastmodified = new Map<Id,Opportunity>();
        List<Opportunity> opptyList = new List<Opportunity>();
        try{
            for(Billing_Checklist_GE_OG__c bcc : billingchklist){
                
                Opportunity TargetObj2 = new Opportunity();
                TargetObj2.Id = bcc.opportunity_ge_og__c;
                System.debug('TargetObj2 >>>>> '+TargetObj2);
                if(optylastmodified.containsKey(TargetObj2.Id)){
                    
                        TargetObj2.Billing_Checklist_Last_ModifiedDate_geog__c= bcc.LastModifiedDate;
                        TargetObj2.billing_checklist_Lat_modified_by__c = bcc.LastModifiedById;
                    
                    optylastmodified.put(TargetObj2.Id, TargetObj2);
                }
                else
                {
                    
                    TargetObj2.Billing_Checklist_Last_ModifiedDate_geog__c= bcc.LastModifiedDate;
                    TargetObj2.billing_checklist_Lat_modified_by__c = bcc.LastModifiedById;
                    optylastmodified.put(TargetObj2.Id, TargetObj2);
                }    
            }
            System.debug('optylastmodified >>> '+optylastmodified);
            opptyList.addAll(optylastmodified.values());
            update opptyList;
        }catch(Exception e){
            System.debug('e.get message in billing checklist trigger handler '+e.getCause());
            System.debug('e.get line number  '+e.getLineNumber());
            System.debug('e.get message '+e.getMessage());
            
            
        }
    }
}