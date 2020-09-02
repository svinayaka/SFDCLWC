@IsTest
Public class TaskEmailOperationsTest {


    
    
    static testMethod void TaskEmailOperationsTest ()
    {
   test.starttest();
    
    Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
        account a = new account();
        a.name='test';
        insert a;
        
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        insert gi;
         system.assertequals(gi.name,'test');
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C.GE_OG_Business_CIR__c='TMS';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=null;   
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;  
        c.recordtypeid = r;
        c.accountid=a.Id;
        c.GE_OG_MC_TS_Name_of_Site_Contact__c='testest';
        c.GE_OG_CIR_Customer_Phone__c='233233333';
        insert c; 
        
      
        
        
         TaskEmailOperations cw1=new TaskEmailOperations ();
        // cw1.SendEmailOnStatusChange();
         task t=new task();
        t.Status='New';
        t.subject='test';
        t.whatid=c.id;
        insert t;   
        
        task t1=new task();
        t1.Status='In Progress';
        t1.subject='test';
        t1.whatid=c.id;
        insert t1;  
        
        List<task>tt=new List<task>();     
        tt.add(t);
        tt.add(t1);
        Map <id,task>oldMap = new Map<id,task>();
        oldmap.put(t.id, t);
        Map<Id,task>oldMaptask1=(Map<Id,task>)oldMap;
        oldMaptask1.put(t.id, t1);       
        t.status='closed';
        update t;     
        
         
      //  TaskEmailOperations cw2=new TaskEmailOperations ();
           test.stoptest();
            

    }    
    
    }