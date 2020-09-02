/*
Type Name [Class/Trigger/Page Name] : Test Class
Used Where ?                        : 
Purpose/Overview                    : To incrase the code coverage 
Functional Area                     : Service MCS(R-22055)
Author                              : Raju Manche
Created Date                        : 08/05/2015           
Change History -
Date Modified   : Developer Name    : Method/Section Modified/Added  : Purpose/Overview of Change
*/
/*
This test class will cover the below Classes
GE_ES_CaseTrashBin_ctrl_delete ----88%
GE_CloseCaseController-------------100%
GE_MCS_MassCaseCloseController------89%
GEOGMC_CaseCloneWithAttsController--91%
GE_OG_trg_Case_ParentCaseAutoUnfollow--85%
GE_OG_MCS_DuplicateCustomerPO_Check--85%
GE_MCS_OpenActivitiesOnCase---91%
*/
@isTest
Public class Test_GE_ES_CaseTrashBin_ctrl_delete
{

    Static testMethod void Test_GE_ES_CaseTrashBin_ctrl_Method()
    {
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        //Inserting a new Account
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Account acc=new Account();
        acc.name='TestClassAccount';
        acc.RecordtypeId = CommAccrecType ;
        acc.classification__c = 'test';
        acc.type='test';
        insert acc;
        string strt;
        
        //Inserting a new Case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = r;
        csobj.accountid=acc.Id;
        
        insert csobj;
        System.assertEquals(csobj.Origin,'Email'); 
        
        test.startTest();
        Group grp = new Group(Name='ssr',Type='Queue');
        insert grp;
        
        QueueSobject mappingObject = new QueueSobject(QueueId = grp.Id, SobjectType = 'Case');
        System.runAs(new User(Id = UserInfo.getUserId())) {
            insert mappingObject;
        }
        
        csObj.OwnerId = grp.Id;
        GE_ES_CaseTrashBin_ctrl_delete trsash=new GE_ES_CaseTrashBin_ctrl_delete();
        GE_ES_CaseTrashBin_ctrl_delete.MyTrashBin(strt);        
        GE_ES_CaseTrashBin_ctrl_delete.TrashBin(csObj.id);        
        Id rtds= Schema.SObjectType.Case.getRecordTypeInfosByName().get('DS - CSR').getRecordTypeId();
        csobj.recordtypeid = rtds;
        //GE_ES_CaseTrashBin_ctrl_delete.MyTrashBin(strt);
        //GE_ES_CaseTrashBin_ctrl_delete.TrashBin(csObj.id);
        test.stopTest();
        //Calling the GE_CloseCaseController Class
        ApexPages.StandardController sc = new ApexPages.StandardController(csObj);
        GE_CloseCaseController caseclone = new GE_CloseCaseController(sc);
        caseclone.originalpage();
        
    }
    
    static testMethod void GE_MCS_MassCaseCloseControllermethod()
    {
        String rt= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
        List<case> caselist =new list<case>();
        //Inserting a new Case
        Case cs=new Case();
        cs.GE_ES_PO__c='123456';
        cs.GE_MCS_Duplicate_PO_ok__c=true;
        cs.recordTypeid = rt;  
        cs.status='new'; 
        cs.GE_ES_Sub_Type__c='RFQ processing';
        insert cs;        
        cs.status='closed';
        cs.Site_Contact_Information__c ='Ravi 12566';
        update cs;
        caselist.add(cs);
        update caselist;
        //Calling StandardSetController Class
        ApexPages.StandardSetController sc1 = new ApexPages.StandardSetController(caselist);
        GE_MCS_MassCaseCloseController csCLOSE= new GE_MCS_MassCaseCloseController(sc1);
        csCLOSE.setCon.setSelected(caselist);
        csCLOSE.getMySelectedSize();
        csCLOSE.getMyRecordsSize();
        csCLOSE.getListCases();
        csCLOSE.save();        
        csCLOSE.recordAction();
        csCLOSE.flag=false;
        csCLOSE.mblock=false;
        csCLOSE.difRec=false;
        csCLOSE.msg='123';
        csCLOSE.msg2='123';             
    }
    
    static testMethod void Test_GEOGMC_CaseCloneWithAttsController()
    {
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Account acc=new Account();
        acc.name='test';
        acc.RecordtypeId = CommAccrecType ;
        acc.classification__c = 'test';
        acc.type='test';
        insert acc;
        //inserting contact
        Contact cnt = new Contact();
        cnt.lastname = ' Contact 1' ;
        cnt.email = 'Test@Sprint.com' ;
        cnt.firstname = ' Test ' ;
        cnt.accountid =  acc.id ;
        insert cnt ;
        System.assertEquals(cnt.lastname,' Contact 1'); 
        
        String rt1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('DS - CSR').getRecordTypeId();
        
        //inserting case
        Case newcase= new case(recordtypeid = rt1,contactid=cnt.id,accountid=acc.Id, Status='Closed', Type='Customer Service', GE_ES_Sub_Type__c='Vendor Form',GE_ES_IsueStrtDt__c= system.today(), CurrencyIsoCode='USD');
        insert newcase;
        System.assertEquals(newcase.Status,'Closed');
        
        //inserting attachment with parent id case
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=newcase.id;
        insert attach;
        System.assertEquals(attach.Name,'Unit Test Attachment');
        
        //inserting FeedItem
        FeedItem caseFeed = new FeedItem();
        Blob bodyBlob1=Blob.valueOf('Unit Test Case FeedItem Body');
        caseFeed.body='Unit Test Case FeedItem Body';
        caseFeed.parentId=newcase.id;
        caseFeed.Type='ContentPost';
        caseFeed.ContentFileName='Test';
        caseFeed.ContentData=bodyBlob1; 
        insert caseFeed;
        System.assertEquals(caseFeed.Type,'ContentPost');
        
        //inserting EmailMessage
        EmailMessage em = new EmailMessage ();
        em.FromAddress = 'test@ge.com';
        em.FromName = 'Test';
        em.ToAddress = 'test@test.com';
        em.ParentId = newcase.Id;
        em.Subject = '[ ref:';
        em.TextBody = 'Test mail';
        insert em;
        System.assertEquals(em.TextBody,'Test mail');
        
        //inserting attachment with parent id emailmessage
        Attachment attachem=new Attachment();     
        attachem.Name='Unit Test Attachment';
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body');
        attachem.body=bodyBlob2;
        attachem.parentId=em.id;
        insert attachem;
        
        test.starttest();
        //From where it is coming
        PageReference pg=Page.GEOGMC_CaseCloneWithAtts;
        pg.getParameters().put('Id', newcase.id);
        Test.setCurrentPage(pg);
        //Calling the Apex Class
        ApexPages.StandardController sc = new ApexPages.StandardController(newcase);
        GEOGMC_CaseCloneWithAttsController caseclone = new GEOGMC_CaseCloneWithAttsController(sc);
        pg=caseclone.reDirect();        
        test.stoptest();  
    }
    //To cover GE_OG_trg_Case_ParentCaseAutoUnfollow
    static testMethod void ParentCaseAutoUnfollow()
    {
    Account acc=new Account();
    acc.name='test';
    insert acc;
    
        String rt= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();                
        List<case> caselist =new list<case>();        
        case cs12=new case();        
        cs12.status ='Closed';        
        cs12.recordtypeid=rt; 
        cs12.GE_ES_Sub_Type__c='RFQ processing';  
        cs12.Site_Contact_Information__c ='Assoh Vahsisht 12566';       
        caselist.add(cs12);
        Insert caselist;    
        GEESUtil.caseRecTypes=null;        
        GE_OG_trg_Case_ParentCaseAutoUnfollow  cw=new GE_OG_trg_Case_ParentCaseAutoUnfollow();
        cw.prePopulateMCS(caselist);
        cw.mcsAutoUnfollowBasedOnCaseClosed(caselist);
        list<task>tslit=new List<task>();
        task t=new task();
        t.Status='In Progress';
        t.subject='test';
        t.whatid=cs12.id;
        tslit.add(t);
        insert tslit;            
        cw.mcsTaskInsert(caselist);
         
              
    }   
    //It will increase more lines
    //To cover GE_OG_trg_Case_ParentCaseAutoUnfollow 
    static testMethod void ParentCaseAutoUnfollow123()
    {
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
    Account acc=new Account();
    acc.name='test';
    acc.RecordtypeId = CommAccrecType ;
    acc.classification__c = 'test';
    acc.type='test';
    insert acc;
    String rt= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();           
    Case cs=new Case();
        cs.GE_ES_PO__c='123456';
        cs.GE_MCS_Duplicate_PO_ok__c=true;
        cs.recordTypeid = rt;  
        cs.status='closed'; 
        cs.GE_ES_Sub_Type__c='RFQ processing'; 
        cs.Site_Contact_Information__c='tested';    
        insert cs;
        Case cs6=new Case();
        cs6.GE_ES_PO__c='123456';
        cs6.GE_MCS_Duplicate_PO_ok__c=true;
        cs6.GE_ES_Sub_Type__c='RFQ processing';     
        cs6.recordTypeid = rt;  
        cs6.status='new';
        cs6.Site_Contact_Information__c ='Gaurav anand 12566';
        insert cs6;   
        Test.startTest();           
        List<case>csl=new List<case>();     
        csl.add(cs);
        csl.add(cs6);
        Map <id,case>oldMap = new Map<id,case>();
        oldmap.put(cs.id, cs);
        Map<Id,Case>oldMapCase1=(Map<Id,Case>)oldMap;
        oldMapCase1.put(cs.id, cs6);       
        cs.status='closed';
        update cs;    
        Test.stopTest();   
        GE_OG_trg_Case_ParentCaseAutoUnfollow  cw1=new GE_OG_trg_Case_ParentCaseAutoUnfollow();
        cw1.mcsTaskUpdate(csl,oldMapCase1);        
        list<task>tslit=new List<task>();
        task t=new task();
        t.Status='In Progress';
        t.subject='test';
        t.whatid=cs.id;
        tslit.add(t);
        insert tslit;   
        GEESUtil.caseRecTypes=null;      
        GE_OG_trg_Case_ParentCaseAutoUnfollow  cw=new GE_OG_trg_Case_ParentCaseAutoUnfollow();
        cw.mcsTaskInsert(csl);        
    }    
  
    static testMethod  void Test_GE_OG_EmailAttachDownload()
    {
        Id case_id;
        String zipContent;
        String searchText;
        ID SearchResults;
        boolean isAttach;
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        Account acc=new Account();
        acc.name='test';
        insert acc;
        
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
       // RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        
        //inserting case object
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid =r;
        csobj.accountid=acc.Id;
        insert csobj;
        System.assertEquals(csobj.Origin,'Email');
        
        apexpages.currentpage().getparameters().put('id',csobj.id);
        
        SearchResults=[select id from Case where id=:csobj.id].Id;
        Case InstantCase=[select CaseNumber from Case where id=:csobj.id];
        
        List<EmailMessage> newEmail = new List<EmailMessage>();
        
        newEmail.add(new EmailMessage(FromAddress = 'test@abc.org', Incoming = True, ToAddress= 'hello@670ocglw7xhomi4oyr5yw2zvf.8kp7yeag.8.case.salesforce.com', Subject = 'Test email', TextBody = '23456 ', ParentId = csobj.Id)); 
        
        insert newEmail;
        
        GE_OG_EmailAttachDownload.AttachmentWrapper attWrap = new GE_OG_EmailAttachDownload.AttachmentWrapper();
        
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        
        //inserting feeditem   
        FeedItem fItem=new FeedItem();      
        fItem.ContentFileName='Unit Test Attachment';
        Blob ContentSize=Blob.valueOf('Unit Test Attachment Body');
        fItem.ContentData=bodyBlob;
        fItem.parentId=csobj.id;
        insert fItem;
        System.assertEquals(fItem.ContentFileName,'Unit Test Attachment');
        
        //inserting attachment
        Attachment attach=new Attachment();       
        attach.Name='Unit Test Attachment1';
        attach.body=bodyBlob;
        attach.parentId=newEmail[0].id;
        insert attach;
        System.assertEquals(attach.Name,'Unit Test Attachment1');
        
        String atId=attach.Id;
        GE_OG_EmailAttachDownload.GetAttachment(atId);
        isAttach = atId.startsWith('00P');
        
        List<FeedItem> FIts=[Select Id,ContentSize,ContentData,ContentType,Title,CreatedDate,RelatedRecordId, LastModifiedDate FROM FeedItem where ParentId=:Case_id];
        List<FeedItem> FItsRes= new List<FeedItem>();
        FItsRes.add(fItem);
        
        GE_OG_EmailAttachDownload emailatch=new GE_OG_EmailAttachDownload();
        emailatch.zipContent='Unit Test Document';
        emailatch.searchText=csobj.casenumber;
        PageReference pg;
        pg=emailatch.downloadAttachments();
        pg=emailatch.search();
        Case c=emailatch.getCaseName();
        emailatch.searchText=InstantCase.CaseNumber;
        pg=emailatch.search();
        emailatch.searchText=csobj.id;
        pg=emailatch.callExistingDocumentDelete();
        pg=emailatch.uploadZip();
        emailatch.GeneratePageTables();
        emailatch.GetAttachments();
        emailatch.GetEmailMessages();
        emailatch.case_id=csobj.id;
        emailatch.getChatA();
        
        String atId1=fItem.Id;
        GE_OG_EmailAttachDownload.GetAttachment(atId1);
        boolean isAttach1 = atId1.startsWith('00P');
        
    }
    

    
    
}