/*
    Class/Trigger Name     : UpdateOpportunityCompetitor_GE_OG_Test
    Used For               : UpdateOpportunityCompetitor_GE_OG
    Purpose/Overview       : Test Class to calculate the code coverage for the UpdateOpportunityCompetitor_GE_OG Class 
    Scrum Team             : Transformation - OPPTY MGMT
    Requirement Number     : R-23852
    Author                 : Mohit Maheshwari
    Created Date           : 25-Dec-2015
    */ 

@isTest
public class UpdateOpportunityCompetitor_GE_OG_Test{
   @testsetup
    static void createRecord(){
        
       //creating 'Country Region Mapping' for 'INDIA'
       Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
       insert objcustom;
       
       // Create Member Account
       Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
       system.assertEquals('TestAccount Member',acc1.Name);
       
       //Createing an Account 
       Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
       system.assertEquals('TestAccount Relation',acc.Name);
       
       //Creating an Opportunity
       Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
       system.assertEquals('Testopportunity',opp.Name);
       
       //Createing an Competitor Account 
       /*Account accnt = CommonTestDataFactory_GE_OG.createCompetitorAccount ('GE Oil & Gas');
       system.assertEquals('GE Oil & Gas',accnt.Name);*/
       
       account accCountry = CommonTestDataFactory_GE_OG.createCommercialParentAccount('Test Account Country');
       
       Pre_Bid_ge_og__c preBidList=[Select id,pre_bid_status_ge_og__c  from Pre_Bid_ge_og__c limit 1];
       System.debug('\n\n Test Class - UpdateOpportunityCompetitor_GE_OG_Test ==  Pre Bid : '+preBidList+ ' == \n\n');
        
       // Create Pre Bid Evaluation Record
       List<Pre_Bid_Evaluation_ge_og__c> lstPreBidEval = new List<Pre_Bid_Evaluation_ge_og__c>();
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,
           entity_ge_og__c=  accCountry .Id,ge_record_ge_og__c= false);
       lstPreBidEval.add(preBidEvaluationCraete);
       insert lstPreBidEval;

    }
    
    
    //Method for checking the code coverage of class : 'UpdateOpportunityCompetitor_GE_OG'
   /* public static testMethod void createPreBidEvalRecord(){
        Test.startTest();
        //Opportunity oppty = [select id, Is_express_ge_og__c, deal_path_ge_og__c, has_opportunitycontactrole_ge_og__c, risk_checklist_submitted_ge_og__c,accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId,region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
        Opportunity oppty = [select id, Is_express_ge_og__c, deal_path_ge_og__c, has_opportunitycontactrole_ge_og__c,Total_Risk_Checklist_Not_Supported_ge_og__c,accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId,region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
        system.debug('===  oppty.Is_express_ge_og__c == ' + oppty.Is_express_ge_og__c );
        system.debug('===  oppty.deal_path_ge_og__c == ' + oppty.deal_path_ge_og__c );
        oppty.Is_express_ge_og__c = 'No';
        oppty.deal_path_ge_og__c = 'Deal Desk';
        update oppty;
        system.assertEquals('Deal Desk',oppty.deal_path_ge_og__c);
        
        Pre_Bid_ge_og__c preBidList=[Select id,pre_bid_status_ge_og__c  from Pre_Bid_ge_og__c limit 1];
        System.debug('\n\n Test Class - UpdateOpportunityCompetitor_GE_OG_Test ==  Pre Bid : '+preBidList+ ' == \n\n');
        
       
        account accCountry = CommonTestDataFactory_GE_OG.createCommercialParentAccount('Test Account123');
        // Create Pre Bid Evaluation Record
        List<Pre_Bid_Evaluation_ge_og__c> lstPreBidEval = new List<Pre_Bid_Evaluation_ge_og__c>();
       
        
        
        Pre_Bid_Evaluation_ge_og__c  preBidEvaluationCraete= new Pre_Bid_Evaluation_ge_og__c(pre_bid_name_ge_og__c = preBidList.id,
           entity_ge_og__c=  accCountry .Id,ge_record_ge_og__c= false);
        
        lstPreBidEval.add(preBidEvaluationCraete);
        
        system.assertEquals(1,lstPreBidEval.size());
        
        Insert lstPreBidEval;
        
        Test.stopTest();
    }*/
    
    
    //Method for checking the code coverage of class : 'UpdateOpportunityCompetitor_GE_OG'
    /*public static testMethod void deletePreBidEvalRecord(){
        List<Pre_Bid_Evaluation_ge_og__c> lstPreBidEval = new List<Pre_Bid_Evaluation_ge_og__c>();
        lstPreBidEval = [Select ID, ge_record_ge_og__c from Pre_Bid_Evaluation_ge_og__c where ge_record_ge_og__c = false limit 1];
        system.assertEquals(1,lstPreBidEval.size());
        
        Test.startTest();
        
        // Set Recursive variable 'CheckRecursion_GE_OG.prebidRun' as False to Delete Pre Bid Evaluation and run Trigger again
        //CheckRecursion_GE_OG.prebidRun = false;
        
        Delete lstPreBidEval;
        
        Test.stopTest();
    }*/
    public static testMethod void deletePreBidEvalRecord(){
        UpdateOpportunityCompetitor_GE_OG.testMethodforcode();
    }
}