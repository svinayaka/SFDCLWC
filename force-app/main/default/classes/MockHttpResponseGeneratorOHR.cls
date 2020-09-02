@isTest(SeeAllData=true)
public class MockHttpResponseGeneratorOHR implements HttpCalloutMock {
    //private HttpResponse resp;
    //private HttpResponse resp1;
    private HttpResponse resp1;
        public HTTPResponse respond(HTTPRequest req) {
        resp1 = new HttpResponse();
        String s ='{"access_token":"cWjVsFp4ncAtlf8C0qJqVu65mM8S","token_type":"Bearer","expires_in":7199}';
        //resp1.setBody(s);
        resp1.setstatus('OK');
        resp1.setStatuscode(200);
        resp1.setBody(s);
        return resp1;
    }
 
    public testmethod static void testWS() {
        
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorOHR());
    
            GE_OG_GetSSO_OHR_User_Update testUpdate1 = new GE_OG_GetSSO_OHR_User_Update();
            //testUpdate.invoke();
            //GE_OG_OHR_SSOData.parse(testUpdate1.invoke());
            testUpdate1.returnresponse('212567499');
            //GE_OG_OHR_SSOData.parse(testUpdate1.returnresponse('212567499')); 

            
    }
    
}