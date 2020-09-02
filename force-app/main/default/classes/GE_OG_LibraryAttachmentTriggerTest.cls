/*
Class/Trigger Name      : GE_OG_LibraryAttachmentTriggerTest
Used Where ?            : in content
Purpose/Overview        : test controller for GE_OG_LibraryFileAttachmentTrigger
Functional Area         : Foundational
Author                  : Prasad Yadala
Created Date            : 12/10/2014
Test Class Name         : GE_OG_LibraryAttachmentTriggerTest
Code Coverage           : 100

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/
@isTest(seealldata=false)
public class GE_OG_LibraryAttachmentTriggerTest {
    public static testmethod void libraryFileAttachmentImpl() {
        
        Test.startTest()
;        
        upsert new GE_OG_RestrFileExtn__c(Name = 'xls') Name;
        try {
            ContentVersion content=new ContentVersion();
            content.pathonclient='test.xls';
            content.VersionData= Blob.valueof('testData');
            insert content;            
        } catch(Exception e) {            
            System.Assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));            
        }                 
        ContentVersion updatecontent=new ContentVersion();
        
        updatecontent.pathonclient='test.txt';
        updatecontent.VersionData= Blob.valueof('testData');
        insert updatecontent;
        update updatecontent;
        
        Test.stopTest();
    }
    
    public static testmethod void SObjectFileAttachmentImpl() {
        
        Test.startTest();
        
        upsert new GE_OG_RestrFileExtn__c(Name = 'xls') Name;
        try {
            Attachment attach=new Attachment();
            attach.Name='test.xls';
            attach.Body= Blob.valueof('testData');
            insert attach;            
        } catch(Exception e) {    
            system.debug('messagee==='+e.getmessage());        
            System.Assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));            
        }       
        
        Test.stopTest();
    }
    
    public static testmethod void feedItemAttachment(){
        
        Test.startTest();
        
        upsert new GE_OG_RestrFileExtn__c(Name = 'xls') Name;
        
        try{
            FeedItem attach = new FeedItem();
            attach.ContentData = Blob.valueof('testData');
    		attach.ContentFileName = 'test.xls';
            attach.Body = 'Attachment added';
            insert attach;
        }
        Catch (Exception e){
            system.debug('error message: ' + e.getMessage());
            system.assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')); 
        }
        
        Test.stopTest();
        
        
    }
    
    public static testmethod void taskAttachment(){
        
        Test.startTest();
        

        List<Sobject> myList = new List<SObject>();
        
        Task myTask = new Task();
        //myTask.whoId=System.UserInfo.getUserId();
        myTask.subject='my Subject';
        myTask.Status='Not Started';
        myTask.Priority='Normal';
        
        Try{
			Insert myTask;
        }
        Catch(exception e){
            System.debug('Was not able to insert Task!!: ' + e.getMessage());
        }

        try{
            Attachment attach=new Attachment();
            attach.Name='test.xls';
            attach.Body= Blob.valueof('testData');
            attach.ParentId = myTask.id;
            Insert attach;
        }
        Catch(Exception e){
            System.debug('Not able to insert Attachment! : ' + e.getMessage());
        }
       
        // add the restricted file type and now the trigger should check for any files attached that match this in the task
        upsert new GE_OG_RestrFileExtn__c(Name = 'xls') Name;
        
        myTask.Subject = 'updated subject';

        try {
            update myTask;           
        } 
        
        catch(Exception e) {    
            system.debug('messagee==='+e.getmessage());        
            System.Assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));            
        }
        
        Test.stopTest();
    }
}