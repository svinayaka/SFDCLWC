/*
Class Name        : GE_OrderSyncWS
Purpose/Overview  : Web service exposed to receive SAP Order header and PDF object details.
Author            : Troy Hedges
Test Class        : GE_OrderSyncWSTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-11    : Troy Hedges        : Inital creation
*/
global with sharing class GE_OrderSyncWS
{
  @TestVisible global class Status
  {
    public Status()
    {
      statusCode = 0;
      errorMsg = null;

    }

    webservice Integer statusCode;      // error code; to be defined by application logic
    webservice String errorMsg;    // a string description of the error
  }

  global class OrderData
  {
    webservice String sfdcOrderNum;
    webservice String orderNum;
    webservice String soldToAccountNum;
    webservice String soldToAccountName;
    webservice Date   orderDate;
    webservice Double orderAmountOC;
    webservice String orderName;
    webservice String overallStatus;
    webservice String deliveryStatus;
    webservice String creditStatus;
    webservice String billingStatus;
    webservice String blockedStatus;
    webservice String fileDisplayName;
    webservice String fileOriginalName;
    webservice Datetime   fileCreatedOn;
    webservice Datetime   fileModifiedOn;
    webservice String fileBase64;
    webservice String poNumber;
    webservice Date   poDate;
    webservice String currencyIsoCode;
    webservice String accountMgrId;
    webservice String accountMgrName;
    webservice String sorSystemID;
    webservice String sorCreatedBy;
    webservice Datetime   sorCreatedOn;
    webservice String sorLastModBy;
    webservice Datetime   sorLastModOn;
  }

  @TestVisible private static String convOrderStatus(String sapStatus)
  {
    String status = null;

    if (sapStatus == null) return null;

    if (sapStatus.toLowerCase().contains('not yet') || (sapStatus == 'A'))
    {
      status = 'Not Yet Processed';
    }
    else if (sapStatus.toLowerCase().contains('partially') || (sapStatus == 'B'))
    {
      status = 'Partially Processed';
    }
    else if (sapStatus.toLowerCase().contains('completely') || (sapStatus == 'C'))
    {
      status = 'Completely Processed';
    }
    else
    {
      status = 'Not Relevant';
    }

    return status;
  }

  webservice static Status saveOrder(OrderData orderData)
  {
    Status wsStatus = new Status();
    Order order = null;

    ///////////////////////////////////
    // check for required parameters //
    ///////////////////////////////////
    if ((orderData.orderNum == null) || (orderData.orderNum.length() == 0))
    {
      wsStatus.statusCode = 3;
      wsStatus.errorMsg = 'ERP Order number must be provided';
      return wsStatus;
    }

    ///////////////////////////////////
    // check for required parameters //
    ///////////////////////////////////
    if ((orderData.sfdcOrderNum == null) || (orderData.sfdcOrderNum.length() == 0))
    {
      wsStatus.statusCode = 4;
      wsStatus.errorMsg = 'SFDC Order number must be provided';
      return wsStatus;
    }

    System.debug('SFDC Order Number: ' + orderData.sfdcOrderNum);
    System.debug('SAP Order Number: ' + orderData.orderNum);
    
    try
    {
      /////////////////////////////////////////////////////
      // Insert or update quote - Are we doing updates?? //
      /////////////////////////////////////////////////////
      order = [SELECT Id, OrderNumber FROM Order WHERE OrderNumber = :orderData.sfdcOrderNum];

      if (orderData.orderNum != null) order.GE_SOR_Sales_Order__c = orderData.orderNum;
      if (orderData.soldToAccountNum != null) order.GE_SOR_Sold_To_AccountNumber__c = orderData.soldToAccountNum;
      if (orderData.soldToAccountName != null) order.GE_SOR_Sold_To_AccountName__c = orderData.soldToAccountName;
      if (orderData.orderDate != null) order.EffectiveDate = orderData.orderDate;
      if (orderData.orderAmountOC != null) order.GE_SOR_Grand_Total__c = orderData.orderAmountOC;
      if (orderData.overallStatus != null) order.GE_SOR_Overall_Status__c = convOrderStatus(orderData.overallStatus);
      if (orderData.deliveryStatus != null) order.GE_SOR_Delivery_Status__c = convOrderStatus(orderData.deliveryStatus);
      if (orderData.creditStatus != null) order.GE_SOR_Credit_Status__c = convOrderStatus(orderData.creditStatus);
      if (orderData.billingStatus != null) order.GE_SOR_Billing_Status__c = convOrderStatus(orderData.billingStatus);
      if (orderData.blockedStatus != null) order.GE_SOR_Blocked_Status__c = convOrderStatus(orderData.blockedStatus);

      /* Order status update has been removed 
      String convStatus = convOrderStatus(orderData.overallStatus);
      System.debug('Order Status: ' + convStatus);
      if (convStatus != null) order.Status = convStatus;
      //order.Status = 'Not Relevant';
      */

      // order name
      if (orderData.poNumber != null) order.PoNumber = orderData.poNumber;
      if (orderData.poDate != null) order.PoDate = orderData.poDate;
      if (orderData.accountMgrId != null) order.GE_SOR_Account_ManagerID__c = orderData.accountMgrId;
      if (orderData.accountMgrName != null) order.GE_SOR_Account_ManagerName__c = orderData.accountMgrName;
      if (orderData.sorSystemID != null) order.GE_SOR_SystemID__c = orderData.sorSystemID;
      if (orderData.sorCreatedOn != null) order.GE_SOR_CreatedOn__c = orderData.sorCreatedOn;
      if (orderData.sorCreatedBy != null) order.GE_SOR_CreatedBy__c = orderData.sorCreatedBy;
      if (orderData.sorLastModOn != null) order.GE_SOR_ModifiedOn__c = orderData.sorLastModOn;
      if (orderData.sorLastModBy != null) order.GE_SOR_ModifiedBy__c = orderData.sorLastModBy;

      ///////////////////////////////
      // Attach order PDF document //
      ///////////////////////////////
      if ((order != null) && (orderData.fileBase64 != null) && (orderData.fileBase64.length() != 0))
      {
        Attachment att = new Attachment();
        att.Body = EncodingUtil.base64Decode(orderData.fileBase64);
        att.Name = 'Order PO Confirmation ' + orderData.poNumber + '.pdf';
        att.parentId = order.Id;
        insert att;

        order.GE_Order_AttachID__c = att.Id;
      }

      update order;

      return wsStatus;

    }
    catch (StringException e)
    {
      wsStatus.statusCode = 2;
      wsStatus.errorMsg = 'Could not decode order base64 data';
      return wsStatus;
    }
    catch (QueryException e)
    {
      wsStatus.statusCode = 1;
      wsStatus.errorMsg = 'Could not retrieve order number ' + orderData.sfdcOrderNum;
      return wsStatus;
    }
    catch (Exception e)
    {
      throw new GE_WebServiceException('Web service call failed CAUSE=[' + e.getCause() + '] MSG=[' + e.getMessage() + '] TYPE_NAME=' + e.getTypeName() + ']', e);
    }

  }

}