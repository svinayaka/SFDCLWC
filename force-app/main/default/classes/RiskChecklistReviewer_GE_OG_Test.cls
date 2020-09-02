/*
Class/Trigger Name     : RiskChecklistReviewer_GE_OG_Test
Used For               : RiskChecklistReviewer_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the RiskChecklistReviewer_GE_OG, OpportunityStagesAutomationHandler_GE_OG Class 
                        for OpportunityTrigger_GE_OG Trigger helper class
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23234
Author                 : Nitish Pandey
Created Date           : 29-Mar-2016

*/

@isTest

public class RiskChecklistReviewer_GE_OG_Test{

    public static testMethod void riskChecklistReviewer() {

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
       rcc.RCC_Opportunity_ge_og__c=opp.Id;
       rcc.Is_Active_ge_og__c=True; 
       insert rcc; 
       
       Map<Id,Id> rccOpptyMap = new Map<Id,Id>();
       rccOpptyMap.put(rcc.id,opp.id);
       Test.startTest();
       RiskChecklistReviewer_GE_OG rcr = new RiskChecklistReviewer_GE_OG();
       
       rcr.submitRecord(rcc,UserInfo.getUserId(),rccOpptyMap);
       rcr.rejectRecord(rcc);
       rcr.submitRecord(rcc,UserInfo.getUserId(),rccOpptyMap);
       rcr.approveRecord(rcc);
       List<Risk_Checklist_Category_ge_og__c > listRCC = new List<Risk_Checklist_Category_ge_og__c >();
       listRCC.add(rcc);
       rcr.recallRecord(listRCC);
       Test.stopTest();
       
       }

}