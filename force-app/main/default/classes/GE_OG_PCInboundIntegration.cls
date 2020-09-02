/*
Class Name: GE_OG_PCInboundIntegration
Purpose/Overview: Used by SOA middlewhere to update SO/Invoice details to SMAX.
Functional Area: Subsea & PC
Author: Prashanth Malegowda/Amit Kumar
Updated By : Shiv Pratap Singh Bhadauria on 30/07/2019
Created Date: 23-SEP-2014
Test Class Name: Test_GE_OG_PCIntegration 
Date Modified: Developer Name: Section/Page Block Modified/Added: Purpose/Overview of Changes
*/
global class GE_OG_PCInboundIntegration{
    global class Status {                                           // inner class to provide a response structure for the service
        public Status() {
            recordStatusInfoList = null ;
        }                                       
        webservice list<RecordStatus_Info> recordStatusInfoList;                
    }
    
    global class RecordStatus_Info{
        webservice String statusCode;                                // error code; to be defined by application logic
        webservice String message ;                                  // a string description of the error or success
        webservice String workDetailName ;                           // a string to send the Work Detail Number 
        // webservice String workOrderName ;                         // a string to send the WO Number 
        
    }
           
    public GE_OG_PCInboundIntegration(){}   
                                                                        
    global class WorkOrder_Info {                                    // Classes for defining the input variables for WebService
        WebService String woNum;                                     // Work order number
        WebService String caseNum;                                   // Case Number
        WebService String salesOrderNum;                             // Sales Order number
        WebService String salesOrderStatus;                          // Sales Order Status
        WebService String invoiceNum;                                // Oracle Invoice Number
        WebService String invoiceStatus;                             // Oracle Invoice Status
        WebService Date invoiceDate;                                 // Oracle Invoice Date
        WebService String projectNumber;                             // Oracle Project Number
        WebService String wotemp1;
        WebService String wotemp2;
        WebService String wotemp3;
    }
    //Added as a part of R-24690
    global class WorkDetail_Info {                                    // Classes for defining the input variables for WebService
    
        WebService String wdLineNum ;                                  // Line Number
        WebService String SOLineNumber ;                               //SalesOrderLineNumber
        WebService String SalesOrderLineStatus ; 
        WebService String SOLineType ;                      // SalesOrderLineStatus
        //Added as part of R-29297
        WebService String invoiceNumber ;                              // Invoice Number
        WebService Date invoiceDate ;                                  // Invoice Date
        //END R-29297
        WebService String wdtemp1 ;
        WebService String wdtemp2 ;
        WebService String wdtemp3 ;
        
    }
    //End of R-24690
             //Added as per the R-24912  
        global class Case_Info {                                    // Classes for defining the input variables for WebService
        WebService String caseNum;                                   // Case Number
        WebService String projectNum;                      // Project Number
        WebService String casetemp1;
        WebService String casetemp2;
        WebService String casetemp3;
        
    }
    
    webservice static Status updateCaseInfo(List<Case_Info> caseList) {
        ID caseRectype = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();
        List<RecordStatus_Info> recStatusList = new List<RecordStatus_Info>() ;
        List<case> caseRecordListToUpdate = new List<case> ();        
        Map<String,Case> caseMap = new Map<String,Case>() ; 
        Database.SaveResult [] caseUpdateResult ;
        String logDescription;
        Status wsStatus = new Status();
        Set<String> strCase = new Set<String>();
        try{
            for(Case_Info casedetail : caseList){
                if(casedetail.caseNum != null){
                   strCase.add(casedetail.caseNum);
                }                
            }
            
            for(Case caseRecord : [SELECT 
                                        Id,CaseNumber,
                                        GE_PW_SalesOrder__c,
                                        GE_ES_Project_Number__c,
                                        RecordType.Name,
                                        RecordtypeId
                                        FROM Case 
                                        WHERE CaseNumber IN :strCase]){
                caseMap.put(caseRecord.CaseNumber,caseRecord) ;                         
            }
            
            if(caseList.size() > 0){
                for(Case_Info caseinf : caseList){
                    if(caseinf.caseNum != null && caseMap.get(caseinf.caseNum).CaseNumber != null && caseinf.caseNum == caseMap.get(caseinf.caseNum).CaseNumber && caseMap.get(caseinf.caseNum).RecordtypeId == caseRectype){
                        Case caseRecordToUpdate = new Case() ;
                        RecordStatus_Info recordStatusObj = new RecordStatus_Info() ;
                        caseRecordToUpdate.Id = caseMap.get(caseinf.caseNum).Id ;
                        caseRecordToUpdate.GE_ES_Project_Number__c = caseinf.projectNum ;
                        caseRecordListToUpdate.add(caseRecordToUpdate) ;
                        recordStatusObj.message = 'Project Number got updated successfully in Servicemax for Case number' + caseMap.get(caseinf.caseNum).CaseNumber ;
                        recordStatusObj.statusCode = '0' ;                    
                        recStatusList.add(recordStatusObj) ;
                    }
                }           
            }       
            
           
                if(caseRecordListToUpdate.size() > 0){
                    caseUpdateResult = Database.update(caseRecordListToUpdate,false) ;
                }
                wsStatus.recordStatusInfoList = recStatusList ;         
        }catch(Exception ex){
           /*
            Will redesign the piece of exception handling 
            recStatusList.clear() ;
            List<Case> caseWithError = new List<Case>() ;
            Map<Id,Case> originalCaseMap = new Map<Id,Case>() ;
            Set<Id> errorCaseRecordIdSet = new Set<Id>() ; 
            
            for(Database.SaveResult caseDMLState : caseUpdateResult) {
                if(!caseDMLState.isSuccess()){
                    errorCaseRecordIdSet.add(caseDMLState.getId()) ;
                }                  
            }
            
            for(Case caseRec : caseMap.values()){
                originalCaseMap.put(caseRec.Id,caseRec) ;
                caseWithError.add(caseRec) ;
            }
            
            for(Database.SaveResult caseDMLState : caseUpdateResult) {              
                for(Database.Error err : caseDMLState.getErrors()){
                    if(originalCaseMap.get(caseDMLState.getId()).Id == caseDMLState.getId()){
                        RecordStatus_Info recordStatusObj = new RecordStatus_Info() ;
                        //recordStatusObj.workDetailName = errorWDRecordMap.get(wdDMLState.getId()).Name ;                   
                        logDescription='GE_OG_PCInboundIntegration:' +ex.getLineNumber()+'---'+ err.getMessage() +'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
                        GE_OG_PCIntegrationUtility.notifyCaseInboundFailure(caseWithError , logDescription);  
                        recordStatusObj.message = 'Error -----> ' + err.getMessage() + ' in updating the Project Number details Servicemax for Case Number -->' + originalCaseMap.get(caseDMLState.getId()).CaseNumber ;
                        recordStatusObj.statusCode = '-1' ;
                        System.debug('******************Error while updating project Details on Case Record*************************' + recordStatusObj) ;
                        recStatusList.add(recordStatusObj) ; 
                    }                        
                }
            } 
            
            wsStatus.recordStatusInfoList = recStatusList ;  */  
        }
        
        return wsStatus ; 
    }//END of method updateCaseInfo & R-24912    
    
    webservice static Status updateWorkOrderInfo(List<WorkOrder_Info> workOrderList,string Updatetype) {
        ID caseRectype = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();
        List<RecordStatus_Info> recStatusList = new List<RecordStatus_Info>() ;
        List<SVMXC__Service_Order__c> workOrderListToUpdate = new List<SVMXC__Service_Order__c>();
        List<case> caseListToUpdate = new List<case>();
        Map<String,Case> caseMap = new Map<String,Case>() ;
        Map<String,SVMXC__Service_Order__c> workOrderMap = new  Map<String,SVMXC__Service_Order__c>() ;
        Database.SaveResult [] woUpdateResult , caseUpdateResult ;
        Status wsStatus = new Status();
        String logDescription;
        Set<String> strWO = new Set<String>();
        Set<String> strCase = new Set<String>();         
        try{ 
            for(WorkOrder_Info woinfo : workOrderList) {
                if(woinfo.woNum!=null && woinfo.caseNum!=null){
                    strWO.add(woinfo.woNum);
                    strCase.add(woinfo.caseNum);
                }
            }
            
            //R-26139 : Modified above query - Removed Invoice fields as of no Interface functionality for Invoicing.
            for(SVMXC__Service_Order__c woRec : [SELECT 
                                                      Id, Name, 
                                                      GE_DS_Billing_Region__r.GE_OG_DS_Billing_Admin__r.id,
                                                      SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin__r.id,
                                                      SVMXC__Case__r.CaseNumber, GE_PC_Oracle_FSO__c, 
                                                      GE_PC_Oracle_SalesOrderStatus__c, SVMXC__Order_Status__c 
                                                      FROM SVMXC__Service_Order__c WHERE Name IN : strWO AND 
                                                      SVMXC__Case__r.CaseNumber IN : strCase]){
                workOrderMap.put(woRec.Name,woRec) ;
            }
            
            //Retriving Case details for :Added as a part of R-24690
            for(Case caseRecord : [SELECT 
                                        Id,CaseNumber,
                                        GE_PW_SalesOrder__c,
                                        RecordType.Name,
                                        RecordtypeId 
                                        FROM Case WHERE 
                                        CaseNumber IN : strCase]){
                caseMap.put(caseRecord.CaseNumber,caseRecord) ;                         
            }
            
            if(workOrderList.size() > 0){
                for(WorkOrder_Info woRecord : workOrderList){
                    if(woRecord.woNum != null && workOrderMap.get(woRecord.woNum).Name == woRecord.woNum){
                        SVMXC__Service_Order__c woRecToUpdate = new SVMXC__Service_Order__c() ;
                        RecordStatus_Info recordStatusObj = new RecordStatus_Info() ;
                        woRecToUpdate.Id = workOrderMap.get(woRecord.woNum).Id ;
                        
                        //Update Sales Order
                        if(Updatetype.equalsIgnoreCase('SalesOrder')){
                            woRecToUpdate.GE_PC_Oracle_FSO__c = woRecord.salesOrderNum ;
                            woRecToUpdate.GE_PC_Oracle_SalesOrderStatus__c = woRecord.SalesOrderStatus ; 
                            //Added as  a part of R-24690
                            for(String strValue : strCase){
                                if(caseMap.get(strValue).CaseNumber == strValue && caseMap.get(strValue).RecordtypeId == caseRectype){
                                    Case caseRecordToUpdate = new Case() ;
                                    caseRecordToUpdate.Id = caseMap.get(strValue).Id ;
                                    if(woRecord.salesOrderNum != null){
                                        caseRecordToUpdate.GE_PW_SalesOrder__c = woRecord.salesOrderNum ;
                                        System.debug('The Sales Order # came to Smax is: on case '+caseRecordToUpdate.GE_PW_SalesOrder__c + 'On Workorder is :' +woRecToUpdate.GE_PC_Oracle_FSO__c );                               
                                    }
                                    woRecToUpdate.GE_PC_Oracle_SalesOrderStatus__c = GE_OG_PCIntegrationUtility.DS_WO_OUTBOUND_STATUS ;
                                    if(!caseListToUpdate.contains(caseRecordToUpdate))
                                        caseListToUpdate.add(caseRecordToUpdate) ; //Case list to consider for the update
                                }else{
                                    //Bug# 0000023998 Added blow line
                                    woRecToUpdate.SVMXC__Order_Status__c = GE_OG_PCIntegrationUtility.WO_STATUS_OUTBOUND ;
                                }                           
                            }//End of R-24690                       
                            recordStatusObj.message = Updatetype + ' got updated successfully in Servicemax for Work Order number' + woRecord.woNum ;
                            recordStatusObj.statusCode = '0' ;
                            recStatusList.add(recordStatusObj) ;                        
                        }
                        
                        //Update Invoice
                        if(Updatetype.equalsIgnoreCase('Invoice')){
                            // R-26139 : Commented below lines as Invoice fields are not in use and functionality is not implemented
                            //objWO.GE_PC_Oracle_Invoice__c = woRecord.invoiceNum;
                            //objWO.GE_PC_Oracle_InvoiceStatus__c = woRecord.InvoiceStatus;
                            //objWO.GE_PC_Oracle_InvoiceDate__c = woRecord.InvoiceDate;
                            String invNo='';
                            //String invNo=objWO.GE_PC_Oracle_Invoice__c;
                            if(invNo != null){
                               woRecToUpdate.SVMXC__Order_Status__c='Closed';
                            }
                        }
                        
                        if(woRecToUpdate != null){
                            workOrderListToUpdate.add(woRecToUpdate) ;
                        }           
                    }
                }            
            }
            
            
               if(workOrderListToUpdate.size() > 0 ){
                   woUpdateResult = Database.update(workOrderListToUpdate,false) ;
               } 
               
               if(caseListToUpdate.size() > 0 ){
                   caseUpdateResult = Database.update(caseListToUpdate,false) ;                         
               }
               wsStatus.recordStatusInfoList = recStatusList ;        
        }catch(Exception ex){
              /* Will redesign the piece of exception handling 
              recStatusList.clear() ;
              List<SVMXC__Service_Order__c> woListWithErrors = new List<SVMXC__Service_Order__c>();
              List<Case> caseListError = new List<Case>() ;
              Map<Id,Case> originalCaseRecordMap = new Map<Id,Case>() ;
              Map<Id,Case> errorCaseRecordMap = new Map<Id,Case>() ;
              Map<Id,SVMXC__Service_Order__c> errorWORecordMap = new Map<Id,SVMXC__Service_Order__c>() ;
              Map<Id,SVMXC__Service_Order__c> originalWORecMap = new Map<Id,SVMXC__Service_Order__c>() ; 
              Set<Id> workOrderErrorRecord = new Set<Id>() ;
              Set<Id> caseErrorRecordIdSet = new Set<Id>() ;
              
              for(SVMXC__Service_Order__c woRec : workOrderMap.values()){
                woListWithErrors.add(woRec) ;
                originalWORecMap.put(woRec.Id,woRec) ;
              }
              
              for(Case caseRec : caseMap.values()){
                caseListError.add(caseRec) ;
                originalCaseRecordMap.put(caseRec.Id,caseRec) ;
              }              
              
              for(Database.SaveResult woDMLState : woUpdateResult) {
                if(!woDMLState.isSuccess()){
                    workOrderErrorRecord.add(woDMLState.getId()) ;
                }                  
              }
              
              for(Database.SaveResult caseDMLState : caseUpdateResult) {
                if(!caseDMLState.isSuccess()){
                    caseErrorRecordIdSet.add(caseDMLState.getId()) ;
                }                  
              }              
              
              for(Id errorWORecId : workOrderErrorRecord){
                if(originalWORecMap.containsKey(errorWORecId) && originalWORecMap.get(errorWORecId).Id == errorWORecId){
                    errorWORecordMap.put(originalWORecMap.get(errorWORecId).Id,originalWORecMap.get(errorWORecId)) ;
                }
              }
              
              for(Id errorCaseRecId : caseErrorRecordIdSet){
                if(originalCaseRecordMap.containsKey(errorCaseRecId) && originalCaseRecordMap.get(errorCaseRecId).Id == errorCaseRecId){
                    errorCaseRecordMap.put(originalCaseRecordMap.get(errorCaseRecId).Id,originalCaseRecordMap.get(errorCaseRecId)) ;
                }
              }       
              
              for(Database.Saveresult woDMLState : woUpdateResult){                
                   for(Database.Error err : woDMLState.getErrors()){ 
                       if(errorWORecordMap.get(woDMLState.getId()).Id == woDMLState.getId()){
                          RecordStatus_Info recordStatusObj = new RecordStatus_Info() ;                                         
                          recordStatusObj.message = 'Error -----> ' + err.getMessage() + ' in updating the ' + Updatetype + ' details Servicemax for Work Order Number -->' + errorWORecordMap.get(woDMLState.getId()).Name ;
                          recordStatusObj.statusCode = '-1';
                          System.debug('***************Error while updating Details on non-subsea WO Record*********************' + recordStatusObj) ;
                          recStatusList.add(recordStatusObj) ;
                          logDescription='GE_OG_PCInboundIntegration:' +ex.getLineNumber()+'---'+ err.getMessage() +'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
                          GE_OG_PCIntegrationUtility.notifyInboundFailure(woListWithErrors , logDescription);
                       }                            
                   }
              }
              
              for(Database.Saveresult caseDMLState : caseUpdateResult){                
                   for(Database.Error err : caseDMLState.getErrors()){ 
                       if(errorCaseRecordMap.get(caseDMLState.getId()).Id == caseDMLState.getId()){
                          RecordStatus_Info recordStatusObj = new RecordStatus_Info() ;                                         
                          recordStatusObj.message = 'Error -----> ' + err.getMessage() + ' in updating the Project Number details Servicemax for Case Number -->' + errorCaseRecordMap.get(caseDMLState.getId()).CaseNumber ;
                          recordStatusObj.statusCode = '-1';
                          System.debug('***************Error while updating Project Details on Cases associated to non-subsea WO Record*********************' + recordStatusObj) ;
                          recStatusList.add(recordStatusObj) ;
                          logDescription='GE_OG_PCInboundIntegration:' +ex.getLineNumber()+'---'+ err.getMessage() +'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
                          GE_OG_PCIntegrationUtility.notifyCaseInboundFailure(caseListError , logDescription);
                       }                            
                   }
              } 
              
              wsStatus.recordStatusInfoList = recStatusList ;  */                            
         } 
         return wsStatus ;      
   }//End of method updateWorkOrderInfo
   
 webservice static Status updateSSWorkOrderInfo(List<WorkOrder_Info> workOrderList,List<WorkDetail_Info> workDetailList,string Updatetype) {
         Status wsStatus = new Status();
         String logDescription;
         List<RecordStatus_Info> recStatusList = new List<RecordStatus_Info>() ;
         Set<String> strWO = new Set<String>{};
         Set<String> strWD = new Set<String>{};
         Map<String,SVMXC__Service_Order__c> workOrderMap = new Map<String,SVMXC__Service_Order__c>() ;
         Map<String,WorkOrder_Info> workOrderSOMap = new Map<String,WorkOrder_Info>() ;
         Map<String,SVMXC__Service_Order_Line__c> workDetailMap = new Map<String,SVMXC__Service_Order_Line__c>() ;
         List<SVMXC__Service_Order__c> workOrderListToUpdate = new List<SVMXC__Service_Order__c>();
         List<SVMXC__Service_Order_Line__c> workDetailListToUpdate = new List<SVMXC__Service_Order_Line__c>();
         Database.SaveResult [] woUpdateResult , wdUpdateResult ;
         
         System.Debug('**********Entered************'+workOrderList+Updatetype);
         
         try{
             for(WorkOrder_Info woinfo : workOrderList) {
                   if(woinfo.woNum!=null){
                       strWO.add(woinfo.woNum);
                       workOrderSOMap.put(woinfo.woNum,woinfo) ;
                   }
             }
             
             for(WorkDetail_Info wdinfo : workdetailList){
                   if(wdinfo.wdLineNum!=null && wdinfo.SOLineNumber!=null && wdinfo.SalesOrderLineStatus!=null){
                         strWD.add(wdinfo.wdLineNum);
                   }
             }
             
             for(SVMXC__Service_Order__c woRecord : [SELECT 
                                                           Id,Name,
                                                           GE_OG_Project_Number__c, 
                                                           GE_DS_Billing_Region__r.GE_OG_DS_Billing_Admin__r.id,
                                                           SVMXC__Service_Group__r.GE_OG_DS_Billing_Admin__r.id,
                                                           SVMXC__Case__r.CaseNumber,GE_PC_Oracle_FSO__c, 
                                                           GE_PC_Oracle_SalesOrderStatus__c, 
                                                           SVMXC__Order_Status__c 
                                                           FROM SVMXC__Service_Order__c 
                                                           WHERE Name IN : strWO]){
                workOrderMap.put(woRecord.Name,woRecord) ;          
             }
             
             //In the below Query Added GE_OG_SS_Invoice_Number__c,GE_SS_Invoice_Date__c as part of R-29297
             for(SVMXC__Service_Order_Line__c wdRecord : [SELECT 
                                                               Id, Name,GE_SS_Invoice_Date__c,GE_SS_SO_Line_Type__c, 
                                                               SVMXC__Line_Type__c, GE_SS_SO_Line_Number__c,
                                                               GE_DS_SO_line_status__c,GE_OG_SS_Invoice_Number__c,
                                                               SVMXC__Service_Order__r.Name                                                            
                                                               FROM SVMXC__Service_Order_Line__c 
                                                               WHERE Name IN :strWD]){
                 workDetailMap.put(wdRecord.Name,wdRecord) ;             
             }
             
             if(workOrderList.size() > 0){
                for(WorkOrder_Info workOrderRecord : workOrderList){
                   // if(workOrderRecord.woNum != null && workOrderMap.get(workOrderRecord.woNum).Name == workOrderRecord.woNum && ( workOrderList.size() == workOrderMap.size())){
                       if(workOrderRecord.woNum != null && workOrderMap.ContainsKey(workOrderRecord.woNum)  && workOrderMap.get(workOrderRecord.woNum).Name == workOrderRecord.woNum ){
                            SVMXC__Service_Order__c woRecordToUpdate = new SVMXC__Service_Order__c() ; 
                            RecordStatus_Info recordStatusObj = new RecordStatus_Info() ;                                          
                            woRecordToUpdate.Id = workOrderMap.get(workOrderRecord.woNum).Id ;
                            if(Updatetype.equalsIgnoreCase('SalesOrder') || Updatetype.equalsIgnoreCase('InvoiceUpdate')) {
                                woRecordToUpdate.GE_PC_Oracle_FSO__c = (workOrderRecord.salesOrderNum != null || workOrderRecord.salesOrderNum != '')  ? workOrderRecord.salesOrderNum : workOrderMap.get(workOrderRecord.woNum).GE_PC_Oracle_FSO__c ;
                                woRecordToUpdate.GE_PC_Oracle_SalesOrderStatus__c = (workOrderRecord.SalesOrderStatus != null || workOrderRecord.SalesOrderStatus != '') ? workOrderRecord.SalesOrderStatus : workOrderMap.get(workOrderRecord.woNum).GE_PC_Oracle_SalesOrderStatus__c ;
                            }
                            if(Updatetype.equalsIgnoreCase('ProjectCreation')){      
                                woRecordToUpdate.GE_OG_Project_Number__c = (workOrderRecord.projectNumber != null || workOrderRecord.projectNumber != '') ?  workOrderRecord.projectNumber : workOrderMap.get(workOrderRecord.woNum).GE_OG_Project_Number__c ;                                        
                            }
                            recordStatusObj.message = workOrderRecord.woNum + ' got successfully synced with Oracle Information.';               
                            recordStatusObj.statusCode = '0' ;             
                        
                        if(woRecordToUpdate != null){
                            workOrderListToUpdate.add(woRecordToUpdate) ;
                        }
                         
                       recStatusList.add(recordStatusObj) ;                   
                    }
                }
                
                for(WorkDetail_Info workDetailRecord : workdetailList){
                 //   if(workDetailRecord.wdLineNum != null && workdetailList.size() == workDetailMap.size() && workDetailMap.get(workDetailRecord.wdLineNum).Name == workDetailRecord.wdLineNum){
                 if(workDetailRecord.wdLineNum != null && workDetailMap.ContainsKey(workDetailRecord.wdLineNum) && workDetailMap.get(workDetailRecord.wdLineNum).Name == workDetailRecord.wdLineNum){
                            SVMXC__Service_Order_Line__c workDetailRecordToUpdate = new SVMXC__Service_Order_Line__c() ;
                            RecordStatus_Info recordStatusObj = new RecordStatus_Info() ; 
                            if(Updatetype.equalsIgnoreCase('SalesOrder') || Updatetype.equalsIgnoreCase('InvoiceUpdate')) {                   
                                workDetailRecordToUpdate.Id = workDetailMap.get(workDetailRecord.wdLineNum).Id ; 
                                workDetailRecordToUpdate.GE_SS_SO_Line_Number__c = (workDetailRecord.SOLineNumber != null || workDetailRecord.SOLineNumber != '') ? workDetailRecord.SOLineNumber : workDetailMap.get(workDetailRecord.wdLineNum).GE_SS_SO_Line_Number__c ;
                                workDetailRecordToUpdate.GE_DS_SO_line_status__c = (workDetailRecord.SalesOrderLineStatus != null || workDetailRecord.SalesOrderLineStatus != '') ? workDetailRecord.SalesOrderLineStatus : workDetailMap.get(workDetailRecord.wdLineNum).GE_DS_SO_line_status__c ;
                                workDetailRecordToUpdate.GE_OG_SS_Invoice_Number__c = (workDetailRecord.invoiceNumber != null || workDetailRecord.invoiceNumber != '') ? workDetailRecord.invoiceNumber : workDetailMap.get(workDetailRecord.wdLineNum).GE_OG_SS_Invoice_Number__c ;
                                workDetailRecordToUpdate.GE_SS_Invoice_Date__c = workDetailRecord.invoiceDate != null  ? workDetailRecord.invoiceDate : workDetailMap.get(workDetailRecord.wdLineNum).GE_SS_Invoice_Date__c ;
                                workDetailRecordToUpdate.GE_SS_SO_Line_Type__c = (workDetailRecord.SOLineType != null || workDetailRecord.SOLineType != '') ? workDetailRecord.SOLineType : workDetailMap.get(workDetailRecord.wdLineNum).GE_SS_SO_Line_Type__c ;
                                if(workOrderSOMap.ContainsKey(workDetailMap.get(workDetailRecord.wdLineNum).SVMXC__Service_Order__r.Name))
                                    workDetailRecordToUpdate.GE_SS_Sales_Order_Number__c = workOrderSOMap.get(workDetailMap.get(workDetailRecord.wdLineNum).SVMXC__Service_Order__r.Name).salesOrderNum ;
                                recordStatusObj.workDetailName = workDetailRecord.wdLineNum ;
                                recordStatusObj.message = workDetailRecord.wdLineNum + ' got successfully synced with Oracle Information.' ;
                                recordStatusObj.statusCode = '0' ;                       
                                recStatusList.add(recordStatusObj);
                                
                                if(workDetailRecordToUpdate != null){
                                    workDetailListToUpdate.add(workDetailRecordToUpdate) ;
                                }
                               
                            }     
                    }
                }   
             }
             
             
                if(workOrderListToUpdate.size() > 0){
                    woUpdateResult = Database.update(workOrderListToUpdate,false) ;
                }
                
                if(workDetailListToUpdate.size() > 0){
                    wdUpdateResult = Database.update(workDetailListToUpdate,false) ;
                }
                wsStatus.recordStatusInfoList = recStatusList ;       
         }catch(DMLException ex){ 
            /* Will redesign the piece of exception handling            
            List<SVMXC__Service_Order__c> woListWithErrors = new List<SVMXC__Service_Order__c>();
            List<SVMXC__Service_Order_Line__c> wdListWithErrors = new List<SVMXC__Service_Order_Line__c>();
            Map<Id,SVMXC__Service_Order_Line__c> errorWDRecordMap = new Map<Id,SVMXC__Service_Order_Line__c>() ;
            Map<Id,SVMXC__Service_Order_Line__c> initialWDRecordMap = new Map<Id,SVMXC__Service_Order_Line__c>() ;
            Map<Id,SVMXC__Service_Order__c> errorWORecordMap = new Map<Id,SVMXC__Service_Order__c>() ;
            Map<Id,SVMXC__Service_Order__c> initialWORecordMap = new Map<Id,SVMXC__Service_Order__c>() ;
            Set<Id> workDetailErrorRecord = new Set<Id>() ;
            Set<Id> workOrderErrorRecord = new Set<Id>() ;
            recStatusList.clear() ;
            
            for(SVMXC__Service_Order__c woRec : workOrderMap.values()){
                woListWithErrors.add(woRec) ;
                initialWORecordMap.put(woRec.Id,woRec) ;
            } 
            
            for(SVMXC__Service_Order_Line__c wdrec : workDetailMap.values()){
                wdListWithErrors.add(wdrec) ;
                initialWDRecordMap.put(wdrec.Id,wdrec) ;
            }            
            
            for(Database.SaveResult wdDMLState : wdUpdateResult) {
                if(!wdDMLState.isSuccess()){
                    workDetailErrorRecord.add(wdDMLState.getId()) ;
                }                  
            }
            
            for(Database.SaveResult woDMLState : woUpdateResult) {
                if(!woDMLState.isSuccess()){
                    workOrderErrorRecord.add(woDMLState.getId()) ;
                }                  
            }
            
            for(Id errorWORecId : workOrderErrorRecord){
                if(initialWORecordMap.containsKey(errorWORecId) && initialWORecordMap.get(errorWORecId).Id == errorWORecId){
                    errorWORecordMap.put(initialWORecordMap.get(errorWORecId).Id,initialWORecordMap.get(errorWORecId)) ;
                }
            }            
            
            for(Id errorWDRecId : workDetailErrorRecord){
                if(initialWDRecordMap.containsKey(errorWDRecId) && initialWDRecordMap.get(errorWDRecId).Id == errorWDRecId){
                    errorWDRecordMap.put(initialWDRecordMap.get(errorWDRecId).Id,initialWDRecordMap.get(errorWDRecId)) ;
                }
            }   
            
            for(Database.SaveResult wdDMLState : wdUpdateResult) {              
                for(Database.Error err : wdDMLState.getErrors()){
                    if(errorWDRecordMap.get(wdDMLState.getId()).Id == wdDMLState.getId()){
                        RecordStatus_Info recordStatusObj = new RecordStatus_Info() ;
                        recordStatusObj.workDetailName = errorWDRecordMap.get(wdDMLState.getId()).Name ;                   
                        logDescription='GE_OG_PCInboundIntegration:' +ex.getLineNumber()+'---'+ err.getMessage() +'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
                        GE_OG_PCIntegrationUtility.notifyInboundFailureWD(wdListWithErrors , logDescription);  
                        recordStatusObj.message = 'Error -----> ' + err.getMessage() + ' in updating the details Servicemax for Work Detail Number -->' + errorWDRecordMap.get(wdDMLState.getId()).Name ;
                        recordStatusObj.statusCode = '-1' ;
                        System.debug('*********Error while updating Details on subsea Work Detail Record**********' + recordStatusObj) ;
                        recStatusList.add(recordStatusObj) ; 
                    }                        
                }
            }
            for(Database.SaveResult woDMLState : woUpdateResult) {
                  for(Database.Error err : woDMLState.getErrors()){
                     if(errorWORecordMap.get(woDMLState.getId()).Id == woDMLState.getId()){
                        RecordStatus_Info recordStatusObj = new RecordStatus_Info() ;                                           
                        logDescription='GE_OG_PCInboundIntegration:' +ex.getLineNumber()+'---'+ err.getMessage() +'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
                        GE_OG_PCIntegrationUtility.notifyInboundFailure(woListWithErrors , logDescription);   
                        recordStatusObj.message = 'Error -----> ' + err.getMessage() + ' in updating the details Servicemax for Work Order Number -->' + errorWORecordMap.get(woDMLState.getId()).Name ;
                        recordStatusObj.statusCode = '-1' ;
                        System.debug('*********Error while updating Details on subsea Work Order Record**********' + recordStatusObj) ;
                        recStatusList.add(recordStatusObj) ; 
                     }                                              
                  }
            }            
            wsStatus.recordStatusInfoList = recStatusList ; */         
         }
         return wsStatus;       
   }//End of method updateSSWorkOrderInfo            
}//End of class GE_OG_PCInboundIntegration