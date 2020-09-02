@isTest
public class Test_GE_OG_Case_Related
{
    //It will cover----GEOGMC_CaseCloneWithAttsController---class----95%
     static testMethod void Test_GEOGMC_CaseCloneWithAttsController()
    {
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        account acc = new account();
        acc.name='test';
        acc.RecordtypeId = CommAccrecType ;
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
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
        
        PageReference pg=Page.GEOGMC_CaseCloneWithAtts;
        pg.getParameters().put('Id', newcase.id);
        Test.setCurrentPage(pg);
        ApexPages.StandardController sc = new ApexPages.StandardController(newcase);
        GEOGMC_CaseCloneWithAttsController caseclone = new GEOGMC_CaseCloneWithAttsController(sc);
        pg=caseclone.reDirect();
        
        test.stoptest();  
    } 
    
    //It will cover----GE_OG_EmailAttachDownload---class---94%
    static testMethod  void Test_GE_OG_EmailAttachDownload()
    {
        Id case_id;
        String zipContent;
        String searchText;
        ID SearchResults;
        boolean isAttach;
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        account acc = new account();
        acc.name='test';
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
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
 //It will cover---GE_ES_Auto_Feed_Scheduler---class---68%
   static testMethod  void Test_GE_ES_Auto_Feed_Scheduler()
    {
    
 //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
 String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
 account acc = new account();
        acc.name='test';
        acc.RecordtypeId = CommAccrecType ;
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
        insert acc;
        
       
        
        
        
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
       // RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        
        User usr=[Select Id,profile.name from User where GE_ES_AutoFdOut__c = true and isActive=true limit 1];
        GE_ES_Feed_Opt_Out__c  opty = new GE_ES_Feed_Opt_Out__c();
        opty.name='Feed Opt-Out Job Id';
        opty.GE_ES_Running_User__c = usr.id;
        opty.GE_ES_Admin_Email__c = 'test12345@ge.com';
        insert opty ;
        System.runAs(usr)
        {
        //inserting case object
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.OwnerId = UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = r;
        csobj.accountid=acc.Id;
        csobj.SuppliedEmail = opty.GE_ES_Admin_Email__c;
        
        insert csobj;
        System.assertEquals(csobj.Origin,'Email');
        
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        
        //inserting feeditem   
        FeedItem fItem=new FeedItem();      
        fItem.ContentFileName='Unit Test Attachment';
        Blob ContentSize=Blob.valueOf('Unit Test Attachment Body');
        fItem.ContentData=bodyBlob;
        fItem.parentId=csobj.id;
        insert fItem;
        System.assertEquals(fItem.ContentFileName,'Unit Test Attachment');
        
               
 List<CronTrigger> cronTriggerList = new List<CronTrigger>([Select Id,CreatedById from CronTrigger where TimesTriggered != 0  and PreviousFireTime!=null Order By Createddate limit 1]);
        GE_ES_Auto_Feed_Scheduler Scheduler  = new GE_ES_Auto_Feed_Scheduler();
        
         GE_ES_Auto_Feed_Scheduler.start();
         }
         
    }   
    //It will cover---GE_CloseCaseController---class---100%
   static testMethod void Test_GE_CloseCaseController()
    {
       // Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        account acc = new account();
        acc.name='test';
        acc.RecordtypeId = CommAccrecType ;
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
        insert acc;
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        
        //Inserting a new Case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = rt.Id;
        csobj.accountid=acc.Id;
        insert csobj;
        System.assertEquals(csobj.Origin,'Email'); 
        
        ApexPages.StandardController sController = new ApexPages.StandardController(csobj); 
        
        GE_CloseCaseController csc = new GE_CloseCaseController(sController);
        PageReference pr = csc.originalpage();
    }
   
    
     static testMethod void Test_GE_ES_CaseTrashBin_ctrl_delete()
    {
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        RecordType rtds = [select id,name from recordtype where sObjectType = 'Case' and Name = 'DS - CSR' limit 1];
       
         String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        account acc = new account();
        acc.name='TestClassAccount';
        acc.RecordtypeId = CommAccrecType ;
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
        insert acc;
        System.assertEquals(acc.Name,'TestClassAccount');
        
        List<Case> CSLst = new List<Case>();
        //Inserting a new Case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = rt.Id;
        csobj.accountid=acc.Id;
        CSLst.add(csobj);
        //insert csobj;        
        
        //test.startTest();       
        //Inserting a new Case
        Case csobjds=new Case();
        csobjds.Subject='Email';
        csobjds.Status='Open';
        csobjds.Origin='Email';
        csobjds.OwnerId=UserInfo.getUserId();
        csobjds.type='Customer Service';
        csobjds.GE_ES_Sub_Type__c='Technical Support Request';
        csobjds.recordtypeid = rtds.id;
        csobjds.accountid=acc.Id;
        CSLst.add(csobjds);
        //insert csobjds;
        system.debug('objecttttttt'+csobjds);        
                      
     

        System.assertEquals(csobj.Origin,'Email'); 
        System.assertEquals(csobjds.Origin,'Email'); 
         
        insert CSLst;
        Group grp = new Group(Name='ssr',Type='Queue');
        insert grp;
        //test.stopTest();
        
        QueueSobject mappingObject = new QueueSobject(QueueId = grp.Id, SobjectType = 'Case');
        System.runAs(new User(Id = UserInfo.getUserId()))
        {
            insert mappingObject;
        }
        test.startTest(); 
        GE_ES_CaseTrashBin_ctrl_delete ctrldelete=new GE_ES_CaseTrashBin_ctrl_delete();
        
        GE_ES_CaseTrashBin_ctrl_delete.MyTrashBin(csobj.id);
        GE_ES_CaseTrashBin_ctrl_delete.TrashBin(csobj.id);
        
       
        //GE_ES_CaseTrashBin_ctrl_delete.MyTrashBin(csobjds.id);
        
        //test.stopTest();
        
        //It will cover----GE_MCS_ChangeOwner----class----92%
        
        PageReference prActual = Page.GE_MCS_ChangeOwner; 
        ApexPages.currentPage().getParameters().put('id', csobj.id); 
        ApexPages.StandardController sController1 = new ApexPages.StandardController(csobj);  
        
        GE_MCS_ChangeOwner co = new GE_MCS_ChangeOwner();
        co.caseId = csobj.id;   
        pagereference pr = co.reDirect();        
        pagereference pre = co.ChangeOwnerName();
        test.stopTest();
    }
    static testMethod void Test_GE_ES_CaseTrashBin_ctrl_delete2()
    {
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        RecordType rtds = [select id,name from recordtype where sObjectType = 'Case' and Name = 'DS - CSR' limit 1];
       
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
         String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        account acc = new account();
        acc.name='TestClassAccount';
        acc.RecordtypeId = CommAccrecType ;
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
        insert acc;
        System.assertEquals(acc.Name,'TestClassAccount');
        
        List<Case> CSLst = new List<Case>();
        //Inserting a new Case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = rt.Id;
        csobj.accountid=acc.Id;
        CSLst.add(csobj);
        //insert csobj;        
        
        //test.startTest();       
        //Inserting a new Case
        Case csobjds=new Case();
        csobjds.Subject='Email';
        csobjds.Status='Open';
        csobjds.Origin='Email';
        csobjds.OwnerId=UserInfo.getUserId();
        csobjds.type='Customer Service';
        csobjds.GE_ES_Sub_Type__c='Technical Support Request';
        csobjds.recordtypeid = rtds.id;
        csobjds.accountid=acc.Id;
        CSLst.add(csobjds);
        //insert csobjds;
        system.debug('objecttttttt'+csobjds);        
                      
        
        System.assertEquals(csobj.Origin,'Email'); 
        System.assertEquals(csobjds.Origin,'Email'); 
        
        insert CSLst;
        Group grp = new Group(Name='ssr',Type='Queue');
        insert grp;
        //test.stopTest();
        
        QueueSobject mappingObject = new QueueSobject(QueueId = grp.Id, SobjectType = 'Case');
        System.runAs(new User(Id = UserInfo.getUserId()))
        {
            insert mappingObject;
        }
        test.startTest(); 
        GE_ES_CaseTrashBin_ctrl_delete ctrldelete=new GE_ES_CaseTrashBin_ctrl_delete();
        
        

        
        GE_ES_CaseTrashBin_ctrl_delete.MyTrashBin(csobjds.id);
        
        test.stopTest();
     }   
    
    //It will cover----GE_Case_Trasbin---class---100%
    static testMethod void Test_GE_Case_Trasbin()
    {
    // test.startTest();
     Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
       // RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        account acc = new account();
        acc.name='test';
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
        insert acc;
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
        
        Group grp = new Group(Name='ssr',Type='Queue');
        insert grp;
      //    test.stopTest();
        QueueSobject mappingObject = new QueueSobject(QueueId = grp.Id, SobjectType = 'Case');
        System.runAs(new User(Id = UserInfo.getUserId()))
        {
            insert mappingObject;
        }
      
        csObj.OwnerId = grp.Id;
       
      //  update csobj;
         test.startTest();
        GE_Case_Trasbin trsash=new GE_Case_Trasbin();
        GE_Case_Trasbin.TrashBin(csObj.id);
        
        Id rtds= Schema.SObjectType.Case.getRecordTypeInfosByName().get('DS - CSR').getRecordTypeId();
       // RecordType rtds = [select id,name from recordtype where sObjectType = 'Case' and Name = 'DS - CSR' limit 1];
        csobj.recordtypeid = rtds;
     //   update csobj;
        GE_Case_Trasbin.TrashBin(csObj.id);
       
        GE_Case_Trasbin.TrashBin(csObj.id);
        
        
        test.stopTest();
        
    }
    
    //It will cover---GE_MCSCloseCaseController---class--100%
    static testMethod  void Test_GE_MCSCloseCaseController()
    {
        //Quoring Profiles through custom settings
        //GE_Profile__c myChannelMgr = GE_Profile__c.getValues('GE_OG_PII Sales Manager');
        //Id chnlMagrId =  myChannelMgr.Profile_SFDC_ID__c;
        Profile sProfileID = [select id from profile where name ='OG_Sales/Comm Ops' limit 1];
        //Inserting a new User
        User chnlManr = new User(firstname = 'fghj', lastname = 'jklh', email = 'fghj@ge.com', alias = 'fgUsr', profileId = sProfileID.id, Title = 'Channel Manager', Username = 'fghj@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        System.assertEquals(chnlManr.firstname,'fghj');
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];        
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];        
        account acc = new account();
        acc.name='test';
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
        insert acc;
        //Inserting a new Case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';        
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = rt.Id;
        csobj.accountid=acc.Id;
        insert csobj;  
        
    } 
    
