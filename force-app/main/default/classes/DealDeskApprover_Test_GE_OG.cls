/*
Class/Trigger Name     : DealDeskApprover_Test_GE_OG
Used For               : DealDeskApprover_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the DealDeskApprover_GE_OG Class 
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-23474
Author                 : Sanath Kumar Dheram
Created Date           : 25-Oct-2015
*/

@isTest
public class DealDeskApprover_Test_GE_OG 
{
    @testsetup
    static void createRecord()
    {
        Test.startTest(); 
        //creating 'Country Region Mapping' for 'INDIA'
        Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
        insert objcustom;
    
        
        //Creating new account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
       // Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account LE',acc.ID,acc1.ID);
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
       
        opportunity opp2 = CommonTestDataFactory_GE_OG.createOppty('TestOppty2', acc.id);
         //commented extra 
        // opportunity oppty = [select id,deal_path_ge_og__c,is_global_ge_og__c,tier_2_ge_og__c, region_ge_og__c from opportunity where name = 'TestOppty'];
        Product2 product = new Product2();
        product.name = 'productName';
       // product.is_service_max_ge_og__c='Yes';
        product.GE_Tier2_PnL__c = 'Measurement & Control';
        product.GE_Tier3_PnL__c = 'Bently Nevada';
        insert product; 
        
        Deal_Reviewer_Criteria_ge_og__c drc = new Deal_Reviewer_Criteria_ge_og__c();
        drc.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
        drc.type_ge_og__c= 'Commercial Approver';
        //drc.deal_reviewer_criteria_region_ge_og__c= 'Global';
        drc.deal_reviewer_criteria_tier_2_ge_og__c = opp.tier_2_ge_og__c;
        
        insert drc;
        
        
        Deal_Reviewer_ge_og__c dr1 = new Deal_Reviewer_ge_og__c();
        //dr1.deal_reviewer_criteria_num_ge_og__c = drc.id;
        dr1.user_ge_og__c = UserInfo.getUserId();
        insert dr1;
        
        
        List<Checklist_Category_ge_og__c> checklistCategoryList = CommonTestDataFactory_GE_OG.createChecklistCategory();
        list<Checklist_ge_og__c> checklistList = CommonTestDataFactory_GE_OG.createChecklist(checklistCategoryList);
        list<Checklist_Deviation_ge_og__c> checklistDeviation = CommonTestDataFactory_GE_OG.createChecklistDeviation(checklistList);
        
        opportunity createdOppty = [select id, tier_2_ge_og__c, region_ge_og__c from opportunity where id =: opp.id];
        Test.stopTest();        
    }
    
