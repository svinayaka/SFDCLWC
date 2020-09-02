/**
 * 
 * Class/Trigger Name--: O_CampaignInactiveOwnerUpdate
 * Purpose/Overview----: This Batch Apex class is used to update the Inactive Campaign owners called from O_CampaignSchedule
 * Author--------------: Sonali Rathore
 * Created Date--------: 19-Mar-2018
 * Test Class Name-----:     
 * Scrum               : Opportunity Scrum              
 * LastModifiedBy      : Sonali Rathore
   
**/


global class O_CampaignInactiveOwnerUpdate implements Database.Batchable<sObject>, Database.Stateful
{
      List<Id> failedCmpgnIDs=new List<Id>(); 
      List<Id> successCmpgnIDs=new List<Id>();
    Map<Id, String> errorMap    = new Map<Id, String>();  
  global Database.QueryLocator start(Database.BatchableContext BC)
  {
      String completed='Completed';
      String aborted='Aborted';
       String queryCampaign = 'Select Id,OwnerId,Owner.IsActive,Campaign_Support_ge_og__r.IsActive,Commercial_owner_Telesales_script_ge_og__r.IsActive,Subject_Matter_Expert_ge_og__r.IsActive,RecordTypeId from Campaign';
      
      System.debug('---------------------Query in batch::'+queryCampaign);
      return Database.getQueryLocator(queryCampaign);
  }

  global void execute(Database.BatchableContext BC, List<Campaign> campaignList)
  {
       System.debug('---------------------campaignList size::'+campaignList.size());
      List<Campaign> listCampaign= new List<Campaign>();
      Map<Id, Campaign> campaignMap = new Map<Id, Campaign>();
       for(Campaign cmpgn : campaignList)
       {    
           
            system.debug('&&&&&campaignList&&&&&&'+campaignList);
            if(cmpgn.Owner.IsActive == FALSE){
            cmpgn.OwnerId=System.Label.Campaign_User;
            //updCampaignList.add(cmpgn) ;
            //campaignMap.put(cmpgn.id, cmpgn);
             }
            system.debug('%%%cmpgn.Campaign_Support_ge_og__r.IsActive^^^^'+cmpgn.Campaign_Support_ge_og__r.IsActive);
            if(cmpgn.Campaign_Support_ge_og__r.IsActive == FALSE){
            cmpgn.Campaign_Support_ge_og__c=System.Label.Campaign_User;
            //updCampaignList.add(cmpgn) ;
            }
            if(cmpgn.Commercial_owner_Telesales_script_ge_og__r.IsActive == FALSE){
            cmpgn.Commercial_owner_Telesales_script_ge_og__c=System.Label.Campaign_User;
            //updCampaignList.add(cmpgn) ;
            }
            if(cmpgn.Subject_Matter_Expert_ge_og__r.IsActive == FALSE){
            cmpgn.Subject_Matter_Expert_ge_og__c=System.Label.Campaign_User;
            //updCampaignList.add(cmpgn) ;
            }
           listCampaign.add(cmpgn) ;
        }
        
        try{
        System.debug('---------------------> Going to Update campaign list:'+listCampaign );    
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
                system.debug('from execute... '+errorMap.get(listCampaign[index].Id));
                
                 
            }
             if(sr.isSuccess()){
                 // Operation was Successful, so get the ID of the record that was processed
                 System.debug('Success Campaign Member Ids: ' + sr.getId());
                 successCmpgnIDs.add(sr.getId());
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
        AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
        TotalJobItems, CreatedBy.Email, ExtendedStatus
        from AsyncApexJob where Id = :BC.getJobId()];
        String sBreak = '</br>';
        String toAddress = System.Label.CampaignBatchLabel_GE_OG;
        String[] toAddresses = toAddress.split(',');
        
         // Creating the CSV file
            String finalstr = 'Id, Error \n';
            //String subject =  'Account Merge - Batch Error List';
            String attName = 'Campaign Errors.csv';
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
        mail.setSubject('BatchJob Campaign Scheduler Status: ' + a.Status);
        mail.setPlainTextBody('The batch Apex job to update Campaign records '
             + 'has finished.The batch Apex job processed ' + a.TotalJobItems +
                ' records with'+' '+ errorMap.size() + ' failures. Please find the error list attached to the email');
   
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
  }

}