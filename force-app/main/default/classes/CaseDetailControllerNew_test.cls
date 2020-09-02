@istest
private class CaseDetailControllerNew_test{
 static testMethod void validateCaseDetailControllerNew_test(){
  
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();

        User u = new User(ProfileId = p.Id, username = 'test1211@ge.com', email = 'test1@ge.com',
        EmailEncodingKey='UTF-8', localesidkey = 'en_US',
        languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
        alias='cserwu', lastname='lastname' );
        insert u;
         
          
        Account a  = new Account(name='testing');
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        a.RecordtypeId = CommAccrecType ;
        a.Classification__c = 'Silver';
        a.type ='EPC';
        insert a;
    
        Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id,phone='9999912345');
        insert con;  
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
           
    case c = new case();
    c.Status='testing';
    c.recordtypeid =rt.id;
    insert c;
       
        Case cs = new case ();
        cs.Status = 'New';
        cs.Community_Last_Modified_User__c = 'testing,';
        cs.Priority = 'P1–Level 1–Catastrophic service failure';
        cs.Subject = 'demo';
        //cs.CreatedDate=System.today();
        cs.createdByID = UserInfo.GetUserID();
        cs.Description='testing';
        cs.Type='testing';
        cs.ContactId=con.Id;
        cs.AccountId=a.Id;
        cs.GE_OG_Predix_Company__c='testing';
        cs.GE_OG_Predix_Product__c='testing';
        cs.recordtypeid=rt.id;
        cs.OwnerId=u.id;
        //cs.GE_Resolution_Time__c='test';
        //cs.GE_Initial_Response_Time2__c='test';
        //cs.Rally_Ticket__c='test';
        //cs.ServiceNow_Ticket_Number__c='test';
        //cs.Customer_Reference_Number__c='test';
        cs.GE_OG_MC_Con_Email__c='test@rediffmail.com';
        cs.Origin='test';
        cs.GE_OG_Case_Issue_Type__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        //cs.Product_Version__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_PRM_Parent_Id__c = c.id;
        cs.Parentid=c.id;
        cs.SuppliedEmail='example@ge.com';
        insert cs;
        
           
        PageReference pageRef = Page.PredixCaseDetailPage;
        Test.setCurrentPage(pageRef);
        pageRef.getparameters().put('Id',cs.id);  
           
            FeedItem  pp = new FeedItem();
            pp.CreatedDate=System.today();
            pp.Body='welcome to salesforce knowledge2';
            pp.ParentId=cs.id;
            insert pp;
            
            //String feedItemId=pp.id;
            FeedComment fc = new FeedComment();
            fc.CommentBody = 'legal test4';
            fc.FeedItemId = pp.id;
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
            pd.Product__c='testing';
            pd.ProfileName__c= p.id ;
            pd.RecordType__c='Predix IPS';
            pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
            pd.Name='testing';
            insert pd; 
           
           
         CaseDetailControllerNew pcpg = new CaseDetailControllerNew();
        test.starttest();
          pcpg.getRecordTypes();
          pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
         pcpg.updateRecordType();
           pcpg.Submit();
            pcpg.Cancel();
             pcpg.ShowRecentActivityFeeds();
             pcpg.getCaseDetails(); 
               pcpg.getEnhanceCaseTypeOptions(); 
                pcpg.PostComment(); 
                 pcpg.FollowUnFollow(); 
                 pcpg.strFollowUnFollow='UnFollow';
                 pcpg.FollowCase();
                 pcpg.getMostRecentFeedsDisplay();
                 pcpg.getLastPostDisplay();
                pcpg.getCasePriority='testing';
                pcpg.getCaseStatus='testing';
                pcpg.counter = 0;
                pcpg.hasAttachment=true;
                    pcpg.hasArticle=true;
                    pcpg.selectedEnhancOptions='testing';
                    pcpg.feedItemId='tester';
                    pcpg.commentToAdd='tester';
                    pcpg.feedItemstatus='tester';
                    pcpg.likeCommentId='tester';

        // CaseDetailControllerNew.wrapFeedItems testfeed1 = new CaseDetailControllerNew.wrapFeedItems(pp);
           CaseDetailControllerNew.wrapcase testfeed2 = new CaseDetailControllerNew.wrapcase(cs);      
       test.stoptest();
}

