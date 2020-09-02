public without sharing class ServiceMaxTimesheetUtils {

    public static boolean trg_insert_fired = false;
    
    public static Map<String, String>  appSettings = null;
    public static Map<Id, Set<SVMXC_Timesheet__c>> timesheetMap = new Map<Id, Set<SVMXC_Timesheet__c>>();
    public static String recordTypeWDTimeName = 'Usage/Consumption';
    public static String recordTypeWDTravelName = 'Usage/Consumption';
    public static String lineTypeTime = 'Labor';
    public static String lineTypeTravel = 'Travel';
    public static Map<String, Map<String,Id>> recordTypeMap = new Map<String, Map<String, Id>>();
    public static Map<String, Map<Id, String>> recordTypeIdMap = new Map<String, Map<Id, String>>();
    
    public static Map<String, Id> getRecordTypeMap(String sObjectName)
    {
        /*
        if (! recordTypeMap.containsKey(sObjectName))
        {
            recordTypeMap.put(sObjectName, new Map<String, Id>());
            
            for (RecordType rt : [Select ID, Name FROM RecordType WHERE sObjectType = :sObjectName])
            {
                recordTypeMap.get(sObjectName).put(rt.Name, rt.Id);
            }
        }
        
        return recordTypeMap.get(sObjectName);
        
        */

        // Bug fix to eliminate too many SOQL queries in Timesheet code
        Map<String, Schema.RecordTypeInfo> WDType = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName();       
        
        if (WDType != null)
        { 
                recordTypeMap.put('SVMXC__Service_Order_Line__c', new Map<String, Id>());
            
                for (Schema.RecordTypeInfo rti : WDType.values())
                {
                    recordTypeMap.get('SVMXC__Service_Order_Line__c').put(rti.getName(), rti.getRecordTypeId());
                }
        }

        return recordTypeMap.get('SVMXC__Service_Order_Line__c');
        
    }
    
    public static Boolean isLaborWD(SVMXC__Service_Order_Line__c detail)
    {
        if (detail != null && detail.RecordTypeId == getRecordTypeMap('SVMXC__Service_Order_Line__c').get(recordTypeWDTimeName) 
               && (lineTypeTime == null || detail.SVMXC__Line_Type__c == lineTypeTime))
        {
            return true;
        }
        
        return false;
    }
    
    public static Boolean isTravelWD(SVMXC__Service_Order_Line__c detail)
    {
        if (detail != null && recordTypeWDTravelName != null 
               && detail.RecordTypeId == getRecordTypeMap('SVMXC__Service_Order_Line__c').get(recordTypeWDTravelName) 
               && (lineTypeTravel == null || detail.SVMXC__Line_Type__c == lineTypeTravel))
        {
            return true;
        }
        
        return false;
    }

    public static void createTimeEventsFromWorkDetails(List<SVMXC__Service_Order_Line__c> detailList)
    {
        System.debug('Work Detail List: ' + detailList.size());
        Set<Id> wdIdSet = new Set<Id>();
        Set<Id> woIdSet = new Set<Id>();
        Set<Id> techIdSet = new Set<Id>();
        
        for (SVMXC__Service_Order_Line__c detail : detailList)
        {
            if (isLaborWD(detail) || isTravelWD(detail))
            {
                wdIdSet.add(detail.Id);
                woIdSet.add(detail.SVMXC__Service_Order__c);
                techIdSet.add(detail.SVMXC__Group_Member__c);
            }
        }
        
        //Change made by Ryan Cerankowski, ForeFront, 3/24/2014
        //Get Record type
        Schema.SObjectType s = SVMXC_Time_Entry__c.sObjectType;
        Schema.DescribeSObjectResult resSchema = s.getDescribe();
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); //getting all Recordtype for the Sobject
        Id rtId;
        
        //try{
            //SVMXC__Service_Order__c svmxcWO = [SELECT Id, GE_SM_HQ_Record_Type_Name__c FROM SVMXC__Service_Order__c WHERE Id in :woIdSet LIMIT 1];
            //String rtypeName = svmxcWO.GE_SM_HQ_Record_Type_Name__c;
            //If the record type is in the approved list of timesheet record types         
            //System.debug('SANDIP - Label=' + Label.GE_DS_Timesheet_Module_Active_Record_Types.contains(rtypeName));
            //System.debug('SANDIP - true/false? rtypeName =' + rTypeName + ' result: ' + Label.GE_DS_Timesheet_Module_Active_Record_Types.contains(rtypeName));
            //if(Label.GE_DS_Timesheet_Module_Active_Record_Types.contains(rtypeName)){
            //    rtId = recordTypeInfo.get(rtypeName).getRecordTypeId();//particular RecordId by  Name
            //}
        //}catch(Exception e){
        //    System.debug(e);
        //}
        //End Change
        System.debug(wdIdSet.size());
        if (wdIdSet.size() > 0)
        {
            List<SVMXC_Time_Entry__c> entryList = [SELECT Id, Work_Details__c, Activity__c, Technician__c, Miles_Driven__c,End_Date_Time__c, Start_Date_Time__c FROM SVMXC_Time_Entry__c WHERE Work_Details__c IN :wdIdSet];
            if (entryList.size() > 0)
            {
                delete entryList;
            }
            
            Map<Id, SVMXC__Service_Group_Members__c> techMap = new Map<Id, SVMXC__Service_Group_Members__c>([SELECT Id FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet]); // AND SVMXC__Salesforce_User__c != null]);
           /* Map<Id, SVMXC__Service_Order__c> woMap = new Map<Id, SVMXC__Service_Order__c>([SELECT Id, SVMXC__Group_Member__c, SVMXC__Group_Member__r.GE_OG_DS_Bonus_Rate__c, SVMXC__Group_Member__r.GE_OG_DS_Bonus_Rate_Type__c, 
                        GE_DS_Bonus_Percentage__c,  SVMXC__Company__c, RecordType.Name, GE_SM_HQ_Record_Type_Name__c FROM SVMXC__Service_Order__c WHERE Id IN :woIdSet ]);
           */ //Commented as per the R-26367 as deleting field GE_DS_Bonus_Percentage__c
           Map<Id, SVMXC__Service_Order__c> woMap = new Map<Id, SVMXC__Service_Order__c>([SELECT Id, SVMXC__Group_Member__c, SVMXC__Group_Member__r.GE_OG_DS_Bonus_Rate__c, SVMXC__Group_Member__r.GE_OG_DS_Bonus_Rate_Type__c, 
                       SVMXC__Company__c, RecordType.Name, GE_SM_HQ_Record_Type_Name__c FROM SVMXC__Service_Order__c WHERE Id IN :woIdSet ]);
           
            List<SVMXC_Time_Entry__c> updateEntryList = new List<SVMXC_Time_Entry__c>();
                    System.debug(' HERE 8');
            
            
            for (SVMXC__Service_Order_Line__c detail : detailList)
            {
                    //System.debug(' HERE 9' + ' isLabor?:' + isLaborWD(detail) + ' isTravel?:' + isTravelWD(detail) + ' StartDateTime:' + detail.SVMXC__Start_Date_and_Time__c + ' techMap ContainsKey?:' + techMap.containsKey(detail.SVMXC__Group_Member__c) + ' Rceord TYpe Name:' +  woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name );
                
                if ((isLaborWD(detail) || isTravelWD(detail)) && detail.SVMXC__Start_Date_and_Time__c != null 
                        && techMap.containsKey(detail.SVMXC__Group_Member__c) 
                        && (woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name == 'D&S' || woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name == 'AL' || woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name == 'PC'))
                {
                    SVMXC__Service_Order__c wo = woMap.get(detail.SVMXC__Service_Order__c);
                    
                    String rtypeName = wo.GE_SM_HQ_Record_Type_Name__c;
                    //If the record type is in the approved list of timesheet record types         
                    System.debug(' - Label=' + Label.GE_DS_Timesheet_Module_Active_Record_Types.contains(rtypeName));
                    System.debug(' - true/false? rtypeName =' + rTypeName + ' result: ' + Label.GE_DS_Timesheet_Module_Active_Record_Types.contains(rtypeName));
                    if(Label.GE_DS_Timesheet_Module_Active_Record_Types.contains(rtypeName)){
                        rtId = recordTypeInfo.get(rtypeName).getRecordTypeId();//particular RecordId by  Name
                    }
                    
                    
                    
                    SVMXC_Time_Entry__c entry = new SVMXC_Time_Entry__c();
                    entry.Work_Details__c = detail.Id;
                    entry.Activity__c = detail.SVMXC__Activity_Type__c;
                    entry.Start_Date_Time__c = detail.SVMXC__Start_Date_and_Time__c;
                    
                    
                    entry.Miles_Driven__c = detail.Miles_Driven__c;
                    entry.Is_Billable__c = detail.SVMXC__Is_Billable__c;
                    entry.Associated_Account__c = wo.SVMXC__Company__c;
                    entry.GE_DS_Work_Order__c = detail.SVMXC__Service_Order__c;
                    entry.Technician__c = detail.SVMXC__Group_Member__c;
                    entry.GE_DS_Work_Description__c = detail.SVMXC__Work_Description__c;
                    entry.GE_OG_DS_Bonus_Applicable__c = true;
                    entry.GE_OG_DS_Premium_Holiday_Bonus__c = detail.GE_OG_DS_Premium_Holiday_Bonus__c;
                    //Change made by Ryan Cerankowski, ForeFront, 3/24/2014
                    entry.GE_DS_CDB_Type__c = detail.GE_DS_CDB_Type__c;
                    // Change made by Abhijeet Virgaonkar , R-22113. 5/14/2014
                    entry.GE_DS_Onshore__c = detail.GE_DS_Onshore__c;
                    //R-21228 - New Field Addition - Job Code - PC Bsg
                    if(detail.PC_Job_Code__c!=null){
                        entry.GE_PC_Job_Code__c=detail.PC_Job_Code__c;
                    }
                    
                    if(rtId != null){
                        
                        entry.RecordTypeId = rtId;
                    }
                    //entry.GE_DS_CDB_Other__c = detail.SVMXC__Work_Description__c;
                    //End Update
                    if (detail.SVMXC__Start_Date_and_Time__c.date() == detail.SVMXC__End_Date_and_Time__c.date())
                    {
                        
                        entry.End_Date_Time__c = detail.SVMXC__End_Date_and_Time__c;
                    }
                    else
                    {
                        //Modified below line for R-22678
                        //uncommented related to 0000021619
                        entry.End_Date_Time__c = Datetime.newInstance(detail.SVMXC__Start_Date_and_Time__c.date(), Time.newInstance(23,59,59,999));
                        //commented related to 0000021619
                        //entry.End_Date_Time__c = Datetime.newInstance(detail.SVMXC__Start_Date_and_Time__c.date().addDays(1), Time.newInstance(0,0,0,0));
                        
                        SVMXC_Time_Entry__c currEntry = entry;
                
                        while (currEntry.Start_Date_Time__c.date().addDays(1) < detail.SVMXC__End_Date_and_Time__c.date())
                        {
                            
                            SVMXC_Time_Entry__c newEntry = currEntry.clone(false, false, false, false);
                            newEntry.Start_Date_Time__c = DateTime.newInstance(currEntry.Start_Date_Time__c.date().addDays(1), Time.newInstance(0,0,0,0));
                            
                            //Modified below line for R-22678
                            //uncommented related to 0000021619
                            newEntry.End_Date_Time__c = DateTime.newInstance(newEntry.Start_Date_Time__c.date(), Time.newInstance(23,59,59,999));
                            //commented related to 0000021619
                            //newEntry.End_Date_Time__c = DateTime.newInstance(newEntry.Start_Date_Time__c.date().addDays(1), Time.newInstance(0,0,0,0));
                            
                            currEntry = newEntry;
                            updateEntryList.add(newEntry);
                        }
                        
                        if (Time.newInstance(0,0,0,0) != detail.SVMXC__End_Date_and_Time__c.time())
                        {
                            
                            SVMXC_Time_Entry__c newEntry = currEntry.clone(false, false, false, false);
                            newEntry.Start_Date_Time__c = DateTime.newInstance(currEntry.Start_Date_Time__c.date().addDays(1), Time.newInstance(0,0,0,0));
                            newEntry.End_Date_Time__c = DateTime.newInstance(newEntry.Start_Date_Time__c.date(), detail.SVMXC__End_Date_and_Time__c.time());
                            updateEntryList.add(newEntry);
                        }
                    }
                    
                    updateEntryList.add(entry);
                    
                    
                    system.debug(entry);
                }
            }
            
            upsert updateEntryList;
        }
    }
    
    public static void removeTimesheetEntriesFromWorkDetails(Set<Id> detailIdSet)
    {
        delete [SELECT Id FROM SVMXC_Time_Entry__c WHERE Work_Details__c IN :detailIdSet];
    }
    
    public static void updateTimeEntryTotal(List<SVMXC_Time_Entry__c> entryList)
    {
        //Added variable as part of R-22678
        /*Variables for case 19404*/
            String tempStartDate='';
            String tempEndDate='';
            DateTime startDateTime;
            DateTime endDateTime;
            Decimal duration=0;
            Decimal quantityHR=0;
            Decimal quantityMINS=0;
            Decimal quantity=0; 
         if(entryList!=null){   
        for (SVMXC_Time_Entry__c entry : entryList)
        {
            if (entry.End_Date_Time__c != null && entry.Start_Date_Time__c != null)
            {
                //Below code added for R-22275
                /* Changes for case 19404*/         
                tempStartDate= (String.valueof(entry.Start_Date_Time__c)).substring(0,17);
                tempStartDate=tempStartDate + '00'; 
                
                tempEndDate= (String.Valueof(entry.End_Date_Time__c)).substring(0,17);
                tempEndDate=tempEndDate + '00'; 
                startDateTime=DateTime.valueof(tempStartDate);
                endDateTime=DateTime.valueof(tempEndDate);
                system.debug('start time is'+startDateTime);
                system.debug('End time is'+endDateTime);
                duration = decimal.valueof((endDateTime.getTime() - startDateTime.getTime())) / (1000.0 * 60.0); 
                system.debug('duration '+duration);
                quantityHR = Math.floor(duration / 60); 
                quantityMINS = ((Math.mod(duration.intvalue(), 60))*.01);
                system.debug('quantityMINS '+quantityMINS);                 
                quantity=((Decimal)(quantityHR + quantityMINS)).setScale(2);                
                entry.Total_Time__c = quantity;
                system.debug('End time is'+entry.End_Date_Time__c.getTime());
                system.debug('Start Time is '+entry.Start_Date_Time__c.getTime());
                system.debug('Difference is '+((Decimal)entry.End_Date_Time__c.getTime()-entry.Start_Date_Time__c.getTime()));
                //R-22678  code ended
                
                //Below block commented and added code as part of R-22678 
                
                // commented related to R-22275 
                //entry.Total_Time__c = ((Decimal) (entry.End_Date_Time__c.getTime() - entry.Start_Date_Time__c.getTime()) / 3600000.0).setScale(2);
                 
                 
                 // edit for R-22275
                 //uncommented related to 0000021619
                entry.Total_Time__c = ((Decimal) (entry.End_Date_Time__c.getTime() - entry.Start_Date_Time__c.getTime()) / 3600000.0).setScale(1).setScale(2);
                // end edit
                
                entry.GE_OG_DS_Total_Days__c = 1;
            }
    }}
    }
    
    
    public static String getSettingValue(String setting)
    {
        if (appSettings == null)
        {
            SVMXC.COMM_Utils_ManageSettings commUtilSettings = new SVMXC.COMM_Utils_ManageSettings();
            appSettings = commUtilSettings.SVMX_getSettingList('Timesheet');
            if (appSettings == null)
                return null;
        }
        return appSettings.get(setting);
    }
    
    public static void updateTimesheetOnEntries(List<SVMXC_Time_Entry__c> entryList)
    {
        Date maxDate;
        Date minDate;
        Set<Id> techIdSet = new Set<Id>();
        
        System.debug('*****TimeEntries'+entryList);
        if(entryList!=null){
        
        for (SVMXC_Time_Entry__c entry : entryList)
        {
            if (maxDate == null || entry.Start_Date_Time__c.date() > maxDate)
            {
                maxDate = entry.Start_Date_Time__c.date();
            }
            
            if (minDate == null || entry.Start_Date_Time__c.date() < minDate)
            {
                minDate = entry.Start_Date_Time__c.date();
            }
            
            techIdSet.add(entry.Technician__c);
        }
        System.debug('Check Tech IDs: ' + techIdSet);
        List<SVMXC_Timesheet__c> sheetList = [SELECT Id, Technician__c, Start_date__c, End_Date__c FROM SVMXC_Timesheet__c WHERE (Start_Date__c <= :maxDate OR End_Date__c >= :minDate) AND Technician__c IN :techIdSet order by Start_Date__c desc];
        Map<Id, SVMXC__Service_Group_Members__c> techMap = new Map<ID, SVMXC__Service_Group_Members__c>([SELECT Id, SVMXC__Service_Group__c, SVMXC__Service_Group__r.GE_HQ_Resource_Director__c FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet]);
        List<SVMXC_Time_Entry__c> newEntryList = new List<SVMXC_Time_Entry__c>();
        
        //Change made by Ryan Cerankowski, ForeFront, 3/24/2014
        //Get Record type
        Schema.SObjectType s = SVMXC_Timesheet__c.sObjectType;
        Schema.DescribeSObjectResult resSchema = s.getDescribe();
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); //getting all Recordtype for the Sobject
        //End Change
        
        for (SVMXC_Time_Entry__c entry : entryList)
        {
            SVMXC_Timesheet__c matchedTS = null;
            entry.Timesheet__c = null;
            for (SVMXC_Timesheet__c ts : sheetList)
            {
                //if (ts.Start_Date__c >= Date.newInstance(pInteger, pInteger, pInteger))
                    System.debug('Checking Time SHEET TECH ID: ' + ts.Technician__c + ' Time ENTRY Tech ID: ' + entry.Technician__c + ' XXXXXXXXXXX Time SHEET Start Date: ' + ts.Start_Date__c + ' Time SHEET End Date: ' + ts.End_Date__c + ' with Time ENTRY Start Date: ' + entry.Start_Date_Time__c.date());
                if (ts.Technician__c == entry.Technician__c && ts.Start_Date__c <= entry.Start_Date_Time__c.date() && ts.End_Date__c >= entry.Start_Date_Time__c.date())
                {
                    entry.Timesheet__c = ts.Id;
                    matchedTS = ts;
                    
                    System.debug('MATCHED Existing: ' + matchedTS + ' Entry = ' + entry.Id);
                }
            }
            
            if (entry.Timesheet__c == null)
            {
                System.debug('New (UNABLE TO MATCH): ' + entry.Id + ' ' + entry.Name);
                matchedTS =  new SVMXC_Timesheet__c();
                matchedTS.Technician__c = entry.Technician__c;
                if (techMap.get(entry.Technician__c) != null && techMap.get(entry.Technician__c).SVMXC__Service_Group__c != null && techMap.get(entry.Technician__c).SVMXC__Service_Group__r.GE_HQ_Resource_Director__c != null)
                    matchedTS.GE_DS_Manager__c = techMap.get(entry.Technician__c).SVMXC__Service_Group__r.GE_HQ_Resource_Director__c;
                
                //SANDIP Added to start timesheets on configured day of Monday instead of going by user locale.
                String origDate = getSettingValue('PROriginationDate');
                if (origDate == null || origDate == '')
                    //Below line modified as part of R-22678
                    //origDate = '2014-01-06 08:00:00';
                    origDate = '2014-01-06';
                    
                    
                Date prdate = Date.valueOf(origDate);
                
                String cycDays = getSettingValue('TIMESHEET002');
                if (cycDays == null || cycDays == '')
                    cycDays = '1';
                    
                Integer cycleDays = Integer.valueOf(cycDays) * 7;
                Integer diff = prdate.daysBetween(entry.Start_Date_Time__c.date());
                Integer paycycleweeks = 0;
                if(diff >= 0 && diff < cycleDays) 
                    matchedTS.Start_Date__c = prdate;
                else if(diff >= cycleDays)
                {
                    paycycleweeks =diff/cycleDays;     
                    matchedTS.Start_Date__c = prdate.addDays(  paycycleweeks * cycleDays); 
                }
                else if(diff < 0)
                {                 
                    entry.addError('Invalid time entry start, please contact your lead');
                }
                matchedTS.End_Date__c=matchedTS.Start_Date__c.addDays(cycleDays).addDays(-1);
                
                //System.debug('PROriginationDate=' + prDate + ' CycleDays =' + cycleDays + ' Diff =' + diff + ' PayCycleWeeks=' + paycycleweeks + ' Start Date=' + matchedTS.Start_Date__c);
                //SANDIP End customized code
/*             
                //Sandip commented out this original code and replaced with the above code to always start timesheet based on configured PROriginationDate day   
                matchedTS.Start_Date__c = entry.Start_Date_Time__c.date().toStartOfWeek();
*/               
                matchedTS.End_Date__c = matchedTS.Start_Date__c.addDays(6);
                
                //Change made by Ryan Cerankowski, ForeFront, 3/24/2014
                String rtypeName = entry.GE_DS_RecordTypeName__c;
                //If the record type is in the approved list of timesheet record types
                Id rtId;
                if(Label.GE_DS_Timesheet_Module_Active_Record_Types.contains(rtypeName)){
                    try{
                        rtId = recordTypeInfo.get(rtypeName).getRecordTypeId();//particular RecordId by  Name
                        matchedTS.RecordTypeId = rtId;
                    }catch(Exception e){
                        System.debug(e);
                    }
                }
                //End Change
                           
                insert matchedTS;
                entry.Timesheet__c = matchedTS.Id;
                List<GE_DS_Daily_Time_Summary__c> dtsList = new List<GE_DS_Daily_Time_Summary__c>();
                Date cDate = matchedTS.Start_Date__c;
                GE_DS_Daily_Time_Summary__c dts = new GE_DS_Daily_Time_Summary__c();
                dts.GE_DS_Technician__c = matchedTS.Technician__c;
                dts.GE_DS_Timesheet__c = matchedTS.Id;
                dts.GE_DS_Total_Billable_Day__c = 0;
                dts.GE_DS_Total_CDB_Time__c = 0;
                dts.GE_DS_Total_Non_Billable_Day__c = 0;
                dts.GE_DS_Total_Non_Billable_Work_Order_Time__c = 0;
                dts.GE_DS_Total_Billable_Work_Order_Time__c = 0;
                dts.GE_DS_Bonus_Day__c = 0;
                dts.GE_DS_Total_CDB_Day__c = 0;
                dts.GE_DS_Bonus_Hours__c = 0;
                dts.GE_DS_Premium_Holiday_Bonus__c = 0;
                dts.GE_PC_Total_Billable_Day__c=0;
                dts.GE_PC_Total_Non_Billable_Day__c=0;             
                
                while (cDate <= matchedTS.End_Date__c)
                {
                    System.debug('cDate value is : '+cDate);
                    GE_DS_Daily_Time_Summary__c newDts = dts.clone(false,false,false,false);
                    newDts.GE_DS_Date__c = cDate;                           
                    dtsList.add(newDts);
                    cDate = cDate.addDays(1);
                }
                
                system.debug(dtsList);
                insert dtsList;
                sheetList.add(matchedTS);
            }
            
            if (entry.End_Date_Time__c.date() > matchedTS.End_Date__c)
            {
                SVMXC_Time_Entry__c newEntry = entry.clone(false, false, false, false);
                newEntry.Start_Date_Time__c = DateTime.newInstance(matchedTS.End_Date__c.addDays(1), Time.newInstance(0,0,0,0));
                entry.End_Date_Time__c = DateTime.newInstance(matchedTS.End_Date__c, Time.newInstance(23, 59, 59, 999));
                newEntry.Timesheet__c = null;
                newEntryList.add(newEntry);
            }
            
        }
        
        if (newEntryList.size() > 0)
        {
           insert newEntryList;
    }}
    }
    
    public static void updateDailyTimeSummary(List<SVMXC_Time_Entry__c> entryList)
    {
        Set<Date> dateSet = new Set<Date>();
        Set<Id> tsIdSet = new Set<Id>();
        Date earliestDate = null;
        Date latestDate = null;
         if(entryList!=null){       
        for (SVMXC_Time_Entry__c entry : entryList)
        {
            if (earliestDate == null || (entry.Start_Date_Time__c.date() < earliestDate))
                earliestDate = entry.Start_Date_Time__c.date();
                
            if (latestDate == null || (entry.Start_Date_Time__c.date() > latestDate))
                latestDate = entry.Start_Date_Time__c.date();
                
            dateSet.add(entry.Start_Date_Time__c.date());
            tsIdSet.add(entry.Timesheet__c);
        }
        
        if (tsIdSet.size() >0)
        {
            system.debug(dateSet);
            system.debug(tsIdSet);
            
/*            
            List<GE_DS_Daily_Time_Summary__c> dtsList = [SELECT Id, GE_DS_Timesheet__c, GE_DS_Date__c, GE_DS_Total_Billable_Day__c, GE_DS_Total_CDB_Time__c, GE_DS_Total_Non_Billable_Day__c,GE_DS_Total_Non_Billable_Work_Order_Time__c, 
                                                         GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c, GE_DS_Bonus_Day__c,GE_DS_Bonus_Hours__c,GE_DS_Premium_Holiday_Bonus__c,GE_DS_Total_CDB_Day__c, GE_DS_Total_Billable_Work_Order_Time__c,
                                                         GE_DS_Bonus_Rate__c, GE_DS_Work_Order__c, GE_DS_CDB_Type__c FROM GE_DS_Daily_Time_Summary__c WHERE GE_DS_Timesheet__c IN :tsIdSet AND GE_DS_Date__c IN :dateSet];
*/
            List<GE_DS_Daily_Time_Summary__c> dtsList = [SELECT Id, GE_DS_Timesheet__c, GE_DS_Date__c,GE_DS_Total_Billable_Day__c, GE_DS_Total_CDB_Time__c, GE_DS_Total_Non_Billable_Day__c,GE_DS_Total_Non_Billable_Work_Order_Time__c, 
                                                         GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c, GE_DS_Bonus_Day__c,GE_DS_Bonus_Hours__c,GE_DS_Premium_Holiday_Bonus__c,GE_DS_Total_CDB_Day__c, GE_DS_Total_Billable_Work_Order_Time__c,
                                                         GE_DS_Bonus_Rate__c, GE_DS_Work_Order__c, GE_DS_CDB_Type__c,GE_PC_Total_Billable_Day__c,GE_PC_Total_Non_Billable_Day__c FROM GE_DS_Daily_Time_Summary__c WHERE GE_DS_Timesheet__c IN :tsIdSet AND GE_DS_Date__c >= :earliestDate 
                                                         and GE_DS_Date__c <= :latestDate];

            Map<String, GE_DS_Daily_Time_Summary__c> dtsMap = new Map<String, GE_DS_Daily_Time_Summary__c>();
            
            for (GE_DS_Daily_Time_Summary__c dts : dtsList)
            {
                dts.GE_DS_Total_Billable_Day__c = 0;
                dts.GE_DS_Total_CDB_Time__c = 0;
                dts.GE_DS_Total_Non_Billable_Day__c = 0;
                dts.GE_DS_Total_Non_Billable_Work_Order_Time__c = 0;
                dts.GE_DS_Total_Billable_Work_Order_Time__c = 0;
                dts.GE_DS_Bonus_Day__c = 0;
                dts.GE_DS_Total_CDB_Day__c = 0;
                dts.GE_DS_Bonus_Hours__c = 0;
                dts.GE_DS_Premium_Holiday_Bonus__c = 0;         
                
                system.debug(String.valueOf(dts.GE_DS_Timesheet__c) + String.valueOf(dts.GE_DS_Date__c));
                System.debug('Putting into map key,value ID: ' + String.valueOf(dts.GE_DS_Timesheet__c) + String.valueOf(dts.GE_DS_Date__c) + ' | ' + dts.Id);
                dtsMap.put(String.valueOf(dts.GE_DS_Timesheet__c) + String.valueOf(dts.GE_DS_Date__c), dts);
            }
            
            //Removed the field Work_Details__r.SVMXC__Service_Order__r.GE_DS_Bonus_Percentage__c, from the below For Query asa part of R-26367
            for (SVMXC_Time_Entry__c entry : [SELECT Id, Work_Details__c, Total_Time__c, Technician__r.GE_OG_DS_Bonus_Rate__c,  GE_OG_DS_Bonus_Applicable__c,
                                              GE_OG_DS_Premium_Holiday_Bonus__c, Timesheet__c, Start_Date_Time__c, GE_DS_Start_Date__c, Is_Billable__c, GE_DS_Work_Order__c,  GE_DS_CDB_Type__c, SVMXC_Time_Entry__c.Activity__c
                                              FROM SVMXC_Time_Entry__c WHERE Timesheet__c IN :tsIdSet AND GE_DS_Start_Date__c IN :dateSet])
            {
                system.debug(String.valueOf(entry.Timesheet__c) + String.valueOf(entry.GE_DS_Start_Date__c));
                GE_DS_Daily_Time_Summary__c dts = dtsMap.get(String.valueOf(entry.Timesheet__c) + String.valueOf(entry.Start_Date_Time__c.date()));
                //System.debug('dts==>' + String.valueOf(entry.Timesheet__c) + String.valueOf(entry.Start_Date_Time__c.date()) + ' results null===> ' + (dts == null));
                //Change made by Ryan Cerankowski, ForeFront, 3/21/2014
                //Changed the criteria for calculating CDB Time on Time Entries from: Time entries not associated with a Work Order to: Time Entries of the type 'CDB Time'
                if (dts != null)  //SP: Added temporary fix null check to allow processing to occur until long-term proper solution implemented.
                {
                    System.debug('DTS null check-------->'+dts);                    
                                        
                    if((entry.Activity__c != null && entry.Activity__c == 'CDB Time') || entry.Work_Details__c == null)
                    //if (entry.Work_Details__c != null)
                    //End Change
                    {
                        dts.GE_DS_Total_CDB_Time__c += entry.Total_Time__c;
                        dts.GE_DS_CDB_Type__c = entry.GE_DS_CDB_Type__c;
                    }
                    else
                    {
                        if (entry.Is_Billable__c)
                        {
                            if (dts.GE_DS_Total_Billable_Work_Order_Time__c == null)
                                System.debug('GE_DS_Total_Billable_Work_Order_Time__c is null, ID= ' + dts.Id);
                            if (entry.Total_Time__c == null)
                                System.debug('entry.Total_Time__c is null, ID= ' + entry.Id);
                                
                            dts.GE_DS_Total_Billable_Work_Order_Time__c += entry.Total_Time__c;
                        }
                        else
                        {
                            dts.GE_DS_Total_Non_Billable_Work_Order_Time__c += entry.Total_Time__c;
                        }
                        
                        dts.GE_DS_Work_Order__c = entry.GE_DS_Work_Order__c;
                    }
                   
                    if (entry.GE_OG_DS_Bonus_Applicable__c && entry.Technician__r.GE_OG_DS_Bonus_Rate__c != null)
                    {
                        dts.GE_DS_Bonus_Hours__c += entry.Total_Time__c;
                        if (entry.GE_OG_DS_Premium_Holiday_Bonus__c != null)
                        {
                            dts.GE_DS_Premium_Holiday_Bonus__c = entry.GE_OG_DS_Premium_Holiday_Bonus__c;
                        }
                     //Commented as part of the R-26367 
                  /*    if (entry.Work_Details__c != null && entry.Work_Details__r.SVMXC__Service_Order__r.GE_DS_Bonus_Percentage__c != null)
                        {
                            dts.GE_DS_Bonus_Rate__c = entry.Technician__r.GE_OG_DS_Bonus_Rate__c * (entry.Work_Details__r.SVMXC__Service_Order__r.GE_DS_Bonus_Percentage__c / 100);
                        }
                        else
                        {*/
                            dts.GE_DS_Bonus_Rate__c = entry.Technician__r.GE_OG_DS_Bonus_Rate__c;
                        //}
                    }
                    
                }
            }
            
            System.debug('Hi***********--------->'+entryList);
            for (GE_DS_Daily_Time_Summary__c dts : dtsList)
            {
                
                if (dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c == null || dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c == 0 || dts.GE_DS_Total_Billable_Work_Order_Time__c >=  dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c)
                {
                    dts.GE_DS_Total_Billable_Day__c = 1;
                }
                else if (dts.GE_DS_Total_Billable_Work_Order_Time__c > 0)
                {
                    dts.GE_DS_Total_Billable_Day__c = .5;
                    
                    if (dts.GE_DS_Total_Non_Billable_Work_Order_Time__c > 0)
                    {
                        dts.GE_DS_Total_Non_Billable_Day__c = .5;
                    }
                    else if (dts.GE_DS_Total_CDB_Time__c > 0)
                    {
                        dts.GE_DS_Total_CDB_Day__c = .5;
                    }
                }
                else if (dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c == null || dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c == 0 || dts.GE_DS_Total_Non_Billable_Work_Order_Time__c >=  dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c)
                {
                    dts.GE_DS_Total_Non_Billable_Day__c = 1;
                }
                else if (dts.GE_DS_Total_Non_Billable_Work_Order_Time__c > 0)
                {
                    dts.GE_DS_Total_Non_Billable_Day__c = .5;
                    
                    if (dts.GE_DS_Total_CDB_Time__c > 0)
                    {
                        dts.GE_DS_Total_CDB_Day__c = .5;
                    }
                }
                else if (dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c == null || dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c == 0 || dts.GE_DS_Total_CDB_Time__c >=  dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c)
                {
                    dts.GE_DS_Total_CDB_Day__c = 1;
                }
                else if (dts.GE_DS_Total_CDB_Time__c > 0)
                {
                    dts.GE_DS_Total_CDB_Day__c = .5;
                }
                
                if (dts.GE_DS_Bonus_Rate__c != null && dts.GE_DS_Bonus_Rate__c != 0)
                {
                    if (dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c == null || dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c == 0 || dts.GE_DS_Bonus_Hours__c >=  dts.GE_DS_Technician__r.GE_DS_Min_Hours_In_Day__c)
                    {
                        dts.GE_DS_Bonus_Day__c = 1;
                    }
                    else if (dts.GE_DS_Bonus_Hours__c > 0)
                    {
                        dts.GE_DS_Bonus_Day__c = .5;
                    }
                }       
            }
            system.debug('*****Sree List: '+dtsList);
            
                
            update dtsList;
        // Below code is written to update Daily Time Summary Records R-22442   
        List<SVMXC_Time_Entry__c> timeEntryLists = [SELECT Id,GE_PC_Job_Code__c,Start_Date_Time__c,End_Date_Time__c FROM SVMXC_Time_Entry__c WHERE Timesheet__c IN :tsIdSet];
        
        List<GE_DS_Daily_Time_Summary__c> dtsList1 = [SELECT Id,GE_DS_Timesheet__c,GE_PC_Total_Billable_Day__c, GE_PC_Total_Non_Billable_Day__c, GE_DS_Date__c,GE_DS_Work_Order__c FROM GE_DS_Daily_Time_Summary__c WHERE GE_DS_Timesheet__c IN :tsIdSet];
        System.debug('List to Delete: '+dtsList1);
        
        List<GE_DS_Daily_Time_Summary__c> dtsList2 = new List<GE_DS_Daily_Time_Summary__c>();
        System.debug('TimeEntry List size: ---> '+ timeEntryLists.size());
        if(dtsList1.size()>0){
        for(GE_DS_Daily_Time_Summary__c dts:dtsList1)
        {      
            dts.GE_PC_Total_Billable_Day__c=0;
            dts.GE_PC_Total_Non_Billable_Day__c=0;
            
            for(SVMXC_Time_Entry__c timeEntry:timeEntryLists)
            {      
                DateTime dT = timeEntry.Start_Date_Time__c;
                Date convertedDT = date.newinstance(dT.year(), dT.month(), dT.day());
                //if(dTS.GE_DS_Date__c==convertedDT)  //Commented this line and added below 3 lines as part of Bug#0000022933
                DateTime dTEndDate = timeEntry.End_Date_Time__c;
                Date convertedDTEnddate = date.newinstance(dTEndDate.year(), dTEndDate.month(), dTEndDate.day());              
                if((dTS.GE_DS_Date__c>=convertedDT) && (dTS.GE_DS_Date__c<=convertedDTEnddate))             
                    {
                        
                        System.debug('DTS-----time--->'+dts.GE_DS_Date__c);
                        System.debug('JobCode--->'+timeEntry.GE_PC_Job_Code__c);
                        //if(timeEntry.GE_PC_Job_Code__c=='Service billable' || timeEntry.GE_PC_Job_Code__c=='Shop support')
                        
                    //R-25726 : Above if conditiona commented and modified as below.
                    //R-26599 : LOV values are not working, updated with API Name
                    //if(timeEntry.GE_PC_Job_Code__c=='Service billable (9)' || timeEntry.GE_PC_Job_Code__c=='Shop Support (13)')
                      if(timeEntry.GE_PC_Job_Code__c=='Service billable' || timeEntry.GE_PC_Job_Code__c=='Shop support')    
                        {
                            dts.GE_PC_Total_Billable_Day__c=1;                      
                        }
                       // if(timeEntry.GE_PC_Job_Code__c=='Out of area support' || timeEntry.GE_PC_Job_Code__c=='Safety training' || timeEntry.GE_PC_Job_Code__c=='OTJ Training' || timeEntry.GE_PC_Job_Code__c=='Vacations' || timeEntry.GE_PC_Job_Code__c=='Service non-billable' )
                     
                    //R-25726 : Above if conditiona commented and modified as below.                 
                    //R-26599 : LOV values are not working, updated with API Name
                    //if(timeEntry.GE_PC_Job_Code__c=='Out of Area Support (5)' || timeEntry.GE_PC_Job_Code__c=='Safety training (8)' || timeEntry.GE_PC_Job_Code__c=='On the Job Training (4)' || timeEntry.GE_PC_Job_Code__c=='Vacations' || timeEntry.GE_PC_Job_Code__c=='Service non-billable (10)' )
                      if(timeEntry.GE_PC_Job_Code__c=='Out of area support' || timeEntry.GE_PC_Job_Code__c=='Safety training' || timeEntry.GE_PC_Job_Code__c=='OTJ Training' || timeEntry.GE_PC_Job_Code__c=='Vacations' || timeEntry.GE_PC_Job_Code__c=='Service non-billable' )   
                        {
                            dts.GE_PC_Total_Non_Billable_Day__c=1;
                        }                       
                        
                    }
            }
             for(SVMXC_Time_Entry__c timeEntry:timeEntryLists)
            {      
                DateTime dT = timeEntry.Start_Date_Time__c;
                Date convertedDT = date.newinstance(dT.year(), dT.month(), dT.day());
               //if(dTS.GE_DS_Date__c==convertedDT) //Commented this line and added below 3 lines as part of Bug#0000022933
                DateTime dTEndDate = timeEntry.End_Date_Time__c;
                Date convertedDTEnddate = date.newinstance(dTEndDate.year(), dTEndDate.month(), dTEndDate.day());              
                if((dTS.GE_DS_Date__c>=convertedDT) && (dTS.GE_DS_Date__c<=convertedDTEnddate))
                    {                       
                        //if(timeEntry.GE_PC_Job_Code__c=='Service billable' || timeEntry.GE_PC_Job_Code__c=='Shop support')
                    //R-25726 : Above if conditiona commented and modified as below.
                    //R-26599 : LOV values are not working, updated with API Name
                    //if(timeEntry.GE_PC_Job_Code__c=='Service billable (9)' || timeEntry.GE_PC_Job_Code__c=='Shop Support (13)')
                      if(timeEntry.GE_PC_Job_Code__c=='Service billable' || timeEntry.GE_PC_Job_Code__c=='Shop support')    
                        {
                            dts.GE_PC_Total_Billable_Day__c=1; 
                            dts.GE_PC_Total_Non_Billable_Day__c=0;
                        }                                             
                        
                    }
            }
            dtsList2.add(dTS);          
        } 
    }
        System.debug('Set deleting--> '+dtsList2);
        if(dtsList2.size()>0)
        update dtsList2; 
        }}
    }
        
        
    public static void updateTimesheetTotals(List<SVMXC_Time_Entry__c> entryList)
    {
        Set<Id> tsIdSet = new Set<Id>();
        if(entryList!=null){
        for (SVMXC_Time_Entry__c entry : entryList)
        {
            tsIdSet.add(entry.Timesheet__c);
        }
        
        if (tsIdSet.size() > 0)
        {

            Map<Id,SVMXC_Timesheet__c> tsMap = new Map<Id, SVMXC_Timesheet__c>([SELECT Id,Total_Hours__c, Total_Time_Worked__c, Total_Time_Off__c, Total_Billable_Hours__c, 
                    Total_Billable_On_Site_Time__c, Total_Nonbillable_On_Site_Time__c, Total_Billable_Travel_Time__c, Total_Nonbillable_Travel_Time__c, GE_DS_Total_Overtime__c,
                    Technician__r.SVMXC__Salesforce_User__c FROM SVMXC_Timesheet__c WHERE Id IN :tsIdSet ]);
            List<SVMXC_Time_Entry__c> tEntryList = [SELECT Id, Timesheet__c, Total_Time__c, Miles_Driven__c, Is_Billable__c,GE_DS_CDB_Type__c,
                    Associated_Account__r.Name,Activity__c,Work_Details__c, Work_Details__r.RecordTypeID, Work_Details__r.SVMXC__Line_Type__c, GE_DS_Overtime__c 
                    FROM SVMXC_Time_Entry__c WHERE Timesheet__c IN :tsIdSet];
            
            for (SVMXC_Timesheet__c ts : tsMap.values())
            {
                ts.Total_Hours__c = 0;
                ts.Total_Time_Worked__c = 0;
                ts.Total_Time_Off__c = 0;
                ts.Total_Billable_Hours__c = 0;
                ts.Total_Billable_On_Site_Time__c = 0;
                ts.Total_Billable_Travel_Time__c = 0;
                ts.Total_Nonbillable_Travel_Time__c = 0;
                ts.Total_NonBillable_On_Site_Time__c = 0;
                ts.Total_Miles_Driven__c = 0;
                ts.GE_DS_Total_Overtime__c = 0;
            }
            
            
            for (SVMXC_Time_Entry__c entry : tEntryList)
            {
                //Calculate the total time
                system.debug(entry);
                system.debug(tsMap.get(entry.Timesheet__c));
                tsMap.get(entry.Timesheet__c).Total_Hours__c += entry.Total_Time__c;

                //Calculate the actual hours worked KDP20120802
                if (! new Set<String> {'Holiday', 'Vacation', 'Sick Leave'}.contains(entry.GE_DS_CDB_Type__c))
                {
                    tsMap.get(entry.Timesheet__c).Total_Time_Worked__c += entry.Total_Time__c;
                }

                //Calculate the time off KDP20120802             
                if (new Set<String> {'Holiday', 'Vacation', 'Sick Leave'}.contains(entry.GE_DS_CDB_Type__c))
                {
                    tsMap.get(entry.Timesheet__c).Total_Time_Off__c += entry.Total_Time__c;
                }

                //Calculate the utilization excluding vacation and sick time KDP20120802                            
                if (entry.Is_Billable__c && (! new Set<String> {'Holiday', 'Vacation', 'Sick Leave'}.contains(entry.GE_DS_CDB_Type__c)))
                {
                    tsMap.get(entry.Timesheet__c).Total_Billable_Hours__c += entry.Total_Time__c;
                }

                //Calculate billable onsite KDP20120802             
                if (entry.Is_Billable__c && ((entry.Associated_Account__c != null && entry.Activity__c != 'Travel Time') && ! isTravelWD(entry.Work_Details__r)) )
                {
                    tsMap.get(entry.Timesheet__c).Total_Billable_On_Site_Time__c +=  entry.Total_Time__c;
                }

                //Calculate nonbillable onsite KDP20120802             
                if (!entry.Is_Billable__c && ((entry.Associated_Account__c != null && entry.Activity__c != 'Travel Time') || isLaborWD(entry.Work_Details__r)) )
                {
                    tsMap.get(entry.Timesheet__c).Total_NonBillable_On_Site_Time__c += entry.Total_Time__c;
                }

                //Calculate miles driven KDP20120802             
                if (entry.Miles_Driven__c!= null)
                {
                    tsMap.get(entry.Timesheet__c).Total_Miles_Driven__c +=  entry.Miles_Driven__c;
                }
                
                if (entry.GE_DS_Overtime__c)
                {
                    tsMap.get(entry.Timesheet__c).GE_DS_Total_Overtime__c += entry.Total_Time__c;
                }
            }
            
            update tsMap.values();
            
    }}
        
    }    
    
    
 public static void updateRelatedEvents(List<SVMXC_Time_Entry__c> entryList)
    {
        Set<Id> entryIdSet = new Set<Id>();
        Set<Id> techIdSet = new Set<Id>();
        
        if(entryList!=null){
        for (SVMXC_Time_Entry__c entry : entryList)
        {
            if (entry.Start_Date_Time__c > system.now())
            {
                entryIdSet.add(entry.Id);
                techIdSet.add(entry.Technician__c);
            }
        }
        
        if (entryIdSet.size() > 0)
        {
            List<Event> eventList = [SELECT Id, WhatId, StartDateTime, EndDateTime,OwnerId, Type, ShowAs FROM Event WHERE WhatId IN :entryIdSet  ];
            
            Map<Id, SVMXC__Service_Group_Members__c> techMap = new Map<Id, SVMXC__Service_Group_Members__c>([SELECT Id, SVMXC__Salesforce_User__c FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet]);
            
            for (SVMXC_Time_Entry__c entry : entryList)
            {
                
                if (entryIdSet.contains(entry.Id) && techMap.containsKey(entry.Technician__c) && techMap.get(entry.Technician__c).SVMXC__Salesforce_User__c != null)
                {
                    Event e = null;
                    
                    for (Event tempE : eventList)
                    {
                        if (tempE.WhatId == entry.Id)
                        {
                            e = tempE;
                        }
                    }
                    
                    if (e == null)
                    {
                        e = new Event();
                        eventList.add(e);
                    }
                    
                    e.Subject = entry.Activity__c;
                    e.StartDateTime = entry.Start_Date_Time__c;
                    e.WhatId = entry.id;
                    e.EndDateTime = entry.End_Date_Time__c;
                    e.OwnerId = techMap.get(entry.Technician__c).SVMXC__Salesforce_User__c;
                    e.ShowAs = 'Busy';
                    e.Type = 'Other';
                }
            }
            
            upsert eventList;
    }}
    } 
    
    public static void deleteRelatedEvents(List<SVMXC_Time_Entry__c> entryList)
    {
        Set<String> entryIdSet = new Set<String>();
        
        if(entryList!=null){
        for (SVMXC_Time_Entry__c entry : entryList)
        {
            entryIdSet.add(String.valueOf(entry.Id));
        }
        }
        if (entryIdSet.size() > 0)
        {
            List<Event> eventList = [SELECT Id FROM Event WHERE WhatId IN :entryIdSet  ];
            
            if (eventList.size() > 0)
            {
                delete eventList;
            }
        }
    }
     
    public static void checkForWorkDetailOverlap(List<SVMXC__Service_Order_Line__c> wdList, Map<Id, SVMXC__Service_Order_Line__c> oldMap, Map<Id, SVMXC__Service_Order__c> woMap)
    {
        Datetime minStart = null;
        Datetime maxEnd = null;
        Set<Id> techIdSet = new Set<Id>();
        Set<Id> woIdSet = new Set<Id>();
        List<SVMXC__Service_Group_Members__c> techList = [select Id from SVMXC__Service_Group_Members__c where SVMXC__Salesforce_User__c=:userinfo.getuserId()];
        
        for (SVMXC__Service_Order_Line__c detail : wdList)
        {
            if ((isLaborWD(detail) || isTravelWD(detail)) && detail.SVMXC__Start_Date_and_Time__c != null)
            {
                if (detail.SVMXC__Group_Member__c == null && techList.size() > 0)
                {
                    detail.SVMXC__Group_Member__c = techList.get(0).Id;
                }
                
                if (detail.SVMXC__Group_Member__c == null)
                {
                    detail.SVMXC__Group_Member__c.addError('Technician/Equipment is required');
                }
                
                if (detail.SVMXC__Start_Date_And_Time__c != null && (minStart == null || detail.SVMXC__Start_Date_And_Time__c < minStart))
                {
                    minStart = detail.SVMXC__Start_Date_And_Time__c;
                    techIdSet.add(detail.SVMXC__Group_Member__c);
                }
                
                if (detail.SVMXC__End_Date_and_Time__c != null && (maxEnd == null || detail.SVMXC__End_Date_and_Time__c > maxEnd))
                {
                    maxEnd = detail.SVMXC__End_Date_and_Time__c;
                    techIdSet.add(detail.SVMXC__Group_Member__c);
                }
                woIdSet.add(detail.SVMXC__Service_Order__c);
                
                if (detail.SVMXC__End_Date_and_Time__c != null)
                {
                    detail.GE_DS_End_Time__c = detail.SVMXC__End_Date_and_Time__c.format('HH:mm');
                }
                
                if (detail.SVMXC__Start_Date_and_Time__c != null)
                {
                    detail.GE_DS_Start_Time__c = detail.SVMXC__Start_Date_and_Time__c.format('HH:mm');
                    detail.GE_DE_Start_Date__c = detail.SVMXC__Start_Date_and_Time__c.date();
                } 
                
                
            }
        }

        if (minStart != null)
        {
            List<SVMXC_Time_Entry__c> otherDetailList = null;
            Map<Integer, List<String>> errorMap = new Map<Integer, List<String>>();
            
            if (maxEnd != null)
            {
                otherDetailList = [SELECT Id, Start_Date_Time__c, Name, End_Date_Time__c, Activity__c, Work_Details__c, Work_Details__r.SVMXC__Service_Order__c, 
                      Work_Details__r.SVMXC__Service_Order__r.Name, Technician__r.SVMXC__Salesforce_User__c, Technician__c 
                      FROM SVMXC_Time_Entry__c 
                      WHERE Technician__c In :techIdSet 
                          AND Activity__c!='Time Off' 
                          AND Start_Date_Time__c <= :maxEnd 
                          AND ( End_Date_Time__c = null OR End_Date_Time__c >= :minStart) ];
            }
            else
            {
                 otherDetailList = [SELECT Id, Start_Date_Time__c, Name, End_Date_Time__c, Activity__c, Work_Details__c, Work_Details__r.SVMXC__Service_Order__c, 
                     Work_Details__r.SVMXC__Service_Order__r.Name, Technician__r.SVMXC__Salesforce_User__c, Technician__c 
                     FROM SVMXC_Time_Entry__c 
                     WHERE Technician__c In :techIdSet 
                        AND Activity__c!='Time Off' 
                        AND Start_Date_Time__c <= :minStart ];
            }
            
            Map<Id, SVMXC__Service_Group_Members__c> techMap = new Map<Id, SVMXC__Service_Group_Members__c>([SELECT Id FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet]); //AND SVMXC__Salesforce_User__c != null
            //Map<Id, SVMXC__Service_Order__c> woMap = new Map<Id, SVMXC__Service_Order__c>([SELECT Id, RecordType.Name FROM SVMXC__Service_Order__c WHERE Id IN :woIdSet]);
            
            for (Integer i = 0; i < wdList.size(); ++i)
            {
                SVMXC__Service_Order_Line__c detail = wdList.get(i);
                
                if ((isLaborWD(detail) || isTravelWD(detail)) && techMap.containsKey(detail.SVMXC__Group_Member__c) && (woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name == 'D&S' || woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name == 'AL' || woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name == 'PC') )
                {
                    if (! errorMap.containsKey(i))
                    {
                        errorMap.put(i, new List<String>());
                    }
                    
                    for (SVMXC__Service_Order_Line__c otherDetail : wdList)
                    {
                        if (detail != otherDetail && detail.SVMXC__Group_Member__c == otherDetail.SVMXC__Group_Member__c && (isLaborWD(detail) || isTravelWD(detail)))
                        {
                            if(otherDetail.SVMXC__End_Date_and_Time__c != null && (
                            //if (otherDetail.SVMXC__End_Date_and_Time__c == null
                                    (detail.SVMXC__Start_Date_and_Time__c <= otherDetail.SVMXC__Start_Date_and_Time__c && detail.SVMXC__End_Date_and_Time__c > otherDetail.SVMXC__Start_Date_and_Time__c)
                                    || (detail.SVMXC__Start_Date_and_Time__c >= otherDetail.SVMXC__Start_Date_and_Time__c && detail.SVMXC__End_Date_and_Time__c <= otherDetail.SVMXC__End_Date_and_Time__c)
                                    || (detail.SVMXC__Start_Date_and_Time__c < otherDetail.SVMXC__End_Date_and_Time__c && detail.SVMXC__End_Date_and_Time__c > otherDetail.SVMXC__End_Date_and_Time__c)
                                )
                            )
                            {
                                if (! otherDetail.SVMXC__Select__c )
                                {
                                    detail.SVMXC__select__c = true;
                                    if (otherDetail.Name != null)
                                    {
                                        errorMap.get(i).add(otherDetail.Name + ' (' + otherDetail.SVMXC__Start_Date_and_Time__c.format('hh:mma') + ' - ' + (otherDetail.SVMXC__End_Date_and_Time__c != null ? otherDetail.SVMXC__End_Date_and_Time__c.format('hh:mma') : '') + ')');
                                    }
                                    else
                                    {
                                        errorMap.get(i).add('New Detail (' + otherDetail.SVMXC__Start_Date_and_Time__c.format('hh:mma') + ' - ' + (otherDetail.SVMXC__End_Date_and_Time__c != null ? otherDetail.SVMXC__End_Date_and_Time__c.format('hh:mma') : '') + ')');
                                    }
                                }
                            }
                        }
                    }
                    
                    for (SVMXC_Time_Entry__c otherDetail : otherDetailList) 
                    {
                        if (detail.SVMXC__Group_Member__c == otherDetail.Technician__c
                                && (detail.Id == null || detail.Id != otherDetail.Work_Details__c ))
                        {
                            if (otherDetail.End_Date_Time__c == null 
                                || (detail.SVMXC__Start_Date_and_Time__c <= otherDetail.Start_Date_Time__c && detail.SVMXC__End_Date_and_Time__c > otherDetail.Start_Date_Time__c)
                                || (detail.SVMXC__Start_Date_and_Time__c >= otherDetail.Start_Date_Time__c && detail.SVMXC__End_Date_and_Time__c <= otherDetail.End_Date_Time__c)
                                || (detail.SVMXC__Start_Date_and_Time__c < otherDetail.End_Date_Time__c && detail.SVMXC__End_Date_and_Time__c > otherDetail.End_Date_Time__c))
                            {
                                if (otherDetail.Work_Details__c != null)
                                {
                                    errorMap.get(i).add(otherDetail.Work_Details__r.SVMXC__Service_Order__r.Name + ' (' + otherDetail.Start_Date_Time__c.format('hh:mma') + ' - ' + (otherDetail.End_Date_Time__c != null ? otherDetail.End_Date_Time__c.format('hh:mma') : '') + ')');         
                                }
                                else 
                                {
                                    errorMap.get(i).add(otherDetail.Name + ' (' + otherDetail.Start_Date_Time__c.format('hh:mma') + ' - ' + (otherDetail.End_Date_Time__c != null ? otherDetail.End_Date_Time__c.format('hh:mma') : '') + ')');         
                                }
                            }
                        }
                    }
                    
                    if (errorMap.get(i).size() > 0 && woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name != 'PC' && woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name != 'AL' && woMap.get(detail.SVMXC__Service_Order__c).RecordType.Name != 'D&S' )
                    {
                        detail.addError('Time Overlaps: ' + String.join(errorMap.get(i), '; '));
                    }
                }
            }
            
            for (SVMXC__Service_Order_Line__c detail : wdList)
            {
                detail.SVMXC__Select__c = false;
            }
        }
    }
    
    public static void checkForTimeEntryOverlap(List<SVMXC_Time_Entry__c> entryList, Map<Id, SVMXC_Time_Entry__c> oldMap)
    {
        Datetime minStart = null;
        Datetime maxEnd = null;
        Set<Id> techIdSet = new Set<Id>();
        SVMXC__Service_Group_Members__c tech = null;
        Set<Id> woIdSet = new Set<Id>();
        List<SVMXC__Service_Order__c> woList = new List<SVMXC__Service_Order__c> ();
        map<id,SVMXC__Service_Order__c> terecMap = new map<id,SVMXC__Service_Order__c>();
            
        try
        {
            tech = [select Id from SVMXC__Service_Group_Members__c where SVMXC__Salesforce_User__c=:userinfo.getuserId() limit 1];
            
        }
        catch(Exception e)
        {
            system.debug('exception:'+e);
        }
        System.debug('Testing classs------>'+entryList);
        if(entryList!=null){
        
        for (SVMXC_Time_Entry__c detail : entryList)
         {
         woIdSet.add(detail.GE_DS_Work_Order__c);
            if(detail.Technician__c == null && tech != null)
            {
                detail.Technician__c = tech.Id;
            }
            else if (detail.Technician__c == null)
            {
                detail.Technician__c.addError('Technician/Equipment is required');
            }
    }
        
        if(woIdSet.size()>0){
       //terecMap = id,[Select Id, RecordType.Name From SVMXC__Service_Order__c Where Id in:woIdSet];
        terecMap = new Map<id,SVMXC__Service_Order__c >  ([Select Id, RecordType.Name From SVMXC__Service_Order__c Where Id in:woIdSet]);
        }
        
        for (SVMXC_Time_Entry__c detail : entryList)
        {
          if (detail.Work_Details__c == null)
            {
                detail.SVMXC_Warnings__c = '';
                if (detail.Start_Date_Time__c != null && (minStart == null || detail.Start_Date_Time__c < minStart))
                {
                    minStart = detail.Start_Date_Time__c;
                    techIdSet.add(detail.Technician__c);
                }
                
                if (detail.End_Date_Time__c != null && (maxEnd == null || detail.End_Date_Time__c > maxEnd))
                {
                    maxEnd = detail.End_Date_Time__c;
                    techIdSet.add(detail.Technician__c);
                }
            }
        }
            
        if (minStart != null)
        {
            List<SVMXC_Time_Entry__c> otherDetailList = null;
            Map<Integer, List<String>> errorMap = new Map<Integer, List<String>>();
                
            if (maxEnd != null) 
            {
                otherDetailList = [SELECT Id, Name, Technician__c, Start_Date_Time__c, End_Date_Time__c, Activity__c, Work_Details__c,Work_Details__r.Name, 
                        Work_Details__r.SVMXC__Service_Order__c, Work_Details__r.SVMXC__Service_Order__r.Name 
                        FROM SVMXC_Time_Entry__c 
                        WHERE  Technician__c In :techIdSet 
                            AND Activity__c != 'Time Off'   
                            AND Start_Date_Time__c <= :maxEnd 
                            AND ( End_Date_Time__c = null OR End_Date_Time__c >= :minStart)];
            }
            else
            {
                 otherDetailList = [SELECT Id, Name, Technician__c, Start_Date_Time__c,  End_Date_Time__c, Activity__c, Work_Details__c,Work_Details__r.Name, 
                        Work_Details__r.SVMXC__Service_Order__c, Work_Details__r.SVMXC__Service_Order__r.Name 
                        FROM SVMXC_Time_Entry__c 
                        WHERE Technician__c In :techIdSet 
                        AND Activity__c != 'Time Off' 
                        AND Start_Date_Time__c <= :minStart ];
            }
                
            for (Integer i = 0; i < entryList.size(); ++i)
            {
                SVMXC_Time_Entry__c detail = entryList.get(i);
                
                if (detail.Work_Details__c == null)
                {
                    if (! errorMap.containsKey(i))
                    {
                        errorMap.put(i, new List<String>());
                    }
                    
                    for (SVMXC_Time_Entry__c otherDetail : entryList)
                    {
                        if (detail != otherDetail && detail.Technician__c == otherDetail.Technician__c && otherDetail.Start_Date_Time__c != null)
                        {
                            if (otherDetail.End_Date_Time__c == null 
                                    || (detail.Start_Date_Time__c <= otherDetail.Start_Date_Time__c && detail.End_Date_Time__c > otherDetail.Start_Date_Time__c)
                                    || (detail.Start_Date_Time__c >= otherDetail.Start_Date_Time__c && detail.End_Date_Time__c <= otherDetail.End_Date_Time__c)
                                    || (detail.Start_Date_Time__c < otherDetail.End_Date_Time__c && detail.End_Date_Time__c > otherDetail.End_Date_Time__c))
                            {
                                if (otherDetail.Name != null)
                                {
                                    errorMap.get(i).add(otherDetail.Name + ' (' + otherDetail.Start_Date_Time__c.format('hh:mma') + ' - ' + (otherDetail.End_Date_Time__c != null ? otherDetail.End_Date_Time__c.format('hh:mma') : '') + ')');
                                }
                                else
                                {
                                    errorMap.get(i).add('New Detail (' + otherDetail.Start_Date_Time__c.format('hh:mma') +  '- ' + (otherDetail.End_Date_Time__c != null ? otherDetail.End_Date_Time__c.format('hh:mma') : '') + ')');
                                }
                            }
                        }
                    }
                
                
                    for (SVMXC_Time_Entry__c otherDetail : otherDetailList) 
                    {
                        system.debug(detail.Technician__c + '    ' + otherDetail.Technician__c);
                        if (detail.Technician__c == otherDetail.Technician__c && detail.Id != otherDetail.Id && otherDetail.Start_Date_Time__c != null)
                        {
                                  
                                  
                            if (otherDetail.End_Date_Time__c == null 
                                || (detail.Start_Date_Time__c <= otherDetail.Start_Date_Time__c && detail.End_Date_Time__c > otherDetail.Start_Date_Time__c)
                                || (detail.Start_Date_Time__c >= otherDetail.Start_Date_Time__c && detail.End_Date_Time__c <= otherDetail.End_Date_Time__c)
                                || (detail.Start_Date_Time__c < otherDetail.End_Date_Time__c && detail.End_Date_Time__c > otherDetail.End_Date_Time__c))
                            {
                                if (otherDetail.Work_Details__c != null)
                                {
                                    errorMap.get(i).add(otherDetail.Work_Details__r.SVMXC__Service_Order__r.Name + ' (' + otherDetail.Start_Date_Time__c.format('hh:mma') + ' - ' + (otherDetail.End_Date_Time__c != null ? otherDetail.End_Date_Time__c.format('hh:mma') : '') + ')');
                                }
                                else 
                                {
                                    errorMap.get(i).add(otherDetail.Name + ' (' + otherDetail.Start_Date_Time__c.format('hh:mma') + ' - ' + (otherDetail.End_Date_Time__c != null ? otherDetail.End_Date_Time__c.format('hh:mma') : '') + ')');
                                }
                            }
                        }
                    }
                     if (errorMap.get(i).size() > 0 && terecMap.get(detail.GE_DS_Work_Order__c)!= null &&  terecMap.get(detail.GE_DS_Work_Order__c).recordType.Name != 'PC' && terecMap.get(detail.GE_DS_Work_Order__c).recordType.Name != 'AL'  &&
                     terecMap.get(detail.GE_DS_Work_Order__c).recordType.Name != 'D&S' )
                    {
                        detail.addError('Time Overlaps: '  + String.join(errorMap.get(i), '; '));
                    }
                    
                }
            }
    }}
    }
    
    
    private static Boolean submitted = false;
    public static void submitTimesheet(List<SVMXC_Timesheet__c> tsList, Map<ID, SVMXC_Timesheet__c> oldMap, Boolean isInsert)
    {
        if (submitted)
        {
            return;
        }
        
        Set<Id> tsIdSet = new Set<Id>();
        
        for (SVMXC_Timesheet__c ts : tsList)
        {
            if (ts.GE_OG_DS_Status__c == 'Submitted' && (isInsert | ts.GE_OG_DS_Status__c != oldMap.get(ts.Id).GE_OG_DS_Status__c))
            {
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                req1.setComments('Submit Timesheet for approval.');
                req1.setObjectId(ts.Id);
                Approval.ProcessResult result = Approval.process(req1);
                submitted = true;
            }
            
        } 
       
    }
    
    private static boolean approved = false;
    public static void approvedTimesheet(List<SVMXC_Timesheet__c> tsList, Map<ID, SVMXC_Timesheet__c> oldMap, Boolean isInsert)
    {
        if (approved)
        {
            return;
        }
        
        Set<Id> tsIdSet = new Set<Id>();
        
        for (SVMXC_Timesheet__c ts : tsList)
        {
            if (ts.GE_OG_DS_Status__c == 'Approved' && (isInsert | ts.GE_OG_DS_Status__c != oldMap.get(ts.Id).GE_OG_DS_Status__c))
            {
                tsIdSet.add(ts.Id);
            }
        }
        
        if (tsIdSet.size() > 0)
        {
            sendBonusSheet(tsIdSet, UserInfo.getSessionId());
            approved = true;
        }
    }
    
    @future(callout=true)
    public static void sendBonusSheet(Set<Id> tsIdSet, String sId)
    {
        GE_DS_BonusSheetService service = new GE_DS_BonusSheetService();
        GE_DS_BonusSheetService.SessionHeader_element sess = new GE_DS_BonusSheetService.SessionHeader_element();
        sess.sessionId = sId;
        GE_DS_BonusSheetService.GE_DS_BonusSheet call = new GE_DS_BonusSheetService.GE_DS_BonusSheet();
        call.endpoint_x = URL.getSalesforceBaseUrl().toExternalForm() + '/services/Soap/class/GE_DS_BonusSheet';
        call.SessionHeader = sess;
        if (! Test.isRunningTest()) {
           call.sendEmail(new List<Id>(tsIdSet));
        }
    }
    
    public static void updateSVMXEventsFromDailyTimeSummary(List<GE_DS_Daily_Time_Summary__c> dtsList)
    {
        Set<Id> dtsIdSet = new Set<Id>();
        Set<Id> techIdSet = new Set<Id>();
        Set<Date> dateSet = new Set<Date>();
        
        for (GE_DS_Daily_Time_Summary__c dts : dtsList)
        {
            if (dts.GE_DS_Has_SFDC_User__c)
            {
                dtsIdSet.add(dts.Id);
                techIdSet.add(dts.GE_DS_Technician__c);
                dateSet.add(dts.GE_DS_Date__c);
            }
        }
        
        if (dtsIdSet.size() > 0)
        {
            Map<Id, SVMXC__SVMX_Event__c> eventList = new Map<Id, SVMXC__SVMX_Event__c>();
            
            for (SVMXC__SVMX_Event__c e : [SELECT Id, GE_DS_Daily_Time_Summary__c, GE_OG_DS_Assignment_Type__c, Is_Billable__c,SVMXC__StartDateTime__c, 
                  SVMXC__EndDateTime__c, GE_OG_DS_Days_Deployed_Billable_Time__c, GE_OG_DS_Event_Duration_Days__c, GE_OG_DS_Days_Deployed_Non_Billable_Time__c, 
                  GE_OG_DS_CDB_Type__c, SVMXC__WhatId__c,  SVMXC__ActivityDate__c FROM SVMXC__SVMX_Event__c WHERE GE_DS_Daily_Time_Summary__c IN :dtsIdSet])
            {
                eventList.put(e.GE_DS_Daily_Time_Summary__c, e);
            }
            
            List<SVMXC__SVMX_Event__c> updateList = new List<SVMXC__SVMX_Event__c>();
            
            for (GE_DS_Daily_Time_Summary__c dts : dtsList)
            {
                if (dtsIdSet.contains(dts.Id))
                {
                    SVMXC__SVMX_Event__c e = eventList.get(dts.Id);
                    
                    if (e == null)
                    {
                        e = new SVMXC__SVMX_Event__c();
                        e.SVMXC__Technician__c = dts.GE_DS_Technician__c;
                        e.SVMXC__WhatId__c = dts.Id;
                        e.SVMXC__ActivityDate__c = dts.GE_DS_Date__c;
                        e.SVMXC__StartDateTime__c = Datetime.newInstance(dts.GE_DS_Date__c, Time.newInstance(8,0,0,0));
                        e.SVMXC__EndDateTime__c = Datetime.newInstance(dts.GE_DS_Date__c, Time.newInstance(17,0,0,0));
                        e.SVMXC__ActivityDateTime__c = e.SVMXC__StartDateTime__c;
                        e.GE_DS_Daily_Time_Summary__c = dts.Id;
                        e.GE_OG_DS_Event_Duration_Days__c = 1;
                    }
                    
                    e.GE_OG_DS_Days_Deployed_Billable_Time__c = dts.GE_DS_Total_Billable_Day__c;
                    e.GE_OG_DS_Days_Deployed_Non_Billable_Time__c = dts.GE_DS_Total_Non_Billable_Day__c;
                    
                    if (dts.GE_DS_Total_Non_Billable_Day__c == null || dts.GE_DS_Total_Non_Billable_Day__c == 0)
                    {
                        e.GE_OG_DS_Days_Deployed_Non_Billable_Time__c = dts.GE_DS_Total_CDB_Day__c;
                    }
                    
                    if (dts.GE_DS_Total_Billable_Day__c > 0 || dts.GE_DS_Total_Non_Billable_Day__c > 0)
                    {
                        e.GE_OG_DS_Assignment_Type__c = 'Deployed';
                        e.Name = dts.GE_DS_Work_Order_Number__c;
                        e.Is_Billable__c = dts.GE_DS_Total_Billable_Day__c > 0 ? 'YES' : 'NO';
                    }
                    else
                    {
                        e.GE_OG_DS_Assignment_Type__c = 'CDB';
                        e.Name = dts.GE_DS_CDB_Type__c;
                        e.GE_OG_DS_CDB_Type__c = dts.GE_DS_CDB_Type__c;
                    }
                    
                    updateList.add(e);
                    
                }
            }
            
            if (updateList.size() > 0)
            {
                upsert updateList;
            }
        }
    }
    
}