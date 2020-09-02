/**
 * 
 * Class/Trigger Name--: O_CampaignMemberInactiveOwnerUpdate
 * Purpose/Overview----: This Batch Apex class is used to update the Inactive Campaign owners called from O_CampaignMemberSchedule
 * Author--------------: Sonali Rathore
 * Created Date--------: 19-Mar-2018
 * Test Class Name-----:     
 * Scrum               : Opportunity Scrum              
 * LastModifiedBy      : Sonali Rathore
   
**/


global class O_CampaignMemberInactiveOwnerUpdate implements Database.Batchable<sObject>, Database.Stateful
{
    List<Id> failedCmpgnIDs=new List<Id>(); 
    List<Id> successCmpgnIDs=new List<Id>();
    Map<Id, String> errorMap    = new Map<Id, String>();  
  global Database.QueryLocator start(Database.BatchableContext BC)
  {
    String queryCampaignMem = 'Select id,Account_Primary_Sales_ge_og__c,Status,Status_ge_og__c,Has_CMR_Owner_ge_og__c,Has_Tier_P_L_ge_og__c,LeadId,ContactId,Owner_ge_og__c,Date_Assigned_ge_og__c,Last_Activity_Date_ge_og__c,Date_Qualifiying_Started_ge_og__c,Owner_ge_og__r.IsActive,Account_Primary_Sales_ge_og__r.IsActive from CampaignMember where ((Owner_ge_og__c !=\'\' and Owner_ge_og__r.IsActive=FALSE) or (Account_Primary_Sales_ge_og__c !=\'\' and Account_Primary_Sales_ge_og__r.IsActive=FALSE))';
    System.debug('---------------------Query in batch::'+queryCampaignMem );
    return Database.getQueryLocator(queryCampaignMem);
  }

  global void execute(Database.BatchableContext BC, List<CampaignMember> campaignMemList)
  {
       System.debug('---------------------campaignList size::'+campaignMemList.size());
       List<CampaignMember> listCampaign = new List<CampaignMember>();
       
       for(CampaignMember cmpgn : campaignMemList){
            if(cmpgn.Account_Primary_Sales_ge_og__r.IsActive == FALSE){
            cmpgn.Account_Primary_Sales_ge_og__c=System.Label.Campaign_User;
            }
            if(cmpgn.Owner_ge_og__r.IsActive == FALSE && cmpgn.Has_CMR_Owner_ge_og__c == TRUE){
            cmpgn.Owner_ge_og__c=System.Label.Campaign_User;
            }
            if((cmpgn.Status_ge_og__c== null || cmpgn.Status_ge_og__c=='') && cmpgn.Has_Tier_P_L_ge_og__c && (cmpgn.ContactId!=null || cmpgn.LeadId!=null) ){
                System.debug('--------->>>Going to update CMR status: Lead Prospecting');
                cmpgn.Status='Lead Prospecting';
                cmpgn.Status_ge_og__c='';
                
                if(cmpgn.Has_CMR_Owner_ge_og__c ){
                  System.debug('--------->>>Going to update CMR status: Lead Prospecting');    
                  cmpgn.Status='Lead Prospecting';
                  cmpgn.Status_ge_og__c='';
                    if(cmpgn.Date_Assigned_ge_og__c==null)
                       cmpgn.Date_Assigned_ge_og__c=System.today();
                    
                     if(cmpgn.Last_Activity_Date_ge_og__c!=null){
                      System.debug('--------->>>Going to update CMR status: Lead Qualifying');
                        cmpgn.Status='Lead Qualifying';
                        cmpgn.Status_ge_og__c='';
                        if(cmpgn.Date_Qualifiying_Started_ge_og__c==null)
                          cmpgn.Date_Qualifiying_Started_ge_og__c=System.today();
                    
                    }
                }
            }
            listCampaign.add(cmpgn);
        }
          
     try{
        System.debug('---------------------> Going to Update campaign Member list:'+listCampaign );    
        if(!listCampaign.isEmpty()) {
        //Update records
        System.debug('---------------------> Inside Database Update for campaign list size:'+listCampaign); 
        
        Database.SaveResult[] cmpgnList = Database.update(listCampaign, false);
        integer index=0;
        // Iterate through each returned result
        for (Database.SaveResult sr : cmpgnList) {
            if (!sr.isSuccess()) {
                // Operation was failed, so get the ID of the record that was processed
                System.debug('Errored Campaign Ids: ' + sr.getId());
                String errMsg = sr.getErrors()[0].getMessage();
                errorMap.put(listCampaign[index].Id, errMsg);
                system.debug('from execute... '+errorMap.get(listCampaign[index].Id));
                
                 
            }
             if(sr.isSuccess()){
                 // Operation was Successful, so get the ID of the record that was processed
                 System.debug('Success Campaign Member Ids: ' + sr.getId());
                 failedCmpgnIDs.add(sr.getId());
                 System.debug('Campaign Member fields that affected this error: ' + sr.getId());
            }
            index++;
        
        }
        
        }
        }catch(Exception exc){
        System.debug('----------------Got failed!!'+exc.getMessage());
        }
    
  } 

  global void finish(Database.BatchableContext BC)
  {
        // Get the AsyncApexJob that represents the Batch job using the Id from the BatchableContext
        AsyncApexJob a = [Select id,Status, NumberOfErrors, JobItemsProcessed,
        TotalJobItems, CreatedBy.Email, ExtendedStatus
        from AsyncApexJob where Id = :BC.getJobId()];
        String sBreak = '</br>';
        String toAddress = System.Label.CampaignBatchLabel_GE_OG;
        String[] toAddresses = toAddress.split(',');
        
         // Creating the CSV file
            String finalstr = 'Id, Error \n';
            //String subject =  'Account Merge - Batch Error List';
            String attName = 'CampaignMember Errors.csv';
            for(Id id  : errorMap.keySet()){
                string err = errorMap.get(id);
                string recordString = '"'+id+'","'+err+'"\n';
                finalstr = finalstr +recordString;
            } 
 
            // Define the email
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
 
            // Create the email attachment  
            if(!errorMap.isEmpty()){  
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(attName);
                efa.setBody(Blob.valueOf(finalstr));
                mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            }
        // Email the Batch Job's submitter that the Job is finished.
       // Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(toAddresses);
        mail.setSubject('BatchJob CampaignMember Scheduler Status: ' + a.Status);
        mail.setPlainTextBody('The batch Apex job to update Campaign Member records '
             + 'has finished.The batch Apex job processed ' + a.TotalJobItems +
                ' records with'+ errorMap.size() + ' failures. Please find the error list attached to the email');
   
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
  }

}