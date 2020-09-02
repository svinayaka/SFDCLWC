@isTest(Seealldata=True)
private class  GE_HQ_TechnicianResumeControllerTest {

    static testmethod void runControllerTest()
    {
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c(
           Name = 'testTeam'
        );
        
        insert team;
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
           SVMXC__Service_Group__c = team.Id,
           Name = 'Mr. Tech',
           GE_SM_HQ_SSO_ID__c = '123',
           GE_SM_HQ_Regional_Manager__c = UserInfo.getUserId()
        );
        
        insert tech;
        
        SVMXC__Skill__c skill=new SVMXC__Skill__c();
        insert skill;
        
        SVMXC__Service_Order__c wo  = new SVMXC__Service_Order__c();
           wo.SVMXC__Group_Member__c = tech.Id;
           wo.SVMXC__Skill__c=skill.id;
           wo.GE_SM_HQ_Scheduled_End_Date_Time__c = system.NOW() + 10;
           wo.GE_SM_HQ_Scheduled_Start_Date_Time__c = system.NOW() - 1;
            wo.GE_OG_MC_Service_Region__c = 'China';
            wo.GE_OG_MC_Business_Unit__c='BN';
       
        
        insert wo;
        
        Test.startTest();
        
        Test.setCurrentPage(Page.GE_OG_MC_TechnicianResume);    
        ApexPages.currentPage().getParameters().put('techId', tech.Id);
        GE_HQ_TechnicianResumeController c = new GE_HQ_TechnicianResumeController();
        
        system.assertEquals(tech.Name, c.Technician.Name);
        //system.assertEquals(1, c.WOList.size());
        //system.assert(c.getDisplayWorkExperience());
        system.assertEquals(system.today(), c.getToday());
        //c.getDisplaySkills();
        Test.stopTest();
    } 
    
    
}