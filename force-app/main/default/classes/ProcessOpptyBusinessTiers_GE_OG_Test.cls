/*
Class Name: ProcessOppRegionUpdate_GE_OG
Author: Mohit Maheshwari
Created Date: 13/Oct/2015
*/
@isTest
private class ProcessOpptyBusinessTiers_GE_OG_Test{

    static testMethod void productBookEntryAutomation() {
    
       //Test.startTest();
    
       //Creating OLI and delete
       CommonTestDataFactory_GE_OG objCTDF =  new CommonTestDataFactory_GE_OG();
       
       //creating 'Country Region Mapping' for 'INDIA'
       Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
       insert objcustom;
       
       
       //Creating new account
        account acc = CommonTestDataFactory_GE_OG.createRelationshipAccount ('Test Account');
        acc  = [SELECT Id,Recordtype.Name FROM Account WHERE Id =:acc.Id];
        
        
        
        account accCountry = CommonTestDataFactory_GE_OG.createCommercialParentAccount('Test Account Country');
        
       
       
        account accLE1 = new account(); 
        accLE1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accLE1.name = 'Test Account LE';
        accLE1.Account_Tier_GEOG__c = 'LE';
        accLE1.Oil_Gas_Parent_Account__c = acc.Id;
        Account accGlobal= CommonTestDataFactory_GE_OG.createAccount('TestAccount Global');    
        accLE1.Member_of_GE_OG__c = accGlobal.Id;//
        accLE1.Country_GEOG__c = 'INDIA';
        accLE1.Classification__c= 'Strategic';
        accLE1.Type = 'Hedge';
        accLE1.ShippingCountry = 'India';
        accLE1.Account_Status__c = 'CC Approved';
        accLE1.ParentId = acc.Id;
        insert accLE1;
        
        
        accLE1 = [Select Id,Account_Tier_GEOG__c ,ParentId,Parent.Recordtype.Name From Account Where id =:accLE1.Id];
        
        acc  = [SELECT Id,Recordtype.Name FROM Account WHERE Id =:acc.Id];
        
        //Test.stopTest();
        
        Test.startTest();

       
       //Creating an Opportunity
       Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
       system.assertEquals('Testopportunity',opp.Name);
       
       OpportunityTeamMember objOTM = CommonTestDataFactory_GE_OG.createOpportunityTeamMember(opp); 
       objOTM.TeamMemberRole =  'Primary Commercial Manager';
       update objOTM;
       objOTM.TeamMemberRole =  'sales';
       update objOTM;
       objOTM.TeamMemberRole =  'Primary Commercial Manager';
       update objOTM;
       List<OpportunityTeamMember > lstOTM = new List<OpportunityTeamMember>();
       lstOTM.add(objOTM);
       delete lstOTM;
       
       //Creating a Product
       Product2 product = CommonTestDataFactory_GE_OG.createProduct('testProduct');
       system.assertEquals('testProduct',product.Name);
       
       //Creating a PriceBookEntry
       PriceBookEntry PBE=  CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
       system.assertEquals(product.ID,PBE.Product2ID);
       
       //Creating a Opportunity Product 
       OpportunityLineItem OLI= CommonTestDataFactory_GE_OG.createOpportunityLineItem(opp,PBE);
       system.assertEquals(PBE.ID,OLI.PriceBookEntryID);
       
       //Creating a Opportunity Product 
       //OpportunityLineItem OLI2= CommonTestDataFactory_GE_OG.createOpportunityLineItem(opp,PBE);
       //system.assertEquals(PBE.ID,OLI2.PriceBookEntryID);

       ValidateOpportunityLineItem_GE_OG VOLI = new ValidateOpportunityLineItem_GE_OG();
       //VOLI.validateOpportunityLineItemTier(New List<OpportunityLineItem>{OLI,OLI2});
       VOLI.validateOpportunityLineItemTier(New List<OpportunityLineItem>{OLI});
  
       //Delete OpportunityProduct
       //delete OLI;
       //system.assertEquals(False,opp.HasOpportunityLineItem);
       
       opp = [SELECT Id,install_country_ge_og__c,amount_ge_og__c,Account.Account_Tier_GEOG__c ,AccountId,Account.RecordtypeId FROM opportunity where
              Id  =: opp.Id];
       
       opp.install_country_ge_og__c= null;
       update opp;
        opp = [SELECT Id,install_country_ge_og__c,amount_ge_og__c,Account.Account_Tier_GEOG__c ,AccountId,Account.RecordtypeId FROM opportunity where
              Id  =: opp.Id]; 
       accLE1 = [SELECT Id, Account_Tier_GEOG__c ,ParentId,RecordtypeId,Parent.RecordtypeId FROM Account WHERE ID=:accLE1.ID];
       
       
       // update 'End User' Account
      opp.end_user_ge_og__c = accLE1.ID;
      
      update opp;
      
      
       Test.stopTest();
    }
 }