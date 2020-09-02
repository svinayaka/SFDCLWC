@isTest
private class  OG_FA_ContractSummary_Display_Test
{
    static testMethod void testOG_FA_ContractSummary_Display()
    {
    Test.startTest();
    Account acc = new Account(name='test');
        Insert acc;
        String rt = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Master Frame Agreement').getRecordTypeId();
        String AddendumIdRT = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        String MasterIdRT = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        Group grp = [SELECT id ,Name from Group where Name like 'OG FA%' Limit 1];
        Business_And_Group_Name__c bg = New Business_And_Group_Name__c();
        bg.Business_Name__c = 'test';
        bg.Group_Name__c='OG FA DS Readonly Group';
        insert bg;
        Contract c = new Contract(Name='testSh' , RecordTypeId= AddendumIdRT, AccountId= acc.Id ,GE_HQ_Buss_Tier1__c='M&C');
        contract contr = c.clone(false,false);
        contr.GE_OG_Evergreen__c = true;
        contr.AccountId = acc.id;
        contr.recordtypeid=AddendumIdRT;
        insert contr;
        Contract_Summary__c cSum = new Contract_Summary__c(Name='TestContract', GE_Are_there_carve_to_the_LOL__c='IP', GE_Conse_Damages_exclu__c='Yes');
        insert cSum;
        cSum.GE_Contract_Name__c = contr.id;
        update cSum;
        Test.stopTest();
        contr.Name='test1';
        Update contr;
        }
    }