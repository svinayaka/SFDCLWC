/*
=======================================================================================================================================
Name       : TEST_GE_OG_SAP_AL_WOPublish 
Author     : Abhijeet Mitra
Created On : 22nd Dec 2015
Purpose    : To calculate code coverage for "GE_OG_SAP_AL_WOPublish"  Apex class
======================================================================================================================================
*/
@isTest
public class TEST_GE_OG_SAP_AL_WOPublish{
    static testMethod void GE_OG_SAP_AL_WOPublish(){
        test.startTest();
        try{
            GE_OG_SAP_AL_WOPublish.HTTP_Port processRequest_x = new GE_OG_SAP_AL_WOPublish.HTTP_Port();
            GE_OG_SAP_AL_WOPublish.DT_ServiceOrder serviceOrder_x = new GE_OG_SAP_AL_WOPublish.DT_ServiceOrder();
            GE_OG_SAP_AL_WOPublish.DT_ServiceOrder_Resp processResponse_x = new GE_OG_SAP_AL_WOPublish.DT_ServiceOrder_Resp();
            GE_OG_SAP_AL_WOPublish.Response_element resMessage_x = new GE_OG_SAP_AL_WOPublish.Response_element();
            GE_OG_SAP_AL_WOPublish.Operation_element workDetail_x = new GE_OG_SAP_AL_WOPublish.Operation_element();
            GE_OG_SAP_AL_WOPublish.Header_element workOrder_x = new GE_OG_SAP_AL_WOPublish.Header_element();
            GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element bundle_x = new GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element();
            GE_OG_SAP_AL_WOPublish.OrderStatus_element orderStatus_x = new GE_OG_SAP_AL_WOPublish.OrderStatus_element();
            GE_OG_SAP_AL_WOPublish.Objects_element objectsElement_x = new GE_OG_SAP_AL_WOPublish.Objects_element();
            GE_OG_SAP_OutboundWrapper.Universal_Response result= new GE_OG_SAP_OutboundWrapper.Universal_Response();

            //AL related list variables//
            List<GE_OG_SAP_AL_WOPublish.Operation_element> workDetail_xItem = new List<GE_OG_SAP_AL_WOPublish.Operation_element>();
            List<GE_OG_SAP_AL_WOPublish.Objects_element> objectsElement_xItem = new List<GE_OG_SAP_AL_WOPublish.Objects_element>();
            List<GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element> bundle_xItem = new List<GE_OG_SAP_AL_WOPublish.ServiceOrderDetails_element>();
            List<GE_OG_SAP_AL_WOPublish.OrderStatus_element> orderStatus_xItem = new List<GE_OG_SAP_AL_WOPublish.OrderStatus_element>();
            List <SVMXC__Service_Order__c> ALWoList = new List <SVMXC__Service_Order__c>();
            List<GE_OG_SAP_OutboundWrapper.Universal_Response> resultList = new List<GE_OG_SAP_OutboundWrapper.Universal_Response>();
            
            Map<string,string> inputHeader=new Map<string,string>();
            string AccessToken='Bearer 12345678';
            inputHeader.put('Authorization',AccessToken); 
            processRequest_x.inputHttpHeaders_x = inputHeader;
                
            //Operation Element
            workDetail_x.ItemNum='WL-00165373';
            workDetail_x.ControlKey='ssssssss';
            workDetail_x.OpPlant='AU01';
            workDetail_x.OpWorkCenter='SM-AU01';
            workDetail_x.OperationDescription='TEST';
            workDetail_x.ActivityType='Billable';
            workDetail_x.WorkHours='22';
            workDetail_x.TechnicianSSO='202046565';
            workDetail_x.MaterialNumber='103255';
            workDetail_x.MaterialDescription='TEST';
            workDetail_x.Quantity='250';
            workDetail_xItem.add(workDetail_x);

            //Order Status
            orderStatus_x.Status='TEST';
            orderStatus_x.ErrorMsg='ERROR';
            orderStatus_x.SMAX_OrderID='WO-327665';
            orderStatus_x.SAP_OrderID='123456';
            orderStatus_xItem.add(orderStatus_x);
            
            //Response Element
            resMessage_x.OrderStatus=orderStatus_xItem;
            
            //Header Element
            workOrder_x.OrderID='WO-327665';
            workOrder_x.OrderDescription='TEST';
            workOrder_x.SAP_OrderID='123456';
            workOrder_x.OrderType='Warranty';
            workOrder_x.Status='In Progress';
            workOrder_x.PlanningPlant='AU01-Midland';
            workOrder_x.PMActivityType='Install';
            workOrder_x.WorkCenter='SM-AU01';
            workOrder_x.BillToParty='123456';
            workOrder_x.SoldToParty='123456';
            workOrder_x.ShipToParty='123456';
            workOrder_x.ServiceProduct='ESP';
            workOrder_x.FunctionalLocation='TEST LOCATION';
            workOrder_x.SalesOrg='TEST SALES ORG';
            workOrder_x.DistChannel='TEST DIST CH';
            workOrder_x.Division='TEST DIV';
            workOrder_x.SalesOffice='TEST SO';
            workOrder_x.SalesGroup='TEST SG';
            
            //Objects Element
            objectsElement_x.Equipment='TEST EQUIP';
            objectsElement_xItem.add(objectsElement_x);
            
            //Service Order Details Element
            bundle_x.Header=workOrder_x;
            bundle_x.Operation=workDetail_xItem;
            bundle_x.Objects=objectsElement_xItem;
            bundle_xItem.add(bundle_x);
            
            //DT Service Order
            serviceOrder_x.ServiceOrderDetails=bundle_xItem;
            
            //DT Service Order Resp
            processResponse_x.Response=resMessage_x;
            
            //HTTP Port
            processRequest_x.SI_CreateServiceOrder_Out(bundle_xItem);
        }
        catch(Exception e){
        System.debug('Exception :'+e.getMessage());
        }
        test.stopTest();
    }
}