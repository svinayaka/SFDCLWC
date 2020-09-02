/******************************************************************************************************************************
* @Name -               LMTMockHttpResponseGenerator
* @Author:              Chandralekha
* @ Modified By:        
* @Used By:             
*----------------------------------------------------------------------------
* Description - This class does the following:
                * Its Used for Providing Test COverage for REST Callout in SendUserLicenseInfo class
                
* Modification Log :
* --------------------------------------------------------------------------- */
@isTest
global class LMTMockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
       
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
    }
}