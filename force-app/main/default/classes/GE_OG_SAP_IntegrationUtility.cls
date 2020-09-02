/*
Class Name: GE_OG_SAP_IntegrationUtility
Used For : Sending emails,logging error and defining re-usable methods
Purpose/Overview : Apex classes built has part of ServiceMax integration with SAP PI
Author: SriKrishna Kolanu
Created Date: 24th Aug 2015
Test Class Name : Test_GE_OG_PCIntegrationChange 
Requirement : 
History    : 
S No.    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
1.          12/18/2015      Abhijeet Mitra      OAuth Sections added              OAuth implementation for Outbound Integration
*/

public class GE_OG_SAP_IntegrationUtility{          
    //Constructor
    public GE_OG_SAP_IntegrationUtility() {
    }
    //OAuth
    public class OAuthResponse{
       String token_type;
       String expires_in;
       String access_token;
    }
    public class ValidationResult{
        public String result;
        public String errorMsg;
    }
    
    //variable declaration for SAP Integration
    public static final Integer AL_SOA_TIMEOUT = 45000;
    public static final String LOG_DESCRIPTION='Data is Synced to PI Middleware for Work Order: ';
    public static final String LOC_INBOUND_ERROR_MSG='Location details cannot be inserted in ServiceMax.'; 
    public static final String IP_INBOUND_ERROR_MSG='Installed Product details cannot be inserted in ServiceMax.';
    public static final String WO_SUCCESS_MSG='Work Order Successfully published to SAP.'; 
    public static final String WO_ERROR_MSG='Error in publishing work order to SAP. Detailed description of the error will be sent to your registered email.';
    public static final String AL_ENVIRON = Label.GE_Integration_Environment;
    
    //OAuth Configurations
    private static final integer OAuth_TIMEOUT=90000; 
    private static final String OAuth_METHOD='POST';
    
    //Location RecordTypes
    public static final String WELL_LOCATION_RECORD_TYPE='Well';
    
    //Installed Product RecordTypes
    public static final String AL_InstalledProduct_RECORD_TYPE='GE OG D&S Artificial Lift';
    
    //Email Configuration
    public static final String EMAIL_DISPLAY_NAME ='SMAX INTEGRATION TO SAP'; 
    public static final String EMAIL_OUT_SUBJECT = 'Error in publishing Location to SAP'; 
    public static final String EMAIL_INB_LOCATION_SUCC_SUBJECT = 'Locations Successfully Inserted to SMax'; 
    public static final String EMAIL_INB_LOCATION_FAIL_SUBJECT = 'Error in inserting Location details to SMax';
    public static final String EMAIL_INB_IP_FAIL_SUBJECT = 'Error in inserting InstallProduct details to SMax';
    public static final String EMAIL_OUT_WO_FAIL_SUBJECT = 'Error in publishing work order to SAP';
    public static final String EMAIL_OUT_WO_SUCCESS_SUBJECT = 'Work Order Successfully published to SAP';
    
    //OAuth End points 
    private static  final  String  OAuth_ENDPOINT_BASE_DEV  = 'https://fssfed.stage.ge.com/fss/as/token.oauth2';
    public  static  final  String  OAuth_ENDPOINT_BASE_QA   = 'https://fssfed.stage.ge.com/fss/as/token.oauth2';
    public  static  final  String  OAuth_ENDPOINT_BASE_PROD = 'https://fssfed.ge.com/fss/as/token.oauth2';
    
    //PI End constants     
    private static final String AL_ENDPOINT_BASE_DEV = 'https://dev.api.ge.com:443/geoilgas/luf/smax/createserviceorder/v1';
    private static final String AL_ENDPOINT_BASE_QA = 'https://stage.api.ge.com:443/geoilgas/luf/smax/createserviceorder/v1';
    private static final String AL_ENDPOINT_BASE_PROD = 'https://api.ge.com/geoilgas/luf/smax/createserviceorder/v1';

    //Querying Account Details using DUNS#
    public List<Account> accountDetails(Set<String> duns ){ 
        List<Account> acctList = [Select Id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_DUNS_Number__c IN: duns];      
        return acctList;    
    }
    
