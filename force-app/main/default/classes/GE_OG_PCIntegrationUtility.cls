/*
Class Name: GE_OG_PCIntegrationUtility
Used For : Sending emails,logging error and defining re-usable methods
Purpose/Overview : Apex classes built has part of ServiceMax integration with Oracle suite.
Author: IGATE INTEGRATION TEAM
Created Date: 24th Sept 2014
Test Class Name : Test_GE_OG_PCIntegrationChange 
Requirement : R-19230, R-19236
History    : 
S No.    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/

public class GE_OG_PCIntegrationUtility{          
    //Constructor
    public GE_OG_PCIntegrationUtility() {
    }
    //DMZ
    public class DMZResponse{
        String token_type;
        String expires_in;
        String access_token;
    }
    
    public class ValidationResult{
        public String result;
        public String errorMsg;
    }
    
    //variable declaration for PC Integration
    public static final integer PC_SOA_TIMEOUT = 45000;  
    public static final String LOG_DESCRIPTION='Data is Synced to Fusion Middleware for Work Order Number ID.'; 
    public static final String CASE_LOG_DESCRIPTION='Data is Synced to Fusion Middleware for Case Number ID.'; 
    public static final String LOG_PAYLOAD_ERR='Data Validation Error for Account Payload'; 
    public static final String SFM_SUCCESS_MSG='Work Order Successfully published to Oracle.'; 
    public static final String SFM_ERROR_MSG='Error in publishing work order to Oracle. Detailed description of the error will be sent on your registered email.'; 
    public static final String WO_STATUS_OUTBOUND='Sent to Oracle'; 
    public static final String WO_STATUS_INBOUND='Closed'; 
    public static final String INBOUND_ERROR_MSG='SalesOrder/Invoice details cannot be updated in ServiceMax.'; 
    public static final String INBOUND_EXE_MSG='Error while updating records details to ServiceMax.'; 
    public static final String SVMX_LINESTATUS_CANCELED='Canceled';
    public static final String SVMX_LINESTATUS_ORACLE='Sent to Oracle';
    public static final String PC_PRICEBOOK_NAME='PC US LIST PRICE';   //PriceBook Name for PC
    public static final String DS_WO_OUTBOUND_STATUS='Billing in Progress';//new status for DS integration - R-24690  
    public static final String INBOUND_WD_ERROR_MSG='Error while updating Work detail lines in ServiceMax'; //New status when error in Work detail lines- R-24690
    public static final String INBOUND_CASE_ERROR_MSG='Error while updating Case lines in ServiceMax'; //New status when error in Work detail lines- R-24912
    
    
    
    //DMZ Configurations
    private static final integer DMZ_TIMEOUT=90000; 
    private static final String DMZ_METHOD='POST'; 
    
    //Email Configuration
    public static final String EMAIL_DISPLAY_NAME ='PC INTEGRATION TO ORACLE'; 
    public static final String EMAIL_OUT_SUBJECT = 'Error in publishing work order to Oracle'; 
    public static final String EMAIL_INB_SUBJECT = 'Error in updating SO/Invoice details to SMax'; 
    public static final String SMAXADMIN  = 'GE Servicemax Admin';
    public static final String SOAADMIN = 'erpdba@np.ge.com';
    public static final String SOASERVER = 'Oracle fusion';
    public static final String SMAXADMINMAIL = 'support@smax.com';
    
    //Other SOA constants
    public static final String  PC_ENVIRON = Label.GE_Integration_Environment;   
    
    //DMZ End points 
    private static  final  String  DMZ_ENDPOINT_BASE_DEV  = 'https://fssfed.stage.ge.com/fss/as/token.oauth2';    
    public  static  final  String  DMZ_ENDPOINT_BASE_QA   = 'https://fssfed.stage.ge.com/fss/as/token.oauth2'; 
    public  static  final  String  DMZ_ENDPOINT_BASE_PROD = 'https://fssfed.ge.com/fss/as/token.oauth2';  
    
    //SOA End constants     
    // private static final String PC_ENDPOINT_BASE_DEV =  'https://dev.api.ge.com/geoilgas/FieldServiceData/v1';
    //private static final String PC_ENDPOINT_BASE_DEV =  'https://dev.api.ge.com/oil/FieldServiceData/v1';
    private static final String PC_ENDPOINT_BASE_DEV = 'https://stage.api.ge.com/geoilgas/FieldServiceData/v1';
    
    private static final String PC_ENDPOINT_BASE_QA =   'https://stage.api.ge.com/geoilgas/FieldServiceData/v1';
    private static final String PC_ENDPOINT_BASE_PROD = 'https://api.ge.com:443/geoilgas/FieldServiceData/v1';
    
    
    //Method to log error,exception,sync data etc...
    public static void insertLog(string logType,string logDescription,datetime logDate ,ID woId)
    {        
        //logtype:1.SYNC 2.ERROR 3.EXCEPTION 4.MAIL
        try {
            PCIntegrationLog__c objLog=new PCIntegrationLog__c (); 
            objLog.LogType__c=logType;
            objLog.LogDescription__c=logDescription;
            objLog.LogDate__c=logDate;
            objLog.Work_Order_ID__c=woId;
            insert objLog;
        } 
        catch (Exception ex) {
            system.debug('exception while logging..'+ex.getLineNumber()+'---'+ex.getMessage()+'---'+ex.getStackTraceString()+'---'+ex.getTypeName());
        }
    }
    
    public static void insertcaseLog(string logType,string logDescription,datetime logDate ,ID csId)
    {        
        //logtype:1.SYNC 2.ERROR 3.EXCEPTION 4.MAIL
        try {
            
            PCIntegrationLog__c objLog=new PCIntegrationLog__c ();
            objLog.LogType__c=logType;
            objLog.LogDescription__c=logDescription;
            objLog.LogDate__c=logDate;           
            objLog.Case_ID__c=csId;            
            insert objLog;
        } 
        catch (Exception ex) {
            system.debug('exception while logging..'+ex.getLineNumber()+'---'+ex.getMessage()+'---'+ex.getStackTraceString()+'---'+ex.getTypeName());
        }
    }
    
    //method to get email body for outbound failure.
    public static string getEmailBodyOutFailure(SVMXC__Service_Order__c objWO)
    {
        
        String templateheader;
        String templatebody;
        String templatefooter;
        String emailbody;
        
        
        templateheader='<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.0 Transitional//EN><HTML><HEAD><TITLE> New Document </TITLE>';
        templateheader=Templateheader + '<META NAME="Author" CONTENT=""><META NAME="Keywords" CONTENT=""><META NAME="Description" CONTENT=""></HEAD><BODY>';
        templatebody='<br>Dear All</br>';        
        templatebody=templatebody+'<br>The following Work Order failed to Submit to Oracle. </br>';
        templatebody= templatebody+'<br><b>Work Order #:'+ objwo.Name +'</b></br>';
        templatebody= templatebody+'<br><b>Case #:'+ objwo.SVMXC__Case__r.CaseNumber +'</b></br>';
        templatebody= templatebody+'<br>For further information/clarification please contact: </br>';
        templatebody= templatebody+'<br>ServiceMax Team:  pc.servicemax.devops@ge.com </br>';
        templatebody= templatebody+'<br>Thanks,</br>';
        templatebody= templatebody+'<br>The Digital Oilfield Team</br>';
        templatefooter='</BODY></HTML>';
        Emailbody= templateheader+templatebody+templatefooter;
        return emailbody;
        
    }  
    
    //method to get email body for Inound failure.
    public static string getEmailBodyInbFailure(SVMXC__Service_Order__c objWO)
    {
        
        String templateheader;
        String templatebody;
        String templatefooter;
        String emailbody;
        
        templateheader='<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.0 Transitional//EN><HTML><HEAD><TITLE> New Document </TITLE>';
        templateheader=Templateheader + '<META NAME="Author" CONTENT=""><META NAME="Keywords" CONTENT=""><META NAME="Description" CONTENT=""></HEAD><BODY>';
        templatebody='<br>Dear All</br>';        
        templatebody=templatebody+'<br>The following Work Order failed to Submit to Oracle. </br>';
        templatebody= templatebody+'<br><b>Work Order #:'+ objwo.Name +'</b></br>';
        templatebody= templatebody+'<br><b>Case #:'+ objwo.SVMXC__Case__r.CaseNumber +'</b></br>';
        templatebody= templatebody+'<br>For further information/clarification please contact: </br>';
        templatebody= templatebody+'<br>ServiceMax Team:  pc.servicemax.devops@ge.com </br>';
        templatebody= templatebody+'<br>Thanks,</br>';
        templatebody= templatebody+'<br>The Digital Oilfield Team</br>';
        templatefooter='</BODY></HTML>';
        Emailbody= templateheader+templatebody+templatefooter;
        return emailbody;
        
    }  
    
    public static string getEmailBodyInbFailure(SVMXC__Service_Order_Line__c objWD)
    {
        
        String templateheader;
        String templatebody;
        String templatefooter;
        String emailbody;
        
        templateheader='<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.0 Transitional//EN><HTML><HEAD><TITLE> New Document </TITLE>';
        templateheader=Templateheader + '<META NAME="Author" CONTENT=""><META NAME="Keywords" CONTENT=""><META NAME="Description" CONTENT=""></HEAD><BODY>';
        templatebody='<br>Dear All</br><br>Sub:  Service Max - Connection Error.</br><br>';
        templatebody=templatebody+'There was an error while establishing connection with middleware and the SO/Invoice details failed to update in SMax.</br>';
        templatebody=templatebody+'<br>The following record/s failed to be updated – </br>';
        templatebody= templatebody+'<br><b>Work Detail #  :'+ objWD.Name +'</b></br>';
        templatebody=templatebody+'<br> Work Order # – </br>'+objWD.SVMXC__Service_Order__r.Name+'<b></br>';
        templatebody= templatebody+'<br><b>Case #  :'+ objWD.SVMXC__Service_Order__r.SVMXC__Case__r.CaseNumber +'</b></br>';
        templatebody= templatebody+'<br>For further information/clarification please contact </br>';
        templatebody= templatebody+'<br>SOA Administrator : '+ SOAADMIN +'</br>';
        templatebody= templatebody+'<br>SOA Server Name: '+ SOASERVER +'</br>';
        templatefooter='</BODY></HTML>';
        Emailbody= templateheader+templatebody+templatefooter;
        return emailbody;
        
    }
    //Sending single  email method
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
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    // Update Work Order status (WO Number , Status)
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    public static void updateWOStatus(List<ID> woIds,String status){ 
        // Bug# 0000023943 Below code on Attachment added to store Id of the attachment on WorkOrder sent to ERP 
        String FsoTypeAttach=''; 
        String FsoNameAttach=''; 
        for(Id tempWoId:woIds){
            FsoTypeAttach='%'+tempWoId+'%'; 
        }    
        if(woIDs.size()>0){
            // in below Query added RecordType.Name as part of R-23728
            List<SVMXC__Service_Order__c> updateWO = [SELECT Id,Name,RecordType.Name, SVMXC__Order_Status__c,GE_OG_Attachment_Id__c FROM SVMXC__Service_Order__c WHERE id IN :woIDs];
            FsoNameAttach='%'+updateWO[0].Name+'%';
            List<Attachment> fsoattach=[SELECT Id,Name FROM Attachment WHERE ParentId=:woIDs AND (Name LIKE :FsoTypeAttach OR Name LIKE :FsoNameAttach)Order By CreatedDate DESC Limit 1];
            if(updateWO!=null){
                for(SVMXC__Service_Order__c record:updateWO){ 
                    //Added the below if as part of R-23728                  
                    if(record.RecordType.Name!='SS-Mobilize'){
                        record.SVMXC__Order_Status__c = status;}
                    if(fsoattach.size()>0){
                        record.GE_OG_Attachment_Id__c =  fsoattach[0].Id;
                    }
                }
                update updateWO;
            }
        }
    }
    //---------------------------------------------------------------------------------------------
    //                             Get SOA endpoint base url
    //-----------------------------------------------------------------------------------------------
    public static String getEndpointBaseSOA(String environ){
        if (environ=='Prod') {
            return PC_ENDPOINT_BASE_PROD;
        } else if (environ=='QA') {
            return PC_ENDPOINT_BASE_QA;
        } else if (environ=='Dev') {
            return PC_ENDPOINT_BASE_DEV;
        } else {
            return '';
        }
    }
    
    //---------------------------------------------------------------------------------------------
    //                             Get DMZ endpoint base url
    //-----------------------------------------------------------------------------------------------
    public static String getEndpointBaseDMZ(String environ){
        if (environ=='Prod') {
            return DMZ_ENDPOINT_BASE_PROD;
        } else if (environ=='QA') {
            return DMZ_ENDPOINT_BASE_QA;
        } else if (environ=='Dev') {
            return DMZ_ENDPOINT_BASE_DEV;
        } else {
            return '';
        }
    }
    
    //---------------------------------------------------------------------------------------------
    //                             OAuth Security Tokem method
    //-----------------------------------------------------------------------------------------------
    public static String getDMZAccessToken(){
        String strAuth='Bearer';
        try{
            HttpRequest req = new HttpRequest();
            Http http = new Http();
            String strpost= getDMZAccessTokenCreds(PC_ENVIRON);
            
            req.setEndpoint(getEndpointBaseDMZ(PC_ENVIRON)); 
            req.setMethod(DMZ_METHOD);
            req.setTimeout(DMZ_TIMEOUT);
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            req.setBody(strpost);
            //Execute web service call here      
            HTTPResponse res = http.send(req);
            System.debug('Access Token returned---> '+res);
            
            DMZResponse dmzObj =(DMZResponse)JSON.deserialize(res.getBody(),DMZResponse.class);
            strAuth=strAuth+' '+ dmzObj.access_token;
            System.debug('SOA Authorization Token:'+strAuth);
        }
        Catch(CalloutException e){
            
        }
        Catch(Exception ex){
            
        }
        return strAuth;
    } 
    
    //---------------------------------------------------------------------------------------------
    //                            Validate WO Publish
    //-----------------------------------------------------------------------------------------------
    ////Bug#: 0000024077 Added parameter workOrder Id in the below method
    public static ValidationResult  validateWOPayload(GE_OG_PCWOPublish.Account_element account_x,Id woID){
        ValidationResult res = new ValidationResult();
        String reqFields='PASS';
        String validationErrorMsg='Data empty.Please fill in the details before publishing it to the ORACLE :';
        
        List<GE_OG_PCWOPublish.WorkDetail_element> payloadwd_x = new List<GE_OG_PCWOPublish.WorkDetail_element>();
        GE_OG_PCWOPublish.Product_element payloadProduct_x=new GE_OG_PCWOPublish.Product_element();
        GE_OG_PCWOPublish.Account_element payloadAcc_x=new GE_OG_PCWOPublish.Account_element();
        payloadAcc_X=account_x;
        //PO Number
        if(payloadAcc_X.Location[0].Case_x[0].PONumber==null){
            reqFields='FAIL';
            //validationErrorMsg= validationErrorMsg + '\n PO# is empty in Case:' +payloadAcc_X.Location[0].Case_x[0].CaseNumber +';' +'\n';
            validationErrorMsg= validationErrorMsg + '\n PO# is missing in Workorder/Case. Please enter the PO# and Try again ' +';' +'\n';
        }
        /*  Commented as part of   R-29297
//Added as part of   R-23728
if((payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].Branch!='MCR(C22)')&&(payloadAcc_X.Location[0].Case_x[0].RecordTypeId=='SS-Mobilize')){
reqFields='FAIL';                
validationErrorMsg= validationErrorMsg + '\n Please select Branch as MCR(C22) to Submit to Oracle ' +';' +'\n';
} //End*/
        
        //Added as a part of R-24690
        if((payloadAcc_X.Location[0].Case_x[0].Region==null) && (payloadAcc_X.Location[0].Case_x[0].RecordTypeId=='FS-D&S') ){
            reqFields='FAIL';
            //validationErrorMsg= validationErrorMsg + '\n D&S Region is empty in Case:' +payloadAcc_X.Location[0].Case_x[0].CaseNumber +';' +'\n';
            validationErrorMsg= validationErrorMsg + '\n D&S Region is missing in Case. Please enter the D&S Region and Try again ' +';' +'\n';
            
        }
        //End part of R-24690
        // Added as part of R-24912
        if((payloadAcc_x.Location[0].Case_x[0].ProjectName==null) && (payloadAcc_X.Location[0].Case_x[0].RecordTypeId=='FS-D&S')){
            System.debug('---------CAse Billing Type value is '+payloadAcc_X.Location[0].Case_x[0].BillingType);
            //if((payloadAcc_X.Location[0].Case_x[0].BillingType!='Commissioning') || (payloadAcc_X.Location[0].Case_x[0].BillingType!='Cost Transfer') || (payloadAcc_X.Location[0].Case_x[0].BillingType!='Non Billable')){
            //if((payloadAcc_X.Location[0].Case_x[0]..WorkOrder[0].OrderType=='Recertifications') || (payloadAcc_X.Location[0].Case_x[0]..WorkOrder[0].BillingType=='Service Agreement') || (payloadAcc_X.Location[0].Case_x[0]..WorkOrder[0].BillingType=='T&M (Transactional)')|| (payloadAcc_X.Location[0].Case_x[0]..WorkOrder[0].BillingType=='Upgrades')){   
            if(payloadAcc_X.Location[0].Case_x[0].WorkOrder[0].OrderType=='Services'){  
                reqFields='FAIL';
                validationErrorMsg= validationErrorMsg + '\n Project Number is missing in Case. Please generate ProjectNumber and Try again ' +';' +'\n';
            }
        }//END R-24912
        //Bug# 0000023944 Below line commented to put validation for only ShipToDunsNumber 
        // if((payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].ShipToDunsNumber==null) && (shipToAdd==null) ){
        if((payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].ShipToDunsNumber==null)){
            reqFields='FAIL';
            //validationErrorMsg= validationErrorMsg + '\n Either ShipToAccount DUNS /ShipToAddress is mandatory in Work Order:' +payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].WorkOrderNumber +';' +'\n';
            validationErrorMsg= validationErrorMsg + '\n Ship – To missing. Enter ShipTo DUNS or ShipTo Address in Workorder and Try again ' +';' +'\n';
        } 
        
        //Ship To DUNS 
        String shipToAdd=null;
        String street=payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].ShipToAddress.Street;
        String city=payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].ShipToAddress.City;
        String state=payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].ShipToAddress.State;
        String zip=payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].ShipToAddress.Zip;
        String country=payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].ShipToAddress.Country;
        String phNum=payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].ShipToAddress.PhoneNumber;
        
        If(street!=null){
            shipToAdd=street;
        }
        If(city!=null){
            shipToAdd=shipToAdd+city;
        }
        If(state!=null){
            shipToAdd=shipToAdd+state;
        }
        If(zip!=null){
            shipToAdd=shipToAdd+zip;
        }
        If(country!=null){
            shipToAdd=shipToAdd+country;
        }
        If(phNum!=null){
            shipToAdd=country+phNum;
        }
        
        payloadwd_x=payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].WorkDetail;
        
        if(payloadwd_x.size()>0)
        {
            for(GE_OG_PCWOPublish.WorkDetail_element wd : payloadwd_x){
                payloadProduct_x=wd.Product;                    
                
                //Added as a part of R-24690
                if(payloadProduct_x==null){
                    reqFields='FAIL';
                    validationErrorMsg= validationErrorMsg + '\n Part# added in work Order line#'+wd.LineNumber+ ' has a missing Product Code. Please add the correct product (NOTE : Contact Administrator if the part # is not available)'  +'\n';
                }
                //End part of R-24690                    
                
                if(payloadAcc_X.Location[0].Case_x[0].RecordTypeId=='FS-D&S'){
                    
                    if(payloadAcc_X.Location[0].Case_x[0].WorkOrder[0].OrderType== 'Services'){
                        String pricevalue = wd.LinePricePerUnit;
                        System.debug('MFL extended price -----'+ wd.LinePricePerUnit + 'Price values ' +pricevalue +'------after cutt value '+pricevalue.substringAfter(' ') );
                        if((pricevalue == null) || ((pricevalue.substringAfter(' ')).equals('0.00') || (pricevalue.equals('')))){
                            reqFields='FAIL';
                            validationErrorMsg = validationErrorMsg + '\n MFL Extended Price unit  in work Order line#'+wd.LineNumber+ ' is missing. Please add Line Price'  +'\n';
                        }
                    }
                    
                }           
                
            }   
            
        }
        
        if(payloadwd_x.size()==0){
            reqFields='FAIL';
            //validationErrorMsg= validationErrorMsg + '\n Either ShipToAccount DUNS /ShipToAddress is mandatory in Work Order:' +payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].WorkOrderNumber +';' +'\n';
            validationErrorMsg= validationErrorMsg + '\n  Work detail Line Items are missing. Please Enter work detail lines in Workorder and Try again ' +';' +'\n';
        }
        //End of R-24690
        
        //Bug#: 0000024077 Added below Attachment validation
        //Attachment on WorkOrder
        String FsoTypeAttach='%'+woID+'%'; 
        String FsoNameAttach='%'+payloadAcc_x.Location[0].Case_x[0].WorkOrder[0].WorkOrderNumber+'%'; 
        List<Attachment> att = [Select Id, Name from Attachment where ParentId =:woID AND (Name LIKE :FsoTypeAttach OR Name LIKE :FsoNameAttach) Order By CreatedDate DESC Limit 1];
        
        if(att.size()<1)
        {
            reqFields='FAIL';
            validationErrorMsg='\nFSO attachment missing. Attach system generated ticket or scanned signed ticket in WO-XXXXXXXX format.'+'\n';              
        }
        
        
        res.result=reqFields;
        res.errorMsg=validationErrorMsg;
        return res;
    }
    
    
    
    //---------------------------------------------------------------------------------------------
    //                             Send Inbound failure mail
    //-----------------------------------------------------------------------------------------------
    public static void notifyInboundFailure(List<SVMXC__Service_Order__c> lstExWO, String logDescription){
        String emailbody;
        if(lstExWO.size() >0)
        {
            for(SVMXC__Service_Order__c objExWO : lstExWO) {
                emailbody=GE_OG_PCIntegrationUtility.getEmailBodyInbFailure(objExWO);                
                
                // Id billAdminId = objExWO.SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin__r.id;
                // Bug# 0000024075: commented above line and modified as below                
                Id billAdminId = objExWO.GE_DS_Billing_Region__r.GE_OG_DS_Billing_Admin__r.id;
                System.debug('billAdminId:'+billAdminId);
                if(billAdminId!=null){
                    GE_OG_PCIntegrationUtility.sendTemplatedEmail(billAdminId, GE_OG_PCIntegrationUtility.EMAIL_DISPLAY_NAME, GE_OG_PCIntegrationUtility.EMAIL_INB_SUBJECT+' : '+objExWO.Name, emailbody);
                }
                GE_OG_PCIntegrationUtility.insertLog('IN_EXCEPTION',logDescription,system.now(),objExWO.id);             
            }
        }
    }
    public static void notifyInboundFailureWD(List<SVMXC__Service_Order_Line__c> lstExWD, String logDescription){
        String emailbody;
        if(lstExWD.size() >0)
        {
            for(SVMXC__Service_Order_Line__c objExWD : lstExWD) {
                emailbody=GE_OG_PCIntegrationUtility.getEmailBodyInbFailure(objExWD);
                Id billAdminId = objExWD.SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin__r.id;
                System.debug('billAdminId:'+billAdminId);
                if(billAdminId!=null){
                    GE_OG_PCIntegrationUtility.sendTemplatedEmail(billAdminId, GE_OG_PCIntegrationUtility.EMAIL_DISPLAY_NAME, GE_OG_PCIntegrationUtility.EMAIL_INB_SUBJECT+' : '+objExWD.Name, emailbody);
                }
                GE_OG_PCIntegrationUtility.insertLog('IN_EXCEPTION',logDescription,system.now(),objExWD.id);             
            }
        }
    }   
    
    //---------------------------------------------------------------------------------------------
    //                            get oAuth client credentials
    //-----------------------------------------------------------------------------------------------
    
    private static String getDMZAccessTokenCreds(String environ){
        
        String retCreds;
        
        
        //Dev
        String grant_typeDev ='grant_type=client_credentials';
        String client_idDev = 'client_id=GEOG_SMAX_ORACLE_FIELDSERVICEDATA_Client';
        String client_secretDev = 'client_secret=ik91df97gP4j51XtCQEwRqNF7kVcP8AnppAcR7a';
        String scopeDev = 'scope=GEOG_SMAX_ORACLE_FIELDSERVICEDATA_API';
        String strpostDev=grant_typeDev+'&'+client_idDev+'&'+client_secretDev+'&'+scopeDev; 
        
        //QA
        
        String grant_typeQA ='grant_type=client_credentials';
        String client_idQA = 'client_id=GEOG_SMAX_ORACLE_FIELDSERVICEDATA_Client';
        String client_secretQA = 'client_secret=ik91df97gP4j51XtCQEwRqNF7kVcP8AnppAcR7a';
        String scopeQA = 'scope=GEOG_SMAX_ORACLE_FIELDSERVICEDATA_API';
        String strpostQA=grant_typeQA +'&'+client_idQA +'&'+client_secretQA +'&'+scopeQA; 
        
        //PROD
        
        String grant_typeProd ='grant_type=client_credentials';
        String client_idProd = 'client_id=GEOG_SMAX_ORACLE_FIELDSERVICEDATA_Client';
        String client_secretProd = 'client_secret=ik91df97gP4j51XtCQEwRqNF7kVcP8AnppAcR7a';
        String scopeProd = 'scope=GEOG_SMAX_ORACLE_FIELDSERVICEDATA_API';
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
    //Added as a part of R-24912
    //Method to send Email notification for Case oubound Failure
    public static string getCaseEmailBodyOutFailure(Case caseObj)
    {
        
        String templateheader;
        String templatebody;
        String templatefooter;
        String emailbody;
        
        
        templateheader='<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.0 Transitional//EN><HTML><HEAD><TITLE> New Document </TITLE>';
        templateheader=Templateheader + '<META NAME="Author" CONTENT=""><META NAME="Keywords" CONTENT=""><META NAME="Description" CONTENT=""></HEAD><BODY>';
        templatebody='<br>Dear All</br><br>Sub:  Service Max - Connection Error.</br><br>';
        templatebody=templatebody+'There was an error while establishing connection with middleware and the data could not be published.</br>';
        templatebody=templatebody+'<br>The following record/s failed to be published – </br>';
        templatebody= templatebody+'<br><b>Case #  :'+ caseObj.CaseNumber +'</b></br>';
        templatebody= templatebody+'<br>For further information/clarification please contact </br>';
        templatebody= templatebody+'<br>SOA Administrator : '+ SOAADMIN +'</br>';
        templatebody= templatebody+'<br>SOA Server Name: '+ SOASERVER +'</br>';
        templatefooter='</BODY></HTML>';
        Emailbody= templateheader+templatebody+templatefooter;
        return emailbody;
        
    }  
    
    //method to get email body for Inound failure for Case.
    public static string getCaseEmailBodyInbFailure(Case caseObj)
    {
        
        String templateheader;
        String templatebody;
        String templatefooter;
        String emailbody;
        
        templateheader='<!DOCTYPE HTML PUBLIC -//W3C//DTD HTML 4.0 Transitional//EN><HTML><HEAD><TITLE> New Document </TITLE>';
        templateheader=Templateheader + '<META NAME="Author" CONTENT=""><META NAME="Keywords" CONTENT=""><META NAME="Description" CONTENT=""></HEAD><BODY>';
        templatebody='<br>Dear All</br><br>Sub:  Service Max - Connection Error.</br><br>';
        templatebody=templatebody+'There was an error while establishing connection with middleware and the SO/Invoice details failed to update in SMax.</br>';
        templatebody=templatebody+'<br>The following record/s failed to be updated – </br>';
        templatebody= templatebody+'<br><b>Case #  :'+ caseObj.CaseNumber +'</b></br>';
        templatebody= templatebody+'<br>For further information/clarification please contact </br>';
        templatebody= templatebody+'<br>SOA Administrator : '+ SOAADMIN +'</br>';
        templatebody= templatebody+'<br>SOA Server Name: '+ SOASERVER +'</br>';
        templatefooter='</BODY></HTML>';
        Emailbody= templateheader+templatebody+templatefooter;
        return emailbody;
        
    } 
    
    public static void notifyCaseInboundFailure(List<Case> caseExpList, String logDescription){
        String emailbody;
        if(caseExpList.size() >0)
        {
            for(Case caseObj : caseExpList) {
                //emailbody=GE_OG_PCIntegrationUtility.getEmailBodyInbFailure(caseObj);
                // Have to be updated after whose sending Email is confirmed.               
                /**Id billAdminId = objExWD.SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin__r.id;
System.debug('billAdminId:'+billAdminId);
if(billAdminId!=null){
GE_OG_PCIntegrationUtility.sendTemplatedEmail(billAdminId, GE_OG_PCIntegrationUtility.EMAIL_DISPLAY_NAME, GE_OG_PCIntegrationUtility.EMAIL_INB_SUBJECT+' : '+caseObj.CaseNumber, emailbody);
}*/
                GE_OG_PCIntegrationUtility.insertLog('IN_EXCEPTION',logDescription,system.now(),caseObj.id);             
            }
        }
    }
    
    //End part of R-24912   
    
    
}