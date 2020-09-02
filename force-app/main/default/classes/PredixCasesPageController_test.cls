@istest(SeeAllData=false)
private class PredixCasesPageController_test{
    
/*static  testMethod void validatePredixCasesPageController_test(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    
    Profile p = [SELECT Id FROM Profile WHERE Name='II Partner Community IPS']; 
     Account a  = new Account(name='testing');
      a.Classification__c = 'Silver';
        a.type ='EPC';
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  insert a;
    
    contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
     User u = new User(ProfileId = p.Id, username = 'prediccasepage1@ge.com', email = 'test1@ge.com',
       EmailEncodingKey='UTF-8', localesidkey = 'en_US',
       languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
     alias='cserwu', lastname='lastname',contactid = con.id,GE_HQ_Tier_3_P_L__c='test');
       insert u;
       
   
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
           
    Datetime countMyCases =System.today();
    
    //string AccID = u.Contact.AccountID;
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = ',';
    cs.Priority = 'P1–Level 1–Catastrophic service failure';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=con.Id;
    cs.AccountId=u.Contact.AccountID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=u.id;
    insert cs;
           
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
       
   // List<Attachment> attachments=[select id, name from Attachment where parent.id=:cs.id];
   // System.assertEquals(1, attachments.size());
   
/*   Technical_Support__kav tt = new Technical_Support__kav();
  // tt.ArticleType ='test';
     tt.Details__c ='test';
      tt.Language ='en_US';
    //  tt.PublishStatus='test';
      tt.Summary='test';
        tt.Title='test';
         tt.UrlName='test';
         insert tt;
          
*/          
  
     //KnowledgeArticle ka =   [SELECT ArchivedById,ArchivedDate,ArticleNumber,CaseAssociationCount,FirstPublishedDate,Id,LastPublishedDate FROM KnowledgeArticle where id=:tt.id limit 1];
    
    /*CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    //ca.KnowledgeArticleId =ka.id;
    insert ca; 
 
    FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
    EntitySubscription newES = new EntitySubscription();
    newES.ParentId =cs.id;
    newES.SubscriberId = UserInfo.getUserId();
    Insert newES;
              
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                       
    /*Enhancement__c es = new Enhancement__c();
    es.Name='testing';
    es.Account_Name__c=a.id;
    es.Case_Type__c='testing';
    es.Contact_Name__c=con.id;
    es.Description__c='testing';
    es.Product__c='testing';
    es.Subject__c='testing';
    insert es; */

    /*CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
   
    test.starttest();
    
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.selectedcases  = new list<case>();
    pcpg.selectedpriority = new list<case>();
    pcpg.prioritycases = new list<case>();
    pcpg.display_contributorlist = new list<PredixCasesPageController.wrapcase>();
    pcpg.display_Searchcaselist = new list<PredixCasesPageController.wrapcase>();
    pcpg.searchResults = new list<PredixCasesPageController.wrapcase>();
    
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
    pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
    pcpg.getNewCasesDisplay();
  /* pcpg.LastPage();
    pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    //pcpg.getClosedFilterCasesDisplay();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
  // pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    // pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
   
    /*pcpg.globalNew = 'True';
    pcpg.globalAcknowledged = 'False';
    pcpg.globalClosed = 'True';
    pcpg.globalClosed = 'False';
    
    pcpg.FilterByStatus = '';
    pcpg.FilterByPriority = '';
    pcpg.FilterByDateTime = '';
     pcpg.FilterByDateTime = 'System.now().addmonths(-1)';
   
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    test.stoptest();
    }*/
    
static  testMethod void validatePredixCasesPageController_test1(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    
    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'prediccasepage2@ge.com', email = 'test1@ge.com',
     EmailEncodingKey='UTF-8', localesidkey = 'en_US',
     languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
     alias='cserwu', lastname='lastname' );
    insert u;
   
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;   a.Classification__c = 'Silver';
        a.type ='EPC';insert a;
        
    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
       
     string AccID = u.Contact.AccountID;
    Datetime countMyCases =System.today();
    Case cs = new case ();
    cs.Status = 'Acknowledged';
    cs.Community_Last_Modified_User__c = 'testing,';
    cs.Priority = 'P2–Level 2–Service failure';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz';
    cs.Type='testing';
    cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=u.id;
    insert cs;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

    FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
    EntitySubscription newES = new EntitySubscription();
    newES.ParentId =cs.id;
    newES.SubscriberId = UserInfo.getUserId();
    Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /* Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es; */

    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
           
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=false;
    pcpg.FirstPage();
      pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
    pcpg.LastPage();
    pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
    pcpg.getP1PriorityCasesDisplay();
    pcpg.CurUser = u;
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    pcpg.isCommunityUser=true;
    pcpg.globalMyCompanyCases='False';
    //pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
   // pcpg.getAnyTimeRecordsToDisplay();
   
    pcpg.globalNew = 'True';
    pcpg.globalAcknowledged = 'False';
    pcpg.globalClosed = 'True';
    pcpg.globalClosed = 'False';
    
