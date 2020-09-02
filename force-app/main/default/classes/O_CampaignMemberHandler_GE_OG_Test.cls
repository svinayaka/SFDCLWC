/*
Class/Trigger Name     : O_CampaignMemberHandler_GE_OG_Test
Used For               : O_CampaignMemberHandler_GE_OG

Purpose/Overview       : Test Class to calculate the code coverage for the above classes
Scrum Team             : Transformation - Deal MGMT
Requirement Number     : R-23281
Author                 : Gourav Anand
Created Date           : 22-Feb-2017

*/

@isTest
public class O_CampaignMemberHandler_GE_OG_Test {

    @testsetup
    static void createRecord() {
        test.startTest();
        Opportunity_Trigger_Controller_ge_og__c oppScrumCmpgnTrig= CommonTestDataFactory_GE_OG.createCampaignTriggerCstmSetting(true, 'Campaign', 'O_Campaign_Trig_GE_OG');
        Opportunity_Trigger_Controller_ge_og__c  oppScrumCMRTrig = CommonTestDataFactory_GE_OG.createCampaignMemTriggerCstmSetting(true, 'CampaignMember', 'O_CampaignMember_Trig_GE_OG');
        Campaign theme = CommonTestDataFactory_GE_OG.createThemeCampaign('TestCMR GrvTheme1');
        Campaign program = CommonTestDataFactory_GE_OG.createProgramCampaign('TestCMR GrvProgram1', theme.Id); 
        Campaign campaign =  CommonTestDataFactory_GE_OG.createCampaign('TestCMR GrvCampaign1', program.Id); 
        Campaign campaign2 = CommonTestDataFactory_GE_OG.createCampaign('TestCMR GrvCampaign2', program.Id);
        Lead lead = CommonTestDataFactory_GE_OG.createLead('firstName', 'lastName');
        campaign2.Campaign_Business_Objective_ge_og__c='New Customers';
        campaign2.Campaign_Target_Personas_ge_og__c = 'Commercial Operations';
        campaign2.StartDate = System.today()+10;
        update campaign2;
            
        test.stopTest();
    }
    
    //Method to test CMR creation and update
    public static testMethod void testCMR(){
        test.startTest();
        Campaign campaignRec = [Select Id,name from Campaign where name='TestCMR GrvCampaign1'];
        //List<Campaign> cmgList = [Select Id,name,status,RecordTypeId from Campaign where Id =:campaignRec.Id];
        //O_CampaignMemberHandler_GE_OG cmrH = new O_CampaignMemberHandler_GE_OG();
        //cmrH.autoInsertCampaignMemberStatus(cmgList);
       /** campaignRec.Campaign_Business_Objective_ge_og__c='New Customers';
        campaignRec.Campaign_Target_Personas_ge_og__c = 'Commercial Operations';
        campaignRec.StartDate = System.today()+10;
        try{
            update campaignRec;
        }catch(Exception exc){
            System.debug('=================> O_CampaignMemberHandler_GE_OG_Test.testCMR: Getting error while updating campaignRec');
        } **/
        Lead lead = [Select Id,name from Lead where firstName='firstName' and lastName='lastName'];
        CampaignMember cmr = CommonTestDataFactory_GE_OG.createCampaignMember(campaignRec.Id, lead.Id);
        
        cmr.Owner_ge_og__c=UserInfo.getUserId();
        try{
            update cmr;
        }catch(Exception excp){
            System.debug('=================> O_CampaignMemberHandler_GE_OG_Test.testCMR: Getting error while updating cmr');
        }
        test.stopTest();
        
    }
    
    //Method to test CMR creation and update CMR to Qualifying
    public static testMethod void testCMRtoQualifying(){
        test.startTest();
        Campaign campaignRec = [Select Id,name from Campaign where name='TestCMR GrvCampaign2'];
        Lead lead = [Select Id,name from Lead where firstName='firstName' and lastName='lastName'];
        CampaignMember cmr = CommonTestDataFactory_GE_OG.createCampaignMember(campaignRec.Id, lead.Id);
        
        cmr.Owner_ge_og__c=UserInfo.getUserId();
        cmr.Last_Activity_Date_ge_og__c = System.today();
        try{
            update cmr;
        }catch(Exception excp){
            System.debug('=================> O_CampaignMemberHandler_GE_OG_Test.testCMR: Getting error while updating cmr');
        }
        System.debug('------- >>> CMR    Std status:'+cmr.Status);
        cmr.Status_ge_og__c='Qualifying';
        update cmr;
        test.stopTest();
        
    }
        
    //Method to test CMR disposition - Blacklisted
    public static testMethod void testCMRdisposition(){
        test.startTest();
        Campaign campaignRec =  [Select Id,name from Campaign where name='TestCMR GrvCampaign1'];
        Campaign campaignRec2 = [Select Id,name from Campaign where name='TestCMR GrvCampaign2'];
        /**campaignRec.Campaign_Business_Objective_ge_og__c='New Customers';
        campaignRec.Campaign_Target_Personas_ge_og__c = 'Commercial Operations';
        campaignRec.StartDate = System.today()+10;
        campaignRec.Status = 'Planned';
        
        try{
            update campaignRec;
            //update campaignRec2;
        }catch(Exception exc){
            System.debug('=================> O_CampaignMemberHandler_GE_OG_Test.testCMR: Getting error while updating campaignRec');
        } **/
        
        //System.debug('***###'+campaignRec.Status);
        
        //Lead lead = [Select Id,name from Lead where RecordType.Name= 'Deal Machine Lead' limit 1];
        Lead lead = [Select Id,name from Lead where firstName='firstName' and lastName='lastName'];
        CampaignMember cmr = CommonTestDataFactory_GE_OG.createCampaignMember(campaignRec.Id, lead.Id);
        CampaignMember cmr2 = CommonTestDataFactory_GE_OG.createCampaignMember(campaignRec2.Id, lead.Id);
        
        //cmr.Owner_ge_og__c=UserInfo.getUserId();
        cmr.Status_ge_og__c ='Lead Cancelled';
        cmr.Dispostion_Reason_ge_og__c = 'Blacklisted';
        try{
            update cmr;
        }catch(Exception excp){
            System.debug('=================> O_CampaignMemberHandler_GE_OG_Test.testCMR: Getting error while Blacklisting cmr');
        }
        test.stopTest();
        
    }
    
    //Method to disposition Qualifying CMR to Prospect  
}