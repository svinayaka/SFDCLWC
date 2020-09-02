/*
* Name -        BHGE_MC_TS_CaseAction_Controller 
* Type-         Apex Class
* Author -      Raksha Shanbhag
* Date -        02/08/2019
* Test Class -  BHGE_MC_TS_CaseAction_Controller_Test
* Description -  
* */
public without sharing class BHGE_MC_TS_CaseAction_Controller {
    
   
    
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
        
       // if(caseRec.accountId!=null && caseRec.contactId!=null){
            //case record type flip logic
            if(caseRec.recordTypeId == recTypeMcTS){
                caseRec.RecordTypeId = recTypeMcsCS;
                caseRec.Type = 'Customer Service';
             }            
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
       // }
       // else
       //     result = 'validation error';
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
    public static string acceptCase(string caseId)
    {
        string result = null;
        Case caseObj= [Select id,GE_ES_Sub_Type__c, OwnerId From Case where id =: caseId];
        
        caseObj.OwnerId =  UserInfo.getUserId();
        caseObj.Status = 'Open';
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
    public static Case caseDetailServer(String caseId)
    { 
         id currentUserId = UserInfo.getUserId();
         Case caseRec = [Select id,OwnerId,GE_ES_Sub_Type__c,GE_Tier_3__c,Account.Name,
                         Customer_RFQ__c,GE_PW_RMA__c,GE_OG_Quote__c,Contact.Name, GE_OG_MCS_Modality__c,
                         GE_DS_Billing_Region__c,CurrencyIsoCode, GE_ES_PO__c,GE_ES_Shop_Order__c,
                         GE_ES_Customer_Request_Date__c,GE_ES_Env_Case_Amount__c,Site_Contact_Information__c,
                         GE_DS_Amount_Invoiced__c,Status,CaseNumber,GE_OG_MCS_TAT_Cause__c,GE_OG_MCS_TAT_Explanation__c,
                         AccountId, ContactId,GE_OG_CIR_Component__c,Item__c,Item_Description__c,Item_Description_1__c,
                         Component__c,GE_OG_CIR_Customer_Email__c,GE_OG_Issue_Event_Date_CIR__c,GE_OG_Customer_Want_Date_CIR__c,
                         GE_OG_Resolution_Committed_date_CIR__c,GE_OG_Resolution_Forecasted_Date_CIR__c,GE_OG_Final_TS_Solution__c,Product_Hierarchy__c,GE_OG_MC_TS_Final_Issue__c,GE_OG_Case_Cancellation_Note_CIR__c,GE_OG_Sub_Business_CIR__c,GE_OG_CIR_Assembly__c from Case where id =: caseId LIMIT 1];                     
         return caseRec;
    }
    
    @AuraEnabled
    public static string updateCaseServer(case caseRecord)
    {
        
        string returnMessage = null;
        //case cs = new case(id = caseRecord.id= caseRecord.Id);
         case cs= new case(id = caseRecord.id); 
        cs.Status = 'Closed';
        //cs.Site_Contact_Information__c = caseRecord.Site_Contact_Information__c;
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
     
   @AuraEnabled 
    public static string fetchProfile(){
     // query current user information  
        Profile p = [SELECT Id, Name FROM Profile WHERE Id =:UserInfo.getProfileId() limit 1];
        system.debug('--profile---'+p.Name);
        return p.Name;
  }
  
  @AuraEnabled
    public static Boolean getTaskInfo(String caseId)
    { 
         Boolean flag = false;
         List<Task> taskInfo =[SELECT status,subject,IsClosed FROM task WHERE whatid=:caseId and Status NOT IN ('Closed','Completed','Cancelled') LIMIT 1000];
         
         system.debug('--taskInfo----'+taskInfo);
         if(taskInfo.size()>0){
             flag =true;
         }
           
         return flag;
    }
    @AuraEnabled 
    public static Id fetchRecordTypeId(){
     // query current user information  
        Id devRecordTypeId = Schema.SObjectType.Deal_Machine__kav.getRecordTypeInfosByName().get('MC-TS Article').getRecordTypeId();
        return devRecordTypeId;
  }
  /*@AuraEnabled 
    public static void updateArticleOnCase(String knowledgeId,String caseId){
      CaseArticle ca = new CaseArticle();
      ca.CaseId = caseId;
      ca.KnowledgeArticleId = knowledgeId;
      insert ca;   
    }
 */

}