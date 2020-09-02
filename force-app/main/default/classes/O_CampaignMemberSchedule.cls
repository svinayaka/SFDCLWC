/**
 * 
 * Class/Trigger Name--: O_CampaignMemberSchedule
 * Purpose/Overview----: This schedulable apex class is used to update the Campaign Member owner through Batch job
 * Author--------------: Sonali Rathore
 * Created Date--------: 19-Mar-2018
 * Test Class Name-----:     
 * Scrum               : Opportunity Scrum              
 * LastModifiedBy      : Sonali Rathore
   
**/


global class O_CampaignMemberSchedule implements Schedulable{

      global void execute(SchedulableContext SC) {
         //Instantiate batch class        
         O_CampaignMemberInactiveOwnerUpdate batchSch = new O_CampaignMemberInactiveOwnerUpdate();
         Database.executebatch(batchSch,1);    
     }
        
}