/*
Class			       : Deal_Reviewer_GE_OG_Test
Used For               : Deal_Reviewer_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the Deal_Approver_GE_OG on Opportunity
Scrum Team             : OPPORTUNITY MGMT
Requirement Number     : R-***
Author                 : Nitish Pandey
Created Date           : 17-Sep-2015

*/

@isTest
private class Deal_Reviewer_GE_OG_Test {

 static testMethod void retrieveRiskReviewers_test() {

   RestRequest req = new RestRequest(); 
   RestResponse res = new RestResponse();


   // Create Member Account
   Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
       
   //Creating an Account 
   Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
       
   //Createing an Account
   Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account LE',acc.ID,acc1.ID);
       
   //creating new opportuntiy
   opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
   string dealSuccessresult = CreateDealDesk_GE_OG.createDealDesk(opp.id);
        
   Deal_Desk_ge_og__c dealDesk = [select id,status_ge_og__c,active_deal_desk_ge_og__c ,approver_comments_ge_og__c from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opp.id];

   Risk_Checklist_Category_ge_og__c rcc = new Risk_Checklist_Category_ge_og__c();
   rcc.RCC_Opportunity_ge_og__c=opp.id;
   rcc.Is_Active_ge_og__c=true;
   insert rcc;                
  
   req.requestURI = 'https://cs9.salesforce.com/services/apexrest/Deal_Reviewer_GE_OG/'+rcc.Id;  
   req.httpMethod = 'GET';
   RestContext.request = req;
   RestContext.response = res;

   List<Deal_Reviewer_GE_OG.ReviewerWrapper> drl = Deal_Reviewer_GE_OG.retrieveRiskReviewers();
   System.assert(drl.size() > 0);

 }

}