static testMethod void validateCaseDetailControllerNew_test1(){
  
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();

        User u = new User(ProfileId = p.Id, username = 'test312312@ge.com', email = 'test2312311@ge.com',
        EmailEncodingKey='UTF-8', localesidkey = 'en_US',
        languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
        alias='cserwu', lastname='lastname' );
        insert u;
         
          
        Account a  = new Account(name='testing');
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        a.RecordtypeId = CommAccrecType ;
        a.Classification__c = 'Silver';
        a.type ='EPC';
        insert a;
    
        Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id,phone='9999912345');
        insert con;  
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
           
    case c = new case();
    c.Status='testing';
    c.recordtypeid =rt.id;
    insert c;
       
        Case cs = new case ();
        cs.Status = 'New';
        cs.Community_Last_Modified_User__c = 'testing,demo1,';
        cs.Priority = 'P1–Level 1–Catastrophic service failure';
        cs.Subject = 'demo';
        //cs.CreatedDate=System.today();
        cs.createdByID = UserInfo.GetUserID();
        cs.Description='testing';
        cs.Type='testing';
        cs.ContactId=con.Id;
        cs.AccountId=a.Id;
        cs.GE_OG_Predix_Company__c='testing';
        cs.GE_OG_Predix_Product__c='testing';
        cs.recordtypeid=rt.id;
        cs.OwnerId=u.id;
        //cs.GE_Resolution_Time__c='test';
        //cs.GE_Initial_Response_Time2__c='test';
        //cs.Rally_Ticket__c='test';
        //cs.ServiceNow_Ticket_Number__c='test';
        //cs.Customer_Reference_Number__c='test';
        cs.GE_OG_MC_Con_Email__c='test@rediffmail.com';
        cs.Origin='test';
        cs.GE_OG_Case_Issue_Type__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        //cs.Product_Version__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_PRM_Parent_Id__c = c.id;
        cs.Parentid=c.id;
        cs.SuppliedEmail='example@ge.com';
        insert cs;
        
           
        PageReference pageRef = Page.PredixCaseDetailPage;
        Test.setCurrentPage(pageRef);
        pageRef.getparameters().put('Id',cs.id);  
           
            FeedItem  pp = new FeedItem();
            pp.CreatedDate=System.today();
            pp.Body='welcome to salesforce knowledge2';
            pp.ParentId=cs.id;
            insert pp;
            
            FeedComment fc = new FeedComment();
            fc.CommentBody = 'legal test4';
            fc.FeedItemId = pp.Id;
            insert fc;
            System.assertEquals ('legal test4', fc.commentbody);
            
            //String likeCommentId='testing';
            FeedLike flike = new  Feedlike();
            //likeCommentId = Apexpages.currentPage().getParameters().get('likeCommentId');
            flike.FeedItemId=pp.id;
            insert flike;
             
            EntitySubscription newES = new EntitySubscription();
            newES.ParentId =cs.id;
            newES.SubscriberId = UserInfo.getUserId();
            Insert newES; 
              
            PredixCustomSetting__c pd = new PredixCustomSetting__c();
            pd.Company__c='testing';
            pd.PermissionSet_Name__c='testing';
            pd.Priority__c='test;demo';
            pd.Product__c='testing';
            pd.ProfileName__c= p.id ;
            pd.RecordType__c='Predix IPS';
            pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
            pd.Name='testing';
            insert pd; 
           
           
         CaseDetailControllerNew pcpg = new CaseDetailControllerNew();
         test.starttest();
      
                  pcpg.getRecordTypes();
                  pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
                 pcpg.updateRecordType();
                   pcpg.Submit();
                    pcpg.Cancel();
                     pcpg.ShowRecentActivityFeeds();
                     pcpg.getCaseDetails(); 
                       pcpg.getEnhanceCaseTypeOptions(); 
                        pcpg.PostComment(); 
                         pcpg.FollowUnFollow(); 
                        pcpg.addCommentToFeedItem();
                        pcpg.likeunlike1();
                         pcpg.strFollowUnFollow='Follow';
                          pcpg.FollowCase();
        // CaseDetailControllerNew.wrapFeedItems testfeed1 = new CaseDetailControllerNew.wrapFeedItems(pp);
           CaseDetailControllerNew.wrapcase testfeed2 = new CaseDetailControllerNew.wrapcase(cs);   test.stoptest();   
}


