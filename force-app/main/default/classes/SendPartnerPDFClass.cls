public class SendPartnerPDFClass
{   
    @InvocableMethod
    public static void sendPDF(List<Id> channelAppId)
    {   
        Blob contentPDF;
        Id principleContactId ;
        Id mailTemplateId;
        List<PRM_Channel_Appointment_GE_OG__c> chApp = new List<PRM_Channel_Appointment_GE_OG__c>();
        List<String> toAddresses = new List<String>();
        List<String> CcAddresses = new List<String>();
        chApp = [Select Id,PRM_Account_Name__c,PRM_Account_Name__r.name,Owner.Email,PRM_Primary_Sales_Channel_Manager__r.Email,PRM_Validation_Sent_Date__c,PRM_Partner_Approval__c,PRM_Principal_Contact__r.Email,PRM_Commercial_Manager__c,PRM_Commercial_Manager__r.Email,LastModifiedBy.TimeZoneSidKey From PRM_Channel_Appointment_GE_OG__c Where Id =: channelAppId[0]];
        
        Pagereference Page = new Pagereference('/apex/PRM_ChannelAppointmentPDF');  
        Page.getParameters().put('Id',ChApp[0].id);
        if(!test.isrunningtest())
        {
            contentPDF = Page.getContentAsPDF();
        } else
        {
            contentPDF = Blob.valueOf('att');
        }
        
        
        String fileName  = 'Channel  Appointment  for '+ ChApp[0].PRM_Account_Name__r.name + '-' +  System.now().format('yyyy-MMM-dd hh:mm a');
        
        List<EmailServicesAddress> esa=new List<EmailServicesAddress>([select localpart,EmailDomainName from EmailServicesAddress where localpart='channelappointmentapproval']);
        
        String replyEmail = esa[0].localpart+'@'+esa[0].EmailDomainName;
        
        if(chApp[0].PRM_Principal_Contact__r.Email != null && !String.isBlank(chApp[0].PRM_Principal_Contact__r.Email))
        {
            toAddresses.add(chApp[0].PRM_Principal_Contact__r.Email);
            principleContactId =  chApp[0].PRM_Principal_Contact__r.Id ;
        }
        
        DateTime d = system.now();   
        String timeStr = d.format('EEEE, MMMMM dd, yyyy hh:mm:ss a', ChApp[0].LastModifiedBy.TimeZoneSidKey); 
        Attachment objAttachement = new Attachment();
        objAttachement.Name=filename+'.pdf' ;
        objAttachement.Body= contentPDF;
        objAttachement.ContentType='application/pdf';
        objAttachement.ParentId=ChApp[0].id; 
        insert objAttachement;
        
        for(EmailTemplate mailTemplate : [select Id,Name from EmailTemplate where Name=: 'GE_PRM_Partner_Validation_NEW'] )
        {
            if(mailTemplate.Name == 'GE_PRM_Partner_Validation_NEW')
            {
                mailTemplateId = mailTemplate.id;
            }
        }
        
        if(!toAddresses.isEmpty())
        {
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName(fileName+'.pdf');        
            attach.Body = contentPDF;
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            mail.setTargetObjectId(principleContactId);
            
            if(ChApp[0].PRM_Primary_Sales_Channel_Manager__r.Email!=null)
            {
                CcAddresses.add(ChApp[0].PRM_Primary_Sales_Channel_Manager__r.Email);
            }  
            if(ChApp[0].PRM_Commercial_Manager__r.Email !=null)
            {
                CcAddresses.add(ChApp[0].PRM_Commercial_Manager__r.Email);
            }   
            mail.setccAddresses(CcAddresses);
            mail.setTemplateId(mailTemplateId);
            mail.SetWhatId(ChApp[0].Id); 
            mail.setReplyTo(replyEmail);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });    
            mail.setsaveAsActivity(false);    
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            ChApp[0].PRM_Validation_Sent_Date__c = System.Today();
            ChApp[0].PRM_Partner_Approval__c = 'Sent to CP';
             
        }
        
        
        update chApp;
        
        
    }
}