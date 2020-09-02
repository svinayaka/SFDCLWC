@isTest
public class ReparentingRequestTriggerHandler_Test
{
    static TestMethod void testmethod1(){
        account accCountry = new account();
        accCountry.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account Country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Unclassified';
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
        //accCountry.Member_of_GE_OG__c = acc.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountry;
        
        account accCountryNew = new account();
        accCountryNew.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountryNew.name = 'Test Account Country New';
        accCountryNew.Account_Tier_GEOG__c = 'Country';
        accCountryNew.Country_GEOG__c = 'INDIA';
        accCountryNew.Classification__c= 'Unclassified';
        accCountryNew.Type = 'Direct Customer';
        accCountryNew.ShippingCountry = 'India';
        //accCountryNew.Member_of_GE_OG__c = acc.Id;
        //accCountryNew.ParentId = accRegional.Id;
        insert accCountryNew;
        
        /*List<Account> lstCountries = new List<Account>();
        lstCountries.add(accCountry);
        lstCountries.add(accCountryNew);
        insert lstCountries;*/
        
        account accLE = new account();
        accLE.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Type = 'Direct Customer';
        accLE.Classification__c = 'Do Not Contact';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        //accLE.Member_of_GE_OG__c = acc.Id;
        insert accLE;
        
        Re_Parenting_LE_Request__c req = new Re_Parenting_LE_Request__c();
        req.Request_Status__c = 'Pending';
        req.Legal_Entity__c = accLE.id;
        req.Old_Parent_Account__c = accCountry.id;
        req.New_Parent_Account__c = accCountryNew.id;
        insert req;
        Re_Parenting_LE_Request__c request = [Select Id, Request_Status__c From Re_Parenting_LE_Request__c Where Id =: req.Id ];
        request.Request_Status__c = 'Completed';
        update request;
        
}


static TestMethod void testmethod2(){
        Id adendumdRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
        Id ammendRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();
        Id masterRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
		
		account accCountryHQ = new account();
        accCountryHQ.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountryHQ.name = 'Test Account OLD HQ';
        accCountryHQ.Account_Tier_GEOG__c = 'Global';
        accCountryHQ.Country_GEOG__c = 'INDIA';
        accCountryHQ.Classification__c= 'Unclassified';
        accCountryHQ.Type = 'Direct Customer';
        accCountryHQ.ShippingCountry = 'India';
        //accCountry.Member_of_GE_OG__c = acc.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountryHQ;
		
		account accCountry = new account();
        accCountry.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account old country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Unclassified';
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
        accCountry.Member_of_GE_OG__c = accCountryHQ.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountry;
        
		
		account accCountryHQ2 = new account();
        accCountryHQ2.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountryHQ2.name = 'Test Account new hq';
        accCountryHQ2.Account_Tier_GEOG__c = 'Global';
        accCountryHQ2.Country_GEOG__c = 'INDIA';
        accCountryHQ2.Classification__c= 'Unclassified';
        accCountryHQ2.Type = 'Direct Customer';
        accCountryHQ2.ShippingCountry = 'India';
        //accCountry.Member_of_GE_OG__c = acc.Id;
        //accCountry.ParentId = accRegional.Id;
        insert accCountryHQ2;
		
		
		
        account accCountryNew = new account();
        accCountryNew.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        accCountryNew.name = 'Test Account Countrynew';
        accCountryNew.Account_Tier_GEOG__c = 'Country';
        accCountryNew.Country_GEOG__c = 'INDIA';
        accCountryNew.Classification__c= 'Unclassified';
        accCountryNew.Type = 'Direct Customer';
        accCountryNew.ShippingCountry = 'India';
        accCountryNew.Member_of_GE_OG__c = accCountryHQ2.Id;
        //accCountryNew.ParentId = accRegional.Id;
        insert accCountryNew;
        
        /*List<Account> lstCountries = new List<Account>();
        lstCountries.add(accCountry);
        lstCountries.add(accCountryNew);
        insert lstCountries;*/
        
        account accLE = new account();
        accLE.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Type = 'Direct Customer';
        accLE.Classification__c = 'Do Not Contact';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        //accLE.Member_of_GE_OG__c = acc.Id;
        insert accLE;
		
		Contract conMaster =  new Contract();
		conMaster.RecordTypeId = masterRecordTypeId;
		conMaster.AccountId = accLE.Id;
		conMaster.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
		conMaster.GE_PRM_Commercial_Account__c = accCountry.Id;
		conMaster.Status = 'Executed';
		conMaster.ContractTerm = 12;
		insert conMaster;
		
		Contract conadd =  new Contract();
		conadd.RecordTypeId = adendumdRecordTypeId;
		conadd.AccountId = accLE.Id;
		conadd.GE_Commercial_Member_Of_GE_OG__c = accCountryHQ.Id;
		conadd.GE_PRM_Commercial_Account__c = accCountry.Id;
		conadd.Status = 'Generate Draft';
		conadd.PRM_Master_Agreement__c = conMaster.Id;
		conadd.ContractTerm = 12;
		insert conadd;
		
        
        Re_Parenting_LE_Request__c req = new Re_Parenting_LE_Request__c();
        req.Request_Status__c = 'Pending';
        req.Legal_Entity__c = accLE.id;
        req.Old_Parent_Account__c = accCountry.id;
        req.New_Parent_Account__c = accCountryNew.id;
        insert req;
        Re_Parenting_LE_Request__c request = [Select Id, Request_Status__c From Re_Parenting_LE_Request__c Where Id =: req.Id ];
        request.Request_Status__c = 'Completed';
        update request;
        
}




}