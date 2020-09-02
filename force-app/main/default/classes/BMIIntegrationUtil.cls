/*
Author : Mahadevan Ramakrishnan
Purpose : Utility Functions for SFDC - BMI integration requirements
Date    : 5/Oct/10
*/
public Class BMIIntegrationUtil{

public static boolean blnTestVariable = false; 
     
public static string strTestLoginRes ='<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><soapenv:Fault><faultcode>soapenv:Server</faultcode><faultstring>COMMERCE-ERR:Partner Login Error for user (mahadevan.ramakrishnan@wipro.com.esdevcurrt)An error occurred while communicating with the partner site.</faultstring></soapenv:Fault></soapenv:Body></soapenv:Envelope>';

public static void SendErrorMessage(String email, String message)
{   
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    If(email !=null){
    Id SendtoEmailId;
    List<User> Useremail= new List<User>();
    Useremail.add([Select Id from user where email=:email and isactive=true]);
    
    if(Useremail.size()>0){
        for(User u:Useremail){
            SendtoEmailId=u.Id;
        }
    mail.setTargetObjectId(SendtoEmailId);
    mail.setSaveAsActivity(false);
    mail.setSenderDisplayName('Big Machine Integration Web Service');        
    mail.setSubject('Big Machine Integration Exception');                
    mail.setPlainTextBody(message);        
    mail.setHtmlBody('<p>' + message + '</p>');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }else{
    mail.setToAddresses(new string[]{email});
    mail.setSenderDisplayName('Big Machine Integration Web Service');        
    mail.setSubject('Big Machine Integration Exception');                
    mail.setPlainTextBody(message);        
    mail.setHtmlBody('<p>' + message + '</p>'); 
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });   
    }
    }
    
    

    
    
}

public static void ProcessOtherResponse(string strResponse)
{
    BMI_Integration_Params__c mc = BMI_Integration_Params__c.getValues('BMI Parameters');
    string strErrorEmail = mc.error_email__c;

    if (strResponse.length() > 0)
    {
        if (strResponse.indexOf('<faultstring>') != -1)
        {
            integer i1 = strResponse.indexOf('<faultstring>');
            integer i2 = strResponse.indexOf('</faultstring>');

            SendErrorMessage(strErrorEmail , 'The following error occured during updating Big Machines Quote :' + ' - ' + strResponse.substring(i1, i2) + ' - contact your admin and retry once the issue is resolved'); 
        
            return;
        }                        
    }
}

