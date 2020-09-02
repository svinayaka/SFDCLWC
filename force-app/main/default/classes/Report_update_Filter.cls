/*
Class/Trigger Name     : Update_Report_filters 
Used Where ?           : Update Report filters process builder
Purpose/Overview       : To minimise the manual effort to send report to risk compliance team
Scrum Team             : Transformation - Platform MGMT
Requirement Number     : R-34280
Author                 : Kokilavani
Created Date           : 05/Jun/2020
Test Class Name        : Report_update_Filter
Code Coverage          : 75
*/
@isTest
public class Report_update_Filter {
    
    public testmethod static void testingreport()
    {
        test.startTest();
        Report_Export__c RE =new Report_Export__c();
 RE.Report_ID__c='00OA0000004hMQB';
 RE.Userid__c='005A0000000HC19';
insert RE;
    List<id> reportid1= new list<id>() ;
        reportid1.add('00OA0000004hMQB');
        
        Update_Report_filters.Updatereportfilters(reportid1);
        
        test.stoptest();
    }
}