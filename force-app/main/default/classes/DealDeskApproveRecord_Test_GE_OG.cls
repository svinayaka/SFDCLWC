/*
Class/Trigger Name     : DealDeskApproveRecord_Test_GE_OG
Used For               : DealDeskApproveRecord_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the DealDeskApproveRecord_GE_OG Class 
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-23474
Author                 : Sanath Kumar Dheram
Created Date           : 25-Oct-2015
*/

@isTest
public class DealDeskApproveRecord_Test_GE_OG 
{
     @testsetup
    static void createRecord()
    {
        //Creating new account
        account acc = CommonTestDataFactory_GE_OG.createRelationshipAccount('Test Account');
        //account accCountry = CommonTestDataFactory_GE_OG.createCommercialParentAccount('Test Account Country');
        //account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccount('Test Account LE',accCountry.Id);
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        Product2 product = new Product2();
        product.name = 'Grv_productName';
        //Changed to Digital Solutions
        product.GE_Tier2_PnL__c = 'Digital Solutions';
        product.GE_Tier3_PnL__c = 'Bently Nevada';
        insert product; 
        
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = product.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=opp.Id;
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=2;
        objOppline.UNITPRICE=30; 
        objOppline.GE_OG_SS_Oppty_Product_CM__c = 45;
        insert objOppline;
        
    }
    
    public static testMethod void testsubmitDealDesk()
    {
        test.startTest();
         //fetching oppty record created in above method
        opportunity opp = [select id from opportunity where name = 'TestOppty'];
        System.assert(opp != null, 'Opportunity not created');
        
        // for successfully creation of Deal Desk
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        System.assertEquals(dealSuccessresult,'Deal Desk Inserted Successfully');
        
        //To Submit and approve PreBid & RCC 
        //To test RCC creation 
        string riskSuccessresult = OG_O_Create_RiskChecklistCategory.createRiskChecklistCategory(opp.id);
       // calling again same functionality with already created Deal Desk
        string dealNotCreatedresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        
        //PreBid fetch and approve
        Prebid_Approval_Process_GE_OG  prebid = new Prebid_Approval_Process_GE_OG ();
        Pre_Bid_ge_og__c preBidList=[Select id,pre_bid_status_ge_og__c,pre_bid_opportunity_ge_og__r.HasOpportunityLineItem,pre_bid_region_ge_og__c  from Pre_Bid_ge_og__c limit 1];
        preBidList.pre_bid_status_ge_og__c  ='Submitted';
        preBidList.pre_bid_uploaded_ge_og__c = true;
        try{
        update preBidList;
       prebid.SubmitRecord(preBidList); 
            system.debug('------------------prebid.SubmitRecord-------------------------->');
        }catch(Exception ex){
            system.debug('------------------prebid.SubmitRecord failed-------------------------->'+ex.getMessage());
        }
        
        //fetching created Risk Checklist which is active for the Oppty
        List<Risk_Checklist_Category_ge_og__c> createdRiskChecklist = [select id,RCC_Opportunity_ge_og__r.stageName, status_ge_og__c,rcl_category_ge_og__c,Is_Active_ge_og__c from Risk_Checklist_Category_ge_og__c where 
                                                        Is_Active_ge_og__c = true and RCC_Opportunity_ge_og__c =: opp.id];
        List<Risk_Checklist_Category_ge_og__c> fetchRCC = new List<Risk_Checklist_Category_ge_og__c>();
        for(Risk_Checklist_Category_ge_og__c rcc: createdRiskChecklist){
            rcc.status_ge_og__c='Submitted';
            fetchRCC.add(rcc);
        }
        try{
            update fetchRCC;
            system.debug('------------------update fetchRCC submit-------------------------->');
        }catch(Exception e){
            system.debug('------------------update fetchRCC failed-------------------------->'+e.getMessage());
        }
       // Ends for implementing validation check of PreBid & RCC approval
        
        //fetching created Deal Desk
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c
                                       from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];
        
