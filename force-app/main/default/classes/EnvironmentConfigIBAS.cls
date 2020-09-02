/**************************
class is used to point SFDC org to IBAS Org.
SFDC Dev <-> IBAS Dev
SFDC QA <-> IBAS QA 
SFDC Prod <->  IBAS Prod
**************************************/

 public class EnvironmentConfigIBAS {
    public enum Env {Dev, QA, Prod}
    private static final String activeEnv = Label.GE_Integration_Environment;
   
    private static final integer WEB_SERVICE_TIMEOUT_MILLIS = 10000;
    
    
    public static integer getWebServiceTimeout(){
        return getWebServiceTimeout(activeEnv);
    }
    public static integer getWebServiceTimeout(String environ){
        return WEB_SERVICE_TIMEOUT_MILLIS;
    }
   
    private static final String IBAS_ENDPOINT_BASE_DEV = 'https://api.geoilandgas.com/dev/v1/ibas/users/';

    private static final String IBAS_ENDPOINT_BASE_QA  = 'https://api.geoilandgas.com/qa/v1/ibas/users/';

    private static final String IBAS_ENDPOINT_BASE_PROD = 'https://api.geoilandgas.com/v1/ibas/users/';

    
    public static String getEndpointBase(){
        return getEndpointBase(activeEnv);      
    }
    
    public static String getEndpointBase(String environ){
        if (environ=='Prod') return IBAS_ENDPOINT_BASE_PROD;
        if (environ=='QA') return IBAS_ENDPOINT_BASE_QA;
        if (environ=='Dev') return IBAS_ENDPOINT_BASE_DEV;
        
        return '';
    }
   
    private static final String API_KEY_DEV = '2mh6a45h9etcvexy8d63gjp9'; 
    private static final String API_KEY_QA = 'dchz9zeus4kja5y345c5mvtc'; 
    private static final String API_KEY_PROD = 'cc4mbhamdsnm94fqaszm9r9c'; 
    
    
    public static string getAPIKey(){
         return getAPIKey(activeEnv);  
    
    }
    
    public static string getAPIKey(String environ){
        if (environ=='Prod') 
        return API_KEY_PROD;
        if (environ=='QA') 
        return API_KEY_QA;
        if (environ=='Dev') 
        return API_KEY_DEV;
         
       return '';
    }

}