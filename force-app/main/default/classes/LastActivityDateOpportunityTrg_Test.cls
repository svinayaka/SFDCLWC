/**
 * 
 * Class/Trigger Name--: LastActivityDateOpportunityTrg_Test
 * Purpose/Overview----: This class is for Covering trigger "LastActivityDateOpportunity" on Task 
 *                          and O_TaskRelationTrigger on Task_Relation 
 *                          and EmailToOpptyTeamMemebrs trigger on GE_ES_Request_Type__c
 * Author--------------: Mudit Arora/Gourav Anand
 * Created Date--------: 4-July-2016
 * Class/Trigger Coving: LastActivityDateOpportunity

 * Change History -

 * Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
   
**/



@isTest
public class LastActivityDateOpportunityTrg_Test {
    

 /*public static testMethod void testOpptyTask()
     {
     Test.startTest();
     
      //Creating an Account
      Account objacc = CommonTestDataFactory_GE_OG.createRelationshipAccount('test account');
      
      //Creating Opportunity
      Opportunity objopp = CommonTestDataFactory_GE_OG.createOppty('TestOppty',objacc.id);
         
      User u =[Select Id from User where Profile.name = 'OG_Sales/Comm Ops' limit 1];
      
      //Creating Task
      Task Objtsk = new Task();
      Objtsk.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();   
      Objtsk.Subject ='Opportunity Task';
      Objtsk.ActivityDate = Date.today()+10;
      Objtsk.Type ='Call';
      Objtsk.Status ='In Progress';
      Objtsk.WhatId = objopp.Id;
      Objtsk.Description= 'Test Task creation';
      Objtsk.Notification_Selection_ge_og__c=True;   
      //Objtsk.OwnerId=Userinfo.getUserId();
      Objtsk.OwnerId = u.id;
      Objtsk.CreatedById=Userinfo.getUserId();
      insert Objtsk;
      
      //Task Update
      Objtsk.Status = 'Completed';
      Update Objtsk;
     
      Test.stopTest();
     }*/

    public static testMethod void testAccntTask()
     {
     Test.startTest();
     
      //Creating an Account
      Account objacc = CommonTestDataFactory_GE_OG.createRelationshipAccount('test account');
      
      
      //Creating Task
      Task Objtsk = new Task();
      Objtsk.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();   
      Objtsk.Subject ='Account Task';
      Objtsk.ActivityDate = Date.today()+10;
      Objtsk.Type ='Call';
      Objtsk.Status ='In Progress';
      Objtsk.WhatId = objacc.Id;
      Objtsk.Description= 'Test Task creation';
      Objtsk.Notification_Selection_ge_og__c=True; 
      Objtsk.OwnerId=Userinfo.getUserId();
      Objtsk.CreatedById=Userinfo.getUserId();
      insert Objtsk;
      
      //Task Update
      Objtsk.Status = 'Completed';
      Update Objtsk;
     
      Test.stopTest();
     }
    
        public static testMethod void testProjectTask()
     {
     Test.startTest();
        //Creating an Account
        Account objacc = CommonTestDataFactory_GE_OG.createRelationshipAccount('test account');
      //Creating a Project
        Project_ge_og__c prj = new Project_ge_og__c();
        prj.name = 'Test';
        prj.Project_Summary_ge_og__c = 'Test';
        prj.project_account_ge_og__c = objacc.id;
        prj.Estimated_Value_ge_og__c = 10;
        Prj.Project_Stage_ge_og__c='Negotiation';
        Insert prj;
      
      
      //Creating Task
      Task Objtsk = new Task();
      Objtsk.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();   
      Objtsk.Subject ='Project Task';
      Objtsk.ActivityDate = Date.today()+10;
      Objtsk.Type ='Call';
      Objtsk.Status ='In Progress';
      Objtsk.WhatId = prj.Id;
      Objtsk.Description= 'Test Task creation on Project';
      Objtsk.Notification_Selection_ge_og__c=True;   
      Objtsk.OwnerId=Userinfo.getUserId();
      Objtsk.CreatedById=Userinfo.getUserId();
      insert Objtsk;
      
      //Task Update
      Objtsk.Status = 'Completed';
      Update Objtsk;
     
      Test.stopTest();
     }

    
    public static testMethod void testTaskRelation(){
       
      
      //Creating an Account
      Account objacc = CommonTestDataFactory_GE_OG.createRelationshipAccount('test account');
      
      //Creating Opportunity
      Opportunity objopp = CommonTestDataFactory_GE_OG.createOppty('TestOppty',objacc.id);
      //Creating Task
      Task Objtsk = new Task();
      Objtsk.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Task','Deal Machine Task').getRecordTypeId();   
      Objtsk.Subject ='Opportunity Task';
      Objtsk.ActivityDate = Date.today()+10;
      Objtsk.Type ='Call';
      Objtsk.Status ='In Progress';
      Objtsk.WhatId = objopp.Id;
      Objtsk.Description= 'Test Task creation';
      Objtsk.Notification_Selection_ge_og__c=True; 
      Objtsk.OwnerId=Userinfo.getUserId();
      Objtsk.CreatedById=Userinfo.getUserId();
      insert Objtsk;
      
      //Creating Task Relation
      Task_Relation_ge_og__c tskRel = new Task_Relation_ge_og__c();
      tskRel.Invitee_ID_ge_og__c = UserInfo.getUserId();
      tskRel.Task_ID_ge_og__c =   Objtsk.Id;
      tskRel.Email_Id_ge_og__c =   UserInfo.getUserEmail();
      insert tskRel;
      Test.startTest();
     
      //Task Update
      Objtsk.Status = 'Complete';
      Update Objtsk;
     
      Test.stopTest();
    }
  
}