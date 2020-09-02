/*
Class/Trigger Name     : O_SynergyDetail_Trig_GE_OG
Purpose/Overview       : To check for duplicate year synergy entry into Campaign
Scrum Team             : OPPTY MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 06/JUN/2017
Test Class Name        : O_SynergyDetail_Handler_GE_OG_Test
Code Coverage          : 80
Changes                :                   
*/

@isTest
public class O_SynergyDetail_Handler_GE_OG_Test {

    
    @testsetup
    static void createRecord() {
        test.startTest();
    	Opportunity_Trigger_Controller_ge_og__c oppScrumCampaignTrig = CommonTestDataFactory_GE_OG.createObjTriggerCstmSetting(true, 'Campaign', 'O_Campaign_Trig_GE_OG');
        Opportunity_Trigger_Controller_ge_og__c oppScrumSynDetailTrig = CommonTestDataFactory_GE_OG.createObjTriggerCstmSetting(true, 'Synergy_Detail_ge_og__c', 'O_SynergyDetail_Trig_GE_OG');
        Campaign theme    = CommonTestDataFactory_GE_OG.createSynergyTheme('Test GrvSynergyTheme1');
        Campaign program  = CommonTestDataFactory_GE_OG.createSynergyProgram('Test GrvSynergyProgram1', theme.Id);
                
        test.stopTest();
    }
    
    public static testmethod void checkDuplicateEntryOnCreate(){
        Campaign synProgram = [Select Id,name from Campaign where name = 'Test GrvSynergyProgram1'];
        Synergy_Detail_ge_og__c synergyRec = new Synergy_Detail_ge_og__c();
        synergyRec.Synergy_Campaign_ID_ge_og__c = synProgram.Id;
        synergyRec.Year_ge_og__c = '2017';
        synergyRec.est_revenue_ge_og__c = 100.00;
        synergyRec.investment_ge_og__c = 101.00;
        insert synergyRec;
        
    }
    
}