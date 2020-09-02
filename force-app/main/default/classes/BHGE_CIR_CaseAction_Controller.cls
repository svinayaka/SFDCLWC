/*
* Name -        BHGE_CIR_CaseAction_Controller 
* Type-         Apex Class
* Author -      Raksha Shanbhag
* Date -        02/08/2019
* Test Class -  BHGE_CIR_CaseAction_Controller_Test
* Description -  
* */
public without sharing class BHGE_CIR_CaseAction_Controller {
    
    @AuraEnabled
    public static Case caseDetailServer(String caseId)
    { 
         id currentUserId = UserInfo.getUserId();
         Case caseRec = [Select id,OwnerId,GE_ES_Sub_Type__c,GE_Tier_3__c,Account.Name,
                         Customer_RFQ__c,GE_PW_RMA__c,GE_OG_Quote__c,Contact.Name, GE_OG_MCS_Modality__c,
                         GE_DS_Billing_Region__c,CurrencyIsoCode, GE_ES_PO__c,GE_ES_Shop_Order__c,
                         GE_ES_Customer_Request_Date__c,GE_ES_Env_Case_Amount__c,Site_Contact_Information__c,
                         GE_DS_Amount_Invoiced__c,Status,CaseNumber,GE_OG_MCS_TAT_Cause__c,GE_OG_MCS_TAT_Explanation__c,
                         AccountId, ContactId,GE_OG_CIR_Component__c,GE_OG_CIR_Assembly__c,Item__c,Item_Description__c,Item_Description_1__c,
                         Component__c,GE_OG_CIR_Customer_Email__c,GE_OG_Issue_Event_Date_CIR__c,GE_OG_Customer_Want_Date_CIR__c,
                         GE_OG_Resolution_Committed_date_CIR__c,GE_OG_Resolution_Forecasted_Date_CIR__c,GE_OG_Final_TS_Solution__c,GE_OG_MC_TS_Final_Issue__c,GE_OG_Case_Cancellation_Note_CIR__c,
                         GE_OG_Correction_CIR__c,GE_OG_CIR_NC_Screening__c,GE_OG_CIR_Defect_Code_Lev_1__c,GE_OG_CIR_Defect_Code_Lev_2__c,GE_OG_CIR_Safer_case__c,GE_OG_EHS_Product_Safety_CIR__c,GE_OG_CIR_Type_of_Issue__c,
                         GE_OG_NCA_RCA_value_CIR__c,GE_OG_Send_Back_Reason_Description_CIR__c,GE_OG_Customer_Feedback_CIR__c,GE_OG_Escalation_Level_CIR__c,GE_OG_Confirm_Escalated_CIR__c from Case where id =: caseId LIMIT 1];                     
         return caseRec;
    }
    
    @AuraEnabled
    public static string updateCase(case caseRecord,String caseStatus)
    {
        system.debug('--caseStatus---'+caseStatus);
        string returnMessage = null;
        //case cs = new case(id = caseRecord.id= caseRecord.Id);
         case cs= new case(id = caseRecord.id); 
         if(caseStatus == 'SendBack'){
             cs.Status = 'Open';
             cs.GE_OG_Resolution_Forecasted_Date_CIR__c=null;
             cs.GE_OG_CIR_Case_Resolution_Date__c=null;
         }else{
              cs.Status = caseStatus; 
         }
        try{
        update cs;
        system.debug('case reco----'+cs);
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
    public static string acceptCase(string caseId)
    {
        String result; 
        Case currentCase = [select RecordTypeId,OwnerId,status,origin from case where id =:caseId];
        if(currentCase.origin== null ||currentCase.origin== ''||(currentCase.origin!= null && currentCase.Origin !='askDrilling System'))
        {
            String CaseOwner = currentCase.OwnerId;
            Id CurrentUserId = UserInfo.getUserId();
            user u=[select id,profileid from user where id=: UserInfo.getUserId()];
            profile p = [select id,name from profile where id=:u.profileid];
            
            if(p.name=='GE_OG_Super User' && currentCase.status=='New')
            {
                
                currentCase.Ownerid = UserInfo.getUserId();
                currentCase.status= 'Open';
                try{
                  
                    update currentCase;
                    result = 'Owner Updated Successfully';
                 }
                catch(Exception e){
                    result = e.getMessage();
                    system.debug('G*G errorMessage'+e.getMessage());
                throw new AuraHandledException(result);
                }
               
            }
            else if(p.name=='GE_OG_Super User' && currentCase.status!='New')
            {
                
                currentCase.Ownerid = UserInfo.getUserId();
                try{
                    update currentCase;
                    result = 'Owner Updated Successfully';
                }
                catch(Exception e){
                    result = e.getMessage();
                    system.debug('G*G errorMessage'+e.getMessage());
                    throw new AuraHandledException(result);
                }
            }
            else
            {
            if(CaseOwner.contains('00G'))
            {
                List<GroupMember> groups = [select Id from GroupMember where Group.Type = 'Queue' and GroupId =:CaseOwner and UserOrGroupId =:CurrentUserId ];
                if(groups.size()>0) 
                {
                    
                    currentCase.Ownerid = UserInfo.getUserId();
                    currentCase.status= 'Open';
                    try
                    {
                        update currentCase;
                        result = 'Owner Updated Successfully';
                    }catch(Exception e){
                    result = e.getMessage();
                    system.debug('G*G errorMessage'+e.getMessage());
                    throw new AuraHandledException(result);
                    }
                     
                }
                else
                {
                    result = 'You are not the member of the queue';
                }
            }
            else{
                result = 'You cannot own the case';
            }
               
                  
           } 
       }
       return result;
        
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
    
    
    

}