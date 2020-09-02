@isTest

public class Reportlogtest
{
    
   
static testmethod void Reporttest()
 {
Report_Export__c RE =new Report_Export__c();
 RE.Report_ID__c='00OA0000004hMQB';
 RE.Userid__c='005A0000000HC19';
insert RE;
system.assertEquals(RE.Userid__c,'005A0000000HC19');

Report_Export__c RE1 =new Report_Export__c();
 RE1.Report_ID__C='';
 RE1.Userid__c='005A0000000HC19';
insert RE1;
system.assertEquals(RE1.Report_ID__C,'');

Private_Reports__c pvr = new Private_Reports__c();
pvr.Report_ID__c='00O0t000000gUol';
pvr.Report_Created_By__c='0051H00000AwGCF';
insert pvr;

Report_Export__c RE2=new Report_Export__c();
RE2.Report_ID__C='00O0t000000gUol';
RE2.Userid__c='0051H00000AwGCF';
insert RE2;
system.assertEquals(RE2.Report_ID__C,'00O0t000000gUol');

}
}