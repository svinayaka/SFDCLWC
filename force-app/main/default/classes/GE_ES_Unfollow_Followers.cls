/*
Type Name [Class/Trigger/Page Name] : Class
Used Where ?                        : Used to Remove the People following an Individual. Class Displays a Pic and the Title of the Follower as well.
Functional Area                     : Chatter
Author                              : Sanjay Kumar Patidar
Created Date                        : Dec 10th 2011
Test Class Name                     : Test_GE_ES_Unfollow_Followers

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

/*
Dependency -
1. Helper Class - GE_ES_Follower_Photo is required to Associate the Photo and the User Details together.
*/

Public Class GE_ES_Unfollow_Followers
    {
    //Constructor
    public GE_ES_Unfollow_Followers() 
        {
        }    

    //Variable Declarations.
    public Id removeFollower {get;set;}
    public set<Id> userPhoto = new Set<Id>();
    public Integer DisplayedListSize {get;set;}
    public List<EntitySubscription> myFollowers = new List<EntitySubscription>();
    public List<User> myFollowersPhoto = new List<User>();
    
    //Logged in user Id
    public ID UserId = UserInfo.getUserId();

    //List of the Logged in User Followers
    public EntitySubscription[] getmyFollowers()
        {
        myFollowers = [Select Id, ParentId, SubscriberId, Subscriber.Name, Subscriber.Title, CreatedById FROM EntitySubscription WHERE ParentId =:UserId LIMIT 1000];
        system.debug('My Followers - '+myFollowers);
        for(Integer i=0; i<myFollowers.size(); i++)
            {
            userPhoto.add(myFollowers[i].SubscriberId);
            }

       return [Select Id, ParentId, SubscriberId, Subscriber.Name, Subscriber.Title, CreatedById FROM EntitySubscription WHERE ParentId =:UserId LIMIT 1000];
       
        }
    //Query the Photo Url for the Followers
    public User[] getPhotoUrl()
        {
        return [Select Id, SmallPhotoUrl,FullPhotoUrl FROM User WHERE Id IN:userPhoto];
        }
    //Method to Call the Helper Class and pass the Follower List and the Phot Url. 
    public GE_ES_Follower_Photo[] getMyFollowerList()
        {
        List<GE_ES_Follower_Photo> result = new List<GE_ES_Follower_Photo>();
        
        //Calling above methods for the Data Set.
        EntitySubscription[] AllEntitySubricptions = getmyFollowers(); 
        User[] AllEntitySubricptionsPhotos = getPhotoUrl();

        //Loop through the Complete data set of Subscribers.
        for(EntitySubscription es: AllEntitySubricptions) 
            { 
            //get the related PhotoUrl
            User curPhotoUrl; 
            for(User u: AllEntitySubricptionsPhotos) 
                { 
                if(u.Id == es.SubscriberId) 
                    { 
                    curPhotoUrl = u; 
                    break; 
                    
                    }
                  
                 }
            //Add the records to the Helper Class Final List 
            result.add(new GE_ES_Follower_Photo(es, curPhotoUrl)); 
            }
       return result;
       }

    //Remove Follower Method.              
    public PageReference RemoveFollowers()
        {
        try
            {
            //Add the Id of the Follower to be removed to the Entity Subscription List.
            List<EntitySubscription> removeFollowerList = new List<EntitySubscription>();
            removeFollowerList.add(new EntitySubscription(Id=removeFollower));
            // Remove Follower
            Delete removeFollowerList;
            }
        catch (DMLException e)
            {
            system.debug('Error - '+e);
            }
        if(ApexPages.hasMessages())
            {
            return null;
            }
        //If current page do not have any errors it will return to the below page
        else
            {
            //Redirect the User to the Same Page.
            PageReference pageRef = new PageReference('/apex/GE_ES_Unfollow_Followers');
            pageRef.setRedirect(true);
            return pageRef;
            } 
        }   
    }