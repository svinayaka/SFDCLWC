@isTest
global class WebServiceMockImpl implements WebServiceMock {
    global void doInvoke(
    Object stub,
    Object request,
    Map<String, Object> response,
    String endpoint,
    String soapAction,
    String requestName,
    String responseNS,
    String responseName,
    String responseType){

        GE_OG_SAP_AL_WOPublish.DT_ServiceOrder_Resp respElement = new GE_OG_SAP_AL_WOPublish.DT_ServiceOrder_Resp();

        GE_OG_SAP_AL_WOPublish.OrderStatus_element orderStatusElement = new GE_OG_SAP_AL_WOPublish.OrderStatus_element();
        orderStatusElement.Status='S';
        orderStatusElement.ErrorMsg='Test Error Msg';
        orderStatusElement.SMAX_OrderID='WO-123456';
        orderStatusElement.SAP_OrderID='50212345';

        List<GE_OG_SAP_AL_WOPublish.OrderStatus_element> listOrderStatusElement = new List<GE_OG_SAP_AL_WOPublish.OrderStatus_element>();
        listOrderStatusElement.add(orderStatusElement);

        GE_OG_SAP_AL_WOPublish.Response_element responseElement = new GE_OG_SAP_AL_WOPublish.Response_element();
        responseElement.OrderStatus=listOrderStatusElement;
        
        respElement.Response = responseElement;
        response.put('response_x', respElement); 
    }
}