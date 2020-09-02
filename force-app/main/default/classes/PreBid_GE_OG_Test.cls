/*
Class/Trigger Name     : PreBid_GE_OG_Test
Used For               : 

PreBidApprover_GE_OG.cls----------------------------------->>>>>>>>>  86%
PreBidEvaluationHandler_GE_OG.cls-------------------------->>>>>>>>>  94%
PreBidEvaluationTrigger_GE_OG.trigger---------------------->>>>>>>>>  100%
PreBidSubmit_GE_OG----------------------------------------->>>>>>>>>  86%
PreBidTriggerHandler_GE_OG.cls----------------------------->>>>>>>>>  78%
PreBidTrigger_GE_OG.trigger-------------------------------->>>>>>>>>  100%
RecallRecord_GE_OG.cls------------------------------------->>>>>>>>>  82%


Purpose/Overview       : Test Class to calculate the code coverage for the above classes
Scrum Team             : Transformation - Deal MGMT
Requirement Number     : R-23281
Author                 : Sanath Kumar Dheram
Created Date           : 22-MAR-2016

*/

@isTest
public class PreBid_GE_OG_Test
{
    static testMethod void testPreBid()
    {
        
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        PreBidApprover_GE_OG prebid_app = new PreBidApprover_GE_OG();
        
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test AccountX');
        
        opportunity opp=CommonTestDataFactory_GE_OG.createOppty('TESTOPPTY',acc.Id);
        //Added by Kiru
        opp.tier_2_ge_og__c = 'Oil Field Services';
        opp.tier_3_ge_og__c = 'Artificial Lift';
        update opp;
        
        Pre_Bid_ge_og__c preBidList=[Select id,pre_bid_status_ge_og__c,
                                     pre_bid_region_ge_og__c,pre_bid_active_ge_og__c,competitor_count_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.StageName, 
                                     pre_bid_opportunity_ge_og__r.deal_path_ge_og__c,pre_bid_opportunity_ge_og__r.has_product_value_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.tier_2_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.documents_uploaded_ge_og__c,pre_bid_opportunity_ge_og__r.HasOpportunityLineItem,
                                     pre_bid_approver_ge_og__c,Prebid_Approver_Do_not_use_ge_og__c  from Pre_Bid_ge_og__c where pre_bid_opportunity_ge_og__c =: opp.Id];
        
        
        
        //Kiru added from below
        //insert the Approver in Deal Reviewer
        List<Deal_Reviewer_Criteria_ge_og__c> drclist = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Pre Bid Approver').getRecordTypeId();
        dr.type_ge_og__c= 'Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Oil Field Services';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='Artificial Lift';
        dr.threshold_lower_limit_ge_og__c = 0;
        dr.threshold_upper_limit_ge_og__c = 100000000;
        dr.deviation_level_ge_og__c = '3';
        drclist.add(dr);
        insert drclist;
        
        string prebidId = preBidList.id;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_ES Developer'].Id,
            LastName = 'last',
            IsActive= TRUE,
            Email = 'test@amamama.com',
            Username = 'test@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u;
        
        List<Deal_Reviewer_ge_og__c> drList = new List<Deal_Reviewer_ge_og__c>();
        for(Deal_Reviewer_Criteria_ge_og__c drc:drclist){
            Deal_Reviewer_ge_og__c dealRev = new Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c='Test Region';
            dealRev.DR_Category_ge_og__c='PreBid Assesment';
            dealRev.DR_Approver_Level_ge_og__c='3';
            dealRev.DR_Tier_2_ge_og__c = 'Oil Field Services';
            dealRev.DR_Tier_3_ge_og__c = 'Artificial Lift';
            dealRev.user_ge_og__c = u.id;
            drList.add(dealRev);
        }
        
        insert drList;
        
        Deal_Reviewer_ge_og__c drrec = [Select Id,user_ge_og__c from Deal_Reviewer_ge_og__c where id=: drList[0].Id];
        test.startTest();
        
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/PreBidApprover_GE_OG/'+prebidId;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        PreBidApprover_GE_OG.retrievePrebidApprovers();
        
        test.stopTest();
        
    } 
    static testMethod void testPreBid1()
    {
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test AccountX');
        
        opportunity opp=CommonTestDataFactory_GE_OG.createOppty('TESTOPPTY',acc.Id);
        //Added by Kiru
        opp.tier_2_ge_og__c = 'Oil Field Services';
        opp.tier_3_ge_og__c = 'Artificial Lift';
        update opp;
        
        Product2 product = new Product2();
        product.name = 'productName';
        product.GE_Tier2_PnL__c = 'Oil Field Services';
        product.GE_Tier3_PnL__c = 'Chemicals';
        insert product;
        
        Product2 product1 = new Product2();
        product1.name = 'productName';
        product1.GE_Tier2_PnL__c = 'Oil Field Services';
        product1.GE_Tier3_PnL__c = 'Artificial Lift';
        insert product1; 
        
        PriceBookEntry pricebk1 = new PriceBookEntry();
        pricebk1.CurrencyIsoCode = 'USD';
        pricebk1.UnitPrice = 1.0;
        pricebk1.Pricebook2Id =Test.getStandardPricebookId();
        pricebk1.Product2Id = product1.id;
        pricebk1.IsActive = true;  
        pricebk1.UseStandardPrice = false;   
        insert pricebk1; 
        
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = product.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        Pre_Bid_ge_og__c preBidList=[Select id,pre_bid_status_ge_og__c,
                                     pre_bid_region_ge_og__c,pre_bid_active_ge_og__c,competitor_count_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.StageName, 
                                     pre_bid_opportunity_ge_og__r.deal_path_ge_og__c,pre_bid_opportunity_ge_og__r.has_product_value_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.tier_2_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.documents_uploaded_ge_og__c,pre_bid_opportunity_ge_og__r.HasOpportunityLineItem,
                                     pre_bid_approver_ge_og__c,Prebid_Approver_Do_not_use_ge_og__c  from Pre_Bid_ge_og__c where pre_bid_opportunity_ge_og__c =: opp.Id];
        
        test.startTest();
        
        //Kiru added from below
        //insert the Approver in Deal Reviewer
        List<Deal_Reviewer_Criteria_ge_og__c> drclist = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Pre Bid Approver').getRecordTypeId();
        dr.type_ge_og__c= 'Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Oil Field Services';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='HQ';
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
        Pre_Bid_ge_og__c prb = [Select Id,pre_bid_status_ge_og__c from Pre_Bid_ge_og__c where id=:preBidList.Id];
        system.debug('===='+prb);
        new Prebid_Approval_Process_GE_OG().ApproveRecord(preBidList);
        preBidList.pre_bid_status_ge_og__c='Approved';
        Update preBidList;
        system.debug('==== AFTER'+prb);
        test.stopTest();
    }
    
