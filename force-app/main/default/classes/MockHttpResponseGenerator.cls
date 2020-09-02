@istest
global class MockHttpResponseGenerator implements WebServiceMock {
    global void doInvoke(Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        AccountWSClient.publishAccountResponse finalresp = new AccountWSClient.publishAccountResponse();
        response.put('response_x', finalresp);
    }
}