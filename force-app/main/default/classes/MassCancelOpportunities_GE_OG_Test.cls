/*
Class Name			: MassCancelOpportunities_GE_OG
Used Where ? 		: Used for Mass cancel Opportunities Automation.
Purpose/Overview	: Automates the manual process of cancelling the opportunities.
Author				: Harsha C
Created Date		: 06/MAY/2019
Requirement			: R-31649
Test Class Name		: MassCancelOpportunities_GE_OG_Test
Code Coverage  		:
*/
@IsTest
public class MassCancelOpportunities_GE_OG_Test {
    
    public static testMethod void testmassCancel(){
       test.startTest();
        Upload_Request_ge_og__c ur =new Upload_Request_ge_og__c();
        ur.Status__c = 'New';
        ur.RecordTypeId = System.Label.Upload_Request_Record_Type_Id;
        insert ur;
       
        String body = 'OpportunityId,Status\n'+'0060000000xxxxxxxx,test comments';
        Attachment attachment = new Attachment();
        attachment.Body = Blob.valueOf(body);
        attachment.Name = 'Test attachment.csv';
        attachment.ParentId = ur.Id;
        insert attachment;
        
        ur.Status__c = 'Submitted';
        ur.Trigger_Upload_Request_ge_og__c = true;
        update ur;
        List<Upload_Request_ge_og__c> urlist = new List<Upload_Request_ge_og__c>();
        urlist.add(ur);
        MassCancelOpportunities_GE_OG.massCancelOptyRecords(urlist);
        test.stopTest();
    }
    
}