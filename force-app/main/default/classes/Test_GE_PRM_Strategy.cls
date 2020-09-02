@isTest
public class Test_GE_PRM_Strategy    
{
    static testmethod void testMehtod1()
    {
        GE_HQ_Account_Plan__c objAP = new GE_HQ_Account_Plan__c();
        PageReference GE_PRM_Strategy1= Page.GE_PRM_Strategy;
        Test.setCurrentPage(GE_PRM_Strategy1);
        GE_PRM_Strategy  ChApptViewcontroller1 = new GE_PRM_Strategy(new ApexPages.StandardController(objAP ));
    }
}