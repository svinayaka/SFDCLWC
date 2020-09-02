@isTest
private class SecuritySoapFunctionsTest {
	// Element to create Security Soap Header
	private static BMXMLDom.Element securityHeader;
	// Element to create Security Soap Body
	private static BMXMLDom.Element securityBody;
	
	// Variable to set the current User Name
	private static String currentUserName;
	// Variable to set the current User Password
	private static String currentPassword;
	
	private static BMUserSecurity__c getBmSec(){
		BMUserSecurity__c bmSec = new BMUserSecurity__c();
		bmSec.isActive__c = true;		
		bmSec.APIUserName__c = 'BM API User';
		bmSec.APISubDomain__c = 'nsalesdemo';
		bmSec.APIUserPassword__c = 'BM password';
		bmSec.AdminEmail__c = 'email@email.com';	
		bmSec.BMSSLRequired__c = false;		
		return bmSec;	
	
	}
	
	static testMethod void generateSecuritySoapHeaderTest()
	{
		try{
			BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
			delete userSecurities;
			
			BMUserSecurity__c bmSec = getBmSec();	
			insert bmSec;
	
			BMUserSecurity__c userSecurity = getAPIUserInfo();
			SecuritySoapFunctions securitySoapFunctions = new SecuritySoapFunctions();
			BMXMLDom.Element securitySoapHeader = securitySoapFunctions.generateSecuritySoapHeader(userSecurity.APISubDomain__c, userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE);
	
			// Create the big machine category
			BMXMLDom.Element category = securitySoapHeader.getElementByTagName(BMGlobal.XMLNS_BM_CATEGORY);
			System.assertEquals(category.nodeName,BMGlobal.XMLNS_BM_CATEGORY);
			System.assertEquals(BMGlobal.XMLNS_BM_URN,category.attributes.get(BMGlobal.XMLNS_BM));
			System.assertEquals(BMGlobal.SOAPENV_ACTOR_URL,category.attributes.get(BMGlobal.SOAPENV_ACTOR));
			System.assertEquals(BMGlobal.SOAPENV_MUSTUNDERSTAND_VALUE,category.attributes.get(BMGlobal.SOAPENV_MUSTUNDERSTAND));
			System.assertEquals(BMGlobal.SECURITY, category.nodeValue);
	
			// Create the big machine category
			BMXMLDom.Element xsdInfo = securitySoapHeader.getElementByTagName(BMGlobal.BM_XSDINFO);
			System.assertEquals(xsdInfo.nodeName,BMGlobal.BM_XSDINFO);
			System.assertEquals(BMGlobal.XMLNS_BM_URN,xsdInfo.attributes.get(BMGlobal.XMLNS_BM));
			System.assertEquals(BMGlobal.SOAPENV_ACTOR_URL,xsdInfo.attributes.get(BMGlobal.SOAPENV_ACTOR));
			System.assertEquals(BMGlobal.SOAPENV_MUSTUNDERSTAND_VALUE,xsdInfo.attributes.get(BMGlobal.SOAPENV_MUSTUNDERSTAND));
	
			BMXMLDom.Element bmSchemaLocation = xsdInfo.getElementByTagName(BMGlobal.BM_SCHEMA_LOCATION);
			System.assertEquals(BMGlobal.BM_SECURITY_SCHEMA_LOCATION_VALUE.Replace(BMGlobal.BM_SUB_DOMAIN, userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c).Replace(BMGlobal.BM_HTTP_REPLACE_VALUE, userSecurity.BMSSLRequired__c==null?'':userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE),bmSchemaLocation.nodeValue);
		}
		catch(Exception e){
			System.debug('Exception in generateSecuritySoapHeaderTest: ' + e.getMessage());
		}
		
	}

	static BMUserSecurity__c getAPIUserInfo()
	{
		BMUserSecurity__c[] userSecurities = [SELECT APIUserName__c, APIUserPassword__c, APISubDomain__c, BMSSLRequired__c, AdminEmail__c FROM BMUserSecurity__c WHERE isActive__c = true LIMIT 1];
		BMUserSecurity__c userSecurity;
		if (userSecurities.size() > 0)
			userSecurity = userSecurities[0];
	
		return userSecurity;
	}
		
	static testMethod void generateLoginSoapMessageTest()
	{
		try{
			BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
			delete userSecurities;
			
			BMUserSecurity__c bmSec = getBmSec();	
			insert bmSec;
	
			BMUserSecurity__c userSecurity = getAPIUserInfo();
			if (userSecurity != null)
			{
				SecuritySoapFunctions securitySoapFunctions = new SecuritySoapFunctions();
				String envelope = securitySoapFunctions.generateLoginSoapMessage(userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c,userSecurity.BMSSLRequired__c==true?BMGlobal.BM_HTTP_WITH_SSL_VALUE:BMGlobal.BM_HTTP_VALUE,userSecurity.APIUserName__c==null?'':userSecurity.APIUserName__c, userSecurity.APIUserPassword__c==null?'':userSecurity.APIUserPassword__c);
				BMXMLDom dom = new BMXMLDom(envelope);
			}
		}
		catch(Exception e){
			System.debug('Exception in generateLoginSoapMessageTest: ' + e.getMessage());
		}	
	}
}