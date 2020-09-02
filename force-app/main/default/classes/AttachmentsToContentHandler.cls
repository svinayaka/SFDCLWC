/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * email.
 * 
 * Processing email from BigMachines workflow and placing PDF attachment in public workspace GE ES Proposals

    Scrum Team             : Transformation - OPPTY MGMT
    Requirement Number     : R-24048
    Modified By            : Mohit Maheshwari
*/
 
global class AttachmentsToContentHandler implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

        Messaging.InboundEmail.BinaryAttachment binaryattach; 

        /**** do nothing when there is no attachment *****/ 
        if (email.binaryAttachments == null) {
          result.message = 'No attachments';  
          result.success = false;
          return result;
        }
        
        /***** do nothing when there is more than 1 attachment *****/
        else if (email.binaryAttachments.size() != 1) {
          result.message = 'Too many attachments';
          result.success = false;
          return result;
        }
        
        binaryattach = email.binaryAttachments.get(0);
        Attachment objAttachment = new Attachment();
        objAttachment.ParentId = email.subject;
        objAttachment.Name = binaryattach.filename;
        objAttachment.Body = binaryattach.body;
        insert objAttachment;
        result.success = true;
        
        return result;
    }
}