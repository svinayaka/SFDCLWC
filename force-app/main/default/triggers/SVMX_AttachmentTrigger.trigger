trigger SVMX_AttachmentTrigger on Attachment (before insert, after insert, after update) {
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate )){
        //Not handling undelete functionality as the customer would get the same email twice (was already sent out during original insert)
        SVMX_AttachmentHelper.emailServiceWorkOrder(Trigger.New);
    }
    
    
    // Related to R-25011
    // Block uploads of file types deemed non secure
    if(!Trigger.isDelete){
        for(Attachment theAttachment : Trigger.new)
            GE_OG_RestrictDllAndExeFileUtil.restrictSObjectAttachment(theAttachment);        
    }   
    
}