@isTest 
public class O_CampaignScheduleTest
{
   public static testMethod void testschedule() {

    Test.StartTest();
    O_CampaignSchedule sh1 = new O_CampaignSchedule ();
    
    String sch = '0 0 23 * * ?'; 
    
    system.schedule('Campaign Schedule', sch, sh1); 
    Test.stopTest(); 
    }
  
}