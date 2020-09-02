/*
Class/Trigger Name     : ProjectTeamMember_Helper_GE_OG    
Purpose/Overview       : Used for Email Notification to project team member whenever new project team member is added 
Scrum Team             : PROJECT MGMT
Created Date           : 28/June/2017
Last Modified Date     : 10/Jan/2018
Last Modified By       : Sonali Rathore
Test Class Name        : ProjectTriggerHandlerTest_GE_OG
*/
Public class ProjectTeamMember_Helper_GE_OG{
    
    public void EmailNotificationToProjTeamMemebrs(Map<Id, List<Id>> MapListOfUsers,List<Project_ge_og__c> ListProjectTeamMember){
       
        EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = 'Project_Team_notification_on_new_VF'];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(Id ProjectId : MapListOfUsers.keySet()){
            for(Id UserId : MapListOfUsers.get(ProjectId)){
                System.debug('Sending email to Project: ' + ProjectId + ' to User: ' + UserId);
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.TargetObjectId = UserId;
                message.WhatId = ProjectId;
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