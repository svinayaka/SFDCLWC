/**
 * 
 * Class/Trigger Name--: O_CampaignBatchStatusUpdate
 * Purpose/Overview----: This Batch Apex class is used to update the Campaign status called from O_CampaignScheduleApex
 * Author--------------: Gourav Anand
 * Created Date--------: 14-Feb-2017
 * Test Class Name-----:     
 * Scrum               : Opportunity Scrum              
 * LastModifiedBy      : Gourav Anand
   
**/


global class O_CampaignBatchStatusUpdate implements Database.Batchable<sObject>
{
      Id themeRecType  = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Theme').getRecordTypeID();    
      Id programRecType  = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Program').getRecordTypeID();    
      Id cmpgnRecType = schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Campaign').getRecordTypeID();
      List<Id> failedCmpgnIDs=new List<Id>(); 
      List<Id> successCmpgnIDs=new List<Id>(); 
  global Database.QueryLocator start(Database.BatchableContext BC)
  {
      String completed='Completed';
      String aborted='Aborted';
      String queryCampaign = 'Select Id,RecordTypeId,Has_Owner_ge_og__c, EndDate, StartDate, Has_Start_Date_ge_og__c,Has_End_Date_ge_og__c,Has_Documentation_Support_ge_og__c,Has_Owner_Function_ge_og__c,Contains_NPI_ge_og__c,Has_Tier_2_ge_og__c,Has_Campaign_Type_ge_og__c,Has_Campaign_Business_Obj_ge_og__c,Has_Target_Region_ge_og__c,Has_TARGET_INDUSTRY_ge_og__c,Has_Target_Personas_ge_og__c,Has_Channel_Partner_Coverage_ge_og__c,Has_Target_Opportunities_ge_og__c,Has_Opportunity_Value_ge_og__c,Has_Actual_Cost_ge_og__c,Is_End_Date_Less_Today_ge_og__c,Is_End_Date_Grt_Today_ge_og__c,Is_Start_Date_Less_Today_ge_og__c,Is_Start_Date_Grt_Today_ge_og__c from Campaign where (Status NOT IN (\'Completed\',\'Aborted\'))' ;
      //String queryCampaign = 'Select Id,RecordTypeId,Has_Owner_ge_og__c, EndDate, StartDate, Has_Start_Date_ge_og__c,Has_End_Date_ge_og__c,Has_Documentation_Support_ge_og__c,Has_Owner_Function_ge_og__c,Contains_NPI_ge_og__c,Has_Tier_2_ge_og__c,Has_Campaign_Type_ge_og__c,Has_Campaign_Business_Obj_ge_og__c,Has_Target_Region_ge_og__c,Has_TARGET_INDUSTRY_ge_og__c,Has_Target_Personas_ge_og__c,Has_Channel_Partner_Coverage_ge_og__c,Has_Target_Opportunities_ge_og__c,Has_Opportunity_Value_ge_og__c,Has_Actual_Cost_ge_og__c,Is_End_Date_Less_Today_ge_og__c,Is_End_Date_Grt_Today_ge_og__c,Is_Start_Date_Less_Today_ge_og__c,Is_Start_Date_Grt_Today_ge_og__c from Campaign where (campaign_id_ge_og__c = \'70112000000ZSUKAA4\')';
      System.debug('---------------------Query in batch::'+queryCampaign);
      return Database.getQueryLocator(queryCampaign);
  }

  global void execute(Database.BatchableContext BC, List<Campaign> campaignList)
  {
       System.debug('---------------------campaignList size::'+campaignList.size());
       List<Campaign> updCampaignList = new List<Campaign>();
       for(Campaign cmpgn : campaignList)
       {
           if((cmpgn.RecordTypeId==themeRecType  && cmpgn.Has_Owner_ge_og__c && cmpgn.Has_Start_Date_ge_og__c && cmpgn.Has_End_Date_ge_og__c && cmpgn.Has_Documentation_Support_ge_og__c)
               //removed Documentation support & Contains NPI for Program
                || (cmpgn.RecordTypeId==programRecType && cmpgn.Has_Owner_ge_og__c && cmpgn.Has_Start_Date_ge_og__c && cmpgn.Has_End_Date_ge_og__c && cmpgn.Has_Owner_Function_ge_og__c)
                ||(cmpgn.RecordTypeId==cmpgnRecType && cmpgn.Has_Tier_2_ge_og__c && cmpgn.Has_Owner_Function_ge_og__c && cmpgn.Has_Campaign_Type_ge_og__c && cmpgn.Has_Campaign_Business_Obj_ge_og__c 
                    && cmpgn.Has_End_Date_ge_og__c && cmpgn.Has_Target_Region_ge_og__c && cmpgn.Has_TARGET_INDUSTRY_ge_og__c && cmpgn.Has_Target_Personas_ge_og__c && 
                     cmpgn.Has_Channel_Partner_Coverage_ge_og__c && cmpgn.Has_Target_Opportunities_ge_og__c
                   && cmpgn.Has_Opportunity_Value_ge_og__c && cmpgn.Has_Actual_Cost_ge_og__c )
              ){ 
                 if(cmpgn.Is_Start_Date_Grt_Today_ge_og__c && cmpgn.Is_End_Date_Grt_Today_ge_og__c){
                    System.debug('--------------------- Going to Update:Campaign_Status_Planned::'); 
                    cmpgn.Status=System.Label.Campaign_Status_Planned;
                    cmpgn.Custom_Status_ge_og__c='';
                    updCampaignList.add(cmpgn)  ;
                 }else if(cmpgn.Is_Start_Date_Less_Today_ge_og__c && cmpgn.Is_End_Date_Grt_Today_ge_og__c){
                    System.debug('--------------------- Going to Update:Campaign_Status_InProgress::'); 
                    cmpgn.Status=System.Label.Campaign_Status_InProgress;
                    cmpgn.Custom_Status_ge_og__c='';
                    updCampaignList.add(cmpgn)  ;
                 }else if(cmpgn.Is_Start_Date_Less_Today_ge_og__c && cmpgn.Is_End_Date_Less_Today_ge_og__c){
                    System.debug('--------------------- Going to Update:Campaign_Status_Completed::'); 
                    cmpgn.Status=System.Label.Campaign_Status_Completed;
                    cmpgn.Custom_Status_ge_og__c='';
                    updCampaignList.add(cmpgn)  ;
                 }
               }
               
                        
         }
        //update updCampaignList;
     try{
      System.debug('---------------------> Going to Update campaign list:'+updCampaignList);    
      if(updCampaignList !=null && updCampaignList.size() > 0) {
        //Update records
        System.debug('---------------------> Inside Database Update for campaign list size:'+updCampaignList.size());    
        List<Database.SaveResult> cmpgnList = Database.Update(updCampaignList, false);
        
        for(Database.SaveResult cmpgnSR : cmpgnList){
            // check for failed record ******
            if(!cmpgnSR.isSuccess()){
                 String errMsg = cmpgnSR.getErrors()[0].getMessage();
                 failedCmpgnIDs.add(cmpgnSR.getId());
                 
                //Send mail here
            }
            if(cmpgnSR.isSuccess()){
                 successCmpgnIDs.add(cmpgnSR.getId());
            }

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
        // Email the Batch Job's submitter that the Job is finished.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = toAddress.split(',');
        mail.setToAddresses(toAddresses);
        mail.setSubject('BatchJob Campaign Scheduler Status: ' + a.Status);
        mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
                ' batches with TotalJobItems:'+a.TotalJobItems+' with'+ a.NumberOfErrors + ' failures.'
                       +sBreak+' The failed Ids,if any are: '+ failedCmpgnIds +sBreak+' The success IDs,if any are: '+successCmpgnIds );
   
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
  }

}