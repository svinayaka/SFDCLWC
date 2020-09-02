/************
Class Name          : PRM_Channel_Appointment_Class 
Used Where ?        : This class is used for CP S&L Acknowledgement
Purpose/Overview    : for storing processing channel appointment details
Functional Area     : PRM 
Author              : 
Created Date        : 
Test Class Name     : PRM_Channel_Appointment_Class_Test
Change History - 
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
************/
public class PRM_Channel_Appointment_Class {
    @InvocableMethod(label='send S&L Policy emails' description='send mail to principle contact') 
    //Method to send S&L Policy emails
    public static void sendSLPolicyEmail(List<ID> channelAppId){
        Id mailTemplateId ;
        String mailid;
        List<User> ccList;
        List<Id> usrID = new List<Id>();
        try{
        Integer totalPDF=[select count() from Attachment where ParentId=:channelAppId and Name like 'Channel%'];
        String docName = 'BH Channel Partner Integrity Training Deck';
        String resourceName = 'BH_Channel_Partner_Integrity_Training_Deck';       
        StaticResource res  = [SELECT Name, NamespacePrefix, body, description,contenttype,SystemModStamp FROM StaticResource WHERE Name = :resourceName];
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType(res.contentType);
        attach.setFileName(res.description+'.pdf');
        attach.setInline(false);
        Blob tempBlb = res.Body;
        attach.setBody(tempBlb); 
        List<EmailServicesAddress> esa=new List<EmailServicesAddress>([select localpart,EmailDomainName from EmailServicesAddress where localpart='SendSLPolicyEmailService']);        
        System.debug('&&&&&&&&&&&&&&&&&&&'+esa);
        //Responses are forwarded to ReplyEmail address.
        String ReplyEmil=Test.isRunningTest() || esa.isempty()?'test@test.ge.com':esa[0].localpart+'@'+esa[0].EmailDomainName;
        List<String> toAddresses=new List<String>();
        List<String> ccAddresses=new List<String>();
        List<EmailTemplate> lstEmailTemplates = [select Id,Name from EmailTemplate where Name=: 'GE_PRM_OG_PDF_Header'];
        for(EmailTemplate mailTemplate : lstEmailTemplates )
        {
            if(mailTemplate.Name == 'GE_PRM_OG_PDF_Header')
            {
                mailTemplateId = mailTemplate.id;
            }
        } 
        PRM_Channel_Appointment_GE_OG__c CA= [select Id,
             PRM_Commercial_Account__c,
             PRM_Principal_Contact__r.Email,
             PRM_Account_Name__c,
             PRM_Address__c,
             PRM_City__c,
             PRM_Postal_Code__c,
             PRM_Country__c,
             PRM_Principal_Contact__c,
             PRM_Phone__c,LastModifiedBy.TimeZoneSidKey,
             PRM_Partner_Integrity_Training_Status__c,
            /* GE_PRM_Account_Email__c,
             GE_PRM_I_Agree_With_This_Statement__c,
             GE_PRM_Partner_Name__c,
             GE_PRM_Last_Spirit_Letter_signed_date__c,
             GE_PRM_Title__c,GE_PRM_Prior_performance_rating__c,*/  
             PRM_Commercial_Manager__c,
             PRM_Primary_Sales_Channel_Manager__c,
             PRM_Primary_Sales_Channel_Manager__r.Email,
             PRM_Commercial_Manager__r.Email
             from PRM_Channel_Appointment_GE_OG__c where Id =:channelAppId]; 
        if(CA.PRM_Principal_Contact__r.Email!='' && CA.PRM_Principal_Contact__r.Email!=null)
        {
            toAddresses.add(CA.PRM_Principal_Contact__r.Email);
            mailid = CA.PRM_Principal_Contact__c;
            usrID.add(CA.PRM_Primary_Sales_Channel_Manager__c);
            usrID.add(CA.PRM_Commercial_Manager__c);
            
            ccList = [select Email from User where id IN :usrID];
        }
        else
        {    
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No mail id available to send email to');
            ApexPages.addMessage(myMsg);
            //return null;
             
        }
        if(toAddresses.size()>0)
        {
            Messaging.EmailFileAttachment att = new Messaging.EmailFileAttachment();
            //att.setContentType('application/pdf');
            att.setFileName(res.description);  
            Blob tmpBlb = res.Body;
            att.setBody(tmpBlb);
            //att.Body = res.Body;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();     
            //mail.setToAddresses(toAddresses);
            if(CA.PRM_Principal_Contact__r.Email!='' && CA.PRM_Principal_Contact__r.Email!=null)
            {  
                mail.setTargetObjectId(mailid);
            }
            System.debug('&&&&&&&&&&&&&&&&&&&'+ReplyEmil);
            mail.setReplyTo(ReplyEmil);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { att }); 
            mail.setTemplateId(mailTemplateId);
            mail.SetWhatId(CA.Id);    
            if(ccList.size()!=0)
            {
                for(User u :ccList)
                {
                    ccAddresses.add(u.Email);
                    mail.setccAddresses(ccAddresses);
                }
            }
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        CA.PRM_Partner_Integrity_Training_Status__c='Sent to CP';
        CA.PRM_Integrity_Training_Sent_Date__c=system.today();
        update CA;
        
            
        }catch(Exception e){
            System.debug('Exception occured in Line number : '+e.getLineNumber());
            System.debug('cause of the Exception : '+e.getCause());
            System.debug('exception Message : '+e.getMessage());
            
        }
        }
     
}