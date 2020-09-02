@istest

Public class Predixdashboardpagecontroller_test{
   
    static  testMethod void validatePredixCaseSearchController_test(){
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Set<String> customerUserTypes = new Set<String> {'CSPLiteUser', 'PowerPartner', 'PowerCustomerSuccess',   'CustomerSuccess'};
        Account a = new Account (Name = 'newAcc1');  
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
         a.Classification__c = 'Silver';
        a.type ='EPC';
        insert a;
        Contact con = new Contact (AccountId = a.id,LastName = 'portalTestUserv1', FirstName='portalTestUserv2',MobilePhone='12333454564',email='der@ge.com');
        insert con;
        Profile p = [select Id,name from Profile where UserType in :customerUserTypes limit 1];
        User u = new User(
        profileId = p.id,
        username = 'predixdashboard1@yahoo.com',
        email = 'psdddb@f.com',
        emailencodingkey = 'UTF-8',
        localesidkey = 'en_US',
        languagelocalekey = 'en_US',
        timezonesidkey = 'America/Los_Angeles',
        alias='user23',
        lastname='lastname',
        contactId = con.id,
        GE_HQ_Tier_3_P_L__c='testing'
        );
        insert u;
            
           // RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
                Datetime countMyCases = DateTime.Now();
                Case cs = new case ();
                cs.Status = 'New';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P1–Level 1–Catastrophic service failure';
                cs.Subject = 'demo';
                cs.CreatedDate=countMyCases;
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
         
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
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
                  delete newES;
                  
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
            //CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' AND ParentId =:cs.id limit 1];
             Test.startTest();
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
            
           pcpg.isCommunityUser=true;           
           pcpg.CurUser = u;
                 
          
            // pcpg.isCommunityUser=false;
            /*pcpg.next();
            pcpg.LastPage();
            pcpg.getprev();
            pcpg.getnxt(); */
          //  pcpg.searchText ='priyanka';
         
           pcpg.getResolvedCasesDisplay();
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='UnFollow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
           // pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
            pcpg.getP1PriorityCasesDisplay();
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            
           
            pcpg.getNewCasesDisplay();
            pcpg.getAckCasesDisplay();
            //pcpg.getClosedCasesDisplay();
           
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
            //pcpg.ShowDateTimeCases();
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
            //pcpg.getAnyTimeRecordsToDisplay();
          //  pcpg.save();
           //pcpg.Search();
            pcpg.getRecentCasesDisplay();
          //  pcpg.getfeedItems();
            //pcpg.getFeedComments();
            //pcpg.feedcommReferesh();
            pcpg.FollowCase();
           // pcpg.GetCaseFollow();
           pcpg.countMyCases ='Thismonth';
           pcpg.isCommunityUser = true;
           pcpg.myCases=0;
          pcpg.displayMonthCount();
          //  pcpg.displaySixMonthCount();
         
           
        pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
       pcpg.updateRecordType();

           // List<Predixdashboardpagecontroller.wrapcases> w;
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
          //  Predixdashboardpagecontroller.wrapFeedsData  testfeed = new Predixdashboardpagecontroller.wrapFeedsData(pp);
     // Predixdashboardpagecontroller.wrapFeedItems testfeed1 = new Predixdashboardpagecontroller.wrapFeedItems(pp);
              Test.stopTest();
    }

    static  testMethod void validatePredixCaseSearchController_test1(){
      
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'predixdashboard2@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
            Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  a.Classification__c = 'Silver';
            a.type ='EPC'; insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  
            
           // RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
         
                Case cs = new case ();
                cs.Status = 'Resolved';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P2–Level 2–Service failure';
                cs.Subject = 'demo';
                cs.CreatedDate=DateTime.Now();
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
                
                
         
            
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
                pp.Body='welcome to salesforce knowledge2';
                pp.ParentId=cs.id;
                insert pp;
                FeedComment fc = new FeedComment();
                fc.CommentBody = 'legal test4';
                fc.FeedItemId = pp.Id;
                insert fc;
                System.assertEquals ('legal test4', fc.commentbody);
                 
                 
                 
                 EntitySubscription newES = new EntitySubscription();
                  newES.ParentId = cs.Id;
                  newES.SubscriberId = UserInfo.getUserId();
                  Insert newES;
                  
                PredixCustomSetting__c pd = new PredixCustomSetting__c();
              //  pd.Company__c='testing';
                pd.PermissionSet_Name__c='testing';
                pd.Priority__c='test;demo';
               pd.Product__c='TESTING';
                pd.ProfileName__c= p.id ;
                pd.RecordType__c='Predix IPS';
                pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
                pd.Name='testing';
                insert pd;
               
               
           
              //CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' limit 99];
               Test.startTest();
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
            pcpg.CurUser = u;
        pcpg.isCommunityUser=true;
             pcpg.isCommunityUser=false;
         
          
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='Follow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
            pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
            //pcpg.getP1PriorityCasesDisplay();
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            //pcpg.getNewCasesDisplay();
            pcpg.getAckCasesDisplay();
            //pcpg.getClosedCasesDisplay();
            pcpg.getResolvedCasesDisplay();
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
            //pcpg.ShowDateTimeCases();
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
            //pcpg.getAnyTimeRecordsToDisplay();
          //  pcpg.save();
           //pcpg.Search();
            pcpg.getRecentCasesDisplay();
          //  pcpg.getfeedItems();
            //pcpg.getFeedComments();
            //pcpg.feedcommReferesh();
            pcpg.FollowCase();
           // pcpg.GetCaseFollow();
           
          pcpg.countMyCases = 'Sixmonths';
          pcpg.isCommunityUser = true;
          pcpg.displayMonthCount();
          
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
         
          test.stopTest();  
                   
    }
    
    static  testMethod void validatePredixCaseSearchController_test2(){
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'predixdashboard3@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
            Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; a.Classification__c = 'Silver';
            a.type ='EPC'; insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  
            
          //  RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
         
                Case cs = new case ();
                cs.Status = 'Closed';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P3–Level 3–Limited loss of service';
                cs.Subject = 'demo';
                cs.CreatedDate=DateTime.Now()-3;
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
                
                String selectedProduct ='demo';
               
         
            /* Attachment attach=new Attachment(); 
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
                ca.KnowledgeArticleId ='kA1K00000008VokKAE';
                insert ca; */
     
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
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
                pd.Priority__c='test;demo';
                pd.Product__c='TESTING';
                pd.ProfileName__c= p.id ;
                pd.RecordType__c='Predix IPS';
                pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
                pd.Name='testing';
                insert pd;
               
                Test.startTest();
           
              //CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' limit 99];
           
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
                 pcpg.CurUser = u;
           pcpg.isCommunityUser=true;
             pcpg.isCommunityUser=false;
            /*pcpg.next();
            pcpg.LastPage();
            pcpg.getprev();
            pcpg.getnxt(); */
          //  pcpg.searchText ='priyanka';
           pcpg.selectedProduct=selectedProduct;
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='UnFollow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
            pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
            //pcpg.getP1PriorityCasesDisplay();
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            //pcpg.getNewCasesDisplay();
            pcpg.getAckCasesDisplay();
            pcpg.getClosedCasesDisplay();
            pcpg.getResolvedCasesDisplay();
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
            //pcpg.ShowDateTimeCases();
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
            //pcpg.getAnyTimeRecordsToDisplay();
          //  pcpg.save();
           //pcpg.Search();
            pcpg.getRecentCasesDisplay();
          //  pcpg.getfeedItems();
            //pcpg.getFeedComments();
            //pcpg.feedcommReferesh();
            pcpg.FollowCase();
           // pcpg.GetCaseFollow();
          pcpg.displayMonthCount();
          
           
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
         
          Test.StopTest();           
    }
    
    static  testMethod void validatePredixCaseSearchController_test4(){

    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'predixdashboard4@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
            Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ;  a.Classification__c = 'Silver';
            a.type ='EPC'; insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  
            
          //  RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
         
                Case cs = new case ();
                cs.Status = 'Working';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P4–Level 4–No impact to service';
                cs.Subject = 'demo';
                cs.CreatedDate=DateTime.Now()-3;
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
                
                String searchText ='demo';
                string searchQuery = 'FIND {'+searchText+'} IN ALL FIELDS RETURNING Case(subject)';
         
            /* Attachment attach=new Attachment(); 
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
                ca.KnowledgeArticleId ='kA1K00000008VokKAE';
                insert ca; */
     
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
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
                pd.Priority__c='test;demo';
                pd.Product__c='TESTING';
                pd.ProfileName__c= p.id ;
                pd.RecordType__c='Predix IPS';
                pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
                pd.Name='testing';
                insert pd;
               
               
           
              //CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' limit 99];
                    Test.startTest();
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
                 pcpg.CurUser = u;
             pcpg.isCommunityUser=true;
             pcpg.isCommunityUser=false;
            /*pcpg.next();
            pcpg.LastPage();
            pcpg.getprev();
            pcpg.getnxt(); */
          //  pcpg.searchText ='priyanka';
           
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='UnFollow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
            pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
            //pcpg.getP1PriorityCasesDisplay();
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            //pcpg.getNewCasesDisplay();
            pcpg.getAckCasesDisplay();
            //pcpg.getClosedCasesDisplay();
            pcpg.getResolvedCasesDisplay();
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
            //pcpg.ShowDateTimeCases();
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
            //pcpg.getAnyTimeRecordsToDisplay();
          //  pcpg.save();
           //pcpg.Search();
            pcpg.getRecentCasesDisplay();
          //  pcpg.getfeedItems();
            //pcpg.getFeedComments();
            //pcpg.feedcommReferesh();
            pcpg.FollowCase();
           // pcpg.GetCaseFollow();
          pcpg.displayMonthCount();
          

           
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
          
          Test.StopTest();
                     
    }
    
    
  
    static  testMethod void validatePredixCaseSearchController_test7(){
        
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'predixdashboard7@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
            Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
            a.Classification__c = 'Silver';
            a.type ='EPC';          insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  
            
         //   RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
         
                Case cs = new case ();
                cs.Status = 'Resolved';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P2–Level 2–Service failure';
                cs.Subject = 'demo';
                cs.CreatedDate=DateTime.Now();
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
  
     
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
                pp.Body='welcome to salesforce knowledge2';
                pp.ParentId=cs.id;
                insert pp;
                FeedComment fc = new FeedComment();
                fc.CommentBody = 'legal test4';
                fc.FeedItemId = pp.Id;
                insert fc;
                System.assertEquals ('legal test4', fc.commentbody);
                 
                 
                 
                 EntitySubscription newES = new EntitySubscription();
                  newES.ParentId = cs.Id;
                  newES.SubscriberId = UserInfo.getUserId();
                  Insert newES;
                  
                PredixCustomSetting__c pd = new PredixCustomSetting__c();

                pd.PermissionSet_Name__c='testing';
                pd.Priority__c='test;demo';
           pd.Product__c='TESTING';
                pd.ProfileName__c= p.id ;
                pd.RecordType__c='Predix IPS';
                pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
                pd.Name='testing';
                insert pd;
               
               
           
              //CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' limit 99];
            test.startTest(); 
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
            pcpg.CurUser = u;
        pcpg.isCommunityUser=true;
             pcpg.isCommunityUser=false;
            /*pcpg.next();
            pcpg.LastPage();
            pcpg.getprev();
            pcpg.getnxt(); */
     
           
         
           pcpg.NewCase='testing';
           pcpg.selectedBugOptions='test';
           pcpg.selectedSuggestOptions='test';
           pcpg.selectedCompany='test';
           pcpg.selectedStatus='new';
           pcpg.selectedPriority='test';
           pcpg.selectedEnhancOptions='test';
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='UnFollow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
            pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
            //pcpg.getP1PriorityCasesDisplay();
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            //pcpg.getNewCasesDisplay();
            pcpg.getAckCasesDisplay();
            //pcpg.getClosedCasesDisplay();
            pcpg.getResolvedCasesDisplay();
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
            //pcpg.ShowDateTimeCases();
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
            //pcpg.getAnyTimeRecordsToDisplay();
          //  pcpg.save();
           //pcpg.Search();
            pcpg.getRecentCasesDisplay();
          //  pcpg.getfeedItems();
            //pcpg.getFeedComments();
            //pcpg.feedcommReferesh();
            pcpg.FollowCase();
           // pcpg.GetCaseFollow();
           pcpg.Save();
           pcpg.Savemycase();
           pcpg.getCaseRecordTypes();
           pcpg.updateCaseRecordType();
           pcpg.ShowFeed_Comment();
          pcpg.countMyCases = 'OneYear';
          pcpg.isCommunityUser = true;
          pcpg.displayMonthCount();
          //  pcpg.displaySixMonthCount();
         
           
         //  pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
          // pcpg.updateRecordType();

           // List<Predixdashboardpagecontroller.wrapcases> w;
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
          //  Predixdashboardpagecontroller.wrapFeedsData  testfeed = new Predixdashboardpagecontroller.wrapFeedsData(pp);
          //  Predixdashboardpagecontroller.wrapFeedItems testfeed1 = new Predixdashboardpagecontroller.wrapFeedItems(cf);
          Test.stopTest();  
                   
    }
    static  testMethod void validatePredixCaseSearchController_test8(){
        
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'predixdashboard8@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
            Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
            a.Classification__c = 'Silver';
            a.type ='EPC';
            insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  
            
          //  RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
         
                Case cs = new case ();
                cs.Status = 'Resolved';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P2–Level 2–Service failure';
                cs.Subject = 'demo';
                cs.CreatedDate=DateTime.Now();
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
                
                
       
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
                pp.Body='welcome to salesforce knowledge2';
                pp.ParentId=cs.id;
                insert pp;
                FeedComment fc = new FeedComment();
                fc.CommentBody = 'legal test4';
                fc.FeedItemId = pp.Id;
                insert fc;
                System.assertEquals ('legal test4', fc.commentbody);
                 
                 
                 
                 EntitySubscription newES = new EntitySubscription();
                  newES.ParentId = cs.Id;
                  newES.SubscriberId = UserInfo.getUserId();
                  Insert newES;
                  
                PredixCustomSetting__c pd = new PredixCustomSetting__c();
              //  pd.Company__c='testing';
                pd.PermissionSet_Name__c='testing';
                pd.Priority__c='test;demo';
             pd.Product__c='TESTING';
                pd.ProfileName__c= p.id ;
                pd.RecordType__c='Predix IPS';
                pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
                pd.Name='testing';
                insert pd;
               
             Test.startTest();
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
            pcpg.CurUser = u;
        pcpg.isCommunityUser=true;
             pcpg.isCommunityUser=false;
            
          
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='UnFollow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
            pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
            //pcpg.getP1PriorityCasesDisplay();
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            //pcpg.getNewCasesDisplay();
            pcpg.getAckCasesDisplay();
            //pcpg.getClosedCasesDisplay();
            pcpg.getResolvedCasesDisplay();
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
            //pcpg.ShowDateTimeCases();
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
           
            pcpg.getRecentCasesDisplay();
          
            pcpg.FollowCase();
          
           
          pcpg.countMyCases = 'AnyTime';
          pcpg.isCommunityUser = true;
          pcpg.displayMonthCount();
        
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
          
          Test.stopTest();  
                   
    }
    static  testMethod void validatePredixCaseSearchController_test9(){
        
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'predixdashboard9@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
            Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
             a.Classification__c = 'Silver';
            a.type ='EPC';      
            insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  
            
         //   RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
         
                Case cs = new case ();
                cs.Status = 'Resolved';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P2–Level 2–Service failure';
                cs.Subject = 'demo';
                cs.CreatedDate=DateTime.Now();
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
                
                
         
     
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
                pp.Body='welcome to salesforce knowledge2';
                pp.ParentId=cs.id;
                insert pp;
                FeedComment fc = new FeedComment();
                fc.CommentBody = 'legal test4';
                fc.FeedItemId = pp.Id;
                insert fc;
                System.assertEquals ('legal test4', fc.commentbody);
                 
                 
                 
                 EntitySubscription newES = new EntitySubscription();
                  newES.ParentId = cs.Id;
                  newES.SubscriberId = UserInfo.getUserId();
                  Insert newES;
                  
                PredixCustomSetting__c pd = new PredixCustomSetting__c();
              //  pd.Company__c='testing';
                pd.PermissionSet_Name__c='testing';
                pd.Priority__c='test;demo';
             pd.Product__c='TESTING';
                pd.ProfileName__c= p.id ;
                pd.RecordType__c='Predix IPS';
                pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
                pd.Name='testing';
                insert pd;
               
               
           
              //CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' limit 99];
            test.startTest(); 
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
            pcpg.CurUser = u;
             
          
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='UnFollow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
            pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
            //pcpg.getP1PriorityCasesDisplay();
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            //pcpg.getNewCasesDisplay();
            pcpg.getAckCasesDisplay();
            //pcpg.getClosedCasesDisplay();
            pcpg.getResolvedCasesDisplay();
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
            //pcpg.ShowDateTimeCases();
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
            //pcpg.getAnyTimeRecordsToDisplay();
          //  pcpg.save();
           //pcpg.Search();
            pcpg.getRecentCasesDisplay();
          //  pcpg.getfeedItems();
            //pcpg.getFeedComments();
            //pcpg.feedcommReferesh();
            pcpg.FollowCase();
           // pcpg.GetCaseFollow();
           
          pcpg.countMyCases = 'Thismonth';
       
          pcpg.displayMonthCount();
          
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
          
          Test.stopTest();  
                   
    }
    static  testMethod void validatePredixCaseSearchController_test10(){
         
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'predixdashboard10@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
            Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
            a.Classification__c = 'Silver';
            a.type ='EPC';      
            insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  
            
        //    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
         
                Case cs = new case ();
                cs.Status = 'Resolved';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P2–Level 2–Service failure';
                cs.Subject = 'demo';
                cs.CreatedDate=DateTime.Now();
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
                
                
         
          
     
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
                pp.Body='welcome to salesforce knowledge2';
                pp.ParentId=cs.id;
                insert pp;
                FeedComment fc = new FeedComment();
                fc.CommentBody = 'legal test4';
                fc.FeedItemId = pp.Id;
                insert fc;
                System.assertEquals ('legal test4', fc.commentbody);
                 
                 
                 
                 EntitySubscription newES = new EntitySubscription();
                  newES.ParentId = cs.Id;
                  newES.SubscriberId = UserInfo.getUserId();
                  Insert newES;
                  
                PredixCustomSetting__c pd = new PredixCustomSetting__c();
              //  pd.Company__c='testing';
                pd.PermissionSet_Name__c='testing';
                pd.Priority__c='test;demo';
             pd.Product__c='TESTING';
                pd.ProfileName__c= p.id ;
                pd.RecordType__c='Predix IPS';
                pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
                pd.Name='testing';
                insert pd;
               
               
           
              //CaseFeed  cf =  [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' limit 99];
            Test.startTest();
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
            pcpg.CurUser = u;
             
            /*pcpg.next();
            pcpg.LastPage();
            pcpg.getprev();
            pcpg.getnxt(); */
     
           
         
          
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='UnFollow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
            pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
            //pcpg.getP1PriorityCasesDisplay();
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            //pcpg.getNewCasesDisplay();
            pcpg.getAckCasesDisplay();
            //pcpg.getClosedCasesDisplay();
            pcpg.getResolvedCasesDisplay();
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
            //pcpg.ShowDateTimeCases();
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
           
            pcpg.getRecentCasesDisplay();
         
            pcpg.FollowCase();
         
           
          pcpg.countMyCases = 'Sixmonths';
       
          pcpg.displayMonthCount();
        
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
         
          Test.stopTest();  
                   
    }
    static  testMethod void validatePredixCaseSearchController_test11(){
        
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'predixdashboard11@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
         alias='cserwu', lastname='lastname' );
           insert u;
           
            Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
            a.Classification__c = 'Silver';
            a.type ='EPC';          insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  
            
         //   RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
         
                Case cs = new case ();
                cs.Status = 'Resolved';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P2–Level 2–Service failure';
                cs.Subject = 'demo';
                cs.CreatedDate=DateTime.Now();
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
                
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
                pp.Body='welcome to salesforce knowledge2';
                pp.ParentId=cs.id;
                insert pp;
                FeedComment fc = new FeedComment();
                fc.CommentBody = 'legal test4';
                fc.FeedItemId = pp.Id;
                insert fc;
                System.assertEquals ('legal test4', fc.commentbody);
                 
                 
                 
                 EntitySubscription newES = new EntitySubscription();
                  newES.ParentId = cs.Id;
                  newES.SubscriberId = UserInfo.getUserId();
                  Insert newES;
                  
                PredixCustomSetting__c pd = new PredixCustomSetting__c();
              //  pd.Company__c='testing';
                pd.PermissionSet_Name__c='testing';
                pd.Priority__c='test;demo';
             pd.Product__c='TESTING';
                pd.ProfileName__c= p.id ;
                pd.RecordType__c='Predix IPS';
                pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
                pd.Name='testing';
                insert pd;
          
            Test.startTest();
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
            pcpg.CurUser = u;
             
            
           
         
          
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='UnFollow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
            pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
            
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            
            pcpg.getAckCasesDisplay();
            
            pcpg.getResolvedCasesDisplay();
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
           
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
            
            pcpg.getRecentCasesDisplay();
         
            pcpg.FollowCase();
           
           
          pcpg.countMyCases = 'OneYear';
       
          pcpg.displayMonthCount();
      
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
         
          Test.stopTest();  
                   
    }
    static  testMethod void validatePredixCaseSearchController_test12(){
       
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(ProfileId = p.Id, username = 'predixdashboard12@ge.com', email = 'test1@ge.com',
           EmailEncodingKey='UTF-8', localesidkey = 'en_US',
           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
            alias='cserwu', lastname='lastname' );
           insert u;
           
            Account a  = new Account(name='testing');
            a.GE_HQ_DUNS_Number__c = 'GEGUL1012';a.RecordtypeId = CommAccrecType ; 
             a.Classification__c = 'Silver';
            a.type ='EPC';  
            insert a;
        
            Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id);
            insert con;  
            
        //    RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
               
         
                Case cs = new case ();
                cs.Status = 'Resolved';
                cs.Community_Last_Modified_User__c = ',';
                cs.Priority = 'P2–Level 2–Service failure';
                cs.Subject = 'demo';
                cs.CreatedDate=DateTime.Now();
                cs.createdByID = UserInfo.GetUserID();
                cs.Description='testing';
                cs.Type='testing';
                 cs.ContactId=con.Id;
                cs.AccountId=a.Id;
                cs.GE_OG_Predix_Company__c='testing';
                cs.GE_OG_Predix_Product__c='testing';
               cs.recordtypeid= Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
               cs.OwnerId=u.id;
                insert cs;
                
                
         
            
     
                 FeedItem  pp = new FeedItem();
                pp.CreatedDate=DateTime.Now();
                pp.Body='welcome to salesforce knowledge2';
                pp.ParentId=cs.id;
                insert pp;
                FeedComment fc = new FeedComment();
                fc.CommentBody = 'legal test4';
                fc.FeedItemId = pp.Id;
                insert fc;
                System.assertEquals ('legal test4', fc.commentbody);
                 
                 
                 
                 EntitySubscription newES = new EntitySubscription();
                  newES.ParentId = cs.Id;
                  newES.SubscriberId = UserInfo.getUserId();
                  Insert newES;
                  
                PredixCustomSetting__c pd = new PredixCustomSetting__c();
              //  pd.Company__c='testing';
                pd.PermissionSet_Name__c='testing';
                pd.Priority__c='test;demo';
             pd.Product__c='TESTING';
                pd.ProfileName__c= p.id ;
                pd.RecordType__c='Predix IPS';
                pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
                pd.Name='testing';
                insert pd;
               
             Test.startTest();
            Predixdashboardpagecontroller pcpg = new Predixdashboardpagecontroller();
            pcpg.listOfPriority.add('testing');
                pcpg.listOfStatus.add('testing');
        
              
            pcpg.CurUser = u;
             
            pcpg.caseFollowing = true;
            pcpg.strFollowUnFollow ='UnFollow';
            pcpg.Submit();
            pcpg.Cancel();
            pcpg.getEnhanceCaseTypeOptions();
            pcpg.getBugCaseTypeOptions();
            pcpg.getSuggestCaseTypeOptions();
            pcpg.getRecordTypes();
             pcpg.getPriortyPicklist();
            pcpg.getStatusPicklist();
            pcpg.getProductPicklist();
            pcpg.getCompanyPicklist();
           
            pcpg.getP2PriorityCasesDisplay();
            pcpg.getP3PriorityCasesDisplay();
            pcpg.getP4PriorityCasesDisplay ();
            
            pcpg.getAckCasesDisplay();
            
            pcpg.getResolvedCasesDisplay();
            pcpg.getWorkingCasesDisplay();
            pcpg.ShowPriorityCases();
          
            pcpg.getRecordTypes();
            pcpg.ShowStatusCases();
          
            pcpg.getRecentCasesDisplay();
       
            pcpg.FollowCase();
         
           
          pcpg.countMyCases = 'AnyTime';
       
          pcpg.displayMonthCount();
        
             Predixdashboardpagecontroller.wrapcase testwrap = new Predixdashboardpagecontroller.wrapcase(cs); 
          
          Test.stopTest();  
                   
    }
     
    }