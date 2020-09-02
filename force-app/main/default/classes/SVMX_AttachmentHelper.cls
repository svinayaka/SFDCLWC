/*

  Custom attachment work order service report email functionality based loosely on Dave Avery's custom code.
  
*/

public without sharing class SVMX_AttachmentHelper {



    public static void emailServiceWorkOrder(List<Attachment> newList)
    {
        Boolean foundUser = false;        
        String emailAddress = Label.Work_Order_Attachment_Email_Address;
        List<User> uList =  [select id, Email from User where email = :emailAddress limit 1];
        User u = null;
        List<Messaging.SingleEmailMessage> messagesList = new List<Messaging.SingleEmailMessage>(); 
        Set<String> emailSet = new Set<String>();
        Map<String, Contact> contactMap = new Map<String, Contact>();
        List<SVMXC__Service_Order__c> woModifiedList = new List<SVMXC__Service_Order__c>();
        
		String inclusiveRecordTypesLabel = Label.Work_Order_Attachment_Record_Types;
		List<String> listTokenStrings= inclusiveRecordTypesLabel.split(',', 0);
		
		Set<String> inclusiveRecordTypes = new Set<String>();
		for(String strToken:listTokenStrings)
		{
			inclusiveRecordTypes.add(strToken);
		}
        
        if (uList != null && uList.size() > 0)
        {
            foundUser = true;
            u = uList.get(0);
        }       
        
        // Load email template used for all e-mails.
        EmailTemplate emailTemplateBase = [Select Id, Name, Subject, Body, HtmlValue from EmailTemplate where DeveloperName = 'Work_Order_Service_Report_Email' limit 1];
        
        Set<Id> woIDs = new Set<Id>();
        for (Attachment a : newList)
        {
            if (a.ParentId.getSobjectType() == SVMXC__Service_Order__c.SobjectType &&
                a.Name != null && a.Name.contains(a.ParentId) && a.Name.contains('.pdf'))
                {
                    woIDs.add(a.ParentId);
                }
        }
        
        
        Map<Id, SVMXC__Service_Order__c> woMap = new Map<Id, SVMXC__Service_Order__c>([Select Id, Name, Email_Service_Report__c, Send_Service_Report_to_Customer__c from SVMXC__Service_Order__c where Id in :woIDs and RecordType.Name in :inclusiveRecordTypes]);
        
        for (SVMXC__Service_Order__c so : woMap.Values())
        {
            if (so.Email_Service_Report__c != null)
                emailSet.add(so.Email_Service_Report__c);
                
        }
        
        List<Contact> contactList = [Select Id, Email from Contact where Email in :emailSet];
        
        if (contactList != null && contactList.size() >0)
        {
            for (Contact co : contactList)
            {
                contactMap.put(co.Email, co);
            }
        }
        
        for (Attachment a : newList)
        {
            
            if (a.ParentId != null && a.ParentId.getSobjectType() == SVMXC__Service_Order__c.SobjectType &&
                a.Name != null && a.Name.contains(a.ParentId) && a.Name.contains('.pdf') && woMap != null && woMap.get(a.ParentId) != null)  //modified to check for only PC record types
            {
                
               
                SVMXC__Service_Order__c workOrder = woMap.get(a.ParentId);
                if (workOrder != null)
                {   
                    
                    //List<String> emailAddresses = new List<String>();
                    // Use information in the most recent Attachment to populate the email message attachment info.
                    Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
                    emailAttachment.setFileName(a.Name);
                    emailAttachment.setBody(a.Body);
                    
                    // Construct the Email Message
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.setTemplateId(emailTemplateBase.Id);
                    if (contactMap.get(workOrder.Email_Service_Report__c) != null)
                        message.setTargetObjectId(contactMap.get(workOrder.Email_Service_Report__c).Id);
                    else
                        message.setTargetObjectId(Label.Default_Contact_ID_for_Work_Order_Emails);  
                    message.setFileAttachments(new Messaging.EmailFileAttachment[] { emailAttachment });
                    message.setSaveAsActivity(false);
                    message.setWhatId(a.ParentId);
                    
                    // Send the emails in a transaction, then roll it back in order to use the template with external email addresses
                    // This will count against DML limits so we must be certain that an iPad/offline user will sync (insert/update)
                    // no more than 75 Service Report attachments in a single sync.
                    Savepoint sp = Database.setSavepoint();
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message } );
                    Database.rollback(sp);
                    
                    if (foundUser)
                    {
                        Messaging.SingleEmailMessage message1 = new Messaging.SingleEmailMessage();
                        message1.setOrgWideEmailAddressId(Label.Org_Wide_Email_Address_Record);
                        message1.setTemplateId(emailTemplateBase.Id);
                        message1.setTargetObjectId(u.Id);
                        message1.setFileAttachments(new Messaging.EmailFileAttachment[] { emailAttachment });
                        message1.setSaveAsActivity(false);
                        messagesList.add(message1);
                    }
                    else if (emailAddress != null)
                    {
                        Messaging.SingleEmailMessage message1 = new Messaging.SingleEmailMessage();
                        message1.setOrgWideEmailAddressId(Label.Org_Wide_Email_Address_Record);
                        message1.setToAddresses(new String[] {emailAddress}); // Requires custom field on WO
                        message1.setFileAttachments(new Messaging.EmailFileAttachment[] { emailAttachment } );
                        message1.setSubject(message.getSubject());
                        message1.setPlainTextBody(message.getPlainTextBody());
                        message1.setHtmlBody(message.getHTMLBody());
                        message1.setSaveAsActivity(false);
                        messagesList.add(message1);
                    }
                    
                    if (workOrder.Email_Service_Report__c != null && workOrder.Send_Service_Report_to_Customer__c == true)
                    {
                        Messaging.SingleEmailMessage message2 = new Messaging.SingleEmailMessage();
                        message2.setOrgWideEmailAddressId(Label.Org_Wide_Email_Address_Record);
                        message2.setToAddresses(new String[] {workOrder.Email_Service_Report__c}); // Requires custom field on WO
                        message2.setFileAttachments(new Messaging.EmailFileAttachment[] { emailAttachment } );
                        message2.setSubject(message.getSubject());
                        message2.setPlainTextBody(message.getPlainTextBody());
                        message2.setHtmlBody(message.getHTMLBody());
                        message2.setSaveAsActivity(false);
                        messagesList.add(message2);
                    }
                    //else if (workOrder.Send_Service_Report_to_Customer__c == false)
                    //{
                    //  workOrder.Send_Service_Report_to_Customer__c = true;
                    //  woModifiedList.add(workOrder);
                    //}
                }
            }
        }
        
        if (messagesList.size() > 0)
            Messaging.sendEmail(messagesList);
        
    }
    
    
    
}