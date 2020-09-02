public class GE_OG_SendRequestTypeId_Opp{
    public class deserializeResponse
    {
          public String id;
          public String access_token;
           //public String token_type;
    }
    @InvocableMethod 
    public static void SendRequestTypeId_Opp_invoke( List<Id> oppid)
    {
        String s = String.valueof(oppid[0]);

            for(Id objid :oppid)
            {
                Id rtypeid = objid; 
                if(s.startsWith('006'))
                {
                    SendOpportunityIdToPII(rtypeid);
                }
                else
                {
                    SendRequestTypeIdToTMSP6(rtypeid );
                }
            }
    }
    
    @future (callout=true)
    public static void SendRequestTypeIdToTMSP6( Id oppid)
    {
        
      RequestTypeToTMSPAuthSetting__c authSetting = RequestTypeToTMSPAuthSetting__c.getOrgDefaults();
      
      if(authSetting == null){
            throw new GE_OG_GS_SSOException('SSO Auth Setting not found.');
      }
      String clientId =authSetting.clientId__c ;
      String clientSecret = authSetting.clientSecret__c ;

      String reqbody = 'client_id='+clientId+'&client_secret='+clientSecret;
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setBody(reqbody);
      req.setMethod('POST');
      req.setEndpoint(authSetting.AuthEndPoint__c);
      HttpResponse res = h.send(req);
      deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
      System.debug(resp1 + ' ' + resp1.access_token);
    
        //deserializeResponse:[access_token=MNpUbSUiaH76vbIrmT6rLhtAIqjV, id=null] 


    String endPoint = authSetting.EndPoint__c;

    //String accName = 'Ashish Vashisht';
    String js =Label.SOAP_XML_RequestTypeToTMSPAuthSetting ;
    Integer a =js.indexOf('@');
    String soappart1 = js.subString(0,a);
    String soappart2 = js.subString(a+1);
    System.debug('###' + soappart1 +' '+ soappart2);
    String jsonstr = soappart1 + oppid +soappart2;
        System.debug(jsonstr + '@@@@');
      Http h2 = new Http();
      HttpRequest req1 = new HttpRequest();
      req1.setHeader('Authorization','Bearer ' + resp1.access_token);
      req1.setHeader('Content-Type','application/xml');
      //req1.setHeader('Content-Type', 'text/xml');
      req.setHeader('SOAPAction', '""');
      req1.setBody(jsonstr);
      req1.setMethod('POST');
      req1.setEndpoint(endPoint);
      HttpResponse res1 = h2.send(req1);
      System.debug(res1);
      System.debug(res1.getbody());
      
     } 
     
    @future (callout=true)
    public static void SendOpportunityIdToPII( Id oppid)
    {
        
      RequestTypeToTMSPAuthSetting__c authSetting = RequestTypeToTMSPAuthSetting__c.getOrgDefaults();
      
      if(authSetting == null){
            throw new GE_OG_GS_SSOException('SSO Auth Setting not found.');
      }
      String clientId =authSetting.clientId__c ;
      String clientSecret = authSetting.clientSecret__c ;

      String reqbody = 'client_id='+clientId+'&client_secret='+clientSecret;
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setBody(reqbody);
      req.setMethod('POST');
      req.setEndpoint(authSetting.AuthEndPoint__c);
      HttpResponse res = h.send(req);
      deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
      System.debug(resp1 + ' ' + resp1.access_token);
    
        //deserializeResponse:[access_token=MNpUbSUiaH76vbIrmT6rLhtAIqjV, id=null] 


    String endPoint = authSetting.EndPointPII__c;

    //String accName = 'Ashish Vashisht';
    String js =Label.SOAP_XML_RequestTypeToPIIAuthSetting;
    Integer a =js.indexOf('@');
    String soappart1 = js.subString(0,a);
    String soappart2 = js.subString(a+1);
    System.debug('###' + soappart1 +' '+ soappart2);
    String jsonstr = soappart1 + oppid +soappart2;
        System.debug(jsonstr + '@@@@');
      Http h2 = new Http();
      HttpRequest req1 = new HttpRequest();
      req1.setHeader('Authorization','Bearer ' + resp1.access_token);
      req1.setHeader('Content-Type','application/xml');
      //req1.setHeader('Content-Type', 'text/xml');
      req.setHeader('SOAPAction', '""');
      req1.setBody(jsonstr);
      req1.setMethod('POST');
      req1.setEndpoint(endPoint);
      HttpResponse res1 = h2.send(req1);
      System.debug(res1);
      System.debug(res1.getbody());
      
     } 
}