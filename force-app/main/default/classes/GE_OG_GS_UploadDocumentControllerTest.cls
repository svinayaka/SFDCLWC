/*
 * UploadDocumentController test class
 */
@isTest
public class GE_OG_GS_UploadDocumentControllerTest {
    
    public static testmethod void testAttachmentUploadPositive(){
        // Insert chatter group
        CollaborationGroup cgroup =  new CollaborationGroup();
        cgroup.Name = 'Test'+system.now();
        cgroup.CollaborationType = 'Public';
        insert cgroup;
        
        // insert group setting
        GE_OG_GS_Technician_Attachment_Setting__c taSetting = new GE_OG_GS_Technician_Attachment_Setting__c();
        taSetting.GE_OG_GS_Chatter_Gruop_Id__c = cgroup.Id;
        taSetting.GE_OG_GS_Chatter_Gruop_Name__c = 'Test';
        taSetting.GE_OG_GS_SF_Instance_URL__c = 'https://servicemaxdemo-2140.cloudforce.com';
        insert taSetting;
        
        //insert Technician Attachment
        GE_OG_GS_Technician_Attachment__c ta = new GE_OG_GS_Technician_Attachment__c();
        insert ta;
        
        // test upload page
        PageReference pgRef = Page.GE_OG_GS_UploadDocument;
        pgRef.getParameters().put('id',ta.Id);
        Test.setCurrentPageReference (pgRef);
        
        //create content feeditem;
        FeedItem post = new FeedItem();
        Blob data = Blob.valueOf('test');
        post.ContentFileName = 'test.pdf';
        post.ContentData = data;
        
        //+positive upload test
        GE_OG_GS_UploadDocumentController uController = new GE_OG_GS_UploadDocumentController();
        uController.post = post;
        uController.upload();
        
        // for coverage cover catch block
        
    }
    
    public static testmethod void testAttachmentUploadNegative(){
        // Insert chatter group
        CollaborationGroup cgroup =  new CollaborationGroup();
        cgroup.Name = 'Test'+system.now();
        cgroup.CollaborationType = 'Public';
        insert cgroup;
        
        // insert group setting
        GE_OG_GS_Technician_Attachment_Setting__c taSetting = new GE_OG_GS_Technician_Attachment_Setting__c();
        taSetting.GE_OG_GS_Chatter_Gruop_Id__c = cgroup.Id;
        taSetting.GE_OG_GS_Chatter_Gruop_Name__c = 'Test';
        taSetting.GE_OG_GS_SF_Instance_URL__c = 'https://servicemaxdemo-2140.cloudforce.com';
        insert taSetting;
        
        //insert Technician Attachment
        GE_OG_GS_Technician_Attachment__c ta = new GE_OG_GS_Technician_Attachment__c();
        insert ta;
        
        // test upload page
        PageReference pgRef = Page.GE_OG_GS_UploadDocument;
        pgRef.getParameters().put('id','');
        Test.setCurrentPageReference (pgRef);
        
        //create content feeditem;
        FeedItem post = new FeedItem();
        Blob data = Blob.valueOf('test');
        post.ContentFileName = 'test.pdf';
        post.ContentData = data;
        
        //+ve upload test
        GE_OG_GS_UploadDocumentController uController = new GE_OG_GS_UploadDocumentController();
        uController.post = post;
        uController.upload();
                
    }
}