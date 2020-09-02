/*
=======================================================================================================================================
Name       : GE_OG_SAP_OutboundWrapper 
Author     : Abhijeet Mitra
Created On : 16th Oct 2015
Purpose    : SMax-SAP Service Order integration
======================================================================================================================================
*/
public class GE_OG_SAP_OutboundWrapper{

    //AL related sub class variables//
    GE_OG_SAP_AL_WOPublish.HTTP_Port processRequest_x = new GE_OG_SAP_AL_WOPublish.HTTP_Port();
    GE_OG_SAP_AL_WOPublish.DT_ServiceOrder_Resp processResponse_x = new GE_OG_SAP_AL_WOPublish.DT_ServiceOrder_Resp();
    GE_OG_SAP_AL_WOPublish.Response_element resMessage_x = new GE_OG_SAP_AL_WOPublish.Response_element();
    GE_OG_SAP_AL_WOPublish.Operation_element workDetail_x = new GE_OG_SAP_AL_WOPublish.Operation_element();
    GE_OG_SAP_AL_WOPublish.Header_element workOrder_x = new GE_OG_SAP_AL_WOPublish.Header_element();
    GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element bundle_x = new GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element();
    GE_OG_SAP_OutboundWrapper.Universal_Response result= new GE_OG_SAP_OutboundWrapper.Universal_Response();

    //AL related list variables//
    List<GE_OG_SAP_AL_WOPublish.Operation_element> workDetail_xItem = new List<GE_OG_SAP_AL_WOPublish.Operation_element>();
    List<GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element> bundle_xItem = new List<GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element>();
    List<GE_OG_SAP_AL_WOPublish.OrderStatus_element> orderStatus_xItem = new List<GE_OG_SAP_AL_WOPublish.OrderStatus_element>();
    List <SVMXC__Service_Order__c> ALWoList = new List <SVMXC__Service_Order__c>();
    List<GE_OG_SAP_OutboundWrapper.Universal_Response> resultList = new List<GE_OG_SAP_OutboundWrapper.Universal_Response>();

    public GE_OG_SAP_OutboundWrapper(){
    }

    public class Universal_Response{
        public String Status;
        public String ErrorMsg;
        public String SMAX_OrderID;
    }

    //Method invoked by OutboundIntegration class//
    public List<GE_OG_SAP_OutboundWrapper.Universal_Response> submitToSAP(List <String> woIdList,  String AccessToken){

        //Fetching all the Work Order records
        
        //List <SVMXC__Service_Order__c> objWoList=[SELECT Id, Name, GE_OG_Service_Order__c, RecordType.DeveloperName, GE_Rig_ID__c, SVMXC__Billing_Type__c, GE_PC_Branch__c, SVMXC__Problem_Description__c, SVMXC__Order_Type__c, GE_OG_Bill_to_Account_Number__c, Well_Type__c, GE_OG_Work_Center__c, GE_OG_Sold_to_Party__c, GE_OG_AL_Ship_to_Account_Number__c from SVMXC__Service_Order__c WHERE Id IN: woIdList];
          List <SVMXC__Service_Order__c> objWoList=[SELECT Id, Name, GE_OG_Service_Order__c, RecordType.DeveloperName, GE_Rig_ID__c, SVMXC__Billing_Type__c, GE_PC_Branch__c, SVMXC__Problem_Description__c, SVMXC__Order_Type__c, GE_OG_Bill_to_Account_Number__c, Well_Type__c, GE_OG_AL_Work_Center__c, GE_OG_Sold_to_Party__c, GE_OG_AL_Ship_to_Account_Number__c from SVMXC__Service_Order__c WHERE Id IN: woIdList];
          
        //Fetching all the related Work Detail records
        List<SVMXC__Service_Order_Line__c> objWdList = [SELECT id, Name, SVMXC__Work_Description__c, GE_DS_Total_Time__c, GE_AL_Part_Number__c, SVMXC__Billable_Quantity__c, SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c, SVMXC__Activity_Type__c, SVMXC__Line_Type__c, SVMXC__Service_Order__c, SVMXC__Start_Date_and_Time__c, SVMXC__End_Date_and_Time__c FROM SVMXC__Service_Order_Line__c WHERE SVMXC__Service_Order__c IN: woIdList];

        //Loop to make separate lists for each P&L
        for(SVMXC__Service_Order__c objWo:objWoList){
            if (objWo.RecordType.DeveloperName == 'GE_OG_AL'){
                ALWoList.add(objWo);
            }
        }

        //Processing for AL records
        if (ALWoList.size()>0){
            Map<string,string> inputHeader=new Map<string,string>();
            inputHeader.put('Authorization',AccessToken); 
            processRequest_x.inputHttpHeaders_x = inputHeader;
            System.debug('The Input Header: ' +processRequest_x.inputHttpHeaders_x);
            processRequest_x.timeout_x = GE_OG_SAP_IntegrationUtility.AL_SOA_TIMEOUT;
            processRequest_x.endpoint_x = GE_OG_SAP_IntegrationUtility.getEndpointBaseSOA(GE_OG_SAP_IntegrationUtility.AL_ENVIRON);
            //Calling Work Order method for each Work Order
            for (SVMXC__Service_Order__c ALobjWo:ALWoList){
                bundle_x = retrieveWorkOrdersAL(ALobjWo, objWdList);
                bundle_xItem.add(bundle_x);
            }
            System.debug('The final bundle: ' +bundle_xItem);
            
            processResponse_x.Response = processRequest_x.SI_CreateServiceOrder_Out(bundle_xItem);
            resMessage_x = processResponse_x.Response;
            System.debug('Response 1 -->'+resMessage_x);
            orderStatus_xItem = resMessage_x.OrderStatus;
            System.debug('Response 2 -->'+orderStatus_xItem);
            resultList = updateALSapID(orderStatus_xItem);
        }
        return resultList;
    }

