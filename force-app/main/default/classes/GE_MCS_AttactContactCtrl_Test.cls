/*
The below test class will coverage the following class
GE_MCS_AttactContactCtrl -- 93%
*/

@isTest(seeAlldata=true)
public class GE_MCS_AttactContactCtrl_Test
{
 
 
 static testMethod void Test_GE_MCS_AttactContactCtrl()
    {
        RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
        RecordType rtAccount = [select id,name from recordtype where sObjectType = 'Account' and Name = 'Relationship Account' limit 1];
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
        
        Account acct =  [Select id,name  from account where name = 'EMERSON / DENMARK' and recordtypeid =: rtAccount.id ] ;
        
        Account acce = [Select id,name  from account where name =  '2M PROCESS / HQ' and recordtypeid =: rtAccount.id ];       
        
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
        cont.email = 'Testashv@Sprint.com' ;
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
}