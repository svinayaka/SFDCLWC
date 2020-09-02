/*********************************************
* Class Name: 	GE_HQ_PwResetForUserWebmethod
* Latest:		Moving this code out from a trigger and into a class to be called from the single User trigger
* Purpose: 	    Reset Password for webmethods.integration users 
* Date: 		June 2017
* Author:		Sean Kim
*********************************************/

public class GE_HQ_PwResetForUserWebmethod {
    
   public static void runOperation (String operation, List<User> newData, map<Id, User> oldMapData){
    
    If(UserInfo.getUserName().toUpperCase().contains('WEBMETHODS.INTEGRATION')) {
        EmailTemplate et = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'User_Creation_Updated_Mail_VF_Template' LIMIT 1];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        For(User u: newData) {
            String[] UserEmail = new String[]{u.Email};
            System.debug('====User Name===' + u.id);
           if(Operation == 'Insert' || (Operation == 'Update' && oldMapData.get(u.id).IsActive != u.IsActive && u.IsActive == true)) {
                mail.setTemplateID(et.id);
                mail.setSaveAsActivity(false);
                mail.setWhatId(u.id);
                mail.setTargetObjectId(u.id);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            }
        }
    }
 }
}