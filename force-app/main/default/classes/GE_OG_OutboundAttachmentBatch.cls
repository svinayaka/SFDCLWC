global class GE_OG_OutboundAttachmentBatch implements Database.Batchable<sObject>,Database.AllowsCallouts {
    
    /* @Descripton - Start method of batch class to query the required attachments
* @Return - List of Attachments
* */
    private ID recordId;
    Private String woName,outboundResponse, logDescription;
    
    public GE_OG_OutboundAttachmentBatch(ID woID) {
        recordId = woID;
    } 
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug('G*G Heap Size in start'+ Limits.getHeapSize());
        system.debug('G*G Heap Size Limit in start'+Limits.getLimitHeapSize());
        return Database.getQueryLocator(
            'SELECT ID from SVMXC__Service_Order__c  WHERE Id = :recordId'       
        );
    }
    
    global void execute(Database.BatchableContext bc, List<SVMXC__Service_Order__c> woList){
        SVMXC.INTF_WebServicesDef.INTF_Response obj = new SVMXC.INTF_WebServicesDef.INTF_Response(); 
        
        try{
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
                // return obj;
            }
            else{
                logDescription=GE_OG_PCIntegrationUtility.LOG_PAYLOAD_ERR+ ':' + recordId + ' --- ' +outboundResponse;
                GE_OG_PCIntegrationUtility.insertLog('ERROR',logDescription,system.now(),recordId);             
                obj.message=outboundResponse;
                obj.success = false;
                //return obj;
            }
            if(Test.isRunningTest()){
               String errorMessage = 'A exception is found';
               throw new GE_OG_GS_SSOException();
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
            //return obj;          
        }
        
        
    }    
    
    /* @Description - Finish method of batch class
* */
    global void finish(Database.BatchableContext bc){
    }    
}