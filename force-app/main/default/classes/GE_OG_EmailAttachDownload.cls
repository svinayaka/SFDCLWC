Public class GE_OG_EmailAttachDownload{

    Public string case_id{get;set;}
    public List<EmailandAttachmentWrapper> lstEmailMessagesToAttachments{get;set;}
    public Map<Id, List<Attachment>>  mapEmailMessagesToAttachments {get;set;}
    public String searchText{get;set;}
    public Id SearchResults;
    Case CaseNumber;
             public PageReference downloadAttachments() {
                 return null;
             }
    
             public GE_OG_EmailAttachDownload(){
                 case_id = apexpages.currentpage().getparameters().get('id');
              
                 GetEmailMessages();
                 GetAttachments(setIdsofEmailMessages);
                 GeneratePageTables();
                 getNandA();
                 lengthOFZip = 0 ;
             }
             
             public Case getCaseName() {
                 CaseNumber=[select CaseNumber from Case where id=:case_id];
                 return CaseNumber;
             }
              
             public List<EmailMessage> lstEmailMessages{get;set;}
             public Set<Id> setIdsofEmailMessages{get;set;}
             
             public pageReference search() {
                 try{
                     searchResults = [select id from Case where CaseNumber =: searchText].Id;
                     PageReference requestPage = new pagereference('/apex/ge_og_emailattachdownload?id='+searchResults);
                     requestPage.setRedirect(true);
                      return requestpage;   
                 }
                 catch(Exception e){
                     //ApexPages.addMessages(e) ; 
                     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Case does not Exist'));
                 }
                 return null;  
             
             }
             
             public void GetEmailMessages(){
                 //Map<Id, EmailMessage> mapIdtoEmailMessage = new Map<Id, EmailMessage> [SELECT ActivityId,Subject, ToAddress, status FROM EmailMessage where parentId =:case_id];
                 setIdsofEmailMessages = new Set<Id>();
                 lstEmailMessages = [SELECT ActivityId,Subject,Incoming,FromAddress,ToAddress,status,MessageDate FROM EmailMessage where parentId =:case_id order by LastModifiedDate desc limit 100];
                 for(EmailMessage eMessage  : lstEmailMessages ){
                     setIdsofEmailMessages.add(eMessage.Id);
                 }
                 
                
             }


             public void GetAttachments(set<Id> EmailMessagesIds ){
                 List<Attachment> Attachments = new  List<Attachment>();
                 Attachments  = [select id,name,ParentId, BodyLength,LastModifiedDate from attachment where ParentId IN :EmailMessagesIds ];
                 lstEmailMessagesToAttachments = new List<EmailandAttachmentWrapper>();
                 
                 mapEmailMessagesToAttachments = new Map<Id, List<Attachment>>();
                 
                
                
                 for( Attachment attachmentlocal  : Attachments){
                 
                     if(mapEmailMessagesToAttachments.get(attachmentlocal.ParentId) != null ){
                             List<Attachment> lstAttachment =      mapEmailMessagesToAttachments.get(attachmentlocal.ParentId);
                             lstAttachment.add(attachmentlocal  );
                             mapEmailMessagesToAttachments.put(attachmentlocal.ParentId,lstAttachment);
                         }
                         else{
                             List<Attachment> lstAttachment =    new   List<Attachment>();
                             lstAttachment.add(attachmentlocal  );
                             mapEmailMessagesToAttachments.put(attachmentlocal.ParentId,lstAttachment);
                     }
                 }
                 
             }

             
              public void GeneratePageTables(){
                 //EmailandAttachmentWrapper instantEAWrapper = new EmailandAttachmentWrapper();
                 List<CustomAttachment> lstAttachments = new  List<CustomAttachment>();
                 List<Attachment> attachments = new  List<Attachment>();
                 for( EmailMessage eMessage  :  lstEmailMessages){
                     lstAttachments = new  List<CustomAttachment>();
                     attachments  = new  List<Attachment>(); 
                     attachments =  mapEmailMessagesToAttachments.get(eMessage.Id );
                     if(attachments == null ){
                          lstAttachments  = new List<customAttachment>();
                     }else{
                          for(Attachment a  : attachments ){
                            lstAttachments.add(new customAttachment(false, a));
                        }
                        lstEmailMessagesToAttachments.add(new EmailandAttachmentWrapper(eMessage ,lstAttachments));
                    }
                    
                    //lstEmailMessagesToAttachments.add(new EmailandAttachmentWrapper(eMessage ,lstAttachments));
                 }
            
                 System.debug('*******************'+lstEmailMessagesToAttachments) ; 
            
            }
        
             Public class EmailandAttachmentWrapper{
                 public EmailMessage eMessage{get; set;} 
                 public List<customAttachment> lstAttachments{get;set;}
                 public boolean emailMessageChkbox{get;set;}
                 
                 
                 public EmailandAttachmentWrapper(EmailMessage eMessage, List<customAttachment> lstAttachments ){
                     this.eMessage = eMessage ; 
                     this.lstAttachments  = lstAttachments ;
                 
                 }
                 
                 
                 
             }
            
             
             public class customAttachment{
                     public boolean attachmentCheckbox{get;set;}
                     public Attachment InstantAttachment{get;set;}
                     public customAttachment(boolean  attachmentCheckbox, Attachment InstantAttachment ){
                         this.attachmentCheckbox  = attachmentCheckbox;
                         this.InstantAttachment =  InstantAttachment ;
                     }
             }
             
             //For Notes and Attachments
             
             
             List<attachment> nattach=new List<attachment>();
             List<CustomAttachment> nandAttachments{get;set;}
             
             public List<CustomAttachment> getNandA()
             {
             
                 nandAttachments = new List<CustomAttachment>();
                 
                 nattach = [select id,name,Bodylength,LastModifiedDate, CreatedBy.Name from Attachment where ParentId=:Case_id order by LastModifiedDate desc limit 25];
                 System.debug('**'+nattach);
             
                 for(Attachment a  : nattach )
                    {
                        nandAttachments.add(new customAttachment(false, a));
                    }
                    return nandAttachments;
             
             
             }
             
             // For Chatter Attachments
             List<FeedItem>  lstcontentResult= new List<FeedItem>();
             List<FeedItem>  ChatAResult= new List<FeedItem>();
              public List<FeedItem> getChatA()
             {
             
             lstcontentResult=[Select Id,ContentFileName,ContentSize,ContentType,RelatedRecordId, Title, Type, CreatedBy.Name,CreatedDate, LastModifiedDate FROM FeedItem where ParentId=:Case_id]; 
             //System.debug('///'+lstcontentResult);
            for(FeedItem fItem:lstcontentResult ){
             
                 if(fItem.RelatedRecordId != null)
                 {
                 
                 ChatAResult.add(fItem);
                 }
             
             
             }
             
             System.debug('///'+ChatAResult);
             
             //return lstcontentResult;
             return ChatAResult;
             
             
             } 
             
             
              /*Zip Code*/
             
              public PageReference callExistingDocumentDelete() {
        
                 List<Document> lst = [Select Id, Description from Document where Description= 'MultiAttachment Feature - Mark for Deletion.'];
                 delete lst;
                 return null;
             }
             
             
              public String zipFileName {get; set;}
              public String zipContent {get; set;}
 
              public PageReference uploadZip() {
                 callExistingDocumentDelete();
        
                 if (String.isEmpty(zipFileName) ||
                     String.isBlank(zipFileName)) {
                     zipFileName = 'my_zip.zip';
                  }
                 else {
                     zipFileName.replace('.', '');
                     zipFileName += '.zip';
                 }
         
              Document doc = new Document();
              doc.Name = zipFileName;
              doc.ContentType = 'application/zip';
              doc.FolderId = UserInfo.getUserId();
              doc.Body = EncodingUtil.base64Decode(zipContent);
              doc.Description = 'MultiAttachment Feature - Mark for Deletion.';
              insert doc;
         
              this.zipFileName = null;
              this.zipContent = null;
 
              PageReference pageRef = new PageReference('/servlet/servlet.FileDownload?file=' + doc.Id);
              pageRef.setRedirect(true);
         
              return pageRef;
             }
 
              public List<Attachment> getAttachments() {
                 return [select Id, ParentId, Name, ContentType, BodyLength
                 from Attachment
                 limit 15];
             }
     
              
              public static Integer lengthOFZip = 0 ;
              
              @RemoteAction
              public static AttachmentWrapper getAttachment(String attId) {
                 System.debug('***'+attId);
                 
                boolean isAttach = attId.startsWith('00P');
                if(isAttach  == true ){
                System.debug('1112'+attId);
                                    
                 
                  Attachment att = [select Id, Name, ContentType, Body , Bodylength from Attachment where Id = :attId];
                  
                    Integer a = GE_OG_EmailAttachDownload.lengthOFZip ;
                   Integer b = att.Bodylength;
                   
                  GE_OG_EmailAttachDownload.lengthOFZip  = a+b;
                  AttachmentWrapper attWrapper = new AttachmentWrapper();
                  attWrapper = new AttachmentWrapper();
                  attWrapper.attEncodedBody = EncodingUtil.base64Encode(att.body);
                  attWrapper.TotalLength = att.Bodylength;
                  attWrapper.attName = att.Name;
                  System.debug('123$$'+attWrapper);
                  return attWrapper;
             
                          
                          }
                          
                 else{
                 
                  System.debug('1113'+attId);
                  
                  FeedItem att=[Select Id,ContentSize,ContentData,ContentFileName, ContentType,Title,CreatedDate, LastModifiedDate FROM FeedItem where Id=:attId];           
                   System.debug('1114'+attId);          
                                           
                   Integer a = GE_OG_EmailAttachDownload.lengthOFZip ;
                   Integer b = att.Contentsize;
                   
                  GE_OG_EmailAttachDownload.lengthOFZip  = a+b;
                  AttachmentWrapper attWrapper = new AttachmentWrapper();
                  attWrapper = new AttachmentWrapper();
                  attWrapper.attEncodedBody = EncodingUtil.base64Encode(att.ContentData);
                  attWrapper.TotalLength = att.ContentSize;
                  attWrapper.attName = att.ContentFileName;
                   System.debug('1115'+attId);
                 
                  return attWrapper;
                  
                  }
                 
             }
     
                   
     
     
             public class AttachmentWrapper {
                 public String attEncodedBody {get; set;}
                 public String attName {get; set;}
                 public Integer TotalLength{get;set;}
             }
      
        }