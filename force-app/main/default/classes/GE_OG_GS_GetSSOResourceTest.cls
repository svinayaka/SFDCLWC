/*
 * test class for sso get resource
 */
@isTest
public class GE_OG_GS_GetSSOResourceTest{



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
    
    /*
     * test middleware sso get resource
     */
    public static testmethod void testGetSSOResource(){
     if(!test.isrunningtest()){
        //Initialize sso auth setting 
        GE_OG_GS_SSO_Auth_Setting__c ssoAuth = new GE_OG_GS_SSO_Auth_Setting__c();
        ssoAuth.GE_OG_GS_API_Key__c = 'k3kheh88fvu26wwfmx8ejfw2';
        ssoAuth.GE_OG_GS_API_Secret__c = 'pxfN3mK5Aj';
        ssoAuth.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/dev/v1/gs/hr/people';
        insert ssoAuth;
        System.Test.startTest();
        String sso = '23242424';
        GE_OG_GS_GetSSOResource resource = new GE_OG_GS_GetSSOResource(sso);
        String resp =  resource.invoke();   
        system.assertNotEquals(resp, GE_OG_GS_SSODataTest.getTestResponse());  
        System.Test.stopTest();
       }
    }
    
    
    /*
     * test middleware sso get resource with valid SSO
     */
    public static testmethod void testGetSSOResourceWSSO(){
     if(!test.isrunningtest())
     {
        //Initialize sso auth setting 
        GE_OG_GS_SSO_Auth_Setting__c ssoAuth = new GE_OG_GS_SSO_Auth_Setting__c();
        ssoAuth.GE_OG_GS_API_Key__c = 'k3kheh88fvu26wwfmx8ejfw2';
        ssoAuth.GE_OG_GS_API_Secret__c = '26667c5441f7efc18c9166c476ca1111bf9adb1d';
        ssoAuth.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/dev/v1/gs/hr/people';
        insert ssoAuth;
        System.Test.startTest();
        String sso = '105700056';
        GE_OG_GS_GetSSOResource resource = new GE_OG_GS_GetSSOResource(sso);
        String resp =  resource.invoke();   
        system.assertEquals(resp, GE_OG_GS_SSODataTest.getTestResponse());  
        System.Test.stopTest();
     }
    }
   
    
     public static testmethod void testParser() {
     
        
        //Initialize sso auth setting
        String sso = '23242424';
        Test.setMock(HttpCalloutMock.class, new MockGE_OG_GS_GetSSOResourceGenerator());
        GE_OG_GS_GetSSOResource resource = new GE_OG_GS_GetSSOResource(sso);
        String res = resource.invoke();
        GE_OG_GS_SSO_Auth_Setting__c ssoAuth = new GE_OG_GS_SSO_Auth_Setting__c();
        ssoAuth.GE_OG_GS_API_Key__c = 'k3kheh88fvu26wwfmx8ejfw2';
        ssoAuth.GE_OG_GS_API_Secret__c = 'pxfN3mK5Aj';
        ssoAuth.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/dev/v1/gs/hr/people';
        insert ssoAuth;
        
        System.Test.startTest();
        System.assertNotEquals(res, GE_OG_GS_SSODataTest.getTestResponse());
        System.Test.stopTest();
        
            
    }
    
    
}