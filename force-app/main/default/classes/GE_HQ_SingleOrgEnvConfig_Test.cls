// For CMF edited By Ashish Yadav on 30072013

@isTest
private class GE_HQ_SingleOrgEnvConfig_Test{
   
   static testMethod void testSingleOrgConfig()
   {
   
      // GIB Config..
            GE_HQ_SingleOrgEnvConfig.GIB_getHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.GIB_getHTTPAuthorization('QA');
            GE_HQ_SingleOrgEnvConfig.GIB_getHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.GIB_getEndpointBase('Prod');
            GE_HQ_SingleOrgEnvConfig.GIB_getEndpointBase('QA');
            GE_HQ_SingleOrgEnvConfig.GIB_getEndpointBase('Dev');
            GE_HQ_SingleOrgEnvConfig.GIB_getHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.GIB_getEndpointBase();
            GE_HQ_SingleOrgEnvConfig.GIB_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.GIB_getWebServiceTimeout('Dev');            
            
        // SAP Config ..
            GE_HQ_SingleOrgEnvConfig.SAP_getHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.SAP_getHTTPAuthorization('QA');
            GE_HQ_SingleOrgEnvConfig.SAP_getHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.SAP_getEndpointBase('Prod');
            GE_HQ_SingleOrgEnvConfig.SAP_getEndpointBase('QA');
            GE_HQ_SingleOrgEnvConfig.SAP_getEndpointBase('Dev');
            GE_HQ_SingleOrgEnvConfig.SAP_getHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.SAP_getEndpointBase(); 
            GE_HQ_SingleOrgEnvConfig.SAP_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.SAP_getWebServiceTimeout('Dev');
            
            //CMF Config...
            //GE_HQ_SingleOrgEnvConfig.CMF_getHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getHTTPAuthorization('Prod');
            //GE_HQ_SingleOrgEnvConfig.CMF_getHTTPAuthorization('QA');
             GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getHTTPAuthorization('QA');

            //GE_HQ_SingleOrgEnvConfig.CMF_getHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getHTTPAuthorization('Dev');

            //GE_HQ_SingleOrgEnvConfig.CMF_getEndpointBase('Prod');
            //GE_HQ_SingleOrgEnvConfig.CMF_getEndpointBase('QA');
            //GE_HQ_SingleOrgEnvConfig.CMF_getEndpointBase('Dev');
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getEndpointBase('Prod');
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getEndpointBase('QA');
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getEndpointBase('Dev');

            //GE_HQ_SingleOrgEnvConfig.CMF_useHTTPAuthorization();
            //GE_HQ_SingleOrgEnvConfig.CMF_useHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_useHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_useHTTPAuthorization('Dev');

            //GE_HQ_SingleOrgEnvConfig.CMF_getHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getHTTPAuthorization();

            /* GE_HQ_SingleOrgEnvConfig.CMF_getEndpointBase();
            GE_HQ_SingleOrgEnvConfig.CMF_useClientCertificate();
            GE_HQ_SingleOrgEnvConfig.CMF_useClientCertificate('Prod');  
            GE_HQ_SingleOrgEnvConfig.CMF_getClientCertificate();
            GE_HQ_SingleOrgEnvConfig.CMF_getClientCertificate('Dev');
            GE_HQ_SingleOrgEnvConfig.CMF_getClientCertificate('QA');
            GE_HQ_SingleOrgEnvConfig.CMF_getClientCertificate('Prod');
            GE_HQ_SingleOrgEnvConfig.CMF_getClientCertificatePassword();
            GE_HQ_SingleOrgEnvConfig.CMF_getClientCertificatePassword('Prod');  
            GE_HQ_SingleOrgEnvConfig.CMF_getClientCertificatePassword('Dev'); 
            GE_HQ_SingleOrgEnvConfig.CMF_getClientCertificatePassword('QA');     
            GE_HQ_SingleOrgEnvConfig.CMF_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.CMF_getWebServiceTimeout('Prod');                                          
            GE_HQ_SingleOrgEnvConfig.CMF_getWebServiceTimeout('Dev');    
            GE_HQ_SingleOrgEnvConfig.CMF_getWebServiceTimeout('QA');  */  
            
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getEndpointBase();
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_useClientCertificate();
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_useClientCertificate('Prod');  
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificate();
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificate('Dev');
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificate('QA');
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificate('Prod');
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificatePassword();
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificatePassword('Prod');  
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificatePassword('Dev'); 
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getClientCertificatePassword('QA');     
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getWebServiceTimeout('Prod');                                          
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getWebServiceTimeout('Dev');    
            GE_HQ_SingleOrgEnvConfig.GE_OG_CMF_getWebServiceTimeout('QA');            
                            
                    
            //Kintana Config                    
            GE_HQ_SingleOrgEnvConfig.KIN_getHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.KIN_getHTTPAuthorization('QA');
            GE_HQ_SingleOrgEnvConfig.KIN_getHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.KIN_getEndpointBase('Prod');
            GE_HQ_SingleOrgEnvConfig.KIN_getEndpointBase('QA');
            GE_HQ_SingleOrgEnvConfig.KIN_getEndpointBase('Dev');
            GE_HQ_SingleOrgEnvConfig.KIN_getHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.KIN_getEndpointBase();
            GE_HQ_SingleOrgEnvConfig.KIN_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.KIN_getWebServiceTimeout('Dev');
            
            // OSC Config ...            
            GE_HQ_SingleOrgEnvConfig.OSC_getHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.OSC_getHTTPAuthorization('QA');
            GE_HQ_SingleOrgEnvConfig.OSC_getHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.OSC_getEndpointBase('Prod');
            GE_HQ_SingleOrgEnvConfig.OSC_getEndpointBase('QA');
            GE_HQ_SingleOrgEnvConfig.OSC_getEndpointBase('Dev');
            GE_HQ_SingleOrgEnvConfig.OSC_getHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.OSC_getEndpointBase();
            GE_HQ_SingleOrgEnvConfig.OSC_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.OSC_getWebServiceTimeout('Dev');
            
            // GACC config..
            GE_HQ_SingleOrgEnvConfig.GACC_useHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.GACC_useHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.GACC_getHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.GACC_getHTTPAuthorization('QA');
            GE_HQ_SingleOrgEnvConfig.GACC_getHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.GACC_getEndpointBase('Prod');
            GE_HQ_SingleOrgEnvConfig.GACC_getEndpointBase('QA');
            GE_HQ_SingleOrgEnvConfig.GACC_getEndpointBase('Dev');  
            GE_HQ_SingleOrgEnvConfig.GACC_getHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.GACC_getEndpointBase();
            GE_HQ_SingleOrgEnvConfig.GACC_useClientCertificate();
            GE_HQ_SingleOrgEnvConfig.GACC_useClientCertificate('Prod');
            GE_HQ_SingleOrgEnvConfig.GACC_getClientCertificate();
            GE_HQ_SingleOrgEnvConfig.GACC_getClientCertificate('Prod');
            GE_HQ_SingleOrgEnvConfig.GACC_getClientCertificate('QA');
            GE_HQ_SingleOrgEnvConfig.GACC_getClientCertificate('Dev');
            GE_HQ_SingleOrgEnvConfig.GACC_getClientCertificatePassword();
            GE_HQ_SingleOrgEnvConfig.GACC_getClientCertificatePassword('Prod');
            GE_HQ_SingleOrgEnvConfig.GACC_getClientCertificatePassword('QA');
            GE_HQ_SingleOrgEnvConfig.GACC_getClientCertificatePassword('Dev');
            GE_HQ_SingleOrgEnvConfig.GACC_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.GACC_getWebServiceTimeout('Dev'); 
                      
            // GCON Config..            
            GE_HQ_SingleOrgEnvConfig.GCON_getHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.GCON_getHTTPAuthorization('QA');
            GE_HQ_SingleOrgEnvConfig.GCON_getHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.GCON_getEndpointBase('Prod');
            GE_HQ_SingleOrgEnvConfig.GCON_getEndpointBase('QA');
            GE_HQ_SingleOrgEnvConfig.GCON_getEndpointBase('Dev');
            GE_HQ_SingleOrgEnvConfig.GCON_getHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.GCON_getEndpointBase();
            GE_HQ_SingleOrgEnvConfig.GCON_useHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.GCON_useHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.GCON_useClientCertificate();
            GE_HQ_SingleOrgEnvConfig.GCON_useClientCertificate('Prod');
            GE_HQ_SingleOrgEnvConfig.GCON_getClientCertificate();
            GE_HQ_SingleOrgEnvConfig.GCON_getClientCertificate('Prod');
            GE_HQ_SingleOrgEnvConfig.GCON_getClientCertificate('QA');
            GE_HQ_SingleOrgEnvConfig.GCON_getClientCertificate('Dev');
            GE_HQ_SingleOrgEnvConfig.GCON_getClientCertificatePassword();
            GE_HQ_SingleOrgEnvConfig.GCON_getClientCertificatePassword('Prod');
            GE_HQ_SingleOrgEnvConfig.GCON_getClientCertificatePassword('QA');
            GE_HQ_SingleOrgEnvConfig.GCON_getClientCertificatePassword('Dev');
            GE_HQ_SingleOrgEnvConfig.GCON_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.GCON_getWebServiceTimeout('Dev');
            
            // OG Config..
            
            GE_HQ_SingleOrgEnvConfig.OG_getHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.OG_getHTTPAuthorization('QA');
            GE_HQ_SingleOrgEnvConfig.OG_getHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.OG_getEndpointBase('Prod');
            GE_HQ_SingleOrgEnvConfig.OG_getEndpointBase('QA');
            GE_HQ_SingleOrgEnvConfig.OG_getEndpointBase('Dev');
            GE_HQ_SingleOrgEnvConfig.OG_getHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.OG_getEndpointBase();
            GE_HQ_SingleOrgEnvConfig.OG_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.OG_getWebServiceTimeout('Dev');
            
            //TM Config
            
            GE_HQ_SingleOrgEnvConfig.TM_getHTTPAuthorization('Prod');
            GE_HQ_SingleOrgEnvConfig.TM_getHTTPAuthorization('QA');
            GE_HQ_SingleOrgEnvConfig.TM_getHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.TM_getEndpointBase('Prod');
            GE_HQ_SingleOrgEnvConfig.TM_getEndpointBase('QA');
            GE_HQ_SingleOrgEnvConfig.TM_getEndpointBase('Dev');
            GE_HQ_SingleOrgEnvConfig.TM_getWebServiceTimeout('Prod');
            GE_HQ_SingleOrgEnvConfig.TM_getWebServiceTimeout('QA');
            GE_HQ_SingleOrgEnvConfig.TM_getWebServiceTimeout('Dev');
            GE_HQ_SingleOrgEnvConfig.TM_getEndpointBase();
            GE_HQ_SingleOrgEnvConfig.TM_getWebServiceTimeout();
            GE_HQ_SingleOrgEnvConfig.TM_getHTTPAuthorization();
            GE_HQ_SingleOrgEnvConfig.TM_useHTTPAuthorization('Dev');
            GE_HQ_SingleOrgEnvConfig.TM_useHTTPAuthorization();
   }
}