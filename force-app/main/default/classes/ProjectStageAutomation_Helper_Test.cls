/*
Class/Trigger Name     : ProjectStageAutomation_Helper
Purpose/Overview       : Test Class to calculate the code coverage for the ProjectStageAutomation_Helper Class               
Requirement Number     : R-31184
Author                 : Harsha C
Created Date           : 02-Feb-2019
Used For               : ProjectStageAutomation_Helper - 
*/
@IsTest
public class ProjectStageAutomation_Helper_Test {
    
    @testsetup
    static void createRecord()
    {
        
        //creating 'Country Region Mapping' for 'INDIA'
        Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
        //Country_Region_Mapping_ge_og__c objcust = CommonTestDataFactory_GE_OG.createCountryRegionMappingData('1','RUSSIAN FEDERATION','TT','RUSSIAN FEDERATION','Active');
        insert objcustom;
        // insert objcust;
        
        /* Create Opportunity Reason Code Custom Setting */
        List<Opportunity_Primary_Reason_Has_Code__c> lstReasonCode = CommonTestDataFactory_GE_OG.createPrimaryReasonCustomSetting();
        insert lstReasonCode;
        
        test.startTest();
        // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        //Createing an Account 
        
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        //Create Test Account for ContactSumTrigger
        String TestAccountName = system.Label.Test_Account_Name;
        // Account testacc = CommonTestDataFactory_GE_OG.createCommercialParentAccount(TestAccountName); commetned by kiru
        
        
        //Creating an Opportunity
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',opp.Name);
        
        // Opportunity oppofs = CommonTestDataFactory_GE_OG.createOpptyForTPS('Testopportunity tps',acc1.Id);
        //Creating a Product
        //
        
        Test.stopTest();
    }
    
    public static testMethod void testOpportunityStages1(){
        test.startTest(); 
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member'); 
        Opportunity oppofs = CommonTestDataFactory_GE_OG.createOpptyForTPS('Testopportunity tps',acc.Id);
        
       // Account accLE = [select id from account where name='TestAccount Legal'];
        //Account internalLe = [Select id,Name from Account where Name = 'TestAccount Internal'];
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        
        List<Opportunity> oplist = new List<Opportunity>();
        
        User u1 = new User(Alias = 'standt', Email='standarduser@testorg.com',
                           EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles', UserName='grvAnan123@testorg.com');
        insert u1;
        
        /*  contact objcont = new contact();
objcont.Email = 'test@sfdc.com';
objcont.accountid =  accLE.id;
objcont.firstname = 'test';
objcont.lastname = 'test';
objcont.GE_OG_Contact_Audience__c = 'Field Service';
objcont.GE_HQ_SFDC_Legacy_Id__c='random id';
insert objcont;*/
        
        
        
         Opportunity opp = [Select Id,Name from Opportunity where Name = 'Testopportunity' limit 1];
         Project_ge_og__c prj  = new Project_ge_og__c();
        prj.recordtypeid= Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('Joint Pursuit Project').getRecordTypeId();
        prj.name = 'Test1';
        prj.Project_Summary_ge_og__c = 'Test1';
        prj.project_account_ge_og__c = acc.id;
        prj.Estimated_Value_ge_og__c = 10;
        prj.project_Install_Country_ge_og__c = 'INDIA';
        prj.Fullstream_Type_ge_og__c = 'Integrated Projects';
        prj.Project_type_ge_og__c= 'Brownfield';
        prj.hasScopeofwork_ge_og__c = true;
        Insert prj;
        
        oppofs.opportunity_project_ge_og__c = prj.Id;
        oplist.add(oppofs);
        opp.opportunity_project_ge_og__c = prj.id;
        oplist.add(opp);
        
        update oplist;
        test.stopTest();
        
        
        
    }
    
    public static testMethod void testProjectautomation(){
        Account acc = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        test.startTest(); 
        Project_ge_og__c prj  = new Project_ge_og__c();
        prj.recordtypeid= Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('Joint Pursuit Project').getRecordTypeId();
        prj.name = 'Test1';
        prj.Project_Summary_ge_og__c = 'Test1';
        prj.project_account_ge_og__c = acc.id;
        prj.Estimated_Value_ge_og__c = 10;
        prj.project_Install_Country_ge_og__c = 'INDIA';
        prj.Fullstream_Type_ge_og__c = 'Integrated Projects';
        prj.Project_type_ge_og__c= 'Brownfield';
        prj.hasScopeofwork_ge_og__c = true;
        Insert prj;
        
        
        //User u = [Select Id from User where LastName='last'];
     /*   List<Opportunity> updateList = new List<Opportunity>();
        List<Opportunity> optyList = [Select Id,Name from Opportunity where Name In ('TestOppty','TestOppty 2')];
        for(Opportunity op : optyList){
            op.opportunity_project_ge_og__c = prj.Id;
            updateList.add(op);
        }
        update updateList;*/
        ProjectStageAutomation_Helper.testMethodforcode();
        Test.stopTest();
        
    }
    
}