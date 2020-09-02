/*
Class/Trigger Name     : EmailToOpptyTeamMemebrs_GE_OG
Used Where ?           : Call From LastActivityDateOpportunity
Purpose/Overview       : Used for Email Notification to oppty team member and task invitees 
Scrum Team             : OPPTY MGMT
Requirement/Bug Number : 0000022672
Author                 : Gourav Anand
Created Date           : 18/Dec/2016
Last Modified By       : Sonali Rathore on 01/16/2018 as part of R-26325
Test Class Name        : LastActivityDateOpportunityTrg_Test    
Code Coverage          : 
*/

public without sharing class EmailToOpptyTeamMemebrs_GE_OG{
    
  /*  public void emailToOpptyTeamMemebrs(List<GE_ES_Request_Type__c> lstRequest){
        System.debug('------ Into EmailToOpptyTeamMemebrs_GE_OG.emailToOpptyTeamMemebrs() after Request Type insert:-------');                
        set<id> opptyIds = New set<id>();
        List<User> recipient = New List<User>();
        List<GE_ES_Request_Type__c> newRequestLst = new List<GE_ES_Request_Type__c>();
        set<id> ctvg = New Set<id>();
        ID dealPassportRecordTypeID = Schema.SObjectType.GE_ES_Request_Type__c.getRecordTypeInfosByName().get(System.Label.Deal_Passport_RequestType).getRecordTypeId();
        
        List<OpportunityTeamMember> teamMemberId = New List<OpportunityTeamMember>();   
        
        for(GE_ES_Request_Type__c objRequestType: lstRequest) {
            if(objRequestType.RecordTypeId == dealPassportRecordTypeID) {
                opptyIds.add(objRequestType.Opportunity__c);
                //whatIds.add(objRequestType.id);
                newRequestLst.add(objRequestType);
            }
        }
        
        if(opptyIds.size()>0)
            teamMemberId =[select id,userId,OpportunityId from OpportunityTeamMember where opportunityid in :opptyIds];
    
        for(OpportunityTeamMember otm:teamMemberId) {
            ctvg.add(otm.userId);
        }
        
        if(teamMemberId.size()>0) {
            recipient = [SELECT id,email FROM user where id in :ctvg];
            if(recipient.size()>0) {
                List <String> Addresses = new List<String>();
                List<Messaging.SingleEmailMessage> lstMails = new List<Messaging.SingleEmailMessage>();
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                EmailTemplate et = [SELECT id,body,subject FROM EmailTemplate WHERE developerName = 'GE_OG_TMS_Opportunity_Team_Members'];
                
                for(GE_ES_Request_Type__c RequestType: newRequestLst) {
                    if(RequestType.Opportunity__c == teamMemberId[0].opportunityId && RequestType.Name != null) {
                        for(integer i=0; i < recipient.size() ; i++) {
                            mail = new Messaging.SingleEmailMessage();
                            mail.saveAsActivity = false;
                            mail.setTemplateId(et.id);
                            String toTargetObjects = (string)recipient[i].Id;
                            system.debug('target object deb:'+toTargetObjects);
                            mail.setTargetObjectId(toTargetObjects);
                            mail.setWhatId(requestType.Id);
                            lstMails.add(mail);
                        }
                    }
                }
                if(lstMails.size() > 0 && !Test.isRunningTest())
                    Messaging.sendEmail(lstMails);
            }
        }
    }   
   */ 
    
  //Email to Oppty DM Team Members & Assignee on Task creation
  public void taskEmailToOpptyTeamMembers(List<Task> newListTask){
        System.debug('-----Entering into EmailToOpptyTeamMemebrs_GE_OG.emailToOpptyTeamMembers on Task creation------');
        List<id> opptyIds = new List<id>();
        List<id> accIds = new List<id>();
        List<id> taskIds = new List<id>();
        String whatName = '';
        List<id> opptyAccIds = new List<id>();
        List<id> opptyUserIds = new List<id>();
        List<id> opptyUserIdList = new List<id>();
        List<Task> taskList = new List<Task>();
        List<OpportunityTeamMember> opptyTeamMembers = New List<OpportunityTeamMember>();   
        List<AccountTeamMember> accTeamMembers = New List<AccountTeamMember>();   
        List<Id> assignedToIDs = new List<Id>();  
        List<Id> assignedToIDsone = new List<Id>(); 
        List<User> emailIDsListUsers = New List<User>();     
        List<String> emailIDsList = New List<String>();     
        List<Task_Relation_ge_og__c> taskInvitees = new List<Task_Relation_ge_og__c>();
      
        ID dealMacRecordType = schema.sObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeID();
      
        for(Task task: newListTask) {
            String status= task.Status;
            String dmRecType=task.RecordTypeId;
            String oldStatus='';
              String taskWhatID = task.WhatId ; 
              // Updated on 1/18/2017 R-26325- Notify only when assignee is not the creator
              if(task.RecordTypeId == dealMacRecordType && task.OwnerId != task.CreatedById) {
               assignedToIDs.add(task.OwnerId);
               //assignedToIDs.add(task.CreatedById);
               assignedToIDsone.add(task.OwnerId);
               
               assignedToIDsone.add(task.CreatedById);
               taskIds.add(task.Id);   
               taskList.add(task);
               //opptyName = [Select Name from Opportunity where Id  =: task.WhatId].Name ; 
              
                   if(task.Notification_Selection_ge_og__c && taskWhatID.startsWith('006')) {
                     opptyIds.add(task.WhatId); 
                   }else if(task.Notification_Selection_ge_og__c && taskWhatID.startsWith('001')) {
                     accIds.add(task.WhatId); 
                   }
               }
        }
      Map<Id,String> mUser = new Map<Id,String>();
      List<User> usrDet= new List<User>();
       usrDet = [Select Id,Full_Name__c from User where Id in :assignedToIDsone];
      for(User u:usrDet){
         mUser.put(u.Id,u.Full_Name__c);
      }
        
       if(taskIds.size()>0)
       whatName = [Select what.name from Task where Id  =:taskIds.get(0)].what.name;
      //Getting Assigned To IDs and Creator ID email addresses
      /*  if(assignedToIDs.size()>0){
            List<User> emailAssignedToIDs =[select Id, Email from User where Id in :assignedToIDs];
            for(User emailStr:emailAssignedToIDs) {
                emailIDsList.add(emailStr.Email);
            }
        }*/
      
      //Task Invitees email IDs
      if(taskIds.size()>0) {
        System.debug('-----Fetching Task Invitees on task creation1------');  
        taskInvitees = [Select Id, Task_ID_ge_og__c, Invitee_ID_ge_og__c from Task_Relation_ge_og__c where Task_ID_ge_og__c in :taskIds];
           System.debug('-----Fetching Task Invitees on task creation 2------');   
           if(taskInvitees !=null && taskInvitees.size()>0){
               for(Task_Relation_ge_og__c tRel:taskInvitees)  {
                    assignedToIDs.add(tRel.Invitee_ID_ge_og__c);
                   // emailIDsList.add(tRel.Invitee_ID_ge_og__c);
            }
         }
          
       }
       
      //Opportunity and Account Team User IDs
       if(opptyIds.size()>0){
            opptyTeamMembers =[select id,User.Email, userId,OpportunityId from OpportunityTeamMember where opportunityid in :opptyIds];
            for(OpportunityTeamMember otm:opptyTeamMembers) {
                assignedToIDs.add(otm.UserId);  
                //emailIDsList.add(otm.User.Email);
            }
        }else if(accIds.size()>0){
            accTeamMembers =[select id,User.Email, userId,AccountId from AccountTeamMember where AccountId in :accIds];
            for(AccountTeamMember acctm:accTeamMembers) {
                assignedToIDs.add(acctm.UserId);    
               // emailIDsList.add(acctm.User.Email);
            }
        }
       System.debug('-------============================>> Total assignedToIDs size='+assignedToIDs.size());
      System.debug('-------============================>> assignedToIDs'+assignedToIDs);
      //Fetching all email Ids based on all the assigned task users and team members 
      if(assignedToIDs.size()>0) {
                emailIDsListUsers = [Select Email from User where Id in :assignedToIDs];
           for(User usr:emailIDsListUsers){
               emailIDsList.add(usr.Email);
           }
                EmailTemplate emailTemp = [SELECT id,HTMLValue,body,subject FROM EmailTemplate WHERE developerName = 'Activity_DM_Notification_on_Task_Creation_or_Update'];
         System.debug('-------============================>> emailIDsList'+emailIDsList);
         System.debug('-------============================>> taskList'+taskList);
         System.debug('-------============================>> emailTemp'+emailTemp);
         System.debug('-------============================>> whatName'+whatName);
         System.debug('-------============================>> mUser'+mUser);
              sendEmailToUsers(emailIDsList, taskList, emailTemp, whatName,mUser); 
        }
       
    } 
   
  //Email to OpptyTeam and Assignees on Task close
  public void emailToOpptyTeamMembersOnTaskClose(List<Task> newListTask, Map <Id,Task> taskOldMap){
        System.debug('-----Entering into EmailToOpptyTeamMemebrs_GE_OG.emailToOpptyTeamMembersOnTaskClose------');
        List<id> opptyIds = new List<id>();
        List<id> accIds = new List<id>();
        List<id> taskIds = new List<id>();
        List<id> notificationselids = new List<id>();
        String whatName = '';
        List<id> opptyAccIds = new List<id>();
        List<id> opptyUserIds = new List<id>();
        List<id> opptyUserIdList = new List<id>();
        List<Task> taskList = new List<Task>();
        List<OpportunityTeamMember> opptyTeamMembers = New List<OpportunityTeamMember>();   
        List<AccountTeamMember> accTeamMembers = New List<AccountTeamMember>();   
        List<Id> assignedToIDs = new List<Id>();  
        List<Id> assignedToIDsone = new List<Id>();  
        List<User> emailIDsListUsers = New List<User>();     
        List<String> emailIDsList = New List<String>();  
        
        List<Task_Relation_ge_og__c> taskInvitees = new List<Task_Relation_ge_og__c>();
      
        ID dealMacRecordType = schema.sObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeID();
      
        for(Task task: newListTask) {
              String status= task.Status;
            String dmRecType=task.RecordTypeId;
            String oldStatus='';
              String taskWhatID = task.WhatId ; 
              if(task.Notification_Selection_ge_og__c){
              notificationselids.add(task.Id); 
              }
              // Updated on 1/18/2017 R-26325- Notify only when assignee is not the creator
              if(task.RecordTypeId == dealMacRecordType && (taskOldMap.get(task.Id).Status != task.Status && task.Status.contains('Complete')) && (task.LastModifiedById  != task.CreatedById || task.LastModifiedById  != task.OwnerId)) {
               assignedToIDs.add(task.OwnerId);
               assignedToIDs.add(task.CreatedById);
               //assignedToIDs.add(task.LastModifiedById);
               
               taskIds.add(task.Id);   
               taskList.add(task);
               //opptyName = [Select Name from Opportunity where Id  =: task.WhatId].Name ; 
              
                   if(task.Notification_Selection_ge_og__c && taskWhatID.startsWith('006')) {
                     opptyIds.add(task.WhatId); 
                   }else if(task.Notification_Selection_ge_og__c && taskWhatID.startsWith('001')) {
                     accIds.add(task.WhatId); 
                   }
               }
        }
      Map<Id,String> mUser = new Map<Id,String>();
      List<User> usrDet= new List<User>();
       usrDet = [Select Id,Full_Name__c from User where Id in :assignedToIDs];
      for(User u:usrDet){
         mUser.put(u.Id,u.Full_Name__c);
      }
        
       if(taskIds.size()>0)
       whatName = [Select what.name from Task where Id  =:taskIds.get(0)].what.name;
      //Getting Assigned To IDs and Creator ID email addresses
      /*  if(assignedToIDs.size()>0){
            List<User> emailAssignedToIDs =[select Id, Email from User where Id in :assignedToIDs];
            for(User emailStr:emailAssignedToIDs) {
                emailIDsList.add(emailStr.Email);
            }
        }*/
      
      //Task Invitees email IDs
      if(notificationselids.size()>0) {
        taskInvitees = [Select Id, Task_ID_ge_og__c, Invitee_ID_ge_og__c from Task_Relation_ge_og__c where Task_ID_ge_og__c in :taskIds];
            if(taskInvitees !=null && taskInvitees.size()>0){
               for(Task_Relation_ge_og__c tRel:taskInvitees)  {
                    assignedToIDs.add(tRel.Invitee_ID_ge_og__c);
                   // emailIDsList.add(tRel.Invitee_ID_ge_og__c);
            }
         }
          
       }
       
      //Opportunity and Account Team User IDs
       if(opptyIds.size()>0){
            opptyTeamMembers =[select id,User.Email, userId,OpportunityId from OpportunityTeamMember where opportunityid in :opptyIds];
            for(OpportunityTeamMember otm:opptyTeamMembers) {
                assignedToIDs.add(otm.UserId);  
                //emailIDsList.add(otm.User.Email);
            }
        }else if(accIds.size()>0){
            accTeamMembers =[select id,User.Email, userId,AccountId from AccountTeamMember where AccountId in :accIds];
            for(AccountTeamMember acctm:accTeamMembers) {
                assignedToIDs.add(acctm.UserId);    
               // emailIDsList.add(acctm.User.Email);
            }
        }
       System.debug('-------============================>> Total assignedToIDs size='+assignedToIDs.size());
      
      //Fetching all email Ids based on all the assigned task users and team members 
      if(assignedToIDs.size()>0) {
                emailIDsListUsers = [Select Email from User where Id in :assignedToIDs];
           for(User usr:emailIDsListUsers){
               emailIDsList.add(usr.Email);
           }
                EmailTemplate emailTemp = [SELECT id,HTMLValue,body,subject FROM EmailTemplate WHERE developerName = 'Activity_DM_Notification_on_Task_Complete'];
              
                sendEmailToUsers(emailIDsList, taskList, emailTemp, whatName,mUser);
        }
       
    } 
    
  //Email to Task Invitees on Task Membership
  public void emailToTaskInviteeOnAdd(List<Task_Relation_ge_og__c> newListTaskMembers){
        System.debug('-----Entering into EmailToOpptyTeamMemebrs_GE_OG.emailToTaskInviteeOnAdd------');
        List<String> inviteeTaskIds = new List<String>();
        List<String> inviteeIds = new List<String>();
        List<String> taskIds = new List<String>();
        String whatName = '';
         List<Id> assignedToIDs = new List<Id>();  
        List<User> emailIDsListUsers = New List<User>();     
        List<String> emailIDsList = New List<String>();     
              
        for(Task_Relation_ge_og__c nTaskInvitee: newListTaskMembers) {
           
           if(nTaskInvitee.Invitee_ID_ge_og__c !='' ) {
                inviteeIds.add(nTaskInvitee.Invitee_ID_ge_og__c);
                taskIds.add(nTaskInvitee.Task_ID_ge_og__c);
              //  mInviteeEmail.put(nTaskInvitee.Task_ID_ge_og__c, nTaskInvitee.Email_Id_ge_og__c) ;  
            }
        } 
      //String tWhatID = ''; 
      
      List<Task> taskList = [Select WhatId,Status,what.name,CreatedById,OwnerId,Type,Subject,Description,ActivityDate from Task where Id in : taskIds];
      for(Task t:taskList){
           assignedToIDs.add(t.CreatedById);
           assignedToIDs.add(t.OwnerId);
      }
      
      Map<Id,String> mUser = new Map<Id,String>();
      List<User> usrDet = [Select Id,Full_Name__c from User where Id in :assignedToIDs];
      for(User u:usrDet){
         mUser.put(u.Id,u.Full_Name__c);
      }
      
      if(taskIds !=null && taskIds.size()>0)
      whatName= [Select what.name from Task where Id  =: taskIds.get(0)].what.name ; 
      system.debug('------------------->>task Related To:'+whatName);
      //Task Invitees email IDs
      if(inviteeIds.size()>0) {
            emailIDsListUsers = [Select Email from User where Id in :inviteeIds];
          for(User usr:emailIDsListUsers){
              emailIDsList.add(usr.Email);
          }
           // emailIDsList.addAll(mInviteeEmail.values());
            System.debug('-------============================>> emailIDsList size='+emailIDsList.size()+' for Related To:'+whatName);
      }
      
      if(emailIDsList.size()>0) {
                EmailTemplate emailTemp = [SELECT id,HTMLValue,body,subject FROM EmailTemplate WHERE developerName = 'Activity_DM_Notification_for_Task_Invitees'];
                sendEmailToUsers(emailIDsList, taskList, emailTemp, whatName,mUser);
      }
       
    }   
   
  //Email to Old and New Assignee on Task assignee change
  public void emailToOpptyTaskAssigneeOnChange(List<Task> newListTask, Map <Id,Task> taskOldMap){
        System.debug('-----Entering into EmailToOpptyTeamMemebrs_GE_OG.emailToOpptyTaskAssignee------');
       
        List<id> taskIds = new List<id>();
        String whatName = '';
        List<Task> taskList = new List<Task>();
        
        List<Id> assignedToIDs = new List<Id>();  
        List<User> emailIDsListUsers = New List<User>();     
        List<String> emailIDsList = New List<String>();     
        List<Task_Relation_ge_og__c> taskInvitees = new List<Task_Relation_ge_og__c>();
      
        ID dealMacRecordType = schema.sObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeID();
       
           for(Task task: newListTask) {
             
              String taskRecId=  task.RecordTypeId;
              if(task.RecordTypeId == dealMacRecordType && taskOldMap.get(task.Id).OwnerId != task.OwnerId) {
               assignedToIDs.add(task.OwnerId);
               assignedToIDs.add(taskOldMap.get(task.Id).OwnerId);
               assignedToIDs.add(task.CreatedById);
               taskIds.add(task.Id);   
               taskList.add(task);
               //whatName = [Select Name from Opportunity where Id =: task.WhatId].Name ; 
               
               }
            }
         
       if(taskIds !=null && taskIds.size()>0)
       whatName = [Select what.name from Task where Id =:taskIds.get(0)].what.name;
       System.debug('-------------------->>>>>>>Task Related To'+whatName);
      
      Map<Id,String> mUser = new Map<Id,String>();
      List<User> usrDet = new List<User>();
       usrDet = [Select Id,Full_Name__c from User where Id in :assignedToIDs];
      for(User u:usrDet){
         mUser.put(u.Id,u.Full_Name__c);
      }
      //Getting old & new Assigned To IDs and Creator ID email addresses
        if(assignedToIDs.size()>0){
            List<User> emailAssignedToIDs =[select Id, Email from User where Id in :assignedToIDs];
            for(User emailStr:emailAssignedToIDs) {
                emailIDsList.add(emailStr.Email);
            }
        }
      System.debug('-------============================>> 1. emailIDsList size='+emailIDsList.size());
      if(emailIDsList.size()>0) {
                
                EmailTemplate emailTemp = [SELECT id,HTMLValue,body,subject FROM EmailTemplate WHERE developerName = 'Activity_DM_Notification_on_Task_Assignee_change'];
                sendEmailToUsers(emailIDsList, taskList, emailTemp, whatName,mUser);
        }
       
    }   
    
  //To send emails to emailIDs list of users related to Task
    public static void sendEmailToUsers(List<String> emailIDsList, List<Task> taskList, EmailTemplate emailTemp, String objName, Map<Id,String> mUser){
            
          List<Messaging.SingleEmailMessage> lstMails = new List<Messaging.SingleEmailMessage>();
          Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
               
          for(Task task: taskList) {
                            String emailBody = createEmailBody(task, emailTemp, objName, mUser) ;
                            System.debug('--------------->>>Inside email method1 email body:'+emailBody);
                            mail = new Messaging.SingleEmailMessage();
                            mail.saveAsActivity = false;
                            mail.setTemplateId(emailTemp.id);
                      mail.setSubject(emailTemp.Subject);
                           // String toTargetObjectId = '00321000004J4bqAAC'; 
                           // mail.setTargetObjectId(toTargetObjectId);
                            mail.setToAddresses(emailIDsList);
                            mail.setWhatId(task.WhatId);
                            mail.setHTMLBody(emailBody);
                            lstMails.add(mail);
            }
                
            if(lstMails.size() > 0 && !Test.isRunningTest())
                    Messaging.sendEmail(lstMails);
    }  
    
  //To create HTML version of email template to include Task details for DM notification
  public static String createEmailBody(Task taskObject, EmailTemplate emailTemp, String objName, Map<Id,String> mUser){
    
    String emailBody = emailTemp.HTMLValue;
    
    System.debug('-----===============>>>>>>>>>>>>>>>>>>>createEmailBody -> Related To: objNm:'+objName);  
    //String = taskObject.WhatId;
    String Related_To= objName;  
    String Created_By= mUser.get(taskObject.CreatedById);
    String Assigned_To= mUser.get(taskObject.OwnerId);
    String Type_of_Activity= '';
    system.debug('Subject before conversion-----------------------'+taskObject.Subject);
    String Task_Subject= String.valueOf(taskObject.Subject);
    system.debug('Subject after conversion-----------------------'+Task_Subject);
    String due_Date = ' ';
    String description = '';
    String taskUrl = System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+taskObject.Id;  
    
    emailBody = emailBody.replace('{!Opportunity.Name}',Related_To);
    emailBody = emailBody.replace('{!Task.CreatedBy}',Created_By);
    emailBody = emailBody.replace('{!Task.Assigned_To_User__c}', Assigned_To) ;
    emailBody = emailBody.replace('{!Task.Subject}', Task_Subject) ;
    
    if(taskObject.ActivityDate != null) {
        due_Date = string.valueofGmt(taskObject.ActivityDate);
    }
    if(taskObject.Description != null) { 
        description = String.valueOf(taskObject.Description);
    }
    if(taskObject.Type != null) { 
        Type_of_Activity = String.valueOf(taskObject.Type);
    }  
    emailBody = emailBody.replace('{!Task.Type}', Type_of_Activity) ;  
    emailBody = emailBody.replace('{!Task.Description}', description) ;  
    emailBody = emailBody.replace('{!Task.ActivityDate}', due_Date) ;
    emailBody = emailBody.replace('{!Task.Link}', taskUrl);
    return emailBody;
  }
  
}