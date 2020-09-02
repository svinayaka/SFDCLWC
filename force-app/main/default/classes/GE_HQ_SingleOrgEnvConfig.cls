/*
Class Name:-      GE_HQ_SingleOrgEnvConfig
Overview:-        This Class is the merge of all the EnvConfig classes used for checking  salesforce environment(DEV,QA,Prod) 
Author:-          Sneha Joshi
Created Date:-    28th June 2011

*/

public class GE_HQ_SingleOrgEnvConfig{ 


    //Variable declaration for OLS Integration - added on 12/06/2012
    private static final String OLS_activeEnv = Label.GE_Integration_Environment;   
    private static final String OLS_ENDPOINT_BASE_DEV = 'http://newstoretest.gedigitalenergy.com/SFDCdispatch.asp';//'http://3.94.244.145/SFDCdispatch.asp';//'http://olsdev.consind.ge.com/SFDCdispatch.asp';
    private static final String OLS_ENDPOINT_BASE_QA = 'http://newstoretest.gedigitalenergy.com/SFDCdispatch.asp';
    private static final String OLS_ENDPOINT_BASE_PROD = 'https://store.gedigitalenergy.com/SFDCdispatch.asp';
    

    // Variable declaration for TM (copied from custom labels)- added on 29/11/11 --updated  03/19/2013
    private static final String TM_activeEnv = Label.GE_Integration_Environment;   

    private static final String TM_HTTP_AUTHORIZATION_DEV ='Basic U0ZEQ09HT1BQVFk6U0ZEQ09HT1BQVFk=';
    private static final String TM_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ09HT1BQVFk6U0ZEQ09HT1BQVFk=';
    private static final String TM_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ09HT1BQVFlQUk9EOlNGRENPR09QUFRZUFJPRA==';
       
    private static final String TM_ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_SFDC_OGOpportunity_Source.WebServices.Provider:publishOGOpportunity_WSD';
    private static final String TM_ENDPOINT_BASE_QA = 'https://fpssl.geae.com:7733/ws/GE_SFDC_OGOpportunity_Source.WebServices.Provider:publishOGOpportunity_WSD';
    private static final String TM_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_OGOpportunity_Source.WebServices.Provider:publishOGOpportunity_WSD';
        
    private static final integer TM_WEB_SERVICE_TIMEOUT_MILLIS = 90000;
    
 
    //variable declaration for CMF Integration added by vijay 12/06/2013
    public enum Env {Dev, QA, Prod}
        private static final String GE_OG_CMF_activeEnv = Label.GE_Integration_Environment;

    private static final String GE_OG_CMF_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ3Rlc3Q6U0ZEQ3Rlc3Q='; // 'Basic U0ZEQ1Byb2Q6U0ZEQ1Byb2Q''Administrator username   
    private static final String GE_OG_CMF_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ3Rlc3Q6U0ZEQ3Rlc3Q=';// 'Basic U0ZEQ1BPQzpTRkRDUE9D'
    private static final String GE_OG_CMF_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ09HcHJvZDpTRkRDT0dwcm9k'; // Administrator username
    
    private static final String GE_OG_CMF_CLIENT_CERTIFICATE_PASSWORD_DEV = ''; // N/A
    private static final String GE_OG_CMF_CLIENT_CERTIFICATE_PASSWORD_QA = '';
    private static final String GE_OG_CMF_CLIENT_CERTIFICATE_PASSWORD_PROD = '';
    
    private static final String GE_OG_CMF_ENDPOINT_BASE_DEV ='https://fpssl.geae.com:7744/ws/GE_SFDC_OG_CustomerRequest_Source.WebServices.Provider:publishCustomerRequest_WSD'; 
    private static final String GE_OG_CMF_ENDPOINT_BASE_QA  = 'https://fpssl.geae.com:7733/ws/GE_SFDC_OG_CustomerRequest_Source.WebServices.Provider:publishCustomerRequest_WSD';
    private static final String GE_OG_CMF_ENDPOINT_BASE_PROD  = 'https://fpssl.geae.com:8733/ws/GE_SFDC_OG_CustomerRequest_Source.WebServices.Provider:publishCustomerRequest_WSD';
   
    private static final String GE_OG_CMF_CLIENT_CERTIFICATE_DEV ='';
    private static final String GE_OG_CMF_CLIENT_CERTIFICATE_QA ='';
    private static final String GE_OG_CMF_CLIENT_CERTIFICATE_PROD ='';
    
    private static final integer GE_OG_CMF_WEB_SERVICE_TIMEOUT_MILLIS = 10000;
    
     
    //variable declaration for GIB Integration
    private static final String GIB_activeEnv = Label.GE_Integration_Environment;   
    //private static final String GIB_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ0dJQlVuaXRVcGRhdGU6U0ZEQ0dJQlVuaXRVcGRhdGU='; //'Basic U0ZEQ09QUFRZL1NGRENPUFBUWQ==';
    //Dhanush - private static final String GIB_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ0dJQlVOSVQ6U0ZEQ0dJQlVOSVQ='; //'Basic U0ZEQ09QUFRZL1NGRENPUFBUWQ==';
    //private static final String GIB_HTTP_AUTHORIZATION_DEV = 'Basic c2ZkY29nZ2licWE6c2ZkY29nZ2licWE='; //'Basic U0ZEQ09QUFRZL1NGRENPUFBUWQ==';
private static final String GIB_HTTP_AUTHORIZATION_DEV = 'Basic c2ZkY2dpYnByb2Q6c2ZkY2dpYnByb2Q=';

