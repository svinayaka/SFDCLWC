global class GE_OG_SAP_OutboundIntegration{

    webservice static SVMXC.INTF_WebServicesDef.INTF_Response sfmSubmitToSAP(SVMXC.INTF_WebServicesDef.INTF_Response request){
        String recordId,logDescription;
        Integer counter=0;
        List<GE_OG_SAP_OutboundWrapper.Universal_Response> outboundResponseList = new List<GE_OG_SAP_OutboundWrapper.Universal_Response>();
        List <String> woIdList = new List <String>();

        for(SVMXC.INTF_WebServicesDef.SVMXMap objSVXMMap : request.valueMap){
            // Iterate request's valueMap member to get Key-Value pairs
            if(objSVXMMap.key == 'WorkOrder_ID'){
            // Assigning Work Order id (from Default key), to a local variable
                recordId = objSVXMMap.value;
                woIdList.add(recordId);
            }
        }

        SVMXC.INTF_WebServicesDef.INTF_Response obj = new SVMXC.INTF_WebServicesDef.INTF_Response();
        obj.message='';

        // Response object declaration //

        try{
            System.debug('GE_OG_SAP_OutboundIntegration : Work Order IDs: '+woIdList);
            //Invoking OAuth end point to retrieve access token
            String oAuthResponse = GE_OG_SAP_IntegrationUtility.getOAuthAccessToken();
            //Invoke SOA endpoint
            GE_OG_SAP_OutboundWrapper outInstance= new GE_OG_SAP_OutboundWrapper();
            outboundResponseList = outInstance.submitToSAP(woIdList,oAuthResponse);
            for (GE_OG_SAP_OutboundWrapper.Universal_Response outboundResponse:outboundResponseList){
                counter=counter+1;
                if(outboundResponse.Status=='S'){
                    logDescription=GE_OG_SAP_IntegrationUtility.LOG_DESCRIPTION+ ':' + outboundResponse.SMAX_OrderID;
                    System.debug('Log Description --> '+logDescription);
                    GE_OG_SAP_IntegrationUtility.insertLog('SYNCHED',logDescription,system.now(),outboundResponse.SMAX_OrderID, 'WorkOrder');
                    String emailbody = GE_OG_SAP_IntegrationUtility.getEmailBodySAPResponse(outboundResponse.SMAX_OrderID, outboundResponse.Status, outboundResponse.ErrorMsg);
                    GE_OG_SAP_IntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(), GE_OG_SAP_IntegrationUtility.EMAIL_DISPLAY_NAME, GE_OG_SAP_IntegrationUtility.EMAIL_OUT_WO_SUCCESS_SUBJECT+' : '+outboundResponse.SMAX_OrderID, emailbody);
                    obj.message = obj.message+'\n'+counter+') '+GE_OG_SAP_IntegrationUtility.WO_SUCCESS_MSG+': '+outboundResponse.SMAX_OrderID;
                    obj.success = true;
                }
                else{
                    logDescription=outboundResponse.ErrorMsg;
                    System.debug('Log Description --> '+logDescription);
                    GE_OG_SAP_IntegrationUtility.insertLog('ERROR',logDescription,system.now(),outboundResponse.SMAX_OrderID, 'WorkOrder');
                    String emailbody = GE_OG_SAP_IntegrationUtility.getEmailBodySAPResponse(outboundResponse.SMAX_OrderID, outboundResponse.Status, outboundResponse.ErrorMsg);
                    GE_OG_SAP_IntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(), GE_OG_SAP_IntegrationUtility.EMAIL_DISPLAY_NAME, GE_OG_SAP_IntegrationUtility.EMAIL_OUT_WO_FAIL_SUBJECT+' : '+outboundResponse.SMAX_OrderID, emailbody);
                    obj.message = obj.message+'\n'+counter+') '+GE_OG_SAP_IntegrationUtility.WO_ERROR_MSG+': '+outboundResponse.SMAX_OrderID;
                    obj.success = false;
                }
            }
            return obj;
        }
        catch(Exception ex){
            SVMXC__Service_Order__c objWo = [SELECT id, Name from SVMXC__Service_Order__c WHERE id =:recordId LIMIT 1];
            String emailbody=GE_OG_SAP_IntegrationUtility.getEmailBodyOutFailure(objWo);
            GE_OG_SAP_IntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(), GE_OG_SAP_IntegrationUtility.EMAIL_DISPLAY_NAME, GE_OG_SAP_IntegrationUtility.EMAIL_OUT_WO_FAIL_SUBJECT+' : '+objWo.Name, emailbody);
            logDescription='GE_OG_SAP_OutboundIntegration:' +ex.getLineNumber()+'---'+ex.getMessage()+'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
            System.debug('Log Description --> '+logDescription);
            GE_OG_SAP_IntegrationUtility.insertLog('EXCEPTION',logDescription,system.now(),objWo.Name,'WorkOrder');
            obj.message = GE_OG_SAP_IntegrationUtility.WO_ERROR_MSG;
            obj.success = false;
            return obj;
        }
    }
}