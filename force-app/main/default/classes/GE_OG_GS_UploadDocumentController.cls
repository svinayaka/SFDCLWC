/*
 * Technician attachment upload controller
 * Get chatter groupid from Technician attachment custom setting
 * Attched document to above groupid.
 */
public class GE_OG_GS_UploadDocumentController {
    
    public FeedItem post{get;set;}
    private String parentId;
    public Boolean isAttachmentSaved {get;set;}
    
    public GE_OG_GS_UploadDocumentController (){
        this.post = new FeedItem();
        isAttachmentSaved = false;
        parentId = ApexPages.currentPage().getparameters().get('id');
    }
    
    /*
     * Upload technician attachment 
     */
    public PageReference upload(){
        try{
            //check file selected or not
            if(String.isBlank(post.ContentFileName)){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select document.'));    
            }else{
                
                GE_OG_GS_Technician_Attachment__c objTechAttachment = new GE_OG_GS_Technician_Attachment__c();
                String strRecordTypeName; 
                if(parentId != null)
                {
                    objTechAttachment = [Select RecordType.Name from GE_OG_GS_Technician_Attachment__c where Id =: parentId];
                    if(objTechAttachment != null)
                    strRecordTypeName = objTechAttachment.RecordType.Name;
                }
                
                isAttachmentSaved = true;
                // Get CollaborationGroup name and Id from custom setting 
                GE_OG_GS_Technician_Attachment_Setting__c atSetting;
                
                 List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
                 String MyProflieName = PROFILE[0].Name;
                
                System.debug('****Record Type******'+strRecordTypeName);
                
                if(strRecordTypeName == 'GE_Subsea' || strRecordTypeName == 'GE DS'){
                        atSetting = GE_OG_GS_Technician_Attachment_Setting__c.getInstance(UserInfo.getProfileId());
                        }
                        
                  else if(MyProflieName == 'BHGE PT Admin User')
                              {
                                 
                                 atSetting = GE_OG_GS_Technician_Attachment_Setting__c.getInstance(UserInfo.getProfileId());
                                 
                              }          
                        
                else {
                    atSetting = GE_OG_GS_Technician_Attachment_Setting__c.getOrgDefaults();
                    }
                post.ParentId = atSetting.GE_OG_GS_Chatter_Gruop_Id__c;
                insert post;
                ContentDocument document = [select id from ContentDocument 
                                            where OwnerId =: UserInfo.getUserId()
                                            order by LastModifiedDate desc limit 1];
                GE_OG_GS_Technician_Attachment__c attach = new GE_OG_GS_Technician_Attachment__c();
                attach.Id = parentId;
                attach.GE_OG_GS_Download_Link_to_Document__c = buildDocumentDownloadURl(atSetting.GE_OG_GS_SF_Instance_URL__c,document.Id);
                attach.GE_OG_GS_TA_Link_to_Document__c = atSetting.GE_OG_GS_SF_Instance_URL__c+'/'+document.Id;
                System.debug(LoggingLevel.INFO,'LinkUrl = '+attach.GE_OG_GS_TA_Link_to_Document__c);
                update attach;
            }
        }catch(Exception e){
            String error = e.getMessage();
            isAttachmentSaved = false;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,error));
            System.debug(LoggingLevel.ERROR,'Exception = '+e.getMessage());
        }
        post = new FeedItem ();
        return null;
    }
    
    /*
     * Find uploaded document and build download url;
     */
    private String buildDocumentDownloadURl(String instanceUrl,String documentId){
        ContentVersion cv = [select id, ContentUrl from ContentVersion where ContentDocumentId =:documentId];
        String docURL = instanceUrl
                        +'/sfc/servlet.shepherd/version/download/'+cv.Id
                        +'?asPdf=false&operationContext=CHATTER';
        return docURL;
    }
 
}