@isTest
public class BHGE_CIR_CaseAction_ControllerTest{

 
 public static testmethod void cirCreationTest()
  {
  String CIRrecType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
    Profile sProfileID = [select id from profile where name ='GE_OG_Super User'  limit 1];
        User superuser= [select id ,name from user where profileid=:sProfileID.id And Isactive = true limit 1];
        
    account a = new account();
        a.name='test';
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        a.RecordtypeId = CommAccrecType ;
        a.ShippingCountry = 'INDIA';
        insert a;
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        gi.GE_ES_Station_Name__c='test';
        insert gi;
        system.assertequals(gi.name,'test');
        GE_OG_Product_Hierarchy1__c p = new GE_OG_Product_Hierarchy1__c();
        p.GE_OG_MCS_Assembly__c = 'Remote Visual Inspection';
        p.GE_OG_MCS_Business__c = 'Subsea (SS)';
        p.GE_OG_MCS_Component__c ='Video Borescopes';
        p.GE_OG_MCS_Item_Description1__c='Air Hose';
        p.GE_OG_MCS_Item_Description__c ='Accessory';
        p.GE_OG_MCS_Item__c = 'Flying Probe';
        p.GE_OG_MCS_Sub_Business__c='Inspection Technologies';
        p.Name ='OG_Prod_Hier__1341';
        insert p;  
       // System.runas(superuser){
        case c = new case();
      
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c = p.GE_OG_MCS_Business__c;        
        c.GE_ES_Sub_Type__c='MCS Sub Status';  
        c.Product_Hierarchy__c = p.id;
        c.accountid=a.id;   
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;  
        c.GE_OG_CIR_Assembly__c=p.GE_OG_MCS_Assembly__c;
        c.recordtypeid = CIRrecType;
        c.GE_OG_CIR_Component__c=p.GE_OG_MCS_Component__c;
        c.GE_OG_Sub_Business_CIR__c=p.GE_OG_MCS_Sub_Business__c;
        //c.GE_OG_CIR_Not_A_Key_Account__c  = true;
        c.GE_OG_CIR_Item__c =  p.GE_OG_MCS_Item__c ;
        c.status= 'new';
        c.Origin='Email';
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        c.setOptions(dmlOpts);
        insert c;
        case c1 = new case();
      
        c1.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C1.GE_OG_Business_CIR__c = p.GE_OG_MCS_Business__c;        
        c1.GE_ES_Sub_Type__c='MCS Sub Status';  
        c1.Product_Hierarchy__c = p.id;
        c1.accountid=a.id;   
        c1.GE_OG_CIR_Unit_Serial_number__c=gi.id;  
        c1.GE_OG_CIR_Assembly__c=p.GE_OG_MCS_Assembly__c;
        c1.recordtypeid = CIRrecType;
        c1.GE_OG_CIR_Component__c=p.GE_OG_MCS_Component__c;
        c1.GE_OG_Sub_Business_CIR__c=p.GE_OG_MCS_Sub_Business__c;
        //c.GE_OG_CIR_Not_A_Key_Account__c  = true;
        c1.GE_OG_CIR_Item__c =  p.GE_OG_MCS_Item__c ;
        c1.status= 'Open';
        c1.Origin='Email';
        AssignmentRule AR1 = new AssignmentRule();
        AR1 = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        Database.DMLOptions dmlOpts1 = new Database.DMLOptions();
        dmlOpts1.assignmentRuleHeader.assignmentRuleId= AR1.id;
        c1.setOptions(dmlOpts1);
        insert c1;
        System.Test.StartTest();
        BHGE_CIR_CaseAction_Controller.fetchProfile();
        BHGE_CIR_CaseAction_Controller.caseDetailServer(c.id);
        
        
          BHGE_CIR_CaseAction_Controller.acceptCase(c.id);
          BHGE_CIR_CaseAction_Controller.acceptCase(c1.id);
          BHGE_CIR_CaseAction_Controller.updateCase(c,'SendBack');
          BHGE_CIR_CaseAction_Controller.updateCase(c,'New');
        //BHGE_CIR_CaseAction_Controller.updateCase(c,'Closed');
        
        BHGE_CIR_CaseAction_Controller.getTaskInfo(c.id);
        
        case c2 = new case();
      
        c2.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C2.GE_OG_Business_CIR__c = p.GE_OG_MCS_Business__c;        
        c2.GE_ES_Sub_Type__c='MCS Sub Status';  
        c2.Product_Hierarchy__c = p.id;
        c2.accountid=a.id;   
        c2.GE_OG_CIR_Unit_Serial_number__c=gi.id;  
        c2.GE_OG_CIR_Assembly__c=p.GE_OG_MCS_Assembly__c;
        c2.recordtypeid = CIRrecType;
        c2.GE_OG_CIR_Component__c=p.GE_OG_MCS_Component__c;
        c2.GE_OG_Sub_Business_CIR__c=p.GE_OG_MCS_Sub_Business__c;
        //c.GE_OG_CIR_Not_A_Key_Account__c  = true;
        c2.GE_OG_CIR_Item__c =  p.GE_OG_MCS_Item__c ;
        c2.status= 'Open';
        c2.Origin='Email';
        
        insert c2;
        System.runas(superuser){
        BHGE_CIR_CaseAction_Controller.acceptCase(c2.id);
        BHGE_CIR_CaseAction_Controller.acceptCase(c.id);
        }
        System.Test.StopTest();
 
 //}
   
  }
  public static testmethod void acceptTest(){
       
        
        User objUser =  [Select id,name from User where id = :UserInfo.getUserID()];
         
        Group testGroup = [Select id from Group where name =:'O&G IT Support Team'];
        //insert testGroup;
        
        QueueSobject testQueue = new QueueSObject(QueueID = testGroup.Id, SobjectType = 'Case');
        insert testQueue;
        
        
        
        GroupMember grpmem = new GroupMember(GroupId=testGroup.id, UserOrGroupId=objUser.Id);
        insert grpmem;
  
        System.runAs(objUser) {
        String CIRrecType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
    account a = new account();
        a.name='test';
        insert a;
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
        c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status'; 
        //c.OwnerId =  testGroup.Id;
     
        c.accountid=a.id;   
        c.recordtypeid=r;
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        c.setOptions(dmlOpts);
        insert c;
        BHGE_CIR_CaseAction_Controller.acceptCase(c.id);
       
        
        }  
        
  }
  
  

}