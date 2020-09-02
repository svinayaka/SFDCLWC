@isTest
Private class GEOGCreditLimitCalc_Test
{
    Static testMethod void GEOGCreditLimitCalc_Test()
    {
        //Account Acc1 = new Account(Name = 'Test account',BillingCountry = 'USA',ShippingCountry = 'USA',ShippingState = 'AT',ShippingCity = 'TestShipping City',ShippingStreet = 'Test Shipping Street',ShippingPostalCode = '101010',GE_HQ_Request_Status__c = 'CMF Approved');
       // Insert Acc1;
       
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account Global';
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Classification__c= 'Strategic';
        acc.Type = 'EPC';
        acc.ShippingCountry = 'India';
        insert acc;
       
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();

       
        Opportunity Opp1 = new Opportunity();
        //Opp1.tier_1_ge_og__c ='Power & Water (P&W)';
        Opp1.tier_1_ge_og__c ='Oil & Gas';
        
        Opp1.tier_2_ge_og__c = 'Digital Solutions';
        Opp1.tier_3_ge_og__c = 'Bently Nevada';  
        Opp1.StageName='Active - Commit';
        Opp1.Name='Opp1';
        Opp1.CloseDate=Date.Today();
        Opp1.AccountID=acc.Id;
        //Opp1.GE_ES_Last_Allowable_Ship_Date__c = Date.today();
       //Opp1.Expected_Delivery_Date__c = Date.today()+1;
        //Opp1.GE_ES_R_Status__c = 'R0';
       // Opp1.GE_ES_OPPTY_CM__c = 100;
        Opp1.Amount=5000;
        Opp1.StageName='Prospecting';
        Opp1.amount_ge_og__c=1200;
        Insert Opp1;
        
        //GE_HQ_CUST_CREDIT_HIST__c  Cch1= new GE_HQ_CUST_CREDIT_HIST__c(GE_HQ_Acc__c=Acc1.Id,GE_HQ_Cr_Watchlist__c = 'No',GE_HQ_Acct_Cr_Limit__c=0,GE_HQ_Bus_Tier_1__c='P&W');
        GE_HQ_CUST_CREDIT_HIST__c  Cch2= new GE_HQ_CUST_CREDIT_HIST__c(GE_HQ_Acc__c=acc.Id,GE_HQ_Cr_Watchlist__c = 'No',GE_HQ_Acct_Cr_Limit__c=0,GE_HQ_Bus_Tier_1__c='O&G');
 
        //Cch1.GE_HQ_Acc__c=Acc1.id;        
       // Insert Cch1;

        Cch2.GE_HQ_Acc__c=acc.id;        
        Insert Cch2;
        
       // Cch1.GE_HQ_Acct_Cr_Limit__c=null;
       // Update Cch1;
        
        Cch2.GE_HQ_Acct_Cr_Limit__c=null;
        Update Cch2;
                
       // Cch1.GE_HQ_Bus_Tier_1__c='P&W';
        Cch2.GE_HQ_Bus_Tier_1__c='O&G';
       // update Cch1;
        update Cch2;      
       
        
    }
    
}