        //Updating the SAP order Id for list of successfully inserted records
    public List<GE_OG_SAP_OutboundWrapper.Universal_Response> updateALSapID(List<GE_OG_SAP_AL_WOPublish.OrderStatus_element> orderStatus_List){
        Integer i,j;
        List <String> SMAX_OrderIDList = new List <String>();
        for (i=0;i<orderStatus_List.size();i++){
            if(orderStatus_List[i].Status=='S' && orderStatus_List[i].SMAX_OrderID != '' && orderStatus_List[i].SMAX_OrderID != null){
                SMAX_OrderIDList.add(orderStatus_List[i].SMAX_OrderID);
                System.debug('Order Status Resp: '+orderStatus_List[i].SMAX_OrderID);
            }
        }
        System.debug('Order Id List'+SMAX_OrderIDList);
        List<SVMXC__Service_Order__c> queriedWOList = [SELECT Id, Name, GE_OG_Service_Order__c FROM SVMXC__Service_Order__c WHERE Name IN: SMAX_OrderIDList];
        System.debug('Response 3 -->'+queriedWOList);
        for (i=0;i<orderStatus_List.size();i++){
            for (j=0;j<queriedWOList.size();j++){
                if(queriedWOList[j].Name == orderStatus_List[i].SMAX_OrderID){
                    System.debug('Queried WO: '+queriedWOList[j].Name+' and Order ID Queried: '+orderStatus_List[i].SMAX_OrderID);
                    queriedWOList[j].GE_OG_Service_Order__c = orderStatus_List[i].SAP_OrderID;
                    System.debug('Updated field: '+queriedWOList[j].GE_OG_Service_Order__c);
                    update queriedWOList[j];
                    //break;
                }
            }
            result.Status=orderStatus_List[i].Status;
            result.ErrorMsg=orderStatus_List[i].ErrorMsg;
            result.SMAX_OrderID=orderStatus_List[i].SMAX_OrderID;
            resultList.add(result);
        }
        return resultList;
    }

        //Method to get work orders for AL//

