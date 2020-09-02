/*
* Name -        GE_OG_LI_CaseAction_Controller
* Type-         Apex Class
* Author -      Gautam Kumar
* Date -        07/24/2018
* Test Class -  GE_OG_LI_CaseAction_Controller_Test
* Description - This class will be the controller for the lightning quick action to flip case record types. 
* */
public without sharing class GE_OG_LI_CaseAction_Controller {
    
    
    
    /*@parameter - the id of the case record 
     * @return - string to show the success error state of the operation  
     * @description - this method will be used to flip the case recordtype from cs to ts and vice -a -versa. 
     * */
    @AuraEnabled
    public static string flipCaseRecordTypeServer(string caseId){
        
        //Get the recordtype Ids for the 2 case record types
        string recTypeMcTS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
        string recTypeMcsCS = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
        system.debug('G*G caseId '+caseId);
        system.debug('G*G rec1'+recTypeMcTS);
        system.debug('G*G rec2'+recTypeMcsCS);
        string result = null;// variable to store return value
        //query the case record for the existing recordType
        Case caseRec = [Select Id,recordTypeId,accountId,contactId from case where Id=:caseId LIMIT 1];
        system.debug('G*G recTypeId'+caseRec);
        
        if(caseRec.accountId!=null && caseRec.contactId!=null){
            //case record type flip logic
            if(caseRec.recordTypeId == recTypeMcTS)
                caseRec.RecordTypeId = recTypeMcsCS;
            
            else
                caseRec.RecordTypeId = recTypeMcTS;
            
            try{
            update caseRec;//update case record with the new record type. 
            system.debug('G*G updated recType'+caseRec.RecordTypeId);
            result ='update success';
            }
            catch(Exception e){
                result = e.getMessage();
                system.debug('G*G errorMessage'+e.getMessage());
                throw new AuraHandledException(result);
            }
        }
        else
            result = 'validation error';
        return result;
    }
    
    @AuraEnabled
    public static string moveToTrashBin(string caseId){
        string result = null;
        List<QueueSobject> MC_Trashbin = new List<QueueSobject>();
        Case caseRec = [Select Id,recordTypeId,accountId,contactId,ownerId from case where Id=:caseId LIMIT 1];
        MC_Trashbin = [select id,Queue.Name,QueueId from QueueSobject where Queue.Name=:'MC_TRASHBIN'];
        if(!MC_Trashbin.isEmpty()){
            caseRec.ownerId = MC_Trashbin.get(0).QueueId;
            try{
            update caseRec;
            result = 'updated successfully';
            }
            catch(Exception e){
                result = e.getMessage();
                system.debug('G*G errorMessage'+e.getMessage());
                throw new AuraHandledException(result);
            }
        }
        return result;
    }
    
    @AuraEnabled
    public static string cloneCaseAndAttachServer(string caseId){
        string result = null;
        try{
        case clonedCaseRecord = cloneCaseRecord(caseId);
        insertAttachmentsToClonedCase(clonedCaseRecord.Id,caseId);
        result = clonedCaseRecord.Id;
        }
        catch(Exception e){
            result = e.getMessage();
            system.debug('G*G errorMessage'+e.getMessage());
            throw new AuraHandledException(result);
        }
        return result;
    }
    
    public static case cloneCaseRecord(string caseId){
        string soqlQuery,whereClause;
        whereClause= 'id=\''+caseId +'\'';
        soqlQuery = GE_ES_Utils.getCreatableFieldsSOQL('Case', whereClause);
        case currentCase  = (Case) Database.query(soqlQuery);
        Case caseRec = [Select Id,recordTypeId,accountId,contactId from case where Id=:caseId LIMIT 1];
        case clonedCaseRec = new case();
        clonedCaseRec = currentCase.clone(false, true);
        
        System.debug('clonedCaseRec :'+ clonedCaseRec );
        clonedCaseRec.GE_HQ_SFDC_LEGACY_ID__c=null;
        clonedCaseRec.Status=CurrentCase.Status;
        clonedCaseRec.Legacy_Thread_ID__c= null;
        clonedCaseRec.GE_HQ_LEGACY_AUTONUM__c= null;
        clonedCaseRec.ClosedDate = null;
        clonedCaseRec.Case_Age_Buffer__c=0;
        clonedCaseRec.status = 'Open';
        clonedCaseRec.RecordTypeId = caseRec.RecordTypeId;
        clonedCaseRec.OwnerId = userInfo.getUserId();
        //clonedCaseRec.parentId = caseId;
        insert clonedCaseRec;
        return clonedCaseRec;
    }
    
   
    public static void insertAttachmentsToClonedCase(string clonedCaseId,string parentCaseId){
        system.debug('G*G insert Attach called');
        list<ContentDocumentLink> contentDocumentLinkList = new list<ContentDocumentLink>();
        list<ContentDocument> contentDocumentList = new list<ContentDocument>();
        list<contentDocumentLink> insertContentDocumentLinkList = new list<contentDocumentLink>();
        set<id> documentIdSet = new set<id>();
        
        if(string.isNotBlank(parentCaseId)){
            for(ContentDocumentLink cdl: [SELECT Id,ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =: parentCaseId]){
                ContentDocumentLink link = new ContentDocumentLink();
                link.LinkedEntityId = clonedCaseId;
                link.ContentDocumentId = cdl.contentDocumentId;
                link.ShareType = 'V';
                link.Visibility = 'AllUsers';
                insertContentDocumentLinkList.add(link);
            }
        }
        system.debug('G*G insertContentDocumentLinkList'+insertContentDocumentLinkList.size());
        
        list<attachment> attachmentList = new list<attachment>();
        list<attachment> insertAttachmentList = new list<attachment>();
         attachmentList.addAll(getEmailAttachments(parentCaseId,clonedCaseId));
         //attachmentList.addAll(emailAtt(parentCaseId));
        system.debug('G*G attachmentList'+attachmentList);
        system.debug('G*G attachmentList size'+attachmentList.size());
        list<ContentVersion> contentVersionList = new list<ContentVersion>();
        
        if(!attachmentList.isEmpty()){
        system.debug('--inside if---');
            for(Attachment attach: attachmentList){
                //Attachment newAttach = attach.clone();
                Attachment newAttach = new Attachment(name = attach.name, body = attach.body,  parentid = clonedCaseId);
                system.debug('-inside for--');
                //newAttach.ParentId = clonedCaseId;
                system.debug('----after prent id--');
                insertAttachmentList.add(newAttach);
                system.debug('----afetr list---');
                system.debug('-insertAttachmentList----'+insertAttachmentList);
            }
            system.debug('-insertAttachmentList----'+insertAttachmentList);
        }
        
        system.debug('--insertContentDocumentLinkList------'+insertContentDocumentLinkList);
        if(!insertContentDocumentLinkList.isEmpty())
            insert insertContentDocumentLinkList;
       
        
        if(!insertAttachmentList.isEmpty())    
            insert insertAttachmentList;
    }
    
  
    
    private static list<attachment> getEmailAttachments(string caseId, string clonedCaseId){
        String Subject;
        String Subject1;
        String Subject2;
        Integer Position;
        Case ThreadId;
        ThreadId = [select Id, GE_CASE_THREAD_ID__C from Case where Id =: clonedCaseId];
               
        List<attachment> emailAttachmentList = new List<attachment>();
        Map<Id, EmailMessage> emailAttachmentMap = new Map<Id, EmailMessage>();
        
        for(EmailMessage em: [Select Id,FromAddress,FromName,Subject,MessageDate,Incoming,ToAddress,
                              ParentId,CcAddress,BccAddress,TextBody,ActivityId,Status
                              From EmailMessage 
                              Where ParentId = :caseId])
        {
            EmailMessage em2 = new EmailMessage();
            em2.TextBody = em.TextBody;
            em2.FromAddress = em.FromAddress;
            em2.FromName = em.FromName;
            em2.MessageDate = em.MessageDate;
            em2.ToAddress = em.ToAddress;
            em2.CcAddress = em.CcAddress;
            em2.BccAddress = em.BccAddress;
            em2.ParentId = clonedCaseId;
            em2.Status = em.Status;
            em2.Incoming =  em.Incoming;
            
             if(em.Subject!=null)
                {                 
                    Subject = em.Subject;
                    If(Subject.contains('[ ref:')){
                        Position = Subject.Indexof('[ ref:');
                        Subject1 = Subject.Left(Position);
                        Subject2 = Subject.Right(Subject.Length()-Position-31);
                        em2.Subject = Subject1 + ' '+ ThreadId.GE_CASE_THREAD_ID__C+ ' '+ Subject2;
                    }
                    else{
                        em2.Subject = em.Subject;
                    }
                 }
            emailAttachmentMap.put(em.Id, em2);
        }
        
        system.debug('emailAttachmentMap'+emailAttachmentMap);
        if(!emailAttachmentMap.isEmpty()) {
            system.debug('emailAttachmentMap'+emailAttachmentMap.values());
            insert emailAttachmentMap.values();
            for(Attachment a : [select id, name, ParentId, body from Attachment where ParentId in :emailAttachmentMap.keySet()]){
                {
                   // Attachment att2 = a.clone();
                    Attachment att2 = new Attachment(name = a.name, body = a.body);
                    att2.ParentId = emailAttachmentMap.get(a.ParentId).id; 
                    emailAttachmentList.add(att2);
                    
                }                             
            }
               
            }
        system.debug('J*J emailAttachList'+emailAttachmentList);
       
      return emailAttachmentList;
    
}

     
    
    @AuraEnabled  
    public static string acceptCase(string caseId)
    {
        string result = null;
        Case caseObj= [Select id,GE_ES_Sub_Type__c, OwnerId From Case where id =: caseId];
        
        caseObj.OwnerId =  UserInfo.getUserId();
        try{
        Update caseObj;
        result = 'Owner Updated Successfully';
        }
        catch(Exception e){
            result = e.getMessage();
            system.debug('G*G errorMessage'+e.getMessage());
            throw new AuraHandledException(result);
        }
        return result;
        
    }
    
    
    @AuraEnabled
    public static string returnCase(string caseId)
    {
        id currentUserId = UserInfo.getUserId();
        string result = null;
        Case caseObj= [Select id,GE_ES_Sub_Type__c,GE_OG_MCS_Previous_Owner_Name__c,GE_OG_MCS_Previous_Owner__c,OwnerId From Case where id =: caseId LIMIT 1];
        Id prevOwner =  caseObj.GE_OG_MCS_Previous_Owner__c;
        caseObj.OwnerId = prevOwner;
        try{
        Update caseObj;
        result = 'Owner Reverted';
        }
        catch(Exception e){
            result = e.getMessage();
            system.debug('G*G errorMessage'+e.getMessage());
            throw new AuraHandledException(result);
        }
        return result;
    }
    
    @AuraEnabled
    public static Case caseDetailServer(String caseId)
    { 
         id currentUserId = UserInfo.getUserId();
         Case caseRec = [Select id,OwnerId,GE_ES_Sub_Type__c,GE_Tier_3__c,Account.Name,
                         Customer_RFQ__c,GE_PW_RMA__c,GE_OG_Quote__c,Contact.Name, GE_OG_MCS_Modality__c,
                         GE_DS_Billing_Region__c,CurrencyIsoCode, GE_ES_PO__c,GE_ES_Shop_Order__c,
                         GE_ES_Customer_Request_Date__c,GE_ES_Env_Case_Amount__c,Site_Contact_Information__c,
                         GE_DS_Amount_Invoiced__c,Status,CaseNumber,GE_OG_MCS_TAT_Cause__c,GE_OG_MCS_TAT_Explanation__c,
                         AccountId, ContactId from Case where id =: caseId LIMIT 1];                     
         return caseRec;
    }
    
    @AuraEnabled
    public static string updateCaseServer(case caseRecord)
    {
        
        string returnMessage = null;
        //case cs = new case(id = caseRecord.id= caseRecord.Id);
         case cs= new case(id = caseRecord.id); 
        cs.Status = 'Closed';
        cs.Site_Contact_Information__c = caseRecord.Site_Contact_Information__c;
        try{
        update cs;
        returnMessage = 'Case updated successfully';
        }
        catch(Exception e){
            returnMessage = e.getMessage();
            system.debug('G*G errorMessage'+e.getMessage());
            throw new AuraHandledException(returnMessage);
        }
        return returnMessage;
       
        
     }
}