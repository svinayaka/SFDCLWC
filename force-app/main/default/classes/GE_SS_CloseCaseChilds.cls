public class GE_SS_CloseCaseChilds {
    @InvocableMethod
    public static void closeCaseChilds(list<Id> lstCaseIds) {
        System.debug('list of record to proceed: '+lstCaseIds);
        if(lstCaseIds != null && lstCaseIds.size() > 0)
        {
            List<SVMXC__Service_Order__c> lstWorkOrders = new List<SVMXC__Service_Order__c>();

            lstWorkOrders = [Select Id, SVMXC__Order_Status__c, GE_SM_HQ_Actual_End_Date__c From SVMXC__Service_Order__c where SVMXC__Case__c IN: lstCaseIds and SVMXC__Order_Status__c != 'Closed' and (GE_SM_HQ_Record_Type_Name__c = 'SS-Mobilize' OR GE_SM_HQ_Record_Type_Name__c = 'SS-Daily' OR GE_SM_HQ_Record_Type_Name__c = 'SS-Trip')];
            
            if(lstWorkOrders != null && lstWorkOrders.size() > 0)
            {
                for(SVMXC__Service_Order__c ObjWO : lstWorkOrders)
                {
                    ObjWO.SVMXC__Order_Status__c = 'Closed';
                    if(ObjWO.GE_SM_HQ_Actual_End_Date__c == null )
                        ObjWO.GE_SM_HQ_Actual_End_Date__c = System.Now();
                }
                update lstWorkOrders;
            }
        }
    }
}