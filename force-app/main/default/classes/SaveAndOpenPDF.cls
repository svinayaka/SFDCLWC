public with sharing class SaveAndOpenPDF {

public GE_HQ_Account_Plan__c acctPlan;
public List<Task> lstCompletedTasks = new List<Task>();
public List<Task> lstIncomTasks = new List<Task>();

    public SaveAndOpenPDF(ApexPages.StandardController controller) {
     
     acctPlan=[Select id,Channel_Partner_Contact_Name_GEOG__c,Primary_Channel_Manager_18_digit_ID__c,Secondary_Channel_Manager_18_digit_ID__c from GE_HQ_Account_Plan__c where id=:ApexPages.currentPage().getParameters().get('Id')];

    }

  public String recordId {
    get {
      return ApexPages.currentPage().getParameters().get('Id');
    }
  }

  // this is to make testing a lot easier -- simply append renderAs=html
  // to the url parameters to test, add displayOnly=1 if you don't want to save
  public String renderAs {
    get {
      if (String.isBlank(ApexPages.currentPage().getParameters().get('renderAs'))) {
        return 'pdf';
      } else {
        return ApexPages.currentPage().getParameters().get('renderAs');
      }
    }
  }

    public PageReference saveAndOpenPDF() {
        if (String.isBlank(ApexPages.currentPage().getParameters().get('displayOnly'))) {
          Id attachmentId = savePDF();
          return openPDF(attachmentId);
        } else {
          return null;
        }
      }
      
    Public void sendEmailNotification(id attachId){
    
       EmailTemplate templateId=[Select id from  EmailTemplate where name='GE_PRM_AccountPlanpdf'];
       
       //System.debug('templateId***'+templateId);
      
        try {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      
      
       
       User Usr = new User();
       Usr = [SELECT Email, Id FROM User WHERE Id = : UserInfo.getUserId()];
       
       //System.debug('logged in user email'+Usr.email);
       
       String loggedinUser=Usr.email;
       
       
       //System.debug('email adre'+acctPlan.Primary_Channel_Manager_18_digit_ID__c);
      
      //System.debug('email adre'+acctPlan.Secondary_Channel_Manager_18_digit_ID__c);
      
      //creating set of 18 digit id's
      Set<String> ccAddresses=new Set<String>();
      if(acctPlan.Primary_Channel_Manager_18_digit_ID__c!=null)
      {
          ccAddresses.add(acctPlan.Primary_Channel_Manager_18_digit_ID__c);
      }
      
       if(acctPlan.Secondary_Channel_Manager_18_digit_ID__c!=null)
      {
          ccAddresses.add(acctPlan.Secondary_Channel_Manager_18_digit_ID__c);
      }
      
      //variable declaration:
      String primaryChnlMgr='';
      String secChnlMgr='';
      
      List<User> useradd = [SELECT Email FROM User WHERE Id = :ccAddresses];
      //System.debug('**useradd**'+useradd);
      // System.debug('**useradd[0]**'+useradd[0].email);
       //System.debug('**useradd[1]**'+useradd[1].email);
       
       if((useradd.size() > 0)  && (useradd.size()==2))
       {
           if(useradd[0].email!=null)
           {
               primaryChnlMgr=useradd[0].email;
           }
           
            if(useradd[1].email!=null)
           {
               secChnlMgr=useradd[1].email;
           }
           
           
       }else if((useradd.size() > 0)  && (useradd.size()==1))
       {
           primaryChnlMgr=useradd[0].email;
           secChnlMgr='';
           System.debug('primaryChnlMgr'+primaryChnlMgr);
           
       }
       
    //System.debug('**primaryChnlMgr'+primaryChnlMgr);
    //System.debug('**secChnlMgr'+secChnlMgr);
       
        //String[] ccAddF= new String[3];
        List<String> ccAddF=new List<String>();
        
        ccAddF.clear();
        //System.debug('ccAddF log 1'+ccAddF);
        ccAddF.add(loggedinUser);
        
        
       if(primaryChnlMgr!=null && String.isNotBlank(primaryChnlMgr))
       {
           ccAddF.add(primaryChnlMgr);
       }
       
        if(secChnlMgr!=null && String.isNotBlank(secChnlMgr))
       {
           //System.debug('secChnlMgr*************'+secChnlMgr);
           ccAddF.add(secChnlMgr);
       }
       
       
       //System.debug('Array of Users'+ccAddF);
      
       
        //mail.setBccSender(true);
        mail.setccAddresses(ccAddF);
          //System.debug('Array of Users2'+ccAddF);
      // mail.setReplyTo('sendchannelpartnerservice@6-313m7xjlv4uuqy03vzp9vw710somly8ssfdrpqdf49vpqh276h.0s-pphuam.cs54.apex.sandbox.salesforce.com');
       
       
       
       
       List<EmailServicesAddress> esa=new List<EmailServicesAddress>([select localpart,EmailDomainName from EmailServicesAddress where localpart='SendChannelPartnerService']);  
       System.debug('&&&&&&&&&&&&&&&&&&&'+esa);
       String ReplyEmil=Test.isRunningTest() || esa.isempty()?'test@test.ge.com':esa[0].localpart+'@'+esa[0].EmailDomainName;
       System.debug('ReplyEmil*'+ReplyEmil);
       mail.setReplyTo(ReplyEmil);
       
       
       /*mail.setReplyTo('sendchannelpartnerservice@6-313m7xjlv4uuqy03vzp9vw710somly8ssfdrpqdf49vpqh276h.0s-pphuam.cs54.apex.sandbox.salesforce.com');*/
       
       
        mail.setUseSignature(true);
        mail.setTemplateID(templateId.id);        
        mail.setSaveAsActivity(false);
        mail.setTargetObjectId(acctPlan.Channel_Partner_Contact_Name_GEOG__c);
        mail.setWhatId(acctPlan.id);   
        
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for (Attachment a : [select Name, Body, BodyLength from Attachment where Id= :attachId]){
        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName(a.Name);
        efa.setBody(a.Body);
        fileAttachments.add(efa);
        //mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        }
        system.debug('****'+fileAttachments);
        mail.setFileAttachments(fileAttachments);
        system.debug('****'+mail);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        system.debug('Mail Debug ***************');
        } catch(Exception e) {
            
            System.debug('Exception in method sendEmailNotification'+e);
            
        }
     }        
   
   public Id savePDF() {
        if(acctPlan!=Null){
            acctPlan.Last_sent_Date_to_Channel_partner_GEOG__c=system.today();
            
            update acctPlan;
        }
        
        //System.debug('acctPlan.Last_sent_Date_to_Channel_partner_GEOG__c**'+acctPlan.Last_sent_Date_to_Channel_partner_GEOG__c);
        getlstCompletedTasks();
        getlstIncomTasks();
        //system.debug('*****'+lstTasks);
        Attachment attachment = new Attachment();
        attachment.ParentId = recordId;
        attachment.name = 'PDF_'+String.valueof(Datetime.now())+'.pdf';
        PageReference pdf = Page.AccountPlanPage;
        pdf.getParameters().put('Id', recordId);
        pdf.getParameters().put('displayOnly', '1');
        pdf.setRedirect(true);
        try {
          attachment.Body = pdf.getContent();
        }
        catch (VisualForceException e) {
          attachment.Body = Blob.valueof('There was an error.');
        }
        attachment.ContentType = 'application/pdf';
        insert attachment;
        sendEmailNotification(attachment.Id);
        return attachment.Id;
    }

   public PageReference openPDF(Id attachmentId) {
        PageReference ret = new PageReference('/servlet/servlet.FileDownload?file=' + attachmentId);
        ret.setRedirect(true);
        return ret;
    }
   
   public List<Task> getlstCompletedTasks() {
        //system.debug('****Id'+acctPlan.Id);
       // if(lstTasks== null)
            //lstCompletedTasks=[Select id,Subject,WhatId,Type,OwnerId,Owner.Name,WhoId,Who.Name,Status,ActivityDate,Description from Task Where WhatId=:acctPlan.id  and Status IN('Deferred','Rejected','Completed') ORDER BY ActivityDate ASC];
            lstCompletedTasks=[Select id,Subject,WhatId,Type,OwnerId,Owner.Name,WhoId,Who.Name,Status,ActivityDate,Description from Task Where WhatId=:acctPlan.id  and Status IN('Deferred','Rejected','Completed') and IsRecurrence=false  ORDER BY ActivityDate ASC];
            
            //system.debug('****List of Tasks'+lstCompletedTasks);
        return lstCompletedTasks;
    }
    
     public List<Task> getlstIncomTasks() {
        //system.debug('****Id'+acctPlan.Id);
       // if(lstTasks== null)
            lstIncomTasks=[Select id,Subject,WhatId,Type,OwnerId,Owner.Name,WhoId,Who.Name,Status,ActivityDate,Description from Task Where WhatId=:acctPlan.id and Status IN('Not Started','In Progress','Waiting on someone else') and IsRecurrence=false  ORDER BY ActivityDate ASC];
            //system.debug('****List of Tasks'+lstIncomTasks);
        return lstIncomTasks;
    }
    
    
    
}