/*
Class Name     : SendMailToOptyTeam_Helper
Purpose/Overview       : Whenever new Contract has beed added to the Opportunity , the Users will get email notification.
Scrum Team             : 
Created Date           : 20/11/2018
Modified Date          : 
Modified By            : Megha
Test Class Name        : SendMailToOptyTeam_Helper
Code Coverage          : 100%
*/
public class SendMailToOptyTeam_Helper {
    public void EmailNotificationonOptyAndAsset(Map<Id, List<Id>> MapListOfUsers){
        System.debug(LoggingLevel.Info,'Sending email to Opportunity:');
        EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = 'Contract_Linked_to_Opportunity'];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(Id optyId : MapListOfUsers.keySet()){
            for(Id userId : MapListOfUsers.get(optyId)){
                System.debug(LoggingLevel.Info,'Sending email to Opportunity: ' + optyId + ' to User: ' + userId);
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.TargetObjectId = userId;
                message.WhatId = optyId;
                message.optOutPolicy = 'FILTER';
                message.setSaveAsActivity(false);
                message.TemplateId = emailTemp.Id;
                mails.add(message);     
            }
            
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                         + results[0].errors[0].message);
        }
    }
    
     public void EmailNotificationonOptyandnewcontract(Map<Id, List<Id>> MapListOfUsers){
        System.debug(LoggingLevel.Info,'Sending email to Opportunity:');
        EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = 'Contract_Added_to_oppty'];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(Id optyId : MapListOfUsers.keySet()){
            for(Id userId : MapListOfUsers.get(optyId)){
                System.debug(LoggingLevel.Info,'Sending email to Opportunity: ' + optyId + ' to User: ' + userId);
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.TargetObjectId = userId;
                message.WhatId = optyId;
                message.optOutPolicy = 'FILTER';
                message.setSaveAsActivity(false);
                message.TemplateId = emailTemp.Id;
                mails.add(message);     
            }
            
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                         + results[0].errors[0].message);
        }
    }
    
    
    
}