public class GE_OG_GetSSO_OHR_User_Update {
/*
 * SSO Middle ware resource
 * It will call middle ware sso service
 * Return sso data
 */
 
 /*
  * Updated   : To accomodate the changes from OHR To Akana
  * updated by: Ashish Vashisht
  */
   
    private String endPoint; 
    
    public class deserializeResponse
    {
          //public String id;
          public String access_token;
           //public String token_type;
    }

      
    public string returnresponse( String SSO)
    {
      GE_OG_GS_SSO_Auth_Setting__c authSetting = GE_OG_GS_SSO_Auth_Setting__c.getOrgDefaults();
      
      if(authSetting == null){
            throw new GE_OG_GS_SSOException('SSO Auth Setting not found.');
        }
        
      System.debug('ash---'+authSetting.GE_OG_GS_ClientID__c);
      System.debug('ash---' +authSetting.GE_OG_GS_API_Secret__c );

      String reqbody = 'client_id='+ authSetting.GE_OG_GS_ClientID__c +'&client_secret='+ authSetting.GE_OG_GS_API_Secret__c ;
      
      //Build Request 
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setBody(reqbody);
      req.setMethod('POST');
      req.setEndpoint(authSetting.GE_OG_GS_Authentication_URL__c + '?grant_type='+ authSetting.Grant_Type__c +'&scope='+authSetting.scope__c);
      //req.setTimeout(200000);
      
      HttpResponse res;

      res = h.send(req);
      System.debug('res' + res );
      
      
      deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
      System.debug(resp1 + ' ' + resp1.access_token);


      endPoint = authSetting.GE_OG_GS_API_URL__c + SSO ;
      

      Http h2 = new Http();
      HttpRequest req1 = new HttpRequest();
      req1.setHeader('Authorization','Bearer ' + resp1.access_token);
      
      req1.setMethod('GET');
      req1.setEndpoint(endPoint);
      //req1.setTimeout(200000);
      
      HttpResponse res1;
      try
      {
        res1 = h2.send(req1);
        System.debug('@@@'+res1 );
      }
      catch(Exception e)
      {
          System.debug('Exception caught:-' + e);
      }
      
      
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
     
    }
}