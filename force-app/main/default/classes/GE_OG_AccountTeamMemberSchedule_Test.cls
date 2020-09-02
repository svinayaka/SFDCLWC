@istest
public class GE_OG_AccountTeamMemberSchedule_Test{

 static testMethod void scheduleTest1(){
 
    Test.StartTest();
    GE_OG_AccountTeamMemberSchedule sh1 = new GE_OG_AccountTeamMemberSchedule(); 
    String sch = '0 0 23 * * ?';
    system.schedule('Test check', sch, sh1);
    Test.stopTest();


    }
}