    pcpg.FilterByStatus = '';
    pcpg.FilterByPriority = '';
    pcpg.FilterByDateTime = '';
    pcpg.FilterByDateTime = 'System.now().addmonths(-1)';
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();

    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
    testwrap.hasArticle=true;
    Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test2(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     User u = new User(ProfileId = p.Id, username = 'prediccasepage3@ge.com', email = 'test1@ge.com',
       EmailEncodingKey='UTF-8', localesidkey = 'en_US',
       languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
     alias='cserwu', lastname='lastname' );
       insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;   a.Classification__c = 'Silver';
        a.type ='EPC';insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    
    string AccID = u.Contact.AccountID;
    Datetime countMyCases =System.today();
    Case cs = new case ();
    cs.Status = 'Working';
    cs.Community_Last_Modified_User__c = 'testing,demo1,';
    cs.Priority = 'P3–Level 3–Limited loss of service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=u.id;
    insert cs;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

    FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
                 
    EntitySubscription newES = new EntitySubscription();
    newES.ParentId =cs.id;
    newES.SubscriberId = UserInfo.getUserId();
    Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es; */
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
       
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
     pcpg.StrUserInfo =u.Id;
     list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
    pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
 /*   pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
    //pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/

    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
    testwrap.hasArticle=true;
    Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test3(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     User u = new User(ProfileId = p.Id, username = 'prediccasepage4@ge.com', email = 'test1@ge.com',
       EmailEncodingKey='UTF-8', localesidkey = 'en_US',
       languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
     alias='cserwu', lastname='lastname' );
       insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;   a.Classification__c = 'Silver';
        a.type ='EPC';insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    
    string AccID = u.Contact.AccountID; 
    Datetime countMyCases =System.today();
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=u.id;
    insert cs;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
    EntitySubscription newES = new EntitySubscription();
    newES.ParentId =cs.id;
    newES.SubscriberId = UserInfo.getUserId();
    Insert newES;
                  
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
     /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
       
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
    pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
  //  pcpg.LastPage();
    pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
   // pcpg.getP1PriorityCasesDisplay();
   /* pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/

    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test4(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     User u = new User(ProfileId = p.Id, username = 'prediccasepage5@ge.com', email = 'test1@ge.com',
       EmailEncodingKey='UTF-8', localesidkey = 'en_US',
       languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
     alias='cserwu', lastname='lastname' );
       insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;   a.Classification__c = 'Silver';
        a.type ='EPC';insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
    string AccID = u.Contact.AccountID; 
    Datetime countMyCases =System.today();
    Case cs = new case ();
    cs.Status = 'Resolved';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=u.id;
    insert cs;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
                
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
                  
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
      
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
  //  pcpg.LastPage();
 /*   pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/

    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
     Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test5(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     User u = new User(ProfileId = p.Id, username = 'prediccasepage6@ge.com', email = 'test1@ge.com',
       EmailEncodingKey='UTF-8', localesidkey = 'en_US',
       languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
     alias='cserwu', lastname='lastname' );
       insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
     string AccID = u.Contact.AccountID;    
    Datetime countMyCases =System.today();
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=u.id;
    insert cs;
    
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
                 
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
    
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
    pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
  /*  pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
   // pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/

    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
    testwrap.hasArticle=true;
    Test.stopTest();
    }
    
    
static  testMethod void validatePredixCasesPageController_test6(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     User u = new User(ProfileId = p.Id, username = 'prediccasepage7@ge.com', email = 'test1@ge.com',
       EmailEncodingKey='UTF-8', localesidkey = 'en_US',
       languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
     alias='cserwu', lastname='lastname' );
       insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;   a.Classification__c = 'Silver';
        a.type ='EPC';insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
    string AccID = u.Contact.AccountID; 
   Datetime countMyCases =System.today();
    Case cs = new case ();
    cs.Status = 'Working';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=u.id;
    insert cs;
                
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
                
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
     /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
       
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
   /* pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
   // pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
   
   PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
     Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test7(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
    User u = new User(ProfileId = p.Id, username = 'prediccasepage8@ge.com', email = 'test1@ge.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwu', lastname='lastname' );
    insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    Datetime countMyCases =System.today();
     string AccID = u.Contact.AccountID;    
    Case cs = new case ();
    cs.Status = 'Resolved';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=u.id;
    insert cs;
                
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
    
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
     /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
    
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
   
   
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
 /*   pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
   // pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/

    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
    testwrap.hasArticle=true;
    Test.stopTest();
    }
    
    
static  testMethod void validatePredixCasesPageController_test8(){
    
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
    User u = new User(ProfileId = p.Id, username = 'prediccasepage9@ge.com', email = 'test1@ge.com',
        EmailEncodingKey='UTF-8', localesidkey = 'en_US',
        languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
        alias='cserwu', lastname='lastname' );
        insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
   Datetime countMyCases =System.today().addmonths(-1);
    string AccID = u.Contact.AccountID; 
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=u.id;
    insert cs;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
    pcpg.previous();
    pcpg.next();
   // pcpg.LastPage();
   /* pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
 //   pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
    
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
    testwrap.hasArticle=true;
    Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test9(){
    
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
    User u = new User(ProfileId = p.Id, username = 'prediccasepage10@ge.com', email = 'test1@ge.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwu', lastname='lastname' );
    insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
       
    Datetime countMyCases =System.today()-1;
     string AccID = u.Contact.AccountID;    
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=u.id;
    insert cs;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
   /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
    
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
   /* pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
 //   pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
    
   PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
    testwrap.hasArticle=true;
    Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test10(){
    
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
    User u = new User(ProfileId = p.Id, username = 'prediccasepage11@ge.com', email = 'test1@ge.com',
    EmailEncodingKey='UTF-8', localesidkey = 'en_US',
    languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
    alias='cserwu', lastname='lastname' );
    insert u;
       
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    
    datetime myDateTime = System.now().addHours(-5);
     string AccID = u.Contact.AccountID;    
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=myDateTime;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=u.id;
    insert cs;
    
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
    
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
        
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                   
   /* Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
    pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
  /*  pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
  //  pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
    
   
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
   Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test11(){
    
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account acc1 = new Account (Name = 'newAcc1'); 
        acc1.GE_HQ_DUNS_Number__c = 'GEGUL1012';acc1.RecordtypeId = CommAccrecType ;
         acc1.Classification__c = 'Silver';
        acc1.type ='EPC';
        insert acc1;
        Contact conCase = new Contact (AccountId = acc1.id,LastName = 'portalTestUserv1', FirstName='portalTestUserv2',MobilePhone='12333454564',email='test@ge.com');
        insert conCase;
        //Create user

    Profile prfile = [select Id,name from Profile where UserType in :customerUserTypes limit 1];

    User newUser1 = new User(
    profileId = prfile.id,
    username = 'prediccasepage12@yahoo.com',
    email = 'pb@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nuser',
    lastname='lastname',
    contactId = conCase.id,
    GE_HQ_Tier_3_P_L__c='testing'
    );
    insert newUser1;
        
       /* Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  

   Profile p = [SELECT Id FROM Profile WHERE Name='II Partner Community UO' limit 1]; 
     User u = new User(ProfileId = p.Id,  = 'test1111@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname',ContactId=con.Id,GE_HQ_Tier_3_P_L__c='testing',BMUserAccessType__c='power partner');
       insert u;*/

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    string AccID = newUser1.Contact.AccountID;
    datetime myDateTime = System.now().addmonths(-1);
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=myDateTime;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testestingtestestingtestestingtestestingtestesting';
    cs.Type='testing';
     cs.ContactId=conCase.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=newUser1.id;
    insert cs;
                
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    List<Attachment> attachments=[select id, name from Attachment where parent.id=:cs.id];
    System.assertEquals(1, attachments.size());
        
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

    FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= prfile.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
  /*  Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=acc1.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=conCase.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    boolean isSelected = true; 
    test.StartTest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =newUser1.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = newUser1;
    //pcpg.hasAttachment = true;
    //pcpg.hasArticle=true;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
  //  pcpg.LastPage();
    pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    pcpg.getNewCasesDisplay();
    pcpg.getRecordsToDisplay();
    pcpg.getAckCasesDisplay();
    pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.CurUser = newUser1;
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
   pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
    pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();
    pcpg.selectedEnhancOptions='testing';
    pcpg.globalNew = 'true'; 
    pcpg.globalAcknowledged = 'true'; 
    pcpg.globalNew = 'True';
    pcpg.globalAcknowledged = 'False';
    pcpg.globalClosed = 'True';
    pcpg.FilterByStatus = '';
    pcpg.FilterByPriority = '';
    pcpg.FilterByDateTime = '';
     pcpg.FilterByDateTime = 'System.now().addmonths(-1)';
   pcpg.getNewFilterCasesDisplay();
    // pcpg.getClosedFilterCasesDisplay();
     pcpg.isCommunityUser=true;
     pcpg.CurUser = newUser1;
     
    
    pcpg.getAllPrioritiesRecordsToDisplay();
    pcpg.globalMyCompanyCases='False';
    
    
 
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
   Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test12(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account acc1 = new Account(name='testing');acc1.GE_HQ_DUNS_Number__c = 'GEGUL1012';acc1.RecordtypeId = CommAccrecType ;
        acc1.GE_HQ_DUNS_Number__c = 'GEGUL1012';acc1.RecordtypeId = CommAccrecType ;
         acc1.Classification__c = 'Silver';
        acc1.type ='EPC';
        insert acc1;
        Contact conCase = new Contact (AccountId = acc1.id,LastName = 'portalTestUserv1', FirstName='portalTestUserv2',MobilePhone='12333454564',email='test1@ge.com');
        insert conCase;
        //Create user

    Profile prfile = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
    
    User newUser1 = new User(
    profileId = prfile.id,
    username = 'prediccasepage13@yahoo.com',
    email = 'pb@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nuser',
    lastname='lastname',
    contactId = conCase.id,
    GE_HQ_Tier_3_P_L__c='testing'
    );
    insert newUser1;
        
       /* Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  

   Profile p = [SELECT Id FROM Profile WHERE Name='II Partner Community UO' limit 1]; 
     User u = new User(ProfileId = p.Id, username = 'test1111@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname',ContactId=con.Id,GE_HQ_Tier_3_P_L__c='testing',BMUserAccessType__c='power partner');
       insert u;*/
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
    // datetime myDateTime = System.now().addHours(-5);
     string AccID = newUser1.Contact.AccountID; 
    Case cs = new case ();
    cs.Status = 'Acknowledged';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=System.now().addHours(-5);
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testestingtestestingtestestingtestestingtestesting';
    
    cs.Type='testing';
     cs.ContactId=conCase.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=newUser1.id;
    insert cs;
    
   Case cs1 = new case ();
    cs1.Status = 'Acknowledged';
    cs1.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs1.Priority = 'P4–Level 4–No impact to service';
    cs1.Subject = 'demo';
    //cs1.CreatedDate=System.now().addHours(-5);
    cs1.createdByID = UserInfo.GetUserID();
    cs1.Description='testestingtestestingtestestingte';
    
    cs1.Type='testing';
     cs1.ContactId=conCase.Id;
    cs1.AccountId=AccID;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
   cs1.recordtypeid=rt.id;
   cs1.OwnerId=newUser1.id;
    insert cs1;
                
         
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= prfile.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=acc1.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=conCase.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    boolean isSelected = true; 
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =newUser1.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
     pcpg.CurUser = newUser1;
   // pcpg.hasAttachment = true;
   // pcpg.hasArticle=true;
    pcpg.s='testing';
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
   /* pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    
    pcpg.getNewCasesDisplay();
    
    pcpg.getRecordsToDisplay();
    pcpg.getAckCasesDisplay();
    pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
   pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
  pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
    pcpg.selectedEnhancOptions='testing';
    pcpg.globalNew = 'true'; 
    pcpg.globalAcknowledged = 'true'; 
         pcpg.globalNew = 'True';
    pcpg.globalAcknowledged = 'False';
    pcpg.globalClosed = 'True';
    pcpg.FilterByStatus = '';
    pcpg.FilterByPriority = '';
    pcpg.FilterByDateTime = '';
     pcpg.FilterByDateTime = 'System.now().addmonths(-1)';
   //pcpg.getNewFilterCasesDisplay();
    
 
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
      PredixCasesPageController.wrapcase  testwrap1 = new PredixCasesPageController.wrapcase(cs1);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    testwrap1.hasAttachment=true;
   testwrap1.hasArticle=true;
     Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test13(){
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account a = new Account (Name = 'newAcc1343');  
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;
        Contact con = new Contact (AccountId = a.id,LastName = 'portalTestUserv431', FirstName='portalTestU43serv2',MobilePhone='1234333454564',email='test2@ge.com');
        insert con;
        //Create user

        Profile p = [select Id,name from Profile where UserType in :customerUserTypes limit 1];

        User u = new User(
        profileId = p.id,
        username = 'prediccasepage14@yahoo.com',
        email = 'p34344444b@f.com',
        emailencodingkey = 'UTF-8',
        localesidkey = 'en_US',
        languagelocalekey = 'en_US',
        timezonesidkey = 'America/Los_Angeles',
        alias='nus322er',
        lastname='lastname',
        contactId = con.id,
        GE_HQ_Tier_3_P_L__c='testing43443'
        );
        insert u;
       /*  Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  

   Profile p = [SELECT Id FROM Profile WHERE Name='II Partner Community UO' limit 1]; 
     User u = new User(ProfileId = p.Id, username = 'test1111@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname',ContactId=con.Id,GE_HQ_Tier_3_P_L__c='testing',BMUserAccessType__c='power partner');
       insert u;*/
      
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
         
    datetime myDateTime = System.now().addmonths(-1);
     string AccID = u.Contact.AccountID;    
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=myDateTime;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testestingtestestingtestestingtestestingtestesting';
    
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=u.id;
    insert cs;

    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
  /*  Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    boolean isSelected = true; 
    Test.StartTest();
    PredixCasesPageController pcpg1 = new PredixCasesPageController();
    pcpg1.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg1.testlstCase = lstCs;
     pcpg1.CurUser = u;
     
   // pcpg.hasAttachment = true;
   // pcpg.hasArticle=true;
    pcpg1.s='testing';
    pcpg1.InputValue='testing';
    pcpg1.RetrivedCaseId='testing';
   
    pcpg1.FirstPage();
     pcpg1.OffsetSize = 25;
    pcpg1.previous();
    pcpg1.next();
    pcpg1.casessize = 100;
    pcpg1.limitsize = 50;
    pcpg1.currentpage = 0;
  //  pcpg1.LastPage();
    pcpg1.getprev();
    pcpg1.getnxt();
    pcpg1.Submit();
    pcpg1.Cancel();
    pcpg1.getEnhanceCaseTypeOptions();
    pcpg1.getNewCasesDisplay();
      pcpg1.getRecordsToDisplay();
      pcpg1.getAckCasesDisplay();
       pcpg1.getClosedCasesDisplay();
  //  pcpg1.getP1PriorityCasesDisplay();
        pcpg1.CurUser = u;
    pcpg1.getP2PriorityCasesDisplay();
    pcpg1.getP3PriorityCasesDisplay();
    pcpg1.getP4PriorityCasesDisplay();
    pcpg1.getWorkingCasesDisplay();
    pcpg1.getResolvedCasesDisplay();
    pcpg1.getFiveHrsCasesDisplay ();
    pcpg1.getYesterdayCasesDisplay();
    pcpg1.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
    pcpg1.processSelected();
    pcpg1.getselectedNewCases();
    pcpg1.ShowClickedCases();
    pcpg1.ShowPriorityCases();
    pcpg1.ShowDateTimeCases();
    pcpg1.getRecordTypes();
    pcpg1.ShowStatusCases();
    pcpg1.getAnyTimeRecordsToDisplay();
    
    pcpg1.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg1.updateRecordType();
    pcpg1.selectedEnhancOptions='testing';
    pcpg1.globalNew = 'true'; 
    pcpg1.globalAcknowledged = 'true'; 
    pcpg1.globalNew = 'True';
    pcpg1.globalAcknowledged = 'False';
    pcpg1.globalClosed = 'True';
 
    pcpg1.FilterByStatus = '';
     pcpg1.FilterByStatus = 'Closed';
    pcpg1.FilterByPriority = '';
    pcpg1.FilterByDateTime = '';
     pcpg1.FilterByDateTime = 'System.now().addmonths(-1)';
   pcpg1.getNewFilterCasesDisplay();
     pcpg1.getClosedFilterCasesDisplay();
     pcpg1.isCommunityUser=false;
     pcpg1.CurUser = u;
      
    pcpg1.getAllPrioritiesRecordsToDisplay();
   // pcpg1.getAllStatusCasesDisplay();
   // pcpg1.getAckCasesDisplayWithFilters();
  
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
  
       Test.StopTest();
    }   
    
static  testMethod void validatePredixCasesPageController_test17(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     User u = new User(ProfileId = p.Id, username = 'prediccasepage15@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
    Datetime countMyCases =System.today();
     string AccID = u.Contact.AccountID;
    Case cs = new case ();
    cs.Status = 'Resolved';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testingtestingtestingtestingtestingtestingtestingtestingtesting';
    cs.Type='testing';
     cs.ContactId=con.id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=u.id;
    insert cs;
                
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
     /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
    
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
     pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
    pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
 //   pcpg.LastPage();
  /*  pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
 //   pcpg.getNewCasesDisplay();
  //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
  //  pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
    
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test18(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     User u = new User(ProfileId = p.Id, username = 'prediccasepage16@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
          string AccID = u.Contact.AccountID;      
        Datetime countMyCases =System.today();
        Case cs = new case ();
        cs.Status = 'Working';
        cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
        cs.Priority = 'P4–Level 4–No impact to service';
        cs.Subject = 'demo';
        //cs.CreatedDate=countMyCases;
        cs.createdByID = UserInfo.GetUserID();
        cs.Description='testingtestingtestingtestingtestingtestingtestingtestingtesting';
        cs.Type='testing';
         cs.ContactId=con.Id;
        cs.AccountId=AccID;
        cs.GE_OG_Predix_Company__c='testing';
        cs.GE_OG_Predix_Product__c='testing';
       cs.recordtypeid=rt.id;
       cs.OwnerId=u.id;
        insert cs;
 
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
   /* Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/

    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];

    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
     pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
  //  pcpg.LastPage();
   /* pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
 //   pcpg.getNewCasesDisplay();
  //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
   // pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
  //  pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/

    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test19(){
    
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     User u = new User(ProfileId = p.Id, username = 'prediccasepage17@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;

    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con;  
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
    Datetime countMyCases =System.today();
     string AccID = u.Contact.AccountID;
    Case cs = new case ();
    cs.Status = 'Working';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P3–Level 3–Limited loss of service';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testingtestingtestingtestingtestingtestingtestingtestingtesting';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=u.id;
    insert cs;
   
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
                  
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.isCommunityUser=true;
    pcpg.FirstPage();
    pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
  //  pcpg.LastPage();
   /* pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
  //  pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
    
   
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    Test.stopTest();
    }
    
static  testMethod void validatePredixCasesPageController_test21(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account a = new Account (Name = 'newAcc1343');  
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;
        Contact con = new Contact (AccountId = a.id,LastName = 'portalTestUserv431', FirstName='portalTestU43serv2',MobilePhone='1234333454564',email='drf@ge.com');
        insert con;
        //Create user

    Profile p = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
    User u = new User(
    profileId = p.id,
    username = 'prediccasepage18@yahoo.com',
    email = 'p34344444b@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nus322er',
    lastname='lastname',
    contactId = con.id,
    GE_HQ_Tier_3_P_L__c='testing43443'
    );
    insert u;
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    
    string AccID = u.Contact.AccountID;         
    datetime myDateTime = System.now().addmonths(-1);
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=myDateTime;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testestingtestestingtestestingtestestingtestesting';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=u.id;
    insert cs;
        
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
    
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 
     
     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
                  
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
     /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
       
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
         
    String globalMyCases='True';
    Integer offsetsizeForlast=1;       
    boolean isSelected = true; 
    Test.StartTest();
    PredixCasesPageController pcpg1 = new PredixCasesPageController();
    pcpg1.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg1.testlstCase = lstCs;
     pcpg1.CurUser = u;
     
   // pcpg.hasAttachment = true;
   // pcpg.hasArticle=true;
    pcpg1.s='testing';
    pcpg1.InputValue='testing';
    pcpg1.RetrivedCaseId='testing';
   
    pcpg1.FirstPage();
    pcpg1.OffsetSize = 25;
    pcpg1.previous();
    pcpg1.next();
    pcpg1.casessize = 100;
    pcpg1.limitsize = 50;
    pcpg1.currentpage = 0;
   // pcpg1.LastPage();
   /* pcpg1.getprev();
    pcpg1.getnxt();
    pcpg1.Submit();
    pcpg1.Cancel();
    pcpg1.getEnhanceCaseTypeOptions();
    pcpg1.getNewCasesDisplay();
    pcpg1.getRecordsToDisplay();
    pcpg1.getAckCasesDisplay();
    pcpg1.getClosedCasesDisplay();
  //  pcpg1.getP1PriorityCasesDisplay();
    pcpg1.getP2PriorityCasesDisplay();
    pcpg1.getP3PriorityCasesDisplay();
    pcpg1.getP4PriorityCasesDisplay();
    pcpg1.getWorkingCasesDisplay();
    pcpg1.getResolvedCasesDisplay();
    pcpg1.getFiveHrsCasesDisplay ();
    pcpg1.getYesterdayCasesDisplay();
    pcpg1.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
    pcpg1.processSelected();
    pcpg1.getselectedNewCases();
    pcpg1.ShowClickedCases();
    pcpg1.ShowPriorityCases();
    pcpg1.ShowDateTimeCases();
    pcpg1.getRecordTypes();
    pcpg1.ShowStatusCases();
    pcpg1.getAnyTimeRecordsToDisplay();
    
    pcpg1.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg1.updateRecordType();*/
    pcpg1.selectedEnhancOptions='testing';
      pcpg1.globalNew = 'True'; 
    pcpg1.globalAcknowledged = 'True'; 
  
  //  pcpg1.globalAcknowledged = 'False';
    pcpg1.globalClosed = 'True';
   
    
    pcpg1.FilterByStatus = '';
    pcpg1.FilterByStatus = 'Closed';
    pcpg1.FilterByPriority = '';
    pcpg1.FilterByDateTime = '';
     pcpg1.FilterByDateTime = 'FIVE_HOURS';
    pcpg1.getNewFilterCasesDisplay();
    pcpg1.isCommunityUser = true;
    pcpg1.CurUser = u;
    pcpg1.globalMyCompanyCases = 'False';
    pcpg1.getAllStatusCasesDisplay();
    pcpg1.isCommunityUser=true;
    pcpg1.globalMyCompanyCases='True';
    pcpg1.localOffsetSizeAllCompCases=1;
    pcpg1.isCommunityUser = true;
    Set<String> rdInt = new Set<String>();
    rdInt.add(rt.Id);
    pcpg1.AllowedRecordtypeID = rdInt;
   pcpg1.getCompanyRecordsToDisplay();
  pcpg1.ShowClickedCompanyCases();
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
  
       Test.StopTest();
    }   
    static  testMethod void validatePredixCasesPageController_test22(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account a = new Account (Name = 'newAcc1343');  
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;
        Contact con = new Contact (AccountId = a.id,LastName = 'portalTestUserv431', FirstName='portalTestU43serv2',MobilePhone='1234333454564',email='drff@ge.com');
        insert con;
        //Create user

    Profile p = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
    User u = new User(
    profileId = p.id,
    username = 'prediccasepage19@yahoo.com',
    email = 'p34344444b@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nus322er',
    lastname='lastname',
    contactId = con.id,
    GE_HQ_Tier_3_P_L__c='testing43443'
    );
    insert u;
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
             
    datetime myDateTime = System.now().addmonths(-1);
    string AccID = u.Contact.AccountID;
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=myDateTime;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testestingtestestingtestestingtestestingtestesting';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=u.id;
    insert cs;
        
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
    
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 
     
     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
                  
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
     /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
       
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
         
    String globalMyCases='True';
    Integer offsetsizeForlast=1;       
    boolean isSelected = true; 
    Test.StartTest();
    PredixCasesPageController pcpg1 = new PredixCasesPageController();
    pcpg1.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg1.testlstCase = lstCs;
     pcpg1.CurUser = u;
     
   // pcpg.hasAttachment = true;
   // pcpg.hasArticle=true;
    pcpg1.s='testing';
    pcpg1.InputValue='testing';
    pcpg1.RetrivedCaseId='testing';
   
    pcpg1.FirstPage();
    pcpg1.OffsetSize = 25;
    pcpg1.previous();
    pcpg1.next();
    pcpg1.casessize = 100;
    pcpg1.limitsize = 50;
    pcpg1.currentpage = 0;
   // pcpg1.LastPage();
   /* pcpg1.getprev();
    pcpg1.getnxt();
    pcpg1.Submit();
    pcpg1.Cancel();
    pcpg1.getEnhanceCaseTypeOptions();
    pcpg1.getNewCasesDisplay();
    pcpg1.getRecordsToDisplay();
    pcpg1.getAckCasesDisplay();
    pcpg1.getClosedCasesDisplay();
  //  pcpg1.getP1PriorityCasesDisplay();
    pcpg1.getP2PriorityCasesDisplay();
    pcpg1.getP3PriorityCasesDisplay();
    pcpg1.getP4PriorityCasesDisplay();
    pcpg1.getWorkingCasesDisplay();
    pcpg1.getResolvedCasesDisplay();
    pcpg1.getFiveHrsCasesDisplay ();
    pcpg1.getYesterdayCasesDisplay();
    pcpg1.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
    pcpg1.processSelected();
    pcpg1.getselectedNewCases();
    pcpg1.ShowClickedCases();
    pcpg1.ShowPriorityCases();
    pcpg1.ShowDateTimeCases();
    pcpg1.getRecordTypes();
    pcpg1.ShowStatusCases();
    pcpg1.getAnyTimeRecordsToDisplay();
    
    pcpg1.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg1.updateRecordType();*/
    pcpg1.selectedEnhancOptions='testing';
      pcpg1.globalNew = 'True'; 
    pcpg1.globalAcknowledged = 'True'; 
  
  //  pcpg1.globalAcknowledged = 'False';
    pcpg1.globalClosed = 'True';
   
    
    pcpg1.FilterByStatus = '';
    pcpg1.FilterByStatus = 'Closed';
    pcpg1.FilterByPriority = '';
   pcpg1.FilterByDateTime = '';
    pcpg1.FilterByDateTime = 'LAST_MONTH';
     pcpg1.FilterByDateTime = 'YESTERDAY';
    pcpg1.getNewFilterCasesDisplay();
    pcpg1.getAllStatusCasesDisplay();
   
    pcpg1.globalMyCompanyCases='True';
    pcpg1.localOffsetSizeAllCompCases=1;
   pcpg1.getCompanyRecordsToDisplay();
  pcpg1.ShowClickedCompanyCases();
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
  
       Test.StopTest();
    }   
    
static  testMethod void validatePredixCasesPageController_test23(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account a = new Account (Name = 'newAcc1343');  
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; a.Classification__c = 'Silver';
        a.type ='EPC'; insert a;
        Contact con = new Contact (AccountId = a.id,LastName = 'portalTestUserv431', FirstName='portalTestU43serv2',MobilePhone='1234333454564',email='test7@ge.com');
        insert con;
        //Create user

    Profile p = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
    User u = new User(
    profileId = p.id,
    username = 'prediccasepage20@yahoo.com',
    email = 'p34344444b@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nus322er',
    lastname='lastname',
    contactId = con.id,
    GE_HQ_Tier_3_P_L__c='testing43443'
    );
    insert u;
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
             
    datetime myDateTime = System.now().addmonths(-1);
    string AccID = u.Contact.AccountID;
    Case cs = new case ();
    cs.Status = 'Closed';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=myDateTime;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='test';
    cs.Type='testing';
     cs.ContactId=con.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=u.id;
    insert cs;
        
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
    
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 
     
     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
                  
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
     /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=a.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=con.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
       
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
         
    String globalMyCases='True';
    Integer offsetsizeForlast=1;       
    boolean isSelected = true; 
    Test.StartTest();
    PredixCasesPageController pcpg1 = new PredixCasesPageController();
    pcpg1.StrUserInfo =u.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg1.testlstCase = lstCs;
     pcpg1.CurUser = u;
     
   // pcpg.hasAttachment = true;
   // pcpg.hasArticle=true;
    pcpg1.s='testing';
    pcpg1.InputValue='testing';
    pcpg1.RetrivedCaseId='testing';
   
    pcpg1.FirstPage();
     pcpg1.OffsetSize = 25;
    pcpg1.previous();
    pcpg1.next();
    pcpg1.casessize = 100;
    pcpg1.limitsize = 50;
    pcpg1.currentpage = 0;
   // pcpg1.LastPage();
   /* pcpg1.getprev();
    pcpg1.getnxt();
    pcpg1.Submit();
    pcpg1.Cancel();
    pcpg1.getEnhanceCaseTypeOptions();
    pcpg1.getNewCasesDisplay();
    pcpg1.getRecordsToDisplay();
    pcpg1.getAckCasesDisplay();
    pcpg1.getClosedCasesDisplay();
  //  pcpg1.getP1PriorityCasesDisplay();
    pcpg1.getP2PriorityCasesDisplay();
    pcpg1.getP3PriorityCasesDisplay();
    pcpg1.getP4PriorityCasesDisplay();
    pcpg1.getWorkingCasesDisplay();
    pcpg1.getResolvedCasesDisplay();
    pcpg1.getFiveHrsCasesDisplay ();
    pcpg1.getYesterdayCasesDisplay();
    pcpg1.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
    pcpg1.processSelected();
    pcpg1.getselectedNewCases();
    pcpg1.ShowClickedCases();
    pcpg1.ShowPriorityCases();
    pcpg1.ShowDateTimeCases();
    pcpg1.getRecordTypes();
    pcpg1.ShowStatusCases();
    pcpg1.getAnyTimeRecordsToDisplay();
    
    pcpg1.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg1.updateRecordType();*/
    pcpg1.selectedEnhancOptions='testing';
      pcpg1.globalNew = 'True'; 
    pcpg1.globalAcknowledged = 'True'; 
  
  //  pcpg1.globalAcknowledged = 'False';
    pcpg1.globalClosed = 'True';
   
    
    pcpg1.FilterByStatus = '';
    pcpg1.FilterByStatus = 'Closed';
    pcpg1.FilterByPriority = '';
    pcpg1.FilterByDateTime = '';
    pcpg1.FilterByDateTime = 'LAST_MONTH';
     pcpg1.FilterByDateTime = 'YESTERDAY';
    pcpg1.getNewFilterCasesDisplay();
    pcpg1.getAllStatusCasesDisplay();
   
    pcpg1.globalMyCompanyCases='True';
    pcpg1.localOffsetSizeAllCompCases=1;
   pcpg1.getCompanyRecordsToDisplay();
  pcpg1.ShowClickedCompanyCases();
  pcpg1.getAckCasesDisplayWithFilters();
  pcpg1.globalMyCompanyCases='False';
  pcpg1.globalMyCases='test';
    pcpg1.offsetsizeForlast=1;
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
  
       Test.StopTest();
    }   
   static  testMethod void validatePredixCasesPageController_test24(){
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account acc1 = new Account(name='testing');acc1.GE_HQ_DUNS_Number__c = 'GEGUL1012';acc1.RecordtypeId = CommAccrecType ;
        acc1.Classification__c = 'Silver';
        acc1.type ='EPC';
        insert acc1;
        Contact conCase = new Contact (AccountId = acc1.id,LastName = 'portalTestUserv1', FirstName='portalTestUserv2',MobilePhone='12333454564',email='test71@ge.com');
        insert conCase;
        //Create user

    Profile prfile = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
    
    User newUser1 = new User(
    profileId = prfile.id,
    username = 'prediccasepage21@yahoo.com',
    email = 'pb@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nuser',
    lastname='lastname',
    contactId = conCase.id,
    GE_HQ_Tier_3_P_L__c='testing'
    );
    insert newUser1;
        
       /* Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  

   Profile p = [SELECT Id FROM Profile WHERE Name='II Partner Community UO' limit 1]; 
     User u = new User(ProfileId = p.Id, username = 'test1111@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname',ContactId=con.Id,GE_HQ_Tier_3_P_L__c='testing',BMUserAccessType__c='power partner');
       insert u;*/
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
    // datetime myDateTime = System.now().addHours(-5);
     string AccID = newUser1.Contact.AccountID; 
    Case cs = new case ();
    cs.Status = 'Acknowledged';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=System.now().addHours(-5);
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testestingtestestingtestestingtestestingtestesting';
    
    cs.Type='testing';
     cs.ContactId=conCase.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=newUser1.id;
    insert cs;
    
   Case cs1 = new case ();
    cs1.Status = 'Acknowledged';
    cs1.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs1.Priority = 'P4–Level 4–No impact to service';
    cs1.Subject = 'demo';
    //cs1.CreatedDate=System.now().addHours(-5);
    cs1.createdByID = UserInfo.GetUserID();
    cs1.Description='testestingtestestingtestestingtestestingtestesting';
    
    cs1.Type='testing';
     cs1.ContactId=conCase.Id;
    cs1.AccountId=AccID;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
   cs1.recordtypeid=rt.id;
   cs1.OwnerId=newUser1.id;
    insert cs1;
                
         
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= prfile.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=acc1.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=conCase.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    boolean isSelected = true; 
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =newUser1.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
     pcpg.CurUser = newUser1;
   // pcpg.hasAttachment = true;
   // pcpg.hasArticle=true;
    pcpg.s='testing';
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
//pcpg.isCommunityUser=true;
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
   /* pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    
    pcpg.getNewCasesDisplay();
    
    pcpg.getRecordsToDisplay();
    pcpg.getAckCasesDisplay();
    pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
   pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
  pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
    pcpg.selectedEnhancOptions='testing';
    pcpg.globalNew = 'true'; 
    pcpg.globalAcknowledged = 'true'; 
         pcpg.globalNew = 'True';
    pcpg.globalAcknowledged = 'False';
    pcpg.globalClosed = 'True';
    pcpg.FilterByStatus = '';
    pcpg.FilterByPriority = '';
     pcpg.FilterByDateTime = '';
    pcpg.FilterByDateTime = 'LAST_MONTH';
     pcpg.FilterByDateTime = 'YESTERDAY';
 
   //pcpg.getNewFilterCasesDisplay();
    
 
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
      PredixCasesPageController.wrapcase  testwrap1 = new PredixCasesPageController.wrapcase(cs1);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    testwrap1.hasAttachment=true;
   testwrap1.hasArticle=true;
     Test.stopTest();
    }
    
    static  testMethod void validatePredixCasesPageController_test25(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account acc1 = new Account(name='testing');acc1.GE_HQ_DUNS_Number__c = 'GEGUL1012';acc1.RecordtypeId = CommAccrecType ;
        acc1.Classification__c = 'Silver';
        acc1.type ='EPC';
        insert acc1;
        Contact conCase = new Contact (AccountId = acc1.id,LastName = 'portalTestUserv1', FirstName='portalTestUserv2',MobilePhone='12333454564',email='test17@ge.com');
        insert conCase;
        //Create user

    Profile prfile = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
    
    User newUser1 = new User(
    profileId = prfile.id,
    username = 'prediccasepage22@yahoo.com',
    email = 'pb@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nuser',
    lastname='lastname',
    contactId = conCase.id,
    GE_HQ_Tier_3_P_L__c='testing'
    );
    insert newUser1;
        
       /* Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  

   Profile p = [SELECT Id FROM Profile WHERE Name='II Partner Community UO' limit 1]; 
     User u = new User(ProfileId = p.Id, username = 'test1111@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname',ContactId=con.Id,GE_HQ_Tier_3_P_L__c='testing',BMUserAccessType__c='power partner');
       insert u;*/
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
    // datetime myDateTime = System.now().addHours(-5);
     string AccID = newUser1.Contact.AccountID; 
    Case cs = new case ();
    cs.Status = 'Acknowledged';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=System.now().addHours(-5);
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testestingtestestingtestestingtestestingtestesting';
    
    cs.Type='testing';
     cs.ContactId=conCase.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=newUser1.id;
    insert cs;
    
   Case cs1 = new case ();
    cs1.Status = 'Acknowledged';
    cs1.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs1.Priority = 'P4–Level 4–No impact to service';
    cs1.Subject = 'demo';
    //cs1.CreatedDate=System.now().addHours(-5);
    cs1.createdByID = UserInfo.GetUserID();
    cs1.Description='test';
    
    cs1.Type='testing';
     cs1.ContactId=conCase.Id;
    cs1.AccountId=AccID;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
   cs1.recordtypeid=rt.id;
   cs1.OwnerId=newUser1.id;
    insert cs1;
                
         
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= prfile.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=acc1.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=conCase.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    boolean isSelected = true; 
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =newUser1.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
     pcpg.CurUser = newUser1;
   // pcpg.hasAttachment = true;
   // pcpg.hasArticle=true;
    pcpg.s='testing';
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
//pcpg.isCommunityUser=true;
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
   /* pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    
    pcpg.getNewCasesDisplay();
    
    pcpg.getRecordsToDisplay();
    pcpg.getAckCasesDisplay();
    pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
   pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
  pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
    pcpg.selectedEnhancOptions='testing';
    pcpg.globalNew = 'true'; 
    pcpg.globalAcknowledged = 'true'; 
         pcpg.globalNew = 'True';
    pcpg.globalAcknowledged = 'False';
    pcpg.globalClosed = 'True';
    pcpg.FilterByStatus = '';
    pcpg.FilterByPriority = '';
    pcpg.FilterByDateTime = '';
    pcpg.FilterByDateTime = 'LAST_MONTH';
     pcpg.FilterByDateTime = 'YESTERDAY';
     
   //pcpg.getNewFilterCasesDisplay();
    
 
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
      PredixCasesPageController.wrapcase  testwrap1 = new PredixCasesPageController.wrapcase(cs1);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    testwrap1.hasAttachment=true;
   testwrap1.hasArticle=true;
     Test.stopTest();
    } 
    
    
    /*static  testMethod void validatePredixCasesPageController_test000(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    
    Profile p = [SELECT Id FROM Profile WHERE Name='II Partner Community IPS']; 
    
    Account a  = new Account(name='testing');
    a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  
    a.Classification__c = 'Silver';
    a.type ='EPC';
        insert a;
    
    Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
    insert con; 
    
    User u = new User(ProfileId = p.Id, username = 'prediccasepage23@ge.com', email = 'test1@ge.com',
       EmailEncodingKey='UTF-8', localesidkey = 'en_US',
       languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
     alias='cserwu', lastname='lastname',contactid=con.id,GE_HQ_Tier_3_P_L__c='test');
       insert u;
       
    
            
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
           
    Datetime countMyCases =System.today();
    
    string AccID = u.Contact.AccountID;
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = ',';
    cs.Priority = 'P1–Level 1–Catastrophic service failure';
    cs.Subject = 'demo';
    //cs.CreatedDate=countMyCases;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testing';
    cs.Type='testing';
    cs.ContactId=con.Id;
    cs.AccountId=a.id;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
    cs.recordtypeid=rt.id;
    cs.OwnerId=u.id;
    insert cs;
           
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
       
   // List<Attachment> attachments=[select id, name from Attachment where parent.id=:cs.id];
   // System.assertEquals(1, attachments.size());
   
/*   Technical_Support__kav tt = new Technical_Support__kav();
  // tt.ArticleType ='test';
     tt.Details__c ='test';
      tt.Language ='en_US';
    //  tt.PublishStatus='test';
      tt.Summary='test';
        tt.Title='test';
         tt.UrlName='test';
         insert tt;
          
*/          
  
     //KnowledgeArticle ka =   [SELECT ArchivedById,ArchivedDate,ArticleNumber,CaseAssociationCount,FirstPublishedDate,Id,LastPublishedDate FROM KnowledgeArticle where id=:tt.id limit 1];
    
    /*CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    //ca.KnowledgeArticleId =ka.id;
    insert ca; 
 
    FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
    EntitySubscription newES = new EntitySubscription();
    newES.ParentId =cs.id;
    newES.SubscriberId = UserInfo.getUserId();
    Insert newES;
              
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= p.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;*/
                       
    /*Enhancement__c es = new Enhancement__c();
    es.Name='testing';
    es.Account_Name__c=a.id;
    es.Case_Type__c='testing';
    es.Contact_Name__c=con.id;
    es.Description__c='testing';
    es.Product__c='testing';
    es.Subject__c='testing';
    insert es; */

   /* CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
   
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
     pcpg.StrUserInfo =u.Id;   
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.selectedcases  = new list<case>();
    pcpg.selectedpriority = new list<case>();
    pcpg.prioritycases = new list<case>();
    pcpg.display_contributorlist = new list<PredixCasesPageController.wrapcase>();
    pcpg.display_Searchcaselist = new list<PredixCasesPageController.wrapcase>();
    pcpg.searchResults = new list<PredixCasesPageController.wrapcase>();
    
    pcpg.CurUser = u;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
   // pcpg.isCommunityUser=true;
    pcpg.FirstPage();
    pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
    pcpg.getNewCasesDisplay();/*
  /* pcpg.LastPage();
    pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    //pcpg.getClosedFilterCasesDisplay();
    pcpg.getEnhanceCaseTypeOptions();
    //pcpg.getNewCasesDisplay();
    //pcpg.getRecordsToDisplay();
    //pcpg.getAckCasesDisplay();
    //pcpg.getClosedCasesDisplay();
  // pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    // pcpg.isSelected=true;
    //pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
   
    /*pcpg.globalNew = 'True';
    pcpg.globalAcknowledged = 'False';
    pcpg.globalClosed = 'True';
    pcpg.globalClosed = 'False';
    
    pcpg.FilterByStatus = '';
    pcpg.FilterByPriority = '';
  pcpg.FilterByDateTime = '';
    pcpg.FilterByDateTime = 'LAST_MONTH';
     pcpg.FilterByDateTime = 'YESTERDAY';
 
   
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
    testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    test.stoptest();
    }*/
    
    static  testMethod void validatePredixCasesPageController_test26(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account acc1 = new Account(name='testing');acc1.GE_HQ_DUNS_Number__c = 'GEGUL1012';acc1.RecordtypeId = CommAccrecType ;
        acc1.Classification__c = 'Silver';
        acc1.type ='EPC';
        insert acc1;
        Contact conCase = new Contact (AccountId = acc1.id,LastName = 'portalTestUserv1', FirstName='portalTestUserv2',MobilePhone='12333454564',email='test5@ge.com');
        insert conCase;
        //Create user

    Profile prfile = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
    
    User newUser1 = new User(
    profileId = prfile.id,
    username = 'prediccasepage24@yahoo.com',
    email = 'pb@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nuser',
    lastname='lastname',
    contactId = conCase.id,
    GE_HQ_Tier_3_P_L__c='testing'
    );
    insert newUser1;
        
       /* Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  

   Profile p = [SELECT Id FROM Profile WHERE Name='II Partner Community UO' limit 1]; 
     User u = new User(ProfileId = p.Id, username = 'test1111@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname',ContactId=con.Id,GE_HQ_Tier_3_P_L__c='testing',BMUserAccessType__c='power partner');
       insert u;*/
    
    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
    // datetime myDateTime = System.now().addHours(-5);
     string AccID = newUser1.Contact.AccountID; 
    Case cs = new case ();
    cs.Status = 'Acknowledged';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=System.now().addHours(-5);
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='test';
    
    cs.Type='testing';
     cs.ContactId=conCase.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=newUser1.id;
    insert cs;
    
   Case cs1 = new case ();
    cs1.Status = 'Acknowledged';
    cs1.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs1.Priority = 'P4–Level 4–No impact to service';
    cs1.Subject = 'demo';
    //cs1.CreatedDate=System.now().addHours(-5);
    cs1.createdByID = UserInfo.GetUserID();
    cs1.Description='testestingtestestingtestestingte';
    
    cs1.Type='testing';
     cs1.ContactId=conCase.Id;
    cs1.AccountId=AccID;
    cs1.GE_OG_Predix_Company__c='testing';
    cs1.GE_OG_Predix_Product__c='testing';
   cs1.recordtypeid=rt.id;
   cs1.OwnerId=newUser1.id;
    insert cs1;
                
         
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

     FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= prfile.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
    /*Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=acc1.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=conCase.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    boolean isSelected = true; 
    test.starttest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =newUser1.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
     pcpg.CurUser = newUser1;
   // pcpg.hasAttachment = true;
   // pcpg.hasArticle=true;
    pcpg.s='testing';
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    //pcpg.isCommunityUser=true;
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
   // pcpg.LastPage();
   /* pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    
    pcpg.getNewCasesDisplay();
    
    pcpg.getRecordsToDisplay();
    pcpg.getAckCasesDisplay();
    pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
   pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
  pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();*/
    pcpg.selectedEnhancOptions='testing';
    pcpg.globalNew = 'true'; 
    pcpg.globalAcknowledged = 'true'; 
         pcpg.globalNew = 'True';
    pcpg.globalAcknowledged = 'False';
    pcpg.globalClosed = 'True';
    pcpg.FilterByStatus = '';
    pcpg.FilterByPriority = '';
  pcpg.FilterByDateTime = '';
    pcpg.FilterByDateTime = 'LAST_MONTH';
     pcpg.FilterByDateTime = 'YESTERDAY';
     
   //pcpg.getNewFilterCasesDisplay();
    
 
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
      PredixCasesPageController.wrapcase  testwrap1 = new PredixCasesPageController.wrapcase(cs1);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
    testwrap1.hasAttachment=true;
   testwrap1.hasArticle=true;
     Test.stopTest();
    }
    static  testMethod void validatePredixCasesPageController_test28(){
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account acc1 = new Account(name='testing');acc1.GE_HQ_DUNS_Number__c = 'GEGUL1012';acc1.RecordtypeId = CommAccrecType ;
        acc1.Classification__c = 'Silver';
        acc1.type ='EPC';
        insert acc1;
        Contact conCase = new Contact (AccountId = acc1.id,LastName = 'portalTestUserv1', FirstName='portalTestUserv2',MobilePhone='12333454564',email='tst@ge.com');
        insert conCase;
        //Create user

    Profile prfile = [select Id,name from Profile where UserType in :customerUserTypes limit 1];

    User newUser1 = new User(
    profileId = prfile.id,
    username = 'prediccasepage12@yahoo.com',
    email = 'pb@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nuser',
    lastname='lastname',
    contactId = conCase.id,
    GE_HQ_Tier_3_P_L__c='testing'
    );
    insert newUser1;
        
       /* Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  

   Profile p = [SELECT Id FROM Profile WHERE Name='II Partner Community UO' limit 1]; 
     User u = new User(ProfileId = p.Id,  = 'test1111@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname',ContactId=con.Id,GE_HQ_Tier_3_P_L__c='testing',BMUserAccessType__c='power partner');
       insert u;*/

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    string AccID = newUser1.Contact.AccountID;
    datetime myDateTime = System.now().addmonths(-1);
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=myDateTime;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testestingtestestingtestestingtestestingtestesting';
    cs.Type='testing';
     cs.ContactId=conCase.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=newUser1.id;
    insert cs;
                
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    List<Attachment> attachments=[select id, name from Attachment where parent.id=:cs.id];
    System.assertEquals(1, attachments.size());
        
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

    FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= prfile.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
                           
  /*  Enhancement__c es = new Enhancement__c();
     es.Name='testing';
     es.Account_Name__c=acc1.id;
     es.Case_Type__c='testing';
     es.Contact_Name__c=conCase.id;
     es.Description__c='testing';
     es.Product__c='testing';
     es.Subject__c='testing';
     insert es;*/
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
           
    boolean isSelected = true; 
    test.StartTest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =newUser1.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = newUser1;
    //pcpg.hasAttachment = true;
    //pcpg.hasArticle=true;
    pcpg.s='testing';
    pcpg.casesSize=10;
    pcpg.InputValue='testing';
    pcpg.RetrivedCaseId='testing';
    pcpg.FirstPage();
     pcpg.OffsetSize = 25;
    pcpg.previous();
    pcpg.next();
    pcpg.casessize = 100;
    pcpg.limitsize = 50;
    pcpg.currentpage = 0;
  //  pcpg.LastPage();
    pcpg.getprev();
    pcpg.getnxt();
    pcpg.Submit();
    pcpg.Cancel();
    pcpg.getEnhanceCaseTypeOptions();
    pcpg.getNewCasesDisplay();
    pcpg.getRecordsToDisplay();
    pcpg.getAckCasesDisplay();
    pcpg.getClosedCasesDisplay();
  //  pcpg.getP1PriorityCasesDisplay();
    pcpg.getP2PriorityCasesDisplay();
    pcpg.getP3PriorityCasesDisplay();
    pcpg.getP4PriorityCasesDisplay();
    pcpg.getWorkingCasesDisplay();
    pcpg.getResolvedCasesDisplay();
    pcpg.getFiveHrsCasesDisplay ();
   pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay();
    //pcpg.isSelected = true;
    pcpg.processSelected();
    pcpg.getselectedNewCases();
    pcpg.ShowClickedCases();
    pcpg.ShowPriorityCases();
    pcpg.ShowDateTimeCases();
    pcpg.getRecordTypes();
    pcpg.ShowStatusCases();
    pcpg.getAnyTimeRecordsToDisplay();
    
    pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    pcpg.updateRecordType();
    pcpg.selectedEnhancOptions='testing';
    pcpg.globalNew = 'true'; 
    pcpg.globalAcknowledged = 'true'; 
    pcpg.globalNew = 'True';
    pcpg.globalAcknowledged = 'False';
    pcpg.globalClosed = 'True';
    pcpg.FilterByStatus = '';
    pcpg.FilterByPriority = '';
    pcpg.FilterByDateTime = '';
     pcpg.FilterByDateTime = 'System.now().addmonths(-1)';
   pcpg.getNewFilterCasesDisplay();
    // pcpg.getClosedFilterCasesDisplay();
    
    pcpg.globalMyCompanyCases='True';
     pcpg.isCommunityUser=true;
     pcpg.CurUser = newUser1;
   //pcpg.getAllPrioritiesRecordsToDisplay();
    
 
    PredixCasesPageController.wrapcase  testwrap = new PredixCasesPageController.wrapcase(cs);
   testwrap.hasAttachment=true;
   testwrap.hasArticle=true;
   Test.stopTest();
    }
    
    static  testMethod void validatePredixCasesPageController_test29(){
            String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
    
    Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account acc1 = new Account(name='testing');acc1.GE_HQ_DUNS_Number__c = 'GEGUL1012';acc1.RecordtypeId = CommAccrecType ;
        acc1.Classification__c = 'Silver';
        acc1.type ='EPC';
        insert acc1;
        Contact conCase = new Contact (AccountId = acc1.id,LastName = 'portalTestUserv1', FirstName='portalTestUserv2',MobilePhone='12333454564',email='test2@ge.com');
        insert conCase;
        //Create user

    Profile prfile = [select Id,name from Profile where UserType in :customerUserTypes limit 1];

    User newUser1 = new User(
    profileId = prfile.id,
    username = 'prediccasepage12@yahoo.com',
    email = 'pb@f.com',
    emailencodingkey = 'UTF-8',
    localesidkey = 'en_US',
    languagelocalekey = 'en_US',
    timezonesidkey = 'America/Los_Angeles',
    alias='nuser',
    lastname='lastname',
    contactId = conCase.id,
    GE_HQ_Tier_3_P_L__c='testing'
    );
    insert newUser1;
 

    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
    string AccID = newUser1.Contact.AccountID;
    datetime myDateTime = System.now().addmonths(-1);
    Case cs = new case ();
    cs.Status = 'New';
    cs.Community_Last_Modified_User__c = 'testing,demo,demo1,demo2,demo3,';
    cs.Priority = 'P4–Level 4–No impact to service';
    cs.Subject = 'demo';
    //cs.CreatedDate=myDateTime;
    cs.createdByID = UserInfo.GetUserID();
    cs.Description='testestingtestestingtestestingtestestingtestesting';
    cs.Type='testing';
     cs.ContactId=conCase.Id;
    cs.AccountId=AccID;
    cs.GE_OG_Predix_Company__c='testing';
    cs.GE_OG_Predix_Product__c='testing';
   cs.recordtypeid=rt.id;
   cs.OwnerId=newUser1.id;
    insert cs;
                
    Attachment attach=new Attachment(); 
    attach.Name='Unit Test Attachment1'; 
    Blob bodyBlo1b = Blob.valueOf('Unit Test Attachment1 Body'); 
    attach.body=bodyBlo1b; 
    attach.parentId=cs.Id; 
    attach.ContentType = 'applicat11ion/msword'; 
    attach.IsPrivate = false; 
    attach.Description = 'Test1'; 
    insert attach; 
            
    List<Attachment> attachments=[select id, name from Attachment where parent.id=:cs.id];
    System.assertEquals(1, attachments.size());
        
    CaseArticle ca = new CaseArticle();
    ca.CaseId= cs.id;
    ca.KnowledgeArticleId ='kA012000000D81ZCAS';
    insert ca; 

    FeedItem  pp = new FeedItem();
    //pp.CreatedDate=System.today();
    pp.Body='welcome to salesforce knowledge2';
    pp.ParentId=cs.id;
    insert pp;
    
    FeedComment fc = new FeedComment();
    fc.CommentBody = 'legal test4';
    fc.FeedItemId = pp.Id;
    insert fc;
    System.assertEquals ('legal test4', fc.commentbody);
     
     EntitySubscription newES = new EntitySubscription();
      newES.ParentId =cs.id;
      newES.SubscriberId = UserInfo.getUserId();
      Insert newES;
      
    PredixCustomSetting__c pd = new PredixCustomSetting__c();
    pd.Company__c='testing';
    pd.PermissionSet_Name__c='testing';
    pd.Priority__c = 'test;demo;demo1;demo2;demo3;';
    pd.Product__c = 'TESTING';
    pd.ProfileName__c= prfile.id ;
    pd.RecordType__c= 'Predix IPS';
    pd.Status__c='New;Acknowledged;Working;Resolved;Closed;';
    pd.Name='testing';
    insert pd;
 
 
    CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
         
    boolean isSelected = true; 
    test.StartTest();
    PredixCasesPageController pcpg = new PredixCasesPageController();
    pcpg.StrUserInfo =newUser1.Id;
    list<Case> lstCs = new list<Case>();
    lstCs.add(cs);
    pcpg.testlstCase = lstCs;
    pcpg.CurUser = newUser1;
     
    Set<String> strRd = new Set<String>();
    strRd.add(rt.id);
    pcpg.AllowedRecordtypeID = strRd;
    pcpg.isCommunityUser=true;
    pcpg.getRecordsToDisplay();
    pcpg.testAccountId = acc1.Id;
    pcpg.globalMyCompanyCases='False';
    pcpg.StrUserInfo =newUser1.Id;
    pcpg.CurUser = newUser1;
    pcpg.getAnyTimeRecordsToDisplay(); 
    pcpg.isCommunityUser=true;
    pcpg.getYesterdayCasesDisplay();
    pcpg.getlastmonthCasesDisplay(); 
    pcpg.currentPage = 2;
    pcpg.Pagecount =10;
    pcpg.next();
    pcpg.casessize = 10;
    pcpg.limitsize = 5;
    pcpg.LastPage();
    Set<String> strRd1 = new Set<String>();
    strRd1.add(rt.id);
    pcpg.AllowedRecordtypeID = strRd1;
    pcpg.getNewCasesDisplay();
    pcpg.localOffsetSizeAllCompCases = 1;
    Set<String> strRd2 = new Set<String>();
    strRd2.add(rt.id);
    pcpg.AllowedRecordtypeID = strRd2;
    pcpg.CurUser = newUser1;
    pcpg.getCompanyRecordsToDisplay();
    pcpg.isCommunityUser = false;
    pcpg.globalMyCompanyCases = 'True';
    pcpg.getAllPrioritiesRecordsToDisplay();
   Test.stopTest();
    }
    
 }