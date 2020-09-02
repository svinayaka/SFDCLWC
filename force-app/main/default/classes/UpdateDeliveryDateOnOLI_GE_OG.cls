/*
Class/Trigger Name     : UpdateDeliveryDateOnOLI_GE_OG
Purpose/Overview       : call from OpportunityTrigger_GE_OG - OpportunityTriggerHandler_GE_OG Class for update O&G Region and Install Country
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23941
Author                 : Mohit Maheshwari
Created Date           : 16/Dec/2015
Test Class Name        : UpdateDeliveryDateOnOLI_GE_OG_Test
Code Coverage          : 100
*/

public without sharing class UpdateDeliveryDateOnOLI_GE_OG{
    public void updateDeliveryDateOnOLI(List<Opportunity> lstOpp, Map<ID,Opportunity> mapOldOppty){
        // Retreive O&G record type ID on Opportunity 
        ID OppOGRecordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(System.Label.O_G).getRecordTypeID();
        // Initialize set of Oppty ID  
        Set<ID> setOppIDs = new Set<ID>();
        // Initialize list of OpportunityLineItem
        List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
        // Initialize map of Opportunity and Delivery Date
        Map<ID,Opportunity> mapOpp = new Map<ID,Opportunity>();
        // logic to create set of Opportunity IDs and Map of Opportunity in which Delivery Date updated
        for(Opportunity objOpp : lstOpp){
            if(objOpp.delivery_date_ge_og__c != mapOldOppty.get(objOpp.ID).delivery_date_ge_og__c && OppOGRecordTypeID == objOpp.RecordTypeID){
                setOppIDs.add(objOpp.ID);
                mapOpp.put(objOpp.ID, objOpp);
            }
        }
        // logic to update OpportunityLineItem 1st Delivery Date
        if(setOppIDs.size()>0){
            lstOLI = [Select ID, OpportunityID, x1st_delivery_date_ge_og__c, closed_opportunity_ge_og__c from OpportunityLineItem where OpportunityID in : setOppIDs];
            if(lstOLI.size()>0){
                for(OpportunityLineItem objOLI : lstOLI){
                    objOLI.x1st_delivery_date_ge_og__c = (mapOpp.containsKey(objOLI.OpportunityID) ? mapOpp.get(objOLI.OpportunityID).delivery_date_ge_og__c : objOLI.x1st_delivery_date_ge_og__c);
                    objOLI.closed_opportunity_ge_og__c = True;
                }
                update lstOLI;
            }
        }
    }
}