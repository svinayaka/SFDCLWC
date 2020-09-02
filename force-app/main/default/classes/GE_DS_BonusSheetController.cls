/*****************
Author: Chris Hurd
GE OG D&S
Summary: This is used to generate bonus sheet.
*****************/
public with sharing class GE_DS_BonusSheetController {
    
    public Id timesheetId = System.currentPageReference().getParameters().get('id');
    public SVMXC__Service_Group_Members__c tech {get;set;}
    public List<GE_DS_Daily_Time_Summary__c> entryList {get;set;}
    public SVMXC_Timesheet__c ts {get;set;}
    public GE_DS_Daily_Time_Summary__c total {get;set;}
    
    public GE_DS_BonusSheetController()
    {
        ts = [SELECT Id, Technician__c, CurrencyIsoCode, End_Date__c FROM SVMXC_Timesheet__c WHERE Id = :timesheetId LIMIT 1];
        tech = [SELECT Id,  GE_OG_DS_Supervisor_Name__c, GE_SM_HQ_SSO_ID__c, Name, GE_OG_DS_FSCC_EX_ID__c FROM SVMXC__Service_Group_Members__c WHERE Id = :ts.Technician__c LIMIT 1 ];
        entryList = [SELECT Id, GE_DS_Date__c, GE_DS_Bonus_Day__c, GE_DS_Bonus_Rate__c, GE_DS_Premium_Holiday_Bonus__c, GE_DS_Bonus_Amount__c FROM GE_DS_Daily_Time_Summary__c WHERE GE_DS_Timesheet__c = :ts.Id AND GE_DS_Bonus_Amount__c > 0 ORDER BY GE_DS_Date__c ASC ];
        
        total = new GE_DS_Daily_Time_Summary__c();
        total.CurrencyIsoCode = ts.CurrencyIsoCode;
        total.GE_DS_Bonus_Rate__c = 0;
        
        for (GE_DS_Daily_Time_Summary__c entry : entryList)
        {
            total.GE_DS_Bonus_Rate__c += entry.GE_DS_Bonus_Amount__c;
        }
    }

}