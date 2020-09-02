public with sharing class GE_SS_Work_Detail_Line_on_IP
{
    public List<SVMXC__Service_Order_Line__c> lstWorkDetails{get;set;}
    public boolean isTool{get;set;}
    public boolean isEquipment{get;set;}
    public boolean isSpares{get;set;}
    
    
    public GE_SS_Work_Detail_Line_on_IP()
    {
        String strIBId = apexpages.currentpage().getparameters().get('IP_Id');
        String strIBType = [Select GE_AL_Installed_Product_Type__c from SVMXC__Installed_Product__c where Id=:strIBId ].GE_AL_Installed_Product_Type__c;
        
        
        lstWorkDetails = new List<SVMXC__Service_Order_Line__c>();
        isTool = false;
        isEquipment = false;
        isSpares = false;
        if(strIBId != null)
        {
            if(strIBType == 'Tools')
            {
                isTool = true;
                //Commenting below as part of  R-26631  
                //lstWorkDetails = [select Id, Name, SVMXC__Serial_Number__r.Name,GE_SS_Product_Name__c,GE_SS_Product_Description__c,GE_SS_Delivered__c, GE_SS_Condition_Before_Use__c, GE_SS_New_Condition__c, GE_SS_Number_of_Runs__c, GE_SS_Hours_Used__c, GE_SS_Issues_During_Operation__c, GE_SS_Additional_Comments__c from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c =: strIBId  AND GE_HQ_Record_Type_Name__c = 'Tools' AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip'];
                lstWorkDetails = [select Id, Name, SVMXC__Serial_Number__r.Name,GE_SS_Product_Name__c,GE_SS_Product_Description__c,GE_SS_Delivered__c, GE_SS_Condition_Before_Use__c, GE_SS_New_Condition__c, GE_SS_Number_of_Runs__c, GE_SS_Hours_Used__c, GE_SS_Issues_During_Operation__c from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c =: strIBId  AND GE_HQ_Record_Type_Name__c = 'Tools' AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip'];
            }
            else if(strIBType == 'Equipment')
            {
                isEquipment = true;
                //Commenting below as part of  R-26631  
                //lstWorkDetails = [select Id, Name, GE_SS_Condition_Before_Use__c, GE_SS_New_Condition__c, SVMXC__Serial_Number__r.Name,GE_SS_Product_Name__c,GE_SS_Product_Description__c,GE_SS_Delivered__c, GE_SS_Additional_Comments__c, GE_SS_IP_Status__c from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c =: strIBId  AND GE_HQ_Record_Type_Name__c = 'Equipment' AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip'];
                lstWorkDetails = [select Id, Name, GE_SS_Condition_Before_Use__c, GE_SS_New_Condition__c, SVMXC__Serial_Number__r.Name,GE_SS_Product_Name__c,GE_SS_Product_Description__c,GE_SS_Delivered__c, GE_SS_IP_Status__c from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c =: strIBId  AND GE_HQ_Record_Type_Name__c = 'Equipment' AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip'];
            }
            else if(strIBType == 'Spares')
            {
                isSpares = true;
                lstWorkDetails = [select Id, Name, SVMXC__Serial_Number__r.Name,GE_SS_Product_Name__c,GE_SS_Product_Description__c,GE_SS_Delivered__c,GE_SS_Quantity__c, GE_SS_Qty_Consumed__c from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c =: strIBId  AND GE_HQ_Record_Type_Name__c = 'Spares' AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip'];
            }
        }
    }
}