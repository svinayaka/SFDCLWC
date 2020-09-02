@isTest
public class LE_Reparenting_Opportunity_GE_OG_test {
    /* @testSetup
static void createTestData(){
account accCountry = new account();
accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
accCountry.name = 'Test Account Country';
accCountry.Account_Tier_GEOG__c = 'Country';
accCountry.Country_GEOG__c = 'INDIA';
accCountry.Classification__c= 'Unclassified';
accCountry.Type = 'Direct Customer';
accCountry.ShippingCountry = 'India';
insert accCountry;

account Globalaccnt= new account();
Globalaccnt.name='accountNameGlobal';
Globalaccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
Globalaccnt.Account_Tier_GEOG__c = 'Global';
Globalaccnt.Classification__c= 'Strategic';
Globalaccnt.Type = 'Direct Customer';
Globalaccnt.ShippingCountry = 'India';
insert Globalaccnt;

account accRegional = new account();
accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
accRegional.name = 'Regional account';
accRegional.Account_Tier_GEOG__c = 'Regional';
accRegional.Country_GEOG__c = 'INDIA';
accRegional.Classification__c= 'Strategic';
accRegional.Type = 'Direct Customer';
accRegional.ShippingCountry = 'India';
accRegional.Member_of_GE_OG__c = Globalaccnt.Id;
accRegional.ParentId = Globalaccnt.Id;
insert accRegional;

Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Test Opty', accCountry.id);


}  */
    public static testMethod void testReparent_Accounts(){
        test.startTest();
        account Globalaccnt= new account();
        Globalaccnt.name='accountNameGlobal';
        Globalaccnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        Globalaccnt.Account_Tier_GEOG__c = 'Global';
        Globalaccnt.Classification__c= 'Strategic';
        Globalaccnt.Type = 'Direct Customer';
        Globalaccnt.ShippingCountry = 'India';
        insert Globalaccnt;
        
        account accCountry2 = new account();
        accCountry2.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountry2.name = 'Test Account Country2';
        accCountry2.Account_Tier_GEOG__c = 'Country';
        accCountry2.Country_GEOG__c = 'INDIA';
        accCountry2.Classification__c= 'Unclassified';
        accCountry2.Type = 'Direct Customer';
        accCountry2.ShippingCountry = 'India';
        insert accCountry2;
        
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Test Opty', Globalaccnt.id);
        List<Opportunity> oppp = new List<Opportunity>();
        oppp.add(opp);
        LE_Reparenting_Opportunity_GE_OG.reParentLEforoppty(oppp, accCountry2);
        test.stopTest();
    }
    public static testMethod void testReparent_Accounts2(){
        test.startTest();
        
        
        account accRegional = new account();
        accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accRegional.name = 'Regional account';
        accRegional.Account_Tier_GEOG__c = 'Regional';
        accRegional.Country_GEOG__c = 'INDIA';
        accRegional.Classification__c= 'Strategic';
        accRegional.Type = 'Direct Customer';
        accRegional.ShippingCountry = 'India';
        insert accRegional;
        
        account accCountry = new account();
        accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account Country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Unclassified';
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
       // accCountry.parentId = accRegional.Id;
        insert accCountry;
        
        account accCountry2 = new account();
        accCountry2.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountry2.name = 'Test Account Country2';
        accCountry2.Account_Tier_GEOG__c = 'Country';
        accCountry2.Country_GEOG__c = 'INDIA';
        accCountry2.Classification__c= 'Unclassified';
        accCountry2.Type = 'Direct Customer';
        accCountry2.ShippingCountry = 'India';
        accCountry2.parentId = accRegional.Id;
        
        insert accCountry2;
        
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Test Opty', accRegional.id);
        List<Opportunity> oppp = new List<Opportunity>();
        oppp.add(opp);
        LE_Reparenting_Opportunity_GE_OG.reParentLEforoppty(oppp, accCountry);
        test.stopTest();
    }
    
}