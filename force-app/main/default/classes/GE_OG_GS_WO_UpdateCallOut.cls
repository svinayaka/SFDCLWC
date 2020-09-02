/**
 * Author: Chris Hurd
 * Date: May 5, 2015
 * Purpose: Make Middleware callout when WO update is created
 * MAPLES - Edited on 2015-07-20 to extend timeout value
 */
public with sharing class GE_OG_GS_WO_UpdateCallOut {

    public static boolean hasProcessed = false;
    public static String accessToken = '';
    public static String tokenType = '';

    
    public static void sendCallout(List<GE_OG_GS_WO_Updates__c> updateList)
    {
        if (hasProcessed)
        {
            return;
        }
        
        Set<String> woUpdateSet = new Set<String>();
        
        for (GE_OG_GS_WO_Updates__c woUpdate : updateList){
            // adding condition to only send records related to GS-Requirements
            // Adding condition to send record for GS-Training records as well for R-24974
            if (woUpdate.GE_OG_GS_Record_Type__c =='GS-Requirement' || woUpdate.GE_OG_GS_Record_Type__c =='GS-Training' || woUpdate.GE_OG_GS_Record_Type__c == 'GS-Equipment')
            {
                woUpdateSet.add(woUpdate.Id);
            }
            system.debug('woUpdateSet values'+woUpdate.Id);
        }
        system.debug('woUpdateSet values'+woUpdateSet);
        initiateCallOut(woUpdateSet);
        hasProcessed = true;
    }
    
    
    @future(callout=true)
    public static void initiateCallOut(Set<String> woUpdateSet)
    {
        // added next 4 lines to check custom settings and display message if no value
            //GE_OG_GS_WO_Update_Settings__c authSetting = GE_OG_GS_WO_Update_Settings__c.getOrgDefaults();
            //GE_OG_GS_WO_Update_Settings_Oauth__c authSetting = GE_OG_GS_WO_Update_Settings_Oauth__c.getOrgDefaults();
            GE_OG_GS_WO_Update_Settings__c authSetting = GE_OG_GS_WO_Update_Settings__c.getOrgDefaults();
            if(authSetting == null){
                throw new GE_OG_GS_SSOException('WO Update Setting not found.');
            }
        // Setting values for URL and Key
        system.debug('OAuth URL = ' + authSetting.GE_OG_GS_Authentication_URL__c);
        String endpoint = authSetting.GE_OG_GS_Authentication_URL__c;
        
        String grantType = authSetting.Grant_Type__c;
        String scope = authSetting.scope__c;
        String clientId = authSetting.GE_OG_GS_ClientID__c;
        String secretKey = authSetting.GE_OG_GS_Client_Secret__c;
        
        Blob headerValue = Blob.valueOf(clientId+':'+secretKey);
        
        String apiURL = authSetting.GE_OG_GS_API_URL__c;
        system.debug('clientId = '+ clientId + 'secretKey = '+ secretKey);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue) + '=';
        system.debug('authorizationHeader = '+ authorizationHeader);
        
        HttpRequest req = new HttpRequest();
        // Commented out to test custom setting  
        // req.setEndpoint('https://api.geoilandgas.com/dev/v1/gs/field-automation/publish/servicemax/work-order-event?api_key=k3kheh88fvu26wwfmx8ejfw2');
        // Formula to set API and Key
        req.setEndpoint(endpoint+'?grant_type='+grantType+'&scope='+scope); 
        req.setMethod('POST');
        req.setHeader('Authorization', authorizationHeader);
        system.debug('Request55' + req.getBody());
        // MJM 2015-07-20 Changed to 120,000 from 20,000 to reduce the amount of timeout erros being received
        req.setTimeout(120000);
        
        Http http = new Http();
        HTTPResponse res = new HTTPResponse();
        String json1;        
        for (String stagingObjectId : woUpdateSet)
        {
        system.debug('wo update set'+woUpdateSet);
            json1 = '{"work-order-event": { "stagingObjectID" : "' + stagingObjectId + '"}}';
            req.setBody(json1);
            try
            {
                res = http.send(req);
                System.debug('Response' + res.getBody());
            }   
            catch (Exception ex) 
            {
                system.debug('Exception: ' + ex);
            }
        }
        JSONParser parser = JSON.createParser(res.getBody());
        
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText() == 'access_token')) {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                accessToken += parser.getText();
                system.debug('AccessTokenExactValues'+accessToken);
            }
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText() == 'token_type')) {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                tokenType += parser.getText();
                system.debug('TokenExactTypetoken_type'+tokenType);
            }

        }
        String authorizationHeaderAccess = tokenType + ' ' + accessToken;
        system.debug('authorizationHeaderAccess' + authorizationHeaderAccess);
        HttpRequest reqWithAccessToken = new HttpRequest();
        String newJson = authSetting.Format__c;
        reqWithAccessToken.setEndpoint(apiURL+'?format='+newJson); 
        reqWithAccessToken.setMethod('GET');
        reqWithAccessToken.setHeader('Authorization', authorizationHeaderAccess);
        system.debug('Request55' + reqWithAccessToken.getBody());
       
        reqWithAccessToken.setTimeout(120000);
        Http http1 = new Http();
        HTTPResponse res1 = new HTTPResponse();
        reqWithAccessToken.setBody(json1);
            try
            {
                res1 = http1.send(reqWithAccessToken);
                System.debug('Response' + res1.getBody());
            }   
            catch (Exception ex) 
            {
                system.debug('Exception: ' + ex);
            }
    }
    
    
}