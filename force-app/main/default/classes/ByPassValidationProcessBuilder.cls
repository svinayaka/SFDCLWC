global without sharing class ByPassValidationProcessBuilder{
    @InvocableMethod(label='BypassPB')
    public static void bypassPB(List<String> input){
        Id userId = UserInfo.getUserId();
        List<User> lstObjUser = [Select id, UserName, Bypass_Validations_Account_Inactivate__c
                                FROM User
                                WHERE id=: userId
                                LIMIT 1];
        if(lstObjUser.size() == 1){               
            for(User objUser: lstObjUser){
                objUser.Bypass_Validations_Account_Inactivate__c = Boolean.valueOf(input[0]);
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