    private GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element retrieveWorkOrdersAL(SVMXC__Service_Order__c ALobjWo, List<SVMXC__Service_Order_Line__c> objWdList){

        GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element ALbundle = new GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element();

        //----------------------------------//
        //  Work Order Information for AL   //
        //----------------------------------//

        workOrder_x.OrderType=ALobjWo.SVMXC__Billing_Type__c;                   //Billing Type
        workOrder_x.FunctionalLocation=ALobjWo.GE_Rig_ID__c;                    //Rig Id
        workOrder_x.OrderID=ALobjWo.Name;                                       //WorkOrder Number
        workOrder_x.SAP_OrderID=ALobjWo.GE_OG_Service_Order__c;                 //Sap Service Order Number
        workOrder_x.PlanningPlant=ALobjWo.GE_PC_Branch__c;                      //Planning Plant
        workOrder_x.OrderDescription=ALobjWo.SVMXC__Problem_Description__c;     //Problem description
        workOrder_x.PMActivityType=ALobjWo.SVMXC__Order_Type__c;                //Order Type
        workOrder_x.BillToParty=ALobjWo.GE_OG_Bill_to_Account_Number__c;        //Bill to Account Number
        workOrder_x.ServiceProduct=ALobjWo.Well_Type__c;                        //Well Type
        workOrder_x.WorkCenter=ALobjWo.GE_OG_AL_Work_Center__c;                 //Work center
        workOrder_x.SoldToParty=ALobjWo.GE_OG_Sold_to_Party__c;                 //Sold to Party
        workOrder_x.ShipToParty=ALobjWo.GE_OG_AL_Ship_to_Account_Number__c;     //Ship to Address

        System.debug('Billing Type: '+workOrder_x.OrderType +'\t Service Order Number: '+workOrder_x.SAP_OrderID +'\t WorkOrder Number: '+workOrder_x.OrderID +'\t Planning Plant: '+workOrder_x.PlanningPlant +'\t Problem description: '+workOrder_x.OrderDescription +'\t Order Type: '+workOrder_x.PMActivityType +'\t Bill to Account Number: '+workOrder_x.BillToParty +'\t Well Type: '+workOrder_x.ServiceProduct +'\t Work center: '+workOrder_x.WorkCenter +'\t Sold to Party: '+workOrder_x.SoldToParty +'\t Ship to Address: '+workOrder_x.ShipToParty);

        ALbundle.Header = workOrder_x;

        //Calling Work Deatil method for each Work Detail
        for(SVMXC__Service_Order_Line__c wd :objWdList){
            if(wd.SVMXC__Service_Order__c == ALobjWo.Id){
                workdetail_x=retrieveWorkDetailsAL(wd);
                workDetail_xItem.add(workdetail_x);
            }
        }

        System.debug('WORK DETAIL SIZE-->'+workdetail_xItem.size());
        System.debug('Work Detail: '+workDetail_xItem);

        ALbundle.Operation = workDetail_xItem;

/*      //Get Attachment
        String FsoTypeAttach='%'+woId+'%';
        List<Attachment> fsoattach=[SELECT Id, Name, ContentType, Body FROM Attachment WHERE ParentId=:woId AND Name LIKE :FsoTypeAttach Order By CreatedDate DESC Limit 1];
        if(fsoattach.size()>0){
            System.debug('Attachement--> Name: '+fsoattach[0].Name);
            workOrder_x.AttachmentFileName=fsoattach[0].Name;
            String pdfBody = EncodingUtil.base64Encode(fsoattach[0].Body);
            details_x.Attachment=pdfBody;
        }*/

        return ALbundle;
    }

        //Method to bind work detail for AL//

    private GE_OG_SAP_AL_WOPublish.Operation_element retrieveWorkDetailsAL(SVMXC__Service_Order_Line__c wd){
        
        GE_OG_SAP_AL_WOPublish.Operation_element workdetail_x1 = new GE_OG_SAP_AL_WOPublish.Operation_element();

        //----------------------------------//
        //  Work Deatil Information for AL  //
        //----------------------------------//
        try{
        workdetail_x1.ItemNum=wd.Name;                                               //Work Detail Number
        workdetail_x1.LineType=wd.SVMXC__Line_Type__c;                               //Work Detail Line Type
        workdetail_x1.StartDate=wd.SVMXC__Start_Date_and_Time__c;                    //Start Date Time
        workdetail_x1.EndDate=wd.SVMXC__End_Date_and_Time__c;                        //End Date Timme 
        workdetail_x1.OperationDescription=wd.SVMXC__Work_Description__c;            //Work Description
        if(wd.GE_DS_Total_Time__c==null || wd.GE_DS_Total_Time__c.format()==''){     //Total Time
            workdetail_x1.WorkHours='0';
        }
        else{
            workdetail_x1.WorkHours=wd.GE_DS_Total_Time__c.format();
        }
        workdetail_x1.MaterialNumber=wd.GE_AL_Part_Number__c;                        //Part Number
        workdetail_x1.Quantity=wd.SVMXC__Billable_Quantity__c.format();              //Billable Quantity       


        
        System.debug('Item Num: '+workdetail_x1.ItemNum+'\t Line Type: '+workdetail_x1.LineType+'\t Start Date: '+workdetail_x1.StartDate+'\t End Date: '+workdetail_x1.EndDate+'\t Op Desc: '+workdetail_x1.OperationDescription+'\t Total Hours: '+workdetail_x1.WorkHours+'\t Mat Number: '+workdetail_x1.MaterialNumber+'\t Quantity: '+workdetail_x1.Quantity+'\t SSO: '+workdetail_x1.TechnicianSSO); 
             
        }
        catch(Exception e){
            System.debug('Exception :'+e.getMessage());
        }
        return workdetail_x1;
    }
}