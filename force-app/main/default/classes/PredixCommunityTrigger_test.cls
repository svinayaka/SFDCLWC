@isTest(seeAlldata=False)
public class PredixCommunityTrigger_test
{
 
 
 static testMethod void PredixCommunityTrigger_test()
    {
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'Predix IPS'  limit 1];
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
      //  RecordType rtAccount = [select id,name from recordtype where sObjectType = 'Account' and Name = 'CMF Approved' limit 1];
        Id p = [select id from profile where name='Customer Portal Manager Standard'].id;
       
        Account ac = new Account(name ='Grazirrtti') ;
        ac.GE_HQ_DUNS_Number__c = 'GEGUL1012';    ac.RecordtypeId = CommAccrecType ;
        ac.classification__c = 'test';
        ac.type='test';
        insert ac; 
       
        Contact con3 = new Contact(firstname = 'tester' , LastName ='testrrCon',email ='tester@yahoo.com' ,AccountId = ac.Id);
        insert con3;  
                  
        User user = new User(alias = 'tesgft13', email='tesgfft123@noemail.com',
                emailencodingkey='UTF-8', lastname='Tesgffting', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con3.Id,GE_HQ_Tier_3_P_L__c ='testing',
                timezonesidkey='America/Los_Angeles', username='tegffgster@noemail.com');
       
        insert user;
        System.assertEquals(user.Alias,'tesgft13');
       // system.debug('******************rtAccount*************************************************'+rtAccount.id);
        
      Account acct = new Account();
       acct.name='test account for user0';
        //acct.GE_HQ_DUNS_Number__c = 'GEGUL1012';    
        acct.RecordtypeId = CommAccrecType ;
        acct.classification__c = 'test';
        acct.type='test';
      insert acct;
      //  Account acct =  [Select id,name  from account where name = 'TestClassAccount'] ;
        
      //  Account acce = [Select id,name  from account where name =  'TestClassAccount-EndUser'];       
        
        //inserting account team member
      //  AccountTeamMember atm = new AccountTeamMember();
      //  atm.userId = usr.id ;
      //  atm.accountid = acct.id ;
      //  atm.TeamMemberRole = 'Account Manager';
      //  insert atm ;
      //  System.assertEquals(atm.TeamMemberRole,'Account Manager');
        
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
        cont.lastname = ' Contact 2' ;
        cont.email = 'Test22@Spr22int.com' ;
        cont.firstname = ' Te22st ' ;
        cont.accountid =  acct.id ;
        insert cont;
        System.assertEquals(cont.firstname,' Te22st ');
        
        
           List<Case> CSLst = new List<Case>();
            List<Case> CSLst1 = new List<Case>();
        //inserting case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='New';
        csobj.Origin='Email';
        csobj.accountid = acct.id;
        csobj.contactid = con.id;
        csobj.suppliedemail = 'Te33st@Sprint.com';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = rt.Id;
        csobj.Community_Last_Modified_User__c ='testing department';
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
        csobj1.suppliedemail = 'Tes44t@Sprint.com';
        csobj1.GE_ES_Sub_Type__c='Technical Support Request';
        csobj1.recordtypeid = rt.Id;
      csobj1.Community_Last_Modified_User__c ='testingdfg department';

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
              csobj3.Community_Last_Modified_User__c ='testigbfgfngdfg department';

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
            
            /*PageReference attachPage = Page.PredixCommunityTrigger; 
            ApexPages.currentPage().getParameters().put('id', csobj.id); 
            ApexPages.StandardController sController = new ApexPages.StandardController(csobj);      
            PredixCommunityTrigger at = new PredixCommunityTrigger(sController) ;
            at.contactIdNew = cont.id ;
            at.Attach();           
            PageReference attachPg= Page.PredixCommunityTrigger; 
            ApexPages.currentPage().getParameters().put('id', csobj1.id); 
            ApexPages.StandardController sController1 = new ApexPages.StandardController(csobj1);      
            PredixCommunityTrigger atcntrl = new PredixCommunityTrigger(sController1) ;
            atcntrl.contactIdNew = cont.id ;
            atcntrl.Attach();*/
            
        }
    } 
}