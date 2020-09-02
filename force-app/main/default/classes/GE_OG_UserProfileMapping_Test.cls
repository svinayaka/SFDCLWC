@isTest
public class GE_OG_UserProfileMapping_Test {
    
    static testMethod void runTestMethod(){
    
        //List<Group> PublicGroups = new List<Group>();
        //PublicGroups = [SELECT Id, Name FROM Group where Name in ('SMax - AL Read/Write', 'SMax - SS Read/Write')];
        
        // Get profiles which will be used by users created below
        map<String,Profile> profiles = new map<String,Profile>();
        for(Profile p : ([select Name, Id from Profile]))
            profiles.put(p.Name, p);
        
        List<Group>myGroups = new List<Group>();
        Group group1 = new Group(Name='MySpecialGroup1', DeveloperName='MySpecialGroup1', Type='Regular', DoesincludeBosses = false);
        myGroups.add(group1);
        
        group1 = new Group (Name='MySpecialGroup2', DeveloperName='MySpecialGroup2', Type='Regular', DoesincludeBosses = false);
        myGroups.add(group1);
        
        insert myGroups;
        
        List<User_Profile_License_Group_Mapping__c> mappings = new List <User_Profile_License_Group_Mapping__c>();
        
        mappings.add(new User_Profile_License_Group_Mapping__c(Name='GE_AL_SM Read Only', 
                                                               Managed_Package_License_IDs__c='050A00000009BzEIAU', 
                                                               Public_Group_IDs__c=myGroups.get(0).Id));
        
        mappings.add(new User_Profile_License_Group_Mapping__c(Name='GE_SS Field Service Engineer/Technic', 
                                                               Managed_Package_License_IDs__c='050A00000009BzEIAU', 
                                                               Public_Group_IDs__c=myGroups.get(1).Id));
        
        mappings.add(new User_Profile_License_Group_Mapping__c(Name='OG_Sales/Comm Ops', 
                                                               Managed_Package_License_IDs__c='05012000000LHtiAAG'));
        

        insert mappings;
        
        User usr = new User();
        usr.FirstName = 'Test';
        usr.LastName = 'User 1';
        usr.email='yehho@ge.com';
        usr.Alias='10$$';
        usr.TimeZoneSidKey='America/New_York';
        usr.LocaleSidKey='en_US';
        usr.EmailEncodingKey='ISO-8859-1';
        usr.LanguageLocaleKey ='en_US';
        usr.Username='yomama_koshay1266@ge-forever.com';
        usr.ProfileId = profiles.get('GE_AL_SM Read Only').Id;
        usr.GE_HQ_SSO_ID__c='77&644*$$';
        
        User usr2 = new User();
        usr2.FirstName = 'Test';
        usr2.LastName = 'User 2';
        usr2.email='yehho@ge.com';
        usr2.Alias='10))';
        usr2.TimeZoneSidKey='America/New_York';
        usr2.LocaleSidKey='en_US';
        usr2.EmailEncodingKey='ISO-8859-1';
        usr2.LanguageLocaleKey ='en_US';
        usr2.Username='yomama_koshay999@ge-forever.com';
        usr2.ProfileId = profiles.get('GE_SS Field Service Engineer/Technician').Id;
        usr2.GE_HQ_SSO_ID__c='77&644*))';
        usr2.isActive = true;

        
        User usr3 = new User();
        usr3.FirstName = 'Test';
        usr3.LastName = 'User 3';
        usr3.email='yehho@ge.com';
        usr3.Alias='10))';
        usr3.TimeZoneSidKey='America/New_York';
        usr3.LocaleSidKey='en_US';
        usr3.EmailEncodingKey='ISO-8859-1';
        usr3.LanguageLocaleKey ='en_US';
        usr3.Username='yomama_koshay9154@ge-forever.com';
        usr3.ProfileId = profiles.get('OG_Sales/Comm Ops').Id;
        usr3.GE_HQ_SSO_ID__c='77&644*999))';
        usr3.IsActive=false;
        
        List<User> myUserList = new List<User>{usr, usr2, usr3};
        
        test.startTest();
        insert myUserList;
        
        //User usr4 = new User();
        //usr4 = [select Id, ProfileId from User where ProfileId = : profiles.get('OG_Sales/Comm Ops').Id and isActive = true limit 1];
        //usr4.ProfileId = profiles.get('GE_SS Field Service Engineer/Technician').Id;
        
        User usr5 = new User();
        usr5 = [select Id, ProfileId, isActive from User where Id = :usr3.id];
        usr5.isActive = true;

        User usr6 = new User();
        usr6 = [select Id, ProfileId, isActive from User where Id = :usr2.id];
        usr6.isActive = false;
        //List<User> myUpdateUserList = new List<User>{usr4, usr5};   
       // List<User> myUpdateUserList = new List<User>{usr5};
        List<User> myUpdateUserList = new List<User>{usr5,usr6};
        
        System.runAs(new User(Id = Userinfo.getUserId())) {
            Database.Saveresult[] updateRes;
            updateRes = database.update(myUpdateUserList);
        }
               
                  
        /*Set<String> groupUserIds = new Set<String>();        
        for(GroupMember m : [SELECT Id, GroupId, UserOrGroupId FROM GroupMember where GroupId in : PublicGroups])
            groupUserIds.add(m.UserOrGroupId);
        
        Set<String> packageUserIds = new Set<String>();
        for(UserPackageLicense u : [SELECT Id, UserId FROM UserPackageLicense where PackageLicenseId = '050A00000009BzEIAU'])
            packageUserIds.add(u.UserId);
    */
        
        test.stopTest();
    }


}