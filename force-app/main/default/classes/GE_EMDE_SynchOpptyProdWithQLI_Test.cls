/*
Description     : This is the test class to cover the GE_EMDE_SynchOpptyProdWithQuoteLineItem trigger
Functional Area : Quick Quotes-Aero Service Synch funcationality
Created By      : Jayaraju Nulakachandanam 
Release         : Huey

*/

@isTest(SeeAllData = true)
public class GE_EMDE_SynchOpptyProdWithQLI_Test
{
    static testMethod void GE_EMDE_SynchOpptyProdWithQLI_Test1()
    {
        //Creating a new Account
           
           /*
            Account Acc=new Account();
            Acc.Name='CUSTOMERLINX OF OKLAHOMA INC';
            Acc.GE_HQ_Request_Status__c = 'CMF Approved';        
            Acc.BillingCountry = 'USA';        
            Acc.ShippingStreet = '123 Test Ave.';        
            Acc.ShippingCity = 'Testville';        
            Acc.ShippingState = 'FL';        
            Acc.ShippingPostalCode = '32951';        
            Acc.ShippingCountry = 'Argentina';                  
            insert Acc; 
            System.assertEquals(acc.GE_HQ_Request_Status__c,'CMF Approved');      
         */   
         
     //   User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
        /*
    Account acc = new Account();
           acc.Name='Test Acc For TestClass';  
           acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
           acc.Account_Tier_GEOG__c = 'Country';
           acc.Country_GEOG__c = 'INDIA';
           acc.Classification__c= 'Strategic';
           acc.ShippingCountry = 'India';
           acc.GE_ES_Primary_Industry__c = 'ABC';           
           insert acc;
        */
        
         Account acc = new Account();
      User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
      
        acc.Name='TestClassAccount';  
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        //acc.name = accname;
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        //acc.Type = 'Competitor';
        //acc.Member_of_GE_OG__c = accID;
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'ABC';
        insert acc;
        
        //Creating an Opportunity
            //Id rt =[select id,Name from RecordType where sObjectType='Opportunity' and Name='GE PW Aero Services' limit 1][0].Id;                                 
           /*
            CommonTestDataFactory_GE_OG.DeactivateIFETrig();
            Opportunity Opp =new Opportunity();
            //Opp.RecordTypeId=rt;
            Opp.tier_1_ge_og__c ='Oil & Gas (O&G)';
            Opp.tier_2_ge_og__c ='Measurement & Control';
            Opp.tier_3_ge_og__c  ='Bently Nevada';
            Opp.name='KT-DE Oppty-Quote'; 
            //Opp.Pricebook2Id = pbook.id;     
            Opp.StageName='Prospecting'; 
            Opp.AccountId = Acc.Id;
            //Commented below for oppty cleanup
            //Opp.GE_ES_Customer_Type__c='Distributor';
            Opp.install_country_ge_og__c ='INDIA';
            //Opp.GE_OG_PII_State__c='Victoria';
            Opp.CloseDate = Date.today();
            //Commented below for oppty cleanup
            //Opp.GE_ES_R_Status__c='R0';
            Opp.amount_ge_og__c =1000.00;
            insert Opp;
            
            */
            CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        Opportunity_Split_Account__c splacc = new Opportunity_Split_Account__c();
        splacc.Account_Id__c = acc.id;
        splacc.Region__c = 'Asia';
        splacc.Name = 'Asia1';
        insert splacc;
        Opportunity oppty2 = new Opportunity();        
        //oppty2.RecordTypeId =MCSRecId;
        oppty2.Name= 'Test Oppty1';
        oppty2.tier_1_ge_og__c= 'Oil & Gas (O&G)';
        oppty2.tier_2_ge_og__c='Measurement & Control (M&C)';
        oppty2.tier_3_ge_og__c='Opex Core';
        oppty2.amount_ge_og__c =1000.00;
        //main region
        //oppty2.GE_Tier2_Pregion__c = 'Canada';
        //oppty2.GE_T2PrmRgTy__c = 'Tier 2 Account Region';
        //oppty2.GE_Tier2_Pregion__c = 'Asia';
        oppty2.currencyisocode = 'USD';
        oppty2.AccountId = acc.Id;  
        //commeneted below for cleanup      
        //oppty2.Opportunity_Splitted__c =false;
        oppty2.StageName = 'Prospecting';
        oppty2.CloseDate= Date.today();
        
       // insert oppty2;
            
            
            
           /* 
            Product2 p2 = new Product2();        
            p2.Name = 'a test product';        
            p2.ProductCode = 'xyz123';        
            p2.Description = 'a description';        
            p2.Family = 'a test family';
           // p2.GE_ES_Reporting_Segment__c='test segment'; 
            p2.GE_ES_P_L__c ='MCS';            
            p2.GE_ES_Sub_P_L__c='Measurement Solutions';      
            insert p2;
           
           Pricebook2 pbStandard = [select Id from Pricebook2 where IsStandard = true];
           PricebookEntry pbe = new PricebookEntry();        
           pbe.Product2Id = p2.Id;        
           pbe.Pricebook2Id = pbStandard.id;        
           pbe.UnitPrice = 100;        
           pbe.UseStandardPrice = false;        
           pbe.IsActive = true;        
           insert pbe;  
            
       
        //Creating a Quote 
            Id rt1 =[select id,Name from RecordType where sObjectType='Quote' and Name='GE PW Aero Services' limit 1][0].Id;   
            Quote quoteObj = new Quote(OpportunityId=oppty2.Id);            
            quoteObj.RecordTypeId=rt1;
            quoteObj.Name ='Test Quote';            
            quoteObj.OpportunityId =oppty2.Id;   
            quoteObj.Pricebook2Id = pbStandard.id;         
            insert quoteObj;
            //quoteObj.IsSyncing=true;
       
       QuoteLineItem qLIObj = new QuoteLineItem();
        //qLIObj.PriceBookEntry.Product2Id = pbe1.Product2Id;
        qLIObj.PriceBookEntryId = pbe.Id;
        //qLIObj.Product2 = p2.Id;
        //qLIObj.PriceBookEntry.ProductCode = pbe.ProductCode;
        qLIObj.QuoteId = quoteObj.Id;
        qLIObj.quantity=2;
        qLIObj.UnitPrice =100;
        insert qLIObj;  
        try{
        oppty2.SyncedQuoteId = quoteObj.Id;
        update oppty2;
        }
        catch(Exception e)
        {
        }     
        */
    }
}