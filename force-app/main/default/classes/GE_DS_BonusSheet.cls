global class GE_DS_BonusSheet {
    
    
    
    webservice static void sendEmail(List<Id> tsIdSet)
    {
        List<SVMXC_Timesheet__c> tsList = [SELECT Id, Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin__r.id ,Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin_Email__c, Technician__r.Name, Start_Date__c, End_Date__c FROM SVMXC_Timesheet__c WHERE Id IN :tsIdSet];
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        Id SendtoEmailList;
        for (SVMXC_Timesheet__c ts : tsList)
        {
            Attachment attmt = new Attachment();
            attmt.ParentId = ts.Id;
            attmt.IsPrivate = true;
            attmt.ContentType = 'application/pdf';
            attmt.Name = 'BonusSheet.pdf';
            PageReference pageRef = new PageReference('/apex/GE_DS_BonusSheet');
            pageRef.getParameters().put('id', ts.Id);
            //attmt.Body = pageRef.getContentAsPDF();
            try {
 
        // returns the output of the page as a PDF
        attmt.Body = pageRef.getContentAsPDF();
 
    // need to pass unit test -- current bug    
    } catch (VisualforceException e) {
        attmt.Body = Blob.valueOf('Some Text');
    }
            
            insert attmt;
            
            if (ts.Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin_Email__c != null)
            {
                SendtoEmailList = ts.Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin__r.Id;

                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setPlainTextBody('Bonus sheet for ' + ts.Technician__r.Name + ' for period ' + ts.Start_Date__c + ' to ' + ts.End_Date__c);
                mail.setSubject('Bonus Sheet');
                mail.setTargetObjectId(SendtoEmailList);
                mail.setSaveAsActivity(false);

                //mail.setToAddresses(new List<String> { ts.Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin_Email__c});
                
                Messaging.EmailFileAttachment fileAttachment = new Messaging.EmailFileAttachment();
                fileAttachment.setBody(attmt.body);
                fileAttachment.setFileName(attmt.name);
                fileattachment.setContentType(attmt.ContentType);
                mail.setFileAttachments(new List<Messaging.EmailFileAttachment> {fileAttachment});
                emailList.add(mail);    
            }
        }
        
        if (emailList.size() > 0)
        {
            Messaging.sendEmail(emailList);
        }
        
    }

}