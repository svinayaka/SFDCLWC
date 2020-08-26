Trigger GE_HQ_AfterWorkOrderTechAssignment on SVMXC__Service_Order__c (after insert, after update) {
    
    Set<Id> woIdset = new Set<Id>();
    Set<Id> techIdSet = new Set<Id>();
    Boolean insertNew = false;
    
    public static integer check=0;
    
    if (GE_HQ_UpdateWorkOrderTechAssignment.sentToApproval)
    {
        return;
    }
    
    for (SVMXC__Service_Order__c wo : trigger.new)
    {
        SVMXC__Service_Order__c beforeUpdate = null;
        
        if (trigger.isUpdate)
        {
            beforeUpdate = trigger.oldMap.get(wo.Id);
        }
        
        System.debug('SVMX : wo is ' +wo);
        
        /*
Case 10108 - Updated code to send approval process if technician is assigned by dragging either to Gantt chart or directly to Technician
Used Future call
*/
       /* if (wo.GE_SM_HQ_Record_Type_Name__c =='MCS' && wo.SVMXC__Group_Member__c != null 
            && wo.GE_SM_HQ_Dispatched_Outside_Territory__c 
            && wo.GE_SM_HQ_Borrowed_Technician_Approved_On__c == null
            && ! wo.GE_SM_PW_PGS_Technician_Restricted__c 
            && (trigger.isInsert || wo.SVMXC__Group_Member__c != beforeUpdate.SVMXC__Group_Member__c)
            )*/// Commented as part of requirement R-26296
        if (wo.GE_SM_HQ_Record_Type_Name__c =='MCS' && wo.SVMXC__Group_Member__c != null 
            && wo.GE_SM_HQ_Dispatched_Outside_Territory__c 
            && wo.GE_SM_HQ_Borrowed_Technician_Approved_On__c == null
            && (trigger.isInsert || wo.SVMXC__Group_Member__c != beforeUpdate.SVMXC__Group_Member__c)
            ) 
        {

     //code related to approval process
       
       GE_HQ_UpdateWorkOrderTechAssignment.sentToApproval = true;
      
       if(!Test.isRunningTest()){
       
       SVMX_Utility.sendApprovalEmail(wo.Id);
       
       }
       Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
       req1.setComments('Technician is assigned from outside region.');
       req1.setObjectId(wo.Id);
       Approval.ProcessResult result = Approval.process(req1);
        
        }
        
        if (wo.SVMXC__Group_Member__c != null && wo.GE_SM_HQ_Scheduled_End_Date_Time__c != null && wo.GE_SM_HQ_Scheduled_Start_Date_Time__c != null && (trigger.isInsert || wo.SVMXC__Group_Member__c != beforeUpdate.SVMXC__Group_Member__c || wo.GE_SM_HQ_Scheduled_Start_Date_Time__c != beforeUpdate.GE_SM_HQ_Scheduled_Start_Date_Time__c || wo.GE_SM_HQ_Scheduled_End_Date_Time__c != beforeUpdate.GE_SM_HQ_Scheduled_End_Date_Time__c))
        {
            woIdSet.add(wo.Id);
            techIdSet.add(wo.SVMXC__Group_Member__c);
            if (trigger.isUpdate && wo.GE_SM_HQ_Scheduled_End_Date_Time__c == beforeUpdate.GE_SM_HQ_Scheduled_End_Date_Time__c && wo.GE_SM_HQ_Scheduled_Start_Date_Time__c == beforeUpdate.GE_SM_HQ_Scheduled_Start_Date_Time__c && wo.SVMXC__Group_Member__c != beforeUpdate.SVMXC__Group_Member__c)
            {
                insertNew = true;
            }
            /*
Case #8619
Sajana - Modified to include check on old start and end date before creating event
26 Nov 2013 - Modified to replace workflow GE_OG_DS_AssignFEWorkOrder
*/
            /*if((wo.GE_SM_HQ_Record_Type_Name__c == 'MCS' 
|| (wo.GE_SM_HQ_Record_Type_Name__c == 'D&S'
&& wo.SVMXC__NoOfTimesAssigned__c >= 1))
&& wo.GE_SM_HQ_Dispatched_Outside_Territory__c == false
&& wo.SVMXC__Group_Member__c != null 
&& Trigger.oldMap.get(wo.id).SVMXC__Group_Member__c == null
&& wo.GE_SM_HQ_Scheduled_Start_Date_Time__c != null
&& (wo.GE_SM_HQ_Scheduled_Start_Date_Time__c == Trigger.oldMap.get(wo.id).GE_SM_HQ_Scheduled_Start_Date_Time__c
|| wo.GE_SM_HQ_Scheduled_End_Date_Time__c == Trigger.oldMap.get(wo.id).GE_SM_HQ_Scheduled_End_Date_Time__c))
{
SVMX_Utility.idset.add(wo.id);
}*/
        }
        
    }
    
 /*   if (woIdSet.size() > 0)
    {
        List<SVMXC__SVMX_Event__c> eventList = [SELECT Id, Name, SVMXC__StartDateTime__c, SVMXC__EndDateTime__c, SVMXC__WhatId__c, SVMXC__Technician__c FROM SVMXC__SVMX_Event__c WHERE SVMXC__WhatId__c IN :woIdSet];
        List<SVMXC__SVMX_Event__c> updatedEventList = new List<SVMXC__SVMX_Event__c>();
        
        
        for (SVMXC__Service_Order__c wo : trigger.new)
        {
            SVMXC__Service_Order__c beforeUpdate = null;
            
            if (trigger.isUpdate)
            {
                beforeUpdate = trigger.oldMap.get(wo.Id);
            }
            
            if (woIdSet.contains(wo.Id) && wo.GE_SM_HQ_Record_Type_Name__c =='MCS')
            {
                SVMXC__SVMX_Event__c event = null;
                for (SVMXC__SVMX_Event__c e : eventList)
                {
                    if (e.SVMXC__WhatId__c == wo.Id)
                    {
                        event = e;
                    }
                }
                
                if (event != null || insertNew)
                {
                    if (event == null)
                    {
                        event = new SVMXC__SVMX_Event__c();
                    }
                    
// to resolve owner issue

event.SVMXC__Technician__c = wo.SVMXC__Group_Member__c;
event.SVMXC__Service_Team__c = wo.SVMXC__Service_Group__c;
event.SVMXC__WhatId__c = String.valueOf(wo.Id);
event.SVMXC__StartDateTime__c = wo.GE_SM_HQ_Scheduled_Start_Date_Time__c;
event.SVMXC__EndDateTime__c = wo.GE_SM_HQ_Scheduled_End_Date_Time__c;
                    
                    
                    if(wo.GE_SM_HQ_Record_Type_Name__c =='MCS'&&wo.GE_OG_MC_Subject__c!=null)
                    {                 
                            event.Name=wo.GE_OG_MC_Subject__c;
                            System.debug('subject on WO is ----:'+event.Name);
                    }
                    else
                    {
                           event.Name = wo.Name;
                           System.debug('subject on WO in else loop------ is :'+event.Name);
                        
                    }
                    updatedEventList.add(event);
                }
            }
            
            upsert updatedEventList;
            System.debug('SVMX : updatedEventList id ' +updatedEventList);
        }
    }*/
}