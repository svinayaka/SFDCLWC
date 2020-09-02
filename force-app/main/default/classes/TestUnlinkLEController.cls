@isTest
public class TestUnlinkLEController{
    public static testMethod void testUncheckCommercialReady(){
        test.startTest();
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'CMF Approved' LIMIT 1].Id;
        String strRecordTypeParentId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Relationship Account' LIMIT 1].Id;
        Account parentAccount = new Account(name='parentTestunlink',type='Direct Customer', Account_Tier_GEOG__c='Country',RecordTypeId=strRecordTypeParentId, Classification__c='Unclassified');
        insert parentAccount;
        Account objTestAccount = new Account(name='unlinkTestAccount', type='Direct Customer', Account_Status__c='CC Approved',Oil_Gas_Parent_Account__c=parentAccount.id,RecordTypeId= strRecordTypeId,Classification__c='Unclassified');
        insert objTestAccount;
        UnlinkLEController.uncheckCommercialReady(objTestAccount.id);
        test.stopTest();
    }
}