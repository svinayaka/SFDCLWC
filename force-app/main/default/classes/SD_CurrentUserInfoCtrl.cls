public with sharing class SD_CurrentUserInfoCtrl {
   @AuraEnabled 
    public static Boolean fetchUser(){
     // query current user information  
      User oUser = [select id,Name,Profile.Name FROM User Where id =: userInfo.getUserId()];
        
        if(oUser!= null && (oUser.Profile.Name == 'Service Delivery Dispatcher' || oUser.Profile.Name == 'Service Delivery Field Services Personnel'))
            return true;
        
        return false;
    }
}