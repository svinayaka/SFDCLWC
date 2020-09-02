/* test class for OG_FA_ContractSummary_Share */
@isTest
private class  OG_FA_ContractSummary_Share_Test
{
    static testMethod void testOG_FA_ContractSummary_Share()
        {
        List<Contract_Summary__c> contractSummList = new List<Contract_Summary__c>();
        List<Contract> contractList = new List<Contract>();
        List<Contract> contractExtractList = new List<Contract>();
        Set<Id> conIds = new Set<Id>();
        Id conId ;
        String rt = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Master Frame Agreement').getRecordTypeId();
        //Account acc = [select id from Account where name = 'TestClassAccount' limit 1];
        Date startDate = Date.newInstance(2013,10,09);
        Date endDate = Date.newInstance(2013,12,09);
        //User user = [select Id , Name , GE_HQ_Tier_2_P_L__c from User where Id = '005A00000014IRG'];
        Account acc = New Account( Name='TestClassAccount');
        insert acc;
        
    Contract contr = new Contract(Name='testSh' , RecordTypeId= rt, AccountId= acc.Id , GE_OG_FA_Type__c= 'Discount' ,Status='Draft', GE_PRM_Business_Tier_1__c= 'Oil & Gas (O&G)' ,GE_HQ_Buss_Tier1__c= 'Measurement & Control (M&C)' ,   GE_OG_Legal_Entity__c='Australia' , StartDate= startDate  ,GE_OG_Contract_End_Date__c = endDate , GE_FA_Applicable_Products_Services__c='Products' ,GE_OG_Standard_Warranty__c= 'Y' , GE_OG_Warranty_Timeframe__c= 4 , GE_OG_Governing_Law__c='b' ,GE_OG_Dispute_Resolution_Arbitration__c= 'Y' ,GE_OG_Dispute_Resolution_Description__c= 'eg1' , GE_OG_Mutual_Confidentiality__c='Y' ,GE_OG_Confidentiality_duration_years__c= 4 ,GE_OG_Limitation_of_liability__c= 'All Claims( contract & tort)' ,GE_OG_Limitation_of_Liability_amount__c= '4' ,GE_OG_3rd_Party_Indemnity__c= 'Negligence based' ,GE_OG_Other_Indemnity__c='Pollution' , Exclusion_of_Consequential_Damages_incl__c='y');
    insert contr;
    
    contractExtractList = [Select Id from Contract where Id =: contr.Id];
    if(contractExtractList.size()>0)
    {
    for(Contract conItr : contractExtractList)
    {
    conId = conItr.Id ;
    }
    }
     Contract_Summary__c contractSumm = new Contract_Summary__c(Name = 'TestCSShareTrigger' ,   GE_Contract_Name__c = conId);
       insert contractSumm ;
       
       contractSummList= [Select Id , GE_Contract_Name__c from Contract_Summary__c where Id =:contractSumm.Id];  
        
        if(contractSummList.size()>0)
        {
        for(Contract_Summary__c cSum : contractSummList)
        {
        conIds.add(cSum.Id);
        }
        contractList = [Select Id , Name from Contract where Id IN : conIds];
        if(contractList.size() > 0)
        {
        }
        }
    }
}