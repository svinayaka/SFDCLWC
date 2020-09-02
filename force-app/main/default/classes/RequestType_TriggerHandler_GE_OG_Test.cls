/*
Class/Trigger Name     : RequestType_TriggerHandler_GE_OG_Test
Used For               : RequestType_TriggerHandler_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the OpportunityStagesAutomationHandler_GE_OG Class 
                        for OpportunityTrigger_GE_OG Trigger helper class
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : 
Author                 : Mohit Maheshwar
i
    
*/ 

@isTest

public class RequestType_TriggerHandler_GE_OG_Test
{

   @testsetup
    static void createRecord()
    {
        
       /* //creating 'Country Region Mapping' for 'INDIA'
       Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
       insert objcustom;
       
       // Create Member Account
       Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
       system.assertEquals('TestAccount Member',acc1.Name);
       
       //Createing an Account 
       Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
       system.assertEquals('TestAccount Relation',acc.Name);
       
       //Createing an Account
       Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('TestAccount Legal',acc.ID,acc1.ID);
       system.assertEquals('TestAccount Legal',accLE.Name);
       
       //Creating an Opportunity
       Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
       system.assertEquals('Testopportunity',opp.Name);

       //Creating a Product
       
       Product2 prod1 = CommonTestDataFactory_GE_OG.createProduct('testProduct');
       system.assertEquals('testProduct',prod1.Name);
       
       //Creating a PriceBookEntry
       PriceBookEntry PBE=  CommonTestDataFactory_GE_OG.createPriceBookEntry(prod1);
       system.assertEquals(prod1.ID,PBE.Product2ID);
       List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
       lstPBE.add(PBE);
       
       
       //Create OpportunityLineItem 
       if(lstPBE.size()>0){
            List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
            lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(opp, lstPBE);
            if(lstOLI.size()>0){
                insert lstOLI;
            }
       }
       
       // Create Opportunity Team Member
       OpportunityTeamMember objOTM = CommonTestDataFactory_GE_OG.createOpportunityTeamMember(opp.ID, UserInfo.getUserID(), System.Label.OpportunityTeamMember_Role);
       insert objOTM;*/
       
       account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Region_GEOG__c = 'India';
        insert acc;
        
        
        
        account accnt= new account();
       // accnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Competitor').getRecordTypeId();
        accnt.name = 'GE Oil & Gas';
        accnt.Account_Tier_GEOG__c = 'Global';
        accnt.Classification__c= 'Strategic';
        accnt.Type = 'Direct Customer';
        accnt.ShippingCountry = 'India'; 
       // insert accnt;
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        
        
        //Create Product
        Product2 product = CommonTestDataFactory_GE_OG.createProduct('Test Product');
        
        //Create Price Book Entry
        PriceBookEntry prBook= CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
        
        //Craete oppty Product
        OpportunityLineItem oti = CommonTestDataFactory_GE_OG.createOpportunityLineItem(opp,prBook);
       
    }
    
    static testMethod void test1()
    {
        test.startTest();
        
        Opportunity objOpp = [SELECT Id FROM Opportunity WHERE Name = 'TestOppty'];
        
        GE_Installed_Base__c objInstalledbase = new GE_Installed_Base__c();
        objInstalledbase.Name = 'Test';
        insert objInstalledbase;
        
        
        GE_ES_Request_Type__c objRequestType = new GE_ES_Request_Type__c();
        objRequestType.Name = 'Test';
        objRequestType.Opportunity__c = objOpp.Id;
        objRequestType.RecordTypeId = Util_GE_OG.getRecordTypeDetails('GE_ES_Request_Type__c','TPS- FSE Check List').getRecordTypeId();
        objRequestType.GE_OG_Intervent_Description__c = 'Test desc';
        objRequestType.GE_OG_Week_Duration_days_week__c = 1;
        objRequestType.GE_OG_Shift_Duration_hours_day__c = 2;
        objRequestType.GE_OG_Shifts__c = 'Single';
        objRequestType.GE_OG_Offshore__c = 'N';
        objRequestType.GE_OG_Board_Lodging__c = 'GE';
        objRequestType.GE_OG_Lodging_Type__c = 'Hotel';
        objRequestType.GE_OG_Local_Transportation__c = 'GE';
        objRequestType.GE_OG_Emergency_Flag__c = 'N';
        objRequestType.GE_OG_Overlap_Days__c = 1;
        objRequestType.GIB_Serial_Number_1__c = objInstalledbase.Id;
        objRequestType.GE_OG_Execution_Date_GFS__c = Date.today();
        objRequestType.GE_OG_Expected_Delivery_Date__c = Date.today();
        objRequestType.GE_OG_Intervent_Type__c = 'LEVEL 1';
        insert objRequestType;
        
                
        test.stopTest();
        
    }
}