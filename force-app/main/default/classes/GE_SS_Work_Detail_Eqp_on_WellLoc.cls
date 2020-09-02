public with sharing class GE_SS_Work_Detail_Eqp_on_WellLoc
{
   public List<SVMXC__Service_Order_Line__c> lstWorkDetails{get;set;}
    
   public GE_SS_Work_Detail_Eqp_on_WellLoc()
   {
       String strLocId = apexpages.currentpage().getparameters().get('Loc_Id');
       
       lstWorkDetails = new List<SVMXC__Service_Order_Line__c>();
       if(strLocId != null)
        {
            lstWorkDetails = [select Id, Name, SVMXC__Serial_Number__r.Name,GE_SS_Product_Name__c,GE_SS_Product_Description__c, SVMXC__Service_Order__r.Name, GE_SS_IP_Status__c, LastModifiedBy.Name, LastModifiedById from  SVMXC__Service_Order_Line__c where SVMXC__Service_Order__r.GE_SS_Well_ID__c =: strLocId  AND GE_HQ_Record_Type_Name__c = 'Equipment' and GE_SS_IP_Status__c = 'Installed' AND (SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Mobilize' OR SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip' ) ];
        }
   }
}