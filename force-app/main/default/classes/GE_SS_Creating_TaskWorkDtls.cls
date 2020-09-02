public class GE_SS_Creating_TaskWorkDtls{
    public static Integer noofWL;
    public static Date StartDate ;
    public static Date EndDate ;
    public static Set<ID> woIDs = new Set<Id>();    
    public static Set<Id> oldWLIDs =  new Set<Id>();
    public static List<SVMXC__Service_Order_Line__c > delWLList = new List<SVMXC__Service_Order_Line__c >();
    public static Id rtESTMId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId();
    public static  Id rtUSGId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Usage/Consumption').getRecordTypeId();
    public static Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
    public static Id wdToolsRTId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();   
    
    //Code for R-30139 Starts
    public static void GE_SS_NewToolsWLCreation(List<SVMXC__Service_Order_Line__c> newWorkDetailRecordList){
        List<SVMXC__Service_Order_Line__c> toolsForecastWordDetailList = new List<SVMXC__Service_Order_Line__c>() ; 
        List<SVMXC__Service_Order_Line__c> toolsWordDetailListToInsert = new List<SVMXC__Service_Order_Line__c>() ; 
        Set<Id> wdIdSet = new Set<Id>() ; 
        Map<Id,Decimal> loopCounterMap = new Map<Id,Decimal>() ;        
        for(SVMXC__Service_Order_Line__c wd : newWorkDetailRecordList){
           wdIdSet.add(wd.Id) ;           
        }        
        system.debug('Trigger Called & now its the time to do magic' ) ;         
        for(SVMXC__Service_Order_Line__c wdRec : [SELECT Id,Recordtype.DeveloperName,
                                                         SVMXC__Service_Order__c , SVMXC__Requested_Quantity2__c ,
                                                         SVMXC__Service_Order__r.Recordtype.DeveloperName ,
                                                         SVMXC__Product__c , GE_AL_Part_Description__c                                                                                                    
                                                         FROM  SVMXC__Service_Order_Line__c 
                                                         WHERE Id IN : wdIdSet ] ) {
            system.debug('---Shiv' + wdRec.Recordtype.DeveloperName + wdRec.SVMXC__Service_Order__r.Recordtype.DeveloperName ) ;
            if(wdRec.Recordtype.DeveloperName == 'GE_SS_Tools_Forecast' && wdRec.SVMXC__Service_Order__r.Recordtype.DeveloperName == 'SS_Mobilize'){
                toolsForecastWordDetailList.add(wdrec) ;
                loopCounterMap.put(wdRec.Id,wdRec.SVMXC__Requested_Quantity2__c ) ;
                system.debug('List Size' + toolsForecastWordDetailList.size() + 'List Data' + toolsForecastWordDetailList) ;
            }
        }
        
        if(toolsForecastWordDetailList.size() > 0) {          
            for(SVMXC__Service_Order_Line__c toolsForecastRec : toolsForecastWordDetailList){
              for(Integer i = 0 ; i < loopCounterMap.get(toolsForecastRec.Id) ; i++) {
                    SVMXC__Service_Order_Line__c toolRecordToInsert = new SVMXC__Service_Order_Line__c() ;
                    toolRecordToInsert.RecordtypeId = wdToolsRTId ;
                    toolRecordToInsert.SVMXC__Service_Order__c = toolsForecastRec.SVMXC__Service_Order__c ;
                    toolRecordToInsert.SVMXC__Product__c = toolsForecastRec.SVMXC__Product__c ;                       
                    toolRecordToInsert.SVMXC__Serial_Number__c = null ;
                    toolRecordToInsert.SVMXC__Requested_Quantity2__c = 1 ;
                    toolsWordDetailListToInsert.add(toolRecordToInsert) ;
                }               
            }
        }    
        
        if(toolsWordDetailListToInsert.size() > 0){
            try{
                insert toolsWordDetailListToInsert ;
                system.debug('Data Successfully inserted') ;
            }Catch(DMLException e){
                system.debug('There is an error occured while doing the insert on the Tools Work Details' + e.getMessage()) ;
            }
        }       
    } //Code for R-30139 Ends
    
    public static void GE_SS_NewWL(List<SVMXC__Service_Order_Line__c> newWorkDtlsList, Map<Id, SVMXC__Service_Order_Line__c> oldMap) {
        list<SVMXC__Service_Order_Line__c> TaskDetailList = new List<SVMXC__Service_Order_Line__c> ();
        Set<ID> wDIDs = new Set<Id>(); 
        for(SVMXC__Service_Order_Line__c wdLab :newWorkDtlsList){
            wDIDs.add(wdLab.Id);
        }
        
        list<SVMXC__Service_Order_Line__c> newWorkDlbrList =[ Select Name,Id,GE_SS_Service_End_Date__c,GE_SS_Service_Start_Date__c,
                                                             SVMXC__Service_Order__c,SVMXC__Work_Description__c,SVMXC__Service_Order__r.GE_SS_Billing_Reference__c,RecordTypeId,SVMXC__Group_Member__c, SVMXC__Line_Type__c from SVMXC__Service_Order_Line__c
                                                             where Id in:wDIDs];                     
        for(SVMXC__Service_Order_Line__c allwdl : newWorkDlbrList)
        {                
            if(allwdl.SVMXC__Line_Type__c=='Labor' && allwdl.RecordTypeId==rtESTMId && allwdl.GE_SS_Service_Start_Date__c != null && allwdl.GE_SS_Service_End_Date__c != null  )
            {
                system.debug('After If');
                noofWL= allwdl.GE_SS_Service_Start_Date__c.daysBetween(allwdl.GE_SS_Service_End_Date__c );  
                system.debug('entering');
                for(Integer i=0;i<=noofWL;i++){  
                    StartDate = allwdl.GE_SS_Service_Start_Date__c.addDays(i);     
                    SVMXC__Service_Order_Line__c newWLTask = new SVMXC__Service_Order_Line__c();
                    if(i==0){
                        newWLTask.BHGE_OFS_Activity_Date__c= allwdl.GE_SS_Service_Start_Date__c;
                    }else{                  
                        newWLTask.BHGE_OFS_Activity_Date__c= StartDate ; 
                    }
                    newWLTask.SVMXC__Line_Type__c='Task'; 
                    //Added the below field to auto populate to 1
                    newWLTask.GE_SS_WL_Billable_Days__c=1;
                    newWLTask.RecordTypeId=rtUSGId; 
                    newWLTask.SVMXC__Work_Detail__c=allwdl.Id;
                    newWLTask.SVMXC__Service_Order__c=allwdl.SVMXC__Service_Order__c;
                    newWLTask.GE_SS_Billable_Hours__c= 12.00;
                    // newWLTask.SVMXC__Is_Billable__c= true;
                    newWLTask.GE_AL_Time_Type__c= 'Regular Time';
                    newWLTask.GE_SS_Shift__c= 'Day';
                    newWLTask.SVMXC__Actual_Quantity2__c=1;
                    if(allwdl.SVMXC__Work_Description__c!=null){
                    newWLTask.SVMXC__Work_Description__c=allwdl.SVMXC__Work_Description__c;
                    }
                    if(allwdl.SVMXC__Service_Order__r.GE_SS_Billing_Reference__c!=null){
                        newWLTask.GE_SS_WBS__c=allwdl.SVMXC__Service_Order__r.GE_SS_Billing_Reference__c;}                   
                    newWLTask.SVMXC__Group_Member__c=allwdl.SVMXC__Group_Member__c; //Uncommented as part of R-29316
                    TaskDetailList.add(newWLTask);
                }
            }                                   
        }
        if(!TaskDetailList.isEmpty())
        {
            system.debug('final entering');
            Insert TaskDetailList;
            System.debug('List of Task Lines'+TaskDetailList);
        }
        
    } 
     //Below Code is Added for the Subsea - R-29773
    public static void deleteTaskWL(List<SVMXC__Service_Order_Line__c> newWorkDtlsList) {                
        Set<ID> wDIDs = new Set<Id>();         
        List<SVMXC__Service_Order_Line__c> oldWLList = new List<SVMXC__Service_Order_Line__c> ();
        for(SVMXC__Service_Order_Line__c wdLab :newWorkDtlsList){
            wDIDs.add(wdLab.Id);
        }
        if(!wDIDs.isEmpty()){
            oldWLList = [select id,name,SVMXC__Work_Detail__c from SVMXC__Service_Order_Line__c where SVMXC__Work_Detail__c=:wDIDs and recordtypeId=:rtUSGId and SVMXC__Line_Type__c='Task'];
        }
        if(!oldWLList.isEmpty()){
            delete oldWLList;
        }
    }
    //Ended code for Subsea - R-29773
    
    public static void updateCalculation(List<SVMXC__Service_Order_Line__c> laborlst){
        set<ID> laborSet = new set<id>();
        for(SVMXC__Service_Order_Line__c wdlbline : laborlst){
            System.debug('******IDIDID******'+wdlbline.ID);
            laborset.add(wdlbline.ID);
        }
        Decimal billableCount = 0;
        
        integer nonbillableCount = 0;
        integer standbyCount = 0;
        Decimal regularhrs=0;
        Decimal standbyhrs=0;
        Decimal overtimehrs=0;
        Decimal hmshrs=0;
        List<SVMXC__Service_Order_Line__c> updatelstlabor = new List<SVMXC__Service_Order_Line__c>();
        List<SVMXC__Service_Order_Line__c> lstwdtask = new List<SVMXC__Service_Order_Line__c>();
        Map<Id,SVMXC__Service_Order_Line__c> taskmap= new Map<Id,SVMXC__Service_Order_Line__c>();
        lstwdtask = [Select Id, Name,SVMXC__Is_Billable__c,SVMXC__Work_Detail__c,GE_SS_WL_Billable_Days__c,GE_SS_Billable_Days__c, SVMXC__Service_Order__c,
                     GE_AL_Time_Type__c,SVMXC__Line_Type__c,GE_SS_Billable_Hours__c,GE_SS_Total_HMS_Hrs__c,GE_SS_Total_Non_Billable_Days__c,GE_SS_Total_Days_Cost__c,
                     SVMXC__Work_Detail__r.SVMXC__Service_Order__r.GE_DS_Daily_Rate__c, SVMXC__Work_Detail__r.SVMXC__Service_Order__r.GE_DS_Overtime__c, 
                     GE_DS_Overtime_Hrs__c,GE_SS_Total_Regular_Hrs__c,GE_SS_Total_Standby_Hrs__c,GE_SS_Total_Standby_Days__c,GE_SS_Total_Overtime_Cost__c 
                     from SVMXC__Service_Order_Line__c where SVMXC__Work_Detail__c In:laborset AND SVMXC__Line_Type__c='Task' ];
        
        for(SVMXC__Service_Order_Line__c wdlabor : laborlst){  
            wdlabor.GE_SS_Billable_Days__c=0; 
            System.debug('*****Entering Labor list*****'+laborlst);        
            for(SVMXC__Service_Order_Line__c wdtask : lstwdtask ){
                if(wdlabor.GE_DRL_Daily_Rate__c ==null){
                    wdlabor.GE_DRL_Daily_Rate__c=wdtask.SVMXC__Work_Detail__r.SVMXC__Service_Order__r.GE_DS_Daily_Rate__c;                    
                }
                if(wdlabor.GE_DRL_Overtime__c==null){
                    wdlabor.GE_DRL_Overtime__c=wdtask.SVMXC__Work_Detail__r.SVMXC__Service_Order__r.GE_DS_Overtime__c;
                }
                if(wdtask.SVMXC__Work_Detail__c == wdlabor.Id){
                    
                    if(wdtask.GE_SS_WL_Billable_Days__c!=null){
                        wdlabor.GE_SS_Billable_Days__c=wdlabor.GE_SS_Billable_Days__c+wdtask.GE_SS_WL_Billable_Days__c;                        
                        if(wdlabor.GE_DRL_Daily_Rate__c!=null)   //added by NS to fix bug 0000026647
                            wdlabor.GE_SS_Total_Days_Cost__c = wdlabor.GE_DRL_Daily_Rate__c * wdlabor.GE_SS_Billable_Days__c;
                    }                   
                    if(wdtask.GE_SS_WL_Billable_Days__c!=null){
                        if(wdlabor.GE_SS_Total_Days_in_Service__c != null && wdlabor.GE_SS_Billable_Days__c != null){
                            wdlabor.GE_SS_Total_Non_Billable_Days__c = wdlabor.GE_SS_Total_Days_in_Service__c - wdlabor.GE_SS_Billable_Days__c;
                        }    
                    }
                    if(wdtask.GE_AL_Time_Type__c=='StandBy'){   
                        standbyCount= standbyCount+1;
                        wdlabor.GE_SS_Total_Standby_Days__c= standbyCount;
                        standbyhrs= standbyhrs + wdtask.GE_SS_Billable_Hours__c;
                        wdlabor.GE_SS_Total_Standby_Hrs__c =standbyhrs;
                    }
                    else if(wdtask.GE_AL_Time_Type__c=='Regular Time'){
                        System.debug('*****Entering*****'+wdtask.GE_SS_Billable_Hours__c);
                        regularhrs = regularhrs + wdtask.GE_SS_Billable_Hours__c;
                        wdlabor.GE_SS_Total_Regular_Hrs__c = regularhrs ;
                        
                    }
                    else if(wdtask.GE_AL_Time_Type__c=='HMS'){
                        hmshrs=hmshrs+wdtask.GE_SS_Billable_Hours__c;
                        wdlabor.GE_SS_Total_HMS_Hrs__c = hmshrs;
                    }
                    else if(wdtask.GE_AL_Time_Type__c=='Overtime'){
                        overtimehrs=overtimehrs+wdtask.GE_SS_Billable_Hours__c;
                        wdlabor.GE_DS_Overtime_Hrs__c = overtimehrs ;
                        wdlabor.GE_SS_Total_Overtime_Cost__c = wdlabor.GE_DS_Overtime_Hrs__c * wdlabor.GE_DRL_Overtime__c;
                    }
                }
            }
            updatelstlabor.add(wdlabor);
        } 
        
        
    }
    @future
    public static void updateActualdaysonTech(set<Id> techId) {
        
        List<SVMXC__Service_Order_Line__c> lstwdLabor = new List<SVMXC__Service_Order_Line__c>();
        Map<ID, Set<SVMXC__Service_Order_Line__c>> mapTechIDtoLstST = new Map<ID, Set<SVMXC__Service_Order_Line__c>>();
        Map<Id, SVMXC__Service_Group_Members__c> mapTech = new Map<Id, SVMXC__Service_Group_Members__c>();
        List<SVMXC__Service_Group_Members__c> lstUpdateTech = new List<SVMXC__Service_Group_Members__c>();
        ID woRtyId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        
        lstwdLabor =[SELECT GE_SS_Service_End_Date__c,SVMXC__Line_Type__c, GE_SS_Total_Days_in_Service__c,GE_SS_Service_Start_Date__c,SVMXC__Group_Member__c,SVMXC__Line_Status__c, SVMXC__Service_Order__c,SVMXC__Service_Order__r.SVMXC__Billing_Type__c,SVMXC__Service_Order__r.GE_OG_DS_SVMX_Non_Billable_Reason__c, SVMXC__Service_Order__r.RecordTypeId FROM SVMXC__Service_Order_Line__c where SVMXC__Group_Member__c IN: techId AND SVMXC__Line_Type__c='Labor' AND SVMXC__Service_Order__r.SVMXC__Billing_Type__c != 'Intercompany Billable'];
        
        for(SVMXC__Service_Order_Line__c allwdl : lstwdLabor){
            if(allwdl.SVMXC__Service_Order__r.RecordTypeId==woRtyId && allwdl.SVMXC__Line_Type__c=='Labor'&& allwdl.SVMXC__Group_Member__c!= Null&& (allwdl.SVMXC__Service_Order__r.GE_OG_DS_SVMX_Non_Billable_Reason__c !='On the Job Training'||allwdl.SVMXC__Service_Order__r.GE_OG_DS_SVMX_Non_Billable_Reason__c !='Technician in Training')&& (allwdl.SVMXC__Line_Status__c!='Canceled'||allwdl.SVMXC__Line_Status__c!='Open'))
                if(!mapTechIDtoLstST.containsKey(allwdl.SVMXC__Group_Member__c))
                mapTechIDtoLstST.put(allwdl.SVMXC__Group_Member__c, new Set<SVMXC__Service_Order_Line__c>());                   
            mapTechIDtoLstST.get(allwdl.SVMXC__Group_Member__c).add(allwdl);
        }
        mapTech.putAll([Select Id, GE_SS_Total_Actual_Days_in_Service__c from SVMXC__Service_Group_Members__c where Id IN: techId]);
        Set<Id> updatedTechId = new Set<Id>();
        if(mapTechIDtoLstST != null && mapTechIDtoLstST.size() > 0)
        {
            for(Id idTech : mapTechIDtoLstST.keySet())
            {
                if(mapTech.containsKey(idTech))
                {
                    Decimal intCount = 0;
                    Date startDateOfYear = Date.newInstance(System.now().year(), 1, 1);
                    Date endDateOfYear = Date.newInstance(System.now().year(), 12, 31);
                    
                    
                    for(SVMXC__Service_Order_Line__c objST : mapTechIDtoLstST.get(idTech))
                    {
                        
                        if(objST.GE_SS_Service_Start_Date__c != null && objST.GE_SS_Service_End_Date__c != null && (objST.SVMXC__Line_Status__c =='Complete'|| objST.SVMXC__Line_Status__c =='Sent to Oracle') )
                        {
                            if((objST.GE_SS_Service_End_Date__c < endDateOfYear || objST.GE_SS_Service_Start_Date__c > startDateOfYear) ){
                                
                                {
                                    if(objST.GE_SS_Service_Start_Date__c >= startDateOfYear && objST.GE_SS_Service_End_Date__c <= endDateOfYear){
                                        intCount = intCount + objST.GE_SS_Service_Start_Date__c.daysBetween(objST.GE_SS_Service_End_Date__c)+1;
                                        System.Debug('***Enntered 1111*****'+intCount );
                                    }
                                    else if(objST.GE_SS_Service_Start_Date__c >= startDateOfYear && objST.GE_SS_Service_Start_Date__c <= EndDateOfYear&& objST.GE_SS_Service_End_Date__c > endDateOfYear){
                                        intCount = intCount + objST.GE_SS_Service_Start_Date__c.daysBetween(endDateOfYear)+1;
                                        System.Debug('***Enntered 1222*****'+intCount );
                                    }
                                    else if(objST.GE_SS_Service_Start_Date__c < startDateOfYear && objST.GE_SS_Service_End_Date__c >= startDateOfYear && objST.GE_SS_Service_End_Date__c<=endDateOfYear){
                                        intCount = intCount + startDateofYEar.daysBetween(objST.GE_SS_Service_End_Date__c)+1;
                                        System.Debug('***Enntered 1333*****'+intCount );
                                    }
                                    else if(objST.GE_SS_Service_Start_Date__c < startDateOfYear &&  objST.GE_SS_Service_End_Date__c>endDateOfYear ){
                                        intCount = intCount + startDateOfYear.daysBetween(endDateOfYear)+1;
                                        System.Debug('***Enntered 1444*****'+intCount );
                                    }
                                    
                                }
                            } 
                            
                        }
                        
                    }
                    mapTech.get(idTech).GE_SS_Total_Actual_Days_in_Service__c = intCount;
                    lstUpdateTech.add(mapTech.get(idTech));
                    UpdatedTechId.add(mapTech.get(idTech).Id);
                }
                
            }
        }
        
        
        List<SVMXC__Service_Group_Members__c> lstUpdateTechfinal = new List<SVMXC__Service_Group_Members__c>();
        for(SVMXC__Service_Group_Members__c objTech : mapTech.values())
        {
            if(!UpdatedTechId.contains(objTech.Id))
                objTech.GE_SS_Total_Actual_Days_in_Service__c = 0;
            lstUpdateTechfinal.add(objTech);
        }
        
        if(lstUpdateTechfinal != null && lstUpdateTechfinal.size() > 0)
            update lstUpdateTechfinal;
        
        
    }
    public static void updateFieldandWellonSSWD(List<SVMXC__Service_Order_Line__c> newWDList, Map<Id, SVMXC__Service_Order__c> woMap){  
        //To update Field and Well on mobilize WD from WO for SubSea  
        for (SVMXC__Service_Order_Line__c sol : newWDList){
            if(woMap.get(sol.SVMXC__Service_Order__c).RecordTypeId == rtWOId && ((woMap.get(sol.SVMXC__Service_Order__c).GE_SS_Field__c != Null && sol.GE_SS_Field__c == Null) || (woMap.get(sol.SVMXC__Service_Order__c).GE_SS_Well_ID__c != Null && sol.GE_SS_Well__c == Null))){
                sol.GE_SS_Field__c = woMap.get(sol.SVMXC__Service_Order__c).GE_SS_Field__c;
                sol.GE_SS_Well__c = woMap.get(sol.SVMXC__Service_Order__c).GE_SS_Well_ID__c;
            }
        }
    }       
}