    //---------------------------------------------------------------------------------------------
    //                             OAuth Security Token method
    //---------------------------------------------------------------------------------------------
    public static String getOAuthAccessToken(){
        
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        String strpost= getOAuthAccessTokenCreds(AL_ENVIRON);
//      String OAuthBaseEndPoint= getEndpointBaseOAuth(AL_ENVIRON);
//      String endPoint= OAuthBaseEndPoint+'?'+strpost;
//      req.setEndpoint(endPoint);
        req.setEndpoint(getEndpointBaseOAuth(AL_ENVIRON)); 
        req.setMethod(OAuth_METHOD);
        req.setTimeout(OAuth_TIMEOUT);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody(strpost);
        //Execute web service call here      
        HTTPResponse res = http.send(req);
        String strAuth='Bearer';
        OAuthResponse OAuthObj =(OAuthResponse)JSON.deserialize(res.getBody(),OAuthResponse.class);
        strAuth=strAuth+' '+ OAuthObj.access_token;
        System.debug('SOA Authorization Token:'+strAuth);
        return strAuth;
      }
      
    //---------------------------------------------------------------------------------------------
    //                             Get OAuth endpoint base url
    //---------------------------------------------------------------------------------------------
    public static String getEndpointBaseOAuth(String environ){

        if (environ=='Prod') {
            return OAuth_ENDPOINT_BASE_PROD;
        } else if (environ=='QA') {
            return OAuth_ENDPOINT_BASE_QA;
        } else if (environ=='Dev') {
            return OAuth_ENDPOINT_BASE_DEV;
        } else {
            return '';
        }
    }

    //---------------------------------------------------------------------------------------------
    //                            get oAuth client credentials
    //-----------------------------------------------------------------------------------------------
  
     private static String getOAuthAccessTokenCreds(String environ){
        
        String retCreds;

       //Dev
        String grant_typeDev ='grant_type=client_credentials';
        String client_idDev = 'client_id=GEOG_LUF_SMAX_CreateServiceOrder_Client';
        String client_secretDev = 'client_secret=76paB94DpMlJUaFZCcIBExDWQRJUmioTxeYTLpwD3r0m0GK4Lg2FSBrLDM7NwU1b';
        String scopeDev = 'scope=GEOG_LUF_SMAX_CreateServiceOrder_API';
        String strpostDev=grant_typeDev+'&'+client_idDev+'&'+client_secretDev+'&'+scopeDev; 

        //QA

        String grant_typeQA ='grant_type=client_credentials';
        String client_idQA = 'client_id=GEOG_LUF_SMAX_CreateServiceOrder_Client';
        String client_secretQA = 'client_secret=76paB94DpMlJUaFZCcIBExDWQRJUmioTxeYTLpwD3r0m0GK4Lg2FSBrLDM7NwU1b';
        String scopeQA = 'scope=GEOG_LUF_SMAX_CreateServiceOrder_API';
        String strpostQA=grant_typeQA +'&'+client_idQA +'&'+client_secretQA +'&'+scopeQA;

        //PROD

        String grant_typeProd ='grant_type=client_credentials';
        String client_idProd = 'client_id=GEOG_LUF_SMAX_CreateServiceOrder_Client';
//        String client_secretProd = 'client_secret=76paB94DpMlJUaFZCcIBExDWQRJUmioTxeYTLpwD3r0m0GK4Lg2FSBrLDM7NwU1b';
        String client_secretProd = 'client_secret=y1mFqhecggblF0wSHrXC5bXcwUXpTyzFGUgTreOPgFCqTdmstvXYsuT2bcYHf6ak';
        String scopeProd = 'scope=GEOG_LUF_SMAX_CreateServiceOrder_API';
        String strpostProd=grant_typeProd +'&'+client_idProd +'&'+client_secretProd+'&'+scopeProd; 


                                           
        if (environ=='Prod') {
            retCreds= strpostProd;
        } else if (environ=='QA') {
            retCreds= strpostQA;
        } else if (environ=='Dev') {
            retCreds= strpostDev;
        } else {
            retCreds='';
        }
        return retCreds;
    }

    //----------------------------------------------------------------------------------------//
    //                             Get SOA endpoint base url                                  //
    //----------------------------------------------------------------------------------------//
    public static String getEndpointBaseSOA(String environ){
        if (environ=='Prod') {
            return AL_ENDPOINT_BASE_PROD;
        } else if (environ=='QA') {
            return AL_ENDPOINT_BASE_QA;
        } else if (environ=='Dev') {
            return AL_ENDPOINT_BASE_DEV;
        } else {
            return '';
        }
    }
    
