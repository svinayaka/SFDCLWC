/*
Class Name        : GE_ConfigOrderRedirectControllerExtTest
Purpose/Overview  : Test class for GE_ConfigOrderRedirectControllerExt
Dependency        : This class is dependent on the GE_ERP_Endpoints custom setting being defined in the target environment as defined by CM-021814.
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-06-16    : Htut Zaw           : Inital creation
                  : 2014-07-22    : Htut Zaw           : Updated account DUNS number to dummy value versus a real DUNS
*/
@isTest(SeeAllData = true)
private class GE_ConfigOrderRedirectControllerExtTest{

  @isTest static void testController()  {
    GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
    Account testAccount = new Account();
    testAccount.Name = 'Test Account';
    testAccount.currencyIsoCode = 'USD';
    testAccount.GE_HQ_DUNS_Number__c = '101010101';    // changed value from '201612512
    testAccount.GE_HQ_KYC_Complete__c = TRUE;
    testAccount.GE_HQ_Request_Status__c = 'CMF Approved';
    insert testAccount;

    ///////////////////////
    // create test order //
    ///////////////////////
    Order testOrder = new Order();
    testOrder.AccountId = testAccount.Id;
    testOrder.Name = 'Test Order';
    testOrder.GE_SOR_Sales_Order__c = '1234';
    testOrder.EffectiveDate = Date.today();
    Schema.DescribeFieldResult statusFieldRes = Order.Status.getDescribe();
    testOrder.Status = statusFieldRes.getPicklistValues().get(0).getValue();
    insert testOrder;

    GE_ERP_Endpoints__c orgDef = GE_ERP_Endpoints__c.getOrgDefaults();

    Test.startTest();

    ApexPages.StandardController sc = new ApexPages.standardController(testOrder);
    GE_ConfigOrderRedirectControllerExt ext = new GE_ConfigOrderRedirectControllerExt(sc);

    PageReference pageRef = ext.redirectToPage();

    System.assert(pageRef.getUrl().startsWith(orgDef.SAP_Persona_BaseURL__c));

    Test.stopTest();
  }

}