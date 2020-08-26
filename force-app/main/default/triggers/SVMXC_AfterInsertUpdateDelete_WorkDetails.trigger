trigger SVMXC_AfterInsertUpdateDelete_WorkDetails on SVMXC__Service_Order_Line__c ( before delete,after insert, after update) {
    
    Map<Id, Schema.RecordTypeInfo> wdRecordType = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosById(); 
    public static Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
    public static Id rtWOtripId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
    Set<String> subSeaRecordTypes = new Set<String>();
    subSeaRecordTypes.add('Equipment');
    subSeaRecordTypes.add('Spares');
    subSeaRecordTypes.add('Tools');
    public static Set<ID> techIDs = new Set<Id>();
    public static Set<ID> woIDs = new Set<Id>();
    public static Map<Id, SVMXC__Service_Order__c> woMap;
    public boolean callTrigger=false;
    
    
    //This is non-SubSea.  Needs to be modified to exclude SubSea 
    if (Trigger.isInsert)
    {   GE_OG_WorkDetailTriggerHandler.OnAfterInsert(Trigger.new); //END R-26304
     if (!SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPostInsertTimesheets() )
     {
         SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPostInsertTimesheets();
         ServiceMaxTimesheetUtils.createTimeEventsFromWorkDetails(trigger.new);   
     }
    }
    else if (Trigger.isUpdate)
    {   GE_OG_WorkDetailTriggerHandler.OnAfterUpdate(Trigger.old,Trigger.new,Trigger.newMap); //END R-26304
     if (!SVMX_TimesheetRecursiveSaveHelper.isAlreadyRunPostUpdateTimesheets() )
     {
         SVMX_TimesheetRecursiveSaveHelper.setAlreadyRunPostUpdateTimesheets();
         ServiceMaxTimesheetUtils.createTimeEventsFromWorkDetails(trigger.new);   
     }
    }
    
    else if(Trigger.isDelete){
        //Below Code is Added for the Subsea - R-29773
        GE_OG_WorkDetailTriggerHandler.OnBeforeDelete(Trigger.old);
        //Ended code for Subsea - R-29773
    }
    
    //Begin Subsea Code    
   /* if (Trigger.isInsert || Trigger.isUpdate) {
        
        List<SVMXC__Service_Order_Line__c> subSeaRecordsList = new List<SVMXC__Service_Order_Line__c>();
        Set<Id> IPSet = new Set<Id>();
        
        Map<Id, String> subSeaRTLookupMap = new Map<Id, String>();
        //Adding RecordType Check ass part of R-28924
        for(SVMXC__Service_Order_Line__c wdl : Trigger.new)
        {
            woIDs.add(wdl.SVMXC__Service_Order__c);
        }
        if(!woIDs.isempty())
        {
            woMap = new Map<Id, SVMXC__Service_Order__c>([Select Id,RecordTypeId, RecordType.Name from SVMXC__Service_Order__c 
                                                          where Id in :woIDs]);
        }//END R-28924
        
        for (SVMXC__Service_Order_Line__c wd : Trigger.new) { 
            RecordTypeInfo recTypeInfo = wdRecordType.get(wd.recordTypeId);
            //Added below If as part of R-28924
            if (woMap.get(wd.SVMXC__Service_Order__c).RecordTypeId==rtWOId || woMap.get(wd.SVMXC__Service_Order__c).RecordTypeId==rtWOtripId)
            {
                if((recTypeInfo != null && subSeaRecordTypes.contains(recTypeInfo.getName()) && wd.SVMXC__Serial_Number__c != null) || Test.isRunningTest()) {
                    
                    subSeaRecordsList.add(wd);
                    if (!IPSet.contains(wd.SVMXC__Serial_Number__c))
                        IPSet.add(wd.SVMXC__Serial_Number__c);     
                    subSeaRTLookupMap.put(wd.Id, recTypeInfo.getName());        
                }
            }
        }
        
        if (!subSeaRecordsList.isEmpty()) {
            SVMXC_WorkDetailsAfter.syncWDLwithIP(subSeaRecordsList, trigger.oldMap, Trigger.isInsert, Trigger.isUpdate, IPSet, subSeaRTLookupMap);
        }
    } */  //Code Commented by NS on 16th April 2019 and merge with SVMXC_WorkOrderLinesAfter.updateFSProjectInIB 
    
    //Below code is added as part of R-26304
    //Creating new Usage/Consumption Work Detail Lines
    
    if(Trigger.isAfter){
        List<SVMXC__Service_Order_Line__c> wdlaborlst = new List<SVMXC__Service_Order_Line__c>();
        for(SVMXC__Service_Order_Line__c wdl : Trigger.new)
        {
            woIDs.add(wdl.SVMXC__Service_Order__c);
        }
        if(!woIDs.isempty())
        {
            woMap = new Map<Id, SVMXC__Service_Order__c>([Select Id,SVMXC__Billing_Type__c,GE_OG_DS_SVMX_Non_Billable_Reason__c,
                                                          RecordTypeId, RecordType.Name from SVMXC__Service_Order__c where Id in :woIDs]);
        }
        if (woMap != null)
        {
            for(SVMXC__Service_Order_Line__c allwdl : Trigger.new){
                
                if (woMap.get(allwdl .SVMXC__Service_Order__c).RecordTypeId==rtWOId && allwdl.SVMXC__Line_Type__c=='Labor')
                {
                    
                    callTrigger=True;
                }
                
            }
        }
        
        if((Trigger.isInsert&&callTrigger==True) || Test.isRunningTest())
        {            
            GE_SS_Creating_TaskWorkDtls.GE_SS_NewWL(Trigger.new,Trigger.oldMap);    
                    
        }  
        
        if(Trigger.isInsert && trigger.isAfter){
            GE_SS_Creating_TaskWorkDtls.GE_SS_NewToolsWLCreation(Trigger.new)  ;  //For R-30139
        }                              
        
        if(Trigger.isUpdate){                  
            for(SVMXC__Service_Order_Line__c allwdl : Trigger.new){
                if(woMap.get(allwdl.SVMXC__Service_Order__c).RecordTypeId==rtWOId && allwdl.SVMXC__Line_Type__c=='Labor'&& allwdl.SVMXC__Group_Member__c!= Null&& (woMap.get(allwdl.SVMXC__Service_Order__c).GE_OG_DS_SVMX_Non_Billable_Reason__c !='On the Job Training'||woMap.get(allwdl.SVMXC__Service_Order__c).GE_OG_DS_SVMX_Non_Billable_Reason__c !='Technician in Training')&& (allwdl.SVMXC__Line_Status__c!='Canceled'||allwdl.SVMXC__Line_Status__c!='Open'))
                {
                    techIDs.add(allwdl.SVMXC__Group_Member__c); 
                }
            }
           // if(techIDs!= null){   Modified by NS on 1/14/2019 for SubSea integration R-31031
            if(techIDs!= null && !System.isBatch()){         
                GE_SS_Creating_TaskWorkDtls.updateActualdaysonTech(techIDs);          
            }  
            
        }  
    } //END of  R-26304    
    
    //R-26508 : Below code is added
    List<SVMXC__Service_Order__c> woList = new List<SVMXC__Service_Order__c>();
    Set<Id> woIdSet = new Set<Id>();
    if(Trigger.isAfter)
    {
        for(SVMXC__Service_Order_Line__c wd : Trigger.new)
        {
            if(wd.SVMXC__Line_Type__c=='Product')
            { 
                woIdSet.add(wd.SVMXC__Service_Order__c);
            }    
        }
        if(woIdSet.size()>0)
        {
            woList = [Select Id, SVMXC__Skill_Set__c, RecordTypeId, RecordType.Name from SVMXC__Service_Order__c where Id in :woIdSet];
            
            GE_OG_WorkOrderUpdate wrkupdate = new GE_OG_WorkOrderUpdate();
            wrkupdate.updateWOJobTypeSkillset(woList,woList,'');
        }    
        
    }   
    //R-26508 Ends  
}