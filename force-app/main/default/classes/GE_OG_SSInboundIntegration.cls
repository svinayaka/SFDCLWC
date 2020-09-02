/*
Class Name: GE_OG_SSInboundIntegration
Used Where: 
Purpose/Overview: Used by SOA middlewhere to upsert FS Project details to SMAX.
Functional Area: 
Author: Naveen Singhal
Created Date: 26-June-2019
*/
global class GE_OG_SSInboundIntegration{
    global class Status {                                           // inner class to provide a response structure for the service
        public Status() {
            Record_Status = null;
            Error_Message = null;
            
        }
        WebService String Error_Message;
        Webservice Line_Status[] Record_Status;
    }
    
    global class Line_Status {
        WebService String Id;
        WebService String process_Status;
        WebService String Error_Reason;
        WebService String LineNumber;
    }
           
    public GE_OG_SSInboundIntegration(){}   
                                                                        
        global class Project_detail {                                    // Classes for defining the input variables for WebService
        WebService String Order_Number;
        WebService String Order_Status;
        WebService String Line_Number;
        WebService String Line_Status;
        WebService String Item;
        WebService String Item_Description;
        WebService Datetime Customer_Request_Date;
        WebService Datetime Actual_Shipped_Date;
        WebService Datetime Actual_Returned_Date;
        WebService Integer Order_Quantity;
        WebService Integer Shipped_Quantity;
        WebService String Serial_Number;
        WebService String FS_Project_Number;
        WebService String OraclelineId;
        WebService String Invoice_Number;
        WebService Datetime Invoice_Date;
        WebService String Product_Type;     
        
    }
    
    global class Record_Status {                                    // Classes for defining the input variables for WebService
        WebService String Id;
        WebService String Status;
        WebService String Error_Message;       
    }
    
    
    webservice static Status updateProjStatus(List<Record_Status> ProjList) {
        Status wsStatus = new Status();
        List<Line_Status> recStatus = new List<Line_Status>();
        Set<String> strProj = new Set<String>{};
        List<GE_SS_Project__c> updProj =new List<GE_SS_Project__c>();
        try{
            for(Record_Status Projdetail:ProjList)
            {
                if(Projdetail.Id!=NULL){
                    GE_SS_Project__c proj = New GE_SS_Project__c();
                    proj.ID = Projdetail.Id;
                    proj.GE_SS_Integration_Status__c = Projdetail.Status;
                    proj.GE_SS_Integration_Error__c = Projdetail.Error_Message;
                    updProj.add(proj);
                }
                
            }
            if(updProj.size()>0){ 
                Schema.SObjectField f = GE_SS_Project__c.Fields.ID;
                Database.UpsertResult [] results = Database.upsert(updProj, f, false);
                
                for(Integer index = 0, size = results.size(); index < size; index++) {
                    Line_Status processedLine = new Line_Status();
                    processedLine.Id = ProjList[index].Id;
                    if(results[index].isSuccess()) {
                        if(results[index].isCreated()) {
                            processedLine.process_Status = 'Created';
                        } else {
                            processedLine.process_Status = 'Updated';
                        }
                    }
                    else{
                            processedLine.process_Status = 'Error'; 
                            for(Database.Error err : results[index].getErrors()) {
                                    processedLine.Error_Reason = processedLine.Error_Reason +  ' ' + err.getMessage();                           }
                    }
                    recStatus.add(processedLine);
                }
            }
            wsStatus.Record_Status = recStatus;
          return wsStatus;
                
        }
    
    catch(Exception ex) {
            wsStatus.Error_Message = String.valueOf(ex);
            return wsStatus;
        }
    }
    
    
    webservice static Status updateProjLineStatus(List<Record_Status> ProjList) {
        Status wsStatus = new Status();
        List<Line_Status> recStatus = new List<Line_Status>();
        Set<String> strProj = new Set<String>{};
        List<GE_OG_FS_Project_Detail__c> updProj =new List<GE_OG_FS_Project_Detail__c>();
        try{
            for(Record_Status Projdetail:ProjList)
            {
                if(Projdetail.Id!=NULL){
                    GE_OG_FS_Project_Detail__c proj = New GE_OG_FS_Project_Detail__c();
                    proj.GE_OG_Line_Id__c = Projdetail.Id;
                    proj.Integration_Status__c = Projdetail.Status;
                    proj.GE_OG_Error_Message__c = Projdetail.Error_Message;
                    updProj.add(proj);
                }
                
            }
            if(updProj.size()>0){ 
                Schema.SObjectField f = GE_OG_FS_Project_Detail__c.Fields.GE_OG_Line_Id__c;
                Database.UpsertResult [] results = Database.upsert(updProj, f, false);
                
                for(Integer index = 0, size = results.size(); index < size; index++) {
                    Line_Status processedLine = new Line_Status();
                    processedLine.Id = ProjList[index].Id;
                    if(results[index].isSuccess()) {
                        if(results[index].isCreated()) {
                            processedLine.process_Status = 'Created';
                        } else {
                            processedLine.process_Status = 'Updated';
                        }
                    }
                    else{
                            processedLine.process_Status = 'Error'; 
                            for(Database.Error err : results[index].getErrors()) {
                                    processedLine.Error_Reason = processedLine.Error_Reason +  ' ' + err.getMessage();
                            }
                    }
                    recStatus.add(processedLine);
                }
            }
            wsStatus.Record_Status = recStatus;
          return wsStatus;
                
        }
    
    catch(Exception ex) {
            wsStatus.Error_Message = String.valueOf(ex);
            return wsStatus;
        }
    }

    
    
    
    webservice static Status updateProjlines(List<Project_detail> ProjList) {
        Status wsStatus = new Status();
        List<Line_Status> recStatus = new List<Line_Status>();
        Set<String> OracleLineIdSet = new Set<String>();
        Map<String, GE_OG_FS_Project_Detail__c> OracleLineIdMap = new Map<String, GE_OG_FS_Project_Detail__c>();
        Set<String> strProj = new Set<String>{};
        List<GE_OG_FS_Project_Detail__c> updProj =new List<GE_OG_FS_Project_Detail__c>();
        try{
            for(Project_detail Projdetail:ProjList)
            {
                if(Projdetail.OraclelineId!=NULL){
                    GE_OG_FS_Project_Detail__c proj = New GE_OG_FS_Project_Detail__c();
                    proj.GE_OG_Processed__c = false;
                    proj.GE_OG_FS_Line_Type__c = Projdetail.Product_Type;
                    proj.GE_OG_Line_Type__c = Projdetail.Product_Type;
                    if(Projdetail.Order_Number != Null)
                    proj.GE_SS_Sales_Order_Number__c = Projdetail.Order_Number ;
                    proj.GE_OG_Record_Status__c = Projdetail.Order_Status ;
                    if(Projdetail.Customer_Request_Date != Null)
                        proj.GE_SS_Customer_Request_Date__c = Date.valueOf(Projdetail.Customer_Request_Date);
                    proj.GE_SS_SO_Line_Number__c = Projdetail.Line_Number ;
                    proj.GE_OG_SO_Line_Status__c = Projdetail.Line_Status;
                    if(Projdetail.Line_Status == 'CANCELLED'){
                    proj.GE_OG_FS_Line_Status__c = Projdetail.Line_Status;
                    }
                    else{
                        proj.GE_OG_FS_Line_Status__c = 'ENTERED';
                    }
                    proj.GE_OG_Product_Code__c = Projdetail.Item;
                    proj.GE_OG_Product_Description__c = Projdetail.Item_Description;          
                    if(Projdetail.Actual_Shipped_Date != null )
                        proj.GE_SS_Actual_Shipment_Date__c = Date.valueOf(Projdetail.Actual_Shipped_Date);
                    if(Projdetail.Actual_Returned_Date != null )
                    proj.GE_SS_Actual_Returned_Date__c = Date.valueOf(Projdetail.Actual_Returned_Date);
                    proj.GE_OG_Line_Qty__c  = Projdetail.Order_Quantity;
                    proj.GE_SS_Shipped_Quantity__c = Projdetail.Shipped_Quantity;
                    proj.GE_OG_Installed_Product_ID__c = Projdetail.Serial_Number;
                    proj.GE_OG_FS_project_ID__c = Projdetail.FS_Project_Number;
                    proj.GE_OG_Line_Id__c = Projdetail.OraclelineId;
                    proj.GE_OG_SS_Invoice_Number__c = Projdetail.Invoice_Number;
                    if(Projdetail.Invoice_Date != null )
                        proj.GE_SS_Invoice_Date__c = Date.valueOf(Projdetail.Invoice_Date);
                    updProj.add(proj);
                    OracleLineIdSet.add(Projdetail.OraclelineId);
                }
                
            }
            if(updProj.size()>0){ 
                Schema.SObjectField f = GE_OG_FS_Project_Detail__c.Fields.GE_OG_Line_Id__c;
                Database.UpsertResult [] results = Database.upsert(updProj, f, false);
                
                for(GE_OG_FS_Project_Detail__c i: [select Id, name, GE_OG_Line_Id__c from GE_OG_FS_Project_Detail__c where GE_OG_Line_Id__c in :OracleLineIdSet ] )
                {
                    OracleLineIdMap.put(i.GE_OG_Line_Id__c,i);
                }
                
                for(Integer index = 0, size = results.size(); index < size; index++) {
                    Line_Status processedLine = new Line_Status();
                    processedLine.Id = ProjList[index].OraclelineId;
                    if(OracleLineIdMap.containsKey(ProjList[index].OraclelineId))
                        processedLine.LineNumber = OracleLineIdMap.get(ProjList[index].OraclelineId).name;
                    if(results[index].isSuccess()) {
                        if(results[index].isCreated()) {
                            processedLine.process_Status = 'Created';
                        } else {
                            processedLine.process_Status = 'Updated';
                        }
                    }
                    else{
                            processedLine.process_Status = 'Error'; 
                            for(Database.Error err : results[index].getErrors()) {
                                    processedLine.Error_Reason = processedLine.Error_Reason +  ' ' + err.getMessage();                           }
                    }
                    recStatus.add(processedLine);
                }
            }
            wsStatus.Record_Status = recStatus;
          return wsStatus;
                
        }
    
    catch(Exception ex) {
            wsStatus.Error_Message = String.valueOf(ex);
            return wsStatus;
        }
     finally{
         GE_OG_InvokeFSProjectDetailMgmtBatch.executeFSPDProcessing();
     }
    }
}