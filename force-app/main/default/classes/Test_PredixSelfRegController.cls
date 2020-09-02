@isTest
class Test_PredixSelfRegController 
{
    static testMethod void testPredix()
    {
     PredixSelfRegController predix=new  PredixSelfRegController();
    
    predix.submitRequest();
    predix.objAccReq.GE_OG_Customer_First_Name__c='test';
    predix.objAccReq.GE_OG_Customer_Last_Name__c='test';
    predix.objAccReq.GE_OG_Contact_Email__c='test55@gmail.com';
    predix.objAccReq.GE_OG_Contact_Phone__c='1234567890';
    predix.objAccReq.GE_OG_Company_Organization_Name__c='test';
    predix.submitRequest();
         
     predix.PredixSelfRegController(); 
      ApexPages.StandardController stdHR = new ApexPages.StandardController(predix.objAccReq);
      PredixSelfRegController test=new PredixSelfRegController(stdHR );
      
      ApexPages.StandardController stdHR1 = new ApexPages.StandardController(predix.objAccReq);
      predix.PredixSelfRegController(stdHR1 );
      predix.cancel();
    }
}