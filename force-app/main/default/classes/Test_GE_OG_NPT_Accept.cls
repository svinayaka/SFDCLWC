@istest
private class Test_GE_OG_NPT_Accept {
    
   
    static testmethod void method1()
    {
        test.starttest();
        Profile sProfileID = [select id from profile where name ='GE_OG_Super User'  limit 1];
        User superuser= [select id ,name from user where profileid=:sProfileID.id And Isactive = true limit 1];
        System.runas(superuser){
     
        account a = new account();
        a.name='test';
        insert a;
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();
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
        c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';  
     
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
       
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        c.setOptions(dmlOpts);
        insert c; 
        System.debug('Owner details' + c.OwnerId);
        apexpages.currentpage().getparameters().put('CaseId',c.id);
     
        GE_OG_NPT_Accept ge = new GE_OG_NPT_Accept();
        ge.ChangeOwnerName();
        ge.ChangeOwnerName();
        
        
         case c1 = new case();        
        c1.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C1.GE_OG_Business_CIR__c='TMS'; 
        c1.GE_OG_EHS_Product_Safety_CIR__c='Accident';
        c1.GE_OG_Customer_Impact_CIR__c='High';
        c1.GE_OG_Customer_Escalation_CIR__c='High';
        c1.GE_OG_Sub_Business_CIR__c='Trees';    
        c1.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c1.GE_ES_Sub_Type__c='MCS Sub Status';  
     
        c1.accountid=a.id;   
        c1.recordtypeid=r;
        c1.status='Waiting for Customer';
        
         insert c1;
         System.debug('Owner details' + c1.OwnerId);
        test.stoptest();}
    }
    
     static testmethod void method2()
    {
        test.starttest();
       
        Group testGroup = new Group(Name = 'Queue', Type = 'Queue');
        insert testGroup;
        
        User objUser =  [Select id,name from User where id = :UserInfo.getUserID()];
        
        
        QueueSobject testQueue = new QueueSObject(QueueId = testGroup.Id, SobjectType = 'Case');
        insert testQueue;
        
        GroupMember grpmem = new GroupMember(GroupId=testGroup.Id, UserOrGroupId=objUser.Id);
        insert grpmem;
  
System.runAs(objUser) {   
   

        account a = new account();
        a.name='test';
        insert a;
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();
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
        c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';  
     
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        
        
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        c.setOptions(dmlOpts);
        insert c; 
        System.debug('Owner details' + c.OwnerId);
        apexpages.currentpage().getparameters().put('CaseId',c.id);
     
        GE_OG_NPT_Accept ge = new GE_OG_NPT_Accept();
       
        ge.ChangeOwnerName();
        ge.ChangeOwnerName();
        
     
        
        }
           test.stoptest();
    }
}