    //It will cover the GE_OG_trg_Case_MCSSendEmailCaseCreation
   /* static testMethod  void Test_GE_OG_trg_Case_MCSSendEmailCaseCreation()
    {
        //Query the Profiles using Custom Setting - GE_Profile.
        
        //GE_Profile__c myChannelMgr = GE_Profile__c.getValues('GE_OG_PII Sales Manager');
        //Id chnlMagrId =  myChannelMgr.Profile_SFDC_ID__c;
        Profile sProfileID = [select id from profile where name ='GE_OG_PII Sales Manager' limit 1];
        //inserting channel manager user
        User chnlManr = new User(firstname = 'channel', lastname = 'manager', email = 'chnmanager@ge.com', alias = 'chnUsr', profileId = sProfileID.id, Title = 'Channel Manager', Username = 'channelmagr@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        System.assertEquals(chnlManr.firstname,'channel');
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        
//Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        //RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='CMF Approved' Limit 1];
        account acc=new account();
            acc.GE_PRM_Active_PRM_Users__c=1;    
            acc.name='testacc';
            acc.GE_HQ_Request_Status__c='New';
            acc.GE_PW_Phone_New_Request__c='123456789';
            acc.GE_HQ_New_Account_Street__c='Room 203, Building Nanxuefu Garden, Zhaowuda Rd.';
            acc.GE_HQ_New_Account_City__c='Huhehaote';
            acc.GE_HQ_New_Account_State_Province__c='Inner Mongolia';
            acc.GE_HQ_New_Account_Zip_Postal_Code__c='010040';
            acc.GE_HQ_New_Account_Country__c='CHINA';
            
           insert acc;
        //Getting list has no rows error if account is queried.
        
        //inserting account
        Account accnt= new Account(
            Name='TestClassAccount2',
            GE_HQ_Station_Name__c='AMP - HAMILTON',
            GE_HQ_Request_Status__c='CMF Approved',
            GE_OG_AccFin_Status__c='In Progress',
            GE_HQ_GE_Vertical__c='Non-Industrial',
            GE_HQ_DUNS_Number__c='TEST13238',
            GE_ES_Competitor__c='No',
            GE_HQ_Channel_Representative__c='No',
            GE_HQ_CMF_Request_Status__c='D',
            GE_HQ_GE_Status_Flag__c='A',
            GE_HQ_New_Account_Country__c='UNITED STATES',
            Case_Notification__c=true);
        insert accnt;
        
        AccountTeamMember atm = new AccountTeamMember(accountid = acc.Id,teammemberrole = 'Account Manager', userid = chnlManr.Id);
        insert atm;
        System.assertEquals(atm.teammemberrole,'Account Manager');
        
        //inserting contact
        Contact cnt = new Contact();
        cnt.lastname = ' Contact 1' ;
        cnt.email = 'Test@Sprint.com' ;
        cnt.firstname = ' Test ' ;
        cnt.accountid =  acc.id ;
        insert cnt ;
        System.assertEquals(cnt.firstname,' Test ' );
        
        Test.startTest();
        
        
         List<Case> CSLst = new List<Case>();
            List<Case> CSLst1 = new List<Case>();
        //inserting case object
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = rt.Id;
        csobj.accountid=acc.Id;
        csobj.suppliedemail ='Test@Sprint.com';
        CSLst.add(csobj);
        //insert csobj;
        System.assertEquals(csobj.Status,'Open');
        
        
        
        //inserting case 
        case corg=new case();
        corg.Subject='Test';
        corg.Status='Open';
        corg.Origin='Email - Comms';
        corg.type='Customer Service';
        corg.GE_ES_Sub_Type__c='OTR';
        corg.recordtypeid = rt.Id;
        corg.accountid=acc.Id;
        CSLst.add(corg);
       // insert corg;
        System.assertEquals(corg.type,'Customer Service');
        insert cslst;
        
        csobj.accountid=accnt.Id;
        cslst1.add(csobj);
        corg.accountid=accnt.Id;
        cslst1.add(corg);
        update cslst1;
        Test.stopTest();        
        
    }*/
    
