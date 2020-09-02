/*
Class/Trigger Name     : CQAChecklistController_GE_OG_Test
Used For               : CreateDealDesk_GE_OG, DealDeskTriggerHandler_GE_OG, DealDeskTrigger_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the CreateDealDesk_GE_OG on Opportunity
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23281
Author                 : Nitish Pandey
Created Date           : 17-Sep-2015

*/

@isTest

public class CQAChecklistController_GE_OG_Test{
    
 
            
    @testsetup
    static void createRecord(){
        
        //Creating new account
        Test.startTest();
        //Creating new accounts
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount('Test AccountTest');
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember('Test Account CountryTest', acc1.ID);
        //Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account LETest',acc1.ID,acc.ID);
        Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccount('Test Account LETest',acc.ID);
        
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        //Craete Fulfillemnt checklist
        List<Checklist_Category_ge_og__c> cgList = CommonTestDataFactory_GE_OG.createFulfillmentChecklistCategory();
        
        //Craete Checklist
        list<Checklist_ge_og__c> clList = CommonTestDataFactory_GE_OG.createChecklist(cgList);
        Test.stopTest();
    }

     //Method for checking the code coverage of class : 'OpportunityStagesAutomationHandler_GE_OG'
    public static testMethod void testOpportunityStages(){
        
        
        
        //Account acc = [select id from account where name='Test Account'];
        Account acc = CommonTestDataFactory_GE_OG.createAccount('Test Account');
        Account accCountry = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember('Test Account Country', acc.ID);
        //Account accCountry = [select id from account where name='Test Account Country'];
        //Account accLE = [select id from account where name='Test Account LE'];
        //Fetching opportunity 
        
        Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, 
        //Commented for DOA Revamp
        //risk_checklist_submitted_ge_og__c,
                                fulfillment_checklist_submitted_ge_og__c, region_ge_og__c, bid_to_win_approval_ge_og__c, 
                                legal_entity_ge_og__c from opportunity where name = 'TestOppty'];
        
        //Creating Product
        Product2 product = CommonTestDataFactory_GE_OG.createProduct('Test Product');
        
        //Creating PricebookEntry
        PriceBookEntry pbEntry = CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
       
        //Creating Opportunity Product, this will add amount in Oppty
        OpportunityLineItem opptyLineItem = CommonTestDataFactory_GE_OG.createOpportunityLineItem(oppty,pbEntry);
        
        
        
        Test.startTest(); 
         // Updating for Qualifying
        oppty.has_opportunitycontactrole_ge_og__c =true ;
        oppty.region_ge_og__c = 'Test Region';
        oppty.deal_path_ge_og__c = 'Deal Desk'; 
        oppty.Is_express_ge_og__c = 'No';
        update oppty;
        
        // Query to fetch oppty again, to handle scenario of recursion
        Opportunity oppty1 = [select id, oppty_cm_ge_og__c, stagename, tier_2_ge_og__c, tier_3_ge_og__c,  end_user_ge_og__c, 
                                install_country_ge_og__c, region_ge_og__c, delivery_date_ge_og__c, bid_due_date_ge_og__c, rfq_received_date_ge_og__c
                                from opportunity where Id =: oppty.Id];
        
        
        
        //System.assertEquals(oppty1.stageName, 'Qualifying');
         List<Checklist_Category_ge_og__c> cgList = [SELECT Id FROM Checklist_Category_ge_og__c];
         list<Checklist_ge_og__c> clList = [SELECT Id FROM Checklist_ge_og__c];
         
         
        
        
        
        //Opportunity for Bid in Development
        oppty1.oppty_cm_ge_og__c = 23;
        oppty1.has_opportunitycontactrole_ge_og__c =true ;
        oppty1.region_ge_og__c = 'Test Region';
        oppty1.deal_path_ge_og__c = 'Deal Desk';         
        //oppty1.end_user_ge_og__c= accLE.id;
        oppty1.install_country_ge_og__c= 'ALGERIA';
        oppty1.delivery_date_ge_og__c = system.today();
        //oppty1.bid_due_date_ge_og__c= system.today();
        //oppty1.rfq_received_date_ge_og__c = system.today();
        oppty1.accountId = accCountry.Id;
        oppty1.has_opportunitycontactrole_ge_og__c =true ;
        oppty1.region_ge_og__c = 'Test Region';
        //oppty1.pre_bid_evaluation_ge_og__c = true;
        //oppty1.bid_no_bid_approval_ge_og__c = true;
        oppty1.Is_express_ge_og__c = 'No'; 
        CheckRecursion_GE_OG.run =true; //handling recursion Scenario
        update oppty1;
        
         
        system.debug('fffffffffffffffffff region: '+ [select  deal_path_ge_og__c,stagename from Opportunity]);
        // Query to fetch oppty again, to handle scenario of recursion
        
             system.debug('fffffffffffffffffff region: '+ [select  deal_path_ge_og__c,stagename from Opportunity]);
                                
                                
            List<Fulfillment_Checklist_Category_ge_og__c> fcLst = [select id from Fulfillment_Checklist_Category_ge_og__c];
            list<Fulfillment_Checklist_Deviation_ge_og__c > fflist = [select id from Fulfillment_Checklist_Deviation_ge_og__c ];
            system.debug('rrrrrrrrrrr     size:  '+fcLst.size());
            system.debug('ssssssssssssssss    size:  '+fflist.size());
            //Create Product
            Product2 product1 = CommonTestDataFactory_GE_OG.createProduct('Test Product1');
            
