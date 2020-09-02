/*
Class/Trigger Name     : OpportunityCustomerLE_GE_OG_Test
Used Where ?           : OpportunityCustomerLegalEntity_GE_OG
Purpose/Overview       : Test class for OpportunityCustomerLegalEntity_GE_OG
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23662
Author                 : Sanath Kumar Dheram
Created Date           : 25/NOV/2015      
Code Coverage          : 
*/

@isTest
public class OpportunityCustomerLE_GE_OG_Test 
{
    @testsetup
    static void createRecord()
    {
        List<Account> lstAccount = new List<Account>();
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account Global';
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        insert acc;
        
        system.assertNotEquals(Null,acc.ID);
        system.assertEquals('Test Account Global',acc.Name);
        
        
        
        //Creating new account
        account accRegional = new account();
        accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accRegional.name = 'Test Account Regional';
        accRegional.Account_Tier_GEOG__c = 'Regional';
        accRegional.Country_GEOG__c = 'INDIA';
        accRegional.Classification__c= 'Strategic';
        accRegional.Type = 'Competitor';
        accRegional.ShippingCountry = 'India';
        accRegional.Member_of_GE_OG__c = acc.Id;
        accRegional.ParentId = acc.Id;
        insert accRegional;
        
        //Creating new account
        account accRegionalwoC = new account();
        accRegionalwoC.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accRegionalwoC.name = 'Test Relationship Account without competitor';
        accRegionalwoC.Account_Tier_GEOG__c = 'Regional';
        accRegionalwoC.Country_GEOG__c = 'INDIA';
        accRegionalwoC.Classification__c= 'Strategic';
        accRegionalwoC.Type = 'EPC';
        accRegionalwoC.ShippingCountry = 'India';
        //accRegionalwoC.Member_of_GE_OG__c = acc.Id;
        //accRegionalwoC.ParentId = acc.Id;
        insert accRegionalwoC;
        
        
        
        
        
        //Creating new account
        account accCountry = new account();
        accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account Country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Strategic';
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
        accCountry.Member_of_GE_OG__c = acc.Id;
        accCountry.ParentId = accRegional.Id;
        insert accCountry;
        
        
        account accLE = new account();
        accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Classification__c= 'Strategic';
        accLE.Type = 'Direct Customer';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        accLE.Member_of_GE_OG__c = acc.Id;
        accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
        insert accLE;
        
        
        /*account accCon1 = new account();
        accCon1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCon1.name = 'Test Account LE';
        accCon1.Account_Tier_GEOG__c = 'Country';
        accCon1.Oil_Gas_Parent_Account__c = accCountry.Id;
        accCon1.Country_GEOG__c = 'INDIA';
        accCon1.Classification__c= 'Strategic';
        accCon1.Type = 'Competitor';
        accCon1.ShippingCountry = 'India';
        accCon1.Account_Status__c = 'CC Approved';
        accCon1.Member_of_GE_OG__c = acc.Id;
        accCon1.Oil_Gas_Parent_Account__c = accCountry.Id;
        insert accCon1;
        
        
        account accLE1 = new account();
        accLE1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accLE1.name = 'Test Account LE';
        accLE1.Account_Tier_GEOG__c = 'LE';
        accLE1.Oil_Gas_Parent_Account__c = accCountry.Id;
        accLE1.Country_GEOG__c = 'INDIA';
        accLE1.Classification__c= 'Strategic';
        accLE1.Type = 'Competitor';
        accLE1.ShippingCountry = 'India';
        accLE1.Account_Status__c = 'CC Approved';
        accLE1.Member_of_GE_OG__c = acc.Id;
        accLE1.Oil_Gas_Parent_Account__c = accCon1.Id;
        insert accLE1;*/
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();

        
        
        opportunity opp = new opportunity();
        opp.name= 'TestOppty';
        opp.stageName = 'Prospecting';
        //opp.region_ge_og__c = 'Middle East / North Africa';
        opp.closedate = system.today().addDays(30);
        opp.accountId = accRegionalwoC.id;
        opp.end_user_ge_og__c= accLE.id;
        opp.install_country_ge_og__c= 'ALGERIA';
        opp.amount_ge_og__c = 25.0;
        opp.tier_1_ge_og__c = 'Oil & Gas';
        //Changing from Measurement & Control to Digital Solutions and Tier 3 to Bently Nevada
        opp.tier_2_ge_og__c = 'Digital Solutions';
        opp.tier_3_ge_og__c = 'Bently Nevada';
        opp.tier_4_ge_og__c = 'Flow';
        //insert opp;
    }
    
    public static testMethod void testCustomerLegalEntityOnOpportunity()
    {
        //Fetching Dummy Account created above
        /*Account accGlobal = [select id from account where name='Test Account Global' limit 1];
        Account accCountry = [select id from account where name='Test Account Country'];
        Account accLE = [select id from account where name='Test Account LE'];
        //Account accRegional = [select id from account where name='Test Account Regional'];
        */
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('Test Account');
        //Account acccountry = [select id, Name from account where name = 'Test Account Country'];
        
        /***************/
        Account accLE = [select id, Name from account where name = 'Test Account LE'];
        //system.assertEquals('Test Relationship Account without competitor',accRegionalwoC.Name);
        Test.startTest();
        /*******/
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
       
        opportunity opp = new opportunity();
        opp.name= 'TestOppty';
        opp.stageName = 'Prospecting';
        //opp.region_ge_og__c = 'Middle East / North Africa';
        opp.closedate = system.today().addDays(30);
        opp.accountId = acc1.id;
        opp.end_user_ge_og__c= accLE.id;
        opp.install_country_ge_og__c= 'ALGERIA';
        opp.amount_ge_og__c = 25.0;
        opp.tier_1_ge_og__c = 'Oil & Gas';
        //Changing from Measurement & Control to Digital Solutions and Tier 3 to Bently Nevada, Tier 4 to Software
        opp.tier_2_ge_og__c = 'Digital Solutions';
        opp.tier_3_ge_og__c = 'Bently Nevada';
        opp.tier_4_ge_og__c = 'Software';
        insert opp;
        
        
        //Fetching opportunity 
        Opportunity oppty = [select id,AccountId,legal_entity_ge_og__c,Account_member_of_ge_og__c   from opportunity where AccountId =: acc1.Id];
        //Changing from Measurement & Control to Digital Solutions
        oppty.tier_2_ge_og__c = 'Digital Solutions';
        update oppty;
        
        Test.stopTest();
    }
}