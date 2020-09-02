/**
 * 
 * Class/Trigger Name--: O_CampaignSchedule
 * Purpose/Overview----: This schedulable apex class is used to update the Campaign owner through Batch job
 * Author--------------: Sonali Rathore
 * Created Date--------: 19-Mar-2018
 * Test Class Name-----:     
 * Scrum               : Opportunity Scrum              
 * LastModifiedBy      : Sonali Rathore
   
**/


global class O_CampaignSchedule implements Schedulable{

      global void execute(SchedulableContext SC) {
         //Instantiate batch class        
         O_CampaignInactiveOwnerUpdate batchSch = new O_CampaignInactiveOwnerUpdate();
         Database.executebatch(batchSch,1);    
     }
        
}