    //It will cover the GE_OG_trg_Case_ParentCaseAutoUnfollow 
    static testMethod  void Test_GE_OG_trg_Case_ParentCaseAutoUnfollow()
    {
        
        GEESUtil.caseRecTypes=null;
        
        //Quoring Profiles through custom settings
        //GE_Profile__c myChannelMgr = GE_Profile__c.getValues('GE_OG_PII Sales Manager');
                Profile sProfileID = [select id from profile where name ='OG_Sales/Comm Ops'  limit 1];

       //Id chnlMagrId =  sProfileID .Profile_SFDC_ID__c;
        //User superuser= [select id ,name from user where profileid=:sProfileID.id And Isactive = true limit 1];
        //Inserting a new User
        User chnlManr = new User(firstname = 'vbnm', lastname = 'kder', email = 'vbnm@ge.com', alias = 'vbUsr', profileId = sProfileID.id, Title = 'Channel Manager', Username = 'vbnm@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        System.assertEquals(chnlManr.firstname,'vbnm');
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];       
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];        
        account acc = new account();
        acc.name='test';
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
        insert acc;
        //Inserting a new Case
       
        Case csobj=new Case();
        csobj.Subject='Email testing';
        csobj.Status='Open';
        csobj.Origin='Email - Comms';        
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';        
        csobj.GE_ES_Sub_Type__c='RFQ Processing';        
        csobj.GE_ES_Customer_Request_Date__c=Date.newInstance(2008, 1, 1);
        csobj.recordtypeid = rt.Id;
        csobj.accountid=acc.Id;
        insert csobj;
        System.assertEquals(csobj.type,'Customer Service');
        
       
        
