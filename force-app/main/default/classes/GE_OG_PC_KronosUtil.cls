/*
Class Name: GE_OG_PC_KronosUtil
Used For : Utility class for Kronos Workforce Mgmt System
Purpose/Overview : Apex classes built has part of ServiceMax integration with Kronos.
Author: Amit Kumar
Created Date: 30/Jan/2015
Test Class Name : 
Change History    : 
S No.    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
1        : 07/20/2015    : Birlasoft DevOps   : BUG#0000021641                : BUG#0000021641 : Job Codes 'Shop Support' and 'Out of area support' should be counted as 'Kronos Billable Hours' and also be counted as 'Kronos OverTime Hours'. 
*/
public class GE_OG_PC_KronosUtil {
     private static Decimal TotalHrs=0.00;
     private static Decimal TotBillHrs=0.00;
     private static Decimal TotOTHrs=0.00;
     private static Decimal TotOTBuffer=0.00;
     private static Decimal TotExtraHrs=0.00;
     private static Boolean isNotRecursive = false ;
    
     public static void calBillableOverTimeHrs(List<SVMXC_Time_Entry__c> tSList){
        Set<Id> tsIdSet = new Set<Id>();
        for (SVMXC_Time_Entry__c entry : tSList)
        {
            tsIdSet.add(entry.Timesheet__c);
        }
        
        if (tsIdSet.size() > 0)
        {
            Map<Id,SVMXC_Timesheet__c> tsMap = new Map<Id, SVMXC_Timesheet__c>([SELECT Id, Name, Kronos_Billable_Hours__c, Kronos_OverTime_Hours__c, Kronos_Others_Hours__c FROM SVMXC_Timesheet__c WHERE Id IN :tsIdSet AND RecordType.Name='PC' ]);
            List<SVMXC_Time_Entry__c> tEntryList = [SELECT Id,Timesheet__c, Name, GE_PC_Job_Code__c, GE_PC_Earnings_Code__c, Total_Time__c FROM SVMXC_Time_Entry__c WHERE Timesheet__c IN :tsIdSet AND RecordType.Name='PC'];
            System.debug('GE_OG_PC_KronosUtil::PC Time Entry --> '+tEntryList);   
            
            for (SVMXC_Timesheet__c ts : tsMap.values())
            {
                ts.Kronos_Billable_Hours__c = 0;
                ts.Kronos_OverTime_Hours__c = 0;
                ts.Kronos_Others_Hours__c = 0;
                ts.Kronos_OverTimeBuffer__c = 0;
                TotalHrs=0.00;
                TotBillHrs=0.00;
                TotOTHrs=0.00;
                TotExtraHrs=0.00;
                TotOTBuffer=0.00;
            }            
            
            if(tEntryList.size()>0){
                for(SVMXC_Time_Entry__c record : tEntryList){  
                    if(record.GE_PC_Job_Code__c=='OTJ Training' || record.GE_PC_Job_Code__c=='Service billable' || record.GE_PC_Job_Code__c=='Service non-billable' || record.GE_PC_Job_Code__c=='Safety training'  || record.GE_PC_Job_Code__c=='Billable crane truck' || record.GE_PC_Job_Code__c=='Non billable crane truck'||
                        //Start BUG#0000021641
                        record.GE_PC_Job_Code__c=='Shop support' || record.GE_PC_Job_Code__c=='Out of area support' ||
                        //End BUG#0000021641
                        record.GE_PC_Earnings_Code__c=='Vacation VA' || record.GE_PC_Earnings_Code__c=='Personal Illness PI' || record.GE_PC_Earnings_Code__c=='Floating Holiday/Holiday FH/H'
                        ){
                        //Billable Hrs
                        tsMap.get(record.Timesheet__c).Kronos_Billable_Hours__c += record.Total_Time__c;                               
                     }
                     else{
                        //Extra Hrs
                        tsMap.get(record.Timesheet__c).Kronos_Others_Hours__c += record.Total_Time__c;
                     }
                    
                     TotBillHrs=tsMap.get(record.Timesheet__c).Kronos_Billable_Hours__c;
                     TotExtraHrs=tsMap.get(record.Timesheet__c).Kronos_Others_Hours__c;
                    
                     TotalHrs=TotBillHrs+TotExtraHrs;                // Billable Hrs Less than 40 Hrs.
                     /*if(TotBillHrs<=40.00){
                         TotOTHrs=0.00;  
                     }*/
                     if(TotBillHrs>40.00){                          // Billable Hrs More than 40 Hrs.
                         Decimal lcSum = TotBillHrs;
                         TotBillHrs=40.00;
                         tsMap.get(record.Timesheet__c).Kronos_Billable_Hours__c=40.00;
                         TotOTHrs=(lcSum-TotBillHrs) + tsMap.get(record.Timesheet__c).Kronos_OverTimeBuffer__c;  
                         tsMap.get(record.Timesheet__c).Kronos_OverTimeBuffer__c = TotOTHrs;
                         
                     }
                     tsMap.get(record.Timesheet__c).Kronos_OverTime_Hours__c=TotOTHrs;
                     System.debug('Test-->::Total Time->'+record.Total_Time__c +' : Total Billable Hrs-->'+TotBillHrs  +' : Total OverTime Hrs-->' +TotOTHrs + ': Total Other Hrs-->'+TotExtraHrs);
                }
                System.debug('GE_OG_PC_KronosUtil::Total Hrs->'+TotalHrs +' : Total Billable Hrs-->'+TotBillHrs  +' : Total OverTime Hrs-->' +TotOTHrs + ': Total Other Hrs-->'+TotExtraHrs);
                System.debug('GE_OG_PC_KronosUtil::tsMap(PC)->'+tsMap);
                update tsMap.values();
            }
        }
    }
}