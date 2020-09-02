/*
Type Name [Class/Trigger/Page Name] : GE_OG_OpptyProductCodeTest
Used Where ?                        : Used to test GE_OG_OpptyProductCode
Purpose/Overview                    : 
Functional Area                     : 
Author                              : Pradeep Rao Yadagiri
Created Date                        : 09/11/2014
Test Class Name                     : NA                

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

@isTest
public class GE_OG_OpptyProductCodeTest {
    @isTest
    static void test_GE_OG_OpptyProductCode(){
    
    test.starttest();
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
           lstPBE.add(PBE);
           test.stoptest();
           
           //Create OpportunityLineItem 
           if(lstPBE.size()>0){
                List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
                lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(opp, lstPBE);
                if(lstOLI.size()>0){
                    insert lstOLI;
                    Delete lstOLI;
    }    
}
}
}