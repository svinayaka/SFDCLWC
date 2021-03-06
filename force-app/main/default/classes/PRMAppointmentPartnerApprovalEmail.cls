global class PRMAppointmentPartnerApprovalEmail implements Messaging.InboundEmailHandler 
{
    
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String  appObjPrefix = PRM_Channel_Appointment_GE_OG__c.SObjectType.getDescribe().getKeyPrefix(); 
        PRM_Channel_Appointment_GE_OG__c appt=new PRM_Channel_Appointment_GE_OG__c();
        List<Attachment>  attachments = new list<attachment>(); 
        String  ApptId;
        Boolean blnProceed;
        
        try {
            blnProceed=email.subject.Contains(appObjPrefix) && email.subject.indexOf(appObjPrefix) + 12 < email.subject.length() -1;                                           
            ApptId = blnProceed ? email.subject.substring(email.subject.indexOf(appObjPrefix), email.subject.indexOf(appObjPrefix)+15):'';                
            if(ApptId !=null || ApptId !=''){
                appt= [SELECT Name, Id,PRM_Commercial_Manager__c, PRM_Partner_Approval__c,PRM_Partner_Comment__c,PRM_Partner_s_Reply_Date_Time__c FROM PRM_Channel_Appointment_GE_OG__c WHERE ID =:ApptId];
                if(appt== Null){
                    blnProceed = false;
                } 
            }
            if(blnProceed){
                String[] emailBody = email.plainTextBody.split('\n', 0);  system.debug('emailBody---->'+emailBody);
                String emailapprej=(emailBody[0]).toLowerCase();   system.debug('emailapprej---->'+emailapprej);
                if(emailBody[1]!=null){
                    appt.PRM_Partner_Comment__c=emailBody[1]; system.debug('----->emailBody[1]'+emailBody[1]);
                }
                appt.PRM_Partner_s_Reply_Date_Time__c=system.now();
                if(emailapprej!='')
                {
                    if((emailapprej.contains('no'))==false &&(emailapprej.contains('not'))==false && (emailapprej.contains('dont'))==false && (emailapprej.contains('don\'t'))==false && (emailapprej.contains('don'))==false)
                    {
                        system.debug('inside 1');
                        if(emailapprej.contains('approv'))
                        {     system.debug('inside 2');
                            //appt.GE_PRM_AFA_Approved_By_Channel_Partner__c = date.today();
                            appt.PRM_Partner_Approval__c='Approved';
                            update appt;
                        }
                    }
                    if((emailapprej.contains('modif'))==true || (emailapprej.contains('no'))==true || (emailapprej.contains('not'))==true || (emailapprej.contains('dont'))==true || (emailapprej.contains('don\'t'))==true || (emailapprej.contains('don'))==true)
                    {
                        appt.PRM_Partner_Approval__c='Modify';
                        update appt;
                    }
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
                                
                //
                //Database.DMLOptions notifyOption = new Database.DMLOptions();
                //notifyOption.EmailHeader.triggerUserEmail = true;
                //Database.insert(newTask, notifyOption);
                //                
                                   
                insert newTask;   
               
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
                
                
                
                //Email Attachments If any are inserted.
                if (email.binaryAttachments != null && email.binaryAttachments.size() > 0){
                    for (integer i = 0 ; i < email.binaryAttachments.size() ; i++){
                            Attachment att = new Attachment(ParentId = newTask.id,
                            Name = email.binaryAttachments[i].filename,
                            Body = email.binaryAttachments[i].body);
                            attachments.add(att);
                    }
                }
                if(!attachments.isEmpty())  {
                    insert attachments;
                }    
            }
        }
        catch(Exception e)  {           
            System.debug('ERROR: Not able to update appt: ' + e);
        }
        
        // Set the result to true, no need to send an email back to the user
        result.success = true;
        // Return the result for the Force.com Email Service
        return result;          
    }
}