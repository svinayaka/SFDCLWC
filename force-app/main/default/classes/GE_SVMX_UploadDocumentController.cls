public without sharing class GE_SVMX_UploadDocumentController {
     @AuraEnabled
     public static void Upload(Id TaId, string docId){  
        List<FeedItem> feedsToInsertInMetadataChatterGroups = new List<FeedItem>() ;
        List<FeedItem> feedsToInsertInSettingChatterGroups = new List<FeedItem>() ;   
        List<GE_OG_GS_Technician_Attachment__c> techAttachmentToUpdate = new List<GE_OG_GS_Technician_Attachment__c>() ;
        List<GE_OG_GS_Technician_Attachment_Setting__c> customSettingList = new  List<GE_OG_GS_Technician_Attachment_Setting__c>() ; 
        List<ContentVersion> contentVersionToUpdate = new List<ContentVersion>() ;
        Set<Id> insertedFeedRecordIdSet = new Set<Id>() ;   
        Map<String,Technician_Attachment_ExtRM__mdt> technicianAttachmentMetadataMap = new Map<String,Technician_Attachment_ExtRM__mdt>() ;
        Map<String,Boolean> currentUserMemberShipDetailsMap = new Map<String,Boolean>();
        Map<String,ContentVersion> contentVersionWithContentDocMap = new Map<String,ContentVersion>() ; 
        Map<String,String> technicianAttachmentWithMetaDataFeedMap = new Map<String,String>() ;
        Map<String,String> technicianAttachmentWithSettingFeedMap = new Map<String,String>() ;        
        Map<String,String> technicianAttachmentWithMetadataDocLinkMap = new Map<String,String>() ;
        Map<String,String> technicianAttachmentWithSettingDocLinkMap = new Map<String,String>() ;              
        GE_OG_GS_Technician_Attachment_Setting__c customSettingRecord = GE_OG_GS_Technician_Attachment_Setting__c.getOrgDefaults() ;
        customSettingList.add(customSettingRecord) ;
        GE_OG_GS_Technician_Attachment__c objTechAttachment = new GE_OG_GS_Technician_Attachment__c();
        objTechAttachment.Id = TaId;   
        Database.SaveResult[] metaDataChatterFeedInsertRecordDetails , settingChatterFeedInsertRecordDetails   ;      
        
        ContentDocument Doc= [select id,Title,FileExtension,FileType from ContentDocument where id=: docId];
  
                   
        for(Technician_Attachment_ExtRM__mdt techMetaDataRecord : [SELECT  
                                                                         Id,Chatter_Group_Id__c,
                                                                         MasterLabel,Chatter_Group_Name__c,
                                                                         Public_Group_Name__c,SF_Instance_URL__c 
                                                                         FROM Technician_Attachment_ExtRM__mdt ]){
            technicianAttachmentMetadataMap.put(techMetaDataRecord.Public_Group_Name__c,techMetaDataRecord) ;                                                           
        }
        
        for(GroupMember grpMemberDetails : [SELECT  
                                                  group.name,
                                                  group.DeveloperName 
                                                  FROM GroupMember 
                                                  WHERE UserOrGroupId =: UserInfo.getUserId()]) {
           if(technicianAttachmentMetadataMap.containsKey(grpMemberDetails.group.name)){
                currentUserMemberShipDetailsMap.put(grpMemberDetails.group.name,True) ; 
           }else{
                currentUserMemberShipDetailsMap.put(grpMemberDetails.group.name,False) ;
           }                  
        }
        
        for(ContentVersion conVersion : [SELECT 
                                               Id,Title,
                                               VersionData,
                                               FileExtension,
                                               contentDocumentId,
                                               SharingOption,
                                               FileType 
                                               FROM ContentVersion 
                                               WHERE contentDocumentId =:Doc.id]){
            contentVersionWithContentDocMap.put(conVersion.contentDocumentId,conVersion) ;                                         
        }
        
        //The parent technician attachment record sharing is being explicitly deleted so that the document is accessible to only the group members
         ContentDocumentLink  Docdel= [select id,LinkedEntityId,contentdocumentID  from ContentDocumentLink where contentdocumentID  =:docId AND LinkedEntityId=: TaId];
              delete Docdel;
        
        for(Technician_Attachment_ExtRM__mdt metadataRecord : technicianAttachmentMetadataMap.values()){
            if(currentUserMemberShipDetailsMap.get(metadataRecord.Public_Group_Name__c) == True){
                FeedItem feedPost= new FeedItem();
                feedPost.ParentId = metadataRecord.Chatter_Group_Id__c ;
                feedPost.body = contentVersionWithContentDocMap.get(Doc.id).Title;               
                feedPost.Title= contentVersionWithContentDocMap.get(Doc.id).Title ;                
                feedsToInsertInMetadataChatterGroups.add(feedPost) ;
                technicianAttachmentWithMetadataDocLinkMap.put(TaId,metadataRecord.SF_Instance_URL__c) ;   
            }       
        }
        
        for(GE_OG_GS_Technician_Attachment_Setting__c hierarchySettingRecord : customSettingList ){
                FeedItem feedPostItem= new FeedItem();
                feedPostItem.ParentId = hierarchySettingRecord.GE_OG_GS_Chatter_Gruop_Id__c ;
                feedPostItem.body = contentVersionWithContentDocMap.get(Doc.id).Title;               
                feedPostItem.Title = contentVersionWithContentDocMap.get(Doc.id).Title ;                              
                feedsToInsertInSettingChatterGroups.add(feedPostItem) ;                
                objTechAttachment.GE_OG_GS_Download_Link_to_Document__c = buildDocumentDownloadURl(hierarchySettingRecord.GE_OG_GS_SF_Instance_URL__c,doc.Id);
                technicianAttachmentWithSettingDocLinkMap.put(TaId,hierarchySettingRecord.GE_OG_GS_SF_Instance_URL__c) ;
                objTechAttachment.GE_OG_GS_TA_Link_to_Document__c = hierarchySettingRecord.GE_OG_GS_SF_Instance_URL__c+doc.Id;
                techAttachmentToUpdate.add(objTechAttachment) ;       
        }
        
      
        
        if(techAttachmentToUpdate.size() > 0){
                try{
                    update techAttachmentToUpdate ;
                }catch(DMLException e){
                    system.debug('There is an error while updating technician attachment' + e.getMessage()) ;
                }
        }
        
        if(feedsToInsertInMetadataChatterGroups.size() > 0){
                try{
                    metaDataChatterFeedInsertRecordDetails = Database.insert(feedsToInsertInMetadataChatterGroups,false) ;
                }catch(DMLException e){
                    system.debug('There is an error while creating feed' + e.getMessage()) ;
                }
        }
        
        if(feedsToInsertInSettingChatterGroups.size() > 0){
                try{
                    settingChatterFeedInsertRecordDetails = Database.insert(feedsToInsertInSettingChatterGroups,false) ;
                }catch(DMLException e){
                    system.debug('There is an error while creating feed' + e.getMessage()) ;
                }
        }         
        
        for(Database.SaveResult resultRecords : metaDataChatterFeedInsertRecordDetails){
            if(resultRecords.isSuccess()){
                insertedFeedRecordIdSet.add(resultRecords.getId()) ;
                technicianAttachmentWithMetaDataFeedMap.put(TaId,resultRecords.getId()) ;
            }
        }
        
        for(Database.SaveResult resultRecords : settingChatterFeedInsertRecordDetails){
            if(resultRecords.isSuccess()){
                insertedFeedRecordIdSet.add(resultRecords.getId()) ;
                technicianAttachmentWithSettingFeedMap.put(TaId,resultRecords.getId()) ;
            }
        } 
              
        
        insertFeedAttachmentRecord(insertedFeedRecordIdSet,contentVersionWithContentDocMap,docId);
     }      
        
       public static String buildDocumentDownloadURl(String instanceUrl,String documentId){
            ContentVersion cv = [select id, ContentUrl,FileExtension from ContentVersion where ContentDocumentId =:documentId];
            String docURL = instanceUrl+'sfc/servlet.shepherd/version/download/'+cv.Id+'?asPdf=false&operationContext=CHATTER';
            return docURL;
       }
       
       public static void insertFeedAttachmentRecord(Set<Id> feedItemIdSet , Map<String,ContentVersion> conVersionWithContentDocMap,String documentId){
            List<FeedAttachment> feedAttachmentListToInsert = new List<FeedAttachment>() ;
            for(Id feedItemRecordId : feedItemIdSet){
                FeedAttachment feedAtt = new FeedAttachment () ;
                feedAtt.FeedEntityId = feedItemRecordId ;
                feedAtt.RecordId = conVersionWithContentDocMap.get(documentId).Id ;
                feedAtt.Title = conVersionWithContentDocMap.get(documentId).Title ;
                feedAtt.Type = 'Content' ;
                feedAttachmentListToInsert.add(feedAtt) ;                
            } 
            
            if(feedAttachmentListToInsert.size() > 0){
                try{
                    insert feedAttachmentListToInsert ;
                }catch(DMLException e){
                    system.debug('There is an error while inserting feed attachment' + e.getMessage()) ;
                }
            }
       }
}