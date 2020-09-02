global without sharing class AccountInactiveUncheckUser{
    @InvocableMethod(label='UncheckBypassUser')
    public static void uncheckByPass(){
        Id userId = UserInfo.getUserId();
        List<User> lstObjUser = [Select id, UserName, Bypass_Validations_Account_Inactivate__c
                                FROM User
                                WHERE id=: userId
                                LIMIT 1];
        if(lstObjUser.size() == 1){               
            for(User objUser: lstObjUser){
                objUser.Bypass_Validations_Account_Inactivate__c = false;
            }
            try{
                update lstObjUser;
            }
            catch(Exception e){
                system.debug('Error while updating user... '+e.getMessage());
            }
        }
        
    }
}