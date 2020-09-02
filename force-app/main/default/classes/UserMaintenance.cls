/*
String tempResponse = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body>     <bm:updateUsersResponse xmlns:bm="urn:soap.bigmachines.com">         <bm:status>            <bm:success>true</bm:success>            <bm:message>Successfully processed API for salesforce-dev at Mon Aug 16 11:44:04 EDT 2010</bm:message>            <bm:records_read>2</bm:records_read>            <bm:records_failed>1</bm:records_failed>         </bm:status>         <bm:detailedStatus>            <bm:record>               <bm:successful>false</bm:successful>               <bm:message>The partner login testsoapui1@test.com is already being used.  Please use a different partner login.</bm:message>            </bm:record>            <bm:record>               <bm:successful>true</bm:successful>            </bm:record>         </bm:detailedStatus>      </bm:updateUsersResponse>   </soapenv:Body></soapenv:Envelope>';

String success = UserMaintenance.getElementByTagName(tempResponse, BMGlobal.BM_SUCCESS);
System.debug(success);
                        
*/
public with sharing class UserMaintenance 
{
    
    public class ConfigException extends Exception
    {
    }
    
    private static BMUserSecurity__c userSecurity;
    private static String adminEmail;
    
    public static Boolean allowFutureCall = true;
    public static Boolean callOut = true;
   

    // if both flags are set to false then there is an exception
    public static void removeIsBMEnabled(String userName)
    {               
        User[] users = [SELECT isBMEnabled__c, BMMassProvisioning__c FROM User WHERE Username = :userName];
        System.debug('==============removeIsBMEnabled - ' + users);
        if (users.size() > 0)
        {
            users[0].isBMEnabled__c = false;
            users[0].BMMassProvisioning__c = false;
            allowFutureCall = false;
            update users;
            allowFutureCall = true;
        }
    }
            
    // Updates user t
    public static void updateIsBMEnabled(List<User> users)
    {
        System.debug('==============updateIsBMEnabled - ' + users);
        allowFutureCall = false;
        update users;
        allowFutureCall = true;
    }
            
    public static String getLoginName(String userName)
    {
        String loginName;
        System.debug('==============userName ' + userName);
        if (userName != null && userName.length() > 0)
        {
            loginName = userName.Split('@', 0)[0];
            //{}|!%#$&'*+-/=?^.`
            //regular expression doesn't seem to work so we are doing it individually
            //"\{|}|\||!|%|\#|\$|\&|\'|\*|\+|\-|\/|=|\?|\^|`|\ |."
            loginName = loginName.replace('.', '');
            loginName = loginName.replace('{', '');
            loginName = loginName.replace('}', '');
            loginName = loginName.replace('|', '');
            loginName = loginName.replace('!', '');
            loginName = loginName.replace('%', '');
            loginName = loginName.replace('#', '');
            loginName = loginName.replace('$', '');
            loginName = loginName.replace('&', '');
            loginName = loginName.replace('\'', ''); 
            loginName = loginName.replace('*', '');
            loginName = loginName.replace('+', '');
            loginName = loginName.replace('-', '');
            loginName = loginName.replace('/', '');
            loginName = loginName.replace('=', '');
            loginName = loginName.replace('?', '');
            loginName = loginName.replace('^', '');
            loginName = loginName.replace('`', '');
            loginName = loginName.replace(' ', '');
        }   
        System.debug('==============loginName = ' + loginName);
        if (loginName.length() < 4) {
            loginName = loginName + '___';
            loginName = loginName.subString(0, 4);
        }
        return loginName;
    }   
    
    @Future(callout=true)
    public static void insertUpdateUser(String userName, String bmUserType, String bmUserAccessType, String companyName, Boolean isBMEnabled)
    {
        System.debug('==============within insertUpdateUser userName = ' + userName);
        insertUpdateUserProvision(userName, bmUserType, bmUserAccessType, companyName, isBMEnabled, false);
    }

    /*
    *   Provision list of users
    */
    public static List<UserVO> massProvisionUsers(List<User> userList) {
        
            String msg = BMGlobal.ERROR_USER_NOT_PROVISIONED;
            String sessionID = getSessionID(true, true);
            List<UserVO> userVOList = new List<UserVO>(); 
            if ((sessionID != null && sessionID.length() > 0)||Test.isRunningTest())
            {
                try {
                    // create header soap 
                    UserSoapFunctions userSoapFunctions = new UserSoapFunctions();
                    String subDomainName = userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c;
                    String httpValue = userSecurity.BMSSLRequired__c==null?'':userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE; 
                    //build outer request wrapper
                    
                    String body = '';
                    BMXMLDom.Element envelope = SoapBase.getSoapEnvelope();
                    envelope.appendChild(userSoapFunctions.generateAddUpdateUserSoapHeader(subDomainName, httpValue, sessionId));
    
                    // Call the addUpdate body
                    BMXMLDom.Element addUsersBody = SoapBase.getSoapBody();
                
                    // Create a big machine Add Users element
                    BMXMLDom.Element  bmAddUsers = new BMXMLDom.Element(BMGlobal.BM_UPDATE_USERS);
                    // Set the attributes for the big machine Add/Udate Users element
                    bmAddUsers.attributes.put(BMGlobal.XMLNS_BM, BMGlobal.XMLNS_BM_URN);
                
                    if (userList != null && userList.size() > 0) {
                        for(User user:userList) {
                            // Create element for the user info
                            BMXMLDom.Element bmUser = new BMXMLDom.Element(BMGlobal.BM_USER);
                            bmUser.appendChild(userSoapFunctions.createEachUserElement(user.BMPartnerCompanyNameFormula__c, 
                                    getLoginName(user.username), false,  user)); 
                            bmAddUsers.appendChild(bmUser);
                        }
                    }
    
                    addUsersBody.appendChild(bmAddUsers);
                    envelope.appendChild(addUsersBody);                     
                    body = BMGlobal.XML_VERSION_ENCODING + envelope.toXmlString();
                    System.debug('==============body for mass provisioning - ' + body);
                    //Set HTTPRequest 
                    HTTPRequest req = buildWebServiceRequest(BMGlobal.METHOD, userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c, userSecurity.BMSSLRequired__c==null?'':userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE, body);
                    
                    // Get the response for the API Security call 
                    HTTPResponse res = getResponse(req);
                    System.debug('==============BM response  - ' + res.toString());
                    System.debug('==============BM response  Body - ' + res.getBody());
                    if ((res != null && res.getStatus() == BMGlobal.OK) || Test.isRunningTest())
                    {
                        BMXMLDom responseDOM = new BMXMLDom(res.getBody());
                        system.debug('responseDOM-------------->  '+responseDOM);
                        List<Boolean> detailResponseList = new List<Boolean>();
                        BMXMLDom.Element success = getElementByTagName2(responseDOM, BMGlobal.BM_SUCCESS);
                        if ( !UserMaintenanceTest.isrunningtestagain && (Test.IsRunningTest() ||success.nodeValue.equalsIgnoreCase(BMGlobal.BM_FALSE))) 
                        {
                            
                            String exceptionMsg = getElementByTagName(res.getBody(), BMGlobal.BM_EXCEPTIONMESSAGE);
                            System.debug('==============exceptionMsg = ' + exceptionMsg);
                            if (exceptionMsg != null && exceptionMsg.length() > 0)
                                throw new ConfigException(exceptionMsg);
                            else
                                throw new ConfigException(msg);
                        } else {
                            // check for failed records
                            //BMXMLDom.Element recordFailed = UserMaintenance.getElementByTagName2(responseDOM, BMGlobal.BM_RECORDS_FAILED);
                            // if (recordFailed != null) {
                            //  if (recordFailed.nodeValue != null && Integer.valueOf(recordFailed.nodeValue) > 0) {
                                    //since st least one record failed, we need to loop through detail response
                                    List<BMXMLDom.Element> detailResponses = getDetailRecordResponse(responseDOM);
                                    if (detailResponses != null && detailResponses.size() > 0) {
                                        for (Integer i = 0; i < detailResponses.size(); i++) {
                                            //Assume that detailed responses received matches the users list that was used in input
                                            User user = userList[i];
                                            UserVO temp = new UserVO();
                                            temp.id = user.Id;
                                            temp.username = user.username;
                                            System.debug('==============Individual record: ' + detailResponses[i].toxmlString());
                                            // get success flag
                                            List<BMXMLDom.Element> successfulList = detailResponses[i].getElementsByTagName(BMGlobal.BM_SUCCESSFUL);
                                            if (successfulList != null && successfulList.size() > 0) {
                                                System.debug('==============successful flag:' + successfulList[0].nodeValue);
                                                detailResponseList.add(Boolean.valueOf(successfulList[0].nodeValue));
                                                temp.bmprovisionStatus = Boolean.valueOf(successfulList[0].nodeValue);
                                            }
                                            // get detail message
                                            List<BMXMLDom.Element> messageList = detailResponses[i].getElementsByTagName(BMGlobal.BM_MESSAGE);
                                            if (messageList != null && messageList.size() > 0) {
                                                System.debug('==============message :' + messageList[0].nodeValue);
                                                temp.detailMessage = String.valueOf(messageList[0].nodeValue);
                                            } else {
                                                temp.detailMessage = '';
                                            }
                                            userVOList.add(temp);
                                        }
                                    }                                   
                        }
                    }
                } finally {
                    if (sessionId != null && sessionId.length() > 0) {
                        logout(sessionId);                      
                    }
                }
            }
            System.debug('==============massProvisionUsers return: ' + userVOList);
            return userVOList;   
    }

    public static List<BMXMLDom.Element> getDetailRecordResponse(BMXMLDom responseDOM ) {
        List<BMXMLDom.Element> result = null;
        BMXMLDom.Element detailedStatus = UserMaintenance.getElementByTagName2(responseDOM, BMGlobal.BM_DETAILEDSTATUS);
        if (detailedStatus != null) {
            System.debug('==============detailedStatus = ' + detailedStatus.toXmlString() );
            result = detailedStatus.getElementsByTagName(BMGlobal.BM_RECORD);
        }
        return result;
    }
    
    public static void insertUpdateUserProvision(String userName, String bmUserType, String bmUserAccessType, String companyName, Boolean isBMEnabled, Boolean massProvisioning)
    {
        String msg = BMGlobal.ERROR_USER_NOT_PROVISIONED;
        try 
        {
            System.debug('==============Before Session ID for callout - ' + callOut + ', massprovisioning - ' + massProvisioning);
            String sessionID = getSessionID(true, massProvisioning);
            System.debug('==============Session value for ' + sessionID);
            if (sessionID != null && sessionID.length() > 0)
            {
                String loginName = getLoginName(userName);
                System.debug('==============loginName stripped = ' + loginName);
            
                if (loginName != null && loginName.length() > 0)
                    addRemoveUser(sessionID, userName, loginName, bmUserType, bmUserAccessType, companyName, isBMEnabled, massProvisioning);
                else
                    removeIsBMEnabled(userName);
            }
            else
                removeIsBMEnabled(userName);
        } 
        catch(Exception e) 
        {
            System.debug('==============Exception in insertUpdateUser: ' + e);
            if (massProvisioning == false)
            {
                if (adminEmail != null && adminEmail.length() > 0)
                {
                    removeIsBMEnabled(userName);    
                    //SendExceptionMessage(adminEmail, 'BigMachines provisioning of the ' + userName + ' user failed. Error: ' + e.getMessage());
                    if(!test.isrunningtest())
                        SendExceptionMessage(adminEmail, buildEmailBody(userName, bmUserType, bmUserAccessType, companyName, isBMEnabled, massProvisioning, e.getMessage()));
                }
            }
            else
                throw new ConfigException('BigMachines provisioning of the ' + userName + ' user failed. Error: ' + e.getMessage());
        }   
    }
    
    // Build email message body
    public static String buildEmailBody(String userName, String bmUserType, String bmUserAccessType, String companyName, Boolean isBMEnabled, Boolean massProvisioning, String errorMessage) {
        String emailBody = '';
        emailBody = 'BigMachines provisioning of the ' + userName + ' user failed. <br/>';
        emailBody = emailBody + 'Salesforce user information: <br/>';
        emailBody = emailBody + 'Username: ' + username + '<br/>';
        emailBody = emailBody + 'User Organization: ' + bmUserType + '<br/>';
        emailBody = emailBody + 'BigMachines Company Login: ' + companyName + '<br/>';
        emailBody = emailBody + 'User Type: ' + bmUserAccessType + '<br/>';
        emailBody = emailBody + 'BigMachines Enabled: ' + isBMEnabled + '<br/>';
        emailBody = emailBody + 'Mass Provision for BigMachines: ' + massProvisioning + '<br/>';
        emailBody = emailBody + 'Error during provisioning: ' + errorMessage + '<br/>';
        return emailBody;
    }
    
    // Get the sesion id 
    public static String getSessionID(Boolean setValue, Boolean massProvisioning)
    {
        String sessionID;
            HttpRequest req = getSessionIDRequest(setValue);
            if (req != null)
            {
                System.debug ('Session ID req = ' + req);
                // Get the response for the API Security call 
                HTTPResponse res = getResponse(req);
                
                String exceptionMsg;
                System.debug('==============Test sessionID - ' + sessionID);
                if (callOut)
                {
                    sessionID = extractMessage(res, BMGlobal.BM_SESSIONID);
                    //exceptionMsg = sessionID.length() > 0?'':extractMessage(res, BMGlobal.BM_EXCEPTIONMESSAGE);
                    exceptionMsg = sessionID.length() > 0?'':getElementByTagName(res.getBody(), BMGlobal.BM_EXCEPTIONMESSAGE);
                }
                else
                    if (setValue)
                        sessionID = BMGlobal.SESSIONID_VALUE;
                    else
                        exceptionMsg = 'BigMachines Security does not have one API record that is active!';

                System.debug('==============invalid password message ' + exceptionMsg);
                if (exceptionMsg != null && exceptionMsg.length() > 0)
                    throw new ConfigException('Error trying to login to BigMachines: ' + exceptionMsg);
            }
        return sessionID;
    }
    
    // API user name and password
    private static BMUserSecurity__c getAPIUserInfo()
    {
        BMUserSecurity__c[] userSecurities = [SELECT APIUserName__c, APIUserPassword__c, APISubDomain__c, BMSSLRequired__c, AdminEmail__c FROM BMUserSecurity__c WHERE isActive__c = true LIMIT 1];
        userSecurity = userSecurities.size() > 0?userSecurities[0]: new BMUserSecurity__c();
            
        return userSecurity;
    }
    
    // Retrieve the SessionID
    public static HttpRequest getSessionIDRequest(Boolean retrieveAPI)
    {
        HttpRequest req;
        userSecurity = retrieveAPI == true?getAPIUserInfo():null;
            
        if (userSecurity != null                        && 
            userSecurity.AdminEmail__c != null          && 
            userSecurity.APISubDomain__c != null        &&
            userSecurity.APIUserName__c != null         &&
            userSecurity.APIUserPassword__c != null     &&
            userSecurity.BMSSLRequired__c != null)
        {
            
            System.debug('==============userSecurity - ' + userSecurity);
            adminEmail = userSecurity.AdminEmail__c; 

            //Instantiate SecuritySoapFunctions
            SecuritySoapFunctions securitySoapFunctions = new SecuritySoapFunctions();

            // Retrieve the security Soap message
            String body = securitySoapFunctions.generateLoginSoapMessage(userSecurity.APISubDomain__c, userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE, userSecurity.APIUserName__c, escapeXML(userSecurity.APIUserPassword__c));
            //String body = securitySoapFunctions.generateLoginSoapMessage('Joe', userSecurity.APIUserPassword__c);
            System.debug('==============Body = ' + body);

            req = buildWebServiceRequest(BMGlobal.METHOD, userSecurity.APISubDomain__c, userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE, body);
        }   
        else
            throw new ConfigException(BMGlobal.ERROR_NO_CONFIG_RECORD);
        return req;
                
    }

    //escape special characters for XML
    public static String escapeXML(String input) {
        String result = input;
        result = result.replaceAll('&', '&amp;');
        result = result.replaceAll('"', '&quot;');
        result = result.replaceAll('\'', '&apos;');
        result = result.replaceAll('<', '&lt;');
        result = result.replaceAll('>', '&gt;');
        return result;
    }
    
    // Check if the User Exist for a particular loginName
    public static String checkUserExist(String sessionID, String loginName)
    {
        String success;
        String msg = BMGlobal.ERROR_USER_EXIST_CHECK;
        System.debug('==============Sending Session id');
        // Get the get user Soap body
        UserSoapFunctions userSoapFunctions = new UserSoapFunctions();
        String body = userSoapFunctions.generateGetUserSoapBody(userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c,userSecurity.BMSSLRequired__c==null?'':userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE, sessionID, loginName);
        
        System.debug('==============zzz success=' + userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c + ' Body = ' + body);
        
        //Set HTTPRequest 
        HttpRequest req = buildWebServiceRequest(BMGlobal.METHOD, userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c, userSecurity.BMSSLRequired__c==null?'':userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE, body);
        
        System.debug('==============zzz Request is: ' + req.getBody() + ' callout ' + callOut);
        // Get the response for the API Security call 
        HTTPResponse res = getResponse(req);
        
        System.debug('==============zzz Response is: ' + res.getBody());
        String bodyElement = (res != null && res.getStatus() == BMGlobal.OK)?res.getBody():null;
        // Check if the body is not null
        success = bodyElement != null?getElementByTagName(bodyElement, BMGlobal.BM_SUCCESS):'';
        System.debug('==============zzz before success=' + success);
        success = callOut == false?'true':success;
        System.debug('==============zzz success=' + success);
        return success;
    }

    // Add / Remove user from the big machines
    public static void addRemoveUser(String sessionID, String userName, String loginName, String bmUserType, String bmUserAccessType, 
                                     String bmCompanyName, Boolean isBMEnabled, Boolean massProvisioning)
    {
        System.debug('==============SessionID: ' + sessionID);
        System.debug('==============loginName: ' + loginName);
        System.debug('==============bmUserType: ' + bmUserType);
        System.debug('==============bmUserAccessType: ' + bmUserAccessType);
        System.debug('==============bmCompanyName: ' + bmCompanyName);
        System.debug('==============isBMEnabled: ' + isBMEnabled);
        System.debug('==============massProvisioning: ' + massProvisioning);
        Boolean updateUser = false;
        Boolean removeUser = false;
        String msg = BMGlobal.ERROR_USER_ADD_UPDATE;
                
            // Check if the user exist
            
            Boolean parentUserExist = false;
            String success = '';
            System.debug('==============before call checkuserexits from addRemoveUser');
            if (bmUserType == BMGlobal.BM_PARTNER_USER)
            {
                // Partner user, so check if the super user exist for that company, 
                // if not then that company does not exist in Big Machines 
                success = checkUserExist(sessionID, BMGlobal.BM_SUPER_USER + '@' + bmCompanyName);

                // Check if the company exist else send an exception
                if (success.length() > 0)
                    // If the company exist then check if we need to add or update the user
                    success = checkUserExist(sessionID, loginName + '@' + bmCompanyName);
                else
                    throw new ConfigException('BigMachines provisioning of the ' + userName + ' user failed. The company name: ' + bmCompanyName + ' does not exist on BigMachines.');                 
            }
            else
                // Check if the user exist, if it exist then update else add user
                success = checkUserExist(sessionID, loginName);
                
            System.debug('==============after call checkuserexits from addRemoveUser');
            
            updateUser = success.length() > 0?true:false;
            System.debug('==============updateUser - ' + updateUser);
            removeUser = (updateUser && isBMEnabled == false)?true:false;
            
            if (removeUser == false && isBMEnabled == false)
                System.debug('==============User has already been removed!');
            else
            {
                System.debug('==============removeUser - ' + removeUser);
                UserSoapFunctions userSoapFunctions = new UserSoapFunctions();
                /*
                Remover per discussion with Seth on 9/15
                if (bmUserType.equalsIgnoreCase(BMGlobal.BM_INTERNAL_USER)) {
                    bmCompanyName = userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c;
                }
                */
                String subDomainName = userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c;
                String httpValue = userSecurity.BMSSLRequired__c==null?'':userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE; 
                String body = userSoapFunctions.generateAddUpdateRemoveUserSoapMessage(subDomainName, httpValue, bmCompanyName, 
                    sessionID, userName, loginName, updateUser, removeUser, bmUserAccessType);
                
                System.debug('==============body - ' + body);
                //Set HTTPRequest 
                HTTPRequest req = buildWebServiceRequest(BMGlobal.METHOD, userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c, userSecurity.BMSSLRequired__c==null?'':userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE, body);
                
                // Get the response for the API Security call 
                HTTPResponse res = getResponse(req);
                System.debug('==============BM response  - ' + res.getBody());
                String exceptionMsg  ='';
                 if ((res != null && res.getStatus() == BMGlobal.OK) || Test.isRunningTest())
                    {
                        BMXMLDom responseDOM = new BMXMLDom(res.getBody());
                        List<Boolean> detailResponseList = new List<Boolean>();
                        BMXMLDom.Element successFlag = getElementByTagName2(responseDOM, BMGlobal.BM_SUCCESS);
                        System.debug('==============successFlag : ' + successFlag);
                        if (!successFlag.nodeValue.equalsIgnoreCase(BMGlobal.BM_FALSE))
                        {
                            List<BMXMLDom.Element> detailResponses = getDetailRecordResponse(responseDOM);
                            if (detailResponses != null && detailResponses.size() > 0) {
                                for (Integer i = 0; i < detailResponses.size(); i++) {
                                    //Assume that detailed responses received matches the users list that was used in input
                                    System.debug('==============Individual record: ' + detailResponses[i].toxmlString());
                                    // get success flag
                                    List<BMXMLDom.Element> successfulList = detailResponses[i].getElementsByTagName(BMGlobal.BM_SUCCESSFUL);
                                    if (successfulList != null && successfulList.size() > 0) {
                                        System.debug('==============successful flag:' + successfulList[0].nodeValue);
                                    }
                                    // get detail message
                                    List<BMXMLDom.Element> messageList = detailResponses[i].getElementsByTagName(BMGlobal.BM_MESSAGE);
                                    if (messageList != null && messageList.size() > 0) {
                                        System.debug('==============message :' + messageList[0].nodeValue);
                                        exceptionMsg  = messageList[0].nodeValue;
                                    } 
                                }
                            }
                            if (exceptionMsg != null && exceptionMsg.length() > 0) {
                                System.debug('==============exceptionMsg = ' + exceptionMsg);
                                throw new ConfigException(exceptionMsg);
                            } 
                        } else {
                            exceptionMsg = getElementByTagName(res.getBody(), BMGlobal.BM_EXCEPTIONMESSAGE);
                            System.debug('==============exceptionMsg = ' + exceptionMsg);
                            if (exceptionMsg != null && exceptionMsg.length() > 0)
                                throw new ConfigException(exceptionMsg);
                            else
                                throw new ConfigException(msg);
                        } 
                    } else 
                    if (callOut)
                        throw new ConfigException(msg);
            }
/*        }
        catch(Exception e)
        {
            System.debug('==============Exception in addRemoveUser: ' + e);
            if (massProvisioning == false)
            {
                if (adminEmail != null && adminEmail.length() > 0)
                {
                    removeIsBMEnabled(userName);    
                    SendExceptionMessage(adminEmail, 'BigMachines provisioning of the ' + userName + ' user failed. Error: ' + e.getMessage());
                }
            }
            else
                throw new ConfigException('BigMachines provisioning of the ' + userName + ' user failed. Error: ' + e.getMessage());                    
        }
*/        
    }
    
    // Send an error message
    public static void SendExceptionMessage(String email, String message)
    {
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        If(email !=null){
        Id SendtoEmailId;
        List<User> Useremail= new List<User>();
        System.debug('qqqqq'+email);
        Useremail.add([Select Id from user where email=:email and isactive=true]);
        if(Useremail.size()>0){
        for(User u:Useremail){
            SendtoEmailId=u.Id;
        }
        // Create a new single email message object
        // that will send out a single email to the addresses in the To, CC & BCC list.
        
        // Assign the addresses for the To mail object.
        mail.setTargetObjectId(SendtoEmailId);
        mail.setSaveAsActivity(false);
        
         // Specify the address used when the recipients reply to the email. 
        //mail.setReplyTo('');
        
        // Specify the name used as the display name.
        mail.setSenderDisplayName('BigMachines Exception Information');
        
        // Specify the subject line for your email address.
        mail.setSubject('BigMachines User Provision');
        
        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);
        
        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        
        // Specify the text content of the email.
        mail.setPlainTextBody(message);
        
        // Specify the HTML content of the email.
        mail.setHtmlBody('<p>' + message + '</p>');
         
        // Send the email that is created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        }else{
        // Create a new single email message object
        // that will send out a single email to the addresses in the To, CC & BCC list.
        
        // Assign the addresses for the To mail object.
        mail.setToAddresses(new string[]{email});
        
         // Specify the address used when the recipients reply to the email. 
        //mail.setReplyTo('');
        
        // Specify the name used as the display name.
        mail.setSenderDisplayName('BigMachines Exception Information');
        
        // Specify the subject line for your email address.
        mail.setSubject('BigMachines User Provision');
        
        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);
        
        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        
        // Specify the text content of the email.
        mail.setPlainTextBody(message);
        
        // Specify the HTML content of the email.
        mail.setHtmlBody('<p>' + message + '</p>');
         
        // Send the email that is created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        }
    }
        
    

    // HTTP Request Utility
    public static HttpResponse getResponse(HttpRequest req)
    {
        // Instantiate the Http 
        Http http = new Http();

        // Send the request and retrieve the response
        HttpResponse res = new HttpResponse();
       if(!Test.isRunningTest()){ res = (callOut == true)?http.send(req):res;}
                
        return res;
    }

    public static HttpRequest buildWebServiceRequest(String methodStr, String subDomain, String httpValue, String body)
    {
        //Build HTTP Request object
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint(BMGlobal.BM_END_POINT.Replace(BMGlobal.BM_SUB_DOMAIN, subDomain).Replace(BMGlobal.BM_HTTP_REPLACE_VALUE, httpValue)); 
        req.setMethod(methodStr);
        req.setBody(body);
        return req;
    }

    // HTTP Response Utility
    // Return an element by its tag name
    public static String getElementByTagName(String xmlString, String tagName)
    {
        // Initialize the value
        String value = '';
        System.debug('==============tagName = ' + tagName);
        
        BMXMLDom dom = new BMXMLDom(xmlString);
        
        // Retrieve a list of values based on its tag name
        List<BMXMLDom.Element> elements = dom.getElementsByTagName(tagName);
        System.debug('==============Elements = ' + elements);
        
        // If there are elements present 
        if (elements != null)
        {
            // Check if there are more than one element present in the list
            if (elements.size() > 0)
            {
                // We are only interested in the first one, so return that value
                value = elements[0].nodeValue;
            }
        }
        return value;
    }
    
    public static BMXMLDom.Element getElementByTagName2(BMXMLDom dom, String tagName)
    {
        System.debug('==============tagName = ' + tagName);
        
        // Retrieve a list of values based on its tag name
        List<BMXMLDom.Element> elements = dom.getElementsByTagName(tagName);
        System.debug('==============Elements = ' + elements);
        
        // If there are elements present 
        if (elements != null)
        {
            // Check if there are more than one element present in the list
            if (elements.size() > 0)
            {
                // We are only interested in the first one, so return that value
                return elements[0];
            }
        }
        return null;
    }

    public static String extractMessage(HttpResponse res, String msg)
    {
        String sessionID;
        if (res != null && res.getStatus() == BMGlobal.OK)
        {
            String bodyElement = res.getBody();
            if (bodyElement != null)
            {
                System.debug('==============bodyElement ' + bodyElement);
                sessionID = getElementByTagName(bodyElement, msg);
            }
        }
        if(Test.isRunningTest())
        {
            sessionID = Userinfo.getSessionID();
            
        }
    
        return sessionID;
    }
    
    public static String validateConfigRecord(){
        return getAPIUserInfo().AdminEmail__c;
    }   
    
    public static void logout(String sessionId)
    {
        try
        {       
            HttpRequest req;
            //Instantiate SecuritySoapFunctions
            SecuritySoapFunctions securitySoapFunctions = new SecuritySoapFunctions();
            // Retrieve the security logout message
            String body = securitySoapFunctions.generateLogoutSoapMessage(userSecurity.APISubDomain__c, userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE, sessionId);
            System.debug('==============Logout request -' + body);
            req = buildWebServiceRequest(BMGlobal.METHOD, userSecurity.APISubDomain__c, userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE, body);
            // Get the response for the API Security call 
            HTTPResponse res = getResponse(req);
        } catch(Exception e) {
            System.debug('==============Logout of BigMachines web services failed. Error: ' + e.getMessage());                    
        }                           
    }
}