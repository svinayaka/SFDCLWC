@isTest 
public class O_CampaignMemScheduleTest
{
   public static testMethod void testschedule() {

    Test.StartTest();
    O_CampaignMemberSchedule sh1 = new O_CampaignMemberSchedule();
    
    String sch = '0 0 23 * * ?'; 
    
    system.schedule('Campaign Member Schedule', sch, sh1); 
    Test.stopTest(); 
    }
  
}