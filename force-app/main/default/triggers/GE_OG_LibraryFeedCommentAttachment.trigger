/*
Class/Trigger Name      : GE_OG_FeedCommentAttachment
Used Where ?            : in content
Purpose/Overview        : to rstrict few file types from being uploaded
Functional Area         : Foundational
Author                  : Prasad Yadala
Created Date            : 12/10/2014
Test Class Name         : GE_OG_FeedCommentAttachmentTest
Code Coverage           : 100

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/
trigger GE_OG_LibraryFeedCommentAttachment on ContentVersion (Before Insert,Before Update)
{    
    //calling the util control to validate the restricted file types on content, Feed Comments
    for (ContentVersion attachment :Trigger.new)
        GE_OG_RestrictDllAndExeFileUtil.restrictLibraryAttachment(attachment);
    
}