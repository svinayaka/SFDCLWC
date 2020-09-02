/*
    Class/Trigger Name     : Optional_BillingChecklist
    Purpose/Overview       : This method is used to create Billing checklist Records
    Scrum Team             : Transformation - OPPTY MGMT
    Requirement Number     : R-33748
    Author                 : Harsha C
    Created Date           : 25/02/2020
    Test Class             : Optional_BillingChecklist_Test
	Code Coverage		   :
*/ 
public class Optional_BillingChecklist {
    @InvocableMethod(label='Create Billing Checklist Records' description='This method is used to create Billing checklist Records')
    public static void create_BillingChecklist_Records(List<Id> opptyId){
        List<Billing_Checklist_GE_OG__c> billingchecklist = new List<Billing_Checklist_GE_OG__c>();
        List<Opportunity_Generic_Checklist_ge_og__c> optygencheklist = [SELECT Id, Checklist_Name__c, Question_ge_og__c, Active_GE_OG__c
                                                                        FROM Opportunity_Generic_Checklist_ge_og__c where Active_GE_OG__c =true ];
        for(Opportunity_Generic_Checklist_ge_og__c opgcl : optygencheklist){
            for(Id optyId : opptyId){
                Billing_Checklist_GE_OG__c bilingchklist = new Billing_Checklist_GE_OG__c();
                bilingchklist.Question_ge_og__c = opgcl.Question_ge_og__c;
                bilingchklist.opportunity_ge_og__c = optyId;
                billingchecklist.add(bilingchklist);
            }
        }
        System.debug('billingchecklist  >>>>> '+billingchecklist);
        insert billingchecklist;  
    }
}