         List<Id> lstDDId1 = new  List<Id>{dealDesk.Id};                              
         
        dealDesk.approver_comments_ge_og__c ='Reviewer Comment';
        dealDesk.status_ge_og__c = 'Submitted';
        dealDesk.approver_deal_desk_ge_og__c = Userinfo.getUserId();
        
        Update dealDesk;
         
        List<Id> lstDDId2 = new  List<Id>{dealDesk.Id};                              
        List<string> submitResult2 = DealDeskApproveRecord_GE_OG.approveDealDesk(lstDDId2);
        string dealSuccess2 = DealDeskApproveRecord_GE_OG.approveDealDesk(dealDesk.Id);
        
        //dealDesk.active_deal_desk_ge_og__c=false;
        
        //dealDesk.status_ge_og__c='Approved';
        //update dealDesk;
        
        List<Id> lstDDId3 = new  List<Id>{dealDesk.Id};                              
         List<string> submitResult3 = DealDeskApproveRecord_GE_OG.approveDealDesk(lstDDId3);
         string dealSuccess3 = DealDeskApproveRecord_GE_OG.approveDealDesk(dealDesk.Id);
        
        dealDesk.status_ge_og__c='Submitted';
        update dealDesk;
        
        List<Id> lstDDId4 = new  List<Id>{dealDesk.Id};                              
         List<string> submitResult4 = DealDeskApproveRecord_GE_OG.approveDealDesk(lstDDId4);
         string dealSuccess4 = DealDeskApproveRecord_GE_OG.approveDealDesk(dealDesk.Id);
       
       dealDesk.active_deal_desk_ge_og__c= false;
       dealDesk.status_ge_og__c='approved';
        //update dealDesk;
        
        List<Id> lstDDId5 = new  List<Id>{dealDesk.Id};                              
         List<string> submitResult5 = DealDeskApproveRecord_GE_OG.approveDealDesk(lstDDId5);
         string dealSuccess5 = DealDeskApproveRecord_GE_OG.approveDealDesk(dealDesk.Id);
       
        
        
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
        objDealDesk.status_ge_og__c='Approved';
        try{
            insert objDealDesk;
        }
        catch(exception e){
        }
        
        
        List<Risk_Checklist_Category_ge_og__c>rccList = [select id, supported_ge_og__c, reviewer_comments_ge_og__c, submit_review_ge_og__c from Risk_Checklist_Category_ge_og__c where RCC_Opportunity_ge_og__c =:opp.id];
        //Risk_Checklist_Category_ge_og__c rcc = [select id, submit_review_ge_og__c from Risk_Checklist_Category_ge_og__c limit 1];
        List<Risk_Checklist_Deviation_ge_og__c> rcdList = [Select id,rcl_deviation_level_ge_og__c  from Risk_Checklist_Deviation_ge_og__c where risk_checklist_category_id_ge_og__c in : rccList ];
        //rcl_deviation_ge_og__c
        List<Risk_Checklist_Deviation_ge_og__c> updateRCDList = new List<Risk_Checklist_Deviation_ge_og__c>();
        for(Risk_Checklist_Deviation_ge_og__c rcd : rcdList ){
            rcd.rcl_deviation_level_ge_og__c = 2;
            updateRCDList.add(rcd);
        }
        update updateRCDList;
        List<Risk_Checklist_Category_ge_og__c> updateRCCSubmitList = new List<Risk_Checklist_Category_ge_og__c>();
        for(Risk_Checklist_Category_ge_og__c rcc : rccList ){
            rcc.submit_review_ge_og__c = true;
            updateRCCSubmitList.add(rcc);
            break;
        }
        update updateRCCSubmitList;
        List<Risk_Checklist_Category_ge_og__c> updateRCCReviewedList = new List<Risk_Checklist_Category_ge_og__c>();
        for(Risk_Checklist_Category_ge_og__c rcc : rccList ){
            rcc.reviewer_comments_ge_og__c= 'Test';
            rcc.supported_ge_og__c= 'Yes';
            updateRCCReviewedList.add(rcc);
        }
        update updateRCCReviewedList; 
        
