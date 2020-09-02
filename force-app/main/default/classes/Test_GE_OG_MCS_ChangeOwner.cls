/*    
Class Name        : Test_GE_OG_MCS_ChangeOwner
Purpose/Overview  : Test Class for GE_MCS_ChangeOwner
Author            : Raju Manche
Created Date      : 8 Apr 2015
Test Class        : Test_GE_OG_MCS_ChangeOwner
*/
@isTest(seeAlldata=false)
public class Test_GE_OG_MCS_ChangeOwner
{
    static testMethod  void Test_GE_OG_MCS_ChangeOwner_method()
    {
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        
        Account acc = new account();
        acc.name='TestClassAccount';
        insert acc;
        id MCSRecordTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId(); 
        case cs=new case();
        cs.status='new';
        cs.Origin='Email';
        cs.OwnerId=UserInfo.getUserId();
        cs.type='Customer Service';
        cs.GE_ES_Sub_Type__c='Technical Support Request';
        cs.recordtypeid = MCSRecordTypeID;
        cs.accountid=acc.Id;
        cs.GE_OG_MCS_Previous_Owner__c=null;
        insert cs;
        //Calling the Class
        GE_MCS_ChangeOwner changeOnr=new GE_MCS_ChangeOwner();
        changeOnr.caseId = cs.id;
        PageReference pr;
        pr=changeOnr.reDirect();  
      //pagereference pr =pr.reDirect();        
        pr=changeOnr.ChangeOwnerName();
        pr=changeOnr.PrevOwnerName();
        
        
    }
    
    static testMethod  void Test_GE_OG_MCS_ChangeOwner_method1()
    {
      //  Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        Account acc = new account();
        acc.name='TestClassAccount';
        insert acc;
        id MCTSRecordTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId(); 
        case cs=new case();
        cs.status='open';
        cs.Origin='Email';
        cs.GE_OG_CIR_Customer_Phone__c  ='45678123';
        cs.OwnerId=UserInfo.getUserId();
        cs.type='Customer Service';
        cs.GE_ES_Sub_Type__c='Technical Support Request';
        cs.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        cs.GE_OG_Business_CIR__c='TMS';        
        cs.recordtypeid = MCTSRecordTypeID;
        cs.accountid=acc.Id;
        cs.GE_OG_MCS_Previous_Owner__c=null;
        insert cs;
        //Calling the Class
        GE_MCS_ChangeOwner changeOnr=new GE_MCS_ChangeOwner();
        changeOnr.caseId = cs.id;
        PageReference pr;
        pr=changeOnr.reDirect();  
      //pagereference pr =pr.reDirect();        
        pr=changeOnr.ChangeOwnerName();
        pr=changeOnr.PrevOwnerName();
        
        
    }
}