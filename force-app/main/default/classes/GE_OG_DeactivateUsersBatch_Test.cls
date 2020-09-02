@isTest
Public class GE_OG_DeactivateUsersBatch_Test{
  static testMethod void GE_OG_DeactivateUsersBatchTest() {
  
  
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
  
  listusers.add(record5);
  
  
  
  User record1=new User();
  
  record1.firstname='pavan';
  record1.lastname='gada';
  record1.Days_Since_Login__c=35;
  record1.Email='pavan.gada@ge.com';
  //record1.Is_DND__c='yes';
  //record1.Is_Risk_Approver__c='No';
  record1.Username='pavangada@ge.com.geclone';
  record1.Alias='pgada';
  record1.CommunityNickname='testname';
  record1.TimeZoneSidKey='America/New_York';
  record1.LocaleSidKey='en_US';
  record1.EmailEncodingKey='ISO-8859-1';
  record1.ProfileId=ProfileID;
  record1.LanguageLocaleKey='en_US';
  record1.IDM_Business__c ='GE Oil & Gas';
  //record1.First_Reminder__c=false;
  
  listusers.add(record1);
  
  User record2=new User();
  
  record2.firstname='pavana';
  record2.lastname='gadaa';
  record2.Days_Since_Login__c=65;
  record2.Email='pavan.gada1@ge.com';
  //record2.Is_DND__c='No';
  //record2.Is_Risk_Approver__c='Yes';
  record2.Username='pavangada1@ge.com.geclone';
  record2.Alias='pgada1';
  record2.CommunityNickname='testname1';
  record2.TimeZoneSidKey='America/New_York';
  record2.LocaleSidKey='en_US';
  record2.EmailEncodingKey='ISO-8859-1';
  record2.ProfileId=ProfileID;
  record2.LanguageLocaleKey='en_US';
  record2.IDM_Business__c ='GE Oil & Gas';
  //record2.Second_Reminder__c=false;
  
  listusers.add(record2);
  
  User record3=new User();
  
  record3.firstname='pavang';
  record3.lastname='gadag';
  record3.Days_Since_Login__c=95;
  record3.Email='pavan.gada2@ge.com';
  //record3.Is_DND__c='No';
  //record3.Is_Risk_Approver__c='No';
  record3.Username='pavangada2@ge.com.geclone';
  record3.Alias='pgada2';
  record3.CommunityNickname='testname2';
  record3.TimeZoneSidKey='America/New_York';
  record3.LocaleSidKey='en_US';
  record3.EmailEncodingKey='ISO-8859-1';
  record3.ProfileId=ProfileID;
  record3.LanguageLocaleKey='en_US';
  record3.IDM_Business__c ='GE Oil & Gas';
  //record3.Third_Reminder__c=false;
  
  listusers.add(record3);
  
  User record4=new User();
  
  record4.firstname='pavangk';
  record4.lastname='gadagk';
  record4.Days_Since_Login__c=35;
  record4.Email='pavan.gada27@ge.com';
  //record4.Is_DND__c='No';
  //record4.Is_Risk_Approver__c='No';
  record4.Username='pavangada27@ge.com.geclone';
  record4.Alias='pgada27';
  record4.CommunityNickname='testname27';
  record4.TimeZoneSidKey='America/New_York';
  record4.LocaleSidKey='en_US';
  record4.EmailEncodingKey='ISO-8859-1';
  record4.ProfileId=ProfileID;
  record4.LanguageLocaleKey='en_US';
  record4.IDM_Business__c =null;
  //record4.First_Reminder__c=false;
  
  listusers.add(record4);
  
  
  insert listusers;
  
  
   Test.startTest();
         
      GE_OG_DeactivateUsersBatch OGDB=new GE_OG_DeactivateUsersBatch();
                Database.executeBatch(OGDB);
                
       Test.stopTest();
  
  }
  
  }