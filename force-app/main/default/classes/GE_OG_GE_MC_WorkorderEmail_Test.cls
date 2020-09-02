@isTest(Seealldata=true)
public class GE_OG_GE_MC_WorkorderEmail_Test{
    private static testMethod void GE_OG_GE_MC_WorkorderEmail(){
      SVMXC__Skill__c skill=new SVMXC__Skill__c();
      insert skill;
      SVMXC__Service_Order__c WO= new SVMXC__Service_Order__c();
      WO.SVMXC__Skill__c=skill.id;
      WO.GE_SM_HQ_Scheduled_Start_Date_Time__c=null;
      //WO.SVMXC__Company__r.Name='Test';
      WO.GE_OG_MC_ERP_Project_Number__c='Test';      
          WO.GE_OG_MC_Business_Unit__c='BN';
         WO.GE_OG_MC_Service_Region__c='ANZ';      
     
      
      //WO.name='Test';
      insert WO;  
      SVMXC__Service_Group__c serteam=new SVMXC__Service_Group__c();
      insert serteam;
      SVMXC__Service_Group_Members__c tech=new SVMXC__Service_Group_Members__c();
      tech.SVMXC__Email__c='abc@abc.com'   ;
      tech.SVMXC__Service_Group__c=serteam.id;
      insert tech;
      WO.SVMXC__Group_Member__c=tech.id;
      update WO;
      GE_MC_WorkorderEmail WOClass=new GE_MC_WorkorderEmail(WO.Id);
      Attachment attach=new Attachment();       
      attach.Name='Unit Test Attachment';
      Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
      attach.body=bodyBlob;
      attach.parentId=WO.id;
      insert attach;
      List<Attachment> attchment = [select name, body from Attachment where ParentId = : Wo.id];
     
      
      GE_MC_WorkorderEmail.sendTechEmail('test',WO.Id);
        }
      

}