@future(Callout=true)
public static void invokeWebService(string strPrimaryBMIQuoteId, string strStageName){
     
     Http h;
     HttpResponse res;
     string strXL;
     string strSession;
     String strUserName;
     String strPwd;
     String strEndPoint;
     String strErrorEmail;
     Httprequest req, req1, req2;
     Dom.Document domDoc;           
    
     String strLoginSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:login xmlns:bm="urn:soap.bigmachines.com"><bm:userInfo><bm:username></bm:username><bm:password></bm:password></bm:userInfo></bm:login></soapenv:Body></soapenv:Envelope>';
     String strLogOffSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:logout xmlns:bm="urn:soap.bigmachines.com"/></soapenv:Body></soapenv:Envelope>';
     String strUpdBMIStatusSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Commerce</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/commerce/quotes_process_bmClone_16.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:updateTransaction xmlns:bm="urn:soap.bigmachines.com"><bm:transaction><bm:id></bm:id><bm:process_var_name>quotes_process_bmClone_16</bm:process_var_name><bm:data_xml><bm:quote_process bm:bs_id= bm:data_type="0" bm:document_number="1" bm:document_name="Quote" bm:document_var_name="quote_process" bm:process_var_name="quotes_process_bmClone_16"><bm:status_quote></bm:status_quote><bm:transactionID_quote></bm:transactionID_quote></bm:quote_process></bm:data_xml><bm:action_data><bm:action_var_name>updateStatus</bm:action_var_name></bm:action_data></bm:transaction></bm:updateTransaction></soapenv:Body></soapenv:Envelope>';

     try
     {
        // following code can used to fetch Username, password and email of the user from BMUserSecurity__c
     
         BMI_Integration_Params__c mc = BMI_Integration_Params__c.getValues('BMI Parameters');
         strUserName = mc.bmi_user_id__c;
         strPwd = mc.bmi_user_pwd__c;
         strEndPoint = mc.End_Point_URL__c;
         strErrorEmail = mc.error_email__c;
     
         h = new Http();
         req = new HttpRequest();
         req.SetMethod('POST');
         req.SetEndPoint(strEndPoint);

        strLoginSOAPMsg = strLoginSOAPMsg.replace('<bm:username>','<bm:username>' + strUserName);
        strLoginSOAPMsg = strLoginSOAPMsg.replace('<bm:password>','<bm:password>' + strPwd);
        
        System.Debug ('Login SOAP : ' + strLoginSOAPMsg);
         
        req.SetBody(strLoginSOAPMsg);
         
         if (blnTestVariable == false)
         {
             res = h.send(req);                  
             domDoc = res.getBodyDocument();
             strXL = domDoc.toXmlString();
         }
         else
         {
             strXL = strTestLoginRes; 
         }

         strSession = ProcessLoginResponse(strXL);         
         
         
        req1 = new HttpRequest();
        req1.SetMethod('POST');
        req1.SetEndPoint(strEndPoint);
         
         strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:sessionId>','<bm:sessionId>' + strSession); 
         strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:status_quote>','<bm:status_quote>' + strStageName); 
         strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:id>','<bm:id>' + strPrimaryBMIQuoteId); 
         strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:transactionID_quote>','<bm:transactionID_quote>' + strPrimaryBMIQuoteId); 
         strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('bm:bs_id=','bm:bs_id="' + strPrimaryBMIQuoteId + '"'); 
         
         /*if (strStageName == 'Pending')
         {
             strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('updateStatus','revise');          
         }*/
                  
         System.Debug('Upd SOAP : ' + strUpdBMIStatusSOAPMsg);
         req1.SetBody(strUpdBMIStatusSOAPMsg );

         if (blnTestVariable == false)
         {         
            res = h.send(req1);
            domDoc = res.getBodyDocument();
            strXL = domDoc.toXmlString();
         }
         else
         {
            strXL = strTestLoginRes;
         }   

         ProcessOtherResponse(strXL); //Update

         strLogoffSOAPMsg = strLogoffSOAPMsg.replace('<bm:sessionId>','<bm:sessionId>' + strSession);
         System.Debug('Log off SOAP : ' + strLogoffSOAPMsg);
        req2 = new HttpRequest();
        req2.SetMethod('POST');
        req2.SetEndPoint(strEndPoint);
         
         req2.SetBody(strLogoffSOAPMsg);            

         if (blnTestVariable == false)
         {         
            res = h.send(req2);
            domDoc = res.getBodyDocument();
            strXL = domDoc.toXmlString();
         }
         else
         {
            strXL = strTestLoginRes;
         }  
         
         ProcessOtherResponse(strXL); //Logoff                      
     }
     catch (exception e)
     {
        System.debug(e.getMessage());
        SendErrorMessage(strErrorEmail , 'The following error occured during updating Big Machines Quote # : ' + strPrimaryBMIQuoteId + ' - ' + e.getTypeName() + ' - ' + e.getMessage() + ' - contact your admin and retry once the issue is resolved'); 
     }
}


public static String ProcessLoginResponse(string strLoginResponse)
{
    string strSession;
        BMI_Integration_Params__c mc = BMI_Integration_Params__c.getValues('BMI Parameters');
        string strErrorEmail = mc.error_email__c;


    if (strLoginResponse.length() > 0)
    {
        if (strLoginResponse.indexOf('<faultstring>') != -1)
        {
            integer i1 = strLoginResponse.indexOf('<faultstring>');
            integer i2 = strLoginResponse.indexOf('</faultstring>');

            SendErrorMessage(strErrorEmail , 'The following error occured during updating(login) Big Machines Quote :' + ' - ' + strLoginResponse.substring(i1, i2) + ' - contact your admin and retry once the issue is resolved'); 
        
            return strSession;
        }            

        integer idx1 = strLoginResponse.indexOf('<bm:sessionId>');
        integer idx2 = strLoginResponse.indexOf('</bm:sessionId>');

        strSession = strLoginResponse.subString(idx1 + 14,idx2);
        
    }
    
    return strSession;
}

