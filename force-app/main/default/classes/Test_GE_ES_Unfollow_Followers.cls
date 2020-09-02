/*
Type Name [Class/Trigger/Page Name] : Test Class
Used Where ?                        : Test Class for the Main Class - GE_ES_Unfollow_Followers & GE_ES_Follower_Photo
Functional Area                     : Chatter
Author                              : Sanjay Kumar Patidar
Created Date                        : Dec 19th 2011
Test Class Name                     : 

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

@isTest
private class Test_GE_ES_Unfollow_Followers
    {
    static testMethod void Test_GE_ES_Unfollow_Followers()
        {
        //Query the Profile Id for the User Creation
        Profile UserProfileId = [Select Id from Profile where name = 'System Administrator'];
        
        //Create a List of Users (Logged in User & Followers) 
        List<User> Followers = new List<User>();  
        User CurrentUser = new User(firstname = 'Current', lastname = 'User', email = 'currentuser@ge.com', alias = 'CUser', profileId = UserProfileId.Id, Username = 'CurrentUser@ge.com', title = 'Current User', CommunityNickname = 'CUser', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        //Insert the Current User
        insert CurrentUser;
        
        User FollowerUser1 = new User(firstname = 'Follower', lastname = 'User 1', email = 'followeruser@ge.com', alias = 'FUser1', profileId = UserProfileId.Id, Username = 'FollowerUser1@ge.com', title = 'Current User', CommunityNickname = 'FUser1', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        User FollowerUser2 = new User(firstname = 'Follower', lastname = 'User 2', email = 'followeruser@ge.com', alias = 'FUser2', profileId = UserProfileId.Id, Username = 'FollowerUser2@ge.com', title = 'Current User', CommunityNickname = 'FUser2', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        User FollowerUser3 = new User(firstname = 'Follower', lastname = 'User 3', email = 'followeruser@ge.com', alias = 'FUser3', profileId = UserProfileId.Id, Username = 'FollowerUser3@ge.com', title = 'Current User', CommunityNickname = 'FUser3', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        User FollowerUser4 = new User(firstname = 'Follower', lastname = 'User 4', email = 'followeruser@ge.com', alias = 'FUser4', profileId = UserProfileId.Id, Username = 'FollowerUser4@ge.com', title = 'Current User', CommunityNickname = 'FUser4', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        User FollowerUser5 = new User(firstname = 'Follower', lastname = 'User 5', email = 'followeruser@ge.com', alias = 'FUser5', profileId = UserProfileId.Id, Username = 'FollowerUser5@ge.com', title = 'Current User', CommunityNickname = 'FUser5', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        
        // Add the Followers to the List
        Followers.add(FollowerUser1);
        Followers.add(FollowerUser2);
        Followers.add(FollowerUser3);
        Followers.add(FollowerUser4);
        Followers.add(FollowerUser5);
        
        //Insert Followers
        Insert Followers;
        
        //Entity Subscription List and Records.
        List<EntitySubscription> myFollowers = new List<EntitySubscription>();
        EntitySubscription Follower1 = new EntitySubscription(ParentId = CurrentUser.Id, SubscriberId = Followers[0].Id);
        EntitySubscription Follower2 = new EntitySubscription(ParentId = CurrentUser.Id, SubscriberId = Followers[1].Id);
        EntitySubscription Follower3 = new EntitySubscription(ParentId = CurrentUser.Id, SubscriberId = Followers[2].Id);
        EntitySubscription Follower4 = new EntitySubscription(ParentId = CurrentUser.Id, SubscriberId = Followers[3].Id);
        EntitySubscription Follower5 = new EntitySubscription(ParentId = CurrentUser.Id, SubscriberId = Followers[4].Id);
        
        myFollowers.add(Follower1);
        myFollowers.add(Follower2);
        myFollowers.add(Follower3);
        myFollowers.add(Follower4);
        myFollowers.add(Follower5);
        
        //Insert Entity Subscriptions.
        Insert myFollowers;
        
        //Run the Code as Logged in User
        system.runAs(CurrentUser)
            {
            //Initiate the Page
            PageReference pageRef = new PageReference('/apex/GE_ES_Unfollow_Followers');
            system.test.setCurrentPageReference(pageRef);  
            
            GE_ES_Unfollow_Followers unFollowers = new GE_ES_Unfollow_Followers();
            //Set the Unfollwer Id and Call the Methods.
            unFollowers.removeFollower = myFollowers[0].Id;
            unFollowers.getMyFollowerList();
            unFollowers.RemoveFollowers();
            }
        }
    }