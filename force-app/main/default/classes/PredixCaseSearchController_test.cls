@isTest
private class PredixCaseSearchController_test{


static  testMethod void validatePredixCaseSearchController_test0(){
    /* Profile p = [select id from profile where Name = :'System Administrator' limit 1];
    User pu = new User(profileId = p.id, username = 'ttjtrryjt@ff.com', email = 'pphjmhm@cc.com',
    emailencodingkey = 'UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='csgfrrgu', lastname='lastname');
    insert pu;
    */
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

    Account a = new Account(name='testing');
    a.classification__c='test';
    a.type='test';
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;    insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;
    list<Case> casestoinsert = new list<case>();

for(integer i=1;i<=40;i++)
{
if(i<=2)
{
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = ',';
    cs.Priority = 'P1–Level 1–Catastrophic service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>2 && i<=4)
{
    Case cs = new case ();
    cs.Status = 'Acknowledged';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P1–Level 1–Catastrophic service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>4 && i<=6)
{
    Case cs = new case ();
    cs.Status = 'Working';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P1–Level 1–Catastrophic service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>6 && i<=8)
{
    Case cs = new case ();
    cs.Status = 'Resolved';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P1–Level 1–Catastrophic service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>8 && i<=10)
{
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P1–Level 1–Catastrophic service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>10 && i<=12)
{
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P2–Level 2–Service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>12 && i<=14)
{
    Case cs = new case ();
    cs.Status = 'Acknowledged';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P2–Level 2–Service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>14 && i<=16)
{
    Case cs = new case ();
    cs.Status = 'Working';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P2–Level 2–Service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>16 && i<=18)
{
    Case cs = new case ();
    cs.Status = 'Resolved';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P2–Level 2–Service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>18 && i<=20)
{
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P2–Level 2–Service failure';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>20 && i<=22)
{
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P3–Level 3–Limited loss of service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>22 && i<=24)
{
    Case cs = new case ();
    cs.Status = 'Acknowledged';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P3–Level 3–Limited loss of service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>24 && i<=26)
{
    Case cs = new case ();
    cs.Status = 'Working';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P3–Level 3–Limited loss of service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>26 && i<=28)
{
    Case cs = new case ();
    cs.Status = 'Resolved';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P3–Level 3–Limited loss of service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>28 && i<=30)
{
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P3–Level 3–Limited loss of service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>30 && i<=32)
{
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>32 && i<=34)
{
    Case cs = new case ();
    cs.Status = 'Acknowledged';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>34 && i<=36)
{
    Case cs = new case ();
    cs.Status = 'Working';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>36 && i<=38)
{
    Case cs = new case ();
    cs.Status = 'Resolved';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
if(i>38 && i<=40)
{
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject='testing';
    cs.CreatedDate=myDateTime;
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=cogbghnt.Id;
    cs.AccountId=a.Id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=pu.id;
    casestoinsert.add(cs);
}
}
    insert casestoinsert;

    list<case> insertedcases = [select id from case];

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = ',';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.FirstPage();   
    pcpg.next();
    pcpg.getnxt();
    pcpg.previous();
    pcpg.getprev();
    //pcpg.LastPage();
    pcpg.Cancel();
    pcpg.Submit();

    //pcpg.getNewCasesDisplay();

    /*
    pcpg.CasesCountQuery
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
    // pcpg.getWorkingCasesDisplay();
    // pcpg.getResolvedCasesDisplay();
    //pcpg.getFiveHrsCasesDisplay();
    pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    //pcpg.getYesterdayCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    //pcpg.getLastMonthCasesDisplay();
    //pcpg.getOneHrCasesDisplay();*/


    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 

    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    //PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');
    //pageRef.getParameters().put('FilterByStatus', 'New');

    //pcpg.getNewCasesDisplay();
    test.stoptest();
    }

static  testMethod void validatePredixCaseSearchController_test1(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

    Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';
    a.classification__c='test';
    a.type='test';
    a.RecordtypeId = CommAccrecType ;    insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');

    pageRef.getParameters().put('FilterByStatus', 'All');
    pcpg.getAllPriorityCasesDisplay();

    test.stoptest();
    }


static  testMethod void validatePredixCaseSearchController_test2(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    pageRef.getParameters().put('FilterByStatus', 'New');
    pcpg.getNewCasesDisplay();
    test.stoptest();
    }

static  testMethod void validatePredixCaseSearchController_test3(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

    Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
    a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);

    pageRef.getParameters().put('filterByPriority', 'P1–Level 1–Catastrophic service failure');
    pcpg.getP1PriorityCasesDisplay();

    test.stoptest();
    }
    
static  testMethod void validatePredixCaseSearchController_test4(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

    Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
    a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,';
    cs1.Priority = 'P2–Level 2–Service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');

    pageRef.getParameters().put('filterByPriority', 'P2–Level 2–Service failure');
    pcpg.getP2PriorityCasesDisplay();

    test.stoptest();
    }  

static  testMethod void validatePredixCaseSearchController_test5(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P3–Level 3–Limited loss of service';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');

    pageRef.getParameters().put('filterByPriority', 'P3–Level 3–Limited loss of service');
    pcpg.getP3PriorityCasesDisplay();

    test.stoptest();
    }  
    
static  testMethod void validatePredixCaseSearchController_test6(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P4–Level 4–No impact to service';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');

