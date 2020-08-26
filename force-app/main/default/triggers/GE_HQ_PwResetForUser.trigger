Trigger GE_HQ_PwResetForUser on User(after insert, after update) {
    If(UserInfo.getUserName().toUpperCase().contains('WEBMETHODS.INTEGRATION')) {
        EmailTemplate et = [SELECT id FROM EmailTemplate WHERE DeveloperName = 'User_Creation_Updated_Mail_VF_Template' LIMIT 1];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        For(User u: Trigger.New) {
            String[] UserEmail = new String[]{u.Email};
            System.debug('====User Name===' + u.id);
           if(Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(u.id).IsActive != u.IsActive && u.IsActive == true)) {
                mail.setTemplateID(et.id);
                mail.setSaveAsActivity(false);
                mail.setWhatId(u.id);
                mail.setTargetObjectId(u.id);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            }
        }
    }
}