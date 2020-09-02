@isTest
  
  Public class OG_Support_Tab_Test {
  
public static boolean boolSFDC = true;
public static boolean boolBM = true;
public static boolean riskAdmin = false;


  static testMethod void OG_Support_Tab_Test_Method() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  
  /*system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Measurement & Control (M&C)';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Salesforce';
            objCase.Short_Description__c='Testing GE SFDC';
          //  objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
           
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
    

            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Measurement & Control (M&C)';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
 
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Salesforce');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Business_Tier__c='Measurement & Control (M&C)';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Salesforce');
    

   
  }
  
  

  static testMethod void OG_Support_Tab_Test_Method1() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='PII Pipeline Solutions';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Salesforce';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
        
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());


            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
  
            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='PII Pipeline Solutions';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Salesforce');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Business_Tier__c='PII Pipeline Solutions';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Salesforce');
    
    
    
    }
    
    static testMethod void OG_Support_Tab_Test_Method2() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Lufkins';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Salesforce';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
          
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());


            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);

            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Lufkin';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Salesforce');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Business_Tier__c='Lufkin';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Salesforce');
    
    
    
    }
    
    
    
    static testMethod void OG_Support_Tab_Test_Method3() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='HQ';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Salesforce';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
        
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);

            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='HQ';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Salesforce');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Business_Tier__c='HQ';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Salesforce');
    
    
    
    }
    
          static testMethod void OG_Support_Tab_Test_Method4() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='DTS';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Salesforce';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
          
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());


            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
    

            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='DTS';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Salesforce');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Business_Tier__c='DTS';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Salesforce');
    
    
    
    }
    
    
        static testMethod void OG_Support_Tab_Test_Method5() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='TMS';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Salesforce';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
           
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
    
  
            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='TMS';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Salesforce');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Business_Tier__c='TMS';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Salesforce');
    
    
    
    }
    
           static testMethod void OG_Support_Tab_Test_Method6() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Drilling & Surface (D&S)';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Salesforce';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
           
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
    
   // PageReference pageRef2 = new PageReference('/apex/OG_Support_Thank_You?id=ObjCase.Id');
  //  ApexPages.currentPage().getParameters().put('id',ObjCase.id); 
            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Drilling & Surface (D&S)';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Salesforce');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Business_Tier__c='Drilling & Surface (D&S)';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Salesforce');
    
    
    
    }
        
    
             static testMethod void OG_Support_Tab_Test_Method7() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Subsea (SS)';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Salesforce';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
         
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

        
            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
    
   // PageReference pageRef2 = new PageReference('/apex/OG_Support_Thank_You?id=ObjCase.Id');
  //  ApexPages.currentPage().getParameters().put('id',ObjCase.id); 
            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Subsea (SS)';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Salesforce');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Business_Tier__c='Subsea (SS)';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Salesforce');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Salesforce');
    
    
    
    }
    
   
    static testMethod void OG_Support_Tab_Test_Method8() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
 /* 
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Measurement & Control (M&C)';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Servicemax';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
        
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);

            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Measurement & Control (M&C)';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
 
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Servicemax');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Business_Tier__c='Measurement & Control (M&C)';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Servicemax');
    
    
    
    }
    
    
     static testMethod void OG_Support_Tab_Test_Method9() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Drilling & Surface (D&S)';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Servicemax';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
    
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

    
            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
    
  
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Drilling & Surface (D&S)';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Servicemax');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Business_Tier__c='Drilling & Surface (D&S)';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Servicemax');
    
    
    
    }
    
    static testMethod void OG_Support_Tab_Test_Method10() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Subsea (SS)';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Servicemax';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
 
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

 
            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
  
            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Subsea (SS)';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Servicemax');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Business_Tier__c='Subsea (SS)';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Servicemax');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Servicemax');
    
    
    
    }
    
    
      static testMethod void OG_Support_Tab_Test_Method11() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Subsea (SS)';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Bigmachines';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
         
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());


            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);

            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Subsea (SS)';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.saveTicketBigMachines();

     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Bigmachines');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Business_Tier__c='Subsea (SS)';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Bigmachines');
     
    
    
    
    }
    
       static testMethod void OG_Support_Tab_Test_Method12() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
  /*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
 */
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Measurement & Control (M&C)';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Bigmachines';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
   
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
  
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Measurement & Control (M&C)';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Bigmachines');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Business_Tier__c='Measurement & Control (M&C)';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Bigmachines');
    
    
    
    }
    


    
               static testMethod void OG_Support_Tab_Test_Method13() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
