/*
Class Name: GE_OG_PCOutboundIntegration
Used Where: 
Purpose/Overview: Integration class to get DMZ token and invoke SOA web service method
Functional Area: 
Author: Amit Kumar
Created Date: 04-Oct-2014
Test Class Name:  Test_GE_OG_PCIntegration
Change History:
Date Modified: Developer Name: Section/Page Block Modified/Added: Purpose/Overview of Change
*/
global class GE_OG_PCOutboundIntegration{
    webservice static SVMXC.INTF_WebServicesDef.INTF_Response sfmSubmitToOracle(SVMXC.INTF_WebServicesDef.INTF_Response request)
    {     
        String recordId,logDescription;
        List<SVMXC__Service_Order__c> listWO;
        String woName,outboundResponse;
        for(SVMXC.INTF_WebServicesDef.SVMXMap objSVXMMap : request.valueMap){                                       // Iterate request's valueMap member to get Key-Value pairs
            if(objSVXMMap.key == 'WorkOrder_ID'){                                                                   // Work Order id from Default key and assign it to a local variable
                recordId = objSVXMMap.value; 
            }
        }
        
        GE_OG_OutboundAttachmentBatch woBatch= new GE_OG_OutboundAttachmentBatch(recordId); 
        database.executeBatch(woBatch); 
        
        SVMXC.INTF_WebServicesDef.INTF_Response obj = new SVMXC.INTF_WebServicesDef.INTF_Response();
        obj.message = GE_OG_PCIntegrationUtility.SFM_SUCCESS_MSG;
        obj.success = true;
        return obj;
        
        //response object declaration
        /*try{
System.debug('GE_OG_PCOutboundIntegration : Work Order ID: '+recordId);
//Invoking DMZ end point to retrieve access token.
String dmzResponse = GE_OG_PCIntegrationUtility.getDMZAccessToken();
//Invoke SOA endpoint
GE_OG_PCOutboundWrapper outInstance= new GE_OG_PCOutboundWrapper();
System.debug('The DMZ response is :' +dmzResponse);
outboundResponse=outInstance.submitToOracle(recordId,dmzResponse); 
System.debug('The outbound response is :' + outboundResponse);
if(outboundResponse=='Success'){
logDescription=GE_OG_PCIntegrationUtility.LOG_DESCRIPTION+ ':' + recordId;
GE_OG_PCIntegrationUtility.insertLog('SYNC',logDescription,system.now(),recordId);             
obj.message = GE_OG_PCIntegrationUtility.SFM_SUCCESS_MSG;
obj.success = true;
return obj;
}
else{
logDescription=GE_OG_PCIntegrationUtility.LOG_PAYLOAD_ERR+ ':' + recordId + ' --- ' +outboundResponse;
GE_OG_PCIntegrationUtility.insertLog('ERROR',logDescription,system.now(),recordId);             
obj.message=outboundResponse;
obj.success = false;
return obj;
}
}
catch(Exception ex){
SVMXC__Service_Order__c objWo = [SELECT id, Name, SVMXC__Case__r.CaseNumber from SVMXC__Service_Order__c WHERE id=:recordId LIMIT 1]; 
String emailbody=GE_OG_PCIntegrationUtility.getEmailBodyOutFailure(objWo);
GE_OG_PCIntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(), GE_OG_PCIntegrationUtility.EMAIL_DISPLAY_NAME, GE_OG_PCIntegrationUtility.EMAIL_OUT_SUBJECT+' : '+objWo.Name, emailbody);
logDescription='GE_OG_PCOutboundIntegration:' +ex.getLineNumber()+'---'+ex.getMessage()+'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
System.debug(logDescription);
GE_OG_PCIntegrationUtility.insertLog('EXCEPTION',logDescription,system.now(),recordId);
obj.message = GE_OG_PCIntegrationUtility.SFM_ERROR_MSG;                                                                               // Construct Failure response, Update response object members
obj.success = false;
return obj;          
}*/
    }
    webservice static SVMXC.INTF_WebServicesDef.INTF_Response sfmCaseToOracle(SVMXC.INTF_WebServicesDef.INTF_Response request){
        String recordId,recordType,logDescription;
        List<Case> listCase;
        String csName,outboundResponse;
        for(SVMXC.INTF_WebServicesDef.SVMXMap objSVXMMap : request.valueMap){                                       // Iterate request's valueMap member to get Key-Value pairs
            if(objSVXMMap.key == 'Case_ID'){                                                                   // Work Order id from Default key and assign it to a local variable
                recordId = objSVXMMap.value; 
            }
            //Added below if conditions as part of R-23728
            if(objSVXMMap.key == 'WorkOrder_ID'){
                recordId = objSVXMMap.value; 
            }
            if(objSVXMMap.key == 'RecordType_ID'){
                recordType = objSVXMMap.value;
            }
        }
        
        SVMXC.INTF_WebServicesDef.INTF_Response obj = new SVMXC.INTF_WebServicesDef.INTF_Response();                     //response object declaration
        try{
            System.debug('GE_OG_PCOutboundIntegration : Work Order ID: '+recordId);
            //Invoking DMZ end point to retrieve access token.
            String dmzResponse = GE_OG_PCIntegrationUtility.getDMZAccessToken();
            //Invoke SOA endpoint
            GE_OG_PCOutboundWrapper outInstance= new GE_OG_PCOutboundWrapper();
            System.debug('The DMZ response is :' +dmzResponse);
            //Commenting below Code as part of R-23728 inorder to differentiate the records
            //outboundResponse=outInstance.createProject(recordId,dmzResponse);
            if(!Test.isRunningTest())
                outboundResponse=outInstance.createProject(recordId,dmzResponse,recordType); 
            System.debug('The outbound response is :' + outboundResponse);
            if(outboundResponse=='Success'){             
                logDescription=GE_OG_PCIntegrationUtility.CASE_LOG_DESCRIPTION+ ':' + recordId; 
                //Added below if conditions as part of R-23728               
                if(recordType=='SS-Mobilize'){
                    GE_OG_PCIntegrationUtility.insertLog('SYNC',logDescription,system.now(),recordId);     
                }
                else{GE_OG_PCIntegrationUtility.insertcaseLog('SYNC',logDescription,system.now(),recordId); }          
                obj.message = 'Successfully Published for Project Creation';
                obj.success = true;
                return obj;
                
            }
            else{
                logDescription=GE_OG_PCIntegrationUtility.LOG_PAYLOAD_ERR+ ':' + recordId + ' --- ' +outboundResponse;
                //Added below if conditions as part of R-23728               
                if(recordType=='SS-Mobilize'){
                    GE_OG_PCIntegrationUtility.insertLog('ERROR',logDescription,system.now(),recordId);    
                }
                else{GE_OG_PCIntegrationUtility.insertcaseLog('ERROR',logDescription,system.now(),recordId);  }           
                obj.message=outboundResponse;
                obj.success = false;
                return obj;
            }
            
        }
        catch(Exception ex)
        {
            logDescription = 'GE_OG_PCOutboundIntegration:' +ex.getLineNumber()+'---'+ex.getMessage()+'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
            System.debug(logDescription);
            GE_OG_PCIntegrationUtility.insertcaseLog('EXCEPTION',logDescription,system.now(),recordId);
            return obj;
        }                
    }       
}