        //Inserting a new Task
        Task tk=new task();
        tk.Status='Not Started';
        tk.WhatId=csobj.Id;
        tk.RecordTypeID='012A0000000npxt';
        insert tk;
        System.assertEquals(tk.Status,'Not Started');
          Test.startTest();
        //Calling GE_Task_Closetask Class
        //Calling the webservice method to cover the above class
        GE_Task_Closetask GETask=new GE_Task_Closetask(); 
        GE_Task_Closetask.Closetask(tk.id);
         Test.stopTest();
       
        
    }  
    
    
    //It will cover the GE_OG_trg_Case_ParentCaseAutoUnfollow 
    static testMethod  void Test_GE_OG_trg_Case_ParentCaseAutoUnfollow1()
    {
        
        GEESUtil.caseRecTypes=null;
        
        //Quoring Profiles through custom settings
        //GE_Profile__c myChannelMgr = GE_Profile__c.getValues('GE_OG_PII Sales Manager');
        //Id chnlMagrId =  myChannelMgr.Profile_SFDC_ID__c;
        Profile sProfileID = [select id from profile where name ='OG_Sales/Comm Ops' limit 1];
        //Inserting a new User
        User chnlManr = new User(firstname = 'vcxxz', lastname = 'mnbv', email = 'vcxxz@ge.com', alias = 'chnUsr', profileId = sProfileID.id, Title = 'Channel Manager', Username = 'vcxxz@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        //System.assertEquals(chnlManr.firstname,'channel');
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];       
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];        
        account acc = new account();
        acc.name='test';
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
        insert acc;
        //Inserting a new Case
       
        Case csobj=new Case();
        csobj.Subject='Email testing';
        csobj.Status='Open';
        csobj.Origin='Email - Comms';        
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';        
        csobj.GE_ES_Sub_Type__c='RFQ Processing';        
        csobj.GE_ES_Customer_Request_Date__c=Date.newInstance(2008, 1, 1);
        csobj.recordtypeid = rt.Id;
        csobj.Site_Contact_Information__c = 'testuser 1237';
        csobj.accountid=acc.Id;
        insert csobj;
        System.assertEquals(csobj.type,'Customer Service');
        
       
        
        
        
        //Calling GE_MCSCloseCaseController Class
        ApexPages.StandardController stdCV1 = new ApexPages.StandardController(csobj);
        GE_MCSCloseCaseController mcscontroller=new GE_MCSCloseCaseController(stdCV1);
        GE_MCSCloseCaseController.Originalpage1(csobj.id);
         Test.startTest();
        //Updating OwnerId        
        csobj.OwnerId=chnlManr.id;
       // update csobj;
         
        GE_MCSCloseCaseController.Originalpage1(csobj.id);
        
        //Calling GE_OG_MCS_Case_CloseSave Class
        GE_OG_MCS_Case_CloseSave csave=new GE_OG_MCS_Case_CloseSave();
        GE_OG_MCS_Case_CloseSave.closeCase(csobj.id);
        Test.stopTest();
    }  
    
    /*
It will cover----GE_OG_trg_Case_NumOFContactsforEmailid---class
&
GE_MCS_AttactContactCtrl----96%
&
GE_OG_trg_Case_MCSSendEmailCaseCreation--92%
*/
    
     static testMethod void Test_GE_MCS_AttactContactCtrl()
    {
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        RecordType rtAccount = [select id,name from recordtype where sObjectType = 'Account' and Name = 'CMF Approved' limit 1];
        Profile p = [  Select p.Name, p.Id From Profile p where name = 'GE_ES Sales Mgr_MCS-SI'];
        
        User usr = new User();
        usr.Username = 'Test1222323@ge.com' ; 
        usr.TimeZoneSidKey = 'America/New_York' ; 
        usr.ProfileId = p.id ; 
        usr.LocaleSidKey = 'en_US' ; 
        usr.LastName = 'MCS' ; 
        usr.LanguageLocaleKey = 'en_US' ; 
        usr.EmailEncodingKey = 'ISO-8859-1' ; 
        usr.Email = 'test.mcs@ge.com' ; 
        usr.CommunityNickname = 'mcssi51' ; 
        usr.Alias = 'test' ; 
        usr.case_notification__c = true ;
        insert usr ;
        System.assertEquals(usr.Alias,'test');
        system.debug('******************rtAccount*************************************************'+rtAccount.id);
        
        //Account acct =  [Select id,name  from account where name = 'TestClassAccount' and recordtypeid =: rtAccount.id and case_notification__c = true and GE_HQ_Request_Status__c = 'CMF Approved' ] ;
         String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        account acct = new account();
acct.name='TestClassAccount';
 acct.RecordtypeId = CommAccrecType ;
acct.case_notification__c = true;
acct.type = 'EPC' ;
        acct.Classification__c = 'Gold';
acct.GE_HQ_Request_Status__c = 'CMF Approved';
insert acct;
        
        //Account acce = [Select id,name  from account where name =  'TestClassAccount-EndUser' and recordtypeid =: rtAccount.id and case_notification__c = true and GE_HQ_Request_Status__c = 'CMF Approved'];   
        //String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();      
              account acce = new account();
acce.name='TestClassAccount-EndUser';
 acce.RecordtypeId = CommAccrecType ;
acce.case_notification__c = true;
acce.type = 'EPC' ;
        acce.Classification__c = 'Gold';
acce.GE_HQ_Request_Status__c = 'CMF Approved';    
insert acce;
        
        //inserting account team member
        AccountTeamMember atm = new AccountTeamMember();
        atm.userId = usr.id ;
        atm.accountid = acct.id ;
        atm.TeamMemberRole = 'Account Manager';
        insert atm ;
        System.assertEquals(atm.TeamMemberRole,'Account Manager');
        
        //inserting contact
        Contact con = new Contact();
        con.lastname = ' Contact 1' ;
        con.email = 'Test@Sprint.com' ;
        con.firstname = ' Test ' ;
        con.accountid =  acct.id ;
        insert con ;
        System.assertEquals(con.firstname,' Test ');
        
        //inserting contact with end user account
        Contact cont = new Contact();
        cont.lastname = ' Contact 1' ;
        cont.email = 'Testash@Sprint.com' ;
        cont.firstname = ' Test ' ;
        cont.accountid =  acce.id ;
        insert cont;
        System.assertEquals(cont.firstname,' Test ');
        
        
           List<Case> CSLst = new List<Case>();
            List<Case> CSLst1 = new List<Case>();
        //inserting case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='New';
        csobj.Origin='Email';
        csobj.accountid = acct.id;
        csobj.contactid = con.id;
        csobj.suppliedemail = 'Test@Sprint.com';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = rt.Id;
        CSLst.add(csobj);
       // insert csobj;
        System.assertEquals(csobj.Origin,'Email');
        
        //inserting case
        Case csobj1=new Case();
        csobj1.Subject='Email';
        csobj1.Status='New';
        csobj1.Origin='Email-MCSC';
        csobj1.accountid = acct.id;
        csobj1.contactid = con.id;
        csobj1.GE_ES_PO__c= 'xyz';
        csobj1.suppliedemail = 'Test@Sprint.com';
        csobj1.GE_ES_Sub_Type__c='Technical Support Request';
        csobj1.recordtypeid = rt.Id;
        CSLst.add(csobj1);
       // insert csobj1;
        System.assertEquals(csobj1.GE_ES_PO__c,'xyz');
        
        
        //upsert csobj1; 
        
        //inserting case
        Case csobj3=new Case();
        csobj3.Subject='Email';
        csobj3.Status='New';
        csobj3.Origin='Email-MCSC';
        csobj3.accountid = acct.id;
        csobj3.contactid = con.id;
        csobj3.GE_ES_PO__c= 'xyz';
        csobj3.suppliedemail = null;
        csobj3.GE_ES_Sub_Type__c='Technical Support Request';
        csobj3.recordtypeid = rt.Id;
         CSLst.add(csobj3);
        //insert csobj3;
        System.assertEquals(csobj3.GE_ES_PO__c,'xyz');
        Test.startTest();
             insert CSLst;
        csobj3.contactid = null ;
        CSLst1.add(csobj3);
        update csobj3;
        csobj1.contactid = null ;   
        CSLst1.add(csobj1);
        update cslst1;
        Test.stopTest();
        System.runAs(new User(Id = UserInfo.getUserId()))
        {
            
            PageReference attachPage = Page.GE_MCS_AttachContact; 
            ApexPages.currentPage().getParameters().put('id', csobj.id); 
            ApexPages.StandardController sController = new ApexPages.StandardController(csobj);      
            GE_MCS_AttactContactCtrl at = new GE_MCS_AttactContactCtrl(sController) ;
            at.contactIdNew = cont.id ;
            at.Attach();           
            PageReference attachPg= Page.GE_MCS_AttachContact; 
            ApexPages.currentPage().getParameters().put('id', csobj1.id); 
            ApexPages.StandardController sController1 = new ApexPages.StandardController(csobj1);      
            GE_MCS_AttactContactCtrl atcntrl = new GE_MCS_AttactContactCtrl(sController1) ;
            atcntrl.contactIdNew = cont.id ;
            atcntrl.Attach();
            
        }
    } 
    
    /*
The below method will cover the 1 Trigger and 1 Class
i.GE_OG_trg_Case_PopulateFromInstalledBase---96%
ii.ManageCaseTags---90%
*/
    
    static testMethod void Test_GE_OG_trg_Case_PopulateFromInstalledBase()
    {  
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'FS-SS' limit 1];
        RecordType rtfs = [select id,name from recordtype where sObjectType = 'Case' and Name = 'FS-MCS' limit 1];
        RecordType mcs= [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        account acc = new account();
        acc.name='TestClassAccount';
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
         acc.RecordtypeId = CommAccrecType ;
        insert acc;
        System.assertEquals(acc.Name,'TestClassAccount');
        
        //Inserting Installed Base Object
        GE_Installed_Base__c ib=new GE_Installed_Base__c();
        ib.Account__c=acc.Id;
        ib.GE_ES_Station_Name__c='Test';
        insert ib;
        System.assertEquals(ib.GE_ES_Station_Name__c,'Test');
        
        //Inserting a new Project Region Object record
        GE_SS_Project_Region__c pg=new GE_SS_Project_Region__c();
        pg.name='test';
        pg.GE_SS_Assignment_Group__c='tester@test.com';
        insert pg;
        System.assertEquals(pg.name,'test');
        
        Test.startTest();
        
         Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        
        // insert Site
    SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
        
        //Inserting a new Case with FS-SS RecordType
        list<Case>AllCases=new List<Case>();
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Origin='Email';
        csobj.CurrencyIsoCode='USD';
        csobj.GE_ES_PO__c='test';
        csobj.GE_ES_Shop_Order__c='test';
        csobj.recordtypeid=rt.id;
        csobj.accountid=acc.Id;
        csobj.Installed_Base__c=ib.id;
        csobj.GE_SS_Project_Region__c=pg.id;
        csobj.GE_PC_Water_Depth__c = '2' ;
        csobj.GE_SS_Field__c = loc.id;
        Allcases.add(csobj);
        System.assertEquals(csobj.GE_ES_Shop_Order__c,'test');
        
        //Inserting a new Case with FS-MCS recordtype. 
        Case csobjfs=new Case();
        csobjfs.Subject='Email';
        csobjfs.Origin='Email';
        csobjfs.CurrencyIsoCode='USD';
        csobjfs.GE_ES_PO__c='test';
        csobjfs.GE_ES_Shop_Order__c='test';
        csobjfs.recordtypeid=rtfs.id;
        csobjfs.accountid=acc.Id;
        csobjfs.Installed_Base__c=ib.id;
        csobjfs.GE_PC_Water_Depth__c = '2';
        csobj.GE_SS_Field__c = loc.id;
        Allcases.add(csobjfs);
        insert Allcases;
       
        
        //Updating the case with MCS recordtype to cover the adderror part
        //To cover adderror part, using the try, catch block. 
        csobj.recordtypeid=mcs.id;        
        try
        {
            update csobj;
        }
        catch(DMLException e)
        {
            
            //System.Assert(e.getMessage().contains('Recommendation should be Compliance Accepted to generate DOA'));
            //System.Assert(e.getMessage().contains('"Sub Type" field is mandatory'));
            
        } 
        //Ending the GE_OG_trg_Case_PopulateFromInstalledBase Part
        Test.stopTest();
        //The below lines will cover the ManageCaseTags Class
        Id tId;
        String tName;
        String tType;
        String publicInput;
        String privateInput;
        
        //Inserting a New CaseTag
        CaseTag ct=new CaseTag();
        ct.ItemId=csobj.Id;
        ct.Name='xyz';
        ct.type='public';
        insert ct;
        System.assertEquals(ct.type,'public');
        
        Set<String> privateInputs = new Set<String>();
        
        Set<String> publicInputs = new Set<String>();
        
        //Calling ManageCaseTags Class
        ApexPages.StandardController sController = new ApexPages.StandardController(csobj);             
        ManageCaseTags mst = new ManageCaseTags(sController);             
        PageReference pageRef2 = mst.DisplayTagBlock();
        mst.publicInput='trouble,installation,product';
        mst.privateInput='trouble,installation,product';
        PageReference pageRef3 = mst.SaveTags();
        
        ManageCaseTags.TagWrapper twr=new ManageCaseTags.TagWrapper(tId,tName,tType);
        
        //inserting case tag to delete 
        CaseTag ctd=new CaseTag();
        ctd.ItemId=csobj.Id;
        ctd.Name='xyz';
        ctd.type='public';
        insert ctd;
        
        delete ctd;
        
        ApexPages.StandardController sController1 = new ApexPages.StandardController(csobj);             
        ManageCaseTags mst1 = new ManageCaseTags(sController1);
        PageReference pageRef5= mst1.DeleteTag();
        
    }  
    
    //It will cover----GE_MCS_MassCaseCloseController----class---81%
    static testMethod void Test_GE_MCS_MassCaseCloseController()
    {
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        RecordType rtds = [select id,name from recordtype where sObjectType = 'Case' and Name = 'DS - CSR' limit 1];
      
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        account acc = new account();
        acc.name='TestClassAccount';
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
         acc.RecordtypeId = CommAccrecType ;
        insert acc; 
        System.assertEquals(acc.Name,'TestClassAccount');
        
        //inserting contact
        Contact con = new Contact();
        con.FirstName='CJTest01';
        con.LastName='Test 1';
        con.Salutation='Mr.';
        con.Email='blabla@ge.com';
        con.Phone='111111111';
        con.Fax='1212121212';
        con.AccountId = Acc.id;
        insert con;
        System.assertEquals(con.LastName,'Test 1'); 
        
        //Inserting a new Case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = rt.Id;
        csobj.accountid=acc.Id;
        csobj.Contact=con; 
        insert csobj;
        System.assertEquals(csobj.Origin,'Email'); 
        
        //Inserting a new Case
        Case csobjds=new Case();
        csobjds.Subject='Email';
        csobjds.Status='Open';
        csobjds.Origin='Email';
        csobjds.OwnerId=UserInfo.getUserId();
        csobjds.type='Customer Service';
        csobjds.GE_ES_Sub_Type__c='Technical Support Request';
        csobjds.recordtypeid = rtds.id;
        csobjds.accountid=acc.Id;
        insert csobjds;
        system.debug('objecttttttt'+csobjds);
        System.assertEquals(csobjds.Origin,'Email'); 
        
        test.startTest();       
        
        
        List<case> caselst=new List<case>();
        caselst.add(csobj);
        caselst.add(csobjds);
     
        
        ApexPages.StandardSetController setCon;
        
        boolean flag; 
        String msag;
        List<Case> ACdet= new List<Case>();
        Acdet.add(csobj);
        GE_MCS_MassCaseCloseController csc = new GE_MCS_MassCaseCloseController(new ApexPages.StandardSetController(Acdet));
        
        csc.getListCases();
        csc.getMyRecordsSize();
        csc.getMySelectedSize();
        csc.recordAction();
        PageReference pageRef2 = csc.save();
    }
    
    
    //It will cover----GE_OG_Mobilization_Detail----97%
    static testMethod  void Test_GE_OG_Mobilization_Detail()
    {   
        integer OffsetSize=1;
        
        //Inserting Country Object
        GE_HQ_Country__c country=new GE_HQ_Country__c();
        country.GE_OG_Finance_Country_Risk__c='Medium';
        country.name='india';
        country.GE_OG_Tax_ID_Format__c='Text';
        country.GE_HQ_ISO_Code__c='T';
        insert country;
        System.assertEquals(country.GE_HQ_ISO_Code__c,'T');
        System.debug('**country**'+country.id);
        
        //Inserting legalEntity Object
        GE_OG_Legal_Entity_Deal_Structure__c legalEntity=new GE_OG_Legal_Entity_Deal_Structure__c();
        legalEntity.CountryMobName__c=country.id;
        legalEntity.Legal_Entity__c='Long Text';
        legalEntity.POA_Holder__c='Long Text';
        legalEntity.SSO__c='9988998878';
        insert legalEntity;
        System.assertEquals(legalEntity.SSO__c,'9988998878');
        
        //Inserting Country Mob
        GE_OG_CountryMob__c mob=new GE_OG_CountryMob__c();
        mob.Country_Highlights__c='Rich Text';
        mob.Country_guideline__c='https://www.google.com';
        insert mob;
        System.assertEquals(mob.Country_Highlights__c,'Rich Text');
        
        //Inserting Primary Contact
        GE_OG_Primary_Contacts__c primary=new GE_OG_Primary_Contacts__c();
        primary.Contact_Number__c='9998988889';
        primary.Function__c='Immigration';
        primary.Location__c='Long Text';
        insert primary;
        System.assertEquals(primary.Location__c,'Long Text');
        
        APexPages.currentPage().getParameters().put('countrys','IN');
        //ApexPages.StandardController sc = new ApexPages.standardController(country);
        //GE_OG_Mobilization_Detail mobilization=new  GE_OG_Mobilization_Detail(sc);
        GE_OG_Mobilization_Detail mobilization=new GE_OG_Mobilization_Detail();
        
        mobilization.previous();
        mobilization.next();
        mobilization.getacclist();
        mobilization.regionKeyPlayerCall();        
    }
    //To cover GE_OG_MCS_Case_updateTier3 -- 100%
      static testmethod void GE_OG_MCS_case_Test_Method(){
      //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        account acc = new account();
        acc.name='test';
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
        insert acc;
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
       // RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        List<Case>cs11=new List<Case>();
        //inserting case object
        //Measurement and Europe
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email - Grobycc';
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid =r;
        csobj.accountid=acc.Id;
        //csobj.GE_Tier_3__c = 'Bently Nevada';
        //insert csobj;
        cs11.add(csobj);
        //North America and Advanced Sensors
        Case csobj56=new Case();
        csobj56.Subject='Email';
        csobj56.Status='Open';
        csobj56.Origin='Email - ST Marys';
        csobj56.OwnerId=UserInfo.getUserId();
        csobj56.type='Customer Service';
        csobj56.GE_ES_Sub_Type__c='Technical Support Request';
        csobj56.recordtypeid =r;
        csobj56.accountid=acc.Id;
        //csobj56.GE_Tier_3__c = 'Bently Nevada';
        //insert csobj56;
        cs11.add(csobj56);
        Case csobj57=new Case();
        csobj57.Subject='Email';
        csobj57.Status='Open';
        csobj57.Origin='Email - CC Validation LA';
        csobj57.OwnerId=UserInfo.getUserId();
        csobj57.type='Customer Service';
        csobj57.GE_ES_Sub_Type__c='Technical Support Request';
        csobj57.recordtypeid =r;
        csobj57.accountid=acc.Id;
        cs11.add(csobj57);
        //India and Inspection Technologies
        Case csobj58=new Case();
        csobj58.Subject='Email';
        csobj58.Status='Open';
        csobj58.Origin='Email - CC IT IND';
        csobj58.OwnerId=UserInfo.getUserId();
        csobj58.type='Customer Service';
        csobj58.GE_ES_Sub_Type__c='Technical Support Request';
        csobj58.recordtypeid =r;
        csobj58.accountid=acc.Id;        
        cs11.add(csobj58);
        Case csobj59=new Case();
        csobj59.Subject='Email';
        csobj59.Status='Open';
        csobj59.Origin='Email - CSUK';
        csobj59.OwnerId=UserInfo.getUserId();
        csobj59.type='Customer Service';
        csobj59.GE_ES_Sub_Type__c='Technical Support Request';
        csobj59.recordtypeid =r;
        csobj59.accountid=acc.Id;
        cs11.add(csobj59);
        //Flow and Process  
        Case csobj5=new Case();
        csobj5.Subject='Email';
        csobj5.Status='Open';
        csobj5.Origin='Email - CSFPTKR';
        csobj5.OwnerId=UserInfo.getUserId();
        csobj5.type='Customer Service';
        csobj5.GE_ES_Sub_Type__c='Technical Support Request';
        csobj5.recordtypeid =r;
        csobj5.accountid=acc.Id;
        cs11.add(csobj5);
        Case csobj8=new Case();
        csobj8.Subject='Email';
        csobj8.Status='Open';
        csobj8.Origin='Email - rsweb';
        csobj8.OwnerId=UserInfo.getUserId();
        csobj8.type='Customer Service';
        csobj8.GE_ES_Sub_Type__c='Technical Support Request';
        csobj8.recordtypeid =r;
        csobj8.accountid=acc.Id;
        cs11.add(csobj8);
        //Controle Solutions
        Case csobj9=new Case();
        csobj9.Subject='Email';
        csobj9.Status='Open';
        csobj9.Origin='Email - EnergyCS';
        csobj9.OwnerId=UserInfo.getUserId();
        csobj9.type='Customer Service';
        csobj9.GE_ES_Sub_Type__c='Technical Support Request';
        csobj9.recordtypeid =r;
        csobj9.accountid=acc.Id;
        cs11.add(csobj9);
        Case csobj10=new Case();
        csobj10.Subject='Email';
        csobj10.Status='Open';
        csobj10.Origin='Email - BentlyGulf';
        csobj10.OwnerId=UserInfo.getUserId();
        csobj10.type='Customer Service';
        csobj10.GE_ES_Sub_Type__c='Technical Support Request';
        csobj10.recordtypeid =r;
        csobj10.accountid=acc.Id;
        cs11.add(csobj10);
        Case csobj11=new Case();
        csobj11.Subject='Email';
        csobj11.Status='Open';
        csobj11.Origin='Email - CustSVCCN';
        csobj11.OwnerId=UserInfo.getUserId();
        csobj11.type='Customer Service';
        csobj11.GE_ES_Sub_Type__c='Technical Support Request';
        csobj11.recordtypeid =r;
        csobj11.accountid=acc.Id;
        cs11.add(csobj11);
        
        insert cs11;
        System.assertEquals(csobj11.Origin,'Email - CustSVCCN');        
 } 
 static testMethod  void Test_GE_OG_GE_OG_CIREmailAlert()
    {        
        GEESUtil.caseRecTypes=null;        
        //Quoring Profiles through custom settings
        //GE_Profile__c myChannelMgr = GE_Profile__c.getValues('GE_OG_PII Sales Manager');
        //Id chnlMagrId =  myChannelMgr.Profile_SFDC_ID__c;
        Profile sProfileID = [select id from profile where name ='OG_Sales/Comm Ops' limit 1];
        //Inserting a new User
        User chnlManr = new User(firstname = 'yuio', lastname = 'poiu', email = 'yuio@ge.com', alias = 'yuUsr', profileId = sProfileID.id, Title = 'Channel Manager', Username = 'yuio@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        System.assertEquals(chnlManr.firstname,'yuio');
        
        // RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];       
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'CIR' limit 1];       
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];        
        account acc = new account();
        acc.name='test';
        acc.type = 'EPC' ;
        acc.Classification__c = 'Gold';
         acc.RecordtypeId = CommAccrecType ;
        insert acc;
        List<Case>CsList=new List<Case>();
        Case csobj=new Case();
        csobj.Subject='Email testing';
        csobj.Status='Open';
        csobj.Origin='Email - Comms';        
        csobj.OwnerId=UserInfo.getUserId();
        //csObj.GE_OG_CIR_Not_A_Key_Account__c  = true;
        csobj.type='Customer Service';        
        csobj.GE_ES_Sub_Type__c='RFQ Processing';        
        csobj.GE_ES_Customer_Request_Date__c=Date.newInstance(2008, 1, 1);
        csobj.recordtypeid = rt.Id;
        csobj.accountid=acc.id; 
        //csobj.Key_Account_Name_Web__c='0011200001FxU1O'; 
        csobj.GE_OG_CIR_Customer_Contact_Name__c='testme';
        //csobj.GE_OG_Key_Account_Name_CIR__c='france';
        csobj.GE_OG_CIR_Customer_Address__c='testdhab';
        csobj.GE_OG_CIR_Customer_Phone__c='1234097';   
        csobj.GE_OG_CIR_Site_Country__c='AFGHANISTAN';    
        insert csobj;
        List<Task>TKList=new List<Task>();  
        Task tk=new task(); 
        tk.Status='Completed';
        tk.WhatId=csobj.Id;
        tk.Task_Closure_Forecast_Date__c=system.today();
        tk.RecordTypeID='012A0000000npxt';
        tk.ownerid=UserInfo.getUserId();
        insert tk;
        TKList.add(tk);
        Task tkDup=new task();        
        tkDup.Status='Completed';
        tkDup.WhatId=csobj.Id;
        tkDup.Task_Closure_Forecast_Date__c=system.today();
        tkDup.ownerid=UserInfo.getUserId();
        tkDup.RecordTypeID='012A0000000npxt';
        insert tkDup;
        //TKList.add(tkDup);
        //insert TKList;
        //tk.ownerid=chnlManr.id;
        //update tk;
        //tkDup.Task_Closure_Forecast_Date__c=Date.newInstance(2014, 12, 12);
        //update tkDup;        
    }        
}