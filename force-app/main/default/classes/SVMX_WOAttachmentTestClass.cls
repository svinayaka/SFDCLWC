/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(SeeAllData=true)
private class SVMX_WOAttachmentTestClass {

    private static SVMXC__Service_Group__c team = null;
    private static User usr = null;
    private static SVMXC__Service_Group_Members__c tech = null;
    private static SVMXC__Site__c site = null;
    private static SVMXC__Installed_Product__c ip = null;
    private static Account a = null;
    private static Contact contact = null;
    
    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        String CMFApprovedAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();

        a = new Account(Name='Apex Test Sold To Account 1', Type = 'Customer',RecordtypeId = CMFApprovedAccrecType, BillingStreet = '123 Main St', BillingCity = 'Anywhere', BillingState='California', BillingCountry='United States', BillingPostalCode='99999', ShippingStreet = '123 Main St', ShippingCity = 'Anywhere', ShippingState='KS', ShippingPostalCode='99999', Phone='510-555-1212', Classification__c='Strategic' );
        Account b = new Account(Name='Apex Test Sold To Account 2',RecordtypeId = CommAccrecType , Type = 'Prospect', BillingStreet = '123 Main St', BillingCity = 'Anywhere', BillingState='California', BillingCountry='United States', BillingPostalCode='99999', ShippingStreet = '123 Main St', ShippingCity = 'Anywhere', ShippingState='KS', ShippingPostalCode='99999',Phone='510-555-1212',Classification__c='Strategic' );
        insert a;
        insert b;
        
        setup(a, b);

        system.debug ('WO IDs are' + a.Id + '|' + site.Id);
                
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Company__c = a.Id;
        wo.SVMXC__Order_Status__c = 'New';
        wo.SVMXC__Order_Type__c='Field Service';
        wo.SVMXC__Street__c = '16260 Monterey St.';
        wo.SVMXC__City__c = 'Morgan Hill';
        wo.SVMXC__State__c = 'California';
        wo.SVMXC__Zip__c = '95037';
        wo.SVMXC__Country__c = 'USA';
        wo.SVMXC__Contact__c = contact.Id;
        wo.Email_Service_Report__c = 'obama@whitehouse.com';  
        wo.Send_Service_Report_to_Customer__c = true;    
        wo.SVMXC__Site__c = site.Id;
        wo.SVMXC__Priority__c = 'Medium';
        RecordType rt1 = [select id,name from recordtype where sObjectType = 'SVMXC__Service_Order__c' and Name = 'PC' limit 1];
        wo.RecordTypeId = rt1.Id;
        system.debug ('WO fields are ' +  ' ' +wo.SVMXC__Company__c + ' ' + wo.SVMXC__Contact__c + ' ' +wo.SVMXC__Site__c);       
        insert wo;
        
        Test.StartTest();
 
        /*Attachment attach=new Attachment();     
        attach.Name=wo.id+'WO_ServiceReport-Create_Service_Report' + wo.Id + '.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=wo.id;
        insert attach;
        
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:wo.id];
        System.assertEquals(1, attachments.size()); 
        */
        
        Test.stopTest();
        
        SVMXC__Service_Order__c wo2 = new SVMXC__Service_Order__c(SVMXC__Company__c = a.Id);
        wo2.SVMXC__Order_Status__c = 'New';
        wo2.SVMXC__Order_Type__c='Field Service';
        wo2.SVMXC__Street__c = '16260 Monterey St.';
        wo2.SVMXC__City__c = 'Morgan Hill';
        wo2.SVMXC__State__c = 'California';
        wo2.SVMXC__Zip__c = '95037';
        wo2.SVMXC__Country__c = 'USA';
        wo2.Email_Service_Report__c = 'noemail@outlook.com';
        wo2.RecordTypeId = rt1.Id;
        
        wo2.SVMXC__Site__c = site.Id;
        wo2.SVMXC__Priority__c = 'Medium';
        insert wo2;
 
        Attachment attach3=new Attachment();    
        attach3.Name='Create_Service_Report.pdf';
        Blob bodyBlob3=Blob.valueOf('Unit Test Attachment Body');
        attach3.body=bodyBlob3;
        attach3.parentId=wo2.id;
        insert attach3;
        
        
    }
    
    static void setUp(Account acct, Account b)
    {
        
         contact = new Contact(FirstName = 'SMax', LastName = 'EmailAttachTesting', Email = 'ps.servicemax@gmail.com',GE_OG_Contact_Audience__c='Technical Support', MailingStreet='123 Main Street', MailingCity='Somewhere', MailingState='California', MailingCountry='United States', MailingPostalCode='99999'); 
         contact.AccountId = b.Id;
        contact.Email = 'obama@whitehouse.com';
        contact.GE_OG_Country__c='United States';
        insert contact;
        
        
        site = new SVMXC__Site__c(NAme = 'test', SVMXC__Account__c = acct.Id);
        insert site;
        
        //RecordType rt1 = [Select Id from RecordType where sObjectType='SVMXC__Service_Group__c' and DeveloperName='Technician' limit 1];
        
        team = new SVMXC__Service_Group__c();
        team.Name = 'West';
        team.SVMXC__Active__c=true;

        insert team;
        
        usr = new User(FirstName = 'Smaxemail', LastName = 'Tester', Email='smax.emailattach@tester.com.test1', Alias = 'aematt2', username = 'smax.send.email.attach@tester.com',
                            CommunityNickname = 'aematt2', TimeZoneSidKey = 'America/Los_Angeles', LocaleSidKey = 'en_US',
                            ProfileId = UserInfo.getProfileId(), EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', EmployeeNumber = '123456');
        insert usr;
        
        
        
    }
   

}