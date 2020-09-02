public class PRMCommercialLine_Abandoned {
     @InvocableMethod(label='PRM CommercialLine Abandon' description='update the CAA status to abandon on change of CL status')
     public static void UpdateCAAtoAbandon(List<Id> CommercialLineId){
         Id mailTemplateId ;
         List<Commercial_Line_Apporver_Relation__c> CLAlst=[select id,PRM_Commercial_Line__c,PRM_Channel_Appointment_Approver__c from Commercial_Line_Apporver_Relation__c
                                                           where PRM_Commercial_Line__c=:CommercialLineId];
          EmailTemplate emailTemplate = [select Id, Body from EmailTemplate where DeveloperName = 'Commercial_Line_Abandoned']; 
         mailTemplateId =emailTemplate.id;
         List<String> toAddresses=new List<String>();
         List<String> ccAddresses=new List<String>();
         String mailid;
         ID CLid;
         system.debug('CLA WRT CL'+CLAlst);
         List<ID> CAAlst=new List<ID>();
        
         
         try{
         for(Commercial_Line_Apporver_Relation__c cla:CLAlst)
         {
             CAAlst.add(cla.PRM_Channel_Appointment_Approver__c);
             CLid=cla.PRM_Commercial_Line__c;
         }
         List<PRM_Channel_Appointment_Approver__c> CAAdatalst=[select id,Status__c,Approver__r.Email,PRM_Channel_Appointment__r.PRM_Primary_Sales_Channel_Manager__r.email,PRM_Channel_Appointment__r.PRM_Commercial_Manager__r.Email from PRM_Channel_Appointment_Approver__c where id=:CAAlst];
         List<Commercial_Line_Apporver_Relation__c> CLAlst1=[select id,PRM_Commercial_Line__c,PRM_Channel_Appointment_Approver__c,PRM_Commercial_Line__r.PRM_Status__c from Commercial_Line_Apporver_Relation__c
                                                           where PRM_Channel_Appointment_Approver__c=:CAAlst];
         system.debug('CLA list wrt CAA'+CLAlst1);
         for(PRM_Channel_Appointment_Approver__c caa:CAAdatalst){
               integer count=0;
               toAddresses.clear();
               ccAddresses.clear();
             
             for(Commercial_Line_Apporver_Relation__c cla:CLAlst1){
             if(caa.id==cla.PRM_Channel_Appointment_Approver__c && cla.PRM_Commercial_Line__r.PRM_Status__c!='Abandoned'){
                 system.debug('enter count '+caa.id);
                 count++;
                 //CLid=cla.PRM_Commercial_Line__r.id;
             }
               system.debug('count '+count); 
                 system.debug('CLid '+CLid); 
         }
             if(count==0){
                 system.debug('update status '+caa.id);
                 caa.Status__c='Abandoned';
                 update caa;
                 system.debug('update status2 '+caa.id);
                 if(caa.Approver__r.Email!='' && caa.Approver__r.Email!=null && caa.PRM_Channel_Appointment__r.PRM_Primary_Sales_Channel_Manager__r.Email!=null && caa.PRM_Channel_Appointment__r.PRM_Primary_Sales_Channel_Manager__r.Email!='')
                {
                    toAddresses.add(caa.Approver__r.Email);
                    toAddresses.add(caa.PRM_Channel_Appointment__r.PRM_Primary_Sales_Channel_Manager__r.Email);
                    ccAddresses.add(caa.PRM_Channel_Appointment__r.PRM_Commercial_Manager__r.Email);
                    mailid = caa.Approver__r.id;
                    //ccList = [select Email from User where id =:CA.OwnerId LIMIT 1];
                }
                else
                {    
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No mail id available to send email to');
                    ApexPages.addMessage(myMsg);
                    //return null;
                     
                }
              if(toAddresses.size()>0)
             {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();     
                mail.setToAddresses(toAddresses);
                mail.setTargetObjectId(mailid);
                mail.setccAddresses(ccAddresses);
                mail.setTemplateId(mailTemplateId);
                mail.SetWhatId(CLid);  
                mail.saveAsActivity = false;
                mail.setSenderDisplayName('Channel Partners System');

                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
        
                 
         }
             
         }
         }catch(Exception e){
            System.debug('Exception occured in Line number : '+e.getLineNumber());
            System.debug('cause of the Exception : '+e.getCause());
            System.debug('exception Message : '+e.getMessage());  
            
}
}
}