static testMethod void validateCaseDetailControllerNew_test2(){
  
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 

        User u = new User(ProfileId = p.Id, username = 'testdasdasdas3@ge.com', email = 'test1@ge.com',
        EmailEncodingKey='UTF-8', localesidkey = 'en_US',
        languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
        alias='cserwu', lastname='lastname' );
        insert u;
         
          
        Account a  = new Account(name='testing');
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        a.RecordtypeId = CommAccrecType ;
        a.Classification__c = 'Silver';
        a.type ='EPC';
        insert a;
    
        Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id,phone='9999912345');
        insert con;  
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
           
    case c = new case();
    c.Status='testing';
    c.recordtypeid =rt.id;
    insert c;
       
        Case cs = new case ();
        cs.Status = 'New';
        cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,';
        cs.Priority = 'P1–Level 1–Catastrophic service failure';
        cs.Subject = 'demo';
        //cs.CreatedDate=System.today();
        cs.createdByID = UserInfo.GetUserID();
        cs.Description='testing';
        cs.Type='testing';
        cs.ContactId=con.Id;
        cs.AccountId=a.Id;
        cs.GE_OG_Predix_Company__c='testing';
        cs.GE_OG_Predix_Product__c='testing';
        cs.recordtypeid=rt.id;
        cs.OwnerId=u.id;
        //cs.GE_Resolution_Time__c='test';
        //cs.GE_Initial_Response_Time2__c='test';
        //cs.Rally_Ticket__c='test';
        //cs.ServiceNow_Ticket_Number__c='test';
        //cs.Customer_Reference_Number__c='test';
        cs.GE_OG_MC_Con_Email__c='test@rediffmail.com';
        cs.Origin='test';
        cs.GE_OG_Case_Issue_Type__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        //cs.Product_Version__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_PRM_Parent_Id__c = c.id;
        cs.Parentid=c.id;
        cs.SuppliedEmail='example@ge.com';
        insert cs;
        
           
        PageReference pageRef = Page.PredixCaseDetailPage;
        Test.setCurrentPage(pageRef);
        pageRef.getparameters().put('Id',cs.id);  
           
        FeedItem  pp = new FeedItem();
            pp.CreatedDate=System.today();
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
            pd.Product__c='testing';
            pd.ProfileName__c= p.id ;
            pd.RecordType__c='Predix IPS';
            pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
            pd.Name='testing';
            insert pd; 
           
           
         CaseDetailControllerNew pcpg = new CaseDetailControllerNew();
         test.starttest();
          pcpg.getRecordTypes();
          pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
         pcpg.updateRecordType();
           pcpg.Submit();
            pcpg.Cancel();
             pcpg.ShowRecentActivityFeeds();
             pcpg.getCaseDetails(); 
               pcpg.getEnhanceCaseTypeOptions(); 
                pcpg.PostComment(); 
                 pcpg.FollowUnFollow(); 

        // CaseDetailControllerNew.wrapFeedItems testfeed1 = new CaseDetailControllerNew.wrapFeedItems(pp);
           CaseDetailControllerNew.wrapcase testfeed2 = new CaseDetailControllerNew.wrapcase(cs);   
           test.stoptest();   
}

