@isTest
public class Prebid_Approval_Process_GE_OG_Test {
    
    public static testMethod void testPreBid()
    {
        Prebid_Approval_Process_GE_OG prebid_app = new Prebid_Approval_Process_GE_OG();
        
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test AccountX');
        
        opportunity opp=CommonTestDataFactory_GE_OG.createOppty('TESTOPPTY',acc.Id);
        //Added by Kiru
        opp.tier_2_ge_og__c = 'Oil Field Services';
        opp.tier_3_ge_og__c = 'Artificial Lift';
        update opp;
        
        Product2 product = new Product2();
        product.name = 'productName';
        product.GE_Tier2_PnL__c = 'Oil Field Services';
        product.GE_Tier3_PnL__c = 'Artificial Lift';
        insert product; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = product.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        /**OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=opp.Id;
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_Oppty_Product_CM__c = 45;
        insert objOppline; **/
        
        Pre_Bid_ge_og__c preBidList=[Select id,pre_bid_status_ge_og__c,
                                     pre_bid_region_ge_og__c,pre_bid_active_ge_og__c,competitor_count_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.StageName, 
                                     pre_bid_opportunity_ge_og__r.deal_path_ge_og__c,pre_bid_opportunity_ge_og__r.has_product_value_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.tier_2_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.documents_uploaded_ge_og__c,pre_bid_opportunity_ge_og__r.HasOpportunityLineItem,
                                     pre_bid_approver_ge_og__c,Prebid_Approver_Do_not_use_ge_og__c  from Pre_Bid_ge_og__c where pre_bid_opportunity_ge_og__c =: opp.Id];
        
        test.startTest();
        
        //Kiru added from below
        //insert the DRC and Approver in Deal Reviewer
        List<Deal_Reviewer_Criteria_ge_og__c> drclist = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Pre Bid Approver').getRecordTypeId();
        dr.type_ge_og__c= 'Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Oil Field Services';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='Artificial Lift';
        dr.threshold_lower_limit_ge_og__c = 1000000000;
        dr.threshold_upper_limit_ge_og__c = 2000000000;
        dr.deviation_level_ge_og__c = '3';
        drclist.add(dr);
        insert drclist;
        
        List<Deal_Reviewer_ge_og__c> drlist = CommonTestDataFactory_GE_OG.createDealApproverForPreBid(drclist);
        
        Deal_Reviewer_ge_og__c drrec = [Select Id,user_ge_og__c from Deal_Reviewer_ge_og__c where id=: drlist[0].Id];
        preBidList.pre_bid_uploaded_ge_og__c = true; 
        preBidList.pre_bid_approver_ge_og__c = drrec.user_ge_og__c;
        preBidList.pre_bid_status_ge_og__c='Submitted';
        Update preBidList;
        
        new Prebid_Approval_Process_GE_OG().ApproveRecord(preBidList);
        preBidList.pre_bid_status_ge_og__c='Pending';
        Update preBidList;
        preBidList.pre_bid_status_ge_og__c='Submitted';
        Update preBidList;
        new Prebid_Approval_Process_GE_OG().RejectRecord(preBidList);
        
        test.stopTest();
        
    }
    
}