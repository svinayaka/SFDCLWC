@isTest
public class GE_OG_CompetencyManagementControllerTest{
    
    static testmethod void expertiseTest(){
        
        // Start the test
        test.startTest();
        
        
        
        SVMXC__Service_Group__c steam= new SVMXC__Service_Group__c();
        steam.Name='test team';
        steam.GE_HQ_P_L_Level__c='O&G > D&S';
        steam.GE_HQ_Sub_P_L__c='Drilling';
        steam.GE_HQ_Region__c='APA';
        steam.GE_OG_GS_Service_Team_Type__c='Regional';
        
        
        insert steam;
        
        
        SVMXC__Service_Group_Members__c tech= new SVMXC__Service_Group_Members__c();
        tech.Name='tech1';
        tech.SVMXC__Service_Group__c=steam.id;
        tech.GE_DS_Career_Track_Level__c='Lead';
        tech.GE_OG_DS_Supervisor_Name__c='test';
        tech.GE_DRL_Target_Date__c=Date.Today();
        tech.GE_DS_FSE_Discipline__c='HT';
        insert tech;
        
        
        Id technicianId =tech.id;
        
        List<SVMXC__Skill__c > skillList = new List<SVMXC__Skill__c >();
        SVMXC__Skill__c sk= new SVMXC__Skill__c();
        sk.Name='Test Skill';
        sk.GE_DRL_Skill_Category__c='HT Lead';
        sk.GE_DRL_Professional_Target_Level__c='level 1';
        sk.GE_DRL_Lead_Target_Level__c='level 2';
        sk.GE_OG_DS_Product_Category__c='MUX Control System - Hydraulic';
        sk.GE_DRL_Master_Target_Level__c='level 2';
        sk.GE_OG_PC_Complexity__c='HT Master';
        sk.Business__c = 'D&S';
        sk.SVMXC__Skill_Area__c='Field Service';
        sk.Sub_Business__c= 'Drilling';
        sk.SVMXC__Skill_Category__c='HT';
        sk.SVMXC__Description__c='test';
        sk.GE_DRL_Lead_Target_Level__c='Test';
        sk.GE_OG_DS_FSCC_EX_ID__c='test0';
        
        //insert sk;
        skillList.add(sk);
        
        SVMXC__Skill__c sk1= new SVMXC__Skill__c();
        sk1.Name='Test Skill';
        sk1.GE_DRL_Skill_Category__c='HT Lead';
        sk1.GE_DRL_Professional_Target_Level__c='level 1';
        sk1.GE_DRL_Lead_Target_Level__c='level 2';
        sk1.GE_OG_DS_Product_Category__c='MUX Control System - Hydraulic';
        sk1.GE_DRL_Master_Target_Level__c='level 2';
        sk1.GE_OG_PC_Complexity__c='HT Master';
        sk1.Business__c = 'D&S';
        sk1.SVMXC__Skill_Area__c='Field Service';
        sk1.Sub_Business__c= 'Drilling';
        sk1.SVMXC__Skill_Category__c='HT';
        sk1.SVMXC__Description__c='test';
        sk1.GE_DRL_Lead_Target_Level__c='Test';
        sk1.GE_OG_DS_FSCC_EX_ID__c='test101';
        
        //insert sk1;
        skillList.add(sk1);
        
        SVMXC__Skill__c sk2= new SVMXC__Skill__c();
        sk2.Name='Test Skill';
        sk2.GE_DRL_Skill_Category__c='HT Lead';
        sk2.GE_DRL_Professional_Target_Level__c='level 1';
        sk2.GE_DRL_Lead_Target_Level__c='level 2';
        sk2.GE_OG_DS_Product_Category__c='MUX Control System - Hydraulic';
        sk2.GE_DRL_Master_Target_Level__c='level 2';
        sk2.GE_OG_PC_Complexity__c='HT Master';
        sk2.Business__c = 'D&S';
        sk2.SVMXC__Skill_Area__c='Field Service';
        sk2.Sub_Business__c= 'Drilling';
        sk2.SVMXC__Skill_Category__c='HT';
        sk2.SVMXC__Description__c='test';
        sk2.GE_DRL_Lead_Target_Level__c='Test';
        sk2.GE_OG_DS_FSCC_EX_ID__c='test2';
        
        //insert sk2;
        skillList.add(sk2);
        insert skillList;
        List<SVMXC__Service_Group_Skills__c> grList =  new List<SVMXC__Service_Group_Skills__c> ();
        SVMXC__Service_Group_Skills__c ex= new SVMXC__Service_Group_Skills__c();
        ex.SVMXC__Skill__c=sk.id;
        ex.GE_PC_WorkOrders_Completed__c=1;
        ex.Expertise_Level__c='Level 0';
        ex.SVMXC__Group_Member__c=tech.id;
        ex.GE_DRL_Skill_Category__c='HT Lead';
        ex.GE_OG_PC_Skill_Level_Target_Date__c=date.parse('3/27/2016');
        ex.SVMXC__Service_Group__c=steam.id;
        
        //insert ex;
        grList.add(ex);
        
        SVMXC__Service_Group_Skills__c ex2= new SVMXC__Service_Group_Skills__c();
        ex2.SVMXC__Skill__c=sk2.id;
        ex2.GE_PC_WorkOrders_Completed__c=1;
        ex2.Expertise_Level__c='Level 0';
        ex2.SVMXC__Group_Member__c=tech.id;
        ex2.GE_DRL_Skill_Category__c='HT Lead';
        ex2.SVMXC__Service_Group__c=steam.id;
        //ex.SVMXC__Skill__r.Name
        //ex. SVMXC__Group_Member__r.GE_SM_HQ_Business_Unit__c=
        //ex. Technician_Business_Unit__c=
        //ex.SVMXC__Service_Group__c=
        //ex.SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c
        
        ex2.SVMXC__Service_Group__c=steam.id;
        ex.GE_OG_PC_Skill_Level_Target_Date__c=Date.Today();
        //insert ex2;
        grList.add(ex2);
        insert grList;
        //cmt.init();
        
        GE_OG_CompetencyManagementController cmt = new GE_OG_CompetencyManagementController();
        
        cmt.expert.SVMXC__Group_Member__c = tech.id;
        cmt.techObj = tech;
        cmt.expert = ex;
        cmt.expertLst.add(ex); 
        cmt.expertLst.add(ex2);
        //cmt.skillLst.add(sk);
        cmt.skillLst=skillList;
        cmt.sortExpression  = 'SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c';
        cmt.sortDirection  = 'ASC';
        cmt.expert.GE_DRL_Skill_Category__c = 'HT Lead';
        //cmt.techObj.GE_OG_Technician_Business_Unit__c = tech.GE_OG_Technician_Business_Unit__c;
        
        cmt.showRecords();
        
        String BusinessUnit;
        String CareerTrack ;
        cmt.setSortDirection('DESC');
        cmt.getSortDirection();
        
        cmt.showEditpanel = false;
        cmt.showTechDetails = false;
        cmt.go();
        
        List<SVMXC__Service_Group_Skills__c> expList= new List<SVMXC__Service_Group_Skills__c>();
        expList.add(ex2);
        
        GE_OG_CompetencyManagementController.expertiseWrapper exp= new GE_OG_CompetencyManagementController.expertiseWrapper();
        exp.isSelect=false;
        exp.objExpert=ex;
        
        cmt.saveExpertise();
        
        GE_OG_CompetencyManagementController.expertiseWrapper exp1= new GE_OG_CompetencyManagementController.expertiseWrapper();
        exp1.isSelect=true;
        exp1.objExpert=ex2; 
        cmt.saveExpertise();
        
        
        
        GE_OG_CompetencyManagementController.skillWrapper skilwpr= new GE_OG_CompetencyManagementController.skillWrapper(sk1);
        skilwpr.isSelect1=true; 
        skilwpr.objSkill =  sk1;
        cmt.skillwrprList.add(skilwpr);
        
        
        BusinessUnit=tech.GE_OG_Technician_Business_Unit__c;
        CareerTrack =ex.GE_DRL_Skill_Category__c;                       
        Set<Id> skillIds= new Set<Id>();
        skillIds.add(ex.SVMXC__Skill__c);           
        cmt.showTechDetails= true;          
        //skilwpr.isSelect1=false;        
        
        
        
        cmt.Cancel();
        cmt.addExpertise();
        cmt.CheckaddExpertiseSuccess();
        cmt.CheckSuccess();
        cmt.CheckSelection();
        cmt.CheckSkillSelection();
        // Stop the test
        test.stopTest();
    }
    
    static testmethod void expertiseTest1(){
        
        test.startTest();
        
        GE_OG_CompetencyManagementController cmt1 = new GE_OG_CompetencyManagementController();
        cmt1.go();
        cmt1.Cancel();
        cmt1.addExpertise();
        cmt1.CheckaddExpertiseSuccess();
        cmt1.CheckSuccess();
        cmt1.CheckSelection();
        cmt1.CheckSkillSelection();
        test.stopTest();
        
    }
    
}