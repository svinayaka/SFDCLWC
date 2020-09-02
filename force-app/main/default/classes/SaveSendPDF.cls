/*
Class Name      :SaveSendPDF
Test class name :Test_GE_PRM_Channel_Appointment_Class
Description     : This is a controller class to support VF page and  manage the business logic 
                  around  generating and sending the partner validation PDF for a channel appointment.
                  with business validations      
Functional Area : PRM
Created By      : Gautam Maheshwari / Vishwa Natarajan  

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change


*/
public class SaveSendPDF {
    public String chAppID;
    public String onlypdf;
    public String fileName{get; set;}
    public PRM_Channel_Appointment_GE_OG__c ChannelApp;
    public List<GE_PRM_Commercial_line__c> CommLines{get; set;}
    public Blob CAPDF{get; set; }
    public Note[] arrNotes { get; set; }
    public Attachment[] arrAttachments { get; set; }
    public Id mailid ;
    public SaveSendPDF(ApexPages.StandardController controller) {
        
        chAppID= ApexPages.CurrentPage().getParameters().get('Id');
        onlypdf = ApexPages.CurrentPage().getParameters().get('onlypdf');
        ChannelApp= [select Id,Owner.Email,
                    PRM_Account_Name__c,
                    PRM_Principal_Contact__r.Email,
                    PRM_Address__c,
                    PRM_Postal_Code__c,
                    PRM_Country__c,
                    PRM_Account_Name__r.name,
                    PRM_Principal_Contact__c,
                    PRM_Phone__c,LastModifiedBy.TimeZoneSidKey,
                    PRM_Email__c  
                    from PRM_Channel_Appointment_GE_OG__c where Id =:chAppID]; 
     /**   CommLines= [select Id,
                    Name,
                    GE_PRM_Authorized_Countries_1__c,
                    GE_PRM_Authorized_Countries_2__c,
                    GE_PRM_Channel_Appointment__c,
                    GE_PRM_Current_year_target__c,
                    GE_PRM_If_Services_pick_type__c,
                    GE_PRM_State_Province_Region__c,
                    GE_PRM_Tier_1__c,
                    GE_PRM_Tier_2__c,
                    GE_PRM_Tier_3__c,
                    GE_PRM_Tier_4__c,
                    GE_PRM_Tier_5__c,
                    GE_PRM_Type__c 
                    from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c =: chAppID]; **/
        arrNotes =  [select id,Title,LastModifiedDate,CreatedById from Note where ParentId =: chAppID order by createddate desc];
        arrAttachments =  [select id,Name,LastModifiedDate,CreatedById from Attachment where ParentId =: chAppID order by createddate desc];           
        //Current Date time
        DateTime  localDT   =    system.Now();
        //Create the file name
        fileName  =    'Channel  Appointment  for '+ ChannelApp.PRM_Account_Name__r.name + '-' +  localDT.format('yyyy-MMM-dd hh:mm a');
        //Set the filename of the pdf (for some browsers content type only will work - For others the below statement file name is set in the header)
        Apexpages.currentPage().getHeaders().put( 'content-disposition', 'inline; filename=' + fileName );

    }
   /** public PageReference goback(){

        Pagereference page = new Pagereference('/'+chAppID);
        return page;  
          
    } 
    public PageReference GeneratePDF(){
        //method to generate the PDF and send it or save it
        Pagereference Page =new Pagereference('/apex/GE_PRM_ChannelAppointmentPDF');  
        Page.getParameters().put('Id',chAppID);
        if(!Test.isRunningTest()){
            CAPDF= Page.getContentAsPDF();
        }
        if(onlypdf=='1')
            return savepdf(CAPDF);
        else
            return sendEmail(CAPDF);
    }
    public PageReference savepdf(Blob pgPDF){
        //method to generate PDF and attach it to the Channel Appointment
        DateTime d = system.now();   
        String timeStr = d.format('EEEE, MMMMM dd, yyyy hh:mm:ss a', ChannelApp.LastModifiedBy.TimeZoneSidKey);        
        Attachment objAttachement = new Attachment();
        objAttachement.Name=filename+'.pdf';
        objAttachement.Body= pgPDF;
        objAttachement.ContentType='application/pdf';
        objAttachement.ParentId=chAppID;        
        insert objAttachement;
                
        Pagereference Page=new Pagereference('/'+chAppID);
        return Page;   
            
    }
    public PageReference sendEmail(Blob pgPDF){
        //Integer totalPDF=[select count() from Attachment where ParentId=:chAppID and Name like 'Channel%'];
        //if(totalPDF==0){
            DateTime d = system.now();   
            String timeStr = d.format('EEEE, MMMMM dd, yyyy hh:mm:ss a', ChannelApp.LastModifiedBy.TimeZoneSidKey);        
            Attachment objAttachement = new Attachment();
            objAttachement.Name=filename+'.pdf' ;
            objAttachement.Body= pgPDF ;
            objAttachement.ContentType='application/pdf';
            objAttachement.ParentId=chAppID;        
            Insert objAttachement;
       // }  
        List<EmailServicesAddress> esa=new List<EmailServicesAddress>([select localpart,EmailDomainName from EmailServicesAddress where localpart='channelappointmentapproval']);        

        //Responses are forwarded to ReplyEmail address.
        String ReplyEmil=Test.isRunningTest() || esa.isempty()?'test@test.ge.com':esa[0].localpart+'@'+esa[0].EmailDomainName;
        List<String> toAddresses=new List<String>();
        if(ChannelApp.GE_PRM_Principal_contact__r.Email!='' && ChannelApp.GE_PRM_Principal_contact__r.Email!=null)
        {
            toAddresses.add(ChannelApp.GE_PRM_Principal_contact__r.Email);
            mailid = ChannelApp.GE_PRM_Principal_contact__r.id;
        }
        else
        {    
            Pagereference page=new Pagereference('/'+chAppID);
            page.getParameters().put('hasError','true');
            page.setRedirect(true);
            return page;  
        }
        String url;
        List<Document> imgdoc =[select Url from Document where Name =:'GE_PRM_OG_PDF_Header' LIMIT 1];
        for(Document doc : imgdoc)
        {
            url=doc.url;
        }
        String subject=' GE O&G Channel Partner Commercial Operations | Attention Required | Data certification | Ref ID: ' + ChannelApp.Id;
        String body=
            '<img src="https://geog.my.salesforce.com/servlet/servlet.ImageServer?id=015A0000004Oded&oid=00DA0000000QC05&lastMod=1412369915000" alt="Channel Partner Onboarding"/><br/>'+
            '<br/><font  face="GE Inspira" color="rgb(87,87,87)"><span style="font-size:12px;font-family:GE Inspira;"> Dear GE Partner,<br/><br/>'+'We are looking forward to moving to the next step of your onboarding experience<br/>'+ 
            ' <br/>This step requires us to confirm the information that we have captured from you and will ensure that we eliminate any inaccuracies or delays later in the process.<br/>'+ 
            ' <br/><b>Action required:</b><br/><br/>'+ 
            ' Simply review the attached document and certify that all content is factual and true.<br/><br/>'+ 
            ' a. If everything is correct,  please reply to this email with only the word <b>“Approve”</b> as the first line<br/> '+
            ' b. If changes are required, please reply to this email with only the word <b>“Modify”</b> as the first line – if modified, a GE Commercial Manager will connect with you shortly.<br/>'+ 
            ' <br/><i>If you wish to add additional comments, please enter in the second line of mail. Please don’t change the subject and reply to email address.</i><br/>'+
            ' <br/><i>Please make sure you review the document carefully – it is critical that we get this right! </i><br/>'+
            ' <br/>Contact your BHGE Account Manager if you have any other questions – we look forward to doing business with you! <br/>'+
            ' <br/>Kind regards,<br/>     '+
            ' Your Partners at Baker Hughes, a GE Company</span></font>';
        if(toAddresses.size()>0)
        {
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName(fileName+'.pdf');        
            attach.Body = pgPDF;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();     
            // mail.setToAddresses(toAddresses);
            if(ChannelApp.GE_PRM_Principal_contact__r.Email!='' && ChannelApp.GE_PRM_Principal_contact__r.Email!=null)
            {  
               mail.setTargetObjectId(mailid);
            }
            if(ChannelApp.Owner.Email!=null){
               mail.setCcAddresses(new String[] {ChannelApp.Owner.Email});
            }
            System.debug(Mail.TargetObjectId+'TARGET');
            mail.setSubject(subject);
            mail.setHtmlBody(body);        
            mail.setReplyTo(ReplyEmil);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });    
            mail.setsaveAsActivity(false);    
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            ChannelApp.GE_PRM_AFA_Send_To_Channel_Partner__c = date.today();
            update ChannelApp;
        }
        Pagereference page=new Pagereference('/'+chAppID);
        return page;    
    } **/
}