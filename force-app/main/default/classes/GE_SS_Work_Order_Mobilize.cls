public class GE_SS_Work_Order_Mobilize {

    public List<SVMXC__Service_Order__c> lstWorkOrder{get;set;}
    
    public GE_SS_Work_Order_Mobilize(ApexPages.StandardController controller) {
        Case objCase = (Case)controller.getRecord();
        System.debug('in controller');
        
        if(objCase.Id != null)
        {
            lstWorkOrder = [select Id, Name, GE_SM_HQ_Record_Type_Name__c, SVMXC__Order_Status__c, SVMXC__Order_Type__c, CreatedDate, LastModifiedDate, LastModifiedById, LastModifiedBy.Name from  SVMXC__Service_Order__c where SVMXC__Case__c =: objCase.Id  and GE_SM_HQ_Record_Type_Name__c = 'SS-Mobilize'];
        }
        
    }
    
}