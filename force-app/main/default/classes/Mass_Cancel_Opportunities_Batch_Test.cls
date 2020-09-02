@isTest
public class Mass_Cancel_Opportunities_Batch_Test {
    public static testMethod void createUploadRequest()
    {
        
        Id recordtypeId =Schema.SObjectType.Upload_Request_ge_og__c.getRecordTypeInfosByDeveloperName().get('Opportunity_Upload_Request').getRecordTypeId();
        
        Upload_Request_ge_og__c ur =new Upload_Request_ge_og__c();
        ur.Status__c = 'New';
        ur.RecordTypeId = recordtypeId;
        insert ur;
        
        String body = 'OpportunityId,Status\n'+'0060000000xxxxxxxx,test comments';
        Attachment attachment = new Attachment();
        attachment.Body = Blob.valueOf(body);
        attachment.Name = 'Test attachment.csv';
        attachment.ParentId = ur.Id;
        insert attachment;
        System.debug('attachment >>>'+attachment);        
        ur.Status__c = 'Submitted';
        update ur;
        List<Upload_Request_ge_og__c> urlist = new list<Upload_Request_ge_og__c>();
        urlist.add(ur);
        System.debug('ur >>>> '+ur);
        test.startTest();
        Mass_Cancel_Opportunities_Batch mcob = new Mass_Cancel_Opportunities_Batch();
        
        Database.QueryLocator ql = mcob.start(null);
        mcob.execute(null,urlist);
        mcob.Finish(null);
        test.stopTest();
    }
    
}