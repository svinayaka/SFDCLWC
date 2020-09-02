@isTest
private class SoapBaseTest {

	static testMethod void getSoapHeaderTest()
	{
		try{
			BMXMLDom.Element soapHeader = SoapBase.getSoapHeader();
			System.assertEquals(BMGlobal.SOAP_ENV_HEADER,soapHeader.nodeName);
			
			BMXMLDom.Element soapBody = SoapBase.getSoapBody();
			System.assertEquals(BMGlobal.SOAP_ENV_BODY,soapBody.nodeName);
	
			BMXMLDom.Element soapEnvelope = SoapBase.getSoapEnvelope();
			System.assertEquals(BMGlobal.SOAPENV_ENVELOPE,soapEnvelope.nodeName);
			System.assertEquals(BMGlobal.XMLNS_SOAPENV_VALUE,soapEnvelope.attributes.get(BMGlobal.XMLNS_SOAPENV));
			System.assertEquals(BMGlobal.XMLNS_XSD_VALUE,soapEnvelope.attributes.get(BMGlobal.XMLNS_XSD));
			System.assertEquals(BMGlobal.XMLNS_XSI_VALUE,soapEnvelope.attributes.get(BMGlobal.XMLNS_XSI));
		}
		catch(Exception e){
			System.debug('Exception in getSoapHeaderTest: ' + e.getMessage());
		}
	}
}