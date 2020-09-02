/*
    Class/Trigger Name     : UpdateDeliveryDateOnOLI_GE_OG_Test
    Used For               : OpportunityStagesAutomationHandler_GE_OG
    Purpose/Overview       : Test Class to calculate the code coverage for the UpdateDeliveryDateOnOLI_GE_OG Class
    Scrum Team             : Transformation - OPPTY MGMT
    Requirement Number     : R-23941
    Author                 : Mohit Maheshwari
    Created Date           : 21-Dec-2015
*/ 

@isTest
public class UpdateDeliveryDateOnOLI_GE_OG_Test{
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

       //Creating a Product
       
       Product2 prod1 = CommonTestDataFactory_GE_OG.createProduct('testProduct');
       system.assertEquals('testProduct',prod1.Name);
       
       //Creating a PriceBookEntry
       PriceBookEntry PBE=  CommonTestDataFactory_GE_OG.createPriceBookEntry(prod1);
       system.assertEquals(prod1.ID,PBE.Product2ID);
       
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        //lstPBE = [Select ID, CurrencyIsoCode, UnitPrice, Pricebook2Id, Product2Id, IsActive, UseStandardPrice from PriceBookEntry limit 1];
        lstPBE.add(PBE);
        
        //Create OpportunityLineItem 
        if(lstPBE.size()>0){
            List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
            lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(opp, lstPBE);
            if(lstOLI.size()>0){
                insert lstOLI;
            }
        }
            

       
    }

     //Method for insert OpportunityProduct
    public static testMethod void testOpportunityProductDeliverDate(){
    
        Opportunity oppty = [select id, accountId, delivery_date_ge_og__c, recordtypeId from opportunity where Name = 'Testopportunity'];
                                        
        Test.startTest(); 
        
        system.debug('---------oppty----'+oppty);
            
        oppty.delivery_date_ge_og__c = System.Today().addDays(2);
        update oppty;
                       
        Test.stopTest();
        
    }
}