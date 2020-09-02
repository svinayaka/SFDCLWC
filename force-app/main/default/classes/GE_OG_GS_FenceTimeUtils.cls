public with sharing class GE_OG_GS_FenceTimeUtils {
    
    public static void setFenceTime(List<SVMXC__Service_Order__c> woList, Map<Id, SVMXC__Service_Order__c> oldMap, Boolean isInsert)
    {
        Set<Id> rtIdSet = new Set<Id>();
        Map<String, Schema.RecordTypeInfo> WORType = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName(); 
        for (String rtName : WORType.keySet())
        {
            if (rtName.startsWith('GS'))
            {
                rtIdSet.add(WORType.get(rtName).getRecordTypeId());
            }
        }
        Set<String> countrySet = new Set<String>();
        List<SVMXC__Service_Order__c> updatedList = new List<SVMXC__Service_Order__c>();
        
        for (SVMXC__Service_Order__c wo : woList)
        {
            if (rtIdSet.contains(wo.RecordTypeId) && wo.SVMXC__Country__c != null && (isInsert || wo.SVMXC__Country__c != oldMap.get(wo.Id).SVMXC__Country__c))
            {
                countrySet.add(wo.SVMXC__Country__c);
                updatedList.add(wo);
            }
        }
        
        if (! updatedList.isEmpty())
        {
            Map<String, Decimal> fenceTimeMAp = new Map<String, Decimal>();
            
            for (GE_OG_GS_Fence_Time__c f : [SELECT Id, GE_OG_GS_Active__c, GE_OG_GS_Country__c, GE_OG_GS_Fence_Time_Days__c FROM GE_OG_GS_Fence_Time__c WHERE GE_OG_GS_Country__c IN :countrySet ])
            {
                if (f.GE_OG_GS_Active__c)
                {
                    fenceTimeMap.put(f.GE_OG_GS_Country__c, f.GE_OG_GS_Fence_Time_Days__c);
                }
            }
            
            for (SVMXC__Service_Order__c wo : updatedList)
            {
                if (fenceTimeMap.containsKey(wo.SVMXC__Country__c))
                {
                    wo.GE_OG_GS_Fence_Time_Days__c = fenceTimeMap.get(wo.SVMXC__Country__c);
                }
                else
                {
                    wo.GE_OG_GS_Fence_Time_Days__c = 999;
                }
            }
        }
        
    }

}