    //private static final String GIB_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ0dJQlVuaXRVcGRhdGU6U0ZEQ0dJQlVuaXRVcGRhdGU=';//U0ZEQ0dJQlVuaXRVcGRhdGU6U0ZEQ0dJQlVuaXRVcGRhdGVTdGFnZQ==
    //private static final String GIB_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ0dJQlVOSVQ6U0ZEQ0dJQlVOSVQ='; //'Basic U0ZEQ09QUFRZL1NGRENPUFBUWQ==';
   private static final String GIB_HTTP_AUTHORIZATION_QA = 'Basic c2ZkY29nZ2licWE6c2ZkY29nZ2licWE=';
   // private static final String GIB_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ0dJQlVOSVQ6U0ZEQ0dJQlVOSVRQUk9E'; 
   private static final String GIB_HTTP_AUTHORIZATION_PROD ='Basic c2ZkY2dpYnByb2Q6c2ZkY2dpYnByb2Q=';
   
   //'Basic c2ZkY2dpYnByb2Q6c2ZkY2dpYnByb2Q=';
    
    /*private static final String GIB_ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD';
      private static final String GIB_ENDPOINT_BASE_QA = 'https://fpssl.geae.com:7733/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD';
      private static final String GIB_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD';
    */
        
    //R-24742  - Rishikesh Ranjan - added the below endpoints for GIB integration 
    private static final String GIB_ENDPOINT_BASE_DEV = 'https://pwsvcb2bqa.gecompany.com:443/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD';
    //private static final String GIB_ENDPOINT_BASE_DEV = 'https://pwsvcb2b.gecompany.com/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD';
    //private static final String GIB_ENDPOINT_BASE_DEV = 'http://pwnlq0811v06.cloud.ge.com:10901/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD/GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port?WSDL';
    private static final String GIB_ENDPOINT_BASE_QA = 'https://pwsvcb2bqa.gecompany.com:443/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD?WSDL';
  //private static final String GIB_ENDPOINT_BASE_QA  = 'https://pwsvcb2bqa.gecompany.com/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD';
 /* private static final String GIB_ENDPOINT_BASE_QA  ='http://pwnlq0811v05.cloud.ge.com:10901/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD/GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port?WSDL';*/
   // private static final String GIB_ENDPOINT_BASE_PROD = 'https://pwsvcb2bqa.gecompany.com/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD?WSDL';
   
   private static final String GIB_ENDPOINT_BASE_PROD = 'https://pwsvcb2b.gecompany.com/ws/GE_SFDC_GIBUnitUpdate_Source.webServices:publishGIBUnitUpdate_WSD';
   
        
    private static final integer GIB_WEB_SERVICE_TIMEOUT_MILLIS = 90000;
    
    //variable declaration for Kintana Integration
    private static final String KIN_activeEnv = Label.GE_Integration_Environment;   
    private static final String KIN_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ1Rlc3Q6U0ZEQ1Rlc3Q='; 
    private static final String KIN_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ09QUFRZOlNGRENPUFBUWQ==';
    private static final String KIN_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ0NVU1RPUFBUWTpTRkRDQ1VTVE9QUFRZUFJPRA=='; 
       
    private static final String KIN_ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_SFDC_CustomOpportunity_Source.webServices:publishCustomOpportunity_WSD';
    private static final String KIN_ENDPOINT_BASE_QA =  'https://fpssl.geae.com:7733/ws/GE_SFDC_CustomOpportunity_Source.webServices:publishCustomOpportunity_WSD';
    private static final String KIN_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_CustomOpportunity_Source.webServices:publishCustomOpportunity_WSD';
        
    private static final integer KIN_WEB_SERVICE_TIMEOUT_MILLIS = 90000;
    
    //variable declaration for Juliet and OSC Integration
    private static final String OSC_activeEnv = Label.GE_Integration_Environment;   
    private static final String OSC_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ1Rlc3Q6U0ZEQ1Rlc3Q='; //'Basic U0ZEQ09QUFRZL1NGRENPUFBUWQ==';
    private static final String OSC_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ09QUFRZOlNGRENPUFBUWQ==';
    private static final String OSC_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ09QUFRZOlNGRENPUFBUWVBST0Q='; // N/A
       
    private static final String OSC_ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_SFDC_Opportunity_Source.WebServices:publishOpportunity_WSD';
    private static final String OSC_ENDPOINT_BASE_QA = 'https://fpssl.geae.com:7733/ws/GE_SFDC_Opportunity_Source.WebServices:publishOpportunity_WSD';
    private static final String OSC_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_Opportunity_Source.WebServices:publishOpportunity_WSD';
        
    private static final integer OSC_WEB_SERVICE_TIMEOUT_MILLIS = 90000;
    
