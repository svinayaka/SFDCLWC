/*
Class/Trigger Name      : GE_OG_FeedItemAttachmentTrigger
Used Where ?            : in content
Purpose/Overview        : test class for GE_OG_FeedItemAttachmentTrigger
Functional Area         : Foundational
Author                  : Prasad Yadala
Created Date            : 12/10/2014
Test Class Name         : GE_OG_FeedItemAttachmentTriggerTest
Code Coverage           : 100

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/

@isTest(seealldata=true)
public Class GE_OG_FeedItemAttachmentTriggerTest
{   
    Public Static TestMethod void insertFeedItemImpl()
    {
        try
        {
            User user=[select id from user where FirstName like '%Silja' limit 1];
            upsert new GE_OG_RestrFileExtn__c(Name = 'xls') Name;
            String testData = 'Test Data';
            FeedItem attachment=new FeedItem();
            attachment.parentid=user.id;
            attachment.ContentFileName='Test.xls';
            
            Blob ContentData = Blob.valueof(testData);
            
            attachment.ContentData=ContentData;
            insert attachment;
            system.assertequals(user.id,attachment.parentid);
            
        }
        catch(Exception e) {
            
            System.Assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));
            
            
            
        } 
        
    }
    
}