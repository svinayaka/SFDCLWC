public class SVMXC_WorkDetailsAfter {
    
    public static void syncWDLwithIP (List<SVMXC__Service_Order_Line__c> wdlList, 
                                        Map<Id, SVMXC__Service_Order_Line__c> triggerOld, Boolean isInsert, 
                                        Boolean isUpdate, Set<Id> IPSet,  Map<Id, String> subSeaRTLookupMap) { 
                                            
    /*
        Written : 4/2/2014 - Scott Fawcett
        
        The purpose of this method is to keep the Work Detail Line in sync with the Installed Product.
        For Equipment and Tools, the "Used" status will be carried over to the IP.
        For Spares, the Quantity Used will be updated against the IP.  If the Quantity Used is updated only the
        delta will be applied to the IP.  (For example if the record is saved with a Quantity Used of 5 and updated 
        to a value of 6, the IP will be adjusted by 1 on the update)
        
        Additionally the Rework, New Condition and New Returned values will be carried to the IP as well.
            
    */                                      
   
        Map<Id, SVMXC__Installed_Product__c> IPMap = new Map<Id, SVMXC__Installed_Product__c> ([SELECT Id, GE_SS_Quantity__c, GE_SS_Qty_Used__c, GE_SS_Used__c 
                                                                                FROM SVMXC__Installed_Product__c WHERE Id IN : IPset]);  
                 
        if (isInsert) {
            
            for (SVMXC__Service_Order_Line__c wdl1 : wdlList) {
                
                // for Equipment and Tools we copy over the "Used"/Rework/New Condition/New Returned status to the IP
                if (subSeaRTLookupMap.get(wdl1.Id) == 'Equipment' || subSeaRTLookupMap.get(wdl1.Id) == 'Tools') {
                    
                    SVMXC__Installed_Product__c workingIP = IPMap.get(wdl1.SVMXC__Serial_Number__c);
                    workingIP.GE_SS_Used__c = wdl1.GE_SS_Used__c;
                    workingIP.GE_SS_Description_of_Rework__c = wdl1.GE_SS_New_Rework__c;
                    workingIP.GE_AL_Condition__c = wdl1.GE_SS_New_Condition__c;
                    workingIP.GE_SS_Returned__c = wdl1.GE_SS_New_Returned__c;
                    
                    IPMap.put(wdl1.SVMXC__Serial_Number__c, workingIP);                     
                    
                // for Spares, an adjustment to the quantity needs to be made on the IP
                } else if (subSeaRTLookupMap.get(wdl1.Id) == 'Spares') {
                    
                    SVMXC__Installed_Product__c workingIP2 = IPMap.get(wdl1.SVMXC__Serial_Number__c);
                    
                    workingIP2.GE_SS_Description_of_Rework__c = wdl1.GE_SS_New_Rework__c;
                    workingIP2.GE_AL_Condition__c = wdl1.GE_SS_New_Condition__c;
                    workingIP2.GE_SS_Returned__c = wdl1.GE_SS_New_Returned__c;
                    
                    if (workingIP2.GE_SS_Qty_Used__c == null)
                        workingIP2.GE_SS_Qty_Used__c = wdl1.GE_SS_Qty_Consumed__c;
                    else {
                        Decimal quantityUsed = workingIP2.GE_SS_Qty_Used__c;
                        
                        if (wdl1.GE_SS_Qty_Consumed__c != null) {
                            quantityUsed = quantityUsed + wdl1.GE_SS_Qty_Consumed__c;
                            workingIP2.GE_SS_Qty_Used__c = quantityUsed;
                        }
                            
                    } 
                            
                    IPMap.put(wdl1.SVMXC__Serial_Number__c, workingIP2);
                }
            }
            
        } else if (isUpdate) {
            
            for (SVMXC__Service_Order_Line__c wdl2 : wdlList) {
                
                // for Equipment and Tools we copy over the "Used"/Rework/New Condition/New Returned status to the IP
                if (subSeaRTLookupMap.get(wdl2.Id) == 'Equipment' || subSeaRTLookupMap.get(wdl2.Id) == 'Tools') {
                    
                    SVMXC__Installed_Product__c workingIP3 = IPMap.get(wdl2.SVMXC__Serial_Number__c);
                    
                    workingIP3.GE_SS_Used__c = wdl2.GE_SS_Used__c;
                    workingIP3.GE_SS_Description_of_Rework__c = wdl2.GE_SS_New_Rework__c;
                    workingIP3.GE_AL_Condition__c = wdl2.GE_SS_New_Condition__c;
                    workingIP3.GE_SS_Returned__c = wdl2.GE_SS_New_Returned__c;
                    
                    IPMap.put(wdl2.SVMXC__Serial_Number__c, workingIP3);                    
                    
                // for Spares, an adjustment to the quantity needs to be made on the IP.  for updates we need to look to see 
                // how the value changed and update the IP accordingly.
                } else if (subSeaRTLookupMap.get(wdl2.Id) == 'Spares') {
                    
                    SVMXC__Installed_Product__c workingIP4 = IPMap.get(wdl2.SVMXC__Serial_Number__c);
                    
                    workingIP4.GE_SS_Description_of_Rework__c = wdl2.GE_SS_New_Rework__c;
                    workingIP4.GE_AL_Condition__c = wdl2.GE_SS_New_Condition__c;
                    workingIP4.GE_SS_Returned__c = wdl2.GE_SS_New_Returned__c;
                    
                    Decimal currentQuantityUsed2;
                    
                    if (workingIP4.GE_SS_Qty_Used__c == null)
                        currentQuantityUsed2 = 0;
                    else 
                        currentQuantityUsed2 = workingIP4.GE_SS_Qty_Used__c;
                        
                    Decimal previousQuantityUsed2;
                    
                    if (triggerOld.get(wdl2.Id).GE_SS_Qty_Consumed__c == null)
                        previousQuantityUsed2 = 0;
                    else 
                        previousQuantityUsed2 = triggerOld.get(wdl2.Id).GE_SS_Qty_Consumed__c;
 
                    if (wdl2.GE_SS_Qty_Consumed__c != null) {
                        workingIP4.GE_SS_Qty_Used__c = (currentQuantityUsed2 - (previousQuantityUsed2 - wdl2.GE_SS_Qty_Consumed__c));
                        IPMap.put(wdl2.SVMXC__Serial_Number__c, workingIP4);
                    }
                }
            }
        }
        
        update IPMap.values();
    } 

}