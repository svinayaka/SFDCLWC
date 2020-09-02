@isTest(SeeAllData = True)
Public class Test_EnvironmentConfigIBAS{

//Public enum Env {Dev, QA, Prod}
static TestMethod void method1(){

String activeEnv = Label.GE_Integration_Environment;

//Intger WEB_SERVICE_TIMEOUT_MILLIS = 10000;

//EnvironmentConfigIBAS.getWebServiceTimeout(activeEnv);

 String IBAS_ENDPOINT_BASE_DEV = 'https://api.geoilandgas.com/dev/v1/ibas/users/';

 String IBAS_ENDPOINT_BASE_QA  = 'https://api.geoilandgas.com/qa/v1/ibas/users/';

 String IBAS_ENDPOINT_BASE_PROD = 'https://api.geoilandgas.com/v1/ibas/users/';

EnvironmentConfigIBAS.getEndpointBase(activeEnv);
EnvironmentConfigIBAS.getEndpointBase();
EnvironmentConfigIBAS.getAPIKey(activeEnv);
EnvironmentConfigIBAS.getAPIKey();
}
}