/*
Type Name [Class/Trigger/Page Name] : Class - GE_MC_WorkorderEmail
Purpose                             : Sending email to the Technicians
Functional Area                     : Service Max
Author                              : Ashish Shishodiya 
Created Date                        : 1 March 2013
Original Class                      : 
*/


Public class GE_MC_WorkorderEmail{

public Id workOrderId{get;set;}

public GE_MC_WorkorderEmail(Id workOrderId){
this.workOrderId = workOrderId ;
} 
@future(callout=true)
public  static void sendTechEmail(String sessionID,Id workOrderId){
                String startTime ;
                String stopTime ;
                SVMXC__Service_Order__c workOrder = [select id,SVMXC__Company__r.Name ,GE_SM_HQ_Scheduled_Start_Date_Time__c,name,SVMXC__Group_Member__r.SVMXC__Email__c,SVMXC__Group_Member__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Group_Member__r.name,GE_SM_HQ_Record_Type_Name__c,GE_OG_MC_ERP_Project_Number__c from SVMXC__Service_Order__c where id =: workOrderId];
                List<Attachment> lstWorkOrderAttachment = [select name, body from Attachment where ParentId = : workOrderId];
                system.debug('**********************workOrder.SVMXC__Group_Member__r.SVMXC__Email__c*********************************'+workOrder.SVMXC__Group_Member__r.SVMXC__Email__c);
                if(lstWorkOrderAttachment.size()>0 && workOrder.SVMXC__Group_Member__r.SVMXC__Email__c != null){
                        String[] toAddresses = workOrder.SVMXC__Group_Member__r.SVMXC__Email__c.split(' ', 0);      
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                        // mail.setTargetObjectId(mapTech.get(workOrder.SVMXC__Group_Member__c));
                        email.setToAddresses(toAddresses);
                        email.saveAsActivity = false;
                        system.debug('***************************************In the Email Class ********************************************************');
                        List<Messaging.Emailfileattachment> fileAttachments  = new   List<Messaging.Emailfileattachment>();
      
                        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();   
                        
                        if (lstWorkOrderAttachment.size()>0){
                            for(Attachment aa : lstWorkOrderAttachment)
                            {
                                Messaging.Emailfileattachment efa1 = new Messaging.Emailfileattachment(); 
                                efa1.setFileName(aa.Name); 
                                efa1.setBody(aa.Body); 
                                fileAttachments.add(efa1);
                            }
                        }
                        system.debug('****************************GE_SM_HQ_Scheduled_End_Date_Time__c***********************************'+workOrder.GE_SM_HQ_Scheduled_End_Date_Time__c);
                        system.debug('*****************************toAddresses********************************************'+toAddresses);
                        
                        if(workOrder.GE_SM_HQ_Scheduled_Start_Date_Time__c != null) { startTime = workOrder.GE_SM_HQ_Scheduled_Start_Date_Time__c.format('MM/dd/yyyy'); }
                        else {startTime = ' ';}
                        if(workOrder.GE_SM_HQ_Scheduled_End_Date_Time__c != null ){stopTime = workOrder.GE_SM_HQ_Scheduled_End_Date_Time__c.format('MM/dd/yyyy');}
                        else { stopTime = ' ';}
                        email.setFileAttachments(fileAttachments);  
                        if(workOrder.GE_SM_HQ_Record_Type_Name__c=='D&S')
                        {
                        email.setSubject('New Work Order Assigned To You - with Attachments');
                        }
                        if(workOrder.GE_SM_HQ_Record_Type_Name__c=='MCS')
                        {
                        email.setSubject('New Work Order Assigned To '+workOrder.SVMXC__Group_Member__r.name+' for '+workOrder.SVMXC__Company__r.Name + ' / '+workOrder.GE_OG_MC_ERP_Project_Number__c+'- with Attachments');
                        } 
                        system.debug('**************************workOrder.SVMXC__Group_Member__r.name****************************'+workOrder.SVMXC__Group_Member__r.name);
                        email.setHtmlBody(workOrder.SVMXC__Group_Member__r.name + 
                        '</br> <p>You have been assigned to '+workOrder.SVMXC__Company__r.Name + '. This assignment is scheduled to start ' + startTime +' and end '+ stopTime +' .' +
                        '<p>Included with this email are any attachments to the Work Order, which will provide you specific details about your assignment.</p>'+
                        '<p>If you have any questions, please contact your Service Manager for this assignment.</p>'+
                        '<p>Thank you. </p>');
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email }); 
                    }

}

}