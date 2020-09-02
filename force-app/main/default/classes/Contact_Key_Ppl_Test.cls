@isTest
public class Contact_Key_Ppl_Test{

    @testsetup
     static void createTestData(){
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account KP test';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c ='Industrial';
        acc.Country_GEOG__c = 'India';
        insert acc;
        
        Contact objCon = new Contact();
        objCon.FirstName = 'testConKP123';
        objCon.LastName = 'LastnameKP123';
        objCon.email = 'test@kp123.com';
        objCon.AccountId = acc.id;
        //objCon.recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Commercial Contact').getRecordTypeId();
        insert objCon;
     }
    public static testMethod void testFollowUnfollow(){
        test.startTest();
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account KP';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c ='Industrial';
        acc.Country_GEOG__c = 'India';
        insert acc;
        
        Contact objCon = new Contact();
        objCon.FirstName = 'testConKP';
        objCon.LastName = 'LastnameKP';
        objCon.email = 'test@kp.com';
        objCon.AccountId = acc.id;
        //objCon.recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Commercial Contact').getRecordTypeId();
        insert objCon;
        
        /*ID loginUserID = UserInfo.getUserID();
        GEOG_Contact_Team__c objTeam = new GEOG_Contact_Team__c();
        objTeam.Team_Role__c = 'Sales';
        objTeam.Contact_Team_Member__c = loginUserID;
        objTeam.Contact__c = objCon.id;
        insert objTeam;*/
        
        List<id> lstCon = new List<id>();
        lstCon.add(objCon.id);
        
        Contact_KeyPeople_FollowUnFollow.updateContactFollow_UnFollow(lstCon);
        test.stopTest();
        
        
    }
    
    public static testMethod void testFollowUnfollow2(){
        test.startTest();
        Contact con = [Select ID, Name from Contact where email= 'test@kp123.com' LIMIT 1];
        
         Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        User objUser = new User(Alias = 'standt1', Email='standarduser1@testbsoft.com', 
        EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser1@testbsoft.com');
        insert objUser;
        List<ID> lstID = new List<ID>();
        lstID.add(con.ID);
        
        system.runAs(objUser){
            Contact_KeyPeople_FollowUnFollow.updateContactFollow_UnFollow(lstID);
            Contact_KeyPeople_FollowUnFollow.updateContactFollow_UnFollow(lstID);
            ContactKeyPeopleCreate_Update.contactTeamCreateUpdate(lstID);
        }
        test.stopTest();
    }
    
    public static testMethod void testFollowUnfollow3(){
        test.startTest();
        Contact con = [Select ID, Name from Contact where email= 'test@kp123.com' LIMIT 1];
        List<ID> lstID = new List<ID>();
        lstID.add(con.ID);
        //ContactKeyPeopleCreate_Update.contactTeamCreateUpdate(lstID);
        
        /*Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User objUser = new User(Alias = 'standt1', Email='standarduser1@testbsoft.com', 
        EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser1@testbsoft.com');
        insert objUser;
        
        con.ownerId = objUser.id;
        update con;*/
         List<GEOG_Contact_Team__c> lstExistingOwner  = [SELECT Id,name,Contact__c,Contact_Team_Member__c,                                        
                            Contact_User_Entry__c,Team_Role__c
                            FROM GEOG_Contact_Team__c
                            WHERE Contact__c =:con.id AND Team_Role__c ='Sales - Primary'
                            LIMIT 1];
        if(!lstExistingOwner.isEmpty()){
            delete lstExistingOwner;
        }
        ContactKeyPeopleCreate_Update.contactTeamCreateUpdate(lstID);
        test.stopTest();
    }
    public static testMethod void testCreateUpdate(){
        test.startTest();
        Contact con = [Select ID, Name,ownerId from Contact where email= 'test@kp123.com' LIMIT 1];
        List<ID> lstID = new List<ID>();
        lstID.add(con.ID);
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User objUser = new User(Alias = 'standt1', Email='standarduser31311@testbft.com', 
        EmailEncodingKey='UTF-8', LastName='Testing1', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarer1@testbsoft.com');
        insert objUser;
        
        GEOG_Contact_Team__c objConTeam = new GEOG_Contact_Team__c();
        objConTeam.Team_Role__c = 'Sales - Primary';
        objConTeam.Contact__c = con.id;
        objConTeam.Contact_Team_Member__c = objUser.id;
        insert objConTeam;
        
        ContactKeyPeopleCreate_Update.contactTeamCreateUpdate(lstID);
        test.stopTest();
    }
}