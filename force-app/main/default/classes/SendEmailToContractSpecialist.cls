public class SendEmailToContractSpecialist
{
    @InvocableMethod
    public static void sendEmail(List<Id> parentId)
    {  
        //List<PRM_Channel_Appointment_Approver__c> caaList = new List<PRM_Channel_Appointment_Approver__c>();
        List<ID> assigneeID = new List<ID>();
        List<String> assigneeEmails = new List<String>();
        /*caaList = [Select Id,Name,PRM_Channel_Appointment_Parent__c From PRM_Channel_Appointment_Approver__c Where PRM_Channel_Appointment_Parent__c IN : parentId];*/
        
        List<PermissionSetAssignment> userID = [SELECT AssigneeId,Assignee.Email FROM PermissionSetAssignment WHERE PermissionSet.Name = 'PRM_Contract_Specialist_Permission_Set'];
        
        for(PermissionSetAssignment p : userID)
        {
            assigneeEmails.add(p.Assignee.Email);
            assigneeID.add(p.AssigneeId);
            
        }
        
        EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = 'Contract_Specialist'];
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
       // Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
       /* message.setToAddresses(assigneeID);
        message.TargetObjectId= assigneeID[0];
        system.debug('To Address---> '+message.TargetObjectId);
        message.TemplateId = emailTemp.Id;
        system.debug('Email Template---> '+message.TemplateId);
        message.setSaveAsActivity(false);
        message.setTreatTargetObjectAsRecipient(false);
        message.WhatId = parentId[0];
        mails.add(message);     
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        system.debug('result--->'+results); */
        for(Id userIds : assigneeID){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.TargetObjectId = userIds;
            message.WhatId = parentId[0];
            //message.optOutPolicy = 'SEND';
            message.setSaveAsActivity(false);
            message.TemplateId = emailTemp.Id;
            mails.add(message);     
        }
         Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        if (results!= null && !results.isEmpty()  && results[0].success) {
            System.debug('The email was sent successfully.');
        } 
                
          } 
}