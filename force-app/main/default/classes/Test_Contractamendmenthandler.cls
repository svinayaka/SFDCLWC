@isTest
private class Test_Contractamendmenthandler {

    static testMethod void runPositiveTestCases() {
        
        Id crtype = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Contract').getRecordTypeId();
        Account a  = AccountTestDataFactory.createAccount('raccount');
        Account le = AccountTestDataFactory.createInternalLegalEntity('LEAccount');
        le.Member_of_GE_OG__c =  a.Id;
        update le;
        
        Contract c= new contract();
        c.Name ='test' ;
        c.Recordtypeid=crtype ;
        c.Region_GEOG__c = 'Asia Pacific' ;
        c.Commercial_Account_Name_GEOG__c = a.Id;
        //c.SubRegion_GEOG__c = 'US Central' ;
        c.AccountId = le.Id;
        c.Country_GEOG__c = 'ALBANIA';
        c.GE_Legal_Entities__c = le.Id;
        c.Industry_GEOG__c = 'Conventional hydrocarbons';
        c.Customer_Contract_Number_GEOG__c ='345676890';
        c.Sub_Industry_GEOG__c = 'Deepwater - Gas';
        c.GE_PRM_Business_Tier_1__c = 'Oil & Gas';
        c.GE_PRM_Tier_2__c ='Subsea & Drilling';
        //c.Tier3_PandL_GEOG__c = 'Chemicals';
        c.Status = 'Pending';
        c.GE_MCS_Contract_Amount__c = 12;
        c.StartDate = Date.newInstance(2017,4,13);
        c.ContractTerm =1;
        c.Expiration_Alert_Days_GEOG__c = 60;
        insert c;
        
        Contract_Amendment_GEOG__c ca = new Contract_Amendment_GEOG__c();
        ca.Contract_GEOG__c = c.id;
        ca.Type_GEOG__c ='Extension';
        ca.Effective_Date_GEOG__c =Date.newInstance(2017,6,20);
        ca.Expiration_date_GEOG__c =Date.newInstance(2017,7,3);
        insert ca;
        
        ca.Expiration_date_GEOG__c = Date.newInstance(2017,7,16);
        update ca;
        
        delete ca;
      
    } // runPositiveTestCases()
    
}