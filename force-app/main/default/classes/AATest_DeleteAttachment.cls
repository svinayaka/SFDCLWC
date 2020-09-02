//Test Class for GE_Retrict_Attachment_Deletion
@isTest(SeeAllData=true) 
public class AATest_DeleteAttachment{
static testmethod void GE_Retrict_Attachment_Deletion()
    {
        Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=acc.id;
        insert attach;
        delete attach;
    }
    }