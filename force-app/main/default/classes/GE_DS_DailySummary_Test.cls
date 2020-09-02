@istest(SeeAllData=false)
public class GE_DS_DailySummary_Test {

    static testMethod void testDailySummary(){
        
        
        SVMXC_Timesheet__c l_timeSheet = new SVMXC_Timesheet__c();
        test.startTest();
        insert l_timeSheet;
        System.debug('TimeSheet ID: '+l_timeSheet.Id);
        
        GE_DS_Daily_Time_Summary__c l_dailySummary = new GE_DS_Daily_Time_Summary__c();
        l_dailySummary.GE_DS_Timesheet__c = l_timeSheet.Id;
        
        insert l_dailySummary;
        System.debug('Summary ID: ' + l_dailySummary.Id);
        
        l_dailySummary.GE_DS_CDB_Type__c = 'Test Text';
        upsert l_dailySummary;
        
        test.stopTest();
    }
}