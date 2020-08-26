/*
Class/Trigger Name      : GE_OG_FeedItemFileAttachmentTrigger
Used Where ?            : in content
Purpose/Overview        : to rstrict few file types from being uploaded
Functional Area         : Foundational
Author                  : Prasad Yadala
Created Date            : 12/10/2014
Test Class Name         : GE_OG_FeedItemAttachmentTriggerTest
Code Coverage           : 100

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/
trigger GE_OG_FeedItemFileAttachmentTrigger on FeedItem (before insert) 
{
    //calling the util control to validate the restricted file types
    for (FeedItem attachment :Trigger.new)
        GE_OG_RestrictDllAndExeFileUtil.restrictFeedItemAttachment(attachment);
}