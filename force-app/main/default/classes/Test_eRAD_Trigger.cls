/*
    Class/Trigger Name     : Test_eRAD_Trigger
    Purpose/Overview       : Test Class to calculate the code coverage eRAD creation 
                             for OpportunityTrigger_GE_OG Trigger helper class
    Scrum Team             : Transformation - OPPTY MGMT
    Requirement Number     : R-23281
    Author                 : Nitish Pandey
    Created Date           : 17-Sep-2015
    Used For               : 
*/ 

@isTest
public class Test_eRAD_Trigger 
{

        @testsetup
        static void createRecord()
        {
             Test.startTest();
            //creating 'Country Region Mapping' for 'INDIA'
           Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
           insert objcustom;
           
           /* Create Opportunity Reason Code Custom Setting */
           List<Opportunity_Primary_Reason_Has_Code__c> lstReasonCode = CommonTestDataFactory_GE_OG.createPrimaryReasonCustomSetting();
           insert lstReasonCode;
           
           
           // Create Member Account
           Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
           system.assertEquals('TestAccount Member',acc1.Name);
           
           //Createing an Account 
           Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
           system.assertEquals('TestAccount Relation',acc.Name);
            
           //Create Test Account for ContactSumTrigger
           // String TestAccountName = system.Label.Test_Account_Name;
           // Account testacc = CommonTestDataFactory_GE_OG.createCommercialParentAccount(TestAccountName);
            
           
           // Account accmem = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccount Relation 1');
           // system.assertEquals('TestAccount Relation 1',accmem.Name);
           
           //Createing an Account
           Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('TestAccount Legal',acc.ID,acc1.ID);
           system.assertEquals('TestAccount Legal',accLE.Name);
           
           // Create Legal Account with Type 'Internal' 
           //Account accInternal = CommonTestDataFactory_GE_OG.createInternalLegalEntity('TestAccount Internal');
           //system.assertEquals('TestAccount Internal',accInternal.Name);
           
           //Creating an Opportunity
          opportunity opp1 = CommonTestDataFactory_GE_OG.createOppty('Testopportunity', acc.Id);
        
         Test.stopTest();   
           
       }
  
    public static testMethod void Test_eRAD_Trigger()
    {
    test.startTest();
       // Opportunity oppty = [select id from Opportunity where tier_2_ge_og__c = 'Subsea (SS)' and StageName = 'Closed Won' LIMIT 1];
        //Opportunity oppty = [select id from Opportunity where tier_2_ge_og__c = 'Subsea & Drilling' and StageName = 'Closed Won' LIMIT 1];
         Account accLE = [select id from account where name='TestAccount Legal'];
              
           /* contact objcont = new contact();
            objcont.Email = 'test@sfdc.com';
            objcont.accountid =  accLE.id;
            objcont.firstname = 'test';
            objcont.lastname = 'test';
            insert objcont; */
            
            Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
        	Id subseaId = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId();
        	Id tmscsaID = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - CSA').getRecordTypeId();
        	Id tmsNewID = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS New Units/Opex').getRecordTypeId();
        
            eRAD__c radRec1 = eradcreate('Active Bid',subseaId,oppty.id);
            eRAD__c radRec2 = eradcreate('Sales mode',subseaId,oppty.id);
            eRAD__c radRec3 = eradcreate('Active Bid',tmscsaID,oppty.id);
            eRAD__c radRec4 = eradcreate('Sales mode',tmscsaID,oppty.id);
            eRAD__c radRec5 = eradcreate('Active Bid',tmsNewID,oppty.id);
            eRAD__c radRec6 = eradcreate('Sales mode',tmsNewID,oppty.id);
            radRec6.status__c = 'Approved';
            update radRec6;
            radRec2.Approval_Status__c = 'Submit For Approval';
            update radRec2;
            radRec4.Tender_Format_TMS__c = 'Single source';
            update radRec4;
        test.stopTest();
    }
    
    public static eRAD__c eradcreate(String statusstr,Id rectypeid,Id OpptyId){
        eRAD__c radRec = new eRAD__c();
        radrec.Status__c = statusstr;
        radrec.RecordTypeId = rectypeid;
        radRec.Opportunity__c = OpptyId;
        insert radrec;
        return radrec;
    }
}