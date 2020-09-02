@isTest
public class scheduledSendMailToTresholdUserTest {
static  testMethod void test_scheduledSendMailToTresholdUser() {
Test.startTest();
scheduledSendMailToTresholdUser dub = new scheduledSendMailToTresholdUser();
  String sch = '0 0 23 * * ?'; 
  system.schedule('sendmail to threshold Schedule', sch, dub); 
 Test.stopTest();
 
 }
}