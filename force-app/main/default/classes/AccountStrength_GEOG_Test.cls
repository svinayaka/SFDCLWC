@isTest 
private class AccountStrength_GEOG_Test{
   static testMethod void AccountStrengthTest() {
        /* Account acnt = new Account();
         acnt.Name='Customer value perception';
         acnt.Type = 'EPC';
         acnt.Classification__c = 'Strategic';
         acnt.Strength__c = 'Low';
         insert acnt;*/
        Account acnt= AccountTestDataFactory.createAcctWithStrength('Customer value perception','Low');
         
     }
    
    
    
    
    
     static testMethod void AccountStrengthTest1() {
         
        Account acnt= AccountTestDataFactory.createAcctWithStrength('Customer value perception','Medium');
         /*RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Relationship Account' Limit 1];        
         Account acnt = new Account();
         acnt.RecordTypeId = rt.Id;
         acnt.Name='Customer value perception';
         acnt.Type = 'EPC';
         acnt.Classification__c = 'Strategic';
        
         acnt.GE_ES_Primary_Industry__c = 'FOUNDRY';
         acnt.Strength__c = 'Medium';
         insert acnt;*/
         
         
        Contact primCont=AccountTestDataFactory.createPrimaryContact(acnt.id,'Test','Test',True);
        /* Contact cont = new Contact();
         cont.LastName = 'Test';
         cont.FirstName = 'Test';
         cont.Phone = '98745632145';
         cont.Email = 'test@test.com';
         cont.GE_PRM_Primary_Contact__c = True;
         cont.AccountId = acnt.Id;
         insert cont;
         
         */
         
        /* ContactAccountSharing__c conshar = new ContactAccountSharing__c ();
         conshar.Primary_Contact_GE_OG__c = True;
         conshar.Account_GEOG__c = acnt.Id;
         conshar.Contact_GEOG__c = cont.Id;
         insert conshar;*/
         
        ContactAccountSharing__c conshar= AccountTestDataFactory.createcontactAccountSharing(acnt.Id,primCont.Id,True);
        
        acnt.Strength__c = 'Medium';
        update acnt;
    
    }
    
    static testMethod void AccountStrengthTest2() {
        
        
        Account acnt= AccountTestDataFactory.createAcctWithStrength('Customer value perception','High',True);
       /* RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Relationship Account' Limit 1]; 
        Account acnt = new Account();
        acnt.RecordTypeId = rt.Id;
         acnt.Name='Customer value perception';
         acnt.Type = 'EPC';
         acnt.Classification__c = 'Strategic';
         acnt.Compliance_Ready__c = True;
         //acnt.GE_Account_Success_Team_X_GEOG__c = 3;
         acnt.GE_ES_Primary_Industry__c = 'FOUNDRY';
         acnt.Strength__c = 'High';
         insert acnt;
         */
         
        AccountTeamMember atm= AccountTestDataFactory.createAccountTeamMember(acnt.id,'Following');
       /* AccountTeamMember atm = new AccountTeamMember();
        atm.AccountId = acnt.id;
        atm.userid = UserInfo.getUserId();
        atm.teammemberrole = 'Following';
        insert atm;
        */
        
        Contact primCont=AccountTestDataFactory.createPrimaryContact(acnt.id,'Test','Test',True);
        /* Contact cont = new Contact();
         cont.LastName = 'Test';
         cont.FirstName = 'Test';
         cont.Phone = '98745632145';
         cont.Email = 'test@test.com';
         cont.GE_PRM_Primary_Contact__c = True;
         cont.AccountId = acnt.Id;
         insert cont;
         */
         
         ContactAccountSharing__c conshar= AccountTestDataFactory.createcontactAccountSharing(acnt.Id,primCont.Id,True);
        
        /*ContactAccountSharing__c conshar = new ContactAccountSharing__c ();
         conshar.Primary_Contact_GE_OG__c = True;
         conshar.Account_GEOG__c = acnt.Id;
         conshar.Contact_GEOG__c = cont.Id;
         insert conshar;
         */
        
     }
 }