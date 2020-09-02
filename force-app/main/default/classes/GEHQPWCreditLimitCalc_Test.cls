@isTest
Private class GEHQPWCreditLimitCalc_Test{
    Static testMethod void GEHQPWCreditLimitCalc_Test(){
    
        account Acc1 = new account();
        Acc1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        Acc1.Name = 'accname';
        Acc1.Account_Tier_GEOG__c = 'Country';
        Acc1.Country_GEOG__c = 'USA';
        Acc1.Classification__c= 'Strategic';
        Acc1.BillingCountry = 'USA';
        Acc1.ShippingCountry = 'USA';
        Acc1.GE_HQ_DUNS_Number__c='555126948';
        Acc1.GE_ES_Primary_Industry__c = 'ABC';
        Acc1.ShippingState = 'AT';
        Acc1.ShippingCity = 'TestShipping City';
        Acc1.ShippingStreet = 'Test Shipping Street';
        Acc1.ShippingPostalCode = '101010';
        Acc1.Type = 'Direct Customer';
        Acc1.Classification__c = 'Strategic';
        insert Acc1 ;
        
        OG_Trigger_fire_Decision__c tfd = new OG_Trigger_fire_Decision__c();
        tfd.isActive__c = true;
        tfd.Object_Name__c = 'Account' ;
        tfd.Trigger_Name__c = 'GE_OG_InsertTeamMember' ;
        tfd.name = 'GE_OG_InsertTeamMember';
        insert tfd;
        
        OG_Trigger_fire_Decision__c tfd1 = new OG_Trigger_fire_Decision__c();
        tfd1.isActive__c = true;
        tfd1.Object_Name__c = 'Account' ;
        tfd1.Trigger_Name__c = 'GE_OG_Update_FinanceUpdateStatus' ;
        tfd1.name = 'GE_OG_Update_FinanceUpdateStatus';
        insert tfd1;
        
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();

        Opportunity Opp1 = new Opportunity();
        Opp1.tier_1_ge_og__c ='Oil & Gas';
        Opp1.tier_2_ge_og__c = 'Digital Solutions';
        Opp1.StageName='Prospecting';
        Opp1.Name='Opp1';
        Opp1.CloseDate=Date.Today();
        Opp1.AccountID=Acc1.Id;
        //Opp1.GE_ES_Last_Allowable_Ship_Date__c = Date.today();
        Opp1.amount_ge_og__c =1000.00;
        //Opp1.GE_ES_R_Status__c = 'R0';
        Opp1.tier_2_ge_og__c ='Digital Solutions';
        Opp1.tier_3_ge_og__c ='Bently Nevada';
        Opp1.Amount=5000;
        Insert Opp1;
        
        GE_HQ_CUST_CREDIT_HIST__c  Cch1= new GE_HQ_CUST_CREDIT_HIST__c(GE_HQ_Acc__c=Acc1.Id,GE_HQ_Cr_Watchlist__c = 'No',GE_HQ_Acct_Cr_Limit__c=0,GE_HQ_Bus_Tier_1__c='P&W');
        GE_HQ_CUST_CREDIT_HIST__c  Cch2= new GE_HQ_CUST_CREDIT_HIST__c(GE_HQ_Acc__c=Acc1.Id,GE_HQ_Cr_Watchlist__c = 'No',GE_HQ_Acct_Cr_Limit__c=0,GE_HQ_Bus_Tier_1__c='O&G');
 
        Cch1.GE_HQ_Acc__c=Acc1.id;        
        Insert Cch1;

        Cch2.GE_HQ_Acc__c=Acc1.id;        
        Insert Cch2;
        
        Cch1.GE_HQ_Acct_Cr_Limit__c=null;
        Update Cch1;
        
        Cch1.GE_HQ_Acct_Cr_Limit__c=null;
        Update Cch2;
                
        Cch1.GE_HQ_Bus_Tier_1__c='P&W';
        Cch2.GE_HQ_Bus_Tier_1__c='O&G';
        update Cch1;
        update Cch2;      
       
        
    }
}