global class GE_OG_GS_CheckDoubleBooking {

    webservice static SVMXC.SFM_WrapperDef.SFM_PageData checkDoubleBooking(SVMXC.SFM_WrapperDef.SFM_TargetRecord request)
    {
        SVMXC.SFM_ServicesDef servicesDef = new SVMXC.SFM_ServicesDef();
        map<String,Schema.SObjectType> allObjMap = Schema.getGlobalDescribe();  
        Sobject header = servicesDef.SFM_Page_GetHeaderRecord(request,allObjMap);
        map<String,List<Sobject>> detailListMap = servicesDef.SFM_Page_GetDetailRecords(request,allObjMap);
        map<String,Schema.SObjectType> detailMap = new map<String,Schema.SObjectType>();
        
        SVMXC__Service_Order__c wo = (SVMXC__Service_Order__c) header;

        if (wo.SVMXC__Group_Member__c != null)
        {
            SVMXC__Service_Group_Members__c tech = [SELECT Id, SVMXC__Salesforce_User__c FROM SVMXC__Service_Group_Members__c WHERE Id = :wo.SVMXC__Group_Member__c LIMIT 1];
            Date startDate = null;
            Date endDate = null;
            Map<Id, String> errorMap = new Map<Id, String>();
            
            if (tech.SVMXC__Salesforce_User__c != null)
            {
                
                List<Event> eventList = [SELECT Id, EndDateTime, StartDateTime FROM Event WHERE WhatId = :wo.Id ];
            
                if (! eventList.isEmpty())
                {
                    for (Event e : eventList)
                    {
                        if (startDate == null || e.StartDateTime.dateGMT() < startDate)
                        {
                            startDate = e.StartDateTime.dateGMT();
                        }
                        
                        if (endDate == null || e.EndDateTime.dateGMT() > endDate)
                        {
                            endDate = e.EndDateTime.dateGMT();
                        }
                    }
                }
                
                
                for (Event e : [SELECT Id, StartDateTime, EndDateTime, WhatId FROM Event WHERE OwnerId = :tech.SVMXC__Salesforce_User__c AND DAY_ONLY(EndDateTime) >= :startDate AND DAY_ONLY(StartDateTime) <= :endDate AND WhatId != :wo.Id]) 
                {
                    errorMap.put(e.WhatId, e.StartDateTime.date().format() + ' to ' + e.EndDateTime.date().format());
                } 
            
            }
            else
            {
                List<SVMXC__SVMX_Event__c> svmxEventList = [SELECT Id, SVMXC__EndDateTime__c, SVMXC__StartDateTime__c FROM SVMXC__SVMX_Event__c WHERE SVMXC__Service_Order__c = :wo.Id];
                
                for (SVMXC__SVMX_Event__c e : svmxEventList)
                {
                    if (startDate == null || e.SVMXC__StartDateTime__c.dateGMT() < startDate)
                    {
                        startDate = e.SVMXC__StartDateTime__c.dateGMT();
                    }
                    
                    if (endDate == null || e.SVMXC__EndDateTime__c.dateGMT() > endDate)
                    {
                        endDate = e.SVMXC__EndDateTime__c.dateGMT();
                    }
                }
                
                for (SVMXC__SVMX_Event__c e : [SELECT Id, SVMXC__EndDateTime__c, SVMXC__StartDateTime__c, SVMXC__Service_Order__c FROM SVMXC__SVMX_Event__c WHERE SVMXC__Technician__c = :tech.Id AND DAY_ONLY(SVMXC__EndDateTime__c) >= :startDate AND DAY_ONLY(SVMXC__StartDateTime__c) <= :endDate AND SVMXC__Service_Order__c != :wo.Id ])
                {
                    errorMap.put(e.SVMXC__Service_Order__c, e.SVMXC__StartDateTime__c.date().format() + ' to ' + e.SVMXC__EndDateTime__c.date().format());
                }
            }
            
            
            if (! errorMap.isEmpty())
            {
                for (SVMXC__Service_Order__c otherWO : [SELECT Id, Name FROM SVMXC__Service_Order__c WHERE Id IN :errorMap.keySet()])
                {
                    errorMap.put(otherWO.Id, 'Conflict with: ' + otherWO.Name + ': ' + errorMap.get(otherWO.Id));
                }
                
                wo.GE_OG_GS_Assignment_Warnings__c = String.join(new List<String>(errorMap.values()), '\n');
            }
            else
            {
                wo.GE_OG_GS_Assignment_Warnings__c = null;
            }
        }
        
        SVMXC.SFM_WrapperDef.SFM_PageData pageData = new SVMXC.SFM_WrapperDef.SFM_PageData();
        pageData =  servicesDef.SFM_Page_BuildResponse(request,header,detailListMap);
        system.debug('*****'+pageData); 
        return pageData;
    }

    webservice static SVMXC.SFM_WrapperDef.SFM_PageData checkDoubleBookingAssignmentRevision(SVMXC.SFM_WrapperDef.SFM_TargetRecord request)
    {
        SVMXC.SFM_ServicesDef servicesDef = new SVMXC.SFM_ServicesDef();
        map<String,Schema.SObjectType> allObjMap = Schema.getGlobalDescribe();  
        Sobject header = servicesDef.SFM_Page_GetHeaderRecord(request,allObjMap);
        map<String,List<Sobject>> detailListMap = servicesDef.SFM_Page_GetDetailRecords(request,allObjMap);
        map<String,Schema.SObjectType> detailMap = new map<String,Schema.SObjectType>();
        
        SVMXC__Service_Order__c wo = (SVMXC__Service_Order__c) header;

        SVMXC__Service_Order__c woSaved = [SELECT Id, SVMXC__Group_Member__c, SVMXC__Order_Type__c, GE_OG_GS_Accept_Revision__c, GE_OG_GS_Planned_End_Date__c, GE_OG_GS_Planned_Start_Date__c FROM SVMXC__Service_Order__c WHERE Id = :wo.Id LIMIT 1];
        system.debug(woSaved);
        if (wo.SVMXC__Group_Member__c != null)
        {
            SVMXC__Service_Group_Members__c tech = [SELECT Id, SVMXC__Salesforce_User__c FROM SVMXC__Service_Group_Members__c WHERE Id = :wo.SVMXC__Group_Member__c LIMIT 1];
            Date startDate = null;
            Date endDate = null;
            Map<Id, String> errorMap = new Map<Id, String>();
            
            if (tech.SVMXC__Salesforce_User__c != null)
            {
                startDate = woSaved.GE_OG_GS_Planned_Start_Date__c;
                endDate = woSaved.GE_OG_GS_Planned_End_Date__c;
                
                for (Event e : [SELECT Id, StartDateTime, EndDateTime, WhatId FROM Event WHERE OwnerId = :tech.SVMXC__Salesforce_User__c AND DAY_ONLY(EndDateTime) >= :startDate AND DAY_ONLY(StartDateTime) <= :endDate AND WhatId != :wo.Id]) 
                {
                    errorMap.put(e.WhatId, e.StartDateTime.date().format() + ' to ' + e.EndDateTime.date().format());
                } 
            
            }
            else
            {

                startDate = woSaved.GE_OG_GS_Planned_Start_Date__c;
                endDate = woSaved.GE_OG_GS_Planned_End_Date__c;
                                
                for (SVMXC__SVMX_Event__c e : [SELECT Id, SVMXC__EndDateTime__c, SVMXC__StartDateTime__c, SVMXC__Service_Order__c FROM SVMXC__SVMX_Event__c WHERE SVMXC__Technician__c = :tech.Id AND DAY_ONLY(SVMXC__EndDateTime__c) >= :startDate AND DAY_ONLY(SVMXC__StartDateTime__c) <= :endDate AND SVMXC__Service_Order__c != :wo.Id ])
                {
                    errorMap.put(e.SVMXC__Service_Order__c, e.SVMXC__StartDateTime__c.date().format() + ' to ' + e.SVMXC__EndDateTime__c.date().format());
                }
            }
            
            
            if (! errorMap.isEmpty())
            {
                for (SVMXC__Service_Order__c otherWO : [SELECT Id, Name FROM SVMXC__Service_Order__c WHERE Id IN :errorMap.keySet()])
                {
                    errorMap.put(otherWO.Id, 'Conflict with: ' + otherWO.Name + ': ' + errorMap.get(otherWO.Id));
                }
                
                wo.GE_OG_GS_Assignment_Warnings__c = String.join(new List<String>(errorMap.values()), '\n');
            }
            else
            {
                wo.GE_OG_GS_Assignment_Warnings__c = null;
            }
        }
        
        SVMXC.SFM_WrapperDef.SFM_PageData pageData = new SVMXC.SFM_WrapperDef.SFM_PageData();
        pageData =  servicesDef.SFM_Page_BuildResponse(request,header,detailListMap);
        system.debug('*****'+pageData); 
        return pageData;
    }
}