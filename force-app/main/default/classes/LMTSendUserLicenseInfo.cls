/******************************************************************************************************************************
* @Name -               LMTSendUserLicenseInfo
* @Author:              Ambresh Srivastava
* @ Modified By:        Ambresh SSO: 212597780;
* @Used By:             
*----------------------------------------------------------------------------
* Description - This class does the following:
                * It Get Executed at preferred Schedule time.
                * It Fetches The Company License Info From Current Org and Send it to Hub/Destination Org for License Management
                * This class incorporates both, Schedulable and batchable Inteface and act as one entity for whole functionality.
                
                
* Modification Log :
* --------------------------------------------------------------------------- */
global class LMTSendUserLicenseInfo implements Database.Batchable<sObject>, Database.AllowsCallouts, Schedulable
{
    global final String orgID = UserInfo.getOrganizationId();
 
    global Database.QueryLocator start(Database.BatchableContext bc){
       String query;
       string query1; 
       query = 'SELECT LMTClientSec__c,Label,LMTClientId__c,LMTPwd__c,LMTUID__c,';
       query+='LMTURLServices__c,LMTURL__c FROM LicenseManagmentData__mdt WHERE Label = \'LicenseManagmentData\'';
       system.debug('query1'+query);
        system.debug('123456789'+Database.getQueryLocator(query));
        return Database.getQueryLocator(query);
    }       
    global static void execute(Database.BatchableContext bc, List<LicenseManagmentData__mdt> scope)
    {
        system.debug('Ambresh'+scope);
        system.debug('Inside Send Request');
				//String clientId = Label.TestClientId;
        		String clientId = scope[0].LMTClientId__c;
				String clientSecret = scope[0].LMTClientSec__c;
				String username=scope[0].LMTUID__c;
				String password=scope[0].LMTPwd__c;
				String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;       
				Organization Orgid =[Select Id,InstanceName,Name,OrganizationType,PrimaryContact from Organization Limit 1];
				List<String> lstObject = new List<String>{'UserLicense','PermissionSetLicense'};//,
				List<sObject> ul = new list<sObject>();
				for(String objName : lstObject){
				ul.addAll(Database.query('SELECT Id,MasterLabel,TotalLicenses,UsedLicenses FROM '+objName));
				}
				system.debug('query' +ul);
			   // List<UserLicense> ul=[SELECT Id,MasterLabel,Name,TotalLicenses,UsedLicenses FROM UserLicense];
			  
			Http h = new Http();
			HttpRequest req = new HttpRequest();
			req.setBody(reqbody);
			req.setMethod('POST');
			//req.setEndpoint(Label.TestURL);
			req.setEndpoint(scope[0].LMTURL__c);
			
				
			HttpResponse res = h.send(req);
				system.debug('Response is'+res.getbody());
			 
				OAuth2 objAuthenticationInfo = (OAuth2)JSON.deserialize(res.getbody(), OAuth2.class);
        
		//RequestWrapper reqst=new RequestWrapper();
        if(Test.isrunningTest()) {
            objAuthenticationInfo.access_token = 'not_null';
            objAuthenticationInfo.id='testID';
            objAuthenticationInfo.instance_url='url';
            objAuthenticationInfo.issued_at='testPlace';
            objAuthenticationInfo.signature='test_signature';
        }
        
		if(objAuthenticationInfo.access_token!=null){
				//if(res.getStatusCode()!=null){
			JSONGenerator gen = JSON.createGenerator(true);
			
				gen.writeStartObject();
				gen.writeFieldName('reqWrp');
					gen.writeStartObject();
					gen.writeFieldName('OrgDetail');
					gen.writeStartObject();
					gen.writeStringField('Organization_Id__c',Orgid.id);
					gen.writeStringField('Name',Orgid.Name);
					gen.writeStringField('Instance_Name__c',Orgid.InstanceName);
					gen.writeStringField('Organization_Type__c',Orgid.OrganizationType);
					gen.writeStringField('Primary_Contact__c',Orgid.PrimaryContact);
					gen.writeEndObject();
					//gen.writeEndObject();
						//gen.writeStartObject();        
						gen.writeFieldName('usl');
			
						gen.writeStartArray();
						for(Integer i = 0; i<ul.size();i++)
						{
							String objName=((sObject)ul[i]).getSObjectType().getDescribe().getName();
							system.debug('objName'+objName);
			
							gen.writeStartObject();
							gen.writeStringField('OrgID__c', Orgid.id);
							
						  
							gen.writeNumberField('TotalLicenses__c',Integer.valueOf(ul[i].get('TotalLicenses')));
							gen.writeNumberField('UsedLicenses__c',Integer.valueOf(ul[i].get('UsedLicenses')));  
							gen.writeStringField('MasterLabel__c', String.valueOf(ul[i].get('MasterLabel')));
							gen.writeStringField('License_Name__c',String.valueOf(ul[i].get('MasterLabel')));
						
							gen.writeEndObject();    
						 }
						 gen.writeEndArray();
				gen.writeEndObject();        
		gen.writeEndObject();   
			
			Http h1 = new Http();
		  HttpRequest req1 = new HttpRequest();
		  req1.setMethod('POST');
		  req1.setHeader('Authorization','Bearer '+objAuthenticationInfo.access_token);
		  req1.setHeader('Content-Type','application/json');
		  req1.setHeader('Accept-headers','application/json');
		  req1.setBody(gen.getAsString());//Send JSON body  
		  system.debug('JSON is'+gen.getAsString());
              
  req1.setEndpoint(scope[0].LMTURLServices__c);
			req.setCompressed(true);//URL will be your Salesforce REST API end point where you will do POST,PUT,DELETE orGET
		  HttpResponse res1 = h1.send(req1);
			  
			
		}
			  
    }
    
    /*
    @future(Callout=true)
    global static void SendRequest()
    {
				
	}  */ 
    public class OAuth2
    {
        public String id{get;set;}
        public String issued_at{get;set;}
        public String instance_url{get;set;}
        public String signature{get;set;}
        public String access_token{get;set;}    
    }
 global void finish(Database.BatchableContext bc){
             
        }
    
    global void execute(SchedulableContext ctx) {
      Database.executeBatch(new LMTSendUserLicenseInfo(),50);
                
    }
}