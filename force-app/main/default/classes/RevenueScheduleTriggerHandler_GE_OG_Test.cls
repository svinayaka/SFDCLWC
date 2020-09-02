/*
Class             : RevenueScheduleTriggerHandler_GE_OG_Test
Used For               : O_CreateRevenueSchedule_GE_OG
Purpose/Overview       : RevenueScheduleTriggerHandler_GE_OG
Scrum Team             : OPPORTUNITY MGMT
Requirement Number     : R-26544
Author                 : 
Created Date           : 22-Jan-18
*/

@isTest
private class RevenueScheduleTriggerHandler_GE_OG_Test{

  static testMethod void insertRevenueLines() {
  
  
        Account accLE = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccountRelation9');
    Account accComp = CommonTestDataFactory_GE_OG.createPreBidCompetitorAccount('Test Account Country9');
        //account accLE = [ select id from Account where name = 'TestAccount Relation'];
        //account accComp = [ select id from Account where name = 'Test Account Country'];
        
        //creating new opportuntiy for SubSea
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.accountId = accLE.Id;
        oppSS.tier_2_ge_og__c ='Oil Field Services'; 
        oppSS.tier_3_ge_og__c ='Chemicals';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;   
        
        Map<Id,Opportunity> mapOpptyOld = new Map<Id,Opportunity>{oppSS.Id => oppSS};
        
        
        //Create Product
        Product2 productSS = new Product2();
        productSS.name = 'productSS'; 
       // productSS.is_service_max_ge_og__c='Yes';
        productSS.GE_Tier2_PnL__c = 'Oil Field Services';
        productSS.GE_Tier3_PnL__c = 'Chemicals';
        insert productSS; 
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = productSS.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=oppSS.Id;
       // objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=200;
        objOppline.UNITPRICE=30000000; 
        objOppline.GE_OG_SS_oppty_Product_CM__c = 45;
        insert objOppline;
      objOppline.GE_ES_Primary_Quote__c = true;
      update objOppline;
      system.debug('objOppline.GE_ES_Primary_Quote__c after update-----------'+objOppline.GE_ES_Primary_Quote__c);
      List <OpportunityLineItem> oliList = new List <OpportunityLineItem>();
      oliList.add(objOppline);
            
        //Create Rev Lines
        Revenue_Schedule_ge_og__c revlines  = new Revenue_Schedule_ge_og__c();
        revlines.Opportunity__c = oppSS.Id;
        revlines.OpportunityLineItemID_ge_og__c = objOppline.Id;
        revlines.Revenue_Amount_ge_og__c=1000;
        revlines.Is_OpportunityLineItem_Included_ge_og__c = true;
        
        insert revlines;
      O_UpdateRevenueScheduleIncludedFlag flagUpdate = new O_UpdateRevenueScheduleIncludedFlag();
      flagUpdate.afterUpdateHandler(oliList);
  
  }

}