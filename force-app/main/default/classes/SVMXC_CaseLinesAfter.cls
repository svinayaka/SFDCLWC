public class SVMXC_CaseLinesAfter {

    public static void syncCaseLineswithIP (List<SVMXC__Case_Line__c> clList, 
                                        Map<Id, SVMXC__Case_Line__c> triggerOld, Boolean isInsert, 
                                        Boolean isUpdate, Set<Id> IPSet, Map<Id, String> subSeaRTLookupMap) { 
                                            
        /*
        
        Written : 4/2/2014 - Scott Fawcett
        
        The purpose of this method is to keep the CaseLine Spare Quantities in sync with the related Installed Product.
            
        */                                  
    
        Map<Id, SVMXC__Installed_Product__c> IPMap = new Map<Id, SVMXC__Installed_Product__c> ([SELECT Id, GE_SS_Quantity__c 
                                                                                FROM SVMXC__Installed_Product__c WHERE Id IN : IPset]);  
                 
        if (isInsert || isUpdate) {
            
            for (SVMXC__Case_Line__c cl1 : clList) {
                        
                // for Spares, we pull quantity from the Case Line field (SVMXC__Quantity__c)
                if (subSeaRTLookupMap.get(cl1.Id) == 'Spares') {
                    
                    SVMXC__Installed_Product__c workingIP2 = IPMap.get(cl1.GE_SS_Serial_Number__c);         
                    workingIP2.GE_SS_Quantity__c = cl1.SVMXC__Quantity__c;
                    IPMap.put(cl1.GE_SS_Serial_Number__c, workingIP2); 
                } 
            }
            
            update IPMap.values();
        }           
    }    
    
    //Method for sync work detail on updation of Case Line written by Sharad(BLS)
    public static void syncWOLineswithCaseLines (List<SVMXC__Case_Line__c> clList) { 

        try
        {
            Set<String> CaseLineRTNames = new Set<String>();
            CaseLineRTNames.add('Equipment');
            CaseLineRTNames.add('Spares');
            CaseLineRTNames.add('Tools');
            
            Set<String> WORTNames = new Set<String>();
            WORTNames.add('SS-Mobilize');
            WORTNames.add('SS-Daily');
            WORTNames.add('SS-Trip');
            
            if(clList != null && clList.size() > 0)
            {
                List<SVMXC__Case_Line__c> lstCaseLine = new List<SVMXC__Case_Line__c>();
                for(SVMXC__Case_Line__c objCaseLine : clList)
                {
                    if(CaseLineRTNames.contains(objCaseLine.GE_SS_Record_Type_Name__c))
                        lstCaseLine.add(objCaseLine);
                }
                if(lstCaseLine != null && lstCaseLine.size() > 0)
                {
                    Map<String, SVMXC__Case_Line__c> mapIdToCaseLine = new Map<String, SVMXC__Case_Line__c>();
                    
                    for(SVMXC__Case_Line__c objCaseLine : lstCaseLine)
                        mapIdToCaseLine.put(objCaseLine.Id, objCaseLine);
                    
                    List<SVMXC__Service_Order_Line__c> lstWODetail = new List<SVMXC__Service_Order_Line__c>();
                    lstWODetail = [Select SVMXC__Actual_Quantity2__c, SVMXC__Line_Status__c, SVMXC__Product__c, SVMXC__Serial_Number__c, GE_SS_Pre_installed__c, GE_SS_Usage_Type__c, GE_HQ_Record_Type_Name__c, Case_Line__c from SVMXC__Service_Order_Line__c where Case_Line__c IN: lstCaseLine AND GE_HQ_Record_Type_Name__c IN: CaseLineRTNames AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c IN: WORTNames];
                    
                    if(lstWODetail != null && lstWODetail.size() > 0)
                    {
                        for(SVMXC__Service_Order_Line__c objWOLine : lstWODetail)
                        {
                            if(mapIdToCaseLine.containskey(objWOLine.Case_Line__c))
                            {
                                objWOLine.SVMXC__Serial_Number__c = mapIdToCaseLine.get(objWOLine.Case_Line__c).GE_SS_Serial_Number__c;
                                objWOLine.SVMXC__Product__c = mapIdToCaseLine.get(objWOLine.Case_Line__c).SVMXC__Product__c;
                                if(objWOLine.GE_HQ_Record_Type_Name__c == 'Spares')
                                {
                                    objWOLine.SVMXC__Actual_Quantity2__c = mapIdToCaseLine.get(objWOLine.Case_Line__c).SVMXC__Quantity__c;
                                    //objWOLine.SVMXC__Line_Status__c = mapIdToCaseLine.get(objWOLine.Case_Line__c).SVMXC__Line_Status__c;
                                }
                                else if(objWOLine.GE_HQ_Record_Type_Name__c == 'Equipment')
                                {
                                    objWOLine.GE_SS_Pre_installed__c = mapIdToCaseLine.get(objWOLine.Case_Line__c).GE_SS_Pre_installed__c;
                                    //objWOLine.SVMXC__Line_Status__c = 'Open';
                                }
                                else if(objWOLine.GE_HQ_Record_Type_Name__c == 'Tools')
                                {
                                    objWOLine.GE_SS_Usage_Type__c = mapIdToCaseLine.get(objWOLine.Case_Line__c).GE_SS_Usage_Type__c;
                                    //objWOLine.SVMXC__Line_Status__c = 'Open';
                                }
                                
                            }
                        }
                        
                        update lstWODetail;
                    }
                }
            }
        }
        catch(Exception ex)
        {
            System.debug('In exception of Method syncWOLineswithCaseLines');
        }
    }
    
    //Method for sync work detail on delete of Case Line written by Sharad(BLS)
    public static void syncWOLineswithCaseLinesDelete (List<SVMXC__Case_Line__c> clList) { 

        try
        {
            Set<String> CaseLineRTNames = new Set<String>();
            CaseLineRTNames.add('Equipment');
            CaseLineRTNames.add('Spares');
            CaseLineRTNames.add('Tools');
            
            Set<String> WORTNames = new Set<String>();
            WORTNames.add('SS-Mobilize');
            WORTNames.add('SS-Daily');
            WORTNames.add('SS-Trip');

            
            if(clList != null && clList.size() > 0)
            {
                List<SVMXC__Case_Line__c> lstCaseLine = new List<SVMXC__Case_Line__c>();
                for(SVMXC__Case_Line__c objCaseLine : clList)
                {
                    if(CaseLineRTNames.contains(objCaseLine.GE_SS_Record_Type_Name__c))
                        lstCaseLine.add(objCaseLine);
                }
                if(lstCaseLine != null && lstCaseLine.size() > 0)
                {
                    Map<String, SVMXC__Case_Line__c> mapIdToCaseLine = new Map<String, SVMXC__Case_Line__c>();
                    
                    for(SVMXC__Case_Line__c objCaseLine : lstCaseLine)
                        mapIdToCaseLine.put(objCaseLine.Id, objCaseLine);
                    
                    List<SVMXC__Service_Order_Line__c> lstWODetail = new List<SVMXC__Service_Order_Line__c>();
                    lstWODetail = [Select Id from SVMXC__Service_Order_Line__c where Case_Line__c IN: lstCaseLine AND GE_HQ_Record_Type_Name__c IN: CaseLineRTNames AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c IN: WORTNames];
                    
                    if(lstWODetail != null && lstWODetail.size() > 0)
                    {
                        delete lstWODetail;
                    }
                }
            }
        }
        catch(Exception ex)
        {
            System.debug('In exception of Method syncWOLineswithCaseLinesDelete');
        }
    }   
    
    //Method for sync work detail on insert of Case Line written by Sharad(BLS)
    public static void syncWOLineswithCaseLinesInsert (List<SVMXC__Case_Line__c> clList) { 

        try
        {
            Set<String> CaseLineRTNames = new Set<String>();
            CaseLineRTNames.add('Equipment');
            CaseLineRTNames.add('Spares');
            CaseLineRTNames.add('Tools');
            
            Set<String> WORTNames = new Set<String>();
            WORTNames.add('SS-Mobilize');
            WORTNames.add('SS-Daily');
            WORTNames.add('SS-Trip');
            
            Id rtSparesId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Spares').getRecordTypeId();
            Id rtToolsId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
            Id rtEquipmentId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Equipment').getRecordTypeId();

            
            if(clList != null && clList.size() > 0)
            {
                List<SVMXC__Case_Line__c> lstCaseLine = new List<SVMXC__Case_Line__c>();
                Set<String> setCaseId = new Set<String>();
                
                
                for(SVMXC__Case_Line__c objCaseLine : clList)
                {
                    if(CaseLineRTNames.contains(objCaseLine.GE_SS_Record_Type_Name__c))
                    {
                        setCaseId.add(objCaseLine.SVMXC__Case__c);
                        lstCaseLine.add(objCaseLine);
                    }
                }
                
                if(lstCaseLine != null && lstCaseLine.size() > 0)
                {
                    
                    List<SVMXC__Service_Order__c> lstWorkOrder = new List<SVMXC__Service_Order__c>();
                    
                    List<SVMXC__Service_Order_Line__c> lstWODetail = new List<SVMXC__Service_Order_Line__c>();
                    
                    lstWorkOrder = [Select Id, SVMXC__Case__c from SVMXC__Service_Order__c where GE_SM_HQ_Record_Type_Name__c IN: WORTNames and SVMXC__Case__c IN: setCaseId];
                    
                    if(lstWorkOrder != null && lstWorkOrder.size() > 0)
                    {
                        Map<String, List<SVMXC__Service_Order__c>> mapCaseIdToLstWorkOrder = new Map<String, List<SVMXC__Service_Order__c>>();
                        
                        for(SVMXC__Service_Order__c objWorkOrder : lstWorkOrder)
                        {
                            if(!mapCaseIdToLstWorkOrder.containsKey(objWorkOrder.SVMXC__Case__c))
                                mapCaseIdToLstWorkOrder.put(objWorkOrder.SVMXC__Case__c, new List<SVMXC__Service_Order__c>());
                            mapCaseIdToLstWorkOrder.get(objWorkOrder.SVMXC__Case__c).add(objWorkOrder);
                        }
                        
                        
                        for(SVMXC__Case_Line__c ObjCaseLine : lstCaseLine)
                        {
                            for(SVMXC__Service_Order__c ObjWorkOrder : mapCaseIdToLstWorkOrder.get(ObjCaseLine.SVMXC__Case__c))
                            {
                                SVMXC__Service_Order_Line__c objWorkDetail = new SVMXC__Service_Order_Line__c();
                                
                                objWorkDetail.SVMXC__Serial_Number__c = ObjCaseLine.GE_SS_Serial_Number__c;
                                objWorkDetail.SVMXC__Product__c = ObjCaseLine.SVMXC__Product__c;
                                objWorkDetail.SVMXC__Service_Order__c = ObjWorkOrder.Id;
                                objWorkDetail.Case_Line__c = ObjCaseLine.Id;
                                objWorkDetail.GE_SS_Case__c = ObjCaseLine.SVMXC__Case__c;

                                if(ObjCaseLine.GE_SS_Record_Type_Name__c == 'Spares')
                                {
                                    objWorkDetail.SVMXC__Actual_Quantity2__c = ObjCaseLine.SVMXC__Quantity__c;
                                    objWorkDetail.SVMXC__Line_Status__c = ObjCaseLine.SVMXC__Line_Status__c;
                                    objWorkDetail.RecordTypeId = rtSparesId;
                                }
                                else if(ObjCaseLine.GE_SS_Record_Type_Name__c == 'Tools')
                                {
                                    objWorkDetail.GE_SS_Usage_Type__c = ObjCaseLine.GE_SS_Usage_Type__c;
                                    objWorkDetail.SVMXC__Line_Status__c = 'Open';
                                    objWorkDetail.RecordTypeId = rtToolsId;
                                }
                                else if(ObjCaseLine.GE_SS_Record_Type_Name__c == 'Equipment')
                                {
                                    objWorkDetail.GE_SS_Pre_installed__c = ObjCaseLine.GE_SS_Pre_installed__c;
                                    objWorkDetail.SVMXC__Line_Status__c = 'Open';
                                    objWorkDetail.RecordTypeId = rtEquipmentId;
                                }
                                
                                lstWODetail.add(objWorkDetail);
                            }
                            
                        }
                    }
                    
                    if(lstWODetail != null && lstWODetail.size() > 0)
                    {
                        insert lstWODetail;
                    }
                }
            }
        }
        catch(Exception ex)
        {
            System.debug('In exception of Method syncWOLineswithCaseLinesInsert');
        }
    }       
    
     //Method for update FS Project in installed product on updation and creation of Case Line written by Sharad(BLS)
    public static void updateFSProjectInIB (List<SVMXC__Case_Line__c> clList)
    {
        Set<String> CaseLineRTNames = new Set<String>();
        CaseLineRTNames.add('Equipment');
        CaseLineRTNames.add('Spares');
        CaseLineRTNames.add('Tools');
        try
        {
            if(clList != null && clList.size() > 0)
            {
                List<SVMXC__Case_Line__c> lstCaseLine = new List<SVMXC__Case_Line__c>();
                Set<String> setCaseId = new Set<String>();
                Set<String> setIBId = new Set<String>();
                for(SVMXC__Case_Line__c objCaseLine : clList)
                {
                    if(CaseLineRTNames.contains(objCaseLine.GE_SS_Record_Type_Name__c))
                    {
                        lstCaseLine.add(objCaseLine);
                        setCaseId.add(objCaseLine.SVMXC__Case__c);
                        setIBId.add(objCaseLine.GE_SS_Serial_Number__c);
                    }
                }
                if(lstCaseLine != null && lstCaseLine.size() > 0)
                {
                    List<Case> lstCase = new List<Case>();
                    lstCase = [Select Id, GE_SS_Project__c from Case where Id IN: setCaseId];
                    Map<Id, SVMXC__Installed_Product__c> mapIdToIB = new Map<Id, SVMXC__Installed_Product__c>();
                    mapIdToIB.putAll([Select Id, GE_SS_FS_Project__c from SVMXC__Installed_Product__c where Id IN: setIBId]);
                    if(lstCase != null && lstCase.size() > 0  && mapIdToIB != null && mapIdToIB.size() > 0)
                    {
                        map<String, String> mapCaseIdToFSProjectId = new map<String, String>();
                        for(Case objCase : lstCase)
                            mapCaseIdToFSProjectId.put(objCase.Id, objCase.GE_SS_Project__c);
                        for(SVMXC__Case_Line__c objCaseLine2 : lstCaseLine)
                        {
                            if(mapCaseIdToFSProjectId.containsKey(objCaseLine2.SVMXC__Case__c) && mapCaseIdToFSProjectId.get(objCaseLine2.SVMXC__Case__c) != null && mapIdToIB.containsKey(objCaseLine2.GE_SS_Serial_Number__c) && mapIdToIB.get(objCaseLine2.GE_SS_Serial_Number__c) != null)
                            {
                                mapIdToIB.get(objCaseLine2.GE_SS_Serial_Number__c).GE_SS_FS_Project__c = mapCaseIdToFSProjectId.get(objCaseLine2.SVMXC__Case__c);
                            }
                        }
                        
                        update mapIdToIB.values();
                    }
                }
            }
        }
        catch(Exception ex)
        {
            System.debug('exception in method updateFSProjectInIB');
        }
    } 
}