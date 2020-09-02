/*
Class/Trigger Name     : O_Lead_Test_GE_OG
Used For               : O_Lead_Trig_GE_OG & O_LeadHandler_GE_OG

Purpose/Overview       : Test Class to calculate the code coverage for the above Lead classes
Scrum Team             : Opportunity MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 01-MAR-2017

*/

@isTest
public class O_Lead_Test_GE_OG {
    
	@testsetup
    static void createRecord() {
        test.startTest();
        Opportunity_Trigger_Controller_ge_og__c  oppScrumCmpgnTrig= CommonTestDataFactory_GE_OG.createCampaignTriggerCstmSetting(true, 'Campaign', 'O_Campaign_Trig_GE_OG');
        Opportunity_Trigger_Controller_ge_og__c  oppScrumCMRTrig  = CommonTestDataFactory_GE_OG.createCampaignMemTriggerCstmSetting(true, 'CampaignMember', 'O_CampaignMember_Trig_GE_OG');
    	Opportunity_Trigger_Controller_ge_og__c  oppScrumLeadTrig = CommonTestDataFactory_GE_OG.createLeadTriggerCstmSetting(true, 'Lead', 'O_Lead_Trig_GE_OG');
    	
        Campaign theme = CommonTestDataFactory_GE_OG.createThemeCampaign('TestLead GrvTheme1');
        Campaign program = CommonTestDataFactory_GE_OG.createProgramCampaign('TestLead GrvProgram1', theme.Id); 
        Campaign cmpgn = CommonTestDataFactory_GE_OG.createCampaign('TestLead GrvCampaign1', program.Id); 
        test.stopTest();
    } 
    
    public static testmethod void updateBlkListLead(){
        test.startTest();
        Campaign themeRec = [Select Id,name from Campaign where name='TestLead GrvTheme1'];
        Campaign programRec = [Select Id,name from Campaign where name='TestLead GrvProgram1'];
        Campaign campaignRec = [Select Id,name from Campaign where name='TestLead GrvCampaign1'];
        campaignRec.Campaign_Business_Objective_ge_og__c='New Customers';
        campaignRec.Campaign_Target_Personas_ge_og__c = 'Commercial Operations';
        campaignRec.StartDate = System.today()+10;
        try{
            update campaignRec;
        }catch(Exception exc){
            System.debug('=================> O_Lead_Test_GE_OG.updateBlkListLead: Getting error while updating campaignRec');
        }
        //Lead lead = [Select Id,name from Lead where RecordType.Name= 'Deal Machine Lead' limit 1];
        Lead leads = new Lead();
        
        leads = CommonTestDataFactory_GE_OG.createLead('firstName1', 'LastName1');
        CampaignMember cmr = CommonTestDataFactory_GE_OG.createCampaignMember(campaignRec.Id, leads.Id);
        //CampaignMember cmr = CommonTestDataFactory_GE_OG.createCampaignMember(campaignRec.Id, lead.Id);
        System.debug('------------->> Test lead status'+leads.Status);
        leads.Custom_Status_ge_og__c='Blacklisted';
        leads.Description='Blacklist Lead';
        System.debug('------------->> Test lead custom status'+leads.Custom_Status_ge_og__c);
        try{
            update leads;
        }catch(Exception exc){
            System.debug('---------------------- Error while blacklisting Lead'+exc.getCause()+exc.getMessage());
        }
        test.stopTest();
    }

}