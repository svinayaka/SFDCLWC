public class GE_OG_DTS_TimesheetHelper{
    
    public static Map<String, String>  appSettings = null;
    //Public Id WorkOrderId;
    public static String getSettingValue(String setting)
    {
        if (appSettings == null)
        {
            SVMXC.COMM_Utils_ManageSettings commUtilSettings = new SVMXC.COMM_Utils_ManageSettings();
            if(!Test.isRunningTest()){
            appSettings = commUtilSettings.SVMX_getSettingList('Timesheet');
            }
            if (appSettings == null)
                return null;
        }
        return appSettings.get(setting);
    }
    
    public static Id recrdtypeid= Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('GE OG DTS Technician').getRecordTypeId();
    public static Id timesheettype= Schema.SObjectType.SVMXC_Timesheet__c.getRecordTypeInfosByName().get('GE OG DTS').getRecordTypeId();
    //public Static Id workorderId;
    public static void createTimesheetFromSvmxeventinsert(List<SVMXC__SVMX_Event__c> newevents){  
        
        Date maxDate;
        Date minDate;
        Date startmin;
        Date endmax;
        
        Set<Id> dtstechidset = new set<Id>();
        Map<Id,boolean> evetimemap = new Map<Id,boolean>();
        List<SVMXC__SVMX_Event__c> dtseventlist = getdtsevents(newevents);        
        List<Date> startdatelist = new List<Date>();
        List<Date> enddatelist = new List<Date>();
        
       // List<SVMXC__Service_Order__c> 
        
        if(dtseventlist.size()>0){
            
            for(SVMXC__SVMX_Event__c e:dtseventlist){
                if (maxDate == null || e.SVMXC__StartDateTime__c.date() > maxDate)
                {
                    maxDate = e.SVMXC__StartDateTime__c.date();
                    //startmin = e.SVMXC__StartDateTime__c.date();
                }
                
                if (minDate == null || e.SVMXC__StartDateTime__c.date() < minDate)
                {
                    minDate = e.SVMXC__StartDateTime__c.date();
                }
                /*if(endmax == null || e.SVMXC__EndDateTime__c.date()>endmax){
                    endmax = e.SVMXC__EndDateTime__c.date();
                }*/
                 startdatelist.add(e.SVMXC__StartDateTime__c.Date());
                enddatelist.add(e.SVMXC__EndDateTime__c.Date());
                dtstechIdSet.add(e.SVMXC__Technician__c);
                evetimemap.put(e.id,false);
                //workorderId = e.SVMXC__Service_Order__c;
                
            }
            
             startdatelist.sort();
        startmin = startdatelist[0];
        enddatelist.sort();
        endmax = enddatelist[enddatelist.size()-1];
        
        system.debug('min++++'+startmin);
        system.debug('max++++'+endmax);
        
            List<SVMXC_Timesheet__c> sheetList = [SELECT Id, Technician__c, Start_date__c, End_Date__c FROM SVMXC_Timesheet__c WHERE (Start_Date__c <= :maxDate OR End_Date__c >= :minDate) AND Technician__c IN :dtstechIdSet order by Start_Date__c desc];
            List<GE_DS_Daily_Time_Summary__c> dtstimelist = [Select Id,GE_DS_Work_Order__c, GE_DS_Technician__c,GE_DS_Timesheet__c,GE_DS_Date__c from GE_DS_Daily_Time_Summary__c where GE_DS_Date__c >= :startmin and GE_DS_Date__c <=: endmax and GE_DS_Technician__c in : dtstechIdSet];
            
            Map<Id,Set<Date>> techdtsmap = new  Map<Id,Set<Date>>();
            
            for(GE_DS_Daily_Time_Summary__c dts:dtstimelist){
                
                if(techdtsmap.containskey(dts.GE_DS_Technician__c)){
                    
                    Set<Date> dateset = techdtsmap.get(dts.GE_DS_Technician__c);
                    dateset.add(dts.GE_DS_Date__c);
                    techdtsmap.put(dts.GE_DS_Technician__c,dateset);
                    
                }else{
                    Set<Date> dateset = new Set<Date>();
                    dateset.add(dts.GE_DS_Date__c);
                    techdtsmap.put(dts.GE_DS_Technician__c,dateset);
                }
                
            }
            
            for (SVMXC__SVMX_Event__c e : dtseventlist)
            {
                SVMXC_Timesheet__c matchedTS = null;
                
                for (SVMXC_Timesheet__c ts : sheetList)
                {
                    //if (ts.Start_Date__c >= Date.newInstance(pInteger, pInteger, pInteger))
                   
                    if (ts.Technician__c == e.SVMXC__Technician__c && ts.Start_Date__c <= e.SVMXC__StartDateTime__c.date() && ts.End_Date__c >= e.SVMXC__StartDateTime__c.date())
                    {
                         System.debug('Checking Time SHEET TECH ID: ' + ts.Technician__c + ' Time ENTRY Tech ID: ' + e.SVMXC__Technician__c+ ' XXXXXXXXXXX Time SHEET Start Date: ' + ts.Start_Date__c + ' Time SHEET End Date: ' + ts.End_Date__c + ' with Time ENTRY Start Date: ' + e.SVMXC__StartDateTime__c.date());
                        evetimemap.put(e.id,true);
                        Date enddate = ts.End_Date__c;
                        while(enddate < e.SVMXC__EndDateTime__c.Date()){
                            enddate = enddate.addDays(1);
                            Set<Date> dateset = techdtsmap.get(e.SVMXC__Technician__c);
                            
                            if(dateset==null)
                                dateset = new Set<Date>();
                            
                            if(dateset.contains(enddate)){
                                enddate = enddate.addDays(6);
                            }else{
                                SVMXC_Timesheet__c newts = new SVMXC_Timesheet__c();
                                newts.RecordTypeId = timesheettype;
                                newts.Technician__c = e.SVMXC__Technician__c;
                                newts.Start_Date__c = enddate;
                                newts.End_Date__c = newts.Start_Date__c.addDays(6);
                                
                                insert newts;
                                
                                List<GE_DS_Daily_Time_Summary__c> dtsList = new List<GE_DS_Daily_Time_Summary__c>();
                                Date cDate = newts.Start_Date__c;
                                GE_DS_Daily_Time_Summary__c dts = new GE_DS_Daily_Time_Summary__c();
                                dts.GE_DS_Technician__c = newts.Technician__c;
                                dts.GE_DS_Timesheet__c = newts.Id;
                                dts.GE_DS_Total_Billable_Day__c = 0;
                                dts.GE_DS_Work_Order__c = e.SVMXC__Service_Order__c;
                                System.debug('Hi1');
                                 while (cDate <= newts.End_Date__c)
                                {
                                    System.debug('cDate value is : '+cDate);
                                    GE_DS_Daily_Time_Summary__c newDts = dts.clone(false,false,false,false);
                                    newDts.GE_DS_Date__c = cDate; 
                              
                                    dtsList.add(newDts);
                                    cDate = cDate.addDays(1);
                                }
                                
                                system.debug(dtsList);
                                insert dtsList;
                              //  sheetList.add(newts);
                                enddate = enddate.addDays(6);
                            }
                            
                        }
                       
                    }
                }
                
                if ( evetimemap.get(e.id) == false)
                {
                    matchedTS =  new SVMXC_Timesheet__c();
                    matchedTS.Technician__c = e.SVMXC__Technician__c;
                    matchedTS.RecordTypeId = timesheettype;
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
                    Integer diff = prdate.daysBetween(e.SVMXC__StartDateTime__c.date());
                    Integer paycycleweeks = 0;
                    if(diff >= 0 && diff < cycleDays) 
                        matchedTS.Start_Date__c = prdate;
                    else if(diff >= cycleDays)
                    {
                        paycycleweeks =diff/cycleDays;     
                        matchedTS.Start_Date__c = prdate.addDays(  paycycleweeks * cycleDays); 
                    }
                     matchedTS.End_Date__c = matchedTS.Start_Date__c.addDays(6);
                
               
                
                insert matchedTS;
                
                List<GE_DS_Daily_Time_Summary__c> dtsList = new List<GE_DS_Daily_Time_Summary__c>();
                Date cDate = matchedTS.Start_Date__c;
                GE_DS_Daily_Time_Summary__c dts = new GE_DS_Daily_Time_Summary__c();
                dts.GE_DS_Technician__c = matchedTS.Technician__c;
                dts.GE_DS_Timesheet__c = matchedTS.Id;
                dts.GE_DS_Total_Billable_Day__c = 0;
                
                while (cDate <= matchedTS.End_Date__c)
                {
                    System.debug('cDate value is : '+cDate);
                    GE_DS_Daily_Time_Summary__c newDts = dts.clone(false,false,false,false);
                    newDts.GE_DS_Date__c = cDate;                           
                    dtsList.add(newDts);
                    cDate = cDate.addDays(1);
                }
                
                Date enddate = matchedTS.End_Date__c;
                
                while(enddate < e.SVMXC__EndDateTime__c.Date()){
                            enddate = enddate.addDays(1);
                            Set<Date> dateset = new Set<Date>();
                            dateset = techdtsmap.get(e.SVMXC__Technician__c);
                            
                            if(dateset == null)
                               dateset = new Set<Date>();
                            
                            if(dateset.contains(enddate)){
                                enddate = enddate.addDays(6);
                            }else{
                                SVMXC_Timesheet__c newts = new SVMXC_Timesheet__c();
                                newts.RecordTypeId = timesheettype;
                                newts.Technician__c = e.SVMXC__Technician__c;
                                newts.Start_Date__c = enddate;
                                newts.End_Date__c = newts.Start_Date__c.addDays(6);
                                
                                insert newts;
                                
                                List<GE_DS_Daily_Time_Summary__c> dtsList1 = new List<GE_DS_Daily_Time_Summary__c>();
                                Date cDate1 = newts.Start_Date__c;
                                GE_DS_Daily_Time_Summary__c dts1 = new GE_DS_Daily_Time_Summary__c();
                                dts1.GE_DS_Technician__c = newts.Technician__c;
                                dts1.GE_DS_Timesheet__c = newts.Id;
                                dts1.GE_DS_Total_Billable_Day__c = 0;
                                dts1.GE_DS_Work_Order__c = e.SVMXC__Service_Order__c;
                                System.debug('Hi2');
                                
                                while (cDate1 <= newts.End_Date__c)
                                {
                                    System.debug('cDate value is : '+cDate1);
                                    GE_DS_Daily_Time_Summary__c newDts = dts1.clone(false,false,false,false);
                                    newDts.GE_DS_Date__c = cDate1;                           
                                    dtsList1.add(newDts);
                                    cDate1 = cDate1.addDays(1);
                                }
                                
                                system.debug(dtsList1);
                                insert dtsList1;
                                sheetList.add(newts);
                                enddate = enddate.addDays(6);
                            }
                            
                        }
                
                system.debug(dtsList);
                insert dtsList;
                sheetList.add(matchedTS);
            }
            
            } 
            
        }
        
        
    }
    
 public static void updatetimesheetfornewevents(List<SVMXC__SVMX_Event__c> newevents){
        
        
        Date maxDate;
        Date minDate;
        Date startmin;
        Date endmax;
       
        Set<Id> dtstechidset = new set<Id>();
        List<GE_DS_Daily_Time_Summary__c> matcheddts = new List<GE_DS_Daily_Time_Summary__c>();
        List<SVMXC__SVMX_Event__c> dtseventlist = getdtsevents(newevents);    
        List<Date> startdatelist = new List<Date>();
        List<Date> enddatelist = new List<Date>();
        
        if(dtseventlist.size()>0){
        
             
                for(SVMXC__SVMX_Event__c e:dtseventlist){
               
                startdatelist.add(e.SVMXC__StartDateTime__c.Date());
                enddatelist.add(e.SVMXC__EndDateTime__c.Date());
                dtstechIdSet.add(e.SVMXC__Technician__c);
             //   evetimemap.put(e.id,false);
            }
        startdatelist.sort();
        startmin = startdatelist[0];
        enddatelist.sort();
        endmax = enddatelist[enddatelist.size()-1];
                
               
        
        
        
         List<GE_DS_Daily_Time_Summary__c> dtstimelist = [Select Id,GE_DTS_Day_Count__c,GE_DS_Technician__c,GE_DS_Total_Billable_Day__c,GE_DS_Timesheet__c,GE_DS_Date__c from GE_DS_Daily_Time_Summary__c where GE_DS_Date__c >= :startmin and GE_DS_Date__c <=: endmax and GE_DS_Technician__c in : dtstechIdSet order by GE_DS_Date__c];
         
         
            Map<Id,List<GE_DS_Daily_Time_Summary__c>> techdtsmap = new Map<Id,List<GE_DS_Daily_Time_Summary__c>>();
            
            for(GE_DS_Daily_Time_Summary__c dts: dtstimelist){
            
                if(techdtsmap.containskey(dts.GE_DS_Technician__c)){
                
                    List<GE_DS_Daily_Time_Summary__c> dtslist = techdtsmap.get(dts.GE_DS_Technician__c);
                    dtslist.add(dts);
                    techdtsmap.put(dts.GE_DS_Technician__c,dtslist);
                    
                }else{
                    
                    List<GE_DS_Daily_Time_Summary__c> dtslist = new List<GE_DS_Daily_Time_Summary__c>();
                    dtslist.add(dts);
                    techdtsmap.put(dts.GE_DS_Technician__c,dtslist);
                                
                }
                
            }
            
            
            system.debug('techdtsmap++++'+techdtsmap);
            
        for(SVMXC__SVMX_Event__c eve : dtseventlist ){
        
            List<GE_DS_Daily_Time_Summary__c> dtstechlist = techdtsmap.get(eve.SVMXC__Technician__c);
            
            system.debug('dtstechlist++++'+dtstechlist);
            
            Set<Date> evedateset = getDates(eve.SVMXC__StartDateTime__c.Date(),eve.SVMXC__EndDateTime__c.Date());
            
            system.debug('evedateset+++'+evedateset);
            
            if(dtstechlist!=null){
            for(GE_DS_Daily_Time_Summary__c dts: dtstechlist){
            
            if(evedateset!=null){
            if(evedateset.contains(dts.GE_DS_Date__c)){
                system.debug('Out>>>>'+dts.GE_DS_Total_Billable_Day__c);
                
                if(dts.GE_DS_Total_Billable_Day__c==null){
                    dts.GE_DS_Total_Billable_Day__c = 0;
                    dts.GE_DS_Work_Order__c = Null;
                    System.debug('Hi3');
                }
                                
                dts.GE_DS_Total_Billable_Day__c +=1;
                if(dts.GE_DS_Total_Billable_Day__c>0){
                    dts.GE_DTS_Day_Count__c = 1;
                    dts.GE_DS_Work_Order__c = eve.SVMXC__Service_Order__c;
                    System.debug('Hi4');
                 }
                 else
                 dts.GE_DS_Work_Order__c = NUll;
                matcheddts.add(dts);
                
            }
            }            
            }
            }
            
                
        
        }
        
        if(matcheddts.size()>0){
        update matcheddts  ;
        }
        }
    
 }   
 
 public static void updatetimesheetforoldevents(List<SVMXC__SVMX_Event__c> oldevents){
        
        
        Date maxDate;
        Date minDate;
        Date startmin;
        Date endmax;
       
        Set<Id> dtstechidset = new set<Id>();
         List<GE_DS_Daily_Time_Summary__c> matcheddts = new List<GE_DS_Daily_Time_Summary__c>();
        List<SVMXC__SVMX_Event__c> dtseventlist = getdtsevents(oldevents);     
        List<Date> startdatelist = new List<Date>();
        List<Date> enddatelist = new List<Date>();
        
        if(dtseventlist.size()>0){
        
             for(SVMXC__SVMX_Event__c e:dtseventlist){
               
                startdatelist.add(e.SVMXC__StartDateTime__c.Date());
                enddatelist.add(e.SVMXC__EndDateTime__c.Date());
                dtstechIdSet.add(e.SVMXC__Technician__c);
             //   evetimemap.put(e.id,false);
            }
        startdatelist.sort();
        startmin = startdatelist[0];
        enddatelist.sort();
        endmax = enddatelist[enddatelist.size()-1];
        
        
         List<GE_DS_Daily_Time_Summary__c> dtstimelist = [Select Id,GE_DTS_Day_Count__c,GE_DS_Technician__c,GE_DS_Total_Billable_Day__c,GE_DS_Timesheet__c,GE_DS_Date__c from GE_DS_Daily_Time_Summary__c where GE_DS_Date__c >= :startmin and GE_DS_Date__c <=: endmax and GE_DS_Technician__c in : dtstechIdSet];
         
          


          Map<Id,List<GE_DS_Daily_Time_Summary__c>> techdtsmap = new Map<Id,List<GE_DS_Daily_Time_Summary__c>>();
            
            for(GE_DS_Daily_Time_Summary__c dts: dtstimelist){
            
                if(techdtsmap.containskey(dts.GE_DS_Technician__c)){
                
                    List<GE_DS_Daily_Time_Summary__c> dtslist = techdtsmap.get(dts.GE_DS_Technician__c);
                    dtslist.add(dts);
                    techdtsmap.put(dts.GE_DS_Technician__c,dtslist);
                    
                }else{
                    
                    List<GE_DS_Daily_Time_Summary__c> dtslist = new List<GE_DS_Daily_Time_Summary__c>();
                    dtslist.add(dts);
                    techdtsmap.put(dts.GE_DS_Technician__c,dtslist);
                                
                }
                
            }
            
            
            
            
        for(SVMXC__SVMX_Event__c eve : dtseventlist ){
        
            List<GE_DS_Daily_Time_Summary__c> dtstechlist = techdtsmap.get(eve.SVMXC__Technician__c);
            
            Set<Date> evedateset = getDates(eve.SVMXC__StartDateTime__c.Date(),eve.SVMXC__EndDateTime__c.Date());
            
            if(dtstechlist!=null){
            for(GE_DS_Daily_Time_Summary__c dts: dtstechlist){
            if(evedateset!=null){
            if(evedateset.contains(dts.GE_DS_Date__c)){
                
                if(dts.GE_DS_Total_Billable_Day__c == null){
                    dts.GE_DS_Total_Billable_Day__c = 0;
                    dts.GE_DS_Work_Order__c = Null;
                    System.debug('Hi5');
                }
                dts.GE_DS_Total_Billable_Day__c -=1;
                if(dts.GE_DS_Total_Billable_Day__c<=0){
                    dts.GE_DTS_Day_Count__c = 0;
                    dts.GE_DS_Work_Order__c = Null;
                    System.debug('Hi6');
                 }
                matcheddts.add(dts);
                
            }
            }
            }
            }
                
         }
        
        if(matcheddts.size()>0){
        update matcheddts;
        }
    }
 }  
 
 public static Set<Date> getDates(Date startdate,Date enddate){
 
    Set<Date> eventdateset = new Set<Date>();
     Integer count = startdate.daysBetween(enddate);
        for(Integer i=0;i<=count;i++){
            eventdateset.add(startdate.addDays(i));
        }   
        
        return eventdateset;
 }
 
 public static List<SVMXC__SVMX_Event__c> getdtsevents(List<SVMXC__SVMX_Event__c> newevents){
 
        Set<Id> techidset = new set<Id>();
        Set<Id> dtstechidset = new set<Id>();
        Map<Id,Id> techrecordtypemap = new Map<Id,Id>();
        set<Id> EvetId =new set<Id>();
        Map<Id,boolean> evetimemap = new Map<Id,boolean>();
        List<SVMXC__SVMX_Event__c> dtseventlist = new List<SVMXC__SVMX_Event__c>();
        for(SVMXC__SVMX_Event__c eve: newevents){
            techidset.add(eve.SVMXC__Technician__c);
            EvetId.add(eve.id);     
        }   
        
        List<SVMXC__Service_Group_Members__c> techlist = [select id,recordtypeid from SVMXC__Service_Group_Members__c where id in : techidset];        
        for(SVMXC__Service_Group_Members__c tech : techlist){
            techrecordtypemap.put(tech.id,tech.RecordTypeId);
        }  
        
        for(SVMXC__SVMX_Event__c eve: newevents){
            system.debug('Timesheet'+eve.SVMXC__Technician__r.RecordTypeId);
            if(techrecordtypemap.get(eve.SVMXC__Technician__c) == recrdtypeid){                                               
                dtseventlist.add(eve);
            }            
        }  
        
        return dtseventlist;
 
 }
 
 
 
}