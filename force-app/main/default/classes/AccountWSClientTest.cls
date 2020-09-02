@isTest
private class AccountWSClientTest
{
  @isTest static void testrequest()
  { Test.setMock(WebServiceMock.class, new MockHttpResponseGenerator());
    AccountWSClient.GE_SFDC_OG_CustomerRequest_Source_WebServices_Provider_publishCustomerRequest_WSD_Port docallout = new AccountWSClient.GE_SFDC_OG_CustomerRequest_Source_WebServices_Provider_publishCustomerRequest_WSD_Port();
    
    AccountWSClient.Request req = new AccountWSClient.Request();
    req.SERVICE_ENVELOPE = new AccountWSClient.SERVICE_ENVELOPE();
    AccountWSClient.Response finalresp = docallout.publishCustomerRequest(req);
    
  }
  
}