         List<Id> lstDDId = new  List<Id>{dealDesk.Id};                              
         List<string> submitResult = DealDeskApproveRecord_GE_OG.approveDealDesk(lstDDId);
         string dealSuccess = DealDeskApproveRecord_GE_OG.approveDealDesk(dealDesk.Id);
         
        test.stopTest();
    }
    
   /* public static testMethod void testsubmitDealDesk1()
    {
        test.startTest();
         //fetching oppty record created in above method
        opportunity opp = [select id from opportunity where name = 'TestOppty'];
        System.assert(opp != null, 'Opportunity not created');
        
        
        //Trying  Creating new Active Deal Desk over already craeted active Deal Desk
        Deal_Desk_ge_og__c objDealDesk = new Deal_Desk_ge_og__c();
        objDealDesk.deal_desk_opportunity_id_ge_og__c = opp.Id;
        objDealDesk.status_ge_og__c='Submitted';
        objDealDesk.active_deal_desk_ge_og__c= true;
        insert objDealDesk;
        
        objDealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c  from Deal_Desk_ge_og__c WHERE Id=:objDealDesk.Id];
        
         List<Id> lstDDId = new  List<Id>{objDealDesk.Id};    
         string dealSuccess = DealDeskApproveRecord_GE_OG.approveDealDesk(objDealDesk.Id);
         List<string> submitResult = DealDeskApproveRecord_GE_OG.approveDealDesk(lstDDId);
         
         
        test.stopTest();
    }
    */
    
    public static testMethod void testsubmitDealDesk2()
    {
        test.startTest();
        //fetching oppty record created in above method
        opportunity opp = [select id from opportunity where name = 'TestOppty'];
        System.assert(opp != null, 'Opportunity not created');
        
        
        Deal_Desk_ge_og__c dealDesk = new Deal_Desk_ge_og__c();
        dealDesk.deal_desk_opportunity_id_ge_og__c = opp.Id;
        dealDesk.active_deal_desk_ge_og__c= true;
        dealDesk.status_ge_og__c='Rejected';
        insert dealDesk;
         
        dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c  from Deal_Desk_ge_og__c WHERE Id=:dealDesk.Id];
                                       
        List<Id> lstDDId = new  List<Id>{dealDesk.Id}; 
        string dealSuccess = DealDeskApproveRecord_GE_OG.approveDealDesk(dealDesk.Id);
        List<string> submitResult = DealDeskApproveRecord_GE_OG.approveDealDesk(lstDDId);
        test.stopTest();
    }
    
     public static testMethod void testsubmitDealDesk3()
    {
        test.startTest();
        //fetching oppty record created in above method
        opportunity opp = [select id from opportunity where name = 'TestOppty'];
        System.assert(opp != null, 'Opportunity not created');
        
        
        Deal_Desk_ge_og__c dealDesk = new Deal_Desk_ge_og__c();
        dealDesk.deal_desk_opportunity_id_ge_og__c = opp.Id;
        dealDesk.active_deal_desk_ge_og__c= true;
        dealDesk.status_ge_og__c='Rejected';
        dealDesk.approver_comments_ge_og__c ='Reviewer Comment';
        insert dealDesk;
         
        dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c  from Deal_Desk_ge_og__c WHERE Id=:dealDesk.Id];
                                       
        List<Id> lstDDId = new  List<Id>{dealDesk.Id}; 
        string dealSuccess = DealDeskApproveRecord_GE_OG.approveDealDesk(dealDesk.Id);
        List<string> submitResult = DealDeskApproveRecord_GE_OG.approveDealDesk(lstDDId);
        test.stopTest();
    }
}