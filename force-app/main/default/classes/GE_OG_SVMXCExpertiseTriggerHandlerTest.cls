@isTest(SeeAllData=true)
private class GE_OG_SVMXCExpertiseTriggerHandlerTest {
	
	@isTest static void triggerHandlerTest() {
		SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
    	team.GE_HQ_P_L_Level__c = 'O&G > TMS/DTS';
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

    	update exp;

    	delete exp;

    	undelete exp;
	}
	
	
}