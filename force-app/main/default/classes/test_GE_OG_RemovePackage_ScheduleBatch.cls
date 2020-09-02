@isTest
public class test_GE_OG_RemovePackage_ScheduleBatch {
static  testMethod void test_GE_OG_RemovePackage_ScheduleBatch() {
Test.startTest();
GE_OG_RemovePackage_ScheduleBatch dub = new GE_OG_RemovePackage_ScheduleBatch();
 String sch = '20 30 8 10 2 ?'; 
  system.schedule('Batchupdateclass scheduled', sch, dub);
SchedulableContext sc;
 dub.execute(sc);
 Test.stopTest();
 
 }
}