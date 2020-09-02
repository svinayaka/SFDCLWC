/*
Functional Area : Service Management
Author:
Purpose/OverView:
ClassName:GE_OG_Tsk_Status_Changng_Mail
TestClassName:Test_GE_OG_Tsk_Status_Changng_Mail
*/
Public with sharing class GE_OG_Tsk_Status_Changng_Mail{

  static Integer mailAlreadySent = 0;

Public static void TaskStatusChgangingMail(List<Task> NewList,Map<Id,Task> NewMap,Map<id,Task> OldMap){
  
  if(mailAlreadySent ==0){
  
    Id TaskRecTypeID = Schema.SObjectType.Task.getRecordTypeInfosByName().get('DS').getRecordTypeId();    
    Set<id> caseIDs = new Set<Id>();
    String fromobjectId;
    // fetching the objects prefix to check whether it is Case or not
    String KeyPrefix = Case.sObjectType.getDescribe().getKeyPrefix();
    system.debug('********key prefix*****'+ KeyPrefix);
       
    for(Task t : NewList){
        fromobjectId =t.whatId;
        if(fromobjectId != null){
         if(fromobjectId.substring(0,3) == KeyPrefix){
           if(t.RecordTypeId == TaskRecTypeID && oldmap.get(t.id).status != NewMap.get(t.id).status)
        {  
             caseIDs.add(t.createdById);
             //caseIDs.add(t.ownerId);
        }
      } 
    }
  }  
    List<User> owners = New List<User>();
    if(caseIDs.size() > 0){
        owners = [select Name,Email from User where id =:caseIDs];
    }       
    List<Messaging.SingleEmailMessage> lstMails = new List<Messaging.SingleEmailMessage>();
    EmailTemplate et = [SELECT id,body,subject FROM EmailTemplate WHERE developerName = 'Task_Status_chanage_Notification_mail'];
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    if(owners.size()>0){
        for(Task t : NewList){                           
            if(t.RecordTypeId == TaskRecTypeID && oldmap.get(t.id).status != NewMap.get(t.id).status){                
                mail = new Messaging.SingleEmailMessage();
                mail.saveAsActivity = false;
                mail.setTemplateId(et.id);
                String toTargetObjects = owners[0].id;            
                mail.setTargetObjectId(toTargetObjects);
                mail.setWhatId(t.Id);
                lstMails.add(mail);                
            }            
            if(!lstmails.isEmpty()){
               Messaging.sendEmail(lstmails);   
               mailAlreadySent = 1;            
            }
        }
        }
    }
}
}