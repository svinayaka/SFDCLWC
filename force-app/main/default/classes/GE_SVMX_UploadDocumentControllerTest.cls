@isTest
public class GE_SVMX_UploadDocumentControllerTest{
    
@TestSetup
public static void setup()
{
    
    User u = new User(
     ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
     LastName = 'lastTest',
     Email = 'puser000@amamama.com',
     Username = 'puser000@amamama.com' + System.currentTimeMillis(),
     CompanyName = 'TEST',
     Title = 'title',
     Alias = 'alias',
     TimeZoneSidKey = 'America/Los_Angeles',
     EmailEncodingKey = 'UTF-8',
     LanguageLocaleKey = 'en_US',
     LocaleSidKey = 'en_US'
     //UserRoleId = r.Id
         
  );
    Insert u;
    
       Group test = new Group();
       test.Name = 'BHGE External Renco';
       insert test;
    
    GroupMember gm= new GroupMember();
    gm.groupId= test.id;
    gm.UserOrGroupId=u.id;
    insert gm;
}
 
 @isTest
 public static  void testUpload()
 {
     User testUser= [Select id from User where Lastname= 'lastTest'];
     
     system.runAs(testUser)
     {
     CollaborationGroup cgroup =  new CollaborationGroup();
        cgroup.Name = 'Test'+system.now();
        cgroup.CollaborationType = 'Public';
        insert cgroup;
        
      GE_OG_GS_Technician_Attachment_Setting__c taSetting = new GE_OG_GS_Technician_Attachment_Setting__c();
        taSetting.GE_OG_GS_Chatter_Gruop_Id__c = cgroup.Id;
        taSetting.GE_OG_GS_Chatter_Gruop_Name__c = 'Test';
        taSetting.GE_OG_GS_SF_Instance_URL__c = 'https://servicemaxdemo-2140.cloudforce.com';
        insert taSetting;
        
     GE_OG_GS_Technician_Attachment__c ta = new GE_OG_GS_Technician_Attachment__c();
     insert ta;
        
      Technician_Attachment_ExtRM__mdt mdt = [Select id,Chatter_Group_Id__c,Chatter_Group_Name__c,Public_Group_Name__c,SF_Instance_URL__c from Technician_Attachment_ExtRM__mdt where 
Public_Group_Name__c='BHGE External Renco'];
        
        
     // FeedItem post = new FeedItem();
       // Blob data = Blob.valueOf('test');
       // post.ContentFileName = 'test.pdf';
        //post.ContentData = data;
        
        
        ContentVersion cv = new ContentVersion();
        cv.title = 'test content trigger';      
        cv.PathOnClient ='test';           
        cv.VersionData = Blob.valueOf('Test Content');          
        insert cv;  
        
        
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];

        //create ContentDocumentLink  record 
        ContentDocumentLink cdl = New ContentDocumentLink();
        //cdl.LinkedEntityId = cgroup.id;
          cdl.LinkedEntityId = ta.id;

        cdl.ContentDocumentId = documents[0].Id;
        
        cdl.shareType = 'V';
        insert cdl;

 
        
        Id docId = cdl.ContentDocumentId;     
        
        //GE_SVMX_UploadDocumentController obj= new GE_SVMX_UploadDocumentController ();
         System.Test.StartTest();
               GE_SVMX_UploadDocumentController.Upload(ta.id,docId);
         System.Test.StopTest();
 
     }  
 
 }
 
 
 
   


}