    //variable declaration for GalaxyAccount
    private static final String GACC_activeEnv = Label.GE_Integration_Environment;
   
    private static final String GACC_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ0NVU1RPTUVSOlNGRENDVVNUT01FUg=='; // Administrator username
    private static final String GACC_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ0NVU1RPTUVSOlNGRENDVVNUT01FUg==';  // 
    private static final String GACC_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ0NVU1RPTUVSOlNGRENDVVNUT01FUg=='; // N/A
       
    private static final String GACC_CLIENT_CERTIFICATE_PASSWORD_DEV = ''; // N/A
    private static final String GACC_CLIENT_CERTIFICATE_PASSWORD_QA = '';
    private static final String GACC_CLIENT_CERTIFICATE_PASSWORD_PROD = '';

    private static final String GACC_ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_SFDC_RDBCustomer_Source.WebServices:publishCustomer_WSD';
    private static final String GACC_ENDPOINT_BASE_QA = 'https://fpssl.geae.com:7733/ws/GE_SFDC_RDBCustomer_Source.WebServices:publishCustomer_WSD';
    private static final String GACC_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_RDBCustomer_Source.WebServices:publishCustomer_WSD';
    
    private static final String GACC_CLIENT_CERTIFICATE_DEV ='';
    private static final String GACC_CLIENT_CERTIFICATE_QA ='';
    private static final String GACC_CLIENT_CERTIFICATE_PROD ='';
    
    private static final integer GACC_WEB_SERVICE_TIMEOUT_MILLIS = 60000;
    
    //variable declaration for GalaxyContact
    private static final String GCON_activeEnv = Label.GE_Integration_Environment;
    
    private static final String GCON_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ0NPTlRBQ1Q6U0ZEQ0NPTlRBQ1Q='; //'U0ZEQ0NPTlRBQ1Q='; // Administrator username
    private static final String GCON_HTTP_AUTHORIZATION_QA  = 'Basic U0ZEQ0NPTlRBQ1Q6U0ZEQ0NPTlRBQ1Q='; //'U0ZEQ0NPTlRBQ1Q='; // Administrator username
    private static final String GCON_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ0NPTlRBQ1Q6U0ZEQ0NPTlRBQ1Q='; // N/A
       
    private static final String GCON_CLIENT_CERTIFICATE_PASSWORD_DEV = ''; // N/A
    private static final String GCON_CLIENT_CERTIFICATE_PASSWORD_QA = '';
    private static final String GCON_CLIENT_CERTIFICATE_PASSWORD_PROD = '';
    
    private static final String GCON_ENDPOINT_BASE_DEV ='https://fpssl.geae.com:7744/ws/GE_SFDC_RDBContact_Source.WebServices:publishContact_WSD';
    private static final String GCON_ENDPOINT_BASE_QA = 'https://fpssl.geae.com:7733/ws/GE_SFDC_RDBContact_Source.WebServices:publishContact_WSD';
    private static final String GCON_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_RDBContact_Source.WebServices:publishContact_WSD';
    
    private static final String GCON_CLIENT_CERTIFICATE_DEV ='';
    private static final String GCON_CLIENT_CERTIFICATE_QA ='';
    private static final String GCON_CLIENT_CERTIFICATE_PROD ='';
    
    private static final integer GCON_WEB_SERVICE_TIMEOUT_MILLIS = 60000;
    
    //Variable declaration for O&G Integration    
    private static final String OG_activeEnv = Label.GE_Integration_Environment;   
    
    private static final String OG_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ1Rlc3Q6U0ZEQ1Rlc3Q='; //'Basic U0ZEQ09QUFRZL1NGRENPUFBUWQ==';
    private static final String OG_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ09QUFRZOlNGRENPUFBUWQ==';
    private static final String OG_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ09QUFRZOlNGRENPUFBUWVBST0Q='; // N/A
    
    private static final String OG_ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_SFDC_Opportunity_Source.WebServices:publishOpportunity_WSD';
    private static final String OG_ENDPOINT_BASE_QA = 'https://fpssl.geae.com:7733/ws/GE_SFDC_Opportunity_Source.WebServices:publishOpportunity_WSD';
    private static final String OG_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_Opportunity_Source.WebServices:publishOpportunity_WSD';
        
    private static final integer OG_WEB_SERVICE_TIMEOUT_MILLIS = 90000;
    
    //Variable declaration for OpptyPublish     
    private static final String OpptyPublish_activeEnv = Label.GE_Integration_Environment;   
    
    private static final String OpptyPublish_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ1Rlc3Q6U0ZEQ1Rlc3Q='; //'Basic U0ZEQ09QUFRZL1NGRENPUFBUWQ==';
    //private static final String OpptyPublish_HTTP_AUTHORIZATION_DEV ='Basic U0ZEQ09HT1BQVFk6U0ZEQ09HT1BQVFk=' ;
    private static final String OpptyPublish_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ09QUFRZOlNGRENPUFBUWQ==';
    private static final String OpptyPublish_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ09QUFRZOlNGRENPUFBUWVBST0Q='; // N/A
    
