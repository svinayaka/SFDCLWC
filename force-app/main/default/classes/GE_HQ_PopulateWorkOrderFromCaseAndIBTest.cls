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
private class GE_HQ_PopulateWorkOrderFromCaseAndIBTest {

    static testMethod void myUnitTest() {
        
        RecordType rt = [SELECT Id, Name FROM RecordType WHERE sObjectType = 'Case' AND Name = 'FS-PGS' LIMIT 1];
        Set<String> countrySet= new Set<String>();       
                
        GE_Installed_Base__c ib = new GE_Installed_Base__c();
        ib.name='234test';
        insert ib;
        Case c = new Case(
          RecordTypeId = rt.Id,
          GE_SM_HQ_Nbr_Shifts__c = '5',
          GE_SM_HQ_City__c='test'
        );
        c.GE_SM_HQ_Region__c='Asia';
        c.GE_SM_HQ_Business_Unit__c='FS';
        
        insert c;
        
        Test.startTest();
        
        SVMXC__Service_Group_Skills__c Expertise=[select id,SVMXC__Skill__c from SVMXC__Service_Group_Skills__c where SVMXC__Skill__c!=null limit 1];
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(
            SVMXC__Case__c = c.Id,SVMXC__Skill__c=Expertise.SVMXC__Skill__c,SVMXC__Country__c = 'testcountry1'
        );
        //wo.GE_SM_HQ_Installed_Base__c = ib.id ;         
        wo.SVMXC__Street__c = null;
        //wo.GE_SM_HQ_Region__c=c.GE_SM_HQ_Region__c;
        //wo.GE_SM_HQ_Business_Unit__c=c.GE_SM_HQ_Business_Unit__c;
        wo.SVMXC__Country__c = 'testcountry';
        
        wo.GE_SM_HQ_Site_FE_TA_TelNo__c = c.GE_SM_HQ_Site_FE_TA_TelNo__c;
        //wo.GE_SM_HQ_OnSite_End__c = c.GE_SM_HQ_OnSite_End__c;
        //wo.GE_SM_HQ_OnSite_Start__c = c.GE_SM_HQ_OnSite_Start__c;
        wo.GE_SM_HQ_SM_Name__c = c.GE_SM_HQ_Service_Request_Owner__r.Name;
        //wo.GE_SM_HQ_SM_Email__c = c.GE_SM_HQ_Service_Request_Owner__r.Email;
        //wo.GE_SM_HQ_SM_TelNo__c = c.GE_SM_HQ_Service_Request_Owner__r.Phone;         
        wo.SVMXC__City__c =c.GE_SM_HQ_City__c;
        
        
        insert wo;
        wo.SVMXC__Street__c ='test';
        update wo;
        wo = [SELECT Id FROM SVMXC__Service_Order__c WHERE Id = :wo.Id LIMIT 1];
        
        
        
        Test.stopTest();
    }
}