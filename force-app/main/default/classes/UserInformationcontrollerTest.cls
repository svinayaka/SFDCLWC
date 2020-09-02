@isTest
public class UserInformationcontrollerTest 
{
   
    static testMethod void testMethod1() 
    { 
        ID ProfileID = [ Select id,UserType from Profile where name = 'System Administrator' and UserType='standard'].id;
 
  list<user> listusers=new   list<user>();
  
  User record5=new User();
  
  record5.firstname='pavan';
  record5.lastname='gada5';
  //record1.Days_Since_Login__c=30;
  record5.Email='ashish.vashisht@ge.com';
 // record1.Is_DND__c='No';
 // record1.Is_Risk_Approver__c='No';
  record5.Username='ashish.vashisht@ge.com.geclone';
  record5.Alias='pgada5';
  record5.CommunityNickname='testname5';
  record5.TimeZoneSidKey='America/New_York';
  record5.LocaleSidKey='en_US';
  record5.EmailEncodingKey='ISO-8859-1';
  record5.ProfileId=ProfileID;
  record5.LanguageLocaleKey='en_US';
  record5.GE_HQ_SSO_ID__c='21271711';
  
  //listusers.add(record5);
  insert record5;
 
  system.runAs(record5){
   Test.StartTest();
   PageReference pageRef = Page.CustomLoginError;
   ApexPages.currentPage().getParameters().put('sso', '21271711');
   UserInformationcontroller userclr=new UserInformationcontroller();
   userclr.sso='1234';
   userclr.searchUsers();
   UserInformationcontroller userclr1=new UserInformationcontroller();
   userclr1.searchUsers();
   
   userclr.searchUsers();
   UserInformationcontroller userclr2=new UserInformationcontroller();
   userclr2.sso='212717101';
   userclr2.searchUsers();
   

   Test.StopTest();

    }
    }
     
    
     
    
}