    private static final String OpptyPublish_ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_SFDC_Opportunity_Source.WebServices:publishOpportunity_WSD';
    //private static final String OpptyPublish_ENDPOINT_BASE_DEV ='https://fpssl.geae.com:7744/ws/GE_SFDC_OGOpportunity_Source.WebServices.Provider:publishOpportunity_WSD'; 
    private static final String OpptyPublish_ENDPOINT_BASE_QA = 'https://fpssl.geae.com:7733/ws/GE_SFDC_Opportunity_Source.WebServices:publishOpportunity_WSD';
    private static final String OpptyPublish_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_Opportunity_Source.WebServices:publishOpportunity_WSD';
        
    private static final integer OpptyPublish_WEB_SERVICE_TIMEOUT_MILLIS = 90000;
    
    //Variable declaration for SAP Integration    
    private static final String SAP_activeEnv = Label.GE_Integration_Environment;   
    private static final String SAP_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ1Rlc3Q6U0ZEQ1Rlc3Q=';
    private static final String SAP_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ1N0YWdlOlNGRENTdGFnZQ==';
    private static final String SAP_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ19TZXJ2UXVvdGVPcmRlcjpTRkRDX1NlcnZRdW90ZU9yZGVyX1Byb2Q=';
       
    private static final String SAP_ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_Repairs_ServicesQuoteOrder_Service.WebServices:processServicesQuoteOrder_WSD';
    private static final String SAP_ENDPOINT_BASE_QA = 'https://fpssl.geae.com:7733/ws/GE_Repairs_ServicesQuoteOrder_Service.WebServices:processServicesQuoteOrder_WSD';
    private static final String SAP_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_Repairs_ServicesQuoteOrder_Service.WebServices:processServicesQuoteOrder_WSD';
        
    private static final integer SAP_WEB_SERVICE_TIMEOUT_MILLIS = 90000;
    
    //Variable declaration for GE_OG_OpptyPublish Integration Added by Sumeet    
   
    
    private static final String GE_OG_OpptyPublish_activeEnv = Label.GE_Integration_Environment;   
    
    private static final String GE_OG_OpptyPublish_HTTP_AUTHORIZATION_DEV = 'Basic U0ZEQ09HT1BQVFk6U0ZEQ09HT1BQVFk=';
    private static final String GE_OG_OpptyPublish_HTTP_AUTHORIZATION_QA = 'Basic U0ZEQ09HT1BQVFk6U0ZEQ09HT1BQVFk=';
    private static final String GE_OG_OpptyPublish_HTTP_AUTHORIZATION_PROD = 'Basic U0ZEQ09HT1BQVFlQUk9EOlNGRENPR09QUFRZUFJPRA==';
    
    private static final String GE_OG_OpptyPublish_ENDPOINT_BASE_DEV = 'https://fpssl.geae.com:7744/ws/GE_SFDC_OGOpportunity_Source.WebServices.Provider:publishOGOpportunity_WSD';
    private static final String GE_OG_OpptyPublish_ENDPOINT_BASE_QA = 'https://fpssl.geae.com:7733/ws/GE_SFDC_OGOpportunity_Source.WebServices.Provider:publishOGOpportunity_WSD';
    private static final String GE_OG_OpptyPublish_ENDPOINT_BASE_PROD = 'https://fpssl.geae.com:8733/ws/GE_SFDC_OGOpportunity_Source.WebServices.Provider:publishOGOpportunity_WSD';
    
    private static final integer GE_OG_OpptyPublish_WEB_SERVICE_TIMEOUT_MILLIS = 90000;
    
    
    
    //Methods for OLS Integration - added on 12/06/2012
    
     public static String OLS_getEndpointBase(){
        return OLS_getEndpointBase(OLS_activeEnv);      
    }
    
    public static String OLS_getEndpointBase(String environ){
        if (environ=='Prod') {
            return OLS_ENDPOINT_BASE_PROD;
        } else if (environ=='QA') {
            return OLS_ENDPOINT_BASE_QA;
        } else if (environ=='Dev') {
            return OLS_ENDPOINT_BASE_DEV;
        } else {
            return '';
        }
    }
    
    
    
    //Methods for TM
    
    public static Boolean TM_useHTTPAuthorization(){
        return TM_useHTTPAuthorization(TM_activeEnv);
    }
    public static Boolean TM_useHTTPAuthorization(String environ){
        if (environ=='Dev' || environ=='QA'|| environ=='Prod' ) {
            return true;
        } else {
            return false;
        }
    }
    public static String TM_getHTTPAuthorization(){
        return TM_getHTTPAuthorization(TM_activeEnv);
    }
    public static String TM_getHTTPAuthorization(String environ){
        if (environ=='Prod'){
            return TM_HTTP_AUTHORIZATION_PROD;
        } else if (environ=='QA') {
            return TM_HTTP_AUTHORIZATION_QA;
        } else if (environ=='Dev') {
            return TM_HTTP_AUTHORIZATION_DEV;
        } else {        
            return '';
        }
    }
    public static String TM_getEndpointBase(){
        return TM_getEndpointBase(TM_activeEnv);      
    }
    

