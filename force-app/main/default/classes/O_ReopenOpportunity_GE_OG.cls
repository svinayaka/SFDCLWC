/*
Class/Trigger Name     : O_ReopenOpportunity_GE_OG
Used Where ?           : "Reopen Opportunity" button on Opportunity record
Purpose/Overview       :  Used to reopen Opportunity record 
Scrum Team             :  Opportunity Management
Requirement Number     : R-26400
Author                 : Rupal Seth
Created Date           : 04/10/2017
Test Class Name        : O_ReopenOpportunity_Test_GE_OG
Code Coverage          : 87%
*/
global class O_ReopenOpportunity_GE_OG {
    // Method to reopen Closed Oppty record
    @InvocableMethod(label = 'Reopen Opportunity'
        description = 'Reopen Opportunity record')
    public static list < String > reopenOppty(List < Id > OpportunityId) {
        System.debug('------------------Inside Invocable method loop--------------------');
        List < String > successResult = new List < String > ();
        successResult.add(reopenOpptyLogic(OpportunityId[0]));
        return successResult;

    }

    webservice static string reopenOppty(String OpportunityId) {
        return reopenOpptyLogic(OpportunityId);

    }

    public static String reopenOpptyLogic(String OpportunityId) {
        System.debug('------------Inside reopenOpptyLogic loop-----------' + OpportunityId);
        Id oppOGRecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity', 'O&G').getRecordTypeId();
        Id oppGFRecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity', 'Grouped Flow').getRecordTypeId();
        Opportunity oppty = [SELECT Id, RecordType.Id, RecordType.name, Opportunity_type_ge_og__c, StageName FROM Opportunity WHERE Id =: OpportunityId];
        System.debug('------------Value of oppty from SOQL-----------' + Oppty.Id);
        System.debug('-----------oppty.opportunity_type_ge_og__c------------' + oppty.opportunity_type_ge_og__c);
        System.debug('-----------oppty.StageName------------' + oppty.StageName);
        
        if (oppty.opportunity_type_ge_og__c == 'O&G' && ((oppty.StageName == 'Closed Won') || (oppty.StageName == 'Closed Lost') || (oppty.StageName == 'Cancelled'))) {
            System.debug('-----------Inside O&G loop------------');
            oppty.RecordTypeId = oppOGRecordTypeId;
            oppty.StageName = 'Prospecting';
            oppty.stage_ge_og__c = '';
            oppty.primary_reason_code_ge_og__c = '';
            oppty.primary_sub_reason_code_ge_og__c = '';
            oppty.disposition_comments_ge_og__c = '';
            try {
                update oppty;
            } catch (Exception e) {
                System.debug(e);
                //oppty.addError('Please correct the bad data first');
                return String.valueOf(e);
            }
            System.debug('-----------O&G oppty updated------------');

        } else if (oppty.opportunity_type_ge_og__c == 'Grouped Flow' && ((oppty.StageName == 'Closed Won') || (oppty.StageName == 'Closed Lost') || (oppty.StageName == 'Cancelled'))) {
            System.debug('-----------Inside Grouped flow loop------------');
            oppty.RecordTypeId = oppGFRecordTypeId;
            oppty.StageName = 'Negotiating';
            oppty.disposition_comments_ge_og__c = '';
            try {
                update oppty;
            } catch (Exception e1) {
                System.debug(e1);
                return String.valueOf(e1);
            }
        }

        return null;
    }
}