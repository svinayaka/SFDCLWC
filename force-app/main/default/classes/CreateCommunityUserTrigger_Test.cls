@isTest 
public class CreateCommunityUserTrigger_Test {
    static testMethod void CreateCommunityUserTrigger_Test() {
    
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
   //List<Profile> pf = [Select id,name from Profile where name ='II Partner Community User' limit 1];
     account acc = new account(name= 'Predix Test 1');
     acc.GE_HQ_DUNS_Number__c = 'GEGUL1012';
     acc.RecordtypeId = CommAccrecType ;
     acc.classification__c ='test';
     acc.type ='test';
     insert acc;
      Predix_Community_Access_Request__c PCA = new Predix_Community_Access_Request__c();
      PCA.GE_OG_Customer_First_Name__c='David';
      PCA.GE_OG_Contact_Phone__c='21313';
      PCA.GE_OG_Account__c=acc.id;
      PCA.GE_OG_Contact_Email__c='test2@ge.com';
      PCA.GE_OG_Company_Organization_Name__c='ABC';
      PCA.GE_OG_Customer_Last_Name__c='1';
     PCA.GE_OG_Predix_Request_Status__c ='Pending';
      insert PCA;
      
       PCA.GE_OG_Predix_Request_Status__c ='Approved';
       update PCA;
 
      
    }
}