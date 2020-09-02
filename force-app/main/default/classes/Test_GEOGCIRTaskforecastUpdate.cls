/**
 * 
 * Class/Trigger Name--: Test_GEOGCIRTaskforecastUpdate    
 * Purpose/Overview----: This test case is used to cover the code for GEOGCIRTaskforecastUpdate  
 * Author--------------: Sandeep Rayavarapu
 * Created Date--------: 1/10/2014
 * Trigger Name-----: GEOGCIRTaskforecastUpdate

 * Change History -

 * Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
   
**/
@istest
private class Test_GEOGCIRTaskforecastUpdate  
{   

   map<id,list<task>> maptasks = new map<id,list<task>>();
    static testmethod void testTaskForecastdatetoCase()
    {
        account a = new account();
        a.name='test';
        insert a;
        System.AssertEquals(a.name, 'test');
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        insert gi;
        
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C.GE_OG_Business_CIR__c='TMS'; 
        c.GE_OG_EHS_Product_Safety_CIR__c='Accident';
        c.GE_OG_Customer_Impact_CIR__c='High';
        c.GE_OG_Customer_Escalation_CIR__c='High';
        //c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        insert c; 
        
        Id trid= Schema.SObjectType.task.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        task t = new task();
        t.whatid=c.id;
        t.subject='Call';
        t.activitydate=date.valueof('2014-02-03');
        t.status='In Progress';
        t.recordtypeid=trid;
        insert t;
    
    }
}