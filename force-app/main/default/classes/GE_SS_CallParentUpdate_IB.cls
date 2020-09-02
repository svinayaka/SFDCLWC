public class GE_SS_CallParentUpdate_IB {
    @InvocableMethod
    public static void callParentUpdate(list<Id> lstRecordIds) {
        System.debug('list of record to proceed: '+lstRecordIds);
        if(lstRecordIds != null && lstRecordIds.size() > 0)
        {
            List<SVMXC__Service_Order_Line__c> lstWorkDetail = new List<SVMXC__Service_Order_Line__c>();

            Map<ID, Set<SVMXC__Service_Order_Line__c>> mapIBIdtoLstWD = new Map<ID, Set<SVMXC__Service_Order_Line__c>>();
            Map<Id, SVMXC__Installed_Product__c> mapIB = new Map<Id, SVMXC__Installed_Product__c>();
            List<SVMXC__Installed_Product__c> lstUpdateIB = new List<SVMXC__Installed_Product__c>();

            lstWorkDetail.clear();
            lstWorkDetail = [select Id, SVMXC__Serial_Number__c, GE_SS_Hours_Used__c from SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c IN: lstRecordIds and GE_HQ_Record_Type_Name__c = 'Tools' and GE_SS_Used__c = 'Yes' ];
            
            System.debug('lstWorkDetail: '+lstWorkDetail);
            
            for(SVMXC__Service_Order_Line__c ObjWD : lstWorkDetail)
            {
                if(ObjWD.SVMXC__Serial_Number__c != null && ObjWD.GE_SS_Hours_Used__c != null && ObjWD.GE_SS_Hours_Used__c > 0)
                    System.debug('mapIBIdtoLstWD.containsKey(ObjWD.SVMXC__Serial_Number__c): '+mapIBIdtoLstWD.containsKey(ObjWD.SVMXC__Serial_Number__c));
                    if(!mapIBIdtoLstWD.containsKey(ObjWD.SVMXC__Serial_Number__c))
                        mapIBIdtoLstWD.put(ObjWD.SVMXC__Serial_Number__c, new Set<SVMXC__Service_Order_Line__c>());
                    System.debug('mapIBIdtoLstWD: '+mapIBIdtoLstWD);
                    mapIBIdtoLstWD.get(ObjWD.SVMXC__Serial_Number__c).add(ObjWD);
            }
            
            mapIB.putAll([Select Id, GE_SS_Total_Hours_Used__c from SVMXC__Installed_Product__c where Id IN: mapIBIdtoLstWD.keySet()]);
            
            if(mapIBIdtoLstWD != null && mapIBIdtoLstWD.size() > 0)
            {
                for(Id idIB : mapIBIdtoLstWD.keySet())
                {
                    if(mapIB.containsKey(idIB))
                    {
                        integer intCount = 0;
                        for(SVMXC__Service_Order_Line__c objWD : mapIBIdtoLstWD.get(idIB))
                        {
                            System.debug('objWD.GE_SS_Hours_Used__c: '+objWD.GE_SS_Hours_Used__c);
                            if(objWD.GE_SS_Hours_Used__c != null && objWD.GE_SS_Hours_Used__c > 0)
                                intCount = intCount + objWD.GE_SS_Hours_Used__c.intValue();
                        }
                        mapIB.get(idIB).GE_SS_Total_Hours_Used__c = intCount;
                        lstUpdateIB.add(mapIB.get(idIB));
                    }
                    
                }
            }
            
            if(lstUpdateIB != null && lstUpdateIB.size() > 0)
                update lstUpdateIB;
        }
    }
}