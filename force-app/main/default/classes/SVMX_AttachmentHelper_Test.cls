/*
Description     :This test class covers the SVMX_AttachmentHelper Controller class
which include covering of various action function and business logic function. 
Functional Area : 
Created By      : Raju Manche
Release         : 
Modified By     : Amit Kumar (R-21990)
*/
@isTest(seeAllData=true)
public class SVMX_AttachmentHelper_Test
{
    static TestMethod void SVMX_AttachmentHelper_method()
    {    
        
        Test.StartTest();
        //Getting RecordType
        String NewSmax = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();    
     
        //Account Data Helper
        Account acc = [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
         
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Account commAcc = new Account(Name='Apex Test Sold To Account 1', Type = 'Customer',RecordtypeId = CommAccrecType, BillingStreet = '123 Main St', BillingCity = 'Anywhere', BillingState='California', BillingCountry='United States', BillingPostalCode='99999', ShippingStreet = '123 Main St', ShippingCity = 'Anywhere', ShippingState='KS', ShippingPostalCode='99999', Phone='510-555-1212',  
Classification__c ='Strategic' );
        insert commAcc;     
     
        // New user
        User usr = new User(FirstName = 'Smaxemail1', LastName = 'Tester1', Email='smax.emailattach1@tester.com.test1', Alias = 'aematt1', username = 'smax.send.email.attach1@tester.com',
                             CommunityNickname = 'aematt2', TimeZoneSidKey = 'America/Los_Angeles', LocaleSidKey = 'en_US',
                             ProfileId = UserInfo.getProfileId(), EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', EmployeeNumber = '123456');
        insert usr;   
        
        //Inserting a new Contact
        Contact ct = new Contact(); 
        ct.FirstName = 'SMax';
        ct.LastName = 'EmailAttachTesting';
        ct.AccountId = commAcc.Id;
        ct.MailingStreet = '123 Main Street';
        ct.MailingCity = 'Houston';
        ct.MailingState = 'California';
        ct.MailingCountry = 'United States';
        ct.MailingPostalCode = '77041';
        ct.Email = 'noemail@outlook.com';
        ct.GE_OG_Contact_Audience__c ='Technical Support';
        ct.GE_OG_Country__c='United States';
        insert ct;
          
        //New Location
        SVMXC__Site__c loc = new SVMXC__Site__c();
        loc.Name='Test Location';
        loc.GE_AL_Well_Type__c='Drilling';
        insert loc;
                
        // New Work Order
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(SVMXC__Company__c = acc.Id);
        wo.SVMXC__Order_Status__c = 'New';
        wo.SVMXC__Order_Type__c='Field Service';
        wo.SVMXC__Street__c = '16260 Monterey St.';
        wo.SVMXC__City__c = 'Morgan Hill';
        wo.SVMXC__State__c = 'California';
        wo.SVMXC__Zip__c = '95037';
        wo.SVMXC__Country__c = 'USA';
        wo.Email_Service_Report__c = 'noemail@outlook.com';
        wo.RecordTypeId = NewSmax;        
        wo.SVMXC__Site__c = loc.Id;
        wo.SVMXC__Priority__c = 'Medium';
        insert wo;
        System.debug('Work Order - Success');
        
        // New Attachment
        Attachment att=new Attachment();    
        att.body=Blob.valueOf('Unit Test Attachment Body');
        att.parentId=wo.id;
        att.Name=att.parentId + 'Create_Service_Report.pdf';
        insert att; 
        System.debug('Insert Attachement-->' +att);
        Test.stopTest();        
        
    /* Commented for R-21990
        //Inserting a new Account
        Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        System.assertEquals(acc.name,'TestClassAccount');
        Account b = new Account(Name='Apex Test Sold To Account 2', Type = 'Prospect', BillingStreet = '123 Main St', BillingCity = 'Anywhere', BillingState='California', BillingCountry='United States', BillingPostalCode='99999', ShippingStreet = '123 Main St', ShippingCity = 'Anywhere', ShippingState='KS', ShippingPostalCode='99999',Phone='510-555-1212' );
        insert b;
        //Inserting a new Contact
        Contact ct = new Contact(FirstName = 'SMax', LastName = 'EmailAttachTesting', Email = 'ps.servicemax@gmail.com', MailingStreet='123 Main Street', MailingCity='Somewhere', MailingState='California', MailingCountry='United States', MailingPostalCode='99999'); 
        ct.AccountId = b.Id;
        ct.Email = 'sateesh.kumar@ge.com';
        insert ct;
        //Inserting a new Service Max User
        User usr  = new User(FirstName = 'Smaxemail', LastName = 'Tester', Email='smax.emailattach@tester.com.test1', Alias = 'aematt2', username = 'smax.send.email.attach@tester.com',
                             CommunityNickname = 'aematt2', TimeZoneSidKey = 'America/Los_Angeles', LocaleSidKey = 'en_US',
                             ProfileId = UserInfo.getProfileId(), EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', EmployeeNumber = '123456');
        insert usr;          
        SVMXC__Site__c site  = new SVMXC__Site__c(NAme = 'test', SVMXC__Account__c = acc.Id);
        insert site;
        SVMXC__Service_Group__c team  = new SVMXC__Service_Group__c();
        team.Name = 'West';
        team.SVMXC__Active__c=true;
        
        insert team;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Company__c = acc.Id;
        wo.SVMXC__Order_Status__c = 'New';
        wo.SVMXC__Order_Type__c='Field Service';
        wo.SVMXC__Street__c = '16260 Monterey St.';
        wo.SVMXC__City__c = 'Morgan Hill';
        wo.SVMXC__State__c = 'California';
        wo.SVMXC__Zip__c = '95037';
        wo.SVMXC__Country__c = 'USA';
        wo.SVMXC__Contact__c = ct.Id;
        wo.Email_Service_Report__c = 'sateesh.kumar@ge.com';  
        wo.Send_Service_Report_to_Customer__c = true;    
        wo.SVMXC__Site__c = site.Id;
        wo.SVMXC__Priority__c = 'Medium';        
        wo.RecordTypeId = NewSmax;
        system.debug ('WO fields are ' +  ' ' +wo.SVMXC__Company__c + ' ' + wo.SVMXC__Contact__c + ' ' +wo.SVMXC__Site__c);       
        insert wo;
        
        Test.StartTest();
      /*  
        Attachment attach=new Attachment();     
        attach.Name=wo.id+'WO_ServiceReport-Create_Service_Report' + wo.Id + '.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=wo.id;
        insert attach;
        
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:wo.id];
        System.assertEquals(1, attachments.size());         
        
        SVMXC__Service_Order__c wo2 = new SVMXC__Service_Order__c(SVMXC__Company__c = acc.Id);
        wo2.SVMXC__Order_Status__c = 'New';
        wo2.SVMXC__Order_Type__c='Field Service';
        wo2.SVMXC__Street__c = '16260 Monterey St.';
        wo2.SVMXC__City__c = 'Morgan Hill';
        wo2.SVMXC__State__c = 'California';
        wo2.SVMXC__Zip__c = '95037';
        wo2.SVMXC__Country__c = 'USA';
        wo2.Email_Service_Report__c = 'noemail@outlook.com';
        wo2.RecordTypeId = NewSmax;
        
        wo2.SVMXC__Site__c = site.Id;
        wo2.SVMXC__Priority__c = 'Medium';
        insert wo2;
        
        Attachment attach3=new Attachment();    
        attach3.Name='Create_Service_Report.pdf';
        Blob bodyBlob3=Blob.valueOf('Unit Test Attachment Body');
        attach3.body=bodyBlob3;
        attach3.parentId=wo2.id;
        insert attach3;   
   */   
    
    }
}