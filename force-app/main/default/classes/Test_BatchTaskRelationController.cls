@istest
Public class Test_BatchTaskRelationController{

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
        
        Task objTask = new Task();
        objTask.subject = 'TestTaskRealtion';
        objTask.whatId= acc.id;
        objTask.type='Call';
        objTask.status = 'In Progress';
        objTask.ownerId = UserInfo.getUserId();
        objTask.ActivityDate= system.today();
        objTask.recordtypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeId();
        insert objTask;
        
        TaskRelation objRel = new TaskRelation();
        objRel.RelationId = objCon.id;
        objRel.TaskId = objTask.id;
        insert objRel;
    }
    
    public static testMethod void testSchduleKeyDates(){
        test.startTest();
            TaskRelation objRel = [select id, TaskId, RelationId FROM TaskRelation limit 1];
            ScheduleTaskRelationController schedule_apex = new ScheduleTaskRelationController();
            String CRON_EXP = '0 0 0 15 3 ? *';
            System.schedule('ScheduleTaskRelationController',  CRON_EXP, schedule_apex);
        test.stopTest();
    }
}