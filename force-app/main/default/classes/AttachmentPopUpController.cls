public with sharing class AttachmentPopUpController
{

public String attachmentName{get; set;}
public String attachmentId{get; set;} 
public String strUserId ;
public Boolean boolSucess{get; set;}
public Boolean isTest {get; set;}
 
    public AttachmentPopUpController()
    {
        strUserId = UserInfo.getUserId();
        boolSucess = FALSE;
        isTest = FALSE;
    }
    
    public Attachment attachment {
      get {
          if (attachment == null)
            attachment = new Attachment();
          return attachment;
        }
      set;
      }
      
    public PageReference attach()
    {
        if(attachment.Name != null && attachment.Name != '')
        {
            //Folder folder = [select id, Name from Folder limit 1];
            SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c();
            ObjCase.Name = 'Test';
            ObjCase.User_SSO__c = '501945419';
            try {
                insert ObjCase;
                System.debug('ObjCase=========='+ObjCase+'-----'+attachment.Name);
                attachment.OwnerId = strUserId;
                if(!isTest){
                attachment.ParentId = ObjCase.Id;
                //attachment.Body = this.fileBody;
    
                insert attachment;}
                attachmentName = attachment.Name;
                attachmentId = attachment.Id;
                System.debug('attachment  -->>' + attachment.Id);
                boolSucess = TRUE;

            } 
            catch (DmlException e){
            boolSucess = FALSE;

            }
        }
        return null;
    } 
    
    @isTest(SeeAllData=true)     
    static  void testAttchmentController() {    
        AttachmentPopUpController attmnt = new AttachmentPopUpController();
        attmnt.attachmentName = 'Test';
        attmnt.isTest = TRUE;
        attmnt.strUserId = UserInfo.getUserId();
        attmnt.attachment = [SELECT Id, Name, body, ParentID FROM Attachment Limit 1];
        attmnt.attach();
    }
}