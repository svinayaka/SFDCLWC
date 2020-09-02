/*
Class             : Deal_Approver_GE_OG_Test
Used For               : Deal_Approver_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the Deal_Approver_GE_OG on Opportunity
Scrum Team             : OPPORTUNITY MGMT
Requirement Number     : R-***
Author                 : Nitish Pandey
Created Date           : 17-Sep-2015

*/

@isTest
private class Deal_Approver_GE_OG_Test {
    
    static testMethod void retrieveDealCommericalApprovers_test() {
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        // Create Member Account
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOpptyOFS('TestOppty', acc.id);
        system.debug('opp=='+opp);
        Opportunity op = [Select Id, Net_Discount_ge_og__c from Opportunity where id=:opp.id];
        system.debug('op=='+op);
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c
                                       from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        string ddid = dealDesk.id;
        
        //insert the Approver in Deal Reviewer
        List<Deal_Reviewer_Criteria_ge_og__c> drclist = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
        dr.type_ge_og__c= 'Commercial Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Oil Field Services';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='Artificial Lift'; //changed from AL to HQ
        dr.threshold_lower_limit_ge_og__c = 0;
        dr.threshold_upper_limit_ge_og__c = 200000;
        dr.deal_cm_lower_limit_ge_og__c=-1;
        dr.deal_cm_upper_limit_ge_og__c=100;
        dr.Deal_Discount_lower_limit_ge_og__c=-100;
        dr.Deal_Discount_Upper_Limit_ge_og__c=999999999999999.00;
        dr.deviation_level_ge_og__c = '3';
        drclist.add(dr);
        insert drclist;
        
        system.debug('drclist'+drclist);
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_ES Developer'].Id,
            LastName = 'last',
            FirstName = 'fst',
            IsActive= TRUE,
            Email = 'test@amamama.com',
            Username = 'test@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            GE_HQ_SSO_ID__c='00102030'
        );
        insert u;
        system.debug('User'+u);
        List<Deal_Reviewer_ge_og__c> drList = new List<Deal_Reviewer_ge_og__c>();
        
        for(Deal_Reviewer_Criteria_ge_og__c drc:drclist){
            Deal_Reviewer_ge_og__c dealRev = new Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c='India'; //updated from test region to India
            dealRev.DR_Category_ge_og__c='Commercial Deal';
            dealRev.DR_Approver_Level_ge_og__c='3';
            dealRev.DR_Tier_2_ge_og__c = 'Oil Field Services';
            dealRev.DR_Tier_3_ge_og__c = 'Artificial Lift';
            dealRev.user_ge_og__c = u.id;
            //dealRev.user_ge_og__c = UserInfo.getUserId();
            drList.add(dealRev);
        }
        
        insert drList;
        
        system.debug('drList'+drList);
        test.startTest();
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/Deal_Approver_GE_OG/'+ddid;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        List<Deal_Approver_GE_OG.ApproverWrapper> arList = Deal_Approver_GE_OG.retrieveDealCommericalApprovers();
        
        Deal_Desk_ge_og__c objDealDesk = [select deal_desk_opportunity_id_ge_og__r.amount_ge_og__c, deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c, 
                                          deal_desk_tier_2_ge_og__c,deal_desk_tier_3_ge_og__c, deal_desk_region_ge_og__c,deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c,
                                          // dd_max_deviation_ge_og__c,
                                          approver_deal_desk_ge_og__c from Deal_Desk_ge_og__c where id =: ddId];
        
        system.debug('deal_desk_region_ge_og__c = '+objDealDesk.deal_desk_region_ge_og__c );
        
        // system.debug('opp.amount_ge_og__c= '+opp.amount_ge_og__c);
        /**
system.debug('objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c= '+objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c);
system.debug('objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c= '+objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c);


Deal_Reviewer_Criteria_ge_og__c drc = [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
and deal_reviewer_criteria_tier_3_ge_og__c='HQ' 
and (threshold_lower_limit_ge_og__c <=: opp.amount_ge_og__c 
AND threshold_upper_limit_ge_og__c >=: opp.amount_ge_og__c) 
and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
)
and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
) 
and RecordTypeId ='01212000000VolG'];
system.debug('DRC in test class = '+drc); **/
        
