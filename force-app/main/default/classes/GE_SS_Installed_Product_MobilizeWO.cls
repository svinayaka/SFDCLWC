public class GE_SS_Installed_Product_MobilizeWO {

    public List<SVMXC__Service_Order__c> lstWorkOrder{get;set;}
    
    public GE_SS_Installed_Product_MobilizeWO (ApexPages.StandardController controller) {
        SVMXC__Installed_Product__c objIP = (SVMXC__Installed_Product__c)controller.getRecord();
        System.debug('in controller');
        
        if(objIP.Id != null)
        {
            lstWorkOrder = [select Id, Name, GE_SM_HQ_Record_Type_Name__c, SVMXC__Order_Status__c, SVMXC__Order_Type__c, CreatedDate, LastModifiedDate, LastModifiedById, LastModifiedBy.Name from  SVMXC__Service_Order__c where GE_SM_HQ_Record_Type_Name__c = 'SS-Mobilize'];
        }
        
    }
    
}