@isTest
private class ProcessOppRegionUpdate_GE_OG_Test{

    static testMethod void productBookEntryAutomation() {
    
       //Creating OLI and delete
       CommonTestDataFactory_GE_OG objCTDF =  new CommonTestDataFactory_GE_OG();
       
       //creating 'Country Region Mapping' for 'INDIA'
       Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
       insert objcustom;
       
       //Createing an Account
       /*Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccount ('TestAccount Relation');
       system.assertEquals('TestAccount Relation',acc.Name);*/
       account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Region_GEOG__c = 'India';
        insert acc;
       
       //Createing an Account
       Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccount('TestAccount Legal',acc.ID);
       system.assertEquals('TestAccount Legal',accLE.Name);
       
       //Creating an Opportunity
       Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
       system.assertEquals('Testopportunity',opp.Name);
       
       //Creating a Product
       
       
       Product2 prod1 = CommonTestDataFactory_GE_OG.createProduct('testProduct1');
       system.assertEquals('testProduct1',prod1.Name);
       
       Product2 prod2 = CommonTestDataFactory_GE_OG.createProduct('testProduct1','Downstream Technology Solutions');
       system.assertEquals('testProduct1',prod2.Name);
       
       Product2 prod3 = CommonTestDataFactory_GE_OG.createProduct('testProduct1','');
       system.assertEquals('testProduct1',prod3.Name);
       
       //Creating a PriceBookEntry
       
       
       PriceBookEntry PBE=  CommonTestDataFactory_GE_OG.createPriceBookEntry(prod1);
       system.assertEquals(prod1.ID,PBE.Product2ID);
       
       PBE=  CommonTestDataFactory_GE_OG.createPriceBookEntry(prod2);
       system.assertEquals(prod2.ID,PBE.Product2ID);
       
       PBE=  CommonTestDataFactory_GE_OG.createPriceBookEntry(prod3);
       system.assertEquals(prod3.ID,PBE.Product2ID); 
       
       List<PriceBookEntry> lstpbe = new List<PriceBookEntry>();
       lstpbe = [Select ID from PriceBookEntry]; 
       
       
       Test.startTest();
       
       //Creating a Opportunity Product 
       List<OpportunityLineItem> lstOLI= CommonTestDataFactory_GE_OG.createOpportunityLineItemDiffTier(opp,lstpbe);
       try{
           if(lstOLI.size()>0)
               insert lstOLI;
       }
       catch(Exception ex){
       
       }
       
       lstpbe = [Select ID from PriceBookEntry where Product2ID =: prod1.ID];
      // system.assertEquals(lstpbe.size(),1);    
       lstOLI = new List<OpportunityLineItem>();
       lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemDiffTier(opp,lstpbe);
       if(lstOLI.size()>0)
           insert lstOLI;
           
      // system.assertEquals(PBE.ID,lstOLI[0].PriceBookEntryID);
     
       
       //Delete OpportunityProduct
       //delete OLI;
       //system.assertEquals(False,opp.HasOpportunityLineItem);
       opp = [SELECT Id, install_country_ge_og__c,legal_entity_ge_og__c,end_user_ge_og__c,amount_ge_og__c FROM
                          opportunity WHERE Id=:opp.Id];
       
       // update 'Install Country' with null
       opp.install_country_ge_og__c= null;
       opp.legal_entity_ge_og__c = null;
       opp.end_user_ge_og__c = null;
       update opp;
       
       
       opp = [SELECT Id, install_country_ge_og__c,legal_entity_ge_og__c,end_user_ge_og__c,amount_ge_og__c FROM
                          opportunity WHERE Id=:opp.Id];
                          
       system.assertEquals(null,opp.install_country_ge_og__c);
       system.assertEquals(null,opp.legal_entity_ge_og__c);
       system.assertEquals(null,opp.end_user_ge_og__c);
        
       Contact objContact = new Contact();
       objContact.FirstName = 'TestFN';
       objContact.LastName = 'TestLN';
       objContact.AccountID = acc.ID;
       objContact.Email = 'testcontact@test.com';
       insert objContact;
       
       objContact = [Select ID from Contact where Email = 'testcontact@test.com' limit 1];
       
       
       OpportunityContactRole objContactRole = new OpportunityContactRole();
       objContactRole.OpportunityId = opp.ID;
       objContactRole.ContactID = objContact.ID;
       insert objContactRole;
       
       // update 'End User' Account
       opp.end_user_ge_og__c = accLE.ID;
       update opp;
      
       Test.stopTest();
    }
 }