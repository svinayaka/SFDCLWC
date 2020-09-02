/*
    Class/Trigger Name     : AttachmentsToContentHandler_Test
    Purpose/Overview       : 
    Scrum Team             : Transformation - OPPTY MGMT
    Requirement Number     : R-23281
    Author                 : Mohit Maheshwari
    Created Date           : 12-Jan-2016
    Used For               : AttachmentsToContentHandler
    */ 

    @isTest
    public class AttachmentsToContentHandler_Test{
        @testsetup
        static void createRecord(){

            //creating 'Country Region Mapping' for 'INDIA'
            Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
            insert objcustom;

            // Create Member Account
            Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
            system.assertEquals('TestAccount Member',acc1.Name);

            //Createing an Account 
            Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
            system.assertEquals('TestAccount Relation',acc.Name);

            //Creating an Opportunity
            Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
            system.assertEquals('Testopportunity',opp.Name);
    }
    
    // test method for 0 attachment  
    static testMethod void testHandleInboundEmailNoAttachment(){
        test.startTest();
        
            Opportunity objOpp = [Select ID, Name from Opportunity];
            system.assertEquals('Testopportunity',objOpp.Name);
            
            // Create a new email, envelope object and Attachment
            Messaging.InboundEmail email = new Messaging.InboundEmail();
            Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
            
            email.subject = objOpp.ID;
            env.fromAddress = 'user@testge.com';
            
            // call the class and test it with the data in the testMethod
            AttachmentsToContentHandler attachHandler = new AttachmentsToContentHandler();
            attachHandler.handleInboundEmail(email, env);
        
        test.stopTest();
        
    }
    
    // to call email service method with more than 1 attachment
    public static testMethod void testHandleInboundEmailMoreAttachment(){
        Test.startTest();
            
            Opportunity objOpp = [select id, Name from Opportunity];
            system.assertEquals('Testopportunity',objOpp.Name);
            
            // Create a new email, envelope object and Attachment
            Messaging.InboundEmail email = new Messaging.InboundEmail();
            Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
            
            Messaging.InboundEmail.BinaryAttachment attach1 = new Messaging.InboundEmail.BinaryAttachment();
            Messaging.InboundEmail.BinaryAttachment attach2 = new Messaging.InboundEmail.BinaryAttachment();
            
            email.subject = objOpp.ID;
            env.fromAddress = 'user@testge.com';
            
            attach1.body = blob.valueOf('test');
            attach1.fileName = 'Some File.txt';
            attach1.mimeTypeSubType = 'text/plain';
            
            attach2.body = blob.valueOf('test');
            attach2.fileName = 'Some File.txt';
            attach2.mimeTypeSubType = 'text/plain';
            
            email.BinaryAttachments = new Messaging.InboundEmail.BinaryAttachment[]{attach1, attach2};
            
            AttachmentsToContentHandler attachHandler = new AttachmentsToContentHandler();
            attachHandler.handleInboundEmail(email, env);
            
        Test.stopTest();
    }

    // to call email service method with 1 attachment
    public static testMethod void testHandleInboundEmailOneAttachment(){
        Test.startTest();
            
            Opportunity objOpp = [select id, Name from Opportunity];
            system.assertEquals('Testopportunity',objOpp.Name);
            
            // Create a new email, envelope object and Attachment
            Messaging.InboundEmail email = new Messaging.InboundEmail();
            Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
            
            Messaging.InboundEmail.BinaryAttachment attach1 = new Messaging.InboundEmail.BinaryAttachment();
            email.BinaryAttachments = new Messaging.InboundEmail.BinaryAttachment[]{attach1};
            
            email.subject = objOpp.ID;
            env.fromAddress = 'user@testge.com';
            
            attach1.body = blob.valueOf('test');
            attach1.fileName = 'Some File.txt';
            attach1.mimeTypeSubType = 'text/plain';
            
            AttachmentsToContentHandler attachHandler = new AttachmentsToContentHandler();
            attachHandler.handleInboundEmail(email, env);
            
        Test.stopTest();
    }
}