/*
 * SSO Middle ware resource
 * It will call middle ware sso service
 * Return sso data
 */
public class GE_OG_GS_GetSSOResource {
    
    private String ssoId; 
    public static String accessToken = '';
    public static String tokenType = '';
    
    public GE_OG_GS_GetSSOResource (String ssoId){
        this.ssoId = ssoId;
    }
    
    //Get sso data from middle ware 
    public String invoke(){
        GE_OG_GS_SSO_Auth_Setting__c authSetting = GE_OG_GS_SSO_Auth_Setting__c.getOrgDefaults();

        if(authSetting == null){
            throw new GE_OG_GS_SSOException('SSO Auth Setting not found.');
        }
        system.debug('OAuth URL = ' + authSetting.GE_OG_GS_Authentication_URL__c);
        String endpoint = authSetting.GE_OG_GS_Authentication_URL__c;
        
        
        String grantType = authSetting.Grant_Type__c;
        String scope = authSetting.scope__c;
        String clientId = authSetting.GE_OG_GS_ClientID__c;
        String secretKey = authSetting.GE_OG_GS_API_Secret__c;
        
        Blob headerValue = Blob.valueOf(clientId+':'+secretKey);
        
        
        String apiURL = authSetting.GE_OG_GS_API_URL__c;
        system.debug('clientId = '+ clientId + 'secretKey = '+ secretKey);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue) + '=';
        system.debug('authorizationHeader = '+ authorizationHeader);
        
        
        /*
        String apiKey = authSetting.GE_OG_GS_API_Key__c;
        system.debug('apiKey = '+apiKey);
        
        String apiSecret = authSetting.GE_OG_GS_API_Secret__c;
        system.debug('apiSecret = '+apiSecret);
        
        Long timee = System.now().getTime()/1000;
        String timestanp = string.valueOf(integer.valueOf(timee));
        system.debug(' timee = '+timee);
        system.debug('todaydatetime = '+System.now());
        
        String signatureString = apiKey+apiSecret+timee;
        system.debug('signatureString = '+signatureString);
        String sig = EncodingUtil.convertToHex(Crypto.generateDigest('MD5',Blob.valueOf(signatureString)));
        system.debug('sig = '+sig);
        
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(endpoint+'/'+ssoId+'?api_key='+apiKey+'&sig='+sig);
        req.setTimeOut(120000) ;
        system.debug('final request url = '+endpoint+'/'+ssoId+'?api_key='+apiKey+'&sig='+sig);
        */
        
        //Start
        
        HttpRequest req = new HttpRequest();
        // Formula to set API and Key
        req.setEndpoint(endpoint+'?grant_type='+grantType+'&scope='+scope); 
        req.setMethod('POST');
        req.setHeader('Authorization', authorizationHeader);
        system.debug('Request55' + req.getBody());
        // MJM 2015-07-20 Changed to 120,000 from 20,000 to reduce the amount of timeout erros being received
        req.setTimeout(120000);
        system.debug('********Request'+req.getBody());
        
        //End
        Http h = new Http();
        System.debug('RunningTest'+System.Test.isRunningTest());
        /*if(System.Test.isRunningTest()){
            return GE_OG_GS_SSODataTest.getTestResponse();
        }*/
        //else {
        
        System.debug('RunningTestElse'+System.Test.isRunningTest());
        HttpResponse resp = h.send(req);
        system.debug('Response Body = '+resp.getBody());
        
        JSONParser parser = JSON.createParser(resp.getBody());
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
        
        
        Http http1 = new Http();
        String authorizationHeaderAccess = tokenType + ' ' + accessToken;
        system.debug('authorizationHeaderAccess' + authorizationHeaderAccess);
        HttpRequest reqWithAccessToken = new HttpRequest();
        String newJson = authSetting.Format__c;
        reqWithAccessToken.setEndpoint(apiURL+ssoId); 
        reqWithAccessToken.setMethod('GET');
        reqWithAccessToken.setHeader('Authorization','Bearer ' + accessToken);
        system.debug('Request55' + reqWithAccessToken.getBody());
       
       
        reqWithAccessToken.setTimeout(120000);
        HTTPResponse res1 = new HTTPResponse();
        
            try
            {
                res1 = http1.send(reqWithAccessToken);
                System.debug('Response' + res1.getBody());
            }   
            catch (Exception ex) 
            {
                system.debug('Exception: ' + ex);
            }
        
            
            //Status=Forbidden, Status code = 403
            if(res1.getStatusCode() == 403){
                throw new GE_OG_GS_SSOException('Not Authorized, Please check api credentials');
            }
            //Status=No Content, StatusCode=204
            if(res1.getStatusCode() == 204){
                throw new GE_OG_GS_SSOException('SSO not Found');
            }
            // Status=Gateway Timeout, StatusCode=504
            if(res1.getStatusCode() == 504){
                throw new GE_OG_GS_SSOException('Service Not available');
            }
            return res1.getBody().replace('IT-FSE-ExpatContract', 'ITFSEExpatContract');
       
       //}
    }  
}