/*
Class                  : O_MarkDigitalProductOnOLIFalse_GE_OG
Used Where ?           : Used to mark/unmark digital flag on OLI when the digital flag on Product is updated
Purpose/Overview       : Used to drive Revenue Schedule for Digital Opportunity Products
Scrum Team             : Opportunity Management
Requirement Number     : R-29717
Author                 : Rupal Seth
Created Date           : 26/APR/2018
Test Class Name        : 
Code Coverage          : 
*/

public class O_MarkDigitalProductOnOLIFalse_GE_OG {
    public void afterUpdateHandler(List < Product2 > updatedProductList, Map<Id,Product2> productoldMap) {
        system.debug('Inside O_MarkDigitalProductOnOLIFalse_GE_OG---------------------');
        List < Product2 > prodListFalse = new List < Product2 > ();
        List < Product2 > prodListTrue = new List < Product2 > ();

        for (Product2 p: updatedProductList) {
            system.debug('p.digital_ge_og__c-----------' + p.digital_ge_og__c);
            if (p.digital_ge_og__c == false && productoldMap.get(p.Id).digital_ge_og__c == True) {
                system.debug('Inside p.digital_ge_og__c false list------------' +p.digital_ge_og__c);
                prodListFalse.add(p);
            } else if (p.digital_ge_og__c == true && productoldMap.get(p.Id).digital_ge_og__c == False) {
                system.debug('Inside p.digital_ge_og__c true list------------' +p.digital_ge_og__c);
                prodListTrue.add(p);
            }
        }

        OpportunityLineItem[] OLIFalseList = [SELECT Product2Id FROM OpportunityLineItem WHERE Product2Id =: prodListFalse];
        List < OpportunityLineItem > updateOLIListToFalse = new List < OpportunityLineItem > ();
        if (OLIFalseList.size() > 0) {
            system.debug('Inside OLISIZE > 0--------------' +OLIFalseList.size());
            for (OpportunityLineItem OLIList: OLIFalseList) {
                OLIList.Is_Digital_Product_ge_og__c = false;
                system.debug('OLIList.Is_Digital_Product_ge_og__c----------' + OLIList.Is_Digital_Product_ge_og__c);
                updateOLIListToFalse.add(OLIList);
            }
        }
        try{
        update updateOLIListToFalse;
            system.debug('updateOLIListToFalse Updated----------');
        }
        catch(Exception e){
            system.debug('Exception caught while updating to false----'+e);
        }

        OpportunityLineItem[] OLITrueList = [SELECT Product2Id FROM OpportunityLineItem WHERE Product2Id =: prodListTrue];
        List < OpportunityLineItem > updateOLIListToTrue = new List < OpportunityLineItem > ();
        if (OLITrueList.size() > 0) {
            system.debug('Inside OLISIZE > 0--------------');
            for (OpportunityLineItem OLIList: OLITrueList) {
                OLIList.Is_Digital_Product_ge_og__c = true;
                system.debug('OLIList.Is_Digital_Product_ge_og__c----------' + OLIList.Is_Digital_Product_ge_og__c);
                updateOLIListToTrue.add(OLIList);
            }
        }
        try{
        update updateOLIListToTrue;
        system.debug('updateOLIListToTrue Updated----------');
        }
        catch(Exception e1){
            System.debug('Exception caught while updating to true'+e1);
        }
    }
}