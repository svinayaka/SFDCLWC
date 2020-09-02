/*
Class/Trigger Name     : RiskChecklistController_GE_OG_Test
Used For               : RiskChecklistController_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the OpportunityStagesAutomationHandler_GE_OG Class 
                        for OpportunityTrigger_GE_OG Trigger helper class
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23281
Author                 : Nitish Pandey
Created Date           : 17-Sep-2015

*/

@isTest

public class RiskChecklistController_GE_OG_Test{

    @testsetup
    static void createRecord(){
        
        
         //Creating new account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        //Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account LE',acc.ID,acc1.ID);
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        //creating Checklist Category records
        list<Checklist_Category_ge_og__c> clCategoryList = CommonTestDataFactory_GE_OG.createChecklistCategory();
        
        //creating Checklist records
        list<Checklist_ge_og__c> clList = CommonTestDataFactory_GE_OG.createChecklist(clCategoryList);
        
        //Creating Checklist Deviation records
        list<Checklist_Deviation_ge_og__c> cldList = CommonTestDataFactory_GE_OG.createChecklistDeviation(clList);
        
        //Creating Deal Reviewer Cirteria
        opportunity op = [select id, tier_2_ge_og__c, region_ge_og__c from opportunity where id=:opp.id];
        list<Deal_Reviewer_Criteria_ge_og__c> drcList = CommonTestDataFactory_GE_OG.createDealReviewerCriteria(op.tier_2_ge_og__c, op.region_ge_og__c);
        
        //Creating Deal reviewer
        list<Deal_Reviewer_ge_og__c> drList = CommonTestDataFactory_GE_OG.createDealApprover(drcList);
        
        
    }
    
    public static testMethod void testRiskChecklistMethod(){
    
        
        Map<id,List<Risk_Checklist_Deviation_ge_og__c>> ddRiskDeviationMap = new Map<id,List<Risk_Checklist_Deviation_ge_og__c>>();
        List<Risk_Checklist_Category_ge_og__c> rccList1 = new List<Risk_Checklist_Category_ge_og__c>();
        
        Test.startTest();
        
        opportunity opp = [select id from opportunity where name = 'TestOppty'];
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        //To test RCC creation 
        String riskSuccessresult = OG_O_Create_RiskChecklistCategory.createRiskChecklistCategory(opp.id);
        
        System.debug('nnnnnnnnnnnnnn deal desk:'  + dealSuccessresult);
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c 
                                       from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        List<Risk_Checklist_Category_ge_og__c>rccList = [select id, answered_all_deviation_ge_og__c, rcl_category_ge_og__c, tier_2_ge_og__c, region_ge_og__c, supported_ge_og__c, max_deviation_ge_og__c, reviewer_comments_ge_og__c, submit_review_ge_og__c from Risk_Checklist_Category_ge_og__c where RCC_Opportunity_ge_og__c  =:opp.id];
        system.debug('vvvvvvvvvvvvv   RC category'+ rccList);
        List<Risk_Checklist_Deviation_ge_og__c> rcdList = [Select id,deviation_reference_ge_og__r.checklist_deviation_level_ge_og__c,deviation_reference_ge_og__r.deviation_ge_og__c,checklist_reference_ge_og__r.question_ge_og__c, rcl_deviation_level_ge_og__c from Risk_Checklist_Deviation_ge_og__c where risk_checklist_category_id_ge_og__c in : rccList ];
        system.debug('ccccccccccccc   deviation '+ rcdList);
        List<Risk_Checklist_Deviation_ge_og__c> updateRCDList = new List<Risk_Checklist_Deviation_ge_og__c>();
        for(Risk_Checklist_Deviation_ge_og__c rcd : rcdList ){
            rcd.rcl_deviation_level_ge_og__c = 2;
            updateRCDList.add(rcd);
        }
        system.debug('xxxxxxxxxxxxxxxxxxxxxx    update deviation'+ updateRCDList );
        
        update updateRCDList;
        
       
        
        List<Risk_Checklist_Category_ge_og__c> updateRCCSubmitList = new List<Risk_Checklist_Category_ge_og__c>();
        List<Deal_Reviewer_Criteria_ge_og__c > drcList = new List<Deal_Reviewer_Criteria_ge_og__c>();
        String riskReviewerRecordType = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Deal Reviewer').getRecordTypeId();
        for(Risk_Checklist_Category_ge_og__c rcc : rccList){
            system.debug('ffffffffffffffff    '+rcc.answered_all_deviation_ge_og__c);
            Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
            //dr.deal_reviewer_criteria_category_ge_og__c= rcc.rcl_category_ge_og__c;
            dr.type_ge_og__c = 'Reviewer';
            dr.deal_reviewer_criteria_tier_2_ge_og__c = rcc.tier_2_ge_og__c;
            dr.deviation_level_ge_og__c = String.valueOf(rcc.max_deviation_ge_og__c);
            //dr.deal_reviewer_criteria_region_ge_og__c = rcc.region_ge_og__c;
            dr.recordTypeId = riskReviewerRecordType;
            drcList.add(dr);
          
        }
        insert drcList;
        ddRiskDeviationMap.put(rccList[0].id,updateRCDList);
            rccList1.add(rccList[0]);
        
        system.debug('mmmmmmmmmmmmmmmmmmmmmm   deal reviewer criteria'+ drcList);
        List<Deal_Reviewer_ge_og__c>dealReviewerList = CommonTestDataFactory_GE_OG.createDealApprover(drcList);
        system.debug('mmmmmmmmmmmmmmmmmmmmmm   deal reviewer '+ dealReviewerList);
        for(Risk_Checklist_Category_ge_og__c rcc : rccList ){
            rcc.submit_review_ge_og__c = true;
            updateRCCSubmitList.add(rcc);
        }
        
        try{
            update updateRCCSubmitList;
        }
        catch(exception e){}
    
        RiskChecklistController_GE_OG rccn = new RiskChecklistController_GE_OG();
        rccn.updateRiskCheckListDeviation(ddRiskDeviationMap,rccList1);
        
        List<Risk_Checklist_Category_ge_og__c> updateRCCReviewedList = new List<Risk_Checklist_Category_ge_og__c>();
        for(Risk_Checklist_Category_ge_og__c rcc : rccList ){
            rcc.reviewer_comments_ge_og__c= 'Test';
            rcc.status_ge_og__c = 'Submitted';
            updateRCCReviewedList.add(rcc);
        }
        try{
            update updateRCCReviewedList;
        }
        catch(exception e){}
        
        List<Opportunity> disposedOpptyList = new List<Opportunity>();
        disposedOpptyList.add(opp);
       
        OpportunityDisposedFunctionality odf = new OpportunityDisposedFunctionality();
        try{
        odf.removeRefrences(disposedOpptyList);
        }catch(Exception ex){}
        Test.stopTest();
    }
    