/*
@future (callout = true)
Public Static void UpdateQuote(string strPrimaryBMIQuoteId, string strStageName)
{
    String strLoginSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:login xmlns:bm="urn:soap.bigmachines.com"><bm:userInfo><bm:username></bm:username><bm:password></bm:password></bm:userInfo></bm:login></soapenv:Body></soapenv:Envelope>';
    String strLogOffSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:logout xmlns:bm="urn:soap.bigmachines.com"/></soapenv:Body></soapenv:Envelope>';
    String strUpdBMIStatusSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Commerce</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/commerce/quotes_process_bmClone_16.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:updateTransaction xmlns:bm="urn:soap.bigmachines.com"><bm:transaction><bm:id></bm:id><bm:process_var_name>quotes_process_bmClone_16</bm:process_var_name><bm:data_xml><bm:quote_process bm:bs_id= bm:data_type="0" bm:document_name="Quote" bm:document_var_name="quote_process" bm:process_var_name="quotes_process_bmClone_16"><bm:status_quote></bm:status_quote><bm:transactionID_quote></bm:transactionID_quote></bm:quote_process></bm:data_xml><bm:action_data><bm:action_var_name>updateStatus</bm:action_var_name></bm:action_data></bm:transaction></bm:updateTransaction></soapenv:Body></soapenv:Envelope>';

    String strUserName;
    String strPwd;
    String strEndPoint;
    String strErrorEmail;
    Httprequest req, req1, req2;
    
    try
    {       
        //Fetch Parameters from Custom Settings
        BMI_Integration_Params__c mc = BMI_Integration_Params__c.getValues('BMI Parameters');
        strUserName = mc.bmi_user_id__c;
        strPwd = mc.bmi_user_pwd__c;
        strEndPoint = mc.End_Point_URL__c;
        strErrorEmail = mc.error_email__c;
    
        System.Debug('Custom Setting : ' + mc.bmi_user_id__c + ' - ' + mc.bmi_user_pwd__c + ' - ' + mc.End_Point_URL__c);
                
        req = new HttpRequest();
        req.SetMethod('POST');
        req.SetEndPoint(strEndPoint);

        strLoginSOAPMsg = strLoginSOAPMsg.replace('<bm:username>','<bm:username>' + strUserName);
        strLoginSOAPMsg = strLoginSOAPMsg.replace('<bm:password>','<bm:password>' + strPwd);
        
        System.Debug ('Login SOAP : ' + strLoginSOAPMsg);
        req.SetBody(strLoginSOAPMsg);

        Http http = new Http();     
        HttpResponse res = new HttpResponse();   
        
        if (clsPublicTest.Testvariable == false)
            res = http.send(req);
       
        String strSession;
     
        If (res.getStatusCode() == 200 || clsPublicTest.Testvariable == true)
        {
            Dom.Document domDoc;
            String strXL;

            if (res != null)
            {
                domDoc = res.getBodyDocument();
                strXL = domDoc.toXmlString();
            }
                            
            if (strXL.indexOf('<faultstring>') != -1)
            {
                integer i1 = strXL.indexOf('<faultstring>');
                integer i2 = strXL.indexOf('</faultstring>');

                SendErrorMessage(strErrorEmail , 'The following error occured during updating Big Machines Quote # :' + strPrimaryBMIQuoteId + ' - ' + strXL.substring(i1, i2) + ' - contact your admin and retry once the issue is resolved'); 
            
                return;
            }            
    
            integer idx1 = strXL.indexOf('<bm:sessionId>');
            integer idx2 = strXL.indexOf('</bm:sessionId>');

            strSession = strXL.subString(idx1 + 14,idx2);
        }
        else //login failure
        {
            SendErrorMessage(strErrorEmail , 'The following error occured during updating Big Machines Quote # :' + strPrimaryBMIQuoteId + ' - ' + res.getStatusCode() + ' - ' + res.getStatus() + ' - contact your admin and retry once the issue is resolved'); 
        
            return;
        }

        System.Debug('Session : ' + strSession);
    
        //Update Quote
        req1 = new HttpRequest();
        req1.SetMethod('POST');
        req1.SetEndPoint(strEndPoint);
        
        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:sessionId>','<bm:sessionId>' + strSession); 

        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:status_quote>','<bm:status_quote>' + strStageName); 
        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:id>','<bm:id>' + strPrimaryBMIQuoteId); 
        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:transactionID_quote>','<bm:transactionID_quote>' + strPrimaryBMIQuoteId); 
        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('bm:bs_id=','bm:bs_id="' + strPrimaryBMIQuoteId + '"'); 

        System.Debug('Upd SOAP : ' + strUpdBMIStatusSOAPMsg);
        req1.SetBody(strUpdBMIStatusSOAPMsg );

        if (clsPublicTest.Testvariable == false)        
            res = http.send(req1);        
        
        If (res.getStatusCode() != 200)
        {
            SendErrorMessage(strErrorEmail , 'The following error occured during updating Big Machines Quote # :' + strPrimaryBMIQuoteId + ' - ' + res.getStatusCode() + ' - ' + res.getStatus() + ' - contact your admin and retry once the issue is resolved'); 
        
            return;
        }
        else
        {
            Dom.Document domDoc = res.getBodyDocument();
            string strRetMessage = domDoc.toXmlString();
            
            System.Debug ('Upd Res : ' + domDoc.toXmlString());
            
            if (strRetMessage.indexOf('<faultstring>') != -1)
            {
                integer i1 = strRetMessage.indexOf('<faultstring>');
                integer i2 = strRetMessage.indexOf('</faultstring>');

                SendErrorMessage(strErrorEmail , 'The following error occured during updating Big Machines Quote # :' + strPrimaryBMIQuoteId + ' - ' + strRetMessage.substring(i1, i2) + ' - contact your admin and retry once the issue is resolved'); 
            }
        }
                
        //Log Off
        strLogoffSOAPMsg = strLogoffSOAPMsg.replace('<bm:sessionId>','<bm:sessionId>' + strSession);

        System.Debug('Log off SOAP : ' + strLogoffSOAPMsg);

        req2 = new HttpRequest();
        req2.SetMethod('POST');
        req2.SetEndPoint(strEndPoint);


        req2.SetBody(strLogoffSOAPMsg);

        if (clsPublicTest.Testvariable == false)        
            res = http.send(req2);        
        
        If (res.getStatusCode() != 200)
        {
            SendErrorMessage(strErrorEmail , 'The following error occured during updating Big Machines Quote # :' + strPrimaryBMIQuoteId + ' - ' + res.getStatusCode() + ' - ' + res.getStatus() + ' - contact your admin and retry once the issue is resolved'); 
        
            return;
        }
        else
        {
            String strRetMessage = res.getBodyDocument().toXmlString();
            System.Debug ('Logoff Res : ' + strRetMessage);
            
            if (strRetMessage.indexOf('<faultstring>') != -1)
            {
                integer i1 = strRetMessage.indexOf('<faultstring>');
                integer i2 = strRetMessage.indexOf('</faultstring>');

                SendErrorMessage(strErrorEmail , 'The following error occured during updating Big Machines Quote # :' + strPrimaryBMIQuoteId + ' - ' + strRetMessage.substring(i1, i2) + ' - contact your admin and retry once the issue is resolved'); 
                return;  
            } 
        }
        
    }
    catch (exception e)
    {
        System.Debug ('Error Says : ' + e);
        //throw e;
        SendErrorMessage(strErrorEmail , 'The following error occured during updating Big Machines Quote # :' + strPrimaryBMIQuoteId + ' - ' + e.getTypeName() + ' - ' + e.getMessage() + ' - contact your admin and retry once the issue is resolved'); 
    }
}
public HttpRequest buildLoginRequest(){

        String strLoginSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:login xmlns:bm="urn:soap.bigmachines.com"><bm:userInfo><bm:username></bm:username><bm:password></bm:password></bm:userInfo></bm:login></soapenv:Body></soapenv:Envelope>';
        String strUserName;
        String strPwd;
        String strEndPoint;
        String strErrorEmail;
        HttpRequest req;
    
    try
    {       
        //Fetch Parameters from Custom Settings
        BMI_Integration_Params__c mc = BMI_Integration_Params__c.getValues('BMI Parameters');
        strUserName = mc.bmi_user_id__c;
        strPwd = mc.bmi_user_pwd__c;
        strEndPoint = mc.End_Point_URL__c;
        strErrorEmail = mc.error_email__c;
    
        System.Debug('Custom Setting : ' + mc.bmi_user_id__c + ' - ' + mc.bmi_user_pwd__c + ' - ' + mc.End_Point_URL__c+ ' - ' + mc.Error_Email__c);
                
        req = new HttpRequest();
        req.SetMethod('POST');
        req.SetEndPoint(strEndPoint);
        
        strLoginSOAPMsg = strLoginSOAPMsg.replace('<bm:username>','<bm:username>' + strUserName);
        strLoginSOAPMsg = strLoginSOAPMsg.replace('<bm:password>','<bm:password>' + strPwd);
        
        System.Debug ('Login SOAP : ' + strLoginSOAPMsg);
        req.SetBody(strLoginSOAPMsg);            
    }
    catch(exception e)
    {
        throw e;
    }
    
    return req;
}

public HttpRequest buildUpdateRequest(string strSession, string strStageName, string strPrimaryBMIQuoteId){

        String strUpdBMIStatusSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Commerce</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/commerce/quotes_process_bmClone_16.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:updateTransaction xmlns:bm="urn:soap.bigmachines.com"><bm:transaction><bm:id></bm:id><bm:process_var_name>quotes_process_bmClone_16</bm:process_var_name><bm:data_xml><bm:quote_process bm:bs_id= bm:data_type="0" bm:document_name="Quote" bm:document_var_name="quote_process" bm:process_var_name="quotes_process_bmClone_16"><bm:status_quote></bm:status_quote><bm:transactionID_quote></bm:transactionID_quote></bm:quote_process></bm:data_xml><bm:action_data><bm:action_var_name>updateStatus</bm:action_var_name></bm:action_data></bm:transaction></bm:updateTransaction></soapenv:Body></soapenv:Envelope>';

        String strUserName;
        String strPwd;
        String strEndPoint;
        String strErrorEmail;
        HttpRequest req;
    
    try
    {       
        //Fetch Parameters from Custom Settings
        BMI_Integration_Params__c mc = BMI_Integration_Params__c.getValues('BMI Parameters');
        strUserName = mc.bmi_user_id__c;
        strPwd = mc.bmi_user_pwd__c;
        strEndPoint = mc.End_Point_URL__c;
        strErrorEmail = mc.error_email__c;
    
        System.Debug('Custom Setting : ' + mc.bmi_user_id__c + ' - ' + mc.bmi_user_pwd__c + ' - ' + mc.End_Point_URL__c + ' - ' + mc.Error_Email__c);
                
        req = new HttpRequest();
        req.SetMethod('POST');
        req.SetEndPoint(strEndPoint);
        
        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:sessionId>','<bm:sessionId>' + strSession); 
        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:status_quote>','<bm:status_quote>' + strStageName); 
        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:id>','<bm:id>' + strPrimaryBMIQuoteId); 
        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('<bm:transactionID_quote>','<bm:transactionID_quote>' + strPrimaryBMIQuoteId); 
        strUpdBMIStatusSOAPMsg = strUpdBMIStatusSOAPMsg.replace('bm:bs_id=','bm:bs_id="' + strPrimaryBMIQuoteId + '"'); 

        System.Debug('Upd SOAP : ' + strUpdBMIStatusSOAPMsg);
        req.SetBody(strUpdBMIStatusSOAPMsg );

    }
    catch(exception e)
    {
        throw e;
    }
    
    return req;
}

public HttpRequest buildLogoffRequest(string strSession){

        String strLogOffSOAPMsg = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Header><bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:sessionId></bm:sessionId></bm:userInfo><bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category><bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0"><bm:schemaLocation>http://ge.bigmachines.com/bmfsweb/ge/schema/v1_0/security/Security.xsd</bm:schemaLocation></bm:xsdInfo></soapenv:Header><soapenv:Body><bm:logout xmlns:bm="urn:soap.bigmachines.com"/></soapenv:Body></soapenv:Envelope>';
        String strUserName;
        String strPwd;
        String strEndPoint;
        String strErrorEmail;
        HttpRequest req;
    
    try
    {       
        //Fetch Parameters from Custom Settings
        BMI_Integration_Params__c mc = BMI_Integration_Params__c.getValues('BMI Parameters');
        strUserName = mc.bmi_user_id__c;
        strPwd = mc.bmi_user_pwd__c;
        strEndPoint = mc.End_Point_URL__c;
        strErrorEmail = mc.error_email__c;
    
        System.Debug('Custom Setting : ' + mc.bmi_user_id__c + ' - ' + mc.bmi_user_pwd__c + ' - ' + mc.End_Point_URL__c + ' - ' + mc.Error_Email__c);
                
        req = new HttpRequest();
        req.SetMethod('POST');
        req.SetEndPoint(strEndPoint);
        
        strLogoffSOAPMsg = strLogoffSOAPMsg.replace('<bm:sessionId>','<bm:sessionId>' + strSession);

        System.Debug('Log off SOAP : ' + strLogoffSOAPMsg);

        req.SetBody(strLogoffSOAPMsg);
    }
    catch(exception e)
    {
        throw e;
    }
    
    return req;
}*/
}