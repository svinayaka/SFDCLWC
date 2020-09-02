@istest
private class Test_GE_OG_Tsk_Status_Changng_Mail  
{
    static testmethod void testGE_OG_Tsk_Status_Changng_Mail()
    {
    test.starttest();
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
        
        Id TaskRecTypeID = Schema.SObjectType.Task.getRecordTypeInfosByName().get('DS').getRecordTypeId();
        task t = new task();
        t.whatid=c.id;
        t.subject='Call';
        Date newDate = date.today().addDays(7);
        t.activitydate=newDate;
        t.status='In Progress';
        t.recordtypeid=TaskRecTypeID;
        insert t;
        
        t.status='Completed';
        update t;
    test.stoptest();
    }
   }