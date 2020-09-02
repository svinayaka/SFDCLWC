/*
Class/Trigger Name     : O_Campaign_Test_GE_OG
Used For               : O_CampaignHelper_GE_OG & O_CampaignClosureAction

Purpose/Overview       : Test Class to calculate the code coverage for the above Campaign classes
Scrum Team             : Opportunity MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 22-MAR-2016

*/

@isTest
public class O_Campaign_Test_GE_OG {

    @testsetup
    static void createRecord() {
        test.startTest();
        Opportunity_Trigger_Controller_ge_og__c oppScrumTrig = CommonTestDataFactory_GE_OG.createCampaignTriggerCstmSetting(true, 'Campaign', 'O_Campaign_Trig_GE_OG');
        Campaign theme    = CommonTestDataFactory_GE_OG.createThemeCampaign('Test GrvTheme1');
        Campaign program  = CommonTestDataFactory_GE_OG.createProgramCampaign('Test GrvProgram1', theme.Id);
        Campaign program2 = CommonTestDataFactory_GE_OG.createProgramCampaign('Test GrvProgram2', theme.Id);
                
        test.stopTest();
    }
    
    public static testMethod void testDraftCampaign(){
        Campaign themeRec = [Select Id,name from Campaign where name='Test GrvTheme1'];
        Campaign programRec = [Select Id,name from Campaign where name='Test GrvProgram1'];
        Campaign campaignRec = CommonTestDataFactory_GE_OG.createCampaign('Test GrvCampaign1', programRec.Id);
        campaignRec.Campaign_Business_Objective_ge_og__c='New Customers';
        campaignRec.Campaign_Target_Personas_ge_og__c = 'Commercial Operations';
        campaignRec.Lead_Type_ge_og__c = 'Proactive contact';
        update campaignRec;
    }
    
    public static testMethod void testPlannedCampaign(){
        Campaign themeRec = [Select Id,name from Campaign where name='Test GrvTheme1'];
        Campaign programRec = [Select Id,name from Campaign where name='Test GrvProgram1'];
        Campaign campaignRec = CommonTestDataFactory_GE_OG.createCampaign('Test GrvCampaign1', programRec.Id);
        campaignRec.Campaign_Business_Objective_ge_og__c='New Customers';
        campaignRec.Campaign_Target_Personas_ge_og__c = 'Commercial Operations';
        campaignRec.StartDate = System.today()+10;
        campaignRec.Lead_Type_ge_og__c = 'Proactive contact';
        update campaignRec;
    }
    
    public static testMethod void testAbortedCampaign(){
        Campaign themeRec = [Select Id,name from Campaign where name='Test GrvTheme1'];
        Campaign programRec = [Select Id,name from Campaign where name='Test GrvProgram1'];
        Campaign campaignRec = CommonTestDataFactory_GE_OG.createCampaign('Test GrvCampaign1', programRec.Id);
        campaignRec.Campaign_Business_Objective_ge_og__c='New Customers';
        campaignRec.Campaign_Target_Personas_ge_og__c = 'Commercial Operations';
        campaignRec.StartDate = System.today()+10;
        campaignRec.Custom_Status_ge_og__c='Aborted';
        update campaignRec;
    }
    
    //To test change in Parent Id for a campaign
    public static testMethod void testAbortedCampaign1(){
        Campaign themeRec = [Select Id,name from Campaign where name='Test GrvTheme1'];
        Campaign programRec1 = [Select Id,name from Campaign where name='Test GrvProgram1'];
        Campaign programRec2 = [Select Id,name from Campaign where name='Test GrvProgram2'];
        Campaign campaignRec = CommonTestDataFactory_GE_OG.createCampaign('Test GrvCampaign1', programRec1.Id);
        campaignRec.ParentId = programRec2.Id;
        update campaignRec;
    }
    static testMethod void ProcessCampaignMemberRecords(){
        //ProcessClosedOpportunities_GE_OG p = new ProcessClosedOpportunities_GE_OG();
        O_CampaignMemberStatus_GE_OG.ProcessCampaignMemberRecords();
        
    }
    static testMethod void ProcessCampaignHelperRecords(){
        //ProcessClosedOpportunities_GE_OG p = new ProcessClosedOpportunities_GE_OG();
        O_CampaignHelper_GE_OG.ProcessCampaignRecords();
        
    }
    
 }