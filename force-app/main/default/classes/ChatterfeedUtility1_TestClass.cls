@isTest(SeeAllData=true)

private class ChatterfeedUtility1_TestClass {
    
    @isTest static void Feed_on_insert_KCC() { 
   
        Account GlobalAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global / HQ','Customer');
        //Contact con =AccountTestDataFactory.createContact(GlobalAcc.id ,'Test','contact');
        Contact objContact = new Contact();
        objContact.FirstName='test';
        objContact.LastName='contact';
        objContact.Salutation='Mr.';
        objContact.Email='blabla'+'@ge.com';
        objContact.Phone='111111111';
        objContact.Fax='1212121212';
        objContact.GE_ES_I_Agree_flag__c = TRUE;
        objContact.AccountId= GlobalAcc.id;
        objContact.GE_OG_Contact_Audience__c='Customer Care';
        
        insert objContact;
        
        Account_Planning__c ap = new Account_Planning__c();
        ap.Account_Name_GEOG__c = GlobalAcc.id;
        ap.Year_GEOG__c ='2018';
        ap.Plan_Target_Geog__c= 1000;
        ap.Status_GEOG__c ='Active';
        
        insert ap;
  
        Key_Customer_Contacts__c kc= new Key_Customer_Contacts__c();
        kc.Contact__c=objContact.id;
        kc.Account_Planning__c=ap.id;
        
        insert kc;
        
        Delete kc;
        
        Id csm_recordtype_id = Schema.SObjectType.Customer_Strategy_Map_item__c.getRecordTypeInfosByName().get('Customer\'s Initiatives').getRecordTypeId();
        Customer_Strategy_Map_item__c csm = new Customer_Strategy_Map_item__c();
        csm.RecordTypeId=csm_recordtype_id;
        csm.Account_Planning__c =ap.id;
        csm.Status__c= 'Active';
        csm.Title__c = 'test chatter feed';
        insert csm;
        
        Customer_Strategy_Map_Contacts__c csmc = new Customer_Strategy_Map_Contacts__c ();
        csmc.Contact__c =objContact.id;
        csmc.Customer_Strategy_Map_item__c =csm.id;
            
        insert csmc ;    
        Delete csmc ;
        
        
        Project_ge_og__c  proj = new Project_ge_og__c ();
        proj.Name ='Test Project';
        proj.Project_Stage_ge_og__c = 'Awarded';
        proj.Status_ge_og__c='Not Started';
        proj.Project_Summary_ge_og__c ='scope of this project is for testing';
        proj.project_account_ge_og__c=GlobalAcc.id;
        proj.GE_ES_Tier_2_P_L__c ='Digital Solutions';
        
        insert proj;
        
        
        Key_Project_ge_og__c keypro = new Key_Project_ge_og__c();
        keypro.Project_ge_og__c = proj.id;
        keypro.Account_Plan_ge_og__c = ap.id;
        
        insert keypro;
        delete keypro;
        
        
 // check  in   
        Asset ast = [select id from Asset limit 1];
        Key_Asset_ge_og__c kast = new Key_Asset_ge_og__c();
        kast.Account_Planning_ge_og__c = ap.id;
        kast.Asset_ge_og__c = ast.id ;
        
        Insert kast;
        delete kast;
        
  // check end           
    
 
}
}