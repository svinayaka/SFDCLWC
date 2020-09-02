/*
Type Name [Class/Trigger/Page Name] : Helper Class
Used Where ?                        : Helper Class for the Main Class - GE_ES_Unfollow_Followers
Functional Area                     : Chatter
Author                              : Sanjay Kumar Patidar
Created Date                        : Dec 10th 2011
Test Class Name                     : Test_GE_ES_Unfollow_Followers

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

public class GE_ES_Follower_Photo
    {
    //Variable Decalrations 
    public EntitySubscription es { get; set; } 
    public User u { get; set; } 
    
    // Constructor - Collecting Values passed from the Main Class and setting the Values.
    public GE_ES_Follower_Photo(EntitySubscription es1, User u1) 
        { 
        es= es1;
        u = u1; 
        }
    }