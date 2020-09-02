/*
Class Name             : AssetTeamHelper_GE_OG
Purpose/Overview       : Whenever new team member has beed added to the team , the team member will get email notification
Scrum Team             : 
Created Date           : 20/11/2018
Modified Date          : 
Modified By            : Harsha C
Test Class Name        : 
Code Coverage          : 
*/
public class AssetTeamHelper_GE_OG {
    public void EmailNotificationToAssetTeamMemebrs(Map<Id, List<Id>> MapListOfUsers,Set<BHGE_Asset_Team_ge_og__c> ListAssetTeamMember){
        System.debug('*************MapListOfUsers'+MapListOfUsers);
        EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = 'Asset_Team_notification_on_new_VF'];
        List<Id> toAddress = new List<Id>();
        System.debug('****************emailTemp *********'+emailTemp ); 
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        
        for(Id assetId : MapListOfUsers.keySet()){
            for(Id userId : MapListOfUsers.get(assetId)){
                System.debug('Sending email to Project: ' + assetId + ' to User: ' + userId);
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.TargetObjectId = userId;
                //message.setToAddresses(toAddress);
                message.WhatId = assetId;
                // message.WhatId = 'aAu1H000000bmip';
                message.optOutPolicy = 'FILTER';
                message.setSaveAsActivity(false);
                message.TemplateId = emailTemp.Id;
                mails.add(message);     
                System.debug('****************message*********'+message);
            }
            
        }
        System.debug('****************mails*********'+mails);
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                         + results[0].errors[0].message);
        }
    }
}