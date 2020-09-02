@isTest(seeAllData=true)
public class GE_OG_MC_POnotReceived_Test{
static testMethod void TestGEOGMCPO(){
SVMXC__Skill__c skill= new SVMXC__Skill__c();
skill.name='Test';
insert skill;

SVMXC__Service_Order__c  WO= NEW SVMXC__Service_Order__c ();
WO.SVMXC__Skill__c=skill.ID;
insert WO;



//SVMXC__Service_Order__c WO=[select id,GE_OG_MC_PO_Not_Received__c,RecordTypeID,RecordType.name from SVMXC__Service_Order__c where GE_OG_MC_PO_Not_Received__c= true and recordType.Name='MCS'  limit 1];
PageReference myVfPage = Page.GE_OG_MC_POnotReceived;
          Test.setCurrentPage(myVfPage);
          
          ApexPAges.StandardController sc = new ApexPages.StandardController(WO);
          GE_OG_MC_POnotReceived_Cntrl testController = new GE_OG_MC_POnotReceived_Cntrl(sc);
          //Code coverage for GE_OG_MC_POnotReceivedAlertScheduler class
          GE_OG_MC_POnotReceivedAlertScheduler testcc = new GE_OG_MC_POnotReceivedAlertScheduler();
          GE_OG_MC_POnotReceivedAlertScheduler.scheduleGE_OG_MC_POnotReceivedAlert();





}
}