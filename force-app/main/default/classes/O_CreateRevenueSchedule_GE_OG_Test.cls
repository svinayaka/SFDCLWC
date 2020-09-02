/*
Class             : O_CreateRevenueSchedule_GE_OG_Test
Used For               : O_CreateRevenueSchedule_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the O_CreateRevenueSchedule_GE_OG on Opportunity
Scrum Team             : OPPORTUNITY MGMT
Requirement Number     : R-26547
Author                 : Rupal Seth
Created Date           : 04-Jan-18
*/

@isTest
private class O_CreateRevenueSchedule_GE_OG_Test {

    static testMethod void retrieveRevenueLines_testQuarterly() {
    
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        // Create Member Account
       Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test revAccount');
       
       //Creating an Account 
       Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount revRelation', acc1.ID);
       
       //Createing an Account
       Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account revLE',acc.ID,acc1.ID);
       
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOpptyRev', acc.id);
        
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        
        List<OpportunityLineItem> lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(opp, lstPBE);
        insert lstOLI;
      
        List<OpportunityLineItem> oliId = [Select id,GE_PTier2_PL__c,GE_PTier3_PL__c,product2.Name from OpportunityLineItem where id =: lstOLI limit 1];
       // String ol = oliId.get(0).id;
        
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/O_CreateRevenueSchedule_GE_OG/'+oliId;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        req.params.put('oppLineItemId', 'oliId');
        req.params.put('splitAmount', '1122');
        req.params.put('revStartDate', '2018-01-03');
        req.params.put('numOfInstallments', '4');
        req.params.put('frequency', 'Quarterly');
        req.params.put('commitFlag', 'FALSE');
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json'); 
        
        List<O_CreateRevenueSchedule_GE_OG.RevenueLinesWrapper> rList = O_CreateRevenueSchedule_GE_OG.retrieveRevenueLines();
        req.params.put('oppLineItemId', '');
        List<O_CreateRevenueSchedule_GE_OG.RevenueLinesWrapper> reqList = O_CreateRevenueSchedule_GE_OG.retrieveRevenueLines();
        System.assert(rList.size() > 0);
        //List<OpportunityLineItem> o = O_CreateRevenueSchedule_GE_OG.getOpporutnityItemDetails(ol);
        
    }
    static testMethod void retrieveRevenueLines_testMonthly() {
    
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        // Create Member Account
       Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test revAccount');
       
       //Creating an Account 
       Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount revRelation', acc1.ID);
       
       //Createing an Account
       Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account revLE',acc.ID,acc1.ID);
       
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOpptyRev', acc.id);
        
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        
        List<OpportunityLineItem> lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(opp, lstPBE);
        insert lstOLI;
      
        List<OpportunityLineItem> oliId = [Select id,GE_PTier2_PL__c,GE_PTier3_PL__c,product2.Name from OpportunityLineItem where id =: lstOLI limit 1];
        
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/O_CreateRevenueSchedule_GE_OG/'+oliId;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        req.params.put('oppLineItemId', 'oliId');
        req.params.put('splitAmount', '1122');
        req.params.put('revStartDate', '2018-01-03');
        req.params.put('numOfInstallments', '4');
        req.params.put('frequency', 'Monthly');
        req.params.put('commitFlag', 'FALSE');
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json'); 
        
        List<O_CreateRevenueSchedule_GE_OG.RevenueLinesWrapper> rList = O_CreateRevenueSchedule_GE_OG.retrieveRevenueLines();
        System.assert(rList.size() > 0);
        
    }
    static testMethod void retrieveRevenueLines_testYearly() {
    
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        // Create Member Account
       Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test revAccount');
       
       //Creating an Account 
       Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount revRelation', acc1.ID);
       
       //Createing an Account
       Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account revLE',acc.ID,acc1.ID);
       
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOpptyRev', acc.id);
        
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        
        List<OpportunityLineItem> lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(opp, lstPBE);
        insert lstOLI;
      
        List<OpportunityLineItem> oliId = [Select id,GE_PTier2_PL__c,GE_PTier3_PL__c,product2.Name from OpportunityLineItem where id =: lstOLI limit 1];
        
        req.requestURI = 'https://cs9.salesforce.com/services/apexrest/O_CreateRevenueSchedule_GE_OG/'+oliId;  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        req.params.put('oppLineItemId', 'oliId');
        req.params.put('splitAmount', '1122');
        req.params.put('revStartDate', '2018-01-03');
        req.params.put('numOfInstallments', '4');
        req.params.put('frequency', 'Yearly');
        req.params.put('commitFlag', 'FALSE');
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json'); 
        
        List<O_CreateRevenueSchedule_GE_OG.RevenueLinesWrapper> rList = O_CreateRevenueSchedule_GE_OG.retrieveRevenueLines();
        System.assert(rList.size() > 0);
        
    }
    static testMethod void retrieveRevenueLines_testEmpty() {
    
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        // Create Member Account
       Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test revAccount');
       
       //Creating an Account 
       Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount revRelation', acc1.ID);
       
       //Createing an Account
       Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account revLE',acc.ID,acc1.ID);
       
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOpptyRev', acc.id);
        
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        
        List<OpportunityLineItem> lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(opp, lstPBE);
        insert lstOLI;
      
        List<OpportunityLineItem> oliId = [Select id,GE_PTier2_PL__c,GE_PTier3_PL__c,product2.Name from OpportunityLineItem where id =: lstOLI limit 1];
       // String ol = oliId.get(0).id;
        req.requestURI = 'https://test.salesforce.com/services/apexrest/O_CreateRevenueSchedule_GE_OG/TestData';  
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        req.params.put('oppLineItemId','');
        req.params.put('splitAmount','');
        req.params.put('revStartDate','');
        req.params.put('numOfInstallments','');
        req.params.put('frequency','');
        req.params.put('commitFlag','');
        req.httpMethod = 'GET';
        req.addHeader('Content-Type','application/json'); 
        
        List<O_CreateRevenueSchedule_GE_OG.RevenueLinesWrapper> reqList = O_CreateRevenueSchedule_GE_OG.retrieveRevenueLines();
        
    }
    
}