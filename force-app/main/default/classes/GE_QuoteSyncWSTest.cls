/*    
Class Name        : GE_QuoteSyncWSTest
Purpose/Overview  : Test class for the SAP Quote Web Service for SAP integration
Author            : Troy Hedges
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-12    : Troy Hedges        : Inital creation
*/
@isTest
private class GE_QuoteSyncWSTest
{

  @isTest static void testWebService()
  {

    /////////////////////////////
    // sample data for testing //
    /////////////////////////////
    GE_QuoteSyncWS.QuoteData data = new GE_QuoteSyncWS.QuoteData();
    data.quoteNum = '1234';
    data.soldToAccountNum = '234567';
    data.soldToAccountName = '50345678';
    data.quoteAmountOC = 345.65;
    data.quoteExpireDate = Date.today();
    data.quoteName = 'Name123';
    data.accountMgrId = '550356873';
    data.accountMgrName = 'John Doe';
    data.currencyIsoCode = 'USD';
    String base64 = EncodingUtil.base64Encode(Blob.valueOf('This is a test'));
    data.fileBase64 = base64;
    GE_QuoteSyncWS.Status wsStatus = null;

    try
    {
      /////////////////////////
      // create test account //
      /////////////////////////
      Account testAccount = new Account();
      testAccount.Name = 'Test Account';
      testAccount.currencyIsoCode = 'USD';
      testAccount.GE_HQ_DUNS_Number__c = '101010101';
      testAccount.GE_HQ_KYC_Complete__c = TRUE;
      //testAccount.GE_HQ_Request_Status__c = 'CMF Approved';
      insert testAccount;


      ///////////////////////
      // create test oppty //
      ///////////////////////
      Opportunity testOpp = new Opportunity();
      testOpp.AccountId = testAccount.Id;
      testOpp.tier_1_ge_og__c = 'Oil & Gas (O&G)';
      testOpp.tier_2_ge_og__c = 'Measurement & Control (M&C)';
      testOpp.tier_3_ge_og__c = 'Bently Nevada';
      //Commented for cleanup
      //testOpp.GE_ES_Customer_Type__c = 'End User';
      testOpp.StageName = 'Quoted';
      testOpp.CloseDate = Date.today();
      testOpp.Name = 'Test Opp';
      insert testOpp;

      ///////////////////////
      // create test quote //
      ///////////////////////
      Quote testQuote = new Quote();
      //testQuote.AccountId = testAccount.Id;
      testQuote.Name = 'Test Quote';
      testQuote.OpportunityId = testOpp.Id;
      testQuote.GE_SOR_Quote_Number__c = data.quoteNum;
      insert testQuote;

      /////////////////////////////////////////
      // query quote to get SAP quote number //
      /////////////////////////////////////////
      Quote quoteNew = [SELECT Id, QuoteNumber, GE_SOR_Quote_Number__c FROM Quote WHERE Id = :testQuote.Id];

      ////////////////////////////////////
      // test valid saveOrder() service //
      ////////////////////////////////////
      Test.startTest();

      data.sfdcQuoteNum = quoteNew.QuoteNumber;
      GE_QuoteSyncWS.saveQuote(data);

      Quote quote = [SELECT Id, QuoteNumber, GE_SOR_Quote_Number__c FROM Quote WHERE QuoteNumber = :quoteNew.QuoteNumber];
      System.AssertEquals(quote.GE_SOR_Quote_Number__c, quoteNew.GE_SOR_Quote_Number__c);

      //////////////////////////////////////////
      // test failure for no SAP quote number //
      //////////////////////////////////////////
      try
      {
        data.quoteNum = null;
        wsStatus = GE_QuoteSyncWS.saveQuote(data);
      }
      catch (Exception e)
      {
        System.debug(e.getMessage());
        System.AssertEquals(wsStatus.statusCode, 3);
      }

      //////////////////////////////////////
      // test failure for bad base64 data //
      //////////////////////////////////////
      try
      {
        data.quoteNum = '1234';
        data.fileBase64 = '11_00*34';
        wsStatus = GE_QuoteSyncWS.saveQuote(data);
      }
      catch (Exception e)
      {
        System.debug(e.getMessage());
        System.AssertEquals(wsStatus.statusCode, 2);
      }

      //////////////////////////////////////////
      // test failure for no SFDC quote number //
      //////////////////////////////////////////
      try
      {
        data.sfdcQuoteNum = '9876';
        wsStatus = GE_QuoteSyncWS.saveQuote(data);
      }
      catch (Exception e)
      {
        System.debug(e.getMessage());
        System.AssertEquals(wsStatus.statusCode, 1);
      }

      Test.stopTest();
    }
    catch (Exception e)
    {
      System.debug(e.getMessage());
    }

  }

}