static testMethod void validateCaseDetailControllerNew_test3(){
  
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        
        User u = new User(ProfileId = p.Id, username = 'test4@ge.com', email = 'test1@ge.com',
        EmailEncodingKey='UTF-8', localesidkey = 'en_US',
        languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
        alias='cserwu', lastname='lastname' );
        insert u;
         
          
        Account a  = new Account(name='testing');
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        a.RecordtypeId = CommAccrecType ;
        a.Classification__c = 'Silver';
        a.type ='EPC';
        insert a;
    
        Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id,phone='9999912345');
        insert con;  
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
           
    case c = new case();
    c.Status='testing';
    c.recordtypeid =rt.id;
    insert c;
       
        Case cs = new case ();
        cs.Status = 'New';
        cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,';
        cs.Priority = 'P1–Level 1–Catastrophic service failure';
        cs.Subject = 'demo';
        //cs.CreatedDate=System.today();
        cs.createdByID = UserInfo.GetUserID();
        cs.Description='testing';
        cs.Type='testing';
        cs.ContactId=con.Id;
        cs.AccountId=a.Id;
        cs.GE_OG_Predix_Company__c='testing';
        cs.GE_OG_Predix_Product__c='testing';
        cs.recordtypeid=rt.id;
        cs.OwnerId=u.id;
        //cs.GE_Resolution_Time__c='test';
        //cs.GE_Initial_Response_Time2__c='test';
        //cs.Rally_Ticket__c='test';
        //cs.ServiceNow_Ticket_Number__c='test';
        //cs.Customer_Reference_Number__c='test';
        cs.GE_OG_MC_Con_Email__c='test@rediffmail.com';
        cs.Origin='test';
        cs.GE_OG_Case_Issue_Type__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        //cs.Product_Version__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_PRM_Parent_Id__c = c.id;
        cs.Parentid=c.id;
        cs.SuppliedEmail='example@ge.com';
        insert cs;
        
           
        PageReference pageRef = Page.PredixCaseDetailPage;
        Test.setCurrentPage(pageRef);
        pageRef.getparameters().put('Id',cs.id);  
           
        FeedItem  pp = new FeedItem();
            pp.CreatedDate=System.today();
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
            pd.Product__c='testing';
            pd.ProfileName__c= p.id ;
            pd.RecordType__c='Predix IPS';
            pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
            pd.Name='testing';
            insert pd; 
           
           
         CaseDetailControllerNew pcpg = new CaseDetailControllerNew();
         test.starttest();
          pcpg.getRecordTypes();
          pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
         pcpg.updateRecordType();
           pcpg.Submit();
            pcpg.Cancel();
             pcpg.ShowRecentActivityFeeds();
             pcpg.getCaseDetails(); 
               pcpg.getEnhanceCaseTypeOptions(); 
                pcpg.PostComment(); 
                 pcpg.FollowUnFollow(); 

        // CaseDetailControllerNew.wrapFeedItems testfeed1 = new CaseDetailControllerNew.wrapFeedItems(pp);
           CaseDetailControllerNew.wrapcase testfeed2 = new CaseDetailControllerNew.wrapcase(cs);    
           test.stoptest();  
}
static testMethod void validateCaseDetailControllerNew_test4(){
  
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();

        User u = new User(ProfileId = p.Id, username = 'test5@ge.com', email = 'test1@ge.com',
        EmailEncodingKey='UTF-8', localesidkey = 'en_US',
        languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',
        alias='cserwu', lastname='lastname' );
        insert u;
         
          
        Account a  = new Account(name='testing');
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        a.RecordtypeId = CommAccrecType ;
        a.Classification__c = 'Silver';
        a.type ='EPC';
        insert a;
    
        Contact con = new Contact(firstname = 'demoing' , LastName ='demoing',email ='demoing@rediffmail.com' ,AccountId = a.Id,phone='9999912345');
        insert con;  
        
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS' limit 1];
           
    case c = new case();
    c.Status='testing';
    c.recordtypeid =rt.id;
    insert c;
       
        Case cs = new case ();
        cs.Status = 'New';
        cs.Community_Last_Modified_User__c = 'testing,demo1,demo2,demo3,demo4,';
        cs.Priority = 'P1–Level 1–Catastrophic service failure';
        cs.Subject = 'demo';
        //cs.CreatedDate=System.today();
        cs.createdByID = UserInfo.GetUserID();
        cs.Description='testing';
        cs.Type='testing';
        cs.ContactId=con.Id;
        cs.AccountId=a.Id;
        cs.GE_OG_Predix_Company__c='testing';
        cs.GE_OG_Predix_Product__c='testing';
        cs.recordtypeid=rt.id;
        cs.OwnerId=u.id;
        //cs.GE_Resolution_Time__c='test';
        //cs.GE_Initial_Response_Time2__c='test';
        //cs.Rally_Ticket__c='test';
        //cs.ServiceNow_Ticket_Number__c='test';
        //cs.Customer_Reference_Number__c='test';
        cs.GE_OG_MC_Con_Email__c='test@rediffmail.com';
        cs.Origin='test';
        cs.GE_OG_Case_Issue_Type__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        //cs.Product_Version__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_ES_INDS_SubSts__c='test';
        cs.GE_PRM_Parent_Id__c = c.id;
        cs.Parentid=c.id;
        cs.SuppliedEmail='example@ge.com';
        insert cs;
        
           
        PageReference pageRef = Page.PredixCaseDetailPage;
        Test.setCurrentPage(pageRef);
        pageRef.getparameters().put('Id',cs.id);  
           
        FeedItem  pp = new FeedItem();
            pp.CreatedDate=System.today();
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
            pd.Product__c='testing';
            pd.ProfileName__c= p.id ;
            pd.RecordType__c='Predix IPS';
            pd.Status__c='New;Acknowledged;Working;Resolved;Closed';
            pd.Name='testing';
            insert pd; 
          
           
         CaseDetailControllerNew pcpg = new CaseDetailControllerNew();
         test.starttest();
         
          pcpg.getRecordTypes();
          pcpg.SelectedRecordType = Schema.SobjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
         pcpg.updateRecordType();
           pcpg.Submit();
            pcpg.Cancel();
             pcpg.ShowRecentActivityFeeds();
             pcpg.getCaseDetails(); 
               pcpg.getEnhanceCaseTypeOptions(); 
                pcpg.PostComment(); 
                 pcpg.FollowUnFollow(); 
                 pcpg.getCasePriority();
                 pcpg.getCaseStatus();
                 pcpg.getShowAllCases();

        // CaseDetailControllerNew.wrapFeedItems testfeed1 = new CaseDetailControllerNew.wrapFeedItems(pp);
           CaseDetailControllerNew.wrapcase testfeed2 = new CaseDetailControllerNew.wrapcase(cs);    
           test.stoptest();  
}
}