@IsTest
public class Batch_Oppty_CPR_Schedule_Test {
    @IsTest
    public static void echjob(){
        Test.StartTest();

        Batch_Oppty_CPR_Checkboxsync_Schedule sh1 = new Batch_Oppty_CPR_Checkboxsync_Schedule();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test Inactive CPR', sch, sh1);
        Test.stopTest();
    }

}