    //Method to test Risk regenerate RCC and its RCD
    public static testMethod void testRCCRegeneration(){
        System.debug('nnnnnnnnnnnnnn testRCCRegeneration:'  );
        Test.startTest();
        //Creating new account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        
        //creating new opportuntiy
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('GrvTestOppty', acc1.id);
        System.debug('nnnnnnnnnnnnnn createOppty:'  + opp);
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        //To test RCC creation 
        String riskSuccessresult = OG_O_Create_RiskChecklistCategory.createRiskChecklistCategory(opp.id);
        
        System.debug('nnnnnnnnnnnnnn deal desk:'  + dealSuccessresult);
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c 
                                       from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        //fetching created Risk Checklist which is active for the Oppty
        List<Risk_Checklist_Category_ge_og__c> createdRiskChecklist = [select id,RCC_Opportunity_ge_og__r.stageName, status_ge_og__c,rcl_category_ge_og__c,Is_Active_ge_og__c from Risk_Checklist_Category_ge_og__c where 
                                                        Is_Active_ge_og__c = true and RCC_Opportunity_ge_og__c =: opp.id];
        
        List<Risk_Checklist_Category_ge_og__c> fetchRCC = new List<Risk_Checklist_Category_ge_og__c>();
        for(Risk_Checklist_Category_ge_og__c rcc: createdRiskChecklist){
            rcc.status_ge_og__c='Submitted';
            system.debug('------------------Submitted occured--------------------------->');
            rcc.rcl_reviewer_ge_og__c=null;
            fetchRCC.add(rcc);
        }
        try{
            update fetchRCC;
        }catch(Exception e){
            system.debug('------------------Exception1 occured--------------------------->');
        }
        
        try{
            Risk_Checklist_Category_ge_og__c rcc1 = fetchRCC[0];
            rcc1.status_ge_og__c='Supported';
            system.debug('------------------Supported occured--------------------------->');
            update rcc1;
            String successRegenerate = O_RiskChecklistGenerator_GE_OG.generateRiskChecklistLogic(rcc1.Id);
        }catch(Exception exp){
            system.debug('------------------Exception2 occured--------------------------->');
        }
    }
    
    
    

}