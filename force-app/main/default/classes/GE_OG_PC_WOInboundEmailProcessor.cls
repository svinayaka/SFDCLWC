/* 
Email Service Class for Attaching single Binary Attachment from Email to related Work Order.
*/

global class GE_OG_PC_WOInboundEmailProcessor implements Messaging.InboundEmailHandler 
{
global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.Inboundenvelope envelope) 
{
Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
Messaging.Inboundemail.BinaryAttachment bAttachment=new Messaging.Inboundemail.BinaryAttachment();
List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

List<SVMXC__Service_Order__c> lstWO=new List<SVMXC__Service_Order__c>();
List<User> lstUser=new List<User>();
Boolean vEmail=false;
Boolean vEmailSub=false;
Boolean vAttachCount=false;
Boolean vAttachExt=false;
Boolean vAttachSub=false;
String userEmail='';

vEmail=email.fromAddress.endsWithIgnoreCase('ge.com');
vEmailSub=email.Subject.startsWithIgnoreCase('WO-');
vAttachCount=(email.binaryAttachments!=null && email.binaryAttachments.size()==1);
if(vAttachCount)
{
    bAttachment=email.binaryAttachments[0];
    vAttachExt=email.binaryAttachments[0].FileName.endsWithIgnoreCase('pdf');
    vAttachSub=email.binaryAttachments[0].FileName==(email.Subject+'.pdf');
}    
else
{
    vAttachExt=false;
    vAttachSub=false;
}
          
try{
    lstUser=[select Id, email from User where Email=:email.fromAddress];
    lstWO=[select id,Name from SVMXC__Service_Order__c where name=:email.Subject.left(11)]; //'WO-00416845'];
    if((vEmail && vEmailSub && vAttachCount && vAttachExt && vAttachSub && lstUser.size()>0 && lstWO.size()>0))
    {
            String woID=email.Subject.left(11);
            Attachment attachment = new Attachment();
            attachment.Name = email.binaryAttachments[0].fileName;
            attachment.Body = email.binaryAttachments[0].body;  //(bAttachment.body); 
            attachment.ParentId =lstWO[0].Id; //'a3N12000002QtRu';// 
            insert attachment;
                                    
            mail.setToAddresses(new String[]{lstUser[0].id});
           // mail.setReplyTo('srikrishnachaitanya.kolanu@ge.com');
            mail.setSenderDisplayName('GE Oil & Gas PC Work Order');
            mail.setSubject(email.Subject);
            //mail.setPlainTextBody('Attachment successful! '+lstWO[0].Name+' has been updated accordingly.');
            mail.setHtmlBody('Attachment successful! '+lstWO[0].Name+' has been updated accordingly.');
            mails.add(mail);                                                            
    }
    else
    {
            if(lstUser.size()>0) 
                mail.setToAddresses(new String[]{lstUser[0].id});
            else 
                mail.setToAddresses(new String[]{email.fromAddress});
           // mail.setReplyTo('srikrishnachaitanya.kolanu@ge.com');
            mail.setSenderDisplayName('GE Oil & Gas PC Work Order');
            mail.setSubject(email.Subject);
            String body = 'Please check the following criteria and try submitting again:';
            body += '<br>';
            body += '<br>';
            body += '&nbsp;&nbsp; 1. Validate attachment name and subject are EXACTLY the same.';
            body += '<br>';
            body += '&nbsp;&nbsp; 2. Validate email subject as “WO-XXXXXXXX”.';
            body += '<br>';
            body += '&nbsp;&nbsp; 3. Validate attachment extension is “.pdf” ';
            body += '<br>';
            body += '&nbsp;&nbsp; 4. Validate only 1 attachment.';
            body += '<br>';
            body += '&nbsp;&nbsp; 5. Validate email id has “ge.com” at the end.';
            body += '<br>';
            body += '&nbsp;&nbsp; 6. Validate sender has an active ServiceMax license.';
            body += '<br>';
            mail.setHtmlBody(body);
            
           // mail.setPlainTextBody('Please check the following criteria and try submitting again:');
            mails.add(mail);
    }
    result.success=true;
    if(Test.isRunningTest() && email.Subject.equalsIgnoreCase('Test Exception')) Integer a=1/0;
}
catch (Exception e) {
        result.success = false;
        result.message = 'Error in Processing Email...'+e;
        Messaging.SingleEmailMessage errorMail = new Messaging.SingleEmailMessage();
        if(lstUser.size()>0) 
                errorMail.setToAddresses(new String[]{lstUser[0].id});
        else 
                errorMail.setToAddresses(new String[]{email.fromAddress});
        //errorMail.setToAddresses(new String[]{email.fromAddress,'srikrishnachaitanya.kolanu@ge.com'});
        //errorMail.setReplyTo('srikrishnachaitanya.kolanu@ge.com');
        errorMail.setSenderDisplayName('GE Oil & Gas PC Work Order');
        errorMail.setSubject(email.Subject);            
        errorMail.setHtmlBody('Email Not Processed. Something went wrong..'+e);            
        mails.add(errorMail); 
        result.success=false;        
      }

Messaging.sendEmail(mails);
return result;
}
}