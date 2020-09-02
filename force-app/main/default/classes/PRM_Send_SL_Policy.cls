global class PRM_Send_SL_Policy implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String  appObjPrefix = PRM_Channel_Appointment_GE_OG__c.SObjectType.getDescribe().getKeyPrefix(); 
        PRM_Channel_Appointment_GE_OG__c appt=new PRM_Channel_Appointment_GE_OG__c();
        List<Attachment>  attachments = new list<attachment>(); 
        String  ApptId;
        Boolean blnProceed;
          
        //try {
           blnProceed=email.subject.Contains(appObjPrefix) && email.subject.indexOf(appObjPrefix) + 12 < email.subject.length() -1;                                           
           ApptId = blnProceed ? email.subject.substring(email.subject.indexOf(appObjPrefix), email.subject.indexOf(appObjPrefix)+15):'';                
           if(ApptId !=null || ApptId !=''){
              appt= [SELECT Name,Id,PRM_Commercial_Manager__c,PRM_Partner_Integrity_Training_Comment__c,PRM_Last_Integrity_Training_Signed_Date__c,PRM_Partner_Integrity_Training_Status__c FROM PRM_Channel_Appointment_GE_OG__c WHERE ID=:ApptId limit 1];
              system.debug('appt'+appt);
              system.debug('ApptId'+ApptId);
              
              if(appt== Null){
                 blnProceed = false;
              } 
           }
           if(blnProceed){
              String[] emailBody = email.plainTextBody.split('\n', 0);
              String emailapprej=(emailBody[0]).toLowerCase();
              System.debug(emailBody);
              if(emailBody[1]!=null){
                appt.PRM_Partner_Integrity_Training_Comment__c=emailBody[1];
              }
              appt.PRM_Last_Integrity_Training_Signed_Date__c=Date.today();
                if(emailapprej.contains('certify') || emailapprej.contains('certified')){
                  appt.PRM_Partner_Integrity_Training_Status__c='Certify';
                  appt.PRM_Last_Integrity_Training_Signed_Date__c=Date.today();
                  update appt;
                }else if(emailapprej.contains('modify')){
                  appt.PRM_Partner_Integrity_Training_Status__c='Modify';
                  appt.PRM_Last_Integrity_Training_Signed_Date__c=Date.today();
                  update appt;
                }
   
              //Creation Of New Task.
              Id taskRecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('New Task').getRecordTypeId();
                  Task newTask = new Task(Description = 'From: ' + email.FromAddress +'\r\n Subject : '+email.Subject + '\r\n Body: \r\n \r\n' + email.plainTextBody,
                                      Priority = 'Normal',
                                      Status = 'Completed',
                                      Type = 'Email',
                                      Subject = email.subject,
                                      ActivityDate = System.today(),
                                      IsReminderSet = false,
                                      OwnerId = appt.PRM_Commercial_Manager__c,  
                                      WhatId = ApptId,
                                      recordTypeId = taskRecordTypeId
                                      );      
                  insert newTask;  
                  
                  //
                //
                task t = [select Description from task where id =: newTask.id];
                user u = [select email from user where id =: appt.PRM_Commercial_Manager__c];
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {u.email});
                mail.setSubject(email.Subject);
                String body;
                string s= t.description;
                integer ind = s.indexof('.com',0);
                s= s.substring(0,ind+4);
                body =  '<font size="4" color=\"#488AC7\" face=\"verdana\"><b>New Task</b></font><br/><br/>'+'Following task has been assigned'+'<br/><br/>'+ 'Subject:'+email.Subject+'<br/>'+'Channel Appointment :'+ appt.Name+'<br/>'+'Due Date :'+date.today().format()+'<br />'+ 'Priority :'+'Normal'+'<br/>'+ 'Comments :'+ s +'<br/>'+'Subject :'+email.subject+'<br/>'+'Body :'+'<br /><br />'+ email.htmlBody;
                System.debug('HTML is ' + body);
                mail.setHtmlBody(body);
                List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
                mails.add(mail);  
                Messaging.SendEmail(mails);

                //
                  //
                   
                  
              //Email Attachments If any are inserted.
                            if (email.binaryAttachments != null && email.binaryAttachments.size() > 0){
                                    for (integer i = 0 ; i < email.binaryAttachments.size() ; i++){
                                            Attachment att = new Attachment(ParentId = ApptId,
                                            Name = email.binaryAttachments[i].filename,
                                            Body = email.binaryAttachments[i].body);
                                            attachments.add(att);
                                    }
                            }
                            if(!attachments.isEmpty())  {
                                insert attachments;
                            }    
           }
        /*}
        catch(Exception e)  {           
            System.debug('ERROR: Not able to update appt: ' + e);
        }*/
           
        // Set the result to true, no need to send an email back to the user
        result.success = true;
        // Return the result for the Force.com Email Service
        return result; 
    }
}