    public static testMethod void testsubmitDealDesk()
    {
         //fetching oppty record created in above method
        
        Test.startTest(); 
        
        opportunity opp = [select id,deal_path_ge_og__c,tier_2_ge_og__c,tier_3_ge_og__c,amount_ge_og__c,oppty_cm_ge_og__c, region_ge_og__c from opportunity where name = 'TestOppty'];
        
        System.assert(opp != null, 'Opportunity not created');
        
        // for successfully creation of Deal Desk
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        System.assertEquals(dealSuccessresult,'Deal Desk Inserted Successfully');
        
        
        // calling again same functionality with already craeted Deal Desk
        string dealNotCreatedresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        //System.assertEquals(dealNotCreatedresult,'New Checklist cannot be generated because an Active Deal Desk record already exist');
        
        //fetching created Deal Desk
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c,deal_desk_opportunity_id_ge_og__c
                                       from Deal_Desk_ge_og__c WHERE deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        
        List<Id> lstDDId1 = new  List<Id>{dealDesk.Id};                              
         //List<string> submitResult1 = DealDeskSubmitForApproval_GE_OG.submitDealDesk(lstDDId1);
         //string dealSuccess1 = DealDeskSubmitForApproval_GE_OG.submitDealDesk(dealDesk.Id);
         
        dealDesk.active_deal_desk_ge_og__c=false;
        try{
            update dealDesk;
        }
        catch(exception e){
        
        }
        dealDesk.status_ge_og__c='Submitted';
        try{
        update dealDesk;
        }
        catch(exception e){}
        
        
        // calling again same functionality with active and Approved Deal Desk
        string approvedDealresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        //System.assertEquals(approvedDealresult,'Deal Desk Inserted Successfully');
        
        // Fetching All Deal Desk for Oppty
        List<Deal_Desk_ge_og__c> dealDeskList = [select id, active_deal_desk_ge_og__c from Deal_Desk_ge_og__c where deal_desk_opportunity_id_ge_og__c =: opp.id];
        //Deal Desk List for updating
        List<Deal_Desk_ge_og__c> updateDealDeskList = new List<Deal_Desk_ge_og__c>();
        //Deal Desk for updating the active to Inactive
        Deal_Desk_ge_og__c inactiveDeal = new Deal_Desk_ge_og__c();        
        
        // making all Deal Desk Active
        for(Deal_Desk_ge_og__c dd : dealDeskList){
            if (dd.active_deal_desk_ge_og__c )
                inactiveDeal = dd;
                
            dd.active_deal_desk_ge_og__c= true;
            updateDealDeskList.add(dd);
        }
        try{
            update updateDealDeskList;
        }
        
        catch(exception e){
        }
        
        //Trying to inactivate the active deal
        inactiveDeal.active_deal_desk_ge_og__c = false;
        
        try {
            update inactiveDeal;
        }
        catch (Exception e){
        }
        
        //Trying  Creating new Active Deal Desk over already craeted active Deal Desk
        Deal_Desk_ge_og__c objDealDesk = new Deal_Desk_ge_og__c();
        objDealDesk.deal_desk_opportunity_id_ge_og__c = opp.Id;
        objDealDesk.active_deal_desk_ge_og__c=true;
        try{
            insert objDealDesk;
        }
        catch(exception e){
        }
        
        List<Risk_Checklist_Category_ge_og__c>rccList = [select id, supported_ge_og__c, reviewer_comments_ge_og__c, submit_review_ge_og__c from Risk_Checklist_Category_ge_og__c where RCC_Opportunity_ge_og__c =:opp.Id];
        //Risk_Checklist_Category_ge_og__c rcc = [select id, submit_review_ge_og__c from Risk_Checklist_Category_ge_og__c limit 1];
        List<Risk_Checklist_Deviation_ge_og__c> rcdList = [Select id,rcl_deviation_level_ge_og__c from Risk_Checklist_Deviation_ge_og__c where risk_checklist_category_id_ge_og__c in : rccList ];
        //, rcl_deviation_ge_og__c
        List<Risk_Checklist_Deviation_ge_og__c> updateRCDList = new List<Risk_Checklist_Deviation_ge_og__c>();
        for(Risk_Checklist_Deviation_ge_og__c rcd : rcdList ){
            rcd.rcl_deviation_level_ge_og__c = 0;
            updateRCDList.add(rcd);
        }
        update updateRCDList;
        List<Risk_Checklist_Category_ge_og__c> updateRCCSubmitList = new List<Risk_Checklist_Category_ge_og__c>();
        for(Risk_Checklist_Category_ge_og__c rcc : rccList ){
            rcc.submit_review_ge_og__c = true;
            updateRCCSubmitList.add(rcc);
        }
        update updateRCCSubmitList;
        
        
        
        DealDeskApprover_GE_OG  objDealDeskApprover = new DealDeskApprover_GE_OG();
        objDealDeskApprover.SubmitRecord(dealDesk);
        
        
        try{
        objDealDeskApprover.ApproveRecord(dealDesk);
        }catch(Exception e){
            
        }
        //objDealDeskApprover.RejectRecord(dealDesk);
        
        Test.stopTest(); 
    }
    
    
    public static testMethod void testsubmitDealDesk1()
    {
        
        Test.startTest(); 
         //fetching oppty record created in above method
        opportunity opp = [select id,deal_path_ge_og__c,is_global_ge_og__c from opportunity where name = 'TestOppty'];
        opp.is_global_ge_og__c = true;
        update opp;
        System.assert(opp != null, 'Opportunity not created');
        
        // for successfully creation of Deal Desk
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        System.assertEquals(dealSuccessresult,'Deal Desk Inserted Successfully');
        
        
        // calling again same functionality with already craeted Deal Desk
        string dealNotCreatedresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        //System.assertEquals(dealNotCreatedresult,'New Checklist cannot be generated because an Active Deal Desk record already exist');
        
        //fetching created Deal Desk
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c, approver_comments_ge_og__c,deal_desk_opportunity_id_ge_og__c
                                       from Deal_Desk_ge_og__c WHERE deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        
        
        
        DealDeskApprover_GE_OG  objDealDeskApprover = new DealDeskApprover_GE_OG();
        //objDealDeskApprover.SubmitRecord(dealDesk);
        objDealDeskApprover.RecallRecord(dealDesk);
        //objDealDeskApprover.ApproveRecord(dealDesk);
        //objDealDeskApprover.RejectRecord(dealDesk);
        
        Test.stopTest(); 
    }
    
    
   
