@isTest
public class GE_PC_ExpertiseTechnicianUpdate_test {
  public static testmethod void updateexppoints()
    {
        Test.StartTest();        
        //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;
        
        //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '123456737',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_PC_Experience_Points__c=5,
        GE_PC_Parent_Skill__c='1000',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
         
        //Skill Insert
        SVMXC__Skill__c skill = new SVMXC__Skill__c();
        skill.name = 'Test JobType3';
        skill.GE_OG_PC_Complexity__c='Low';
        skill.GE_PC_Parent_Skill__c = '1000';
        skill.GE_PC_Experience_Points__c=4;
               insert skill;
        
         //Expertise Insert
       ID PCRecdtype=Schema.SObjectType.SVMXC__Service_Group_Skills__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
        SVMXC__Service_Group_Skills__c techexperts = new SVMXC__Service_Group_Skills__c();
       techexperts.RecordTypeId=PCRecdtype;
        techexperts.SVMXC__Service_Group__c = team.Id;
        techexperts.SVMXC__Group_Member__c = tech.Id;
        techexperts.SVMXC__Skill__c = skill.Id;
        techexperts.Expertise_Level__c = 'Level 2';
        techexperts.GE_PC_Sign_Off__c = True;
        techexperts.GE_OG_GS_Root_Qualification_Level__c='SFSE';
      //  techexperts.GE_PC_Experience_Points__c=5;
         insert techexperts;
         //Expertise Insert
        
        ID PCRectype=Schema.SObjectType.SVMXC__Service_Group_Skills__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
        SVMXC__Service_Group_Skills__c techexpertskill = new SVMXC__Service_Group_Skills__c();
        techexpertskill.RecordTypeId=PCRectype;
        techexpertskill.SVMXC__Service_Group__c = team.Id;
        techexpertskill.SVMXC__Group_Member__c = tech.Id;
        techexpertskill.SVMXC__Skill__c = skill.Id;
        techexpertskill.Expertise_Level__c = 'Level 2';
        techexpertskill.GE_PC_Sign_Off__c = True;
        techexpertskill.GE_OG_GS_Root_Qualification_Level__c='SFSE';
      //  techexperts.GE_PC_Experience_Points__c=5;
         insert techexpertskill; 
        
        ID PCRectype1=Schema.SObjectType.SVMXC__Service_Group_Skills__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
        SVMXC__Service_Group_Skills__c techexpertskill1 = new SVMXC__Service_Group_Skills__c();
        techexpertskill1.RecordTypeId=PCRectype1;
        techexpertskill1.SVMXC__Service_Group__c = team.Id;
        techexpertskill1.SVMXC__Group_Member__c = tech.Id;
        techexpertskill1.SVMXC__Skill__c = skill.Id;
        techexpertskill1.Expertise_Level__c = 'Level 2';
        techexpertskill1.GE_PC_Sign_Off__c = True;
        techexpertskill1.GE_OG_GS_Root_Qualification_Level__c='SFSE';
      //  techexperts.GE_PC_Experience_Points__c=5;
         insert techexpertskill1; 
           
          Test.stopTest();
    }
}