    //Querying Location Details using Location Name
    public List<SVMXC__Site__c> locDetails(Set<String> rigOrName,String flag,Set<String> strShipToAddress){
    List<SVMXC__Site__c> locList = new List<SVMXC__Site__c>();
        if(flag=='LocRigId'){
            locList = [Select Id,Name,GE_Rig_ID__c,GE_AL_Well__c,GE_OG_AL_Bill_to_Account_Number__c,GE_OG_AL_Ship_to_Account_Number__c from SVMXC__Site__c where GE_Rig_ID__c IN: rigOrName and GE_AL_Well__c=true and GE_OG_AL_Ship_to_Account_Number__c IN: strShipToAddress];
        }
        if(flag=='RigId'){
            //locList = [Select Id, Name,GE_Rig_ID__c,GE_AL_Well__c,GE_OG_AL_Bill_to_Account_Number__c,GE_OG_AL_Ship_to_Account_Number__c from SVMXC__Site__c where GE_Rig_ID__c IN: rigOrName and GE_AL_Well__c=true];
            locList = [Select Id,RecordType.Name, Name,GE_Rig_ID__c,GE_AL_Well__c,GE_OG_AL_Bill_to_Account_Number__c,GE_OG_AL_Ship_to_Account_Number__c from SVMXC__Site__c where GE_Rig_ID__c IN: rigOrName and GE_AL_Well__c=true and RecordType.Name=:WELL_LOCATION_RECORD_TYPE];
        }
        if(flag=='Name'){
            locList = [Select Id,Name,GE_Rig_ID__c,GE_AL_Well__c,GE_OG_AL_Bill_to_Account_Number__c,GE_OG_AL_Ship_to_Account_Number__c from SVMXC__Site__c where Name IN: rigOrName and GE_AL_Well__c=true and GE_OG_AL_Ship_to_Account_Number__c IN: strShipToAddress];
        }
        return locList; 
    } 
    
    //Querying Installed Product Details using Serial #    
    public List<SVMXC__Installed_Product__c> ipDetails(Set<String> serialNumbers, String buisnessUnit){ 
        String rectype ='';
        if(buisnessUnit=='AL'){
            rectype = 'GE OG D&S Artificial Lift';
        }
        List<SVMXC__Installed_Product__c> ipList = [Select Id, Name,RecordType.Name,GE_AL_Equipment_Number__c,SVMXC__Serial_Lot_Number__c,GE_OG_DS_Part_Number__c,GE_HQ_SFDC_LEGACY_ID__c from SVMXC__Installed_Product__c where SVMXC__Serial_Lot_Number__c IN: serialNumbers and RecordType.Name=:rectype];
        return ipList;  
    }
    
    //Querying RecordType Id of objects
    public Id getRecTypeId(String obj, String recTypeName){
        Schema.DescribeSObjectResult des1;
        if(obj=='location'){
            des1 = Schema.SObjectType.SVMXC__Site__c;
        } 
        if(obj=='InstalledProduct'){
            des1 = Schema.SObjectType.SVMXC__Installed_Product__c;
        }   
        
        Map<String,Schema.RecordTypeInfo> rtMapByName1 = des1.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName1 =  rtMapByName1.get(recTypeName);
        Id recTypeId= rtByName1.getRecordTypeId();
    
    return recTypeId;    
    }
    
    
    
    //Method to log  error,exception,sync data etc...
    public static void insertLog(string logType,string logDescription,datetime logDate,String recName, String objectName)
    {        
       //logtype:1.SYNC 2.ERROR 3.EXCEPTION 4.MAIL
       try {
            PCIntegrationLog__c objLog=new PCIntegrationLog__c ();
            objLog.LogType__c=logType;
            objLog.LogDescription__c=logDescription;
            objLog.LogDate__c=logDate;
            if(objectName=='Location'){
                objLog.Location_Name__c=recName;
            }
            if(objectName=='InstalledProduct'){
                objLog.Installed_Product_Name__c=recName;       
            }
            if(objectName=='WorkOrder'){
                objLog.Work_Order_Name__c=recName;
            }
            insert objLog;
       } 
       catch (Exception ex) {
           system.debug('exception while logging..'+ex.getLineNumber()+'---'+ex.getMessage()+'---'+ex.getStackTraceString()+'---'+ex.getTypeName());
       }
    }
    
    
 