    pageRef.getParameters().put('filterByPriority', 'P4–Level 4–No impact to service');
    pcpg.getP4PriorityCasesDisplay();

    test.stoptest();
    } 

static  testMethod void validatePredixCaseSearchController_test7(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'Closed';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');
    pageRef.getParameters().put('FilterByStatus', 'Closed');
    pcpg.getClosedCasesDisplay();
    test.stoptest();
    }

static  testMethod void validatePredixCaseSearchController_test8(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'Acknowledged';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    // PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');
    pageRef.getParameters().put('FilterByStatus', 'Acknowledged');
    pcpg.getAckCasesDisplay();
    test.stoptest();
    }

static  testMethod void validatePredixCaseSearchController_test9(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');
    //pageRef.getParameters().put('FilterByStatus', 'New');
    pcpg.getAllStatusCasesDisplay();
    test.stoptest();
    }

static  testMethod void validatePredixCaseSearchController_test10(){


    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'Working';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');
    pageRef.getParameters().put('FilterByStatus', 'Working');
    pcpg.getWorkingCasesDisplay();
    test.stoptest();
    }  
static  testMethod void validatePredixCaseSearchController_test11(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'Resolved';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');
    pageRef.getParameters().put('FilterByStatus', 'Resolved');
    pcpg.getResolvedCasesDisplay();
    test.stoptest();
    } 
    
static  testMethod void validatePredixCaseSearchController_test12(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-65;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');
    //pageRef.getParameters().put('FilterByStatus', 'New');
    pcpg.getAllDateTimeCasesDisplay();
    test.stoptest();
    } 
    
static  testMethod void validatePredixCaseSearchController_test13(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-3;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();
    Test.StartTest(); 
    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();

    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today();
    pcpg.isCommunityUser=true;
    //PageReference pageRef = Page.PredixCaseSearchPage; 

   // pageRef.getParameters().put('strSubject', 'testing');
    
    // pageRef.getParameters().put('strSearch', 'testing');
    //Test.setCurrentPage(pageRef);
    
    pcpg.strSubject = 'testing';
    pcpg.runSearch();
   
    
    pcpg.ShowDateTimeCases();
   pcpg.ShowPriorityCases();
   pcpg.ShowStatusCases(); 
   pcpg.updateRecordType();
   pcpg.getRecordTypes();
  // pcpg.getOneHrCasesDisplay();
   // pcpg.getTwoMonthCasesDisplay();
   PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','FIVE_HOURS');
    //pageRef.getParameters().put('FilterByStatus', 'New');
    pcpg.FilterByStatus = 'New';
    pcpg.FilterByDateTime = 'FIVE_HOURS';
    //pcpg.Submit();
    pcpg.getFiveHrsCasesDisplay();
     pcpg.Cancel();
    test.stoptest();
    }  
    
static  testMethod void validatePredixCaseSearchController_test14(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-1;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();
    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');

    PredixCaseSearchController pcpg = new PredixCaseSearchController();

    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 
    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','YESTERDAY');
    //pageRef.getParameters().put('filterByDateTime', 'FIVE_HOURS');
    pageRef.getParameters().put('FilterByStatus', 'New');
    pcpg.getYesterdayCasesDisplay();
    test.stoptest();
    }  
    
