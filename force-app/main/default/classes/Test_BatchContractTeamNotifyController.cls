@istest
Public class Test_BatchContractTeamNotifyController{

    @testsetup
    static void createData(){
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
        acc.name = 'Test LE121212';
        acc.Account_Tier_GEOG__c = 'LE';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Unclassified';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        insert acc;
        
        Contract objCon = new Contract();
        objCon.name = 'Test Team Contract';
        objCon.AccountId = acc.id;
        objCon.GE_OG_Evergreen__c = true;
        objCon.Status = 'Draft';
        objCon.recordtypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Deal Machine Contract').getRecordTypeId();
        insert objCon;
        
        Contract_Team__c objTeamMember = new Contract_Team__c();
        objTeamMember.Contract_Team_Member__c = UserInfo.getUserid();
        objTeamMember.Contract__C = objCon.ID;
        objTeamMember.Team_Role__c = 'Contracts Manager';
        insert objTeamMember;
        
        Key_Date__c objKDate = new Key_Date__c();
        objKDate.Contract__c = objCon.ID;
        objKDate.Date_Type__c = 'Price Adjustment';
        objKDate.Date__c = system.today().addMonths(1);
        objKDate.Reminder__c = 'Yes; 1 month before';
        insert objKDate;
    }
    
    public static testMethod void testSchduleKeyDates(){
        test.startTest();
            Key_Date__c objDate = [select Contract__c ,Date_Type__c ,Date__c  from Key_Date__c LIMIT 50000];
            ScheduleContractTeamNotifyController schedule_apex = new ScheduleContractTeamNotifyController();
            String CRON_EXP = '0 0 0 15 3 ? *';
            System.schedule('ScheduleApexClassTestNotify',  CRON_EXP, schedule_apex);
        test.stopTest();
    }
}