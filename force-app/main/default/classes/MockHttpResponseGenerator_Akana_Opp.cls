@isTest(SeeAllData=true)
public class MockHttpResponseGenerator_Akana_Opp implements HttpCalloutMock {
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
        
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_Akana_Opp());
            
            RequestTypeToTMSPAuthSetting__c authSetting = new RequestTypeToTMSPAuthSetting__c(SetupOwnerId=Userinfo.getUserId());
            authSetting.clientId__c =' GEOil-7wLJXZdClXb1H0HvFth9Ac9n';
            
            authSetting.clientSecret__c = '189436446860fb1bb9367f0c923c42y86b2c70d8';
            authSetting.AuthEndPoint__c = 'https://fssfed.stage.ge.com/fss/as/token.oauth2?grant_type=client_credentials&scope=api' ;
            authSetting.EndPoint__c = 'https://stage.api.ge.com/geoilgas/api/dev/v1/gs/field-automation/exports/opportunity';
            authSetting.EndPointPII__c = 'https://stage.api.ge.com/geoilgas/api/dev/v1/pii/exports/opportunity';
            
            insert authSetting ;
            
            GE_OG_SendRequestTypeId_Opp.SendRequestTypeId_Opp_invoke(new List<Id>{'a0CV0000008XGDJ'});
            GE_OG_SendRequestTypeId_Opp.SendRequestTypeId_Opp_invoke(new List<Id>{'0061200000TXvsM'});
            //GE_OG_OHR_SSOData.parse(testUpdate1.returnresponse('212567499')); 

            
    }
    
}