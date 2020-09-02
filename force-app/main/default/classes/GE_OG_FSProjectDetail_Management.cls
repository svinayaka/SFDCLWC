/*************************************************************************************************************************************************************
@ Class:          GE_OG_FSProjectDetail_Management
@ Version:        1.1
@ Author:         Mani(manikandan.c@bhge.com)
@ Purpose:        Batch Class to upsert Product, IP and update Work detail.
/*************************************************************************************************************************************************************/

global class GE_OG_FSProjectDetail_Management implements Database.Batchable<sObject> {
    Id fsProjectRecTypeId = Schema.SObjectType.GE_SS_Project__c.getRecordTypeInfosByName().get('SS Project').getRecordTypeId();
    Id pdtSMXRecTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('ServiceMax').getRecordTypeId();
    Id ipEqpRecTypeId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Equipment').getRecordTypeId();
    Id ipSprRecTypeId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Spares').getRecordTypeId();
    Id ipToolRecTypeId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Tools').getRecordTypeId();
    Id wdEQPRecTypeId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Equipment').getRecordTypeId();
    Id wdSprRecTypeId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Spares').getRecordTypeId();
    Id wdtoolRecTypeId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
    Set<Id> ipRecTypeSet = new Set<Id>();
    Set<Id> wdRecTypeSet = new Set<Id>();
    global Database.QueryLocator start(Database.BatchableContext BC) {
        DescribeSObjectResult describeResult = GE_OG_FS_Project_Detail__c.getSObjectType().getDescribe();
        List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );
        String query = ' SELECT  ' +       String.join( fieldNames, ',' ) +    ' FROM GE_OG_FS_Project_Detail__c where GE_OG_Processed__c = false' ;
        return Database.getQueryLocator(query); 
    }
    
    global void execute(Database.BatchableContext BC, List<Sobject> scope) {
        Id prdId = null;
        Id ipId = null;
        Product2 prd = null;
        String ErrorMessage = Null;
        SVMXC__Installed_Product__c ip = null;
        SVMXC__Service_Order_Line__c wrkDetail = null;
        ipRecTypeSet.add(ipEQPRecTypeId);
        ipRecTypeSet.add(ipSprRecTypeId);
        ipRecTypeSet.add(ipToolRecTypeId);
        wdRecTypeSet.add(wdEQPRecTypeId);
        wdRecTypeSet.add(wdSprRecTypeId);
        wdRecTypeSet.add(wdToolRecTypeId);
        List<SVMXC__Service_Order_Line__c> wdUpsertList = new List<SVMXC__Service_Order_Line__c>();
        System.debug('Inside Execute');
        For(Sobject sObj : scope){
            GE_OG_FS_Project_Detail__c tmRec =  (GE_OG_FS_Project_Detail__c)sObj ;
            tmRec.GE_OG_Processed__c = true;
            system.debug('Tools Management' + sObj);
            
            //Reset of lookups if the record comes from integration         
            if(tmRec.GE_OG_Line_Id__c != Null)
            {
                if(tmRec.GE_OG_FS_project_ID__c == null || tmRec.GE_OG_FS_project_ID__c == '')
                    tmRec.GE_OG_FS_Project__c = null;
                if(tmRec.GE_OG_Product_Code__c == null || tmRec.GE_OG_Product_Code__c == '')
                    tmRec.GE_OG_Product__c =  null;
                if(tmRec.GE_OG_Installed_Product_ID__c == null || tmRec.GE_OG_Installed_Product_ID__c == '')
                    tmRec.GE_OG_Installed_Product__c = null;
            }
            
            // FS Project Link Logic
            if(tmRec.GE_OG_FS_project_ID__c != Null ){
                List<GE_SS_Project__c> fsProjectList = [select id from GE_SS_Project__c where GE_SS_Project_ID__c =: tmRec.GE_OG_FS_project_ID__c and RecordTypeId = :fsProjectRecTypeId limit 1];
                if(fsProjectList.size() != 0){
                    tmRec.GE_OG_FS_Project__c = fsProjectList[0].Id;
                }
            }
            
            // Product Logic
            if(tmRec.GE_OG_Product_Code__c != Null ){
                List<Product2> prdList = [Select Id from product2 where Name = :tmRec.GE_OG_Product_Code__c and RecordTypeId =:pdtSMXRecTypeId  limit 1];
                if(prdList.size() == 0)
                    prd = New Product2(RecordTypeId=pdtSMXRecTypeId, SVMXC__Product_Type__c=tmRec.GE_OG_product_type__c, ProductCode=tmRec.GE_OG_Product_Code__c,Description=tmRec.GE_OG_Product_Description__c, Name=tmRec.GE_OG_Product_Code__c, IsActive=true, GE_Tier1_PnL__c=tmRec.GE_OG_Tier_1__c,GE_Tier2_PnL__c=tmRec.GE_OG_Tier_2__c,GE_Tier3_PnL__c=tmRec.GE_OG_Tier_3__c);
                else{
                    tmRec.GE_OG_Product__c = prdList[0].Id;
                }
            }
            if(prd != null){
                Database.SaveResult prdSR = Database.insert(prd);
                if (prdSR.isSuccess()) {
                    tmRec.GE_OG_Product__c = prdSR.getId();
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : prdSR.getErrors()) {
                        ErrorMessage = ErrorMessage  + 'Product creation failed:' + err.getMessage() + ';';                   
                    }
                    tmRec.GE_OG_Processed__c = false;
                }
            }
            
            // Installed Product Logic
            if(tmRec.GE_OG_Product__c != Null  && tmRec.GE_OG_Installed_Product_ID__c != Null ){
                List<SVMXC__Installed_Product__c> ipList = [Select id from SVMXC__Installed_Product__c where SVMXC__Product__c =: tmRec.GE_OG_Product__c and Name =:tmRec.GE_OG_Installed_Product_ID__c and RecordTypeID IN: ipRecTypeSet Limit 1];                
                if(ipList.Size() == 0){
                    ip = New SVMXC__Installed_Product__c(Name = tmRec.GE_OG_Installed_Product_ID__c,SVMXC__Serial_Lot_Number__c = tmRec.GE_OG_Installed_Product_ID__c ,SVMXC__Product__c = tmRec.GE_OG_Product__c,GE_AL_Installed_Product_Type__c = tmRec.GE_OG_FS_Line_Type__c,GE_OG_SS_Tier2__c = tmRec.GE_OG_Tier_2__c,GE_OG_SS_Tier3__c = tmRec.GE_OG_Tier_3__c, GE_SS_Product_Category__c = tmRec.GE_SS_Installed_Product_Category__c);
                    if(tmRec.GE_OG_FS_Line_Type__c == 'Equipment')
                        ip.RecordTypeId = ipEqpRecTypeId;  
                    else if(tmRec.GE_OG_FS_Line_Type__c == 'Spares')
                        ip.RecordTypeId = ipSprRecTypeId;
                    else if(tmRec.GE_OG_FS_Line_Type__c == 'Tools')
                        ip.RecordTypeId = iptoolRecTypeId;
                }
                else{
                    tmRec.GE_OG_Installed_Product__c  = ipList[0].Id;
                }
            }
            if(ip != null){
                Database.SaveResult ipSR = Database.insert(ip);
                if (ipSR.isSuccess()) { 
                    tmRec.GE_OG_Installed_Product__c  = ipSR.getId();
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : ipSR.getErrors()) {
                        ErrorMessage = ErrorMessage + 'IP creation failed:' + err.getMessage() + ';';                  
                    } 
                    tmRec.GE_OG_Processed__c = false;
                }
            }
            
            
            
            //Syncing Fs Project Details information to all Work details related to the FS project.
            Map<Id,SVMXC__Service_Order_Line__c> wdUpdateMap = new Map<Id,SVMXC__Service_Order_Line__c>();
            Set<Id> wdSucessSet = new Set<Id>();
            String FailedWorkDetail = null;
            if(tmRec.GE_OG_FS_Project__c != Null && tmRec.GE_OG_Product__c != Null && tmRec.GE_OG_Installed_Product__c != Null ){  //GE_SS_FS_Project__c =: tmRec.GE_OG_FS_Project__c AND SVMXC__Serial_Number__c =:tmRec.GE_OG_Installed_Product__c AND RecordTypeId IN: wdRecTypeSet AND GE_SS_FS_Project_Detail__c =: tmRec.ID
                List<SVMXC__Service_Order_Line__c> wdList = [Select id, GE_DS_Parent_Work_Order_Record_Type_Name__c from SVMXC__Service_Order_Line__c where RecordTypeId IN: wdRecTypeSet AND GE_SS_FS_Project_Detail__c =: tmRec.ID];
                
                system.debug('wdList'+ wdList );
                if(wdList.Size() > 0){
                    tmRec.GE_OG_Number_of_Runs__c = 0;
                    for(SVMXC__Service_Order_Line__c wd1:wdList){
                        if(wd1.GE_DS_Parent_Work_Order_Record_Type_Name__c == 'SS-Trip')
                        tmRec.GE_OG_Number_of_Runs__c = tmRec.GE_OG_Number_of_Runs__c+1;
                    }
                  system.debug('Inside If logic' );
                      //Query for metadata records
        List<SS_FS_Lines_Sync__mdt> mappingFieldList = [SELECT Source_Field__c, WD_Target_Field__c FROM SS_FS_Lines_Sync__mdt where Active__c = true];
        /*for(SS_FS_Lines_Sync__mdt metaDataRecords :[SELECT Source_Field__c, WD_Target_Field__c FROM SS_FS_Lines_Sync__mdt where Active__c = true] ){
                mappingFieldList.add(metaDataRecords);                                          
        }*/
            system.debug('metaDataRecords'+ mappingFieldList );
                    
                    for(SVMXC__Service_Order_Line__c wd: wdList){
                        SVMXC__Service_Order_Line__c workDet = new SVMXC__Service_Order_Line__c() ; 
                        workDet.Id = wd.Id;
                         for(Integer i=0 ; i < mappingFieldList.size() ; i++){ 
                             String targetField = String.valueOf(mappingFieldList.get(i).WD_Target_Field__c);
                             String sourceField = String.ValueOf(mappingFieldList.get(i).Source_Field__c);                       
                             workDet.put(targetField,tmRec.get(sourceField));                                        
                          }
                        
                        wdUpdateMap.put(wD.id,workDet);
                    }
                }
                if(!wdUpdateMap.IsEmpty()){
                    system.debug('wdUpdateMap'+ wdUpdateMap );
                    Database.SaveResult[] processedWDList = Database.update(wdUpdateMap.values(), false);
                    for(Database.SaveResult wdSR:processedWDList){
                        if (wdSR.isSuccess()) {
                            wdSucessSet.add(wdSR.getId());
                        }
                    }
                }
                if(wdSucessSet.Size() < wdUpdateMap.Size()){
                    tmRec.GE_OG_Processed__c = false;
                    for(id wdId: wdUpdateMap.Keyset()){
                        if(!wdSucessSet.contains(wdId)){
                            FailedWorkDetail = FailedWorkDetail + wdUpdateMap.get(wdId).Name + ',';
                        }
                    }
                    if(FailedWorkDetail != Null)
                        ErrorMessage = ErrorMessage + ' Failed WorkDetail(s):' + FailedWorkDetail.removeEnd(',');
                }
            }
            if(ErrorMessage != Null)
                tmRec.GE_OG_Error_Message__c = ErrorMessage;
            Database.SaveResult tmSR = Database.update(tmRec);
            if (!tmSR.isSuccess()) {
                system.debug('Tools Management record updation failed');
            }
        }
    }
    global void finish(Database.BatchableContext BC) { 
        GE_OG_FSProjectRetryBatch woBatch= new GE_OG_FSProjectRetryBatch(); 
        database.executeBatch(woBatch, 20); 
    }
}