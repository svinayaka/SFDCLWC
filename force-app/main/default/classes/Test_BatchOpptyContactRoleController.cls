@istest
Public class Test_BatchOpptyContactRoleController{

    @testsetup
    static void createData(){
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account KP test';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c ='Industrial';
        acc.Country_GEOG__c = 'India';
        insert acc;
        
        Contact objCon = new Contact();
        objCon.FirstName = 'testConKP123';
        objCon.LastName = 'LastnameKP123';
        objCon.email = 'test@kp123.com';
        objCon.AccountId = acc.id;
        insert objCon;
        
        Opportunity oppty= CommonTestDataFactory_GE_OG.createOpptyOFSIWS('Testopportunity333',acc.ID);
        
        OpportunityContactRole objOppRole = new OpportunityContactRole();
        objOppRole.contactId = objCon.id;
        objOppRole.Role = 'Sales';
        objOppRole.opportunityId = oppty.id;
        insert objOppRole;
    }
    
    public static testMethod void testSchduleKeyDates(){
        test.startTest();
            OpportunityContactRole objOppRole = [select id, ContactId, OpportunityId, Role FROM OpportunityContactRole where Role='Sales'];
            ScheduleOpptyContactRoleController schedule_apex = new ScheduleOpptyContactRoleController();
            String CRON_EXP = '0 0 0 15 3 ? *';
            System.schedule('ScheduleApexClassTestOppRole',  CRON_EXP, schedule_apex);
        test.stopTest();
    }
}