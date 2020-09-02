/*
=====================================
testclass  : GE_ES_ContactGalaxyIntegrationTest
Created On : 17 Sept 2018 to meet te coverage for.."ContactGalaxyIntegrationWrapper" classs

=====================================
*/

@isTest
public class GE_ES_ContactGalaxyIntegrationTest {
    @testsetup
    static void createRecord()
    {
        
        // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        
        //Createing an Account 
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        //Createing an Account
        Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('TestAccount Legal',acc.ID,acc1.ID);
        system.assertEquals('TestAccount Legal',accLE.Name);
    }
    
    
    public static testMethod void testOpportunityStages1(){
       
        
        
        Account accLE = [select id from account where name='TestAccount Legal'];
        
        contact objcont = new contact();
        objcont.Email = 'test@sfdc.com';
        objcont.accountid =  accLE.id;
        objcont.firstname = 'test';
        objcont.lastname = 'test';
        objcont.GE_OG_Contact_Audience__c = 'Field Service';
        objcont.GE_HQ_SFDC_Legacy_Id__c='random id';
        insert objcont;
        
           contact objcont1 = new contact();
        objcont1.Email = 'test@sfdc1.com';
        objcont1.accountid =  accLE.id;
        objcont1.firstname = 'test';
        objcont1.lastname = 'test1';
        objcont1.GE_OG_Contact_Audience__c = 'Field Service';
        //objcont.GE_HQ_SFDC_Legacy_Id__c='random id';
        
        insert objcont1;
    
    }
    
}