static  testMethod void validatePredixCaseSearchController_test15(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=true;
    PageReference pageRef = Page.PredixCaseSearchPage; 

    pageRef.getParameters().put('strSubject', 'testing');
    pageRef.getParameters().put('strSearch', 'testing');
    Test.setCurrentPage(pageRef);
    pcpg.runSearch();
    pcpg.Cancel();
    pcpg.Submit();
    pcpg.ShowDateTimeCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowStatusCases(); 
    pcpg.updateRecordType();
    pcpg.getRecordTypes();
    //pcpg.getOneHrCasesDisplay();
    //pcpg.getTwoMonthCasesDisplay();
    PredixCaseSearchController.wrapcases testwrap = new PredixCaseSearchController.wrapcases(cs1);
    //pageRef.getParameters().put('FilterByDateTime','LAST_MONTH');
    pageRef.getParameters().put('FilterByStatus', 'New');
    pcpg.getLastMonthCasesDisplay();
    test.stoptest();
    }  
    static  testMethod void validatePredixCaseSearchController_test16(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
    pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.pagecount = 2;
    pcpg.currentpage = 1;
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
    pcpg.LastPage();
    pcpg.hasAttachment = true;
    pcpg.strStatus = 'test';
    pcpg.strSubject = 'test';
    pcpg.strOwnerName = 'test';
    pcpg.runSearch();
    pcpg.FilterByStatus = 'New';
    pcpg.FilterByDateTime = 'LAST_MONTH';
    pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();   
    test.stoptest();
    
    }
        static  testMethod void validatePredixCaseSearchController_test17(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
    pcpg.FilterByStatus = 'New';
    pcpg.FilterByDateTime = 'YESTERDAY';
    pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay(); 
    pcpg.getP3PriorityCasesDisplay();
    test.stoptest();
    
    }
        static  testMethod void validatePredixCaseSearchController_test18(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
    pcpg.FilterByStatus = 'New';
    pcpg.FilterByDateTime = 'FIVE_HOURS';
    pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay(); 
    pcpg.getP3PriorityCasesDisplay();
    
    test.stoptest();
    
    }
    
     static  testMethod void validatePredixCaseSearchController_test19(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
  //  pcpg.getP2PriorityCasesDisplay(); 
  //  pcpg.getP3PriorityCasesDisplay();
     pcpg.casessize = 100;
     pcpg.limitsize = 25;
    pcpg.filterByPriority = 'P2–Level 2–Service failure';
    pcpg.filterByDateTime = 'LAST_MONTH';
    pcpg.hasAttachment = True;
    pcpg.getNewCasesDisplay();
    test.stoptest();
    
    }
    
    static  testMethod void validatePredixCaseSearchController_test20(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
   // pcpg.getP2PriorityCasesDisplay(); 
   // pcpg.getP3PriorityCasesDisplay();
     pcpg.casessize = 100;
     pcpg.limitsize = 25;
    pcpg.filterByPriority = 'P2–Level 2–Service failure';
    pcpg.filterByDateTime = 'YESTERDAY';
    pcpg.hasAttachment = True;
    pcpg.getNewCasesDisplay();
    test.stoptest();
    
    }
    
    static  testMethod void validatePredixCaseSearchController_test21(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
   // pcpg.getP2PriorityCasesDisplay(); 
   // pcpg.getP3PriorityCasesDisplay();
     pcpg.casessize = 54;
    pcpg.limitsize = 25;
    pcpg.pagecount = 3;
    pcpg.totalrecs = 200;
    pcpg.filterByPriority = 'P2–Level 2–Service failure';
    pcpg.filterByDateTime = 'YESTERDAY';
    pcpg.hasAttachment = True;
    pcpg.getprev();
    pcpg.getnxt();
    pcpg.lastpage();
    pcpg.getNewCasesDisplay();
    
    test.stoptest();
    
    }
    
    static  testMethod void validatePredixCaseSearchController_test22(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
a.classification__c='test';
    a.type='test';  insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
   // pcpg.getP2PriorityCasesDisplay(); 
   // pcpg.getP3PriorityCasesDisplay();
     pcpg.casessize = 54;
    pcpg.limitsize = 25;
    pcpg.pagecount = 3;
    pcpg.totalrecs = 200;
  //  pcpg.filterByPriority = 'P4–Level 4–No impact to service';
    pcpg.FilterByDateTime = 'FIVE_HOURS';
    pcpg.hasAttachment = True;
  //  pcpg.getprev();
  //  pcpg.getnxt();
  //  pcpg.lastpage();
  //  pcpg.getNewCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    test.stoptest();
    
    }
    
    static  testMethod void validatePredixCaseSearchController_test23(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;

    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 

    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();

    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
   // pcpg.getP2PriorityCasesDisplay(); 
   // pcpg.getP3PriorityCasesDisplay();
     pcpg.casessize = 54;
    pcpg.limitsize = 25;
    pcpg.pagecount = 3;
    pcpg.totalrecs = 200;
  //  pcpg.filterByPriority = 'P4–Level 4–No impact to service';
    pcpg.FilterByDateTime = 'FIVE_HOURS';
    pcpg.hasAttachment = True;
  //  pcpg.getprev();
  //  pcpg.getnxt();
  //  pcpg.lastpage();
  //  pcpg.getNewCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    test.stoptest();
    
    }
    
    static  testMethod void validatePredixCaseSearchController_test24(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    cs1.Community_Last_Modified_User__c = 'test1,test2';
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;
    
    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 
    //pcpg.caseObject.Community_Last_Modified_User__c = 'test1,test2';
    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    
    //pcpg.wrapcases(cs1);
    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
   // pcpg.getP2PriorityCasesDisplay(); 
   // pcpg.getP3PriorityCasesDisplay();
    // pcpg.casessize = 54;
  //  pcpg.limitsize = 25;
  //  pcpg.pagecount = 3;
  //  pcpg.totalrecs = 200;
  //  pcpg.filterByPriority = 'P4–Level 4–No impact to service';
   // pcpg.FilterByDateTime = 'FIVE_HOURS';
   // pcpg.hasAttachment = True;
  //  pcpg.getprev();
  //  pcpg.getnxt();
  //  pcpg.lastpage();
  //  pcpg.getNewCasesDisplay();
    
    //pcpg.getP4PriorityCasesDisplay();
    test.stoptest();
    
    }
    
    static  testMethod void validatePredixCaseSearchController_test25(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    cs1.Community_Last_Modified_User__c = 'test1,test2,test3';
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;
    
    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 
    //pcpg.caseObject.Community_Last_Modified_User__c = 'test1,test2';
    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    
    //pcpg.wrapcases(cs1);
    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
   // pcpg.getP2PriorityCasesDisplay(); 
   // pcpg.getP3PriorityCasesDisplay();
    // pcpg.casessize = 54;
  //  pcpg.limitsize = 25;
  //  pcpg.pagecount = 3;
  //  pcpg.totalrecs = 200;
  //  pcpg.filterByPriority = 'P4–Level 4–No impact to service';
   // pcpg.FilterByDateTime = 'FIVE_HOURS';
   // pcpg.hasAttachment = True;
  //  pcpg.getprev();
  //  pcpg.getnxt();
  //  pcpg.lastpage();
  //  pcpg.getNewCasesDisplay();
    
    //pcpg.getP4PriorityCasesDisplay();
    test.stoptest();
    
    }
    
    static  testMethod void validatePredixCaseSearchController_test26(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;
a.classification__c='test';
    a.type='test';    insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    cs1.Community_Last_Modified_User__c = 'test1,test2,test3,test4';
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;
    
    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 
    //pcpg.caseObject.Community_Last_Modified_User__c = 'test1,test2';
    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    
    //pcpg.wrapcases(cs1);
    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
   // pcpg.getP2PriorityCasesDisplay(); 
   // pcpg.getP3PriorityCasesDisplay();
    // pcpg.casessize = 54;
  //  pcpg.limitsize = 25;
  //  pcpg.pagecount = 3;
  //  pcpg.totalrecs = 200;
  //  pcpg.filterByPriority = 'P4–Level 4–No impact to service';
   // pcpg.FilterByDateTime = 'FIVE_HOURS';
   // pcpg.hasAttachment = True;
  //  pcpg.getprev();
  //  pcpg.getnxt();
  //  pcpg.lastpage();
  //  pcpg.getNewCasesDisplay();
    
    //pcpg.getP4PriorityCasesDisplay();
    test.stoptest();
    
    }
    
    static  testMethod void validatePredixCaseSearchController_test27(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;
a.classification__c='test';
    a.type='test';    insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    cs1.Community_Last_Modified_User__c = 'test1,test2,test3,test4,test5';
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;
    
    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 
    //pcpg.caseObject.Community_Last_Modified_User__c = 'test1,test2';
    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    
    //pcpg.wrapcases(cs1);
    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
   // pcpg.getP2PriorityCasesDisplay(); 
   // pcpg.getP3PriorityCasesDisplay();
    // pcpg.casessize = 54;
  //  pcpg.limitsize = 25;
  //  pcpg.pagecount = 3;
  //  pcpg.totalrecs = 200;
  //  pcpg.filterByPriority = 'P4–Level 4–No impact to service';
   // pcpg.FilterByDateTime = 'FIVE_HOURS';
   // pcpg.hasAttachment = True;
  //  pcpg.getprev();
  //  pcpg.getnxt();
  //  pcpg.lastpage();
  //  pcpg.getNewCasesDisplay();
    
    //pcpg.getP4PriorityCasesDisplay();
    test.stoptest();
    
    }
    
    static  testMethod void validatePredixCaseSearchController_test28(){

    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId(); 
    User pu = new User(ProfileId = p.Id, username = 'test1111@ged.com', email = 'test1@ged.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwus', lastname='lastnamee' );
    insert pu;

Account a = new Account(name='testing');a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
a.classification__c='test';
    a.type='test';   insert a;

    Contact cogbghnt = new Contact();
    cogbghnt .FirstName ='tesdrrfsdgft1';
    cogbghnt .LastName ='defdgrrdfgmo';
    cogbghnt .Email ='abgdfgdfrrgc@xyc.com';
    cogbghnt.AccountId=a.Id;
    insert cogbghnt ;

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    RecordType rt1 = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix UO' limit 1];

    datetime myDateTime = System.today()-30;

    Case cs1 = new case ();
    cs1.Status = 'New';
    cs1.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4';
    cs1.Priority = 'P1–Level 1–Catastrophic service failure';
    cs1.Subject='testing';
    cs1.CreatedDate=myDateTime;
    cs1.Description='testing';
    cs1.Type='testing';
    cs1.ContactId=cogbghnt.Id;
    cs1.AccountId=a.Id;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
    cs1.recordtypeid=rt.id;
    cs1.OwnerId=pu.id;
    cs1.Community_Last_Modified_User__c = 'test1,test2,test3,test4,test5';
    insert cs1;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs1.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 

    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs1.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca;

    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c='testing';
    pd.Product__c='testing';
    pd.ProfileName__c= [Select Name From Profile Where ID =: UserInfo.GetProfileID()].Name ;
    pd.RecordType__c='Predix IPS';
    pd.Status__c='testing';
    pd.Name='testing';
    insert pd;
    
    DateTime FilterByDateTime  = System.today();

    Test.StartTest(); 
    //pcpg.caseObject.Community_Last_Modified_User__c = 'test1,test2';
    // pageRef.getParameters().put('strOwnerName', 'testing');
    // pageRef.getParameters().put('strOwnerName', 'cs');
    PredixCaseSearchController pcpg = new PredixCaseSearchController();
    pcpg.display_P1PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P2PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P3PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_P4PriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_newcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_closedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_workingcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Resolvedcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_ackcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_OneHrcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_FiveHrscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_Yesterdaycaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_TwoMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_LastMonthcaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllStatuscaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllPriorityCaseslist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.display_AllDateTimecaselist = new list<PredixCaseSearchController.wrapcases>();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    
    //pcpg.wrapcases(cs1);
    //pcpg.FilterByDateTime= system.today()-60;
    pcpg.isCommunityUser=false;
   // pcpg.FilterByStatus = 'New';
  //  pcpg.FilterByDateTime = 'FIVE_HOURS';
  //  pcpg.getP1PriorityCasesDisplay();
   // pcpg.getP2PriorityCasesDisplay(); 
   // pcpg.getP3PriorityCasesDisplay();
    // pcpg.casessize = 54;
  //  pcpg.limitsize = 25;
  //  pcpg.pagecount = 3;
  //  pcpg.totalrecs = 200;
  //  pcpg.filterByPriority = 'P4–Level 4–No impact to service';
   // pcpg.FilterByDateTime = 'FIVE_HOURS';
   // pcpg.hasAttachment = True;
  //  pcpg.getprev();
  //  pcpg.getnxt();
  //  pcpg.lastpage();
  //  pcpg.getNewCasesDisplay();
    
    //pcpg.getP4PriorityCasesDisplay();
    test.stoptest();
    
    }
    }