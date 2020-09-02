/*
Class/Trigger Name     : OpportunityMultiTier_GE_OG_Test
Purpose/Overview       : Test Class to calculate the code coverage for the OpportunityMultiTier_GE_OG Class.
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-26476
Author                 : Harsha C
Created Date           : 10-Sep-2018
Used For               : OpportunityMultiTier_GE_OG - 97%

*/ 

@isTest
public class OpportunityMultiTier_GE_OG_Test {
    
    @testsetup
    static void createRecord()
    {
        
        //creating 'Country Region Mapping' for 'INDIA'
        Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
        insert objcustom;
        
        /* Create Opportunity Reason Code Custom Setting */
        List<Opportunity_Primary_Reason_Has_Code__c> lstReasonCode = CommonTestDataFactory_GE_OG.createPrimaryReasonCustomSetting();
        insert lstReasonCode;
        
        
        // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        
        //Createing an Account 
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        Account accmem = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccount Relation 1');
        system.assertEquals('TestAccount Relation 1',accmem.Name);
        
        //Createing an Account
        Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('TestAccount Legal',acc.ID,acc1.ID);
        system.assertEquals('TestAccount Legal',accLE.Name);
        
        //Create Test Account for ContactSumTrigger
        String TestAccountName = system.Label.Test_Account_Name;
        // Account testacc = CommonTestDataFactory_GE_OG.createCommercialParentAccount(TestAccountName); commetned by kiru
        
        // Create Legal Account with Type 'Internal' 
        /*Account accInternal = CommonTestDataFactory_GE_OG.createInternalLegalEntity('TestAccount Internal');
system.assertEquals('TestAccount Internal',accInternal.Name);*/
        Account accInternal = CommonTestDataFactory_GE_OG.createSellingLegalEntityAccount('TestAccount Internal',acc.ID);
        system.assertEquals('TestAccount Internal',accInternal.Name);
        Test.startTest();
        //Creating an Opportunity
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',opp.Name);
        
        
        Opportunity opp2 = CommonTestDataFactory_GE_OG.createOppty('Testopportunity2',acc.ID);
        system.assertEquals('Testopportunity2',opp2.Name);
        
        
        //Creating a Product
        Product2 prod1 = CommonTestDataFactory_GE_OG.createProduct('testProduct');
        system.assertEquals('testProduct',prod1.Name);
        
        Product2 prod2 = CommonTestDataFactory_GE_OG.createProductSameTier3('testProduct2');
        system.assertEquals('testProduct2',prod2.Name);
        
        
        //Creating a PriceBookEntry
        //PriceBookEntry PBE=  CommonTestDataFactory_GE_OG.createPriceBookEntry(prod1);
        //system.assertEquals(prod1.ID,PBE.Product2ID);
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        List<PriceBookEntry> lstPBE1 = new List<PriceBookEntry>();
        lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        //lstPBE.add(PBE);
        
        
        //Create OpportunityLineItem 
        if(lstPBE.size()==0){
            PricebookEntry objPBE = new PricebookEntry();
            objPBE.Product2Id = prod1.Id;
            objPBE.UseStandardPrice = False;
            objPBE.UnitPrice = 0;
            objPBE.CurrencyIsoCode = 'USD';
            objPBE.IsActive = prod1.IsActive;
            objPBE.Pricebook2Id = Test.getStandardPricebookID();
            insert  objPBE;
            
            PricebookEntry objPBE1 = new PricebookEntry();
            objPBE1.Product2Id = prod2.Id;
            objPBE1.UseStandardPrice = False;
            objPBE1.UnitPrice = 0;
            objPBE1.CurrencyIsoCode = 'USD';
            objPBE1.IsActive = prod2.IsActive;
            objPBE1.Pricebook2Id = Test.getStandardPricebookID();
            insert  objPBE1;
            lstPBE1 = new List<PriceBookEntry>();
            lstPBE1 = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        }
        // system.assertEquals(1,lstPBE.size());
        if(lstPBE.size()>0){
            List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
            lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(opp, lstPBE);
            if(lstOLI.size()>0){
                insert lstOLI;
            }
        }
        
        if(lstPBE1.size()>0){
            List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
            lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemDiffTier(opp2, lstPBE1);
            if(lstOLI.size()>0){
                insert lstOLI;
            }
        }
        Test.stopTest();
    }
    public static testMethod void testOpportunityStages1(){
        
        OpportunityMultiTier_GE_OG oppmultitier = new OpportunityMultiTier_GE_OG();
        Map<Id,Opportunity> oldOppMap =  new Map<Id,Opportunity>();
        Test.startTest();
        List<Opportunity> op = [Select id,Name,tier_3_ge_og__c,HasOpportunityLineItem,MultiTier3_ge_og__c from Opportunity ];
        Opportunity op1 = new Opportunity();
        System.debug(' b$ op1.MultiTier3_ge_og__c'+ op[0].MultiTier3_ge_og__c);
        System.debug('  B4 Update op2.MultiTier3_ge_og__c'+ op[1].MultiTier3_ge_og__c);  
        
        oldOppMap.put(op[0].Id, op[0]);
        oldOppMap.put(op[1].Id, op[1]);
        op1.Id = op[1].Id;
        op1.tier_3_ge_og__c = 'Digital';
        
        update op1;
        
        System.debug(' after Update op2.MultiTier3_ge_og__c'+ op[1].MultiTier3_ge_og__c);  
        
        oppmultitier.updateMultiTier(op, oldOppMap);
        Test.stopTest();
    }
    
    
}