@isTest
public class oppAmountSummation_Asset_Project_Test {
	static testMethod void oppAmountSummation_Asset_Project_Test(){
     
        Account acc1 = new Account();
        acc1.name='test';
        acc1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc1.Classification__c= 'Key Account' ;
        acc1.type = 'Direct Customer';
        acc1.Account_Tier_GEOG__c  = 'Regional';
        insert acc1;
        
		Asset asset1 = CommonTestDataFactory_GE_OG.createAsset('Test Asset');
        insert asset1;
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        
        Project_ge_og__c objProject = new Project_ge_og__c();
        objProject.Name = 'TestProject1';
        objProject.GE_OG_SS_First_Oil_Date__c = Date.today();
        objProject.project_account_ge_og__c = acc1.id;
        objProject.RecordTypeId = Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('O&G Project').getRecordTypeId();
        insert objProject;

        List<Opportunity> opp = new List<Opportunity>();
        Opportunity Opp1 = new Opportunity();
        Opp1.tier_1_ge_og__c ='Oil & Gas';
        Opp1.tier_2_ge_og__c = 'Digital Solutions';
        Opp1.StageName ='Prospecting';
        Opp1.Name ='Opp Test';
        Opp1.CloseDate =Date.Today();
        Opp1.AccountID = acc1.Id;
        Opp1.amount_ge_og__c = 1000;
        Opp1.tier_2_ge_og__c ='Digital Solutions';
        Opp1.tier_3_ge_og__c ='Bently Nevada';
        Opp1.Amount = 1000;
        Opp1.CurrencyIsoCode = 'USD';
        Opp1.opportunity_project_ge_og__c = objProject.id;
        Opp1.Opportunity_Asset_ge_og__c	 = asset1.Id;
        Opp1.Oppty_Dummy_Update_ge_og__c = 'testing';
        opp.add(Opp1);
        insert opp;
        
        //Opp1.amount_ge_og__c = 2000;
        Opp1.Oppty_Dummy_Update_ge_og__c = 'test';
        update Opp1;
        opp.add(Opp1);
        
		Test.startTest();
        oppAmountSummation_Asset_Project obj = new oppAmountSummation_Asset_Project();
        test.stopTest();
    }
}