        System.assert(arList.size() > 0);
        test.stopTest();
        
    }
    
    static testMethod void retrieveTPSDealCommericalApprovers_test() {
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        // Create Member Account
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOpptyForTPS('TestOppty TPS', acc.id);
        system.debug('opp=='+opp);
        Opportunity op = [Select Id, Net_Discount_ge_og__c from Opportunity where id=:opp.id];
        system.debug('op=='+op);
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c
                                       from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        string ddid = dealDesk.id;
        
        //insert the Approver in Deal Reviewer
        List<TPS_Deal_Reviewer_Criteria_ge_og__c> drclist = new List<TPS_Deal_Reviewer_Criteria_ge_og__c>();
        TPS_Deal_Reviewer_Criteria_ge_og__c dr = new TPS_Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('TPS_Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
        dr.deal_reviewer_criteria_type_ge_og__c= 'Commercial Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Turbomachinery & Process Solutions';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='New Units'; //changed from AL to HQ
        dr.threshold_lower_limit_ge_og__c = 0;
        dr.threshold_upper_limit_ge_og__c = 200000;
        dr.deal_cm_lower_limit_ge_og__c=-1;
        dr.deal_cm_upper_limit_ge_og__c=100;
        dr.Deal_Discount_lower_limit_ge_og__c=-100;
        dr.Deal_Discount_Upper_Limit_ge_og__c=999999999999999.00;
        dr.deviation_level_ge_og__c = '3';
        dr.TPS_Segment_ge_og__c='LNG';
        
        drclist.add(dr);
        insert drclist;
        
        system.debug('drclist'+drclist);
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_ES Developer'].Id,
            LastName = 'last',
            FirstName = 'fst',
            IsActive= TRUE,
            Email = 'test@amamama.com',
            Username = 'test@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            GE_HQ_SSO_ID__c='00102030'
        );
        insert u;
        system.debug('User'+u);
        List<TPS_Deal_Reviewer_ge_og__c> drList = new List<TPS_Deal_Reviewer_ge_og__c>();
        
        for(TPS_Deal_Reviewer_Criteria_ge_og__c drc:drclist){
            TPS_Deal_Reviewer_ge_og__c dealRev = new TPS_Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c=''; //updated from test region to India
            dealRev.DR_Category_ge_og__c='Commercial Deal';
            dealRev.DR_Approver_Level_ge_og__c='3';
            dealRev.DR_Tier_2_ge_og__c = 'Turbomachinery & Process Solutions';
            dealRev.DR_Tier_3_ge_og__c = 'New Units';
            dealRev.user_ge_og__c = u.id;
            dealRev.TPS_Segment_ge_og__c='LNG';
            
            //dealRev.user_ge_og__c = UserInfo.getUserId();
            drList.add(dealRev);
        }
        
        insert drList;
        
        system.debug('drList'+drList);
        test.startTest();
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/Deal_Approver_GE_OG/'+ddid;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        List<Deal_Approver_GE_OG.ApproverWrapper> arList = Deal_Approver_GE_OG.retrieveDealCommericalApprovers();
        
        Deal_Desk_ge_og__c objDealDesk = [select deal_desk_opportunity_id_ge_og__r.amount_ge_og__c, deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c, 
                                          deal_desk_tier_2_ge_og__c,deal_desk_tier_3_ge_og__c, deal_desk_region_ge_og__c,deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c,
                                          // dd_max_deviation_ge_og__c,
                                          approver_deal_desk_ge_og__c from Deal_Desk_ge_og__c where id =: ddId];
        
        system.debug('deal_desk_region_ge_og__c = '+objDealDesk.deal_desk_region_ge_og__c );
        
        System.assert(arList.size() > 0);
        test.stopTest();
        
    }
    
    static testMethod void retrieveIWSDealCommericalApprovers_test() {
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        // Create Member Account
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOpptyOFSIWS('TestOppty', acc.id);
        system.debug('opp=='+opp);
        Opportunity op = [Select Id, Net_Discount_ge_og__c from Opportunity where id=:opp.id];
        system.debug('op=='+op);
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c
                                       from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        string ddid = dealDesk.id;
        
        //insert the Approver in Deal Reviewer
        List<Deal_Reviewer_Criteria_ge_og__c> drclist = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
        dr.type_ge_og__c= 'Commercial Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Oil Field Services';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='Integrated Well Services'; //changed from AL to HQ
        dr.threshold_lower_limit_ge_og__c = 0;
        dr.threshold_upper_limit_ge_og__c = 200000;
        dr.deal_cm_lower_limit_ge_og__c=-1;
        dr.deal_cm_upper_limit_ge_og__c=100;
        dr.Deal_Discount_lower_limit_ge_og__c=-100;
        dr.Deal_Discount_Upper_Limit_ge_og__c=999999999999999.00;
        dr.deviation_level_ge_og__c = '3';
        drclist.add(dr);
        insert drclist;
        
        system.debug('drclist'+drclist);
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_ES Developer'].Id,
            LastName = 'last',
            FirstName = 'fst',
            IsActive= TRUE,
            Email = 'test@amamama.com',
            Username = 'test@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            GE_HQ_SSO_ID__c='00102030'
        );
        insert u;
        system.debug('User'+u);
        List<Deal_Reviewer_ge_og__c> drList = new List<Deal_Reviewer_ge_og__c>();
        
        for(Deal_Reviewer_Criteria_ge_og__c drc:drclist){
            Deal_Reviewer_ge_og__c dealRev = new Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c='India'; //updated from test region to India
            dealRev.DR_Category_ge_og__c='Commercial Deal';
            dealRev.DR_Approver_Level_ge_og__c='3';
            dealRev.DR_Tier_2_ge_og__c = 'Oil Field Services';
            dealRev.DR_Tier_3_ge_og__c = 'Integrated Well Services';
            dealRev.user_ge_og__c = u.id;
            //dealRev.user_ge_og__c = UserInfo.getUserId();
            drList.add(dealRev);
        }
        
        insert drList;
        
        system.debug('drList'+drList);
        test.startTest();
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/Deal_Approver_GE_OG/'+ddid;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        List<Deal_Approver_GE_OG.ApproverWrapper> arList = Deal_Approver_GE_OG.retrieveDealCommericalApprovers();
        
        Deal_Desk_ge_og__c objDealDesk = [select deal_desk_opportunity_id_ge_og__r.amount_ge_og__c, deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c, 
                                          deal_desk_tier_2_ge_og__c,deal_desk_tier_3_ge_og__c, deal_desk_region_ge_og__c,deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c,
                                          // dd_max_deviation_ge_og__c,
                                          approver_deal_desk_ge_og__c from Deal_Desk_ge_og__c where id =: ddId];
        
        system.debug('deal_desk_region_ge_og__c = '+objDealDesk.deal_desk_region_ge_og__c );
        
        // system.debug('opp.amount_ge_og__c= '+opp.amount_ge_og__c);
        /**
system.debug('objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c= '+objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c);
system.debug('objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c= '+objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c);


Deal_Reviewer_Criteria_ge_og__c drc = [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
and deal_reviewer_criteria_tier_3_ge_og__c='HQ' 
and (threshold_lower_limit_ge_og__c <=: opp.amount_ge_og__c 
AND threshold_upper_limit_ge_og__c >=: opp.amount_ge_og__c) 
and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
)
and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
) 
and RecordTypeId ='01212000000VolG'];
system.debug('DRC in test class = '+drc); **/
        
        System.assert(arList.size() > 0);
        test.stopTest();
        
    }
    
    static testMethod void retrieveNormalDealCommericalApprovers_test() {
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        // Create Member Account
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        system.debug('opp=='+opp);
        Opportunity op = [Select Id, Net_Discount_ge_og__c from Opportunity where id=:opp.id];
        system.debug('op=='+op);
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c
                                       from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        string ddid = dealDesk.id;
        
        //insert the Approver in Deal Reviewer
        List<Deal_Reviewer_Criteria_ge_og__c> drclist = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
        dr.type_ge_og__c= 'Commercial Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Digital Solutions';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='Bently Nevada'; 
        dr.threshold_lower_limit_ge_og__c = 0;
        dr.threshold_upper_limit_ge_og__c = 200000;
        dr.deal_cm_lower_limit_ge_og__c=-1;
        dr.deal_cm_upper_limit_ge_og__c=100;
        dr.Deal_Discount_lower_limit_ge_og__c=-100;
        dr.Deal_Discount_Upper_Limit_ge_og__c=999999999999999.00;
        dr.deviation_level_ge_og__c = '3';
        drclist.add(dr);
        insert drclist;
        
        system.debug('drclist'+drclist);
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_ES Developer'].Id,
            LastName = 'last',
            FirstName = 'fst',
            IsActive= TRUE,
            Email = 'test@amamama.com',
            Username = 'test@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            GE_HQ_SSO_ID__c='00102030'
        );
        insert u;
        system.debug('User'+u);
        List<Deal_Reviewer_ge_og__c> drList = new List<Deal_Reviewer_ge_og__c>();
        
        for(Deal_Reviewer_Criteria_ge_og__c drc:drclist){
            Deal_Reviewer_ge_og__c dealRev = new Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c='India'; //updated from test region to India
            dealRev.DR_Category_ge_og__c='Commercial Deal';
            dealRev.DR_Approver_Level_ge_og__c='3';
            dealRev.DR_Tier_2_ge_og__c = 'Digital Solutions';
            dealRev.DR_Tier_3_ge_og__c = 'Bently Nevada';
            dealRev.user_ge_og__c = u.id;
           
            //dealRev.user_ge_og__c = UserInfo.getUserId();
            drList.add(dealRev);
        }
        
        insert drList;
        
        system.debug('drList'+drList);
        test.startTest();
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/Deal_Approver_GE_OG/'+ddid;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        List<Deal_Approver_GE_OG.ApproverWrapper> arList = Deal_Approver_GE_OG.retrieveDealCommericalApprovers();
        
        Deal_Desk_ge_og__c objDealDesk = [select deal_desk_opportunity_id_ge_og__r.amount_ge_og__c, deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c, 
                                          deal_desk_tier_2_ge_og__c,deal_desk_tier_3_ge_og__c, deal_desk_region_ge_og__c,deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c,
                                          // dd_max_deviation_ge_og__c,
                                          approver_deal_desk_ge_og__c from Deal_Desk_ge_og__c where id =: ddId];
        
        system.debug('deal_desk_region_ge_og__c = '+objDealDesk.deal_desk_region_ge_og__c );
        
        // system.debug('opp.amount_ge_og__c= '+opp.amount_ge_og__c);
        /**
system.debug('objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c= '+objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c);
system.debug('objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c= '+objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c);


Deal_Reviewer_Criteria_ge_og__c drc = [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
and deal_reviewer_criteria_tier_3_ge_og__c='HQ' 
and (threshold_lower_limit_ge_og__c <=: opp.amount_ge_og__c 
AND threshold_upper_limit_ge_og__c >=: opp.amount_ge_og__c) 
and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
)
and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
) 
and RecordTypeId ='01212000000VolG'];
system.debug('DRC in test class = '+drc); **/
        
        System.assert(arList.size() > 0);
        test.stopTest();
        
    }
    
    static testMethod void retrieveTPSFPTDealCommericalApprovers_test() {
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        // Create Member Account
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOpptyForTPSFPT('TestOppty TPS', acc.id);
        system.debug('opp=='+opp);
        Opportunity op = [Select Id, Net_Discount_ge_og__c from Opportunity where id=:opp.id];
        system.debug('op=='+op);
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c
                                       from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        string ddid = dealDesk.id;
        
        //insert the Approver in Deal Reviewer
        List<TPS_F_PT_Deal_Reviewer_Criteria_ge_og__c> drclist = new List<TPS_F_PT_Deal_Reviewer_Criteria_ge_og__c>();
        TPS_F_PT_Deal_Reviewer_Criteria_ge_og__c dr = new TPS_F_PT_Deal_Reviewer_Criteria_ge_og__c();
       // dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('TPS_Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
        dr.deal_reviewer_criteria_type_ge_og__c= 'Commercial Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Turbomachinery & Process Solutions';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='Flow & Process Technologies'; //changed from AL to HQ
        dr.threshold_lower_limit_ge_og__c = 0;
        dr.threshold_upper_limit_ge_og__c = 200000;
        dr.deal_cm_lower_limit_ge_og__c=-1;
        dr.deal_cm_upper_limit_ge_og__c=100;
        dr.Deal_Discount_lower_limit_ge_og__c=-100;
        dr.Deal_Discount_Upper_Limit_ge_og__c=999999999999999.00;
        dr.deviation_level_ge_og__c = '3';
        dr.TPS_Segment_ge_og__c='LNG';
        
        drclist.add(dr);
        insert drclist;
        
        system.debug('drclist'+drclist);
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_ES Developer'].Id,
            LastName = 'last',
            FirstName = 'fst',
            IsActive= TRUE,
            Email = 'test@amamama.com',
            Username = 'test@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            GE_HQ_SSO_ID__c='00102030'
        );
        insert u;
        system.debug('User'+u);
        List<TPS_F_PT_Deal_Reviewer_ge_og__c> drList = new List<TPS_F_PT_Deal_Reviewer_ge_og__c>();
        
        for(TPS_F_PT_Deal_Reviewer_Criteria_ge_og__c drc:drclist){
            TPS_F_PT_Deal_Reviewer_ge_og__c dealRev = new TPS_F_PT_Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c='Asia Pacific'; //updated from test region to India
            dealRev.DR_Category_ge_og__c='Commercial Deal';
            dealRev.DR_Approver_Level_ge_og__c='3';
            dealRev.DR_Tier_2_ge_og__c = 'Turbomachinery & Process Solutions';
            dealRev.DR_Tier_3_ge_og__c = 'Flow & Process Technologies';
            dealRev.user_ge_og__c = u.id;
            dealRev.TPS_Segment_ge_og__c='LNG';
            
            //dealRev.user_ge_og__c = UserInfo.getUserId();
            drList.add(dealRev);
        }
        
        insert drList;
        
        system.debug('drList'+drList);
        test.startTest();
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/Deal_Approver_GE_OG/'+ddid;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        List<Deal_Approver_GE_OG.ApproverWrapper> arList = Deal_Approver_GE_OG.retrieveDealCommericalApprovers();
        
        Deal_Desk_ge_og__c objDealDesk = [select deal_desk_opportunity_id_ge_og__r.amount_ge_og__c, deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c, 
                                          deal_desk_tier_2_ge_og__c,deal_desk_tier_3_ge_og__c, deal_desk_region_ge_og__c,deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c,
                                          // dd_max_deviation_ge_og__c,
                                          approver_deal_desk_ge_og__c from Deal_Desk_ge_og__c where id =: ddId];
        
        system.debug('deal_desk_region_ge_og__c = '+objDealDesk.deal_desk_region_ge_og__c );
        
        System.assert(arList.size() > 0);
        test.stopTest();
        
    }
        
    /*static testMethod void retrievemultitierlDealCommericalApprovers_test() {
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        // Create Member Account
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        Product2 product = new Product2();
        product.name = 'Grv_productName';
        product.GE_Tier2_PnL__c = 'Digital Solutions';
        product.GE_Tier3_PnL__c = 'Measurement & Sensing';
        product.IsActive = true;
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
        
        Product2 tpsproduct = new Product2();
        tpsproduct.name = 'TPS product';
        //Changed to Digital Solutions
        tpsproduct.GE_Tier2_PnL__c = 'Digital Solutions';
        tpsproduct.GE_Tier3_PnL__c = 'Control Solutions';
        tpsproduct.IsActive = true;
        insert tpsproduct; 
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        
        // 2. Insert a price book entry with a custom price.
        PricebookEntry customPrice = new PricebookEntry(
            Pricebook2Id = customPB.Id, 
            Product2Id = tpsproduct.Id,
            UnitPrice = 12000, 
            CurrencyIsoCode = 'USD',
            UseStandardPrice = false,
            IsActive = true);
        insert customPrice;
        
        OpportunityLineItem objOpplinetps=new OpportunityLineItem();
        objOpplinetps.opportunityid=opp.Id;
        objOpplinetps.PRICEBOOKENTRYID=customPrice.id;
        objOpplinetps.Quantity=2;
        objOpplinetps.UNITPRICE=12000; 
        objOpplinetps.GE_OG_SS_Oppty_Product_CM__c = 45;
        insert objOpplinetps;
        
        
        
        System.debug('opp=='+opp);
        Opportunity op = [Select Id, Net_Discount_ge_og__c,MultiTier3_ge_og__c from Opportunity where id=:opp.id];
        system.debug('op=='+op);
        string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        
        Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c
                                       from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];
        
        string ddid = dealDesk.id;
        
        //insert the Approver in Deal Reviewer
        List<Deal_Reviewer_Criteria_ge_og__c> drclist = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
        dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Commercial Approver').getRecordTypeId();
        dr.type_ge_og__c= 'Commercial Approver';
        dr.deal_reviewer_criteria_tier_2_ge_og__c ='Digital Solutions';
        dr.deal_reviewer_criteria_tier_3_ge_og__c ='HQ'; 
        dr.threshold_lower_limit_ge_og__c = 0;
        dr.threshold_upper_limit_ge_og__c = 200000;
        dr.deal_cm_lower_limit_ge_og__c=-1;
        dr.deal_cm_upper_limit_ge_og__c=100;
        dr.Deal_Discount_lower_limit_ge_og__c=-100;
        dr.Deal_Discount_Upper_Limit_ge_og__c=999999999999999.00;
        dr.deviation_level_ge_og__c = '3';
        drclist.add(dr);
        insert drclist;
        
        system.debug('drclist'+drclist);
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_ES Developer'].Id,
            LastName = 'last',
            FirstName = 'fst',
            IsActive= TRUE,
            Email = 'test@amamama.com',
            Username = 'test@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            GE_HQ_SSO_ID__c='00102030'
        );
        insert u;
        system.debug('User'+u);
        List<Deal_Reviewer_ge_og__c> drList = new List<Deal_Reviewer_ge_og__c>();
        
        for(Deal_Reviewer_Criteria_ge_og__c drc:drclist){
            Deal_Reviewer_ge_og__c dealRev = new Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c='India'; //updated from test region to India
            dealRev.DR_Category_ge_og__c='Commercial Deal';
            dealRev.DR_Approver_Level_ge_og__c='3';
            dealRev.DR_Tier_2_ge_og__c = 'Digital Solutions';
            dealRev.DR_Tier_3_ge_og__c = 'Bently Nevada';
            dealRev.user_ge_og__c = u.id;
            //dealRev.user_ge_og__c = UserInfo.getUserId();
            drList.add(dealRev);
        }
        
        insert drList;
        
        system.debug('drList'+drList);
        test.startTest();
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/Deal_Approver_GE_OG/'+ddid;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        List<Deal_Approver_GE_OG.ApproverWrapper> arList = Deal_Approver_GE_OG.retrieveDealCommericalApprovers();
        
        Deal_Desk_ge_og__c objDealDesk = [select deal_desk_opportunity_id_ge_og__r.amount_ge_og__c, deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c, 
                                          deal_desk_tier_2_ge_og__c,deal_desk_tier_3_ge_og__c, deal_desk_region_ge_og__c,deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c,
                                          // dd_max_deviation_ge_og__c,
                                          approver_deal_desk_ge_og__c from Deal_Desk_ge_og__c where id =: ddId];
        
        system.debug('deal_desk_region_ge_og__c = '+objDealDesk.deal_desk_region_ge_og__c );
        
        // system.debug('opp.amount_ge_og__c= '+opp.amount_ge_og__c);
        /**
system.debug('objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c= '+objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c);
system.debug('objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c= '+objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c);


Deal_Reviewer_Criteria_ge_og__c drc = [Select Id,deviation_level_ge_og__c from Deal_Reviewer_Criteria_ge_og__c where 
deal_reviewer_criteria_tier_2_ge_og__c=:objDealDesk.deal_desk_tier_2_ge_og__c 
and deal_reviewer_criteria_tier_3_ge_og__c='HQ' 
and (threshold_lower_limit_ge_og__c <=: opp.amount_ge_og__c 
AND threshold_upper_limit_ge_og__c >=: opp.amount_ge_og__c) 
and (deal_cm_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c 
AND deal_cm_upper_limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.oppty_cm_ge_og__c
)
and (Deal_Discount_lower_limit_ge_og__c <=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c 
AND Deal_Discount_Upper_Limit_ge_og__c >=: objDealDesk.deal_desk_opportunity_id_ge_og__r.Net_Discount_ge_og__c
) 
and RecordTypeId ='01212000000VolG'];
system.debug('DRC in test class = '+drc); **/
        
      /*  System.assert(arList.size() > 0);
        test.stopTest();
        
    }*/
    
}