   public static testMethod void testsubmitDealDeskApproval()
    {
         //fetching oppty record created in above method
        
        Test.startTest(); 
        
        opportunity opp = [select id,deal_path_ge_og__c,tier_2_ge_og__c,tier_3_ge_og__c,amount_ge_og__c,oppty_cm_ge_og__c, region_ge_og__c from opportunity where name = 'TestOppty2'];
        
        Deal_Reviewer_Criteria_ge_og__c drc = new Deal_Reviewer_Criteria_ge_og__c();
        drc.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
        drc.type_ge_og__c= 'Commercial Approver';
        //drc.deal_reviewer_criteria_region_ge_og__c= opp.region_ge_og__c;
        drc.deal_reviewer_criteria_tier_2_ge_og__c = opp.tier_2_ge_og__c;
        drc.deal_reviewer_criteria_tier_3_ge_og__c = opp.tier_3_ge_og__c;
        drc.threshold_lower_limit_ge_og__c = Integer.valueOf(opp.amount_ge_og__c)-5;
        drc.threshold_upper_limit_ge_og__c = Integer.valueOf(opp.amount_ge_og__c)+5;
        drc.deal_cm_lower_limit_ge_og__c = Integer.valueOf(opp.oppty_cm_ge_og__c )-5;
        drc.deal_cm_upper_limit_ge_og__c = Integer.valueOf(opp.oppty_cm_ge_og__c )+5;
        Insert drc;
        
        Deal_Reviewer_ge_og__c drev = new Deal_Reviewer_ge_og__c();
        //drev.deal_reviewer_criteria_num_ge_og__c = drc.id;
        drev.user_ge_og__c = userInfo.getUserId();
        insert drev;
        
        // for successfully creation of Deal Desk
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        
        //fetching created Deal Desk
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c,deal_desk_opportunity_id_ge_og__c
                                       from Deal_Desk_ge_og__c WHERE deal_desk_opportunity_id_ge_og__c =: opp.id];
        dealDesk.approver_deal_desk_ge_og__c=UserInfo.getUserId();
        update dealDesk;
        
        system.debug('rrrrrrrrrrrrrrrrrrrrrrrrrr     '+ dealDesk);
        
        
        List<Risk_Checklist_Category_ge_og__c>rccList = [select id, supported_ge_og__c, reviewer_comments_ge_og__c, submit_review_ge_og__c from Risk_Checklist_Category_ge_og__c where RCC_Opportunity_ge_og__c =:opp.id];
        
        system.debug('sssssssssssssssssssssssss      '+rccList);
        
        List<Risk_Checklist_Deviation_ge_og__c> rcdList = [Select id,rcl_deviation_level_ge_og__c,checklist_reference_ge_og__c from Risk_Checklist_Deviation_ge_og__c where risk_checklist_category_id_ge_og__c in : rccList ];
        
        system.debug('fffffffffffffffffffffffffffffffffff     '+ rcdList);
        
        Map<Id,Checklist_Deviation_ge_og__c> cdMap = new Map<Id,Checklist_Deviation_ge_og__c>();
        for(Checklist_Deviation_ge_og__c cdg: [select id,checklist_id_ge_og__c from Checklist_Deviation_ge_og__c]){
            cdMap.put(cdg.checklist_id_ge_og__c, cdg);
            
        }
        
        List<Risk_Checklist_Deviation_ge_og__c> updateRCDList = new List<Risk_Checklist_Deviation_ge_og__c>();
        for(Risk_Checklist_Deviation_ge_og__c rcd : rcdList ){
            rcd.rcl_deviation_level_ge_og__c = 2;
            rcd.deviation_reference_ge_og__c = cdMap.get(rcd.checklist_reference_ge_og__c).id;
            updateRCDList.add(rcd);
        }
        update updateRCDList;
        List<Risk_Checklist_Category_ge_og__c> updateRCCSubmitList = new List<Risk_Checklist_Category_ge_og__c>();
        for(Risk_Checklist_Category_ge_og__c rcc : rccList ){
            rcc.submit_review_ge_og__c = true;
            updateRCCSubmitList.add(rcc);
        }
        update updateRCCSubmitList;
        
        system.debug('ttttttttttttttttttttttttt     '+[select supported_ge_og__c from Risk_Checklist_Category_ge_og__c]);
        
        DealDeskApprover_GE_OG  objDealDeskApprover = new DealDeskApprover_GE_OG();
        //Start To fix Validation error on submit deal desk for Initated stage value
       // dealDesk.status_ge_og__c = 'Submitted';
        dealDesk.approver_deal_desk_ge_og__c= UserInfo.getUserId();
        update dealDesk;
       //End
       
        try{       
        objDealDeskApprover.SubmitRecord(dealDesk);
        }catch(Exception exp){
            System.debug('--------------- Exception in SubmitRecord');
        }    
        //objDealDeskApprover.ApproveRecord(dealDesk);
        try{
        objDealDeskApprover.RejectRecord(dealDesk);
        }catch(Exception exp){
            System.debug('--------------- Exception in RejectRecord');
        }    
        
        Test.stopTest(); 
    }
    
    
}