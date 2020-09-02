/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(SeeAllData=true)
private class GE_OG_GS_ExpertiseUsageTest {

    static testMethod void updateExistingExperienceUsage() {
        SVMXC__Skill__c rootSkill = new SVMXC__Skill__c();
    	rootSkill.Name = 'TEst Root Skill';
    	insert rootSkill;
    	
        SVMXC__Skill__c skill = new SVMXC__Skill__c();
        skill.GE_OG_GS_Root_Skill_link__c = rootSkill.Id;
        skill.Name = 'Test Skill';
        insert skill;
        
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.Name = 'Test Team';
        insert team;
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
        tech.Name = 'Test Tech';
        tech.SVMXC__Service_Group__c = team.Id;
        insert tech;
        
        SVMXC__Service_Group_Skills__c exp = new SVMXC__Service_Group_Skills__c();
        exp.SVMXC__Skill__c = skill.Id;
        exp.SVMXC__Service_Group__c = team.Id;
		exp.GE_OG_GS_Root_Qualification_Level__c = 'Entry Level';
        exp.SVMXC__Group_Member__c = tech.Id;
        insert exp;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Group_Member__c = tech.Id;
        wo.GE_OG_GS_Skill_Requirement__c = 'Test Skill';
        wo.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c' AND NAme = 'GS-Requirement' LIMIT 1].Id;
        insert wo;
        
        Test.startTest(); 
        
        wo.SVMXC__Order_Status__c = 'Completed';
        update wo;
        
        exp = [SELECT Id, GE_OG_GS_Expertise_Usage_Counter__c FROM SVMXC__Service_Group_Skills__c WHERE Id = :exp.Id LIMIT 1];
        system.assertEquals(1, exp.GE_OG_GS_Expertise_Usage_Counter__c);
        
        Test.stopTest();
    }
    
    static testMethod void updateNonExistingExpertiseUsage() {
    	SVMXC__Skill__c rootSkill = new SVMXC__Skill__c();
    	rootSkill.Name = 'TEst Root Skill';
    	insert rootSkill;
    	
        SVMXC__Skill__c skill = new SVMXC__Skill__c();
        skill.GE_OG_GS_Root_Skill_link__c = rootSkill.Id;
        skill.Name = 'Test Skill';
        insert skill;
        
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.Name = 'Test Team';
        insert team;
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
        tech.Name = 'Test Tech';
        tech.SVMXC__Service_Group__c = team.Id;
        insert tech;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Group_Member__c = tech.Id;
        wo.GE_OG_GS_Skill_Requirement__c = 'Test Skill';
        wo.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c' AND NAme = 'GS-Requirement' LIMIT 1].Id;
        insert wo;
        
        Test.startTest(); 
        
        wo.SVMXC__Order_Status__c = 'Completed';
        update wo;
        
        List<SVMXC__Service_Group_Skills__c> skillList = [SELECT Id, GE_OG_GS_Expertise_Usage_Counter__c, SVMXC__Skill__c FROM SVMXC__Service_Group_Skills__c WHERE SVMXC__Group_Member__c = :tech.Id];
        system.assertEquals(2, skillList.size());
        
        for (SVMXC__Service_Group_Skills__c exp : skillList)
        {
        	if (exp.SVMXC__Skill__c == skill.Id)
        	{
        		system.assertEquals(1, exp.GE_OG_GS_Expertise_Usage_Counter__c);
        	}
        }
        
        
        Test.stopTest();
    }
}