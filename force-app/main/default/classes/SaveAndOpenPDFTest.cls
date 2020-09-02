@isTest

private class SaveAndOpenPDFTest
{
//https://developer.salesforce.com/forums/?id=906F00000005JRuIAM
//TODO: Make AcctPlan id global
 
static GE_HQ_Account_Plan__c acctPlandetails;
static GE_HQ_Account_Plan__c acctPlan;    
    
public static testMethod void test()

    {

 /* acctPlan=new GE_HQ_Account_Plan__c(name='Test Account Plan',Primary_Channel_Manager_18_digit_ID__c='123456789123456789',
 Secondary_Channel_Manager_18_digit_ID__c='123456789123456789',Channel_Partner_Contact_Name_GEOG__c='Raji Ranganathan'
 ); */
   
   acctPlan=new GE_HQ_Account_Plan__c(name='Test Account');   
   insert acctPlan;

   PageReference redtAcctPlanPage = Page.AccountPlanPage;
   Test.setCurrentPage(redtAcctPlanPage);

   ApexPages.currentPage().getParameters().put('id',String.ValueOf(acctPlan.id));        
   acctPlandetails=[Select Channel_Partner_Contact_Name_GEOG__c from GE_HQ_Account_Plan__c where id=:ApexPages.currentPage().getParameters().get('Id')];


//insert acctPlandetails;
//acctPlandetails.Channel_Partner_Contact_Name_GEOG__c='Terence Richards';
//update acctPlandetails;
Test.startTest();

SaveAndOpenPDF saveOpenCtroller=new SaveAndOpenPDF(new ApexPages.StandardController(acctPlan));

saveOpenCtroller.saveAndOpenPDF();
Test.stopTest();




//Need task fields for getlstCompletedTasks() so creating a new task

/*GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp2));*/
    String TaskRecordTypeChannel_MAP_TaskId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Channel MAP Task').getRecordTypeId(); 
    List<Task>lstCompletedTasks=new List<Task>();
    List<Task>lstIncomTasks=new List<Task>();
    List<Task> tasks = new List<Task>();
    tasks.add(new Task(
        ActivityDate = Date.today().addDays(7),
        Subject='Sample Task',
        Type = 'Call',
        WhatId = acctPlan.Id,
        OwnerId = UserInfo.getUserId(),RecordTypeId=TaskRecordTypeChannel_MAP_TaskId,
        Status='In Progress'));    
    insert tasks;
    
    List<Task> tasksList = new List<Task>();
    tasksList.add(new Task(
    ActivityDate = Date.today().addDays(7),
    Subject='Sample Task',
    Type = 'Call',
    WhatId = acctPlan.Id,
    OwnerId = UserInfo.getUserId(),RecordTypeId=TaskRecordTypeChannel_MAP_TaskId,
    Status='Completed'));
    insert tasksList;
    
    List<Task> tasksLst = new List<Task>();
    tasksLst.add(new Task(
    ActivityDate = Date.today().addDays(7),
    Subject='Sample Task',
    Type = 'Call',
    WhatId = acctPlan.Id,
    OwnerId = UserInfo.getUserId(),RecordTypeId=TaskRecordTypeChannel_MAP_TaskId,
    Status='Rejected'));
    
    insert tasksLst;
    
    List<Task> tasksL = new List<Task>();
    tasksL.add(new Task(
    ActivityDate = Date.today().addDays(7),
    Subject='Sample Task',
    Type = 'Call',
    WhatId = acctPlan.Id,
    OwnerId = UserInfo.getUserId(),RecordTypeId=TaskRecordTypeChannel_MAP_TaskId,
    Status='Deferred'));
    insert tasksL;
    lstIncomTasks=[Select id,Subject,WhatId,Type,OwnerId,Owner.Name,WhoId,Who.Name,Status,ActivityDate,Description from Task Where WhatId=:acctPlan.id and Status IN('Not Started','In Progress','Waiting on someone else') ORDER BY ActivityDate DESC];
    lstCompletedTasks=[Select id,Subject,WhatId,Type,OwnerId,Owner.Name,WhoId,Who.Name,Status,ActivityDate,Description from Task Where WhatId=:acctPlan.id  and Status IN('Deferred','Rejected','Completed') ORDER BY ActivityDate DESC];
        
}
public static testMethod void testEmail()

{
    test.startTest();
    Account acc = new account();
            acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
            acc.name = 'Test new AccouPlan';
            acc.Account_Tier_GEOG__c = 'Country';
            acc.Classification__c= 'Strategic';
            acc.Type = 'Channel Partner';
            //acc.Type = 'Competitor';
            acc.ShippingCountry = 'India';
            acc.GE_ES_Primary_Industry__c = 'ABC';
            acc.Country_GEOG__c = 'India';
            insert acc;
    Profile[] profiles = [Select p.name, p.id From Profile p WHERE Name = 'Standard User'];
    Profile profile;
    if (profiles.size() > 0)
                profile = profiles[0];
            System.Debug('User.ProfileId - ' + profile.Id);
            String profileId = profile.Id;


     User one = new User(alias = 'tst_ZZZ', email='bmtestuser@ge.com', 
                emailencodingkey='UTF-8', lastname='testuser_ZZZ', languagelocalekey='en_US', 
                localesidkey='en_US', profileid = profileId, isActive=true, 
                BMUserType__c = BMGlobal.BM_INTERNAL_USER, BMUserAccessType__c = 'FullAccess',                      
                timezonesidkey='America/New_York', username='testuser_KKK@comitydesigns.com');

 insert one;
 
GE_HQ_Account_Plan__c acctPlan1=new GE_HQ_Account_Plan__c(name='Test Account',GE_PRM_Account__c=acc.id,Secondary_Channel_Manager_GEOG__c=one.id);

insert acctPlan1;

ApexPages.StandardController controller = new ApexPages.StandardController(acctPlan1);


ApexPages.currentPage().getParameters().put('Id',acctPlan1.id);

SaveAndOpenPDF sveop=new SaveAndOpenPDF(controller);

 
 
sveop.sendEmailNotification(acctPlan1.id);

test.stopTest();
    
}
}