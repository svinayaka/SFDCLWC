/*
Test Code for Email Service Class GE_OG_PC_WOInboundEmailProcessor.
*/

@isTest(SeeAllData=true)
public class GE_OG_PC_WOInboundEmailProcessor_Test{
    public static testMethod void testWOInboundEmail(){
        
        GE_OG_PC_WOInboundEmailProcessor objconfirm = new GE_OG_PC_WOInboundEmailProcessor();
        User usr = new User(FirstName = 'Smaxemail', LastName = 'Tester', Email='smax.WOInboundEmailProcessor@ge.com', Alias = 'aematt2', username = 'smax.WOInboundEmailProcessor@ge.com',
                            CommunityNickname = 'aematt2', TimeZoneSidKey = 'America/Los_Angeles', LocaleSidKey = 'en_US',
                            ProfileId = UserInfo.getProfileId(), EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', EmployeeNumber = '1234567');
        insert usr;
        /*Account acc = new Account(Name='Test Email Service', BillingStreet = '123 Main St', BillingCity = 'Anywhere', BillingState='California', BillingCountry='United States', BillingPostalCode='99999', ShippingStreet = '123 Main St', ShippingCity = 'Anywhere', ShippingState='KS', ShippingPostalCode='99999', Phone='510-555-1212' );
        insert acc;
        SVMXC__Site__c site = new SVMXC__Site__c(NAme = 'test', SVMXC__Account__c = acc.Id);
        insert site;

        Case c=new Case(Subject='Test Email Service', SVMXC__Site__c=site.id);
        insert c;
        */
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        //wo.SVMXC__Company__c = acc.Id;
        wo.SVMXC__Order_Status__c = 'New';
        wo.SVMXC__Order_Type__c='Field Service';
        wo.SVMXC__Street__c = '16260 Monterey St.';
        wo.SVMXC__City__c = 'Morgan Hill';
        wo.SVMXC__State__c = 'California';
        wo.SVMXC__Zip__c = '95037';
        wo.SVMXC__Country__c = 'USA';
        wo.Email_Service_Report__c = 'avinash.poddar@ge.com';  
        wo.Send_Service_Report_to_Customer__c = true;    
        //wo.SVMXC__Site__c = site.Id;
        wo.SVMXC__Priority__c = 'Medium';
        RecordType rt1 = [select id,name from recordtype where sObjectType = 'SVMXC__Service_Order__c' and Name = 'PC' limit 1];
        wo.RecordTypeId = rt1.Id;
        insert wo;
        String woName=[Select ID, Name from SVMXC__Service_Order__c where ID=:wo.ID].Name;
        
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();        
         
        email.subject = woName+'.pdf'; //'WO-12345678.pdf';
        email.plainTextBody = 'Hello, this a test email body. for testing purposes only. Bye';
        email.fromAddress = usr.Email; //'avinash.poddar@ge.com';
        envelope.fromAddress = usr.Email; //'avinash.poddar@ge.com';
        
        objconfirm.handleInboundEmail(email, envelope);
        email.subject ='Test Exception';
        objconfirm.handleInboundEmail(email, envelope);
        
        email.subject = woName;
        Messaging.InboundEmail.BinaryAttachment binaryAttachment = new Messaging.InboundEmail.BinaryAttachment();
        binaryAttachment.Filename = woName+'.pdf'; //'WO-12345678.pdf';
        binaryAttachment.body = blob.valueOf('my attachment text');
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { binaryattachment };
        
        Messaging.InboundEmailResult result = objconfirm.handleInboundEmail(email, envelope);
        //System.assertEquals( result.success  ,true);
        //List<Attachment> att = [Select id, name from Attachment where name = :'test.pdf'];  //parentid = :testop.id and 
        //System.assertEquals(att[0].name, 'test.pdf');
    }
}