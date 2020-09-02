@isTest
Global Class Test_GE_MCS_Prepopulate_from_ParentCase

{

    public static testMethod void TestCreateAndTest() {
        Test.StartTest(); {
            Profile p = [select id from profile where name = 'System Administrator'];
            User u = new User(alias = 'TestUser', email = 'Testuser@testorg.com.MCMVP',
                emailencodingkey = 'UTF-8', lastname = 'Testing', languagelocalekey = 'en_US',
                localesidkey = 'en_US', profileid = p.Id, timezonesidkey = 'America/Los_Angeles', username = 'userRCJ@testorg.com');
            Insert u;
            String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
            Account acc = new Account(Name = 'TestAccount1', GE_HQ_DUNS_Number__c = 'GEGUL9999', RecordTypeId = recordTypeName);
            acc.type = 'EPC';
            acc.Classification__c = 'Silver';
            insert acc;
            insert new GE_Configuration_Setting__c(Name = 'OG Counter', GE_PWNUC_Oppty_ID__c = 6.0, GE_OGGS_Oppty_Id__c = 0, GE_OG_Oppty_Id_Counter__c = 6.0, GE_OG_PII_OIDCnt__c = 0, GE_OG_SS_WSIDCntr__c = 0);
            insert new GE_Profile__c(Name = 'GE_ES System Integration', Functional_Profile_Name__c = 'test fnctnal name', Profile_Name__c = 'test name', Profile_SFDC_ID__c = '00eA0000000EfIu');
            Opportunity oppTest = CommonTestDataFactory_GE_OG.createOppty('RCJ-New-OPP',acc.Id);
            /*try{
            oppTest = new Opportunity(StageName = 'Prospecting', name = 'RCJ-New-OPP', AccountId = acc.id, CloseDate = Date.Today(), amount_ge_og__c = 100, tier_3_ge_og__c = 'Bently Nevada', tier_2_ge_og__c = 'Measurement & Control');
            
            Insert oppTest;}
            catch(Exception e)
            {System.debug('exception-----------' + e );}*/

            RecordType rt = [select id, name from recordtype where sObjectType = 'Case'
                and Name = 'MCS - CS'
                limit 1
            ];
            Case ParentCase = new Case();
            ParentCase.recordtype = rt;
            ParentCase.AccountID = acc.ID;
            ParentCase.ownerID = u.ID;
            ParentCase.GE_ES_Sub_Type__c = 'RFQ processing';
            ParentCase.Status = 'Open';
            ParentCase.GE_ES_IsueStrtDt__c = Date.Today();
            ParentCase.CurrencyIsoCode = 'USD';
            ParentCase.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            ParentCase.GE_Tier_3__c = 'Contractual Services (CS)';
            ParentCase.Opportunity_Name__c = oppTest.ID;

            Insert ParentCase;

            Case childCase = new Case();
            childCase.recordtypeID = rt.ID;
            //childCase.AccountID = acc.ID;
            //childCase.ownerID = u.ID;
            childCase.GE_ES_Sub_Type__c = 'RFQ processing';
            childCase.Status = 'Open';
            childCase.GE_ES_IsueStrtDt__c = Date.Today();
            childCase.CurrencyIsoCode = 'USD';
            childCase.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            childCase.ParentID = ParentCase.ID;
            Insert childCase;
        }Test.StopTest(); 
    }
}