/*
Class Name                   - GE_OG_User_TriggerHandler
Object Name                  - User
Created Date                 - 8/11/2014
Description                  -  Handler Class GE_OG_User_TriggerHandler would process all the Trigger requests coming from GE_OG_User_Trigger
                               All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/
public without sharing class GE_OG_User_TriggerHandler{

  
/* added for R-26652 
*/
   public void updateRegionOnUser(List<User> UserList){
        for (User User: UserList){
            if(User.GE_DS_Country__c != ''){
                User.GE_OG_Region__c = Util_GE_OG.regionPopulateByCountry(User.GE_DS_Country__c);
            }
        } 
    }      



    public void OnBeforeInsert(List<User> newObjects){
        // EXECUTE BEFORE INSERT LOGIC
        System.debug('Insert begin GE_OG_User_TriggerHandler OnBeforeInsert');
        UserInsertUpdateBigMachines.runOperation('Insert', newObjects, null);
        System.debug('Insert done GE_OG_User_TriggerHandler OnBeforeInsert');
    }

    public void OnAfterInsert(List<User> newObjects){
        // EXECUTE AFTER INSERT LOGIC
        GE_OG_UserProfileMapping.assignLicenseAndGroups(null, null, newObjects, true);
        GE_HQ_PwResetForUserWebmethod.runOperation('Insert', newObjects, null);
       
    }
    
    public void OnBeforeUpdate(List<User> oldObjects, Map<Id, User> oldObjectMap, List<User> newObjects, Map<Id, User> newObjectMap){
        // BEFORE UPDATE LOGIC
        UserInsertUpdateBigMachines.runOperation('Update', newObjects, oldObjectMap);
                 
    }
    
    public void OnAfterUpdate(List<User> oldObjects, Map<Id, User> oldObjectMap, List<User> newObjects, Map<Id, User> newObjectMap){
        // AFTER UPDATE LOGIC
        GE_OG_UserProfileMapping.assignLicenseAndGroups(oldObjects, oldObjectMap, newObjects, false);
        GE_HQ_PwResetForUserWebmethod.runOperation('Update', newObjects, oldObjectMap);   
        
         //R-26376 : Below is written to remove the Servicemax licenses for Inactive Users
         Set<Id> usrSet = new Set<Id>();
         for(User newUsr:newObjects)
         {
             for(User oldUsr:oldObjects)
             {
                  if(newUsr.Id==oldUsr.Id && newUsr.IsActive==false)
                    usrSet.add(newUsr.Id);
             }   
         }
          /*Commented below code as part of 0000025224  
         if(usrSet.size()>0)         
            GE_OG_UserProfileMapping.deleteSmaxLicence(usrSet);
            GE_OG_UserProfileMapping.deletePackageLicence(usrSet);  */   
     }

    /* uncomment as needed
    public void OnBeforeDelete(List<User> ObjectsToDelete, Map<Id, User> oldObjectMap){
        // BEFORE DELETE LOGIC
    }

    public void OnAfterDelete(List<User> deletedObjects, Map<Id, User> oldObjectMap){
        // AFTER DELETE LOGIC
    }

    public void OnUndelete(List<User> restoredObjects){
        // AFTER UNDELETE LOGIC
    }

    */

}