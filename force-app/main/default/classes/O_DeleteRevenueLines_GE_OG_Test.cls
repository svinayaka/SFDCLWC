/*
Class                  : O_DeleteRevenueLines_GE_OG_Test
Used For               : O_DeleteRevenueLines_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the O_DeleteRevenueLines_GE_OG on Opportunity
Scrum Team             : OPPORTUNITY MGMT
Requirement Number     : R-***
Author                 : Rupal Seth
Created Date           : 08-Jan-18
*/

@isTest
public class O_DeleteRevenueLines_GE_OG_Test {
    static testMethod void deleteretrieveRevenueLines() {
        
        // Create Member Account
       Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test delRevAccount');
       
       //Creating an Account 
       Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount delRevAccountRelation', acc1.ID);
       
       //Createing an Account
       Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('Test Account delRevAccountLE',acc.ID,acc1.ID);
       
        //creating new opportuntiy
        opportunity oppty = CommonTestDataFactory_GE_OG.createOppty('TestOpptyDelRev', acc.id);
        oppty.tier_2_ge_og__c = 'Oil Field Services';
        //Cahnged from Control Solutions to Chemicals
        oppty.tier_3_ge_og__c ='Chemicals';
        update oppty;
        
        //Creating a Product
           Product2 prod1 = CommonTestDataFactory_GE_OG.createProduct('testProduct');
           system.assertEquals('testProduct',prod1.Name);
           
        
        List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
        lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
        
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
                lstPBE = new List<PriceBookEntry>();
                lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true and Product2.GE_Tier3_PnL__c ='Drill Bits' limit 1];
           }
           //system.assertEquals(1,lstPBE.size());
           if(lstPBE.size()>0){
                List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
                lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(oppty, lstPBE);
                if(lstOLI.size()>0){
                    insert lstOLI;
                }

        Revenue_Schedule_ge_og__c rs = new Revenue_Schedule_ge_og__c();
        if(lstOLI.size() > 0){
        rs.OpportunityLineItemID_ge_og__c = lstOLI[0].id;
        rs.Revenue_Rec_Date_ge_og__c = system.today();
        rs.Revenue_Amount_ge_og__c = 200;
        rs.opportunity__c = oppty.id;
        insert rs;
        delete lstOLI;
        }
    }

}
}