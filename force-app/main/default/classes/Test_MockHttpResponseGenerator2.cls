/*
Author:Satish Atla
Functional Area:Opportunity Management
*/

@isTest
                        
global class Test_MockHttpResponseGenerator2 implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        //System.assertEquals('http://api.salesforce.com/foo/bar', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status":{"state":"completed","message":"Outage successfully inserted","links":[{"rel":"self","href":"https://api.geoilandgas.com/dev/v1/ibas/users/105047618/fleets/site-outages/2665"}]}}');
        return res;
    }
}