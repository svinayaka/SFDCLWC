@isTest
Public class GE_OG_RemovePackageLicenses_Test{
  static testMethod void GE_OG_RemovePackageLicenses_Test() {
  
  
  ID ProfileID = [ Select id,UserType from Profile where name = 'System Administrator' and UserType='standard'].id;
 
  list<user> listusers=new   list<user>();
  
  list<Package_License_List__c> plist = new list<Package_License_List__c>();
  
  Package_License_List__c p = new Package_License_List__c();
  p.Package_License_Ids__c = '0500t0000008PDkAAM';
  p.name = 'Seismic' ;
  
  plist.add(p);
  insert plist;
  
  User record5=new User();
  
  record5.firstname='pavan';
  record5.lastname='gada5';
  record5.Email='akanksha.pillay@ge.com';
  record5.Username='akanksha.pillay@ge.com.geclone';
  record5.Alias='pgada5';
  record5.CommunityNickname='testname5';
  record5.TimeZoneSidKey='America/New_York';
  record5.LocaleSidKey='en_US';
  record5.EmailEncodingKey='ISO-8859-1';
  record5.ProfileId=ProfileID;
  record5.LanguageLocaleKey='en_US';
  record5.isactive= False;
  
  listusers.add(record5);
  
  
  
  User record1=new User();
  
  record1.firstname='pavan';
  record1.lastname='gada';
  record1.Days_Since_Login__c=35;
  record1.Email='pavan.gada@ge.com';
  record1.Username='pavangada@ge.com.geclone';
  record1.Alias='pgada';
  record1.CommunityNickname='testname';
  record1.TimeZoneSidKey='America/New_York';
  record1.LocaleSidKey='en_US';
  record1.EmailEncodingKey='ISO-8859-1';
  record1.ProfileId=ProfileID;
  record1.LanguageLocaleKey='en_US';
  record1.IDM_Business__c ='GE Oil & Gas';
  record1.isactive=True;

  
  listusers.add(record1);  
  
  
  
  insert listusers;
  
  
   Test.startTest();
         
      GE_OG_RemovePackageLicenses OGDB=new GE_OG_RemovePackageLicenses();
                Database.executeBatch(OGDB, 1);
                
       Test.stopTest();
  
  }
  
  }