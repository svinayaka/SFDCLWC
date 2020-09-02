@isTest
public class PRM_Send_SL_Policy_Test {

    static TestMethod void partnerTestMethod(){    
    //Test.startTest();   
        Account Acc1= new Account();
        Acc1.Name='Test Acc2';
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc1.GE_HQ_Country_Code__c = 'AT'; 
        insert Acc1;
        //Account Acc1 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc2');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp1; 
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        email.subject = 'Create Contact';
        email.fromAddress = 'someaddress@email.com';
        email.plainTextBody = 'approve email body\n2225256325\nTitle';
        
        
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'textfile.txt';
        attachment.mimeTypeSubType = 'text/plain';
    
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
        
        email.subject=prm_chApp1.id;
        PRM_Send_SL_Policy testInbound=new PRM_Send_SL_Policy();
        testInbound.handleInboundEmail(email, env);
        email.plainTextBody = 'modify email body\n2225256325\nTitle';
        testInbound.handleInboundEmail(email, env);
    }
}