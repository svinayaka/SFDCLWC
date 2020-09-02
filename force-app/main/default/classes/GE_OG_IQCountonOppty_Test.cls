/*
Test Class Name: GE_OG_IQCountonOppty_Test
Used For :Trigger GE_OG_IQCountonOppty
Purpose/Overview : Test Class to calculate the code coverage for the GE_OG_IQCountonOppty Trigger on iQuote
Functional Area : Opportunity Management
Author: Naveen Vuppu
Created Date: 7/31/2015

Change History -
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
*/

@isTest()
private class GE_OG_IQCountonOppty_Test
{
  @testsetup
    static void createAccount()
    {
      
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
      
      upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
      upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;
            
    }    
    
    Static TestMethod void IQCountonOppty(){
        //Account acc= [select id,name from Account where name='TestClassAccount'];
        Account acc = CommonTestDataFactory_GE_OG.createAccount('TestClassAcc');
        //String MCSRecId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        Opportunity_Split_Account__c splacc = new Opportunity_Split_Account__c();
        splacc.Account_Id__c = acc.id;
        splacc.Region__c = 'Asia';
        splacc.Name = 'Asia';

        insert splacc;
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();

        Opportunity oppty2 = new Opportunity();        
        //oppty2.RecordTypeId =MCSRecId;
        oppty2.Name= 'Test Oppty1';
        oppty2.tier_1_ge_og__c= 'Oil & Gas';
        oppty2.tier_2_ge_og__c='Turbomachinery & Process Solutions';
        oppty2.tier_3_ge_og__c='Opex Contractual';
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
        
        insert oppty2;
        //start: Added and commeneted below for cleanup
        oppty2.amount_ge_og__c =2000.00;
        //oppty2.Opportunity_Splitted__c =True;
        //end: Added and commeneted below for cleanup
        test.startTest();
        update oppty2;
        
        //Test.startTest();
        IFE__iQuote__c iQuote = new IFE__iQuote__c();
        iQuote.IFE__Primary__c = TRUE;
        //iQuote.Name = 'Big Machine Quote Name Test';
        iQuote.IFE__Opportunity__c = oppty2.ID;
        iQuote.IFE__Quote_Status__c = 'Approved';
        //iQuote.BigMachines__Transaction_Id__c = 'Test Transaction Id 01';
       
        insert iQuote;
        //Test.stopTest();
        
    }
}