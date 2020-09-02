public with sharing class SoapBase {
	
	// Element to create Soap Envelope 
	private static BMXMLDom.Element envelope;
	// Element to create Soap Header
	private static BMXMLDom.Element header;
	// Element to create Soap Body
	private static BMXMLDom.Element body;
	// Retrieve the Soap header
	public static BMXMLDom.Element getSoapHeader()
	{
		// Instantiate the soap header
		header = new BMXMLDom.Element(BMGlobal.SOAP_ENV_HEADER);
		return header;
	}
	
	// Retrieve the Soap Body
	public static BMXMLDom.Element getSoapBody()
	{
		// Instantiate the soap body
		body = new BMXMLDom.Element(BMGlobal.SOAP_ENV_BODY);
		return body;
	}

	// Get the basic soap envelope	
	public static BMXMLDom.Element getSoapEnvelope()
	{
		// Check if the envelope is null or if child nodes are not created 
		// Create the envelope element
		envelope = new BMXMLDom.Element(BMGlobal.SOAPENV_ENVELOPE);
		
		// Set attributes for the envelope element
		envelope.attributes.put(BMGlobal.XMLNS_SOAPENV, BMGlobal.XMLNS_SOAPENV_VALUE);
		envelope.attributes.put(BMGlobal.XMLNS_XSD, BMGlobal.XMLNS_XSD_VALUE);
		envelope.attributes.put(BMGlobal.XMLNS_XSI, BMGlobal.XMLNS_XSI_VALUE);
		return envelope;				
	}
}