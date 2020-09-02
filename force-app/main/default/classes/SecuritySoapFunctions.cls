public with sharing class SecuritySoapFunctions {
	
	// Element to create Security Soap Header
	private BMXMLDom.Element securityHeader;
	// Element to create Security Soap Body
	private BMXMLDom.Element securityBody;

	// Variable to set the current User Name
	private String currentUserName;
	// Variable to set the current User Password
	private String currentPassword;

	//Constructor
	public SecuritySoapFunctions()
	{
	}

	// Retrieve the Security Soap Header
	//	<soapenv:Header>
	//		<bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category>
	//		<bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">
	//			<bm:schemaLocation>http://forcedev.bigmachines.com/bmfsweb/forcedev/schema/v1_0/security/Security.xsd</bm:schemaLocation>
	//		</bm:xsdInfo>
	//	</soapenv:Header>
	public BMXMLDom.Element generateSecuritySoapHeader(String subDomain, String httpValue)
	{
		// Check if the security Header is null or if child nodes are not created
		if (securityHeader == null || securityHeader.hasChildNodes() == false)
		{
			// Call the security header
			securityHeader = SoapBase.getSoapHeader();

			// Create the big machine category
			BMXMLDom.Element bmCategory = new BMXMLDom.Element(BMGlobal.XMLNS_BM_CATEGORY);

			// Set the attributes for the big machine category element
			bmCategory.attributes.put(BMGlobal.XMLNS_BM, BMGlobal.XMLNS_BM_URN);
			bmCategory.attributes.put(BMGlobal.SOAPENV_ACTOR, BMGlobal.SOAPENV_ACTOR_URL);
			bmCategory.attributes.put(BMGlobal.SOAPENV_MUSTUNDERSTAND, BMGlobal.SOAPENV_MUSTUNDERSTAND_VALUE);

			// Set the node value for the big machine category to security
			bmCategory.nodeValue = BMGlobal.SECURITY;
			
			// Append the child element to the Security Header
			securityHeader.appendChild(bmCategory);		

			// Create the big machine xsd info
			BMXMLDom.Element bmXsdInfo = new BMXMLDom.Element(BMGlobal.BM_XSDINFO);

			// Set the attributes for the big machine xsd info element
			bmXsdInfo.attributes.put(BMGlobal.XMLNS_BM, BMGlobal.XMLNS_BM_URN);
			bmXsdInfo.attributes.put(BMGlobal.SOAPENV_ACTOR, BMGlobal.SOAPENV_ACTOR_URL);
			bmXsdInfo.attributes.put(BMGlobal.SOAPENV_MUSTUNDERSTAND, BMGlobal.SOAPENV_MUSTUNDERSTAND_VALUE);
			
			// Create the big machine schema location element
			BMXMLDom.Element bmSchemaLocation = new BMXMLDom.Element(BMGlobal.BM_SCHEMA_LOCATION);
			// Set the node value for the big machine schema location element
			bmSchemaLocation.nodeValue = BMGlobal.BM_SECURITY_SCHEMA_LOCATION_VALUE.Replace(BMGlobal.BM_SUB_DOMAIN, subDomain).Replace(BMGlobal.BM_HTTP_REPLACE_VALUE, httpValue);
			
			// Append the schema location element to the xsd Info element
			bmXsdInfo.appendChild(bmSchemaLocation);
			
			// Finally add the xsd info element to the security header
			securityHeader.appendChild(bmXsdInfo);
		}
		
		// return security header element
		return securityHeader;
	}
	
	// Retrieve the Security Soap Body
	//	<soapenv:Body>
	//		<bm:login xmlns:bm="urn:soap.bigmachines.com">
	//			<bm:userInfo>
	//				<bm:username>dpandya</bm:username>
	//				<bm:password>comity1</bm:password>
	//			</bm:userInfo>
	//		</bm:login>
	//	</soapenv:Body>
	private BMXMLDom.Element generateLoginSoapBody(String userName, String password)
	{
		// Check if the security Header is null or if child nodes are not created or if the username / password has changed
		if (securityBody == null || securityBody.hasChildNodes() == false || currentUserName != userName || currentPassword != password)
		{
			// set current User Name
			currentUserName = userName;
			// set current User Password
			currentPassword = password;
			
			// Call the security body
			securityBody = SoapBase.getSoapBody();
			
			// Create a big machine Login element
			BMXMLDom.Element bmLogin = new BMXMLDom.Element(BMGlobal.BM_LOGIN);

			// Set the attributes for the big machine login element
			bmLogin.attributes.put(BMGlobal.XMLNS_BM, BMGlobal.XMLNS_BM_URN);
			
			// Create element for the user info
			BMXMLDom.Element bmUserInfo = new BMXMLDom.Element(BMGlobal.BM_USER_INFO);
			// Create element for the big machine API user's username
			BMXMLDom.Element bmUserName = new BMXMLDom.Element(BMGlobal.BM_USER_NAME);
			//Set value for the big machine userName
			bmUserName.nodeValue = userName;
			// Create element for the big machine API user password
			BMXMLDom.Element bmPassword = new BMXMLDom.Element(BMGlobal.BM_PASSWORD);
			//Set value for the big machine password
			bmPassword.nodeValue = password;
			
			// Append both username and password to userInfo element
			bmUserInfo.appendChild(bmUserName);
			bmUserInfo.appendChild(bmPassword);

			// Append both username and password to userInfo element
			bmLogin.appendChild(bmUserInfo);
		
			// Append the login info for API user to security body
			securityBody.appendChild(bmLogin);
		}
		return securityBody;
	}
	
	// Generate Security soap message based on envelop, header and body
	//<?xml version="1.0" encoding="UTF-8"?>
	//<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	//	<soapenv:Header>
	//		<bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Security</bm:category>
	//		<bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">
	//			<bm:schemaLocation>http://forcedev.bigmachines.com/bmfsweb/forcedev/schema/v1_0/security/Security.xsd</bm:schemaLocation>
	//		</bm:xsdInfo>
	//	</soapenv:Header>
	//	<soapenv:Body>
	//		<bm:login xmlns:bm="urn:soap.bigmachines.com">
	//			<bm:userInfo>
	//				<bm:username>dpandya</bm:username>
	//				<bm:password>comity1</bm:password>
	//			</bm:userInfo>
	//		</bm:login>
	//	</soapenv:Body>
	//</soapenv:Envelope>
	public String generateLoginSoapMessage(String subDomain, String httpValue, String userName, String password)
	{
		// Initialize the root value
		String rootValue = '';
		try
		{
			//System.Debug(this.root.toXmlString());
			//System.Debug('Envelope - ' + getSoapEnvelope().toXmlString());
			// Generate the envelope and at the same time add the soap header element
			BMXmlDom.Element envelope = SoapBase.getSoapEnvelope();
			envelope.appendChild(generateSecuritySoapHeader(subDomain, httpValue));
			//System.Debug('Envelope with soapHeader - ' + getSoapEnvelope().toXmlString());

			// Add the soap body element
			envelope.appendChild(generateLoginSoapBody(userName, password));

			//System.Debug('Envelope with soapBody - ' + getSoapEnvelope().toXmlString());

			// Concatenate encoding and version along with the soap envelope that was created
			rootValue = BMGlobal.XML_VERSION_ENCODING + envelope.toXmlString();
		}
		catch(System.CalloutException e) 
		{
			System.debug('Exception e: ' + e);
		}   
		return rootValue;
	}
	
	public String generateLogoutSoapMessage(String subDomain, String httpValue, String sessionId)
	    {
	        // Initialize the root value
	        String rootValue = '';
	        try
	        {
	            // Call the Add/Update User header
	            BMXMLDom.Element logoutHeader = SoapBase.getSoapHeader();
	            // Create the big machine userInfo
	            BMXMLDom.Element bmUserInfo = new BMXMLDom.Element(BMGlobal.BM_USER_INFO);
	            bmUserInfo.attributes.put(BMGlobal.XMLNS_BM, BMGlobal.XMLNS_BM_URN);
	            bmUserInfo.attributes.put(BMGlobal.SOAPENV_ACTOR, BMGlobal.SOAPENV_ACTOR_URL);
	            bmUserInfo.attributes.put(BMGlobal.SOAPENV_MUSTUNDERSTAND, BMGlobal.SOAPENV_MUSTUNDERSTAND_VALUE);
	            BMXMLDom.Element bmSessionId = new BMXMLDom.Element(BMGlobal.BM_SESSION_ID);
	            bmSessionId.nodeValue = sessionId;
	            bmUserInfo.appendChild(bmSessionId);
	
	            // Append the child element to the addUpdate Header
	            logoutHeader.appendChild(bmUserInfo);        
	            
	            // Create the big machine category
	            BMXMLDom.Element bmCategory = new BMXMLDom.Element(BMGlobal.XMLNS_BM_CATEGORY);
	
	            // Set the attributes for the big machine category element
	            bmCategory.attributes.put(BMGlobal.XMLNS_BM, BMGlobal.XMLNS_BM_URN);
	            bmCategory.attributes.put(BMGlobal.SOAPENV_ACTOR, BMGlobal.SOAPENV_ACTOR_URL);
	            bmCategory.attributes.put(BMGlobal.SOAPENV_MUSTUNDERSTAND, BMGlobal.SOAPENV_MUSTUNDERSTAND_VALUE);
	
	            // Set the node value for the big machine category to addUpdate
	            bmCategory.nodeValue = BMGlobal.USERS;
	            
	            // Append the child element to the addUpdate Header
	            logoutHeader.appendChild(bmCategory);    
	            
	            // Create the big machine xsd info
	            BMXMLDom.Element bmXsdInfo = new BMXMLDom.Element(BMGlobal.BM_XSDINFO);
	
	            // Set the attributes for the big machine xsd info element
	            bmXsdInfo.attributes.put(BMGlobal.XMLNS_BM, BMGlobal.XMLNS_BM_URN);
	            bmXsdInfo.attributes.put(BMGlobal.SOAPENV_ACTOR, BMGlobal.SOAPENV_ACTOR_URL);
	            bmXsdInfo.attributes.put(BMGlobal.SOAPENV_MUSTUNDERSTAND, BMGlobal.SOAPENV_MUSTUNDERSTAND_VALUE);
	            
	            // Create the big machine schema location element
	            BMXMLDom.Element bmSchemaLocation = new BMXMLDom.Element(BMGlobal.BM_SCHEMA_LOCATION);
	            // Set the node value for the big machine schema location element
	            bmSchemaLocation.nodeValue = BMGlobal.BM_USER_SCHEMA_LOCATION_VALUE.replace(BMGlobal.BM_SUB_DOMAIN, subDomain).Replace(BMGlobal.BM_HTTP_REPLACE_VALUE, httpValue);
	            
	            // Append the schema location element to the xsd Info element
	            bmXsdInfo.appendChild(bmSchemaLocation);
	            
	            // Finally add the xsd info element to the addUpdate header
	            logoutHeader.appendChild(bmXsdInfo);
	
                logoutHeader.appendChild(generateLogoutSoapBody());
                
	            // Concatenate encoding and version along with the soap envelope that was created
	            rootValue = BMGlobal.XML_VERSION_ENCODING + logoutHeader.toXmlString();
	        }
	        catch(System.CalloutException e) 
	        {
	            System.debug('Exception e: ' + e);
	        }   
	        return rootValue;
	    }
	    
	private BMXMLDom.Element generateLogoutSoapBody() {
        // Create a big machine Logout element
        BMXMLDom.Element bmLogout = new BMXMLDom.Element(BMGlobal.BM_LOGOUT);
        // Set the attributes for the big machine login element
        bmLogout.attributes.put(BMGlobal.XMLNS_BM, BMGlobal.XMLNS_BM_URN);
        return bmLogout;		
	}
	
}