    public static void notifyInboundIP(List<GE_OG_SAP_InboundIntegration.IP_Info> failIP, String logDescription){
    String emailbody;
    if(failIP.size() >0 ){            
             emailbody=GE_OG_SAP_IntegrationUtility.getEmailBodyInbFailure(failIP);
             GE_OG_SAP_IntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(), GE_OG_SAP_IntegrationUtility.EMAIL_DISPLAY_NAME, GE_OG_SAP_IntegrationUtility.EMAIL_INB_IP_FAIL_SUBJECT+' : ', emailbody);
             for(GE_OG_SAP_InboundIntegration.IP_Info ips:failIP){
             GE_OG_SAP_IntegrationUtility.insertLog('IN_EXCEPTION',logDescription,system.now(),ips.InstalledProductId,'InstalledProduct');        
             }
        }
    }
    public static string getEmailBodyInbFailure(List<GE_OG_SAP_InboundIntegration.IP_Info> failIP)
    {
                   
        String templateheader;
        String templatebody;
        String templatefooter;
        String emailbody;
        
        templateheader='<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.0 Transitional//EN><HTML><HEAD><TITLE> New Document </TITLE>';
        templateheader=Templateheader + '<META NAME="Author" CONTENT=""><META NAME="Keywords" CONTENT=""><META NAME="Description" CONTENT=""></HEAD><BODY>';
        
       
            templatebody='<br>Dear All</br><br>Sub:  Service Max - Error.</br><br>';
            templatebody=templatebody+'There was an error while insertion/updation of Installed Product from SAP to SMAX.</br>';
            templatebody=templatebody+'<br>The following record/s failed for location creation because of Invalid/Duplicate Data – </br>';
            templatebody= templatebody+'<table border=1><tr><td><b>InstalledProductName</b></td><td><b>GE RIG</b></td><td><b>Serial #</b></td><td><b>Part #</b></td><td><b>Error</b></td></tr>';
            
            for(GE_OG_SAP_InboundIntegration.IP_Info ips: failIP){
            templatebody= templatebody+'<tr><td>'+ips.InstalledProductId+'</td>';
            templatebody= templatebody+'<td>'+ips.GeRigId+'</td>';
            templatebody= templatebody+'<td>'+ips.Serial+'</td>';
            templatebody= templatebody+'<td>'+ips.PartNumber+'</td>';
            templatebody= templatebody+'<td>'+ips.ErrorMsg+'</td></tr>';       
            }
            templatebody= templatebody+'</table><br></br>';
        
        
        templatebody= templatebody+'<br>For further information/clarification please contact </br>';
        templatebody= templatebody+'<br>SAP Administrator : </br>';
        templatefooter='</BODY></HTML>';
        Emailbody= templateheader+templatebody+templatefooter;
        return emailbody;
      
    } 
    
    public static void notifyInboundLocation(List<GE_OG_SAP_InboundIntegration.Location_Info> failLoc, String logDescription){
        String emailbody;
        
        if(failLoc.size() >0){            
             emailbody=GE_OG_SAP_IntegrationUtility.getEmailBodyInbFailure(failLoc);
             GE_OG_SAP_IntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(), GE_OG_SAP_IntegrationUtility.EMAIL_DISPLAY_NAME, GE_OG_SAP_IntegrationUtility.EMAIL_INB_LOCATION_FAIL_SUBJECT+' : ', emailbody);
             for(GE_OG_SAP_InboundIntegration.Location_Info loc:failLoc){
             GE_OG_SAP_IntegrationUtility.insertLog('IN_EXCEPTION',logDescription,system.now(),loc.LocName,'Location');        
             }
        }
    } 
    
    public static string getEmailBodyInbFailure(List<GE_OG_SAP_InboundIntegration.Location_Info> failLoc)
    {
                   
        String templateheader;
        String templatebody;
        String templatefooter;
        String emailbody;
        
        templateheader='<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.0 Transitional//EN><HTML><HEAD><TITLE> New Document </TITLE>';
        templateheader=Templateheader + '<META NAME="Author" CONTENT=""><META NAME="Keywords" CONTENT=""><META NAME="Description" CONTENT=""></HEAD><BODY>';
        
        
            templatebody='<br>Dear All</br><br>Sub:  Service Max - Error.</br><br>';
            templatebody=templatebody+'There was an error while insertion/updation of Location from SAP to SMAX.</br>';
            templatebody=templatebody+'<br>The following record/s failed for location creation because of Invalid/Duplicate Data – </br>';
            templatebody= templatebody+'<table border=1><tr><td><b>LocationName</b></td><td><b>Bill To Number</b></td><td><b>Ship To Address</b></td><td><b>Error</b></td></tr>';
            
            for(GE_OG_SAP_InboundIntegration.Location_Info loc : failLoc){
            templatebody= templatebody+'<tr><td>'+loc.LocName+'</td>';
            templatebody= templatebody+'<td>'+loc.BillToNumber+'</td>';
            templatebody= templatebody+'<td>'+loc.ShipToAddress+'</td>';
            templatebody= templatebody+'<td>'+loc.ErrorMsg+'</td></tr>';       
            }
            templatebody= templatebody+'</table><br></br>';
        
        
        templatebody= templatebody+'<br>For further information/clarification please contact </br>';
        templatebody= templatebody+'<br>SAP Administrator : </br>';
        templatefooter='</BODY></HTML>';
        Emailbody= templateheader+templatebody+templatefooter;
        return emailbody;
      
    }

    public static string getEmailBodyOutFailure(SVMXC__Service_Order__c objWO){
        String templateheader;
        String templatebody;
        String templatefooter;
        String emailbody;
    
        templateheader='<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.0 Transitional//EN><HTML><HEAD><TITLE> New Document </TITLE>';
        templateheader=templateheader + '<META NAME="Author" CONTENT=""><META NAME="Keywords" CONTENT=""><META NAME="Description" CONTENT=""></HEAD><BODY>';
        templatebody= '<br>Dear All</br><br>Sub:  Service Max - Connection Error.</br><br>';
        templatebody= templatebody+'There was an error while establishing connection with middleware and the data could not be published.</br>';
        templatebody= templatebody+'<br>The following record/s failed to be published:– </br>';
        templatebody= templatebody+'<br><b>Work Order#  :'+ objwo.Name +'</b></br>';
        templatebody= templatebody+'<br>For further information/clarification please contact </br>';
        templatebody= templatebody+'<br>SOA Administrator : </br>';
        templatebody= templatebody+'<br>SOA Server Name: </br>';
        templatefooter='</BODY></HTML>';
        emailbody= templateheader+templatebody+templatefooter;
        return emailbody;
    }

    public static string getEmailBodySAPResponse(String SMAX_OrderID, String Status, String ErrorMsg){
        String templateheader;
        String templatebody;
        String templatefooter;
        String emailbody;

        templateheader='<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.0 Transitional//EN><HTML><HEAD><TITLE> New Document </TITLE>';
        templateheader=templateheader + '<META NAME="Author" CONTENT=""><META NAME="Keywords" CONTENT=""><META NAME="Description" CONTENT=""></HEAD><BODY>';
        if(Status=='S')
        {
            templatebody= '<br>Dear All</br><br>Sub:  Service Max - Data Publish Success.</br><br>';
            templatebody= templatebody+'The Work Order data sent to SAP was successfully published.</br>';
            templatebody= templatebody+'<br>The following record/s got published:– </br>';
            templatebody= templatebody+'<br><b>Work Order#  :'+ SMAX_OrderID +'</b></br>';
            templatebody= templatebody+'<br>For further information/clarification please contact </br>';
            templatebody= templatebody+'<br>SOA Administrator: </br>';
            templatebody= templatebody+'<br>SOA Server Name: </br>';
        }
        else
        {
            templatebody= '<br>Dear All</br><br>Sub:  Service Max - Data Publish Error.</br><br>';
            templatebody= templatebody+'There was an error while publishing Work Order data to SAP and the data could not be published.</br>';
            templatebody= templatebody+'<br>The Error says: "'+ErrorMsg+'"</br>';
            templatebody= templatebody+'<br>The following record/s failed to be published:– </br>';
            templatebody= templatebody+'<br><b>Work Order#  :'+ SMAX_OrderID +'</b></br>';
            templatebody= templatebody+'<br>For further information/clarification please contact </br>';
            templatebody= templatebody+'<br>SOA Administrator: </br>';
            templatebody= templatebody+'<br>SOA Server Name: </br>';
        }
        templatefooter='</BODY></HTML>';
        emailbody= templateheader+templatebody+templatefooter;
        return emailbody;
    }

    public static void sendTemplatedEmail(Id userid,string displayname,string subject,string body)
    {
      
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setTargetObjectId(userid);
        email.setSenderDisplayName(displayname);
        email.setSubject(subject);
        email.setBccSender(false);
        email.setUseSignature(false);
        email.setHtmlBody(body);
        email.setSaveAsActivity(false);
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
        catch (Exception ex) {
           system.debug('exception while sending mail..'+ex.getLineNumber()+'---'+ex.getMessage()+'---'+ex.getStackTraceString()+'---'+ex.getTypeName());
        } 
    }
    
    
}