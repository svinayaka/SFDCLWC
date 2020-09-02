@IsTest
public class privatereportsScheduleTest {
    @IsTest
    public static void scchjob(){
        Test.StartTest();

        privatereportsdelete_Schedule sh1 = new privatereportsdelete_Schedule();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Private reports', sch, sh1);
        Test.stopTest();
    }

}