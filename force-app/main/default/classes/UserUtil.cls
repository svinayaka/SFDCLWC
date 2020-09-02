/*
Class Name 			   : UserUtil
Used Where ?           : OpportunityCustomerLegalEntity_GE_OG,Opportunity_Stage_Won_Lost_Nego_GE_OG
Purpose/Overview       : lazy loading of the loggedin user to avoid 101 exception. 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-32605
Author                 : Harsha C
Created Date           : 24/AUG/2019
Test Class Name        : UserUtil_Test
Code Coverage          : 93%
*/
public class UserUtil {
    //Protected Members
    private static final UserUtil instance = new UserUtil();
    private Map<Id, User> mapUsers;
    
    //Properties
    public static User CurrentUser {
        get { return getUser(UserInfo.getUserId()); }
    }
    
    //Constructor
    private UserUtil() {
        mapUsers = new Map<Id, User>(queryUsers());
    }
    
    //Public Methods
    public static User getUser(Id userId) {
        if (instance.mapUsers.containsKey(userId)) {
            return instance.mapUsers.get(userId);
        }
        else {
            throw new InvalidUserIdException('Unable to locate user id: ' + userId);
        }
    }
    
    //Private Methods
    private List<User> queryUsers() {
       List<User> userList = [SELECT 
                Id
                , Name
                , UserName
                , Email
                , Alias,Disable_validations_for_MERGE__c 
                FROM 
                User where Id=:UserInfo.getUserId()];
         return userList;
    }
    
    //Internal Classes
    public class InvalidUserIdException extends Exception {}
}