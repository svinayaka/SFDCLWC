@isTest(SeeAllData=true)
private class GE_OG_GS_PrimaryExpertiseTest {
  
  /*
     * test validateSinglePrimarySkill 
     */
    public static testmethod void validateSinglePrimarySkillTest(){

      SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
      team.GE_HQ_P_L_Level__c = 'Turbomachinery Solutions';
      team.Name = 'Test Team';
      insert team;

      SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
      tech.SVMXC__Service_Group__c = team.Id;
      tech.Name = 'Test Tech';
      insert tech;

      SVMXC__Skill__c skill = new SVMXC__Skill__c();
      skill.Name = 'Test Skill';
      insert skill;

      SVMXC__Skill__c skill2 = new SVMXC__Skill__c();
      skill2.Name = 'Test Skill2';
      insert skill2;

      Test.startTest();

      SVMXC__Service_Group_Skills__c exp = new SVMXC__Service_Group_Skills__c();
      exp.SVMXC__Service_Group__c = team.Id;
      exp.SVMXC__Skill__c = skill.Id;
      exp.SVMXC__Group_Member__c = tech.Id;
      exp.SVMXC_Primary_Skill__c = true;
      insert exp;
      system.debug('TESTHERE');

      SVMXC__Service_Group_Skills__c exp2 = new SVMXC__Service_Group_Skills__c();
      exp2.SVMXC__Service_Group__c = team.Id;
      exp2.SVMXC__Skill__c = skill2.Id;
      exp2.SVMXC__Group_Member__c = tech.Id;
      exp2.SVMXC_Primary_Skill__c = true;

      try
      {
        insert exp2;
        //system.assert(false); // Should never reach here if everything works
      }
      catch (Exception ex)
      {}

      exp.SVMXC_Primary_Skill__c = false;
      update exp;

      insert exp2;

      Test.stopTest();
    
  }
  
}