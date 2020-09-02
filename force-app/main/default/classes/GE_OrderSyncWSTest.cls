/*    
Class Name        : GE_OrderSyncWSTest
Purpose/Overview  : Test class for the SAP Order Web Service for SAP integration
Author            : Troy Hedges
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-12    : Troy Hedges        : Inital creation
*/
@isTest
Public class GE_OrderSyncWSTest
{
 
  @istest static void testWebService()
  {

    /////////////////////////////
    // sample data for testing //
    /////////////////////////////
    
  
    
    GE_OrderSyncWS.OrderData data = new GE_OrderSyncWS.OrderData();
    data.orderNum = '1234';
    data.sfdcOrderNum = '1234';
    data.soldToAccountNum = '234567';
    data.orderAmountOC = 345.65;
    data.orderDate = Date.today();
    data.overallStatus = 'Shipped';
    data.orderName = 'Name123';
    data.poNumber = 'PO-1234';
    data.accountMgrId = '550356873';
    data.accountMgrName = 'John Doe';
    data.currencyIsoCode = 'USD';
    String base64 = EncodingUtil.base64Encode(Blob.valueOf('This is a test'));
    data.fileBase64 = base64;
    GE_OrderSyncWS.Status wsStatus = null;
    
    
   
    /////////////////////////
    // create test account //
    /////////////////////////
   
      System.debug('GE_OrderSyncWSTest::Creating test account...');
      Account testAccount = new Account();
      testAccount.Name = 'Test Account';
      testAccount.currencyIsoCode = 'USD';
      testAccount.GE_HQ_DUNS_Number__c = '201612512';
      //testAccount.GE_HQ_KYC_Complete__c = TRUE;
      //testAccount.GE_HQ_Request_Status__c='CMF Approved';
      insert testAccount;


      ///////////////////////
      // create test order //
      ///////////////////////
      System.debug('GE_OrderSyncWSTest::Creating test order...');
      Order testOrder = new Order();
      testOrder.AccountId = testAccount.Id;
      testOrder.Name = 'Test Order';
      testOrder.GE_SOR_Sales_Order__c = data.orderNum;
      testOrder.EffectiveDate = Date.today();
      testOrder.Status = 'NA';
      insert testOrder;

      System.debug('GE_OrderSyncWSTest::Order.Id=' + testOrder.Id);
      System.debug('GE_OrderSyncWSTest::OrderNumber=' + testOrder.OrderNumber);

      Order orderNew = [SELECT Id, OrderNumber, GE_SOR_Sales_Order__c FROM Order WHERE Id = :testOrder.Id];

      //////////////////////////////
      // test saveOrder() service //
      //////////////////////////////
     
     try
      {
        data.sfdcOrderNum = null;
        system.debug('ppppppppp'+ data);
       // data.fileBase64 = '11_00*34';
        wsStatus = GE_OrderSyncWS.saveOrder(data);
      }
      catch (Exception e)
      {
        System.debug(e.getMessage());
        System.AssertEquals(wsStatus.statusCode, 4);
      }
     

      data.sfdcOrderNum = orderNew.OrderNumber;
      system.debug('>>>>>>>>>'+ data);
      GE_OrderSyncWS.saveOrder(data);

      Order order = [SELECT Id, OrderNumber, GE_SOR_Sales_Order__c FROM Order WHERE OrderNumber = :orderNew.OrderNumber];
      System.AssertEquals(order.GE_SOR_Sales_Order__c, orderNew.GE_SOR_Sales_Order__c);

      ///////////////////////////////////
      // test missing SAP order number //
      ///////////////////////////////////
     
     
       GE_OrderSyncWS GOS = new GE_OrderSyncWS();
    
       GE_OrderSyncWS.Status s = new GE_OrderSyncWS.Status();
    
       data.sfdcOrderNum = null;
       system.debug('>>>>>>>>>'+ data);
     
     
      try
      {
        data.orderNum = null;
        wsStatus = GE_OrderSyncWS.saveOrder(data);
      }
      catch (Exception e)
      {
        System.debug(e.getMessage());
        System.AssertEquals(wsStatus.statusCode, 3);
      }

  }
  static testmethod void testWebService1(){
  
    GE_OrderSyncWS.OrderData data = new GE_OrderSyncWS.OrderData();
    data.orderNum = 'Null';
    data.sfdcOrderNum = 'Null';
    data.soldToAccountNum = 'Null';
    data.orderAmountOC = Null;
    data.orderDate = Date.today();
    data.overallStatus = 'Null';
    data.orderName = 'Null';
    data.poNumber = 'Null';
    data.accountMgrId = 'Null';
    data.accountMgrName = 'Null';
    data.currencyIsoCode = 'Null';
    String base64 = EncodingUtil.base64Encode(Blob.valueOf('This is a test'));
    data.fileBase64 = base64;
    GE_OrderSyncWS.Status wsStatus = null;
    
      System.debug('GE_OrderSyncWSTest::Creating test account...');
      Account testAccount = new Account();
      testAccount.Name = 'Test Account';
      testAccount.currencyIsoCode = 'USD';
      testAccount.GE_HQ_DUNS_Number__c = '201612512';
      //testAccount.GE_HQ_KYC_Complete__c = TRUE;
      //testAccount.GE_HQ_Request_Status__c='CMF Approved';
      insert testAccount;
      
      System.debug('GE_OrderSyncWSTest::Creating test order...');
      Order testOrder = new Order();
      testOrder.AccountId = testAccount.Id;
      testOrder.Name = 'Test Order';
      testOrder.GE_SOR_Sales_Order__c = data.orderNum;
      testOrder.EffectiveDate = Date.today();
      testOrder.Status = 'NA';
      insert testOrder;
     
      GE_OrderSyncWS GOS = new GE_OrderSyncWS(); 
      GE_OrderSyncWS.saveOrder(data); 
   
try{
      Order order = [SELECT Id, OrderNumber, GE_SOR_Sales_Order__c FROM Order WHERE OrderNumber = null];
     
}
catch(exception e){}
  }

}