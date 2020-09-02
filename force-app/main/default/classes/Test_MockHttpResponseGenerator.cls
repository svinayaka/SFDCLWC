@isTest
                        
global class Test_MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        //System.assertEquals('http://api.salesforce.com/foo/bar', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"events":{"orderBy":"gibSerialNumber","orderType":"asc","total":29,"data":[{"gibSerialNumber":"226165","oemSerialNumber":"G07732","technologyCodeOilAndGas":"HDGT","technologyDescOilAndGas":"HD Gas Turbine","eventDataList":{"orderBy":"eventID","orderType":"asc","total":5,"data":[{"eventID":"774","maintLevelCod":"CI","eventDate":"2011-05-05T00:00:00","eventClassCod":"PO","eventStatusDescription":"Confirmed","eventTypeDescription":"Combustion Inspection","siteOtgID":"2632","siteDunsNumber":"CAT052892","oemSerialNumber":"G07732","technologyCodeOilAndGas":"HDGT","technologyDescOilAndGas":"HD Gas Turbine"}]}}]}}');
       return res;
    }
}


//{"events":{"orderBy":"gibSerialNumber","orderType":"asc","total":29,"data":[{"gibSerialNumber":"226165","oemSerialNumber":"G07732","technologyCodeOilAndGas":"HDGT","technologyDescOilAndGas":"HD Gas Turbine","eventDataList":{"orderBy":"eventID","orderType":"asc","total":5,"data":[{"eventID":"774","maintLevelCod":"CI","eventDate":"2011-05-05T00:00:00","eventClassCod":"PO","eventStatusDescription":"Confirmed","eventTypeDescription":"Combustion Inspection","siteDunsNumber":"CAT052892","siteOtgID":"2632",