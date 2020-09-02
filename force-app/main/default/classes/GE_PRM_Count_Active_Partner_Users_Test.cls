@isTest
public class GE_PRM_Count_Active_Partner_Users_Test{

    static testMethod void GE_PRM_Count_Active_Partner_UsersTestMethod(){
    
    
    Test.startTest();

        Profile p = [SELECT Id FROM Profile WHERE Name='Partner Community User']; 
         User u2 = new User(Alias = 'newUser', Email='newuser@testorg.com', 
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
         LocaleSidKey='en_US', ProfileId = p.Id, 
         TimeZoneSidKey='America/Los_Angeles', UserName='new12userPRM@testorg.com');
         
        //System.runAs(u2) {
            String TestAccountName = system.Label.Test_Account_Name;
            Account testRRAccount = new Account(name=TestAccountName);
             insert testRRAccount;
            account acc=new account();
            acc.GE_PRM_Active_PRM_Users__c=1;    
            acc.name='testacc';
            acc.Account_Status__c ='New';
            acc.GE_PW_Phone_New_Request__c='123456789';
            acc.GE_HQ_New_Account_Street__c='Room 203, Building Nanxuefu Garden, Zhaowuda Rd.';
            acc.GE_HQ_New_Account_City__c='Huhehaote';
            acc.GE_HQ_New_Account_State_Province__c='Inner Mongolia';
            acc.GE_HQ_New_Account_Zip_Postal_Code__c='010040';
            acc.GE_HQ_New_Account_Country__c='CHINA';
            //acc.IsPartner =true;
           // IspersonAccount=true;
            /*Filter criteria fix starts*/
            RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Relationship Account' Limit 1]; 
            acc.RecordTypeId = rt.Id;
            /*Filter criteria fix ends here*/
            acc.Type = 'Direct Customer';
            acc.Classification__c = 'Strategic';
           insert acc;
            
            contact c = new contact();
            c.GE_OG_Contact_Audience__c='Customer Care';
            c.lastName = 'test';
            c.firstName = 'name';
            c.accountId = acc.id;
            c.phone='243241234';
            c.email = 'abc@gmail.com';
            insert c;
            
            u2.contactId = c.id;
            u2.GE_HQ_Tier_3_P_L__c = 'DOS - Opex CS';
            insert u2;
                    //sch.execute(acc );
            GE_PRM_Count_Active_Partner_Users sh1 = new GE_PRM_Count_Active_Partner_Users();    
            String sch = '0  00 1 3 * ?';
            system.schedule('Test Job', sch, sh1); 
       //}    
       Test.stopTest();
        
    }
  
 }