@isTest(SeeAllData=true)
global class MockGE_OG_GS_GetSSOResourceGenerator implements HttpCalloutMock {
    public HttpResponse resp1;
        global HTTPResponse respond(HTTPRequest req) {
        resp1 = new HttpResponse();
        String s ='{"access_token":"cWjVsFp4ncAtlf8C0qJqVu65mM8S","token_type":"Bearer","expires_in":7199}';
        resp1.setHeader('Content-Type', 'application/json');
        resp1.setstatus('OK');
        resp1.setStatuscode(200);
        resp1.setBody(s);
        return resp1;
    }
}