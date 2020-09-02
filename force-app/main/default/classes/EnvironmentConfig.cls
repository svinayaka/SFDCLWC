public class EnvironmentConfig {
    public enum Env {Dev, QA, Prod}
    private static final String activeEnv = Label.GE_Integration_Environment;
   //   private static final String HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ1BPQzpTRkRDUE9D';  
     private static final String HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ1Rlc3Q6U0ZEQ1Rlc3Q=';//'Basic U0ZEQ1BPQzpTRkRDUE9D';//'Basic U0RGQ1Rlc3Q6U0RGQ1Rlc3Q='; // 'Basic U0ZEQ1Byb2Q6U0ZEQ1Byb2Q''Administrator username   
     private static final String HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ1BPQzpTRkRDUE9D';//'Basic U0ZEQ1BPQzpTRkRDUE9D'; //'Basic U0ZEQ1BPQzpTRkRDUE9D';  // 
     private static final String HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ1Byb2Q6U0ZEQ1Byb2Q'; // Administrator username

    //U0ZEQ1Byb2Q6U0ZEQ1Byb2Q
  
    private static final String CLIENT_CERTIFICATE_PASSWORD_DEV = ''; // N/A
    private static final String CLIENT_CERTIFICATE_PASSWORD_QA = '';
    private static final String CLIENT_CERTIFICATE_PASSWORD_PROD = '';
    
    private static final String ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_SFDC_CustomerRequest_Source.webservices:publishAccount_WSD'; //-R-4681// 'http://www.postbin.org/1foszp0'; //'http://www.postbin.org/tck1jl';    
    private static final String ENDPOINT_BASE_QA  = 'https://fpssl.geae.com:7733/ws/GE_SFDC_CustomerRequest_Source.webservices:publishAccount_WSD';
    private static final String ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_CustomerRequest_Source.webservices:publishAccount_WSD';

    private static final String CLIENT_CERTIFICATE_DEV ='';
    private static final String CLIENT_CERTIFICATE_QA ='';
    private static final String CLIENT_CERTIFICATE_PROD ='';
    
    private static final integer WEB_SERVICE_TIMEOUT_MILLIS = 10000;

    public static Boolean useHTTPAuthorization(){
        return useHTTPAuthorization(activeEnv);
    }
    public static Boolean useHTTPAuthorization(String environ){
        if (environ=='Dev' || environ=='QA'|| environ=='Prod' ) return true;
        
        return false;
    }
    public static String getHTTPAuthorization(){
        return getHTTPAuthorization(activeEnv);
    }
    public static String getHTTPAuthorization(String environ){
        if (environ=='Prod') return HTTP_AUTHORIZATION_PROD;
        if (environ=='QA') return HTTP_AUTHORIZATION_QA;
        if (environ=='Dev') return HTTP_AUTHORIZATION_DEV;
        
        return '';
    }
    
    public static Boolean useClientCertificate(){
        return useClientCertificate(activeEnv);     
    }
    public static Boolean useClientCertificate(String environ){
        //if (environ=='Prod') return True;
        //|| environ=='QA' || environ=='Dev'
        
        return false;
    }
    public static String getClientCertificate(){
        return getClientCertificate(activeEnv);
    }
    public static String getClientCertificate(String environ){
        if (environ=='Prod') return CLIENT_CERTIFICATE_PROD;
        if (environ=='QA') return CLIENT_CERTIFICATE_QA;
        if (environ=='Dev') return CLIENT_CERTIFICATE_DEV;
        
        return '';
    }
    public static String getClientCertificatePassword(){
        return getClientCertificatePassword(activeEnv);
    }
    public static String getClientCertificatePassword(String environ){
        if (environ=='Prod') return CLIENT_CERTIFICATE_PASSWORD_PROD;
        if (environ=='QA') return CLIENT_CERTIFICATE_PASSWORD_QA;
        if (environ=='Dev') return CLIENT_CERTIFICATE_PASSWORD_DEV;
        
        return '';
    }
    
    public static String getEndpointBase(){
        return getEndpointBase(activeEnv);      
    }
    public static String getEndpointBase(String environ){
        if (environ=='Prod') return ENDPOINT_BASE_PROD;
        if (environ=='QA') return ENDPOINT_BASE_QA;
        if (environ=='Dev') return ENDPOINT_BASE_DEV;
        
        return '';
    }
    
    public static integer getWebServiceTimeout(){
        return getWebServiceTimeout(activeEnv);
    }
    public static integer getWebServiceTimeout(String environ){
        return WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
    @isTest
    public static void testEnvironmentConfig(){
        String getHttpAuthResults;
        String getClientCertResults;
        String getClientCertPasswordResults;
        String getEndpointBaseResults;
        
        getHttpAuthResults = getHTTPAuthorization('Dev');
        System.assert(getHttpAuthResults.equals(HTTP_AUTHORIZATION_DEV));
        if (activeEnv=='Dev') System.assert(getHTTPAuthorization().equals(getHttpAuthResults));
    
        getHttpAuthResults = getHTTPAuthorization('QA');
        System.assert(getHttpAuthResults.equals(HTTP_AUTHORIZATION_QA));
        if (activeEnv=='QA') System.assert(getHTTPAuthorization().equals(getHttpAuthResults));

        getHttpAuthResults = getHTTPAuthorization('Prod');
        System.assert(getHttpAuthResults.equals(HTTP_AUTHORIZATION_PROD));
        if (activeEnv=='Prod') System.assert(getHTTPAuthorization().equals(getHttpAuthResults));
        
        useHTTPAuthorization();
        
        
        getClientCertResults = getClientCertificate('Dev');
        System.assert(getClientCertResults.equals(CLIENT_CERTIFICATE_DEV));
        if (activeEnv=='Dev') System.assert(getClientCertificate().equals(getClientCertResults));
    
        getClientCertResults = getClientCertificate('QA');
        System.assert(getClientCertResults.equals(CLIENT_CERTIFICATE_QA));
        if (activeEnv=='QA') System.assert(getClientCertificate().equals(getClientCertResults));

        getClientCertResults = getClientCertificate('Prod');
        System.assert(getClientCertResults.equals(CLIENT_CERTIFICATE_PROD));
        if (activeEnv=='Prod') System.assert(getClientCertificate().equals(getClientCertResults));
        
        getClientCertPasswordResults = getClientCertificatePassword('Dev');
        System.assert(getClientCertPasswordResults.equals(CLIENT_CERTIFICATE_PASSWORD_DEV));
        if (activeEnv=='Dev') System.assert(getClientCertificatePassword().equals(getClientCertPasswordResults));
    
        getClientCertPasswordResults = getClientCertificatePassword('QA');
        System.assert(getClientCertPasswordResults.equals(CLIENT_CERTIFICATE_PASSWORD_QA));
        if (activeEnv=='QA') System.assert(getClientCertificatePassword().equals(getClientCertPasswordResults));

        getClientCertPasswordResults = getClientCertificatePassword('Prod');
        System.assert(getClientCertPasswordResults.equals(CLIENT_CERTIFICATE_PASSWORD_PROD));
        if (activeEnv=='Prod') System.assert(getClientCertificatePassword().equals(getClientCertPasswordResults));

        useClientCertificate();


        getEndpointBaseResults = getEndpointBase('Dev');
        System.assert(getEndpointBaseResults.equals(ENDPOINT_BASE_DEV));
        if (activeEnv=='Dev') System.assert(getEndpointBase().equals(getEndpointBaseResults));
    
        getEndpointBaseResults = getEndpointBase('QA');
        System.assert(getEndpointBaseResults.equals(ENDPOINT_BASE_QA));
        if (activeEnv=='QA') System.assert(getEndpointBase().equals(getEndpointBaseResults));

        getEndpointBaseResults = getEndpointBase('Prod');
        System.assert(getEndpointBaseResults.equals(ENDPOINT_BASE_PROD));
        if (activeEnv=='Prod') System.assert(getEndpointBase().equals(getEndpointBaseResults));
        
        
        System.assert(getWebServiceTimeout()==WEB_SERVICE_TIMEOUT_MILLIS);
    }
}