    static testMethod void testPreBid2()
    {
        
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        PreBidApprover_GE_OG prebid_app = new PreBidApprover_GE_OG();
        
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test AccountX');
        
        opportunity opp=CommonTestDataFactory_GE_OG.createOppty('TESTOPPTY',acc.Id);
        //Added by Kiru
        opp.tier_2_ge_og__c = 'Oil Field Services';
        opp.tier_3_ge_og__c = 'Integrated Well Services';
        update opp;
        
        Pre_Bid_ge_og__c preBidList=[Select id,pre_bid_status_ge_og__c,
                                     pre_bid_region_ge_og__c,pre_bid_active_ge_og__c,competitor_count_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.StageName, 
                                     pre_bid_opportunity_ge_og__r.deal_path_ge_og__c,pre_bid_opportunity_ge_og__r.has_product_value_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.tier_2_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.documents_uploaded_ge_og__c,pre_bid_opportunity_ge_og__r.HasOpportunityLineItem,
                                     pre_bid_approver_ge_og__c,Prebid_Approver_Do_not_use_ge_og__c  from Pre_Bid_ge_og__c where pre_bid_opportunity_ge_og__c =: opp.Id];
        
        
        
        //Kiru added from below
        //insert the Approver in Deal Reviewer
        List<Deal_Reviewer_Criteria_ge_og__c> drclist = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Pre Bid Approver').getRecordTypeId();
        dr.type_ge_og__c= 'Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Oil Field Services';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='Integrated Well Services';
        dr.threshold_lower_limit_ge_og__c = 0;
        dr.threshold_upper_limit_ge_og__c = 100000000;
        dr.deviation_level_ge_og__c = '3';
        drclist.add(dr);
        insert drclist;
        
        string prebidId = preBidList.id;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_ES Developer'].Id,
            LastName = 'last',
            IsActive= TRUE,
            Email = 'test@amamama.com',
            Username = 'test@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u;
        
        List<Deal_Reviewer_ge_og__c> drList = new List<Deal_Reviewer_ge_og__c>();
        for(Deal_Reviewer_Criteria_ge_og__c drc:drclist){
            Deal_Reviewer_ge_og__c dealRev = new Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c='Test Region';
            dealRev.DR_Category_ge_og__c='PreBid Assesment';
            dealRev.DR_Approver_Level_ge_og__c='3';
            dealRev.DR_Tier_2_ge_og__c = 'Oil Field Services';
            dealRev.DR_Tier_3_ge_og__c = 'Integrated Well Services';
            dealRev.user_ge_og__c = u.id;
            drList.add(dealRev);
        }
        
        insert drList;
        
        Deal_Reviewer_ge_og__c drrec = [Select Id,user_ge_og__c from Deal_Reviewer_ge_og__c where id=: drList[0].Id];
        test.startTest();
        
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/PreBidApprover_GE_OG/'+prebidId;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        PreBidApprover_GE_OG.retrievePrebidApprovers();
        
        test.stopTest();
        
    } 
 static testMethod void testPreBid3()
    {
        
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        PreBidApprover_GE_OG prebid_app = new PreBidApprover_GE_OG();
        
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test AccountX');
        
        opportunity opp=CommonTestDataFactory_GE_OG.createOppty('TESTOPPTY',acc.Id);
        //Added by Kiru
        opp.tier_2_ge_og__c = 'Oil Field Services';
        opp.tier_3_ge_og__c = 'Artificial Lift';
        opp.MultiTier3_ge_og__c = true;
        update opp;
        
        Pre_Bid_ge_og__c preBidList=[Select id,pre_bid_status_ge_og__c,
                                     pre_bid_region_ge_og__c,pre_bid_active_ge_og__c,competitor_count_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.StageName, 
                                     pre_bid_opportunity_ge_og__r.deal_path_ge_og__c,pre_bid_opportunity_ge_og__r.has_product_value_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.tier_2_ge_og__c,
                                     pre_bid_opportunity_ge_og__r.documents_uploaded_ge_og__c,pre_bid_opportunity_ge_og__r.HasOpportunityLineItem,
                                     pre_bid_approver_ge_og__c,Prebid_Approver_Do_not_use_ge_og__c  from Pre_Bid_ge_og__c where pre_bid_opportunity_ge_og__c =: opp.Id];
        
        
        
        //Kiru added from below
        //insert the Approver in Deal Reviewer
        List<Deal_Reviewer_Criteria_ge_og__c> drclist = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Pre Bid Approver').getRecordTypeId();
        dr.type_ge_og__c= 'Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Oil Field Services';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='HQ';
        dr.threshold_lower_limit_ge_og__c = 0;
        dr.threshold_upper_limit_ge_og__c = 100000000;
        dr.deviation_level_ge_og__c = '3';
        drclist.add(dr);
        insert drclist;
        
        string prebidId = preBidList.id;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_ES Developer'].Id,
            LastName = 'last',
            IsActive= TRUE,
            Email = 'test@amamama.com',
            Username = 'test@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u;
        
        List<Deal_Reviewer_ge_og__c> drList = new List<Deal_Reviewer_ge_og__c>();
        for(Deal_Reviewer_Criteria_ge_og__c drc:drclist){
            Deal_Reviewer_ge_og__c dealRev = new Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c='Test Region';
            dealRev.DR_Category_ge_og__c='PreBid Assesment';
            dealRev.DR_Approver_Level_ge_og__c='3';
            dealRev.DR_Tier_2_ge_og__c = 'Oil Field Services';
            dealRev.DR_Tier_3_ge_og__c = 'HQ';
            dealRev.user_ge_og__c = u.id;
            drList.add(dealRev);
        }
        
        insert drList;
        
        Deal_Reviewer_ge_og__c drrec = [Select Id,user_ge_og__c from Deal_Reviewer_ge_og__c where id=: drList[0].Id];
        test.startTest();
        
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/PreBidApprover_GE_OG/'+prebidId;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        PreBidApprover_GE_OG.retrievePrebidApprovers();
        
        test.stopTest();
        
    } 
   
}