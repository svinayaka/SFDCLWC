/*
Class Name : BigMachinesDeleteBMProds
Used Where ? : 
Purpose/Overview : 
Functional Area : Opportunity Management
Author:  
Created Date: 
Test Class Name : 

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
09/08/2011    : Prasad Yadala      :                               : Modified test methods to clear the soql query limit exceptions
12/16/2011    : Prasad Yadala      :                               : Modified as a part of Requirement R-5674
 
*/

public class BigMachinesDeleteBMProds {  
    public static void deleteBMProds(ID quoteId, ID opportunityId) 
    {  
        
        try
        {
            OpportunityLineItem[] opportunityProdToDel = [select Id, OpportunityId, BMI_Part_Number__c from OpportunityLineItem where OpportunityId = :opportunityId and BMI_Part_Number__c != '' and From_BM_Quote__c != true and (BigMachines__Origin_Quote__c = '' or BigMachines__Origin_Quote__c = null)];                   
            delete opportunityProdToDel;
        }
        catch(Exception e)
        {
           System.debug('Error');
        }
    }   
    
    //test method for BigMachinesDeleteBMProds
    @isTest static void testBigMachinesDeleteBMProds() {
        BigMachinesDeleteBMProds.deleteBMProds(null,null);
    }
    
   
    @isTest static void testSyncQuoteWithOpty() {
        Account acct = [select id,name,GE_HQ_Request_Status__c from Account where Name = 'TestClassAccount' and GE_HQ_Request_Status__c = 'CMF Approved' limit 1];          
        
        //Sunayana : Code commented  as class GEESGlobalContextController does not exists any more 
        /* GEESGlobalContextController.etaxflag = true;
        GEESGlobalContextController.COProdflag = true;
        GEESGlobalContextController.flag1 = true;
        GEESGlobalContextController.rMatrix = true;
        GEESGlobalContextController.flag2 = true;
        GEESGlobalContextController.flagcurrency = true;
        GEESGlobalContextController.flagScope = true;
        GEESGlobalContextController.flagPriceMgmt = true;
        GEESGlobalContextController.OpptyToPriceMgmt = true;
        GEESGlobalContextController.OpptyToBMPriceMgmt = true; */
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'accname';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';

        //acc.Type = 'Competitor';
        //acc.Member_of_GE_OG__c = accID;
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'ABC';
        insert acc;
        
        IFE__DisableOpportunityTriggers__c ifgetOppty = IFE__DisableOpportunityTriggers__c.getInstance('Test_Opty');
        System.debug('\n\n =============>>>>> IFE TRIGGER '+ifgetOppty);
        if(ifgetOppty == null){
            IFE__DisableOpportunityTriggers__c ifOppty = new IFE__DisableOpportunityTriggers__c();
            ifOppty.name = 'Test_Opty';
            ifOppty.IFE__Is_Disabled__c = true;
            insert ifOppty;
        } else {
            System.debug('\n\n =============>>>>> IFE TRIGGER : ELSE BLOCK '+ifgetOppty);
            ifgetOppty.IFE__Is_Disabled__c = true;
            update ifgetOppty;
        } 
        opportunity opp = new opportunity();
        opp.name= 'oppName';
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = acc.Id;
        opp.tier_2_ge_og__c ='Digital Solutions';
        opp.tier_3_ge_og__c ='Bently Nevada';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =1000.00;
        opp.install_country_ge_og__c= 'India';
        insert opp;     
        
        /*
        opty.Name = 'BigMachines test opportunity for testSyncQuoteWithOpty()';
        opty.StageName = 'Prospect';
        //Modified as a part of Requirement R-5674
        //opty.GE_HQ_Business_Tier1__c = 'ES';
        opty.CloseDate = Date.today();
        RecordType[] rtID2 = [select Id from RecordType where Name = 'DE'];
        opty.RecordTypeId = rtId2[0].Id;
        opty.Account = acct;
        insert opty;
        */
        
        //opty  =  [Select Id from Opportunity where Name = 'TestClassOpportunity - DE'];
       
       
        // BigMachines_Quote__c.ensurePrimary - begin test
        BigMachines__Quote__c[] quotes = new BigMachines__Quote__c[3];
        for (Integer i=0; i<quotes.size(); i++) {
            quotes[i] = new BigMachines__Quote__c();
            quotes[i].Name = 'BigMachines test quote ' + (i+1) + ' for testSyncQuoteWithOpty()';
            //quotes[i].BigMachines__Opportunity__c = opty.Id;
        }
        insert quotes;  
        // BigMachines_Quote__c.ensurePrimary - end test

        Product2[] prod = new Product2[6];
        for (Integer i=0; i<prod.size(); i++) {
            prod[i] = new Product2();
            prod[i].Name = 'BigMachines test proudct ' + i + ' for testSyncQuoteWithOpty()';
            prod[i].IsActive = true;
            prod[i].BigMachines__Part_Number__c = 'BMITest0' + i;
        }
        insert prod;
        Pricebook2 pbStandard = [select Id from Pricebook2 where IsStandard = true];
        PricebookEntry[] pbookEntry = new PricebookEntry[5];
        for (Integer i=0; i<pbookEntry.size(); i++) {
            pbookEntry[i] = new PricebookEntry();
            pbookEntry[i].IsActive = true;
            pbookEntry[i].Pricebook2Id = pbStandard.id; 
            pbookEntry[i].Product2Id = prod[i].id;
            pbookEntry[i].UnitPrice = i;
        }  
        insert pbookEntry;
         Test.StartTest();
        // BigMachinesQuoting.syncQuoteWithOpty - begin positive test
        BigMachines__Quote_Product__c[] qProd = new BigMachines__Quote_Product__c[5];  
        for (Integer i=0; i<qProd.size(); i++) {
            qProd[i] = new BigMachines__Quote_Product__c();
            qProd[i].Name = 'BMITest0' + i;
            qProd[i].BigMachines__Quote__c = quotes[0].id;
            qProd[i].BigMachines__Sales_Price__c = i;
            qProd[i].BigMachines__Quantity__c = i+1;
        }
        
        try 
        {
        insert qProd;
        }catch(Exception ex){}
        
        quotes[0].BigMachines__Is_Primary__c = true;
        
        try 
        {
            update quotes; 
        }catch(Exception ex){}
        
        
      //  updateProductsLater(quotes[0].id, opty.id);
        // BigMachinesQuoting.syncQuoteWithOpty - end positive test
        
        // Quote_Product__c.propogateModifications - begin test
        try{
        delete qProd[0];
        }catch(Exception ex){}
        // Quote_Product__c.propogateModifications - begin test

        // BigMachinesQuoting.syncQuoteWithOpty - begin no product price negative test 
        BigMachines__Quote_Product__c noPriceProd = new BigMachines__Quote_Product__c();
        noPriceProd.Name = 'BMITest05';
        noPriceProd.BigMachines__Quote__c = quotes[0].id;
        noPriceProd.BigMachines__Sales_Price__c = 5;
        noPriceProd.BigMachines__Quantity__c = 6;
        boolean throwsException = false;
        try 
        {
            insert noPriceProd;
        } 
        catch (Exception e) 
        {
            throwsException = true;
        }
        System.assert(throwsException);
        // BigMachinesQuoting.syncQuoteWithOpty - end no product price negative test

        // Quote_Product__c.propogateModifications - begin error check test
        qProd = new BigMachines__Quote_Product__c[2];
        for (Integer i=0; i<qProd.size(); i++) {
            qProd[i] = new BigMachines__Quote_Product__c();
            qProd[i].Name = 'BMITest0' + i;
            qProd[i].BigMachines__Quote__c = quotes[i+1].id;
            qProd[i].BigMachines__Sales_Price__c = 1;
            qProd[i].BigMachines__Quantity__c = 1;
        }
        insert qProd;
        delete qProd;
        // Quote_Product__c.propogateModifications - end error check test

        // BigMachines_Quote__c.promotePrimaryProdToOppty - begin multi-case test
        quotes[0].BigMachines__Is_Primary__c = false;
        quotes[1].BigMachines__Is_Primary__c = true;
        quotes[2].BigMachines__Is_Primary__c = true;
        update quotes;
        // BigMachines_Quote__c.promotePrimaryProdToOppty - end multi-case test
        
        // BigMachinesQuoting.syncQuoteWithOpty - begin invalid pricebook negative test
        Pricebook2 pbook = new Pricebook2();
        pbook.Name = 'Different pricebook';
        insert pbook;
        quotes[0].BigMachines__Is_Primary__c = true;
        quotes[0].BigMachines__Pricebook_Id__c = pbook.id;
        throwsException = false;
        
        try 
        {
            update quotes;
        } 
        catch (Exception e) 
        {
            throwsException = true;
        }
        
        //System.assert(throwsException);
        // ignore invalid pricebook Id
        quotes[0].BigMachines__Pricebook_Id__c = 'garbage';
        quotes[0].BigMachines__Is_Primary__c = true;
        update quotes;                                      
        // BigMachinesQuoting.syncQuoteWithOpty - end invalid pricebook negative test
        
        Test.StopTest();
    }   

}