/*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
*/
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='GE';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='SF';
            objCase.Short_Description__c='Testing GE SFDC';

            
            try {insert ObjCase;}catch(DmlException e){}
        
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
  
            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='GE';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('SF');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('SF');
    supTab.ObjCase.Business_Tier__c='GE';
    supTab.saveTicket('SF');
    supTab.ObjCase.Type__c ='Fix';
    supTab.saveTicket('SF');
    supTab.ObjCase.Priority__c ='Urgent';
    supTab.saveTicket('SF');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('SF');
    supTab.ObjCase.Short_Description__c='ShortDescriptionTestingGESFDCCShortDescriptionTestingGESFDCCShortDescriptionTestingGESFDCC';
    supTab.saveTicket('SF');
    
    
    
    }
    
    static testMethod void OG_Support_Tab_Test_Method14() {
  
  User u=[Select id,GE_HQ_SSO_ID__c from user where id=:UserInfo.getUserId()];
/*
  system.RunAs(u){ PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Risk_Admin_Super_Users'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;}
*/
  riskAdmin = false;
 // u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'profile name'].Id;
 Profile p = [Select Id from Profile where Name = 'Standard User' Limit 1];
 // Profile.name='System Administrator' and isactive=true limit 1];
 
  Account acct = new Account(Name='Test Account'); 
insert acct;
    
  SFDC_Support_Case__c ObjCase = new SFDC_Support_Case__c ();
             ObjCase.Name='SFDCTEST object';
            ObjCase.Caller_SSO_ID__c =u.id ; 
            ObjCase.User_SSO__c =u.GE_HQ_SSO_ID__c;
            ObjCase.Priority__c = 'Urgent'; 
            ObjCase.Issue_Details__c = 'test'; 
            ObjCase.Type__c = 'Service Request'; 
            ObjCase.Quote_Number__c = '123' ; 
            ObjCase.Record_Affected__c = '2' ; 
            ObjCase.People_Affected__c = '2' ;
            ObjCase.Business_Tier__c='Drilling & Surface (D&S)';
            ObjCase.Issue_Details__c='test';
            objCase.Application__c='Bigmachines';
            objCase.Short_Description__c='Testing GE SFDC';
            //objCase.Assignment_to_Workgroup_Name__c ='Oil & Gas';
            
            try {insert ObjCase;}catch(DmlException e){}
           // System.assertEquals('Measurement and Control', objCase.Business_Tier__c);
            // System.assertEquals('Salesforce', objCase.Application__c);
             //System.assertEquals('Oil & Gas', objCase.Assignment_to_Workgroup_Name__c);
            
 Blob b = Blob.valueOf('Test Data');
Attachment attachment = new Attachment();
attachment.OwnerId = objCase.Caller_SSO_ID__c;
attachment.ParentId=ObjCase.Id;
attachment.Name='Test Attachment for Parent';
attachment.body=b;

try {insert attachment;}catch(DmlException e){}
List<Attachment> attachments=[select id, name from Attachment where parent.id=: ObjCase.Id];
     System.assertEquals(1, attachments.size());

  
            
            PageReference PageRef = Page.OG_Support_Tab;
    Test.setCurrentPage(PageRef);
    
     PageReference PageRef1 = Page.OG_Support_Thank_You;
    // pageRef.getParameters().put('Salesforce','success');
    Test.setCurrentPage(PageRef1);
    
   
            
            String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
              
     ApexPages.StandardController controller = new ApexPages.StandardController(ObjCase); 
       ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ObjCase.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     OG_Support_Tab supTab= new OG_Support_Tab(controller);
     supTab.attachment.OwnerId = objCase.Caller_SSO_ID__c;
     supTab.strBusiness='Drilling & Surface (D&S)';
    //supTab.strApplication='ServiceMax';
    //   supTab.strSelTab='Home';
     supTab.attachment.ParentId = objCase.Id;
     supTab.riskAdmin =true;
     supTab.boolSFDC =true;
     supTab.boolBM =true;
     supTab.getBusinessSFDC();
     supTab.getBusinessBigMachines();
     supTab.getBusinessServiceMax();
     supTab.processUpload();
     supTab.saveTicketSFDC();
     supTab.saveTicketBigMachines();
     supTab.saveTicketServiceMax();
     supTab.closePopup();
     supTab.showPopup();
     supTab.strSucess ='SUCCESS';
     supTab.attachment.Name='Test Attachment for Parent';
    supTab.attachment.body=Blob.valueOf('Test Data');
    
    supTab.saveTicket('Bigmachines');
    supTab.objCase.User_SSO__c = u.GE_HQ_SSO_ID__c;
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Business_Tier__c='Drilling & Surface (D&S)';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Type__c ='BreakFix';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Priority__c ='Medium';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Issue_Details__c='test';
    supTab.saveTicket('Bigmachines');
    supTab.ObjCase.Short_Description__c ='Testing GE SFDC';
    supTab.saveTicket('Bigmachines');
     
    
    
    
    }

  
  }