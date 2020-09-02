/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class GE_HQ_PopulateCaseFromInstalledBaseTest {

    static testMethod void myUnitTest() {
        
        
        GE_Installed_Base__c ib = new GE_Installed_Base__c(
            Name = 'test',
            GE_ES_Station_Name__c = 'testName'
        );
        insert ib;
        
        Test.startTest();
        
        RecordType rt = [SELECT Id, Name FROM RecordType WHERE sObjectType = 'Case' AND Name = 'FS-PGS' LIMIT 1];
        
        Case c = new Case(
          Installed_Base__c = ib.Id,
          RecordTypeId = rt.Id,
          GE_ES_Sub_Type__c = 'RFQ processing',
        GE_ES_Customer_Request_Date__c = Date.Today().adddays(20)
  
        );
        
        insert c;
        
        c = [SELECT Id, GE_SM_HQ_Site_Name__c FROM Case WHERE Id = :c.Id LIMIT 1];
        
//        system.assertEquals(ib.GE_ES_Station_Name__c, c.GE_SM_HQ_Site_Name__c);
        
        Test.stopTest();
    }
}