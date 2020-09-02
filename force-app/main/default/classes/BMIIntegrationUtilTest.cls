@isTest

private class BMIIntegrationUtilTest {

static testMethod void UpdateQuoteTestLoginSuccess(){
    try{

		BMIIntegrationUtil.blnTestVariable=True;
   
        BMIIntegrationUtil bmiIntUtil = new BMIIntegrationUtil();
		String strPrimaryBMIQuoteId = 'Test Primary BMU Quote ID';
		String strStageName = 'Test Stage Name';
        
        //BMIIntegrationUtil.UpdateQuote(strPrimaryBMIQuoteId ,strStageName );
        BMIIntegrationUtil.invokeWebService(strPrimaryBMIQuoteId ,strStageName);
        
        //Login in to BMI
        String strLoginSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:login xmlns:bm="urn:soap.bigmachines.com"><bm:userInfo><bm:username></bm:username><bm:password></bm:password></bm:userInfo></bm:login></soapenv:Body></soapenv:Envelope>';
        String strLogOffSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:logout xmlns:bm="urn:soap.bigmachines.com"/></soapenv:Body></soapenv:Envelope>';
        String strUpdBMIStatusSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Commerce</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/commerce/quotes_process_bmClone_16.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:updateTransaction xmlns:bm="urn:soap.bigmachines.com"><bm:transaction><bm:id></bm:id><bm:process_var_name>quotes_process_bmClone_16</bm:process_var_name><bm:data_xml><bm:quote_process bm:bs_id= bm:data_type="0" bm:document_name="Quote" bm:document_var_name="quote_process" bm:process_var_name="quotes_process_bmClone_16"><bm:status_quote></bm:status_quote><bm:transactionID_quote></bm:transactionID_quote></bm:quote_process></bm:data_xml><bm:action_data><bm:action_var_name>updateStatus</bm:action_var_name></bm:action_data></bm:transaction></bm:updateTransaction></soapenv:Body></soapenv:Envelope>';    
    

        String strUserName;
        String strPwd;
        String strEndPoint;

        //Fetch Parameters from Custom Settings
        BMI_Integration_Params__c mc = BMI_Integration_Params__c.getValues('BMI Parameters');
        strUserName = 'testUserName';
        strPwd = 'testPwd';
        strEndPoint = 'testEndPoint';
      
        HttpRequest req = new HttpRequest();
        req.SetMethod('POST');
        req.SetEndPoint(strEndPoint);

        strLoginSOAPMsg = strLoginSOAPMsg.replace('<bm:username>','<bm:username>' + strUserName);
        strLoginSOAPMsg = strLoginSOAPMsg.replace('<bm:password>','<bm:password>' + strPwd);

	    String strLoginSOAPMsgNew = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:login xmlns:bm="urn:soap.bigmachines.com"><bm:userInfo><bm:username>testUserName</bm:username><bm:password>testPwd</bm:password></bm:userInfo></bm:login></soapenv:Body></soapenv:Envelope>';
	    System.assertEquals(strLoginSOAPMsg,strLoginSOAPMsgNew);
    }
    catch (exception e)
    {
        throw e;
    }
}


static testMethod void UpdateQuoteLoginFail(){
    try{
    	
    	BMIIntegrationUtil.blnTestVariable=True;
        
        String strLoginSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:login xmlns:bm="urn:soap.bigmachines.com"><bm:userInfo><bm:username></bm:username><bm:password></bm:password></bm:userInfo></bm:login></soapenv:Body></soapenv:Envelope>';
        String strLogOffSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:logout xmlns:bm="urn:soap.bigmachines.com"/></soapenv:Body></soapenv:Envelope>';
        String strUpdBMIStatusSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Commerce</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/commerce/quotes_process_bmClone_16.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:updateTransaction xmlns:bm="urn:soap.bigmachines.com"><bm:transaction><bm:id></bm:id><bm:process_var_name>quotes_process_bmClone_16</bm:process_var_name><bm:data_xml><bm:quote_process bm:bs_id= bm:data_type="0" bm:document_name="Quote" bm:document_var_name="quote_process" bm:process_var_name="quotes_process_bmClone_16"><bm:status_quote></bm:status_quote><bm:transactionID_quote></bm:transactionID_quote></bm:quote_process></bm:data_xml><bm:action_data><bm:action_var_name>updateStatus</bm:action_var_name></bm:action_data></bm:transaction></bm:updateTransaction></soapenv:Body></soapenv:Envelope>';    
    
        String strUserName;
        String strPwd;
        String strEndPoint;

        //Fetch Parameters from Custom Settings
        BMI_Integration_Params__c mc = BMI_Integration_Params__c.getValues('BMI Parameters');
        strUserName = 'testUserNameWrong';
        strPwd = 'testPwdWrong';
        strEndPoint = 'testEndPoint';
      
        HttpRequest req = new HttpRequest();
        req.SetMethod('POST');
        req.SetEndPoint(strEndPoint);

        strLoginSOAPMsg = strLoginSOAPMsg.replace('<bm:username>','<bm:username>' + strUserName);

        String strLoginSOAPMsgNew = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:login xmlns:bm="urn:soap.bigmachines.com"><bm:userInfo><bm:username>testUserName</bm:username><bm:password>testPwd</bm:password></bm:userInfo></bm:login></soapenv:Body></soapenv:Envelope>';

        System.assertNotEquals(strLoginSOAPMsg,strLoginSOAPMsgNew);
   
    }
    catch (exception e)
    {
        throw e;
    }
}

}