/*
Class Name:-      GE_OG_DeactivateUsersBatch
Overview:-        This batch class is used to update Days_Since_LastLogin for users and deactivate(Only Standard) them if not logged in for more than 90 days
Author:-          Ashish
Created Date:-    28th July 2016
*/

Global class GE_OG_DeactivateUsersBatch implements Database.Batchable<sObject>
    {
      public List<User> GE_Userlist;
      
      
        //Start Method which retrieves the users
        
      global Database.QueryLocator start(Database.BatchableContext BC)  
      {
             String GUsertype='Standard';
            if(!test.isRunningtest())
            {//Added GE_Date_Re_activated__c field in the below query as part of R-29381
             String query='Select Id,Username,UserType,ProfileId,Name,LastLoginDate,IDM_Business__c,CreatedDate,Is_DND__c,GE_HQ_SSO_ID__c,'+
                           'GE_HQ_Tier_1_P_L__c,IsActive,Email,Profile.Name,Days_Since_Login__c,GE_Date_Re_activated__c '+
                           'From User WHERE IsActive=true and UserType=:GUsertype' ;      
             
             system.debug('@@ Query On User Object' + query);            
             return Database.getQueryLocator(query);
            }
            else 
            {//Added GE_Date_Re_activated__c field in the below query as part of R-29381
             String query='Select Id,Username,UserType,ProfileId,Name,LastLoginDate,IDM_Business__c,CreatedDate,Is_DND__c,GE_HQ_SSO_ID__c,'+
                           'GE_HQ_Tier_1_P_L__c,IsActive,Email,Profile.Name,Days_Since_Login__c,GE_Date_Re_activated__c '+
                           'From User WHERE IsActive=true and UserType=:GUsertype Limit 50 ' ;      
             
             system.debug('@@ Query On User Object' + query);            
             return Database.getQueryLocator(query);
             
               }
      
          
      }

       global void execute(Database.BatchableContext BC, List<User> scope) 
       {

          GE_Userlist=new List<User>();
          Date CratedDate;
          Date loginDate;
          List<Profile_Setting_for_User_Deactivation__mdt> profileSetting = new List<Profile_Setting_for_User_Deactivation__mdt>();
          profileSetting = [Select No_of_Days_to_Deactivate__c,Profile_Name__c from Profile_Setting_for_User_Deactivation__mdt];
          Map<Id,Profile_Setting_for_User_Deactivation__mdt> mapcmt = new Map<Id,Profile_Setting_for_User_Deactivation__mdt>();
          //Added as part of R-29381
          for(User ur:scope)
           {
               for(Profile_Setting_for_User_Deactivation__mdt ps: profileSetting){
               if(ur.Profile.Name == ps.Profile_Name__c){
                     mapcmt.put(ur.Id,ps);
                  }
               }
           }//END of R-29381
          
            // Calculation of Days since last Login for every User and deactivating the users nit Logged in for more than 90 Days
            for(User u:scope)
           {

                  CratedDate = date.newinstance(u.CreatedDate.year(),u.CreatedDate.month(),u.CreatedDate.day());
                  
                  if(u.LastLoginDate != Null)
                  loginDate = date.newinstance(u.LastLoginDate.year(), u.LastLoginDate.month(), u.LastLoginDate.day());
                 
                  
                  if(u.LastLoginDate == Null) 
                  {
                    u.Days_Since_Login__c = Integer.valueof(CratedDate.daysBetween(System.Today()));
                  } 
                  else
                  {
                    u.Days_Since_Login__c=Integer.valueof(loginDate.daysBetween(System.Today()));
                  }
                  
                  System.debug('u.Days_Since_Login__c' + u.Days_Since_Login__c + '----' + Integer.valueof(Label.User_Deactivation_batch_Days.trim()));
                  //Modified below code as part of R-29381
                  if(mapcmt.size()>0){
                      if(mapcmt.containsKey(u.Id)){
                       System.debug('*********No of Days to Deactivate: ' + mapcmt.get(u.Id).No_of_Days_to_Deactivate__c);
                       System.debug('*********Date Reactivated Difference: '+Integer.valueof(u.GE_Date_Re_activated__c.daysBetween(System.Today())));
                      if(u.GE_Date_Re_activated__c!= Null){
                          if((u.Days_Since_Login__c > mapcmt.get(u.Id).No_of_Days_to_Deactivate__c) && u.Is_DND__c == false && Integer.valueof(u.GE_Date_Re_activated__c.daysBetween(System.Today()))>14){
                                  u.isActive = false;                                     
                           }
                      }            
                      else if((u.Days_Since_Login__c > mapcmt.get(u.Id).No_of_Days_to_Deactivate__c) && u.Is_DND__c == false){  
                           u.isActive = false;                              
                           }
                      }
                  }
                  else if(u.GE_Date_Re_activated__c!= Null ){
                      if(u.Days_Since_Login__c > Integer.valueof(Label.User_Deactivation_batch_Days.trim()) && u.Is_DND__c == false && Integer.valueof(u.GE_Date_Re_activated__c.daysBetween(System.Today()))>14){ 
                            u.isActive = false;                              
                      }
                  }
                  else if(u.Days_Since_Login__c > Integer.valueof(Label.User_Deactivation_batch_Days.trim()) && u.Is_DND__c == false){
                          u.isActive = false;                           
                  } //END of R-29381 
                  
              // Updating the User fields 
               GE_Userlist.add(u);  
               
                
           }
           
           // Updating the list 
           
           Database.SaveResult[] UserList = Database.Update(GE_Userlist, false);
           
            // Iterate through each returned result
            
            for (Database.SaveResult sr : UserList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully Updated user ID: ' + sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Users fields that affected this error: ' + err.getFields());
                    }
                }
            } 
     
        }

        global void finish(Database.BatchableContext BC)
        {
    
        }
}