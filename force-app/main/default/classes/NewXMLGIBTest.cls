@IsTest
private with sharing class NewXMLGIBTest
{
    private static testMethod void coverTypes()
    {
        new NewXMLGIB.publishOpportunity();
        new NewXMLGIB.GIBUnitUpdateResponse();
        new NewXMLGIB.GIBUnitUpdateRequest();
        new NewXMLGIB.GIBUNITUPDATE();
        new NewXMLGIB.publishOpportunityResponse();
        new NewXMLGIB.GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port();
    }
    
    
    private class  WebServiceMockImpl implements WebServiceMock
    
    {
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType)
        {
            if(request instanceof NewXMLGIB.publishOpportunity)
                response.put('response_x', new NewXMLGIB.publishOpportunityResponse());
            return;
        }
    }
    
    
   /* private static testMethod void coverMethods()
    {
       // new NewXMLGIB .XAVPort().ProcessXAV(null, null, null, null);
       
      //new NewXMLGIB .GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port().publishGIBUnitUpdate(new NewXMLGIB ().GIBUnitUpdateRequest GIBUnitUpdateRequest);
      new NewXMLGIB .GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port().publishGIBUnitUpdate(null);
    }
    */
    
      private static testMethod void coverMethods()
    {
        /*new NewXMLGIB .GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port.publishGIBUnitUpdate(new NewXMLGIB .GIBUnitUpdateRequest GIBUnitUpdateRequest);
        */
        
       //new NewXMLGIB .GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port.publishGIBUnitUpdate
       
       
       try
        {
        
         new NewXMLGIB.GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port().publishGIBUnitUpdate(null);
        }catch(Exception e)
        {
        
        System.debug('e*************'+e);
        }
       
          
       //new NewXMLGIB .GE_SFDC_GIBUnitUpdate_Source_webServices_publishGIBUnitUpdate_WSD_Port().publishGIBUnitUpdate(null);
       
       Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
    }
    
    
    
    
    
    
    
}