    public static String TM_getEndpointBase(String environ){
        if (environ=='Prod') {
            return TM_ENDPOINT_BASE_PROD;
        } else if (environ=='QA') {
            return TM_ENDPOINT_BASE_QA;
        } else if (environ=='Dev') {
            return TM_ENDPOINT_BASE_DEV;
        } else {
            return '';
        }
    }
    
    public static integer TM_getWebServiceTimeout(){
        return TM_getWebServiceTimeout(TM_activeEnv);
    }
    
    public static integer TM_getWebServiceTimeout(String environ){
        return TM_WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
  
    //Methods for CMF Integration added by Vijay 12/06/2013
    public static Boolean GE_OG_CMF_useHTTPAuthorization(){
        return GE_OG_CMF_useHTTPAuthorization(GE_OG_CMF_activeEnv);
    }
    public static Boolean GE_OG_CMF_useHTTPAuthorization(String environ){
        if (environ=='Dev' || environ=='QA'|| environ=='Prod' ) {
            return true;
        } else {
            return false;
        }
    }
    public static String GE_OG_CMF_getHTTPAuthorization(){
        return GE_OG_CMF_getHTTPAuthorization(GE_OG_CMF_activeEnv);
    }
    public static String GE_OG_CMF_getHTTPAuthorization(String environ){
        if (environ=='Prod') {
            return GE_OG_CMF_HTTP_AUTHORIZATION_PROD;
        } else if (environ=='QA') {
            return GE_OG_CMF_HTTP_AUTHORIZATION_QA;
        } else if (environ=='Dev') {
            return GE_OG_CMF_HTTP_AUTHORIZATION_DEV;
        } else {
            return '';
        }
    }
    
    public static Boolean GE_OG_CMF_useClientCertificate(){
        return GE_OG_CMF_useClientCertificate(GE_OG_CMF_activeEnv);     
    }
    
    public static Boolean GE_OG_CMF_useClientCertificate(String environ){
        //if (environ=='Prod') return True;
        //|| environ=='QA' || environ=='Dev'
        
        return false;
    }
    
    public static String GE_OG_CMF_getClientCertificate(){
        return GE_OG_CMF_getClientCertificate(GE_OG_CMF_activeEnv);
    }
    
    public static String GE_OG_CMF_getClientCertificate(String environ){
        if (environ=='Prod') {
            return GE_OG_CMF_CLIENT_CERTIFICATE_PROD;
        } else if (environ=='QA') {
            return GE_OG_CMF_CLIENT_CERTIFICATE_QA;
        } else if (environ=='Dev') {
            return GE_OG_CMF_CLIENT_CERTIFICATE_DEV;
        } else {
            return '';
        }
    }
    
    public static String GE_OG_CMF_getClientCertificatePassword(){
        return GE_OG_CMF_getClientCertificatePassword(GE_OG_CMF_activeEnv);
    }
    
    public static String GE_OG_CMF_getClientCertificatePassword(String environ){
        if (environ=='Prod') {
            return GE_OG_CMF_CLIENT_CERTIFICATE_PASSWORD_PROD;
        } else if (environ=='QA') {
            return GE_OG_CMF_CLIENT_CERTIFICATE_PASSWORD_QA;
        } else if (environ=='Dev') {
            return GE_OG_CMF_CLIENT_CERTIFICATE_PASSWORD_DEV;
        } else {
            return '';
        }
    }
    
    public static String GE_OG_CMF_getEndpointBase(){
        return GE_OG_CMF_getEndpointBase(GE_OG_CMF_activeEnv);      
    }
    
    public static String GE_OG_CMF_getEndpointBase(String environ){
        if (environ=='Prod') {
            return GE_OG_CMF_ENDPOINT_BASE_PROD;
        } else if (environ=='QA') {
            return GE_OG_CMF_ENDPOINT_BASE_QA;
        } else if (environ=='Dev') {
            return GE_OG_CMF_ENDPOINT_BASE_DEV;
        } else {
            return '';
        }
    }
    
    public static integer GE_OG_CMF_getWebServiceTimeout(){
        return GE_OG_CMF_getWebServiceTimeout(GE_OG_CMF_activeEnv);
    }
    
    public static integer GE_OG_CMF_getWebServiceTimeout(String environ){
        return GE_OG_CMF_WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
     
    
    //Method definitions for GIB Integration
    public static String GIB_getHTTPAuthorization(){
    System.debug('GIB_activeEnv'+GIB_activeEnv);
     System.debug('GIB_ENDPOINT_BASE_QA'+GIB_ENDPOINT_BASE_QA);
    
        return GIB_getHTTPAuthorization(GIB_activeEnv);
    }
    
    public static String GIB_getHTTPAuthorization(String environ){
        String strRet = '';
        
        if (environ=='Prod') 
            strRet = GIB_HTTP_AUTHORIZATION_PROD;

        if (environ=='QA') 
            strRet = GIB_HTTP_AUTHORIZATION_QA;

        if (environ=='Dev') 
            strRet = GIB_HTTP_AUTHORIZATION_DEV;
        
        return strRet;
    }

    public static String GIB_getEndpointBase(){
        return GIB_getEndpointBase(GIB_activeEnv);      
    }

    public static String GIB_getEndpointBase(String environ){
        String strRet = '';
        if (environ=='Prod') 
            strRet = GIB_ENDPOINT_BASE_PROD;
            
        if (environ=='QA') 
            strRet = GIB_ENDPOINT_BASE_QA;
            
        if (environ=='Dev') 
            strRet = GIB_ENDPOINT_BASE_DEV;
        
        return strRet;
    }
    
    public static integer GIB_getWebServiceTimeout(){
        return GIB_getWebServiceTimeout(GIB_activeEnv);
    }
    
    public static integer GIB_getWebServiceTimeout(String environ){
        return GIB_WEB_SERVICE_TIMEOUT_MILLIS;
    }

    //Method definitions for Kintana Integration
    public static String KIN_getHTTPAuthorization(){
        return KIN_getHTTPAuthorization(KIN_activeEnv);
    }
    
    public static String KIN_getHTTPAuthorization(String environ){
        String strRet = '';
        
        if (environ=='Prod') 
            strRet = KIN_HTTP_AUTHORIZATION_PROD;

        if (environ=='QA') 
            strRet = KIN_HTTP_AUTHORIZATION_QA;

        if (environ=='Dev') 
            strRet = KIN_HTTP_AUTHORIZATION_DEV;
        
        return strRet;
    }

    public static String KIN_getEndpointBase(){
        return KIN_getEndpointBase(KIN_activeEnv);      
    }

    public static String KIN_getEndpointBase(String environ){
        String strRet = '';
        if (environ=='Prod') 
            strRet = KIN_ENDPOINT_BASE_PROD;
            
        if (environ=='QA') 
            strRet = KIN_ENDPOINT_BASE_QA;
            
        if (environ=='Dev') 
            strRet = KIN_ENDPOINT_BASE_DEV;
        
        return strRet;
    }
    
    public static integer KIN_getWebServiceTimeout(){
        return KIN_getWebServiceTimeout(KIN_activeEnv);
    }
    
    public static integer KIN_getWebServiceTimeout(String environ){
        return KIN_WEB_SERVICE_TIMEOUT_MILLIS;
    }

    //Method Definitons for Juliet and OSC Integrations
     public static String OSC_getHTTPAuthorization(){
        return OSC_getHTTPAuthorization(OSC_activeEnv);
    }
    public static String OSC_getHTTPAuthorization(String environ){
        String strRet = '';
        
        if (environ=='Prod') 
            strRet = OSC_HTTP_AUTHORIZATION_PROD;

        if (environ=='QA') 
            strRet = OSC_HTTP_AUTHORIZATION_QA;

        if (environ=='Dev') 
            strRet = OSC_HTTP_AUTHORIZATION_DEV;
        
        return strRet;
    }

    public static String OSC_getEndpointBase(){
        return OSC_getEndpointBase(OSC_activeEnv);      
    }

    public static String OSC_getEndpointBase(String environ){
        String strRet = '';
        if (environ=='Prod') 
            strRet = OSC_ENDPOINT_BASE_PROD;
            
        if (environ=='QA') 
            strRet = OSC_ENDPOINT_BASE_QA;
            
        if (environ=='Dev') 
            strRet = OSC_ENDPOINT_BASE_DEV;
        
        return strRet;
    }
    
    public static integer OSC_getWebServiceTimeout(){
        return OSC_getWebServiceTimeout(OSC_activeEnv);
    }
    public static integer OSC_getWebServiceTimeout(String environ){
        return OSC_WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
    //Method definitons for GalaxyAccount
    public static Boolean GACC_useHTTPAuthorization(){
        return GACC_useHTTPAuthorization(GACC_activeEnv);
    }
    
    public static Boolean GACC_useHTTPAuthorization(String environ){
        if (environ=='Dev' || environ=='QA' || environ=='Prod') 
            return true;
        
        return false;
    }
    public static String GACC_getHTTPAuthorization(){
        return GACC_getHTTPAuthorization(GACC_activeEnv);
    }
    
    public static String GACC_getHTTPAuthorization(String environ){
        if (environ=='Prod') 
            return GACC_HTTP_AUTHORIZATION_PROD;
        if (environ=='QA') 
            return GACC_HTTP_AUTHORIZATION_QA;
        if (environ=='Dev') 
            return GACC_HTTP_AUTHORIZATION_DEV;
        
        return '';
    }
    
    public static Boolean GACC_useClientCertificate(){
        return GACC_useClientCertificate(GACC_activeEnv);     
    }
    public static Boolean GACC_useClientCertificate(String environ){
        if (environ=='Prod' ||
            environ=='QA') return true;
        
        return false;
    }
    public static String GACC_getClientCertificate(){
        return GACC_getClientCertificate(GACC_activeEnv);
    }
    public static String GACC_getClientCertificate(String environ){
        if (environ=='Prod') return GACC_CLIENT_CERTIFICATE_PROD;
        if (environ=='QA') return GACC_CLIENT_CERTIFICATE_QA;
        if (environ=='Dev') return GACC_CLIENT_CERTIFICATE_DEV;
        
        return '';
    }
    public static String GACC_getClientCertificatePassword(){
        return GACC_getClientCertificatePassword(GACC_activeEnv);
    }
    public static String GACC_getClientCertificatePassword(String environ){
        if (environ=='Prod') return GACC_CLIENT_CERTIFICATE_PASSWORD_PROD;
        if (environ=='QA') return GACC_CLIENT_CERTIFICATE_PASSWORD_QA;
        if (environ=='Dev') return GACC_CLIENT_CERTIFICATE_PASSWORD_DEV;
        
        return '';
    }
    
    public static String GACC_getEndpointBase(){
        return GACC_getEndpointBase(GACC_activeEnv);      
    }
    public static String GACC_getEndpointBase(String environ){
        if (environ=='Prod') 
            return GACC_ENDPOINT_BASE_PROD;
        if (environ=='QA') 
            return GACC_ENDPOINT_BASE_QA;
        if (environ=='Dev') 
            return GACC_ENDPOINT_BASE_DEV;
        
        return '';
    }
    
    public static integer GACC_getWebServiceTimeout(){
        return GACC_getWebServiceTimeout(GACC_activeEnv);
    }
    
    public static integer GACC_getWebServiceTimeout(String environ){
        return GACC_WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
    //Method Definition for GalaxyContact
     public static Boolean GCON_useHTTPAuthorization(){
        return GCON_useHTTPAuthorization(GCON_activeEnv);
    }
    
    public static Boolean GCON_useHTTPAuthorization(String environ){
        if (environ=='Dev' || environ=='QA' || environ=='Prod') return true;
        return false;
    }
    
    public static String GCON_getHTTPAuthorization(){
        return GCON_getHTTPAuthorization(GCON_activeEnv);
    }
    
    public static String GCON_getHTTPAuthorization(String environ){
        if (environ=='Prod') 
            return GCON_HTTP_AUTHORIZATION_PROD;
        if (environ=='QA') 
            return GCON_HTTP_AUTHORIZATION_QA;
        if (environ=='Dev') 
            return GCON_HTTP_AUTHORIZATION_DEV;
        
        return '';
    }
    
    public static Boolean GCON_useClientCertificate(){
        return GCON_useClientCertificate(GCON_activeEnv);     
    }
    public static Boolean GCON_useClientCertificate(String environ){
        if (environ=='Prod' ||
            environ=='QA') return true;
        
        return false;
    }
    public static String GCON_getClientCertificate(){
        return GCON_getClientCertificate(GCON_activeEnv);
    }
    public static String GCON_getClientCertificate(String environ){
        if (environ=='Prod') return GCON_CLIENT_CERTIFICATE_PROD;
        if (environ=='QA') return GCON_CLIENT_CERTIFICATE_QA;
        if (environ=='Dev') return GCON_CLIENT_CERTIFICATE_DEV;
        
        return '';
    }
    public static String GCON_getClientCertificatePassword(){
        return GCON_getClientCertificatePassword(GCON_activeEnv);
    }
    public static String GCON_getClientCertificatePassword(String environ){
        if (environ=='Prod') return GCON_CLIENT_CERTIFICATE_PASSWORD_PROD;
        if (environ=='QA') return GCON_CLIENT_CERTIFICATE_PASSWORD_QA;
        if (environ=='Dev') return GCON_CLIENT_CERTIFICATE_PASSWORD_DEV;
        
        return '';
    }
    
    public static String GCON_getEndpointBase(){
        return GCON_getEndpointBase(GCON_activeEnv);      
    }
    
    public static String GCON_getEndpointBase(String environ){
        if (environ=='Prod') 
            return GCON_ENDPOINT_BASE_PROD;
        if (environ=='QA') 
            return GCON_ENDPOINT_BASE_QA;
        if (environ=='Dev') 
            return GCON_ENDPOINT_BASE_DEV;
        
        return '';
    }
    
    public static integer GCON_getWebServiceTimeout(){
        return GCON_getWebServiceTimeout(GCON_activeEnv);
    }
    
    public static integer GCON_getWebServiceTimeout(String environ){
        return GCON_WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
    //Method definitions for O&G Integration
    public static String OG_getHTTPAuthorization(){
        return OG_getHTTPAuthorization(OG_activeEnv);
    }
    public static String OG_getHTTPAuthorization(String environ){
        String strRet = '';
        
        if (environ=='Prod') 
            strRet = OG_HTTP_AUTHORIZATION_PROD;

        if (environ=='QA') 
            strRet = OG_HTTP_AUTHORIZATION_QA;

        if (environ=='Dev') 
            strRet = OG_HTTP_AUTHORIZATION_DEV;
        
        return strRet;
    }

    public static String OG_getEndpointBase(){
        return OG_getEndpointBase(OG_activeEnv);      
    }

    public static String OG_getEndpointBase(String environ){
        String strRet = '';
        if (environ=='Prod') 
            strRet = OG_ENDPOINT_BASE_PROD;
            
        if (environ=='QA') 
            strRet = OG_ENDPOINT_BASE_QA;
            
        if (environ=='Dev') 
            strRet = OG_ENDPOINT_BASE_DEV;
        
        return strRet;
    }
    
    public static integer OG_getWebServiceTimeout(){
        return OG_getWebServiceTimeout(OG_activeEnv);
    }
    public static integer OG_getWebServiceTimeout(String environ){
        return OG_WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
    //Method definitions for OpptyPublish
    public static String OpptyPublish_getHTTPAuthorization(){
        return OpptyPublish_getHTTPAuthorization(OpptyPublish_activeEnv);
    }
    public static String OpptyPublish_getHTTPAuthorization(String environ){
        String strRet = '';
        
        if (environ=='Prod') 
            strRet = OpptyPublish_HTTP_AUTHORIZATION_PROD;

        if (environ=='QA') 
            strRet = OpptyPublish_HTTP_AUTHORIZATION_QA;

        if (environ=='Dev') 
            strRet = OpptyPublish_HTTP_AUTHORIZATION_DEV;
        
        return strRet;
    }

    public static String OpptyPublish_getEndpointBase(){
        return OpptyPublish_getEndpointBase(OpptyPublish_activeEnv);      
    }

    public static String OpptyPublish_getEndpointBase(String environ){
        String strRet = '';
        if (environ=='Prod') 
            strRet = OpptyPublish_ENDPOINT_BASE_PROD;
            
        if (environ=='QA') 
            strRet = OpptyPublish_ENDPOINT_BASE_QA;
            
        if (environ=='Dev') 
            strRet = OpptyPublish_ENDPOINT_BASE_DEV;
        
        return strRet;
    }
    
    public static integer OpptyPublish_getWebServiceTimeout(){
        return OpptyPublish_getWebServiceTimeout(OpptyPublish_activeEnv);
    }
    public static integer OpptyPublish_getWebServiceTimeout(String environ){
        return OpptyPublish_WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
     //Method definitions for GE_OG_OpptyPublish Added by Sumeet
    public static String GE_OG_OpptyPublish_getHTTPAuthorization(){
        return GE_OG_OpptyPublish_getHTTPAuthorization(GE_OG_OpptyPublish_activeEnv);
    }
    public static String GE_OG_OpptyPublish_getHTTPAuthorization(String environ){
        String strRet = '';
        
        if (environ=='Prod') 
            strRet = GE_OG_OpptyPublish_HTTP_AUTHORIZATION_PROD;

        if (environ=='QA') 
            strRet = GE_OG_OpptyPublish_HTTP_AUTHORIZATION_QA;

        if (environ=='Dev') 
            strRet = GE_OG_OpptyPublish_HTTP_AUTHORIZATION_DEV;
        
        return strRet;
    }

    public static String GE_OG_OpptyPublish_getEndpointBase(){
        return GE_OG_OpptyPublish_getEndpointBase(GE_OG_OpptyPublish_activeEnv);      
    }

    public static String GE_OG_OpptyPublish_getEndpointBase(String environ){
        String strRet = '';
        if (environ=='Prod') 
            strRet = GE_OG_OpptyPublish_ENDPOINT_BASE_PROD;
            
        if (environ=='QA') 
            strRet = GE_OG_OpptyPublish_ENDPOINT_BASE_QA;
            
        if (environ=='Dev') 
            strRet = GE_OG_OpptyPublish_ENDPOINT_BASE_DEV;
        
        return strRet;
    }
    
    public static integer GE_OG_OpptyPublish_getWebServiceTimeout(){
        return GE_OG_OpptyPublish_getWebServiceTimeout(GE_OG_OpptyPublish_activeEnv);
    }
    public static integer GE_OG_OpptyPublish_getWebServiceTimeout(String environ){
        return GE_OG_OpptyPublish_WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
    
    
    
    //Method definitions for SAP Integration
    public static String SAP_getHTTPAuthorization(){
        return SAP_getHTTPAuthorization(SAP_activeEnv);
    }
    public static String SAP_getHTTPAuthorization(String environ){
        String strRet = '';
        
        if (environ=='Prod') 
            strRet = SAP_HTTP_AUTHORIZATION_PROD;

        if (environ=='QA') 
            strRet = SAP_HTTP_AUTHORIZATION_QA;

        if (environ=='Dev') 
            strRet = SAP_HTTP_AUTHORIZATION_DEV; 
        
        return strRet;
    }

    public static String SAP_getEndpointBase(){
        return SAP_getEndpointBase(SAP_activeEnv);      
    }

    public static String SAP_getEndpointBase(String environ){
        String strRet = '';
        if (environ=='Prod') 
            strRet = SAP_ENDPOINT_BASE_PROD;
        if (environ=='QA') 
            strRet = SAP_ENDPOINT_BASE_QA;  
        if (environ=='Dev') 
            strRet = SAP_ENDPOINT_BASE_DEV;
        
        return strRet;
    }
    
    public static integer SAP_getWebServiceTimeout(){
        return SAP_getWebServiceTimeout(SAP_activeEnv);
    }
    public static integer SAP_getWebServiceTimeout(String environ){
        return SAP_WEB_SERVICE_TIMEOUT_MILLIS;
    }
    
  
    
    
    
    
}