            //Create Price Book Entry
            PriceBookEntry prBook1= CommonTestDataFactory_GE_OG.createPriceBookEntry(product1);
            
            //Craete oppty Product
            OpportunityLineItem oti1 = CommonTestDataFactory_GE_OG.createOpportunityLineItem(oppty,prBook1);
            
            try{
                delete oti1;
            }
            catch(exception e){}
            Test.stopTest(); 
    }
     public static testMethod void testOpportunityStages1(){
        
        
        Account acc = CommonTestDataFactory_GE_OG.createAccount('Test Account');
        Account accCountry = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember('Test Account Country', acc.ID);
        //Fetching opportunity 
        
        Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, 
                                fulfillment_checklist_submitted_ge_og__c, region_ge_og__c, bid_to_win_approval_ge_og__c, 
                                legal_entity_ge_og__c from opportunity where name = 'TestOppty'];
        
        //Creating Product
        Product2 product = CommonTestDataFactory_GE_OG.createProductSameTier3('Test Productsametier');
        
        //Creating PricebookEntry
        PriceBookEntry pbEntry = CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
       
        //Creating Opportunity Product, this will add amount in Oppty
        OpportunityLineItem opptyLineItem = CommonTestDataFactory_GE_OG.createOpportunityLineItem(oppty,pbEntry);
        
        
        
        
        Test.startTest(); 
         // Updating for Qualifying
        oppty.has_opportunitycontactrole_ge_og__c =true ;
        oppty.region_ge_og__c = 'Test Region';
        oppty.deal_path_ge_og__c = 'Deal Desk'; 
        oppty.Is_express_ge_og__c = 'No';
        update oppty;
        
        // Query to fetch oppty again, to handle scenario of recursion
        Opportunity oppty1 = [select id, oppty_cm_ge_og__c, stagename, tier_2_ge_og__c, tier_3_ge_og__c,  end_user_ge_og__c, 
                                install_country_ge_og__c, region_ge_og__c, delivery_date_ge_og__c, bid_due_date_ge_og__c, rfq_received_date_ge_og__c
                                from opportunity where Id =: oppty.Id];
        
        
        
        //System.assertEquals(oppty1.stageName, 'Qualifying');
         List<Checklist_Category_ge_og__c> cgList = [SELECT Id FROM Checklist_Category_ge_og__c];
         list<Checklist_ge_og__c> clList = [SELECT Id FROM Checklist_ge_og__c];
         
         
        
        
        
        //Opportunity for Bid in Development
        oppty1.oppty_cm_ge_og__c = 23;
        oppty1.has_opportunitycontactrole_ge_og__c =true ;
        oppty1.region_ge_og__c = 'Test Region';
        oppty1.deal_path_ge_og__c = 'Deal Desk';         
        //oppty1.end_user_ge_og__c= accLE.id;
        oppty1.install_country_ge_og__c= 'ALGERIA';
        oppty1.delivery_date_ge_og__c = system.today();
        //oppty1.bid_due_date_ge_og__c= system.today();
        //oppty1.rfq_received_date_ge_og__c = system.today();
        oppty1.accountId = accCountry.Id;
        oppty1.has_opportunitycontactrole_ge_og__c =true ;
        oppty1.region_ge_og__c = 'Test Region';
        //oppty1.pre_bid_evaluation_ge_og__c = true;
        //oppty1.bid_no_bid_approval_ge_og__c = true;
        oppty1.Is_express_ge_og__c = 'No'; 
        CheckRecursion_GE_OG.run =true; //handling recursion Scenario
        update oppty1;
        
         
        system.debug('fffffffffffffffffff region: '+ [select  deal_path_ge_og__c,stagename from Opportunity]);
        // Query to fetch oppty again, to handle scenario of recursion
        
             system.debug('fffffffffffffffffff region: '+ [select  deal_path_ge_og__c,stagename from Opportunity]);
                                
                                
            List<Fulfillment_Checklist_Category_ge_og__c> fcLst = [select id from Fulfillment_Checklist_Category_ge_og__c];
            list<Fulfillment_Checklist_Deviation_ge_og__c > fflist = [select id from Fulfillment_Checklist_Deviation_ge_og__c ];
            system.debug('rrrrrrrrrrr     size:  '+fcLst.size());
            system.debug('ssssssssssssssss    size:  '+fflist.size());
            //Create Product
            Product2 product1 = CommonTestDataFactory_GE_OG.createProduct('Test Product1');
            
            //Create Price Book Entry
            PriceBookEntry prBook1= CommonTestDataFactory_GE_OG.createPriceBookEntry(product1);
            
            //Craete oppty Product
            OpportunityLineItem oti1 = CommonTestDataFactory_GE_OG.createOpportunityLineItem(oppty,prBook1);
            
            try{
                delete oti1;
            }
            catch(exception e){}
            Test.stopTest(); 
    }
 
}