@isTest
public class massCancelSchedulerClass_Test {
    public static testMethod void testschedule() {
        test.startTest();
        massCancelSchedulerClass sh1 = new massCancelSchedulerClass();
        String sch = '0 0 23 * * ?'; 
        String s= System.schedule('testing mass cancel', sch, sh1);
        Test.stopTest();
    }
}