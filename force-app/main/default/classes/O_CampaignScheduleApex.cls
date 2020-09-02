/**
 * 
 * Class/Trigger Name--: O_CampaignScheduleApex
 * Purpose/Overview----: This schedulable apex class is used to update the Campaign status through Batch job
 * Author--------------: Gourav Anand
 * Created Date--------: 14-Feb-2017
 * Test Class Name-----:     
 * Scrum               : Opportunity Scrum              
 * LastModifiedBy      : Gourav Anand
   
**/


global class O_CampaignScheduleApex implements Schedulable{

      global void execute(SchedulableContext SC) {
         //Instantiate batch class        
         O_CampaignBatchStatusUpdate batchSch = new O_CampaignBatchStatusUpdate();
         Database.executebatch(batchSch,1);    
     }
        
}