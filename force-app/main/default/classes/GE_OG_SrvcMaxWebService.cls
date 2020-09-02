global with sharing class GE_OG_SrvcMaxWebService {

    public static Map<String, Schema.RecordTypeInfo> RecTypes{get;set;}
    private static User SMAXUser = [Select Id from User Where Username like '%ogintegrationsmax%' Limit 1];
    public static Map<String,ID> Accountnumbers = New Map<String,ID>();
    private static User us = [select id from user where GE_HQ_SSO_ID__c = '502232984' limit 1]; 
    /*
    Global Webservice to insert the workorder details sent from the legacy system 
    Input : List of workorder from the legacy system 
    Return : List of results for each Workorder info record .
    */
    WebService static List<WorkOrderResult> InsertWorkorder (List<WorkOrder_Info> WorkorderInfo){
    
    List<WorkOrderResult> lstWorkOrderResult = new List<WorkOrderResult>();
    List<WorkOrderResult> duplicateResults = new List<WorkOrderResult>();
    WorkOrderResult wResult ;
    //List<WorkOrderResult> wr=new List<WorkOrderResult>();
    //Set<SVMXC__Service_Order__c> Failedwr=new Set<SVMXC__Service_Order__c>();
    Map<String, WorkOrderResult> wr= new Map<String, WorkOrderResult>();
    Map<String, SVMXC__Service_Order__c> Failedwr= new Map<String, SVMXC__Service_Order__c>();
    Map<String, Account> MapAccounts = New Map<String, Account>();
    Map<String, GE_Installed_Base__c> MapInstalledBases = New Map<String, GE_Installed_Base__c>();
    Map<String, User> MapOwners = New Map<String, User>();
    List<WorkOrderResult> Failedwr1=new List<WorkOrderResult>();
    List<String> ListDunsNumbers = New List<String>();
    List<String> ListInstalledBaseNumbers = New List<String>();
    List<String> ListOwnerNames = New List<String>();   
        //List<String> ListCase = new List<String>();
    List<String> ERPProjectNumberList=new List<String>();
    List<String> NetworkNumberList=new List<String>();
    List<SVMXC__Service_Order__c> DuplicateWO=new List<SVMXC__Service_Order__c>();
    List<SVMXC__Service_Order__c> UpdateWOlist=new List<SVMXC__Service_Order__c>();
    List<Account> DunsNotMatching=new List<Account>(); 
        
        
        for(WorkOrder_Info w : WorkorderInfo) {
            if(w.DUNS_Number!=null){
            ListDunsNumbers.add(w.DUNS_Number);
            ListDunsNumbers.add(w.Bill_To);
            ListDunsNumbers.add(w.Sold_To);
            }
            
            if(w.InstalledBase_SerialNo!=null){
            ListInstalledBaseNumbers.add(w.InstalledBase_SerialNo);
            }
            if(w.OwnerName!=null){
            ListOwnerNames.add(w.OwnerName);
            }
            if(w.ERP_Project_Number!=null){
            ERPProjectNumberList.add(w.ERP_Project_Number);
            }
            if(w.NetworkNumber!=null){
            NetworkNumberList.add(w.NetworkNumber);
            }
            //ListCase.add(w.CaseNumber);
           //  ListServiceRequestOwnerName.add(C.ServiceRequestOwnerName);
        } 
        if(NetworkNumberList.size()>0 && ERPProjectNumberList.size()>0){ 
              
            DuplicateWO=[Select Id,Name,GE_SM_OG_MC_Network_Number__c,GE_OG_MC_ERP_Project_Number__c,SVMXC__Order_Status__c from SVMXC__Service_Order__c where GE_SM_OG_MC_Network_Number__c IN :NetworkNumberList and GE_OG_MC_ERP_Project_Number__c IN :ERPProjectNumberList];
        }
        //DunsNotMatching.add([Select Id,Name, GE_HQ_DUNS_Number__c From Account Where GE_HQ_DUNS_Number__c NOT in :ListDunsNumbers and GE_HQ_DUNS_Number__c != NULL and id=Null]);
        
        System.debug('-------DuplicateWO------'+DuplicateWO.size());
        System.debug('--- List Of Duns Numbers ---' + ListDunsNumbers);
        System.debug('--- List Of Installed Base Numbers ---' + ListInstalledBaseNumbers);
        System.debug('--- List Of Owner Names ---' + ListOwnerNames);
        //system.debug('--- List of Case Name ---'+ListCase);
        System.debug('--- List Of Duns Numbers ---' + ListDunsNumbers.size());
        System.debug('--- List Of Installed Base Numbers ---' + ListInstalledBaseNumbers.size());
        System.debug('--- List Of Owner Names ---' + ListOwnerNames.size());

      
        
       // Get the Accounts in a Map         
       for(Account Acc : [Select Id, GE_HQ_DUNS_Number__c,Name From Account Where GE_HQ_DUNS_Number__c in :ListDunsNumbers and GE_HQ_DUNS_Number__c != NULL]) {
           MapAccounts.put(Acc.GE_HQ_DUNS_Number__c, Acc);
           Accountnumbers.put(Acc.GE_HQ_DUNS_Number__c, Acc.ID);
           
       }
       System.debug('--- Accounts Map ---' + MapAccounts);
        
       // Get Installed Base details in to Map
       for(GE_Installed_Base__c IB : [Select Id, Name From GE_Installed_Base__c Where Name in :ListInstalledBaseNumbers]) {
           MapInstalledBases.put(IB.Name, IB);
       }
        
       System.debug('--- Installed Base Map ---' + MapInstalledBases);
        
       // Get Owner details into Map
       for(User U : [Select Id, Name From User Where Name in :ListOwnerNames]) {
           MapOwners.put(U.Name, U);
       }        
       // Get Service Request Owner details into Map
        
       List<SVMXC__Service_Order__c> lstWorkOrders = New List<SVMXC__Service_Order__c>();
       if(WorkorderInfo.size()>0 && DuplicateWO.size()>0){
           for(integer so=0;so<DuplicateWO.size();so++){
               for(integer w=0; w<WorkorderInfo.size();w++){
                   if(WorkorderInfo[w].NetworkNumber==DuplicateWO[so].GE_SM_OG_MC_Network_Number__c&&WorkorderInfo[w].ERP_Project_Number==DuplicateWO[so].GE_OG_MC_ERP_Project_Number__c){
                       //DuplicateWO.SVMXC__Order_Status__c = 'Closed';
                   DuplicateWO[so].SVMXC__Order_Status__c = WorkorderInfo[w].Order_Status;
                   DuplicateWO[so].SVMXC__Closed_By__c = us.id;
                       UpdateWOlist.add(DuplicateWO[so]);
                       WorkorderInfo.remove(w);
                       WResult = New WorkOrderResult();
                       System.debug('FailedlstWorkOrders.GE_SM_OG_MC_Network_Number__c'+WResult);
                       WResult.Severity = 'Info';
                       WResult.Status = 'Success';
                       WResult.WorkOrderNumber=DuplicateWO[so].Name;
                       WResult.StatusMsg = 'A work order with same Network Number and ERP Project Number is already present in the system, Updated Order Status'; 
                       WResult.SAPNetworkNumber=DuplicateWO[so].GE_SM_OG_MC_Network_Number__c;
                       Wresult.SAPProjectNumber=DuplicateWO[so].GE_OG_MC_ERP_Project_Number__c;
                       WResult.Bool=True;
                       duplicateResults.add(WResult);
                   }
               }
           }
            if(UpdateWOlist.size()>0){
            update UpdateWOlist;
            }
       }       
       for(WorkOrder_Info w : WorkorderInfo){
       
           lstWorkOrders.add(SetWorkOrderInfo(w, New SVMXC__Service_Order__c(),MapAccounts.get(w.DUNS_Number),
           MapInstalledBases.get(w.InstalledBase_SerialNo),MapOwners.get(w.OwnerName),null,MapOwners.get(w.OwnerName) ));
       }
       /*for(WorkOrder_Info w : WorkorderInfo){
           //if(w.DUNS_Number!=Null)
           //w.Additional_Site_Details=w.Additional_Site_Details+'Account:'+MapAccounts.get(w.DUNS_Number).Name;
                   
               if(!DuplicateWO.isEmpty()){
                   for(SVMXC__Service_Order__c so:DuplicateWO.Values()){
                            if(w.NetworkNumber!=so.GE_SM_OG_MC_Network_Number__c&&w.ERP_Project_Number!=so.GE_OG_MC_ERP_Project_Number__c){
    
                                    System.debug('w.NetworkNumber'+w.NetworkNumber+so.GE_SM_OG_MC_Network_Number__c);
                                    System.debug('w.ERP_Project_Number'+w.ERP_Project_Number+so.GE_OG_MC_ERP_Project_Number__c);    
                                    System.debug('--- New WorkOrder ---');
                                    lstWorkOrders.add(SetWorkOrderInfo(w, New SVMXC__Service_Order__c(),MapAccounts.get(w.DUNS_Number),
                                    MapInstalledBases.get(w.InstalledBase_SerialNo),MapOwners.get(w.OwnerName),null,MapOwners.get(w.OwnerName) ));
                            }
                            else{
                                    WResult = New WorkOrderResult();
                                    System.debug('FailedlstWorkOrders.GE_SM_OG_MC_Network_Number__c'+WResult);
                                    WResult.Severity = 'Error';
                                    WResult.Status = 'Failure';
                                    WResult.WorkOrderNumber='No Work Order';
                                    WResult.StatusMsg = 'A work order with same Network Number and ERP Project Number is already present in the system'; 
                                    WResult.SAPNetworkNumber=so.GE_SM_OG_MC_Network_Number__c;
                                    Wresult.SAPProjectNumber=so.GE_OG_MC_ERP_Project_Number__c;
                                    System.debug('else w.NetworkNumber'+w.NetworkNumber+so.GE_SM_OG_MC_Network_Number__c);
                                    System.debug('else w.ERP_Project_Number'+w.ERP_Project_Number+so.GE_OG_MC_ERP_Project_Number__c);    
                                    duplicateResults.add(WResult);
                            }
                    }  
                    }
                    else{
                            System.debug('--- New WorkOrder ---no duplicates');
                            lstWorkOrders.add(SetWorkOrderInfo(w, New SVMXC__Service_Order__c(),MapAccounts.get(w.DUNS_Number),
                            MapInstalledBases.get(w.InstalledBase_SerialNo),MapOwners.get(w.OwnerName),null,MapOwners.get(w.OwnerName) ));
                    }  
                    
        }*/
        
        for(Account a:DunsNotMatching)
        {
            for(SVMXC__Service_Order__c wo:lstWorkOrders){
                System.debug(wo.SVMXC__Company__c);
            }
        }     
        /*if(lstWorkOrders.size()>0&&duplicateResults.size()>0){
            for(integer i=0;i<duplicateResults.size();i++){
            for(integer j=0;j<lstWorkOrders.size();j++){
                if((duplicateResults[i].SAPNetworkNumber==lstWorkOrders[j].GE_SM_OG_MC_Network_Number__c)&&(duplicateResults[i].SAPProjectNumber==lstWorkOrders[j].GE_OG_MC_ERP_Project_Number__c)){
                    lstWorkOrders.remove(j);
                }
            }
            }
        } */  
        if(lstWorkOrders.size()>0){
        
        System.debug('--- WorkOrder Result List ---' + lstWorkOrderResult);
        System.debug('--- WorkOrder List ---' + lstWorkOrders);
        System.debug('--- WorkOrder List ---' + lstWorkOrders.size());
        List<Database.Upsertresult> uResults = Database.upsert(lstWorkOrders, false);
         
        List<String> ListIds = New List<String>();
        for(Database.Upsertresult Res : uResults) {
            ListIds.add(Res.getId());
        }
        
        Map<String, SVMXC__Service_Order__c> MapWKOrders = New Map<String, SVMXC__Service_Order__c>();
        for(SVMXC__Service_Order__c wk : [Select Id,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c, name,SVMXC__Case__c 
                        From SVMXC__Service_Order__c
                        Where Id in :ListIds]) {
            MapWKOrders.put(wk.Id, wk);
        }
         System.debug('uResults'+uResults);
         System.debug('uResults'+uResults.size());
         integer Count=0;
         for(Database.Upsertresult Res : uResults) {
            WResult = New WorkOrderResult();
            if(Res.isSuccess()) {
                system.debug('if');
                WResult = New WorkOrderResult();
                WResult.Severity = 'Info';
                WResult.Status = 'Success';
                WResult.StatusMsg = 'WorkOrder has been Successfully Created';               
                //WResult.CaseNumber = MapWKOrders.get(Res.getId()).SVMXC__Case__c;
                WResult.WorkOrderNumber = MapWKOrders.get(Res.getId()).name ;
                WResult.SAPNetworkNumber=MapWKOrders.get(Res.getId()).GE_SM_OG_MC_Network_Number__c;
                WResult.SAPProjectNumber=MapWKOrders.get(Res.getId()).GE_OG_MC_ERP_Project_Number__c;
                WResult.Bool=True;
                wr.put(WResult.SAPNetworkNumber,WResult);
                lstWorkOrderResult.add(WResult);
                
                     
            }
            
                          
            
         }

                
         for(integer i=0;i<wr.size();i++){
                         for(integer j=0;j<lstWorkOrders.size();j++){
                             if(!wr.containsKey(lstWorkOrders[j].GE_SM_OG_MC_Network_Number__c)){
                                                                  
                                      Failedwr.put(lstWorkOrders[j].GE_SM_OG_MC_Network_Number__c,lstWorkOrders[j]);
                                      
                                 
                             
                         }
                     }
                     
           }
                 
             

         
     
         System.debug('Failedwr'+Failedwr);
         System.debug('Failedwr'+Failedwr.size());
         
         for(SVMXC__Service_Order__c wresul:Failedwr.values()){
             
         
            System.debug('else if');
            WResult = New WorkOrderResult();
            System.debug('FailedlstWorkOrders.GE_SM_OG_MC_Network_Number__c'+WResult);
            WResult.Severity = 'Error';
            WResult.Status = 'Failure';
            WResult.WorkOrderNumber='No Work Order';
            WResult.StatusMsg = 'Enter valid values(check values like email,date details has been entered correctly).'; 
            WResult.SAPNetworkNumber=wresul.GE_SM_OG_MC_Network_Number__c;
            Wresult.SAPProjectNumber=wresul.GE_OG_MC_ERP_Project_Number__c;
            lstWorkOrderResult.add(WResult);
            
                
        
        }
        if(wr.size()==0){
                 for(integer i=0;i<lstWorkOrders.size();i++){
                    system.debug('if size 0');
                    WResult = New WorkOrderResult();                   
                    System.debug('Failed'+lstWorkOrders[i].GE_SM_OG_MC_Network_Number__c);
                    WResult.Severity = 'Error';
                    WResult.Status = 'Failure';
                    WResult.WorkOrderNumber='No Work Order';
                    WResult.SAPNetworkNumber=lstWorkOrders[i].GE_SM_OG_MC_Network_Number__c;
                    Wresult.SAPProjectNumber=lstWorkOrders[i].GE_OG_MC_ERP_Project_Number__c;
                    WResult.StatusMsg = 'Enter valid values(check values like email,date details has been entered correctly).'; 
                    lstWorkOrderResult.add(WResult);
                 }
            }
        System.debug('---Debug Results---' + WResult);
        System.debug('---Return Result List---' + lstWorkOrderResult);
               
        
        }
        lstWorkOrderResult.addall(duplicateResults);
        Return lstWorkOrderResult;
        }
        
        
      
    
    
    /*
    Private Method to set the each record of the Work Order
    Input:  Work Order Info - Input Work Order Details, New Work Order record to set the input Work Order details
    Return: Work Order Record with all the details set.
    */
    public static SVMXC__Service_Order__c SetWorkOrderInfo(WorkOrder_Info WorkOrderInfo, SVMXC__Service_Order__c UpsertWorkOrderInfo,
                                                            Account AccountRecord, GE_Installed_Base__c InstalledBaseRecord,
                                                            User WorkOrderOwner, User WorkOrderClosedOwner, User SAPUser) {
        Datetime dt;
        
        //List<Group> grp=[Select id,name from Group where Type='Queue'];  
        if(AccountRecord != Null)
            UpsertWorkOrderInfo.SVMXC__Company__c = AccountRecord.Id;
                
        //if(InstalledBaseRecord != Null)
        //UpsertWorkOrderInfo.GE_SM_HQ_Installed_Base__c = InstalledBaseRecord.Id;
        
        UpsertWorkOrderInfo.GE_SM_OG_MC_Network_Number__c = WorkOrderInfo.NetworkNumber;
        
        UpsertWorkOrderInfo.GE_OG_MC_Subject__c=WorkOrderInfo.Subject;
        
        UpsertWorkOrderInfo.GE_OG_MC_ERP_Project_Number__c=WorkOrderInfo.ERP_Project_Number;
        
        //UpsertWorkOrderInfo.GE_SM_OG_MC_Network_Number__c=WorkOrderInfo.SAP_Network_Number;
        UpsertWorkOrderInfo.GE_OG_MC_Additional_Site_Details__c=WorkOrderInfo.Additional_Site_Details;
               
        UpsertWorkOrderInfo.GE_OG_MC_Serial_Nmber__c=WorkOrderInfo.Serial_Nmber;
        
        UpsertWorkOrderInfo.GE_OG_MC_Additional_Project_Details__c=WorkOrderInfo.Additional_Project_Details;
        
        UpsertWorkOrderInfo.GE_OG_MC_ConName__c=WorkOrderInfo.Contact_Name;
        
        UpsertWorkOrderInfo.GE_OG_MC_Con_Phone__c=WorkOrderInfo.Contact_Phone;
        
        UpsertWorkOrderInfo.GE_OG_MC_Con_Email__c=WorkOrderInfo.Contact_Email;
        
        UpsertWorkOrderInfo.GE_OG_MC_Additional_PPE__c=WorkOrderInfo.Additional_PPE;
        
        UpsertWorkOrderInfo.GE_OG_MC_Customer_training__c=WorkOrderInfo.Customer_training;
        
        UpsertWorkOrderInfo.GE_OG_MC_Site_Entry_Req__c=WorkOrderInfo.Site_Entry_Requirements;
        
        UpsertWorkOrderInfo.GE_OG_SM_Directions__c=WorkOrderInfo.Directions_to_Plant;
        
        //UpsertWorkOrderInfo.GE_OG_MC_Business_Unit__c=WorkOrderInfo.Business_Unit;
        
        UpsertWorkOrderInfo.Type__c=WorkOrderInfo.Type;
        
        //UpsertWorkOrderInfo.GE_SM_HQ_Installed_Base__c=WorkOrderInfo.Equipment_type;
        
        UpsertWorkOrderInfo.GE_OG_MC_Service_Region__c=WorkOrderInfo.Service_Region;
        
        UpsertWorkOrderInfo.GE_OG_MC_Person_Responsible__c=WorkOrderInfo.Person_Responsible;
               
        
        /*if(WorkOrderInfo.Scheduled_Start_Date != Null && WorkOrderInfo.Scheduled_Start_Date != '') {
            Datetime SchStartDate= DateTime.valueOfGMT(WorkOrderInfo.Scheduled_Start_Date);
            if(SchStartDate.year()<2000){
            UpsertWorkOrderInfo.GE_SM_HQ_Scheduled_Start_Date_Time__c=null;
            }else{
            UpsertWorkOrderInfo.GE_SM_HQ_Scheduled_Start_Date_Time__c = Datetime.valueOfGMT(WorkOrderInfo.Scheduled_Start_Date);
            }
        } else if(WorkOrderInfo.Planned_Start_Date != Null && WorkOrderInfo.Planned_Start_Date != '') {
            Datetime PlanStartDate= DateTime.valueOfGMT(WorkOrderInfo.Planned_Start_Date);
            if(PlanStartDate.year()<2000){
            UpsertWorkOrderInfo.GE_SM_HQ_Scheduled_Start_Date_Time__c=null;
            }else{
            UpsertWorkOrderInfo.GE_SM_HQ_Scheduled_Start_Date_Time__c = Datetime.valueOfGMT(WorkOrderInfo.Planned_Start_Date);
            }
        }*/
        if(WorkOrderInfo.AssignByDate!= Null && WorkOrderInfo.AssignByDate!= ''){
            Datetime AssByDate= DateTime.valueOfGMT(WorkOrderInfo.AssignByDate);
            if(AssByDate.year()<2000){
            UpsertWorkOrderInfo.GE_SM_HQ_Assign_By__c=null;
            }else{
            UpsertWorkOrderInfo.GE_SM_HQ_Assign_By__c = Datetime.valueOfGMT(WorkOrderInfo.AssignByDate);
            }
        }    
        if(WorkOrderInfo.Planned_Start_Date != Null && WorkOrderInfo.Planned_Start_Date != ''){
            Datetime PlannStartDate= DateTime.valueOfGMT(WorkOrderInfo.Planned_Start_Date);
            if(PlannStartDate.year()<2000){
            UpsertWorkOrderInfo.GE_SM_HQ_Planned_Start_Date__c=null;
            }else{
            UpsertWorkOrderInfo.GE_SM_HQ_Planned_Start_Date__c = Datetime.valueOfGMT(WorkOrderInfo.Planned_Start_Date);
            }
        }    

        if(WorkOrderInfo.Planned_End_Date != Null && WorkOrderInfo.Planned_End_Date != ''){
            Datetime PlanEndDate= DateTime.valueOfGMT(WorkOrderInfo.Planned_End_Date);
            if(PlanEndDate.year()<2000){
            UpsertWorkOrderInfo.GE_SM_HQ_Planned_End_Date__c=null;
            }else{
            UpsertWorkOrderInfo.GE_SM_HQ_Planned_End_Date__c = Datetime.valueOfGMT(WorkOrderInfo.Planned_End_Date);
            }
        }

        
        /*if(WorkOrderInfo.Scheduled_End_Date != Null && WorkOrderInfo.Scheduled_End_Date != '') {
            Datetime SchdEndDate= DateTime.valueOfGMT(WorkOrderInfo.Scheduled_End_Date);
            if(SchdEndDate.year()<2000){
            UpsertWorkOrderInfo.GE_SM_HQ_Scheduled_End_Date_Time__c=null;
            }else{
            UpsertWorkOrderInfo.GE_SM_HQ_Scheduled_End_Date_Time__c = Datetime.valueOfGMT(WorkOrderInfo.Scheduled_End_Date);
            }
            
        } else if(WorkOrderInfo.Planned_End_Date != Null && WorkOrderInfo.Planned_End_Date != '') {
            Datetime PlaEndDate= DateTime.valueOf(WorkOrderInfo.Planned_End_Date);
            if(PlaEndDate.year()<2000){
            UpsertWorkOrderInfo.GE_SM_HQ_Scheduled_End_Date_Time__c=null;
            }else{
            UpsertWorkOrderInfo.GE_SM_HQ_Scheduled_End_Date_Time__c = Datetime.valueOfGMT(WorkOrderInfo.Planned_End_Date);
            }
            
        }*/

        if(WorkOrderInfo.Actual_Start_Date != Null && WorkOrderInfo.Actual_Start_Date != ''){
            Datetime ActualStartDate= DateTime.valueOfGMT(WorkOrderInfo.Actual_Start_Date);
            if(ActualStartDate.year()<2000){
            UpsertWorkOrderInfo.GE_SM_HQ_Actual_Start_Date__c=null;
            }else{
            UpsertWorkOrderInfo.GE_SM_HQ_Actual_Start_Date__c = DateTime.valueOfGMT(WorkOrderInfo.Actual_Start_Date);
            }
        }    

        if(WorkOrderInfo.Actual_End_Date != Null && WorkOrderInfo.Actual_End_Date != ''){
            Datetime ActualEndDate= DateTime.valueOfGMT(WorkOrderInfo.Actual_End_Date);
            if(ActualEndDate.year()<2000){
            UpsertWorkOrderInfo.GE_SM_HQ_Actual_End_Date__c=null;
            }else{
            UpsertWorkOrderInfo.GE_SM_HQ_Actual_End_Date__c = DateTime.valueOfGMT(WorkOrderInfo.Actual_End_Date);        
            }
        }    
            
        UpsertWorkOrderInfo.GE_SM_HQ_Task_Description__c = WorkOrderInfo.Task_Description;    
        
            
        if(WorkOrderInfo.Closed_On!= Null && WorkOrderInfo.Closed_On!= '')
            UpsertWorkOrderInfo.SVMXC__Closed_On__c = Datetime.valueOfGMT(WorkOrderInfo.Closed_On);
           
        if(WorkOrderClosedOwner != Null) 
            UpsertWorkOrderInfo.SVMXC__Closed_By__c = WorkOrderClosedOwner.Id; 
        
        /*if(WorkOrderInfo.Source_System == 'SAP') {
            UpsertWorkOrderInfo.OwnerId = SAPUser.Id;
        } else if(WorkOrderOwner != Null) {
            UpsertWorkOrderInfo.OwnerId = WorkOrderOwner.Id;
        }*/ /*else if(WorkOrderQueue != Null) {
            UpsertWorkOrderInfo.OwnerId = WorkOrderQueue.QueueId;
        }*/
        
        UpsertWorkOrderInfo.GE_SM_HQ_Ship_to_Address__c = WorkOrderInfo.ShipToAddress;
        UpsertWorkOrderInfo.RecordTypeId = getRecordType('SVMXC__Service_Order__c', WorkOrderInfo.Source_System);
        //UpsertWorkOrderInfo.RecordTypeId = '012A0000000k6Fu';
        
        //Additional fields
        UpsertWorkOrderInfo.GE_OG_GS_P_L__c = WorkOrderInfo.Business_Unit;
        UpsertWorkOrderInfo.GE_DS_Country_WkPerformed__c = WorkOrderInfo.Country;
        UpsertWorkOrderInfo.GE_SS_Customer_PO_number__c = WorkOrderInfo.Customer_PO;
        //UpsertWorkOrderInfo.GE_DS_Daily_Rate__c = WorkOrderInfo.Case_Amount;
        //UpsertWorkOrderInfo.CurrencyIsoCode = WorkOrderInfo.Case_Currency;
        UpsertWorkOrderInfo.GE_SS_Sales_Order__c = WorkOrderInfo.Sales_Order;
        //UpsertWorkOrderInfo.GE_DS_Overtime__c = WorkOrderInfo.Service_Rate;
        //UpsertWorkOrderInfo.GE_DS_Service_Discount__c = WorkOrderInfo.Service_Discount;
        UpsertWorkOrderInfo.GE_DS_SAP_WBS_Element_Number__c = WorkOrderInfo.WBS_Element_Number;
        UpsertWorkOrderInfo.GE_DS_Product_Line_Code__c = WorkOrderInfo.Product_Line_Code;
        //UpsertWorkOrderInfo.GE_DS_Project_Manager__c = WorkOrderInfo.Project_Manager;
        UpsertWorkOrderInfo.SVMXC__Country__c = WorkOrderInfo.Workorder_Country;
        if(WorkOrderInfo.Bill_To != Null){
        UpsertWorkOrderInfo.GE_DS_Bill_To__c = Accountnumbers.get(WorkOrderInfo.Bill_To);
        }
         if(WorkOrderInfo.Sold_To != Null){
        UpsertWorkOrderInfo.BHGE_OFS_Sold_To__c = Accountnumbers.get(WorkOrderInfo.Sold_To);
        }
        UpsertWorkOrderInfo.GE_DS_Project_Manager__c = WorkOrderInfo.Person_Responsible;
        
        Return UpsertWorkOrderInfo;
    }
    public static String getRecordType(String ObjApi, String SourceSystem) {
        Map<String, Schema.SObjectType> GlobalObjects = Schema.getGlobalDescribe(); 
        if(RecTypes==null)
        {
            RecTypes=GlobalObjects.get(ObjApi).getDescribe().getRecordTypeInfosByName();
            system.debug('inside if');
            
            system.debug(RecTypes);
        }
        
        String strKey='';
        /*if(ObjApi == 'Case') {
            if(SourceSystem.toUpperCase() == 'SAP') {
                strKey = 'FS-MCS';
            }
        }*/
        if (ObjApi == 'SVMXC__Service_Order__c') {
            if(SourceSystem.toUpperCase() == 'SAP') {
                strKey = 'MCS';
            system.debug(strKey);
            }
        }
        system.debug(strKey);
        System.debug((RecTypes.get(strKey)).getName());
        Return (RecTypes.get(strKey)).getRecordTypeId();
    }

    

    // Classes for defining the input variables for WebService
    
    
    global class WorkOrder_Info {
        WebService String Source_System;
        //WebService String CaseNumber;
        WebService String WorkOrderNumber;
        //WebService String SAP_Project_Number;
        WebService String NetworkNumber;
        WebService String AssignByDate;
        WebService String Planned_Start_Date;
        WebService String Planned_End_Date;
        WebService String Scheduled_Start_Date;
        WebService String Scheduled_End_Date;
        WebService String Actual_Start_Date;
        WebService String Actual_End_Date;
        WebService String Task_Description;
        WebService String Closed_By;
        WebService String Closed_On;
        WebService String OwnerSSOId;
        WebService String OwnerName;
        WebService String DUNS_Number;
        WebService String InstalledBase_SerialNo;
        WebService String ShipToAddress; 
        WebService String Subject;               //added By Somanath
        Webservice String ERP_Project_Number;
        //Webservice String SAP_Network_Number;
        Webservice String Additional_Site_Details;
        Webservice String Serial_Nmber;
        Webservice String Additional_Project_Details;
        Webservice String Contact_Name;
        Webservice String Contact_Phone;
        Webservice String Contact_Email;
        Webservice String Additional_PPE;
        Webservice String Customer_training;
        Webservice String Site_Entry_Requirements;
        Webservice String Directions_to_Plant;
        Webservice String Business_Unit;
        Webservice String Type;
        Webservice String Equipment_type;
        Webservice String Service_Region;
        Webservice String Person_Responsible;
        //Additional fields
        //Webservice String Tier3;
        Webservice String Country;
        Webservice String Customer_PO;
        //Webservice Decimal Case_Amount;
        //Webservice String Case_Currency;
        Webservice String Sales_Order;
        //Webservice Decimal Service_Rate;
        //Webservice Decimal Service_Discount;
        Webservice String WBS_Element_Number;
        Webservice String Product_Line_Code;
        //Webservice String Project_Manager;
        Webservice String Bill_To;
        Webservice String Sold_To;
        Webservice String Order_Status;
        Webservice String Workorder_Country;
    
    }
    
        
    global class WorkOrderResult {
        WebService String Severity;
        WebService String Status;
        WebService String StatusMsg;
        WebService String SAPNetworkNumber;
        WebService String WorkOrderNumber;
        Webservice String SAPProjectNumber;
        //WebService String CaseNumber;
        Boolean Bool=false;
    }

}