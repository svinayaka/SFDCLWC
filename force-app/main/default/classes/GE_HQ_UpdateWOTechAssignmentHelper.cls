public class GE_HQ_UpdateWOTechAssignmentHelper{
 
    public void techAssignmentbeforeInsert(List<SVMXC__Service_Order__c> insertedWOs)
    {
        Set<Id> techIdSet = new Set<Id>();
        Set<Id> accountIdSet = new Set<Id>();
        Set<Id> installedIdSet = new Set<Id>();
        Set<Id> unassignedTechIdSet = new Set<Id>();
        Set<String> unassignedWOIdSet = new Set<String>();
        Set<String> countrySet = new Set<String>();
        Boolean flag ;
        
        Map<String, Id> recordTypeMap = new Map<String, Id>();
        for (RecordType rt : [SELECT Id, Name FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c'])
        {
            recordTypeMap.put(rt.Name, rt.Id);
        } 
        
        for(SVMXC__Service_Order__c wo: insertedWOs)
        {
            if(wo.GE_SM_HQ_Borrowed_Technician_Rejected__c) 
            {
                wo.GE_SM_HQ_Borrowed_Technician_Rejected__c = false;
                wo.SVMXC__Group_Member__c = null;
                wo.SVMXC__Last_Dispatch_Event__c = null;
            }
            
            if(wo.SVMXC__Group_Member__c != null)
            {
                techIdSet.add(wo.SVMXC__Group_Member__c);
              //  wo.GE_SM_PW_PGS_Technician_Restricted__c = false; Commented as part of requirement R-26296 and added below  line
                flag=false;
                //wo.GE_SM_PW_PGS_Days_Needed_For_Visa__c = null;
                //wo.GE_SM_PW_PGS_Travel_Approval__c = null;
                wo.GE_SM_HQ_Dispatcher_Name__c = UserInfo.getName();
                wo.SVMXC__Last_Dispatch_Event__c = null;
            }
        }
        
        
        
        
        if (techIdSet.size() > 0)
        {
            Map<Id, SVMXC__Service_Group_Members__c> techMap = new Map<Id, SVMXC__Service_Group_Members__c>([SELECT Id, SVMXC__Email__c, SVMXC__Country__c, SVMXC__Service_Group__c, SVMXC__Service_Group__r.GE_HQ_Resource_Director__c, GE_SM_HQ_Controls_EmpType__c, GE_SM_PW_PGS_Number_Of_Short_Tasks__c  FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet]);
            List<SVMXC__Dispatcher_Access__c> dispatcherList = [SELECT Id, GE_HQ_Not_Home_Territory__c, SVMXC__Dispatcher__c, SVMXC__Service_Team__c FROM SVMXC__Dispatcher_Access__c WHERE SVMXC__Service_Team__c IN (SELECT SVMXC__Service_Group__c FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet)];
            
            
            for(SVMXC__Service_Order__c wo: insertedWOs)
            {
                if (techMap.containsKey(wo.SVMXC__Group_Member__c))
                {
                    SVMXC__Service_Group_Members__c tech = techMap.get(wo.SVMXC__Group_Member__c);
                    
                   // if (! wo.GE_SM_PW_PGS_Technician_Restricted__c) Commented as part of requirement R-26296 and added below  line 
                    if(!flag)
                    {    
                        wo.SVMXC__Member_Email__c = tech.SVMXC__Email__c;
                        wo.GE_SM_HQ_Borrowed_Technician_Approved_On__c = null;
                        wo.GE_SM_HQ_Technician_Type__c = tech.GE_SM_HQ_Controls_EmpType__c;
                        wo.SVMXC__Service_Group__c = tech.SVMXC__Service_Group__c;
                        wo.GE_SM_HQ_Technician_Home_Dispatcher__c = tech.SVMXC__Service_Group__r.GE_HQ_Resource_Director__c;
                        wo.GE_SM_HQ_Dispatched_Outside_Territory__c = false;
                        wo.GE_SM_HQ_Assigned_On__c = system.now();
                        wo.GE_SM_HQ_Dispatcher_Email__c = userInfo.getUserEmail();
                    
                    //User currentUser = [SELECT Email From User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        
                        for (SVMXC__Dispatcher_Access__c dispatcher : dispatcherList)
                        {
                            system.debug(dispatcher);
                            if (dispatcher.SVMXC__Dispatcher__c == UserInfo.getUserId() && dispatcher.GE_HQ_Not_Home_Territory__c)
                            {
                                wo.GE_SM_HQ_Dispatched_Outside_Territory__c = true;
                            }
                        }
                    }   
                }
            }
        }
    
    }
    
    
    public void techAssignmentbeforeUpdate(List<SVMXC__Service_Order__c> insertedWOs, List<SVMXC__Service_Order__c> oldWOs)
    {
        Set<Id> techIdSet = new Set<Id>();
        Set<Id> accountIdSet = new Set<Id>();
        Set<Id> installedIdSet = new Set<Id>();
        Set<Id> unassignedTechIdSet = new Set<Id>();
        Set<String> unassignedWOIdSet = new Set<String>();
        Set<String> countrySet = new Set<String>();
        Boolean flag ;
        
        Map<String, Id> recordTypeMap = new Map<String, Id>();
        for (RecordType rt : [SELECT Id, Name FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c'])
        {
            recordTypeMap.put(rt.Name, rt.Id);
        } 
        
        for(SVMXC__Service_Order__c wo: oldWOs)
        {
            for(SVMXC__Service_Order__c newWO:insertedWOs)
            {
     
                if(wo.GE_SM_HQ_Borrowed_Technician_Rejected__c) 
                {
                    newWO.GE_SM_HQ_Borrowed_Technician_Rejected__c = false;
                    newWO.SVMXC__Group_Member__c = null;
                    newWO.SVMXC__Last_Dispatch_Event__c = null;
                }
            
                if(wo.SVMXC__Group_Member__c != null && wo.SVMXC__Group_Member__c != newWO.SVMXC__Group_Member__c)
                {
                    techIdSet.add(newWO.SVMXC__Group_Member__c);
                    //newWO.GE_SM_PW_PGS_Technician_Restricted__c = false; Commented as part of requirement R-26296 and added below  line 
                    flag= false;
                    //newWO.GE_SM_PW_PGS_Days_Needed_For_Visa__c = null;
                    //newWO.GE_SM_PW_PGS_Travel_Approval__c = null;
                    newWO.GE_SM_HQ_Dispatcher_Name__c = UserInfo.getName();
                    newWO.SVMXC__Last_Dispatch_Event__c = null;
                    
                    if(!wo.GE_SM_HQ_Dispatched_Outside_Territory__c && wo.GE_SM_HQ_Borrowed_Technician_Approved_On__c!=null)
                    {
                        newWO.GE_SM_HQ_Previous_Member_Email__c = wo.SVMXC__Member_Email__c;
                    }
                    
                    if(newWO.SVMXC__Group_Member__c == null)
                    {
                        newWO.SVMXC__Member_Email__c = null;
                        newWO.GE_SM_HQ_Borrowed_Technician_Approved_On__c = null;
                        newWO.GE_SM_HQ_Technician_Home_Dispatcher__c = null;
                        newWO.GE_SM_HQ_Technician_Type__c = null;
                        newWO.SVMXC__Service_Group__c = null;
                        newWO.GE_SM_HQ_Dispatched_Outside_Territory__c = false;
                        newWO.SVMXC__Group_Member__c = null;
                        //newWO.GE_SM_PW_PGS_Technician_Restricted__c = false; Commented as part of requirement R-26296 and added below  line 
                        flag=false;
                    }
                    
                    newWO.SVMXC__Last_Dispatch_Event__c = null;
                }
                
            }
        
        
        
        }
        if (techIdSet.size() > 0)
        {
            Map<Id, SVMXC__Service_Group_Members__c> techMap = new Map<Id, SVMXC__Service_Group_Members__c>([SELECT Id, SVMXC__Email__c, SVMXC__Country__c, SVMXC__Service_Group__c, SVMXC__Service_Group__r.GE_HQ_Resource_Director__c, GE_SM_HQ_Controls_EmpType__c, GE_SM_PW_PGS_Number_Of_Short_Tasks__c  FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet]);
            List<SVMXC__Dispatcher_Access__c> dispatcherList = [SELECT Id, GE_HQ_Not_Home_Territory__c, SVMXC__Dispatcher__c, SVMXC__Service_Team__c FROM SVMXC__Dispatcher_Access__c WHERE SVMXC__Service_Team__c IN (SELECT SVMXC__Service_Group__c FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet)];
            
            
            for(SVMXC__Service_Order__c wo1: insertedWOs)
            {
                if (techMap.containsKey(wo1.SVMXC__Group_Member__c))
                {
                    SVMXC__Service_Group_Members__c tech = techMap.get(wo1.SVMXC__Group_Member__c);
                    
                   // if (! wo1.GE_SM_PW_PGS_Technician_Restricted__c) Commented as part of requirement R-26296 and added below  line 
                    if(!flag)
                    {    
                        wo1.SVMXC__Member_Email__c = tech.SVMXC__Email__c;
                        wo1.GE_SM_HQ_Borrowed_Technician_Approved_On__c = null;
                        wo1.GE_SM_HQ_Technician_Type__c = tech.GE_SM_HQ_Controls_EmpType__c;
                        wo1.SVMXC__Service_Group__c = tech.SVMXC__Service_Group__c;
                        wo1.GE_SM_HQ_Technician_Home_Dispatcher__c = tech.SVMXC__Service_Group__r.GE_HQ_Resource_Director__c;
                        wo1.GE_SM_HQ_Dispatched_Outside_Territory__c = false;
                        wo1.GE_SM_HQ_Assigned_On__c = system.now();
                        wo1.GE_SM_HQ_Dispatcher_Email__c = userInfo.getUserEmail();
                    
                    //User currentUser = [SELECT Email From User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        
                        for (SVMXC__Dispatcher_Access__c dispatcher : dispatcherList)
                        {
                            system.debug(dispatcher);
                            if (dispatcher.SVMXC__Dispatcher__c == UserInfo.getUserId() && dispatcher.GE_HQ_Not_Home_Territory__c)
                            {
                                wo1.GE_SM_HQ_Dispatched_Outside_Territory__c = true;
                            }
                        }
                    }   
                }
            }
        
    
        }
    }
 


}