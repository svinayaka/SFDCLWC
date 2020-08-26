trigger UserInsertUpdate on User (before insert, before update) 
{
    String adminEmail;
    String userName;
    User userForErrorReport;
    System.debug('Entering UserInsertUpdate trigger');
    try
    {       
        adminEmail = UserMaintenance.validateConfigRecord();        
        
        Integer myFutureCalls; 
        Integer sfLimitFutureCalls;
        
        Boolean callOut = true;
        
        // Loop through Users 
        for (User user : Trigger.New)
        {
            // Set the user name and user
            userForErrorReport = user;
            userName = user.Username;
            
            System.debug('UserMaintenance.allowFutureCall = '  + UserMaintenance.allowFutureCall);
            // Check if the future call is allowed
            if(UserMaintenance.allowFutureCall == true)
            {
                System.debug('user.isBMEnabled__c - ' + user.isBMEnabled__c);
                System.debug('user.BMMassProvisioning__c'  + user.BMMassProvisioning__c);
                // Check if the bm mass provisioning is not set
                if (user.BMMassProvisioning__c == false)
                {
                    
                    System.Debug('test for new user - ' + user.UserName);
                    
                    UserMaintenance.callOut = true;
                    
                    // Set the call out to false if the user is a test user
                    if (user.Department == BMGlobal.TEST_USER || user.Department == BMGlobal.TEST_USER_100)
                        UserMaintenance.callOut = false;
                    
                    Boolean invokeTrigger = false;
                    
                    // check if the trigger is insert or update
                    if (Trigger.isInsert)
                    {
                        System.debug('user in Insert');
                        if (user.IsActive == true && user.isBMEnabled__c == true)
                            invokeTrigger = true;
                    }
                    else
                    {
                        System.debug('user in Update');
                        
                        // Check if the active flag has changed
                        Boolean activeFlagChanged = (Trigger.oldMap.get(user.Id).IsActive != user.IsActive);
                        
                        // Check if the bm enabled flag has changed
                        Boolean isBMEnabledFlagChanged = (Trigger.oldMap.get(user.Id).isBMEnabled__c != user.isBMEnabled__c);
                        
                        // Check if the active and bm enabled flag are both set to false
                        if (activeFlagChanged && isBMEnabledFlagChanged && user.IsActive == false && user.isBMEnabled__c == false)
                            invokeTrigger = true;
                        
                        // Check if the invoke trigger is still false
                        if (invokeTrigger == false)
                        {
                            // Check if the user active flag is set to false
                            if (user.IsActive == false && activeFlagChanged && user.isBMEnabled__c == true)
                                invokeTrigger = true;
                            else
                            {
                                // Check if the user is active
                                if (user.IsActive)
                                {
                                    // if we reached here then bm enabled is set to false
                                    if (isBMEnabledFlagChanged)
                                        invokeTrigger = true;
                                    else
                                    {                           
                                        // Check if data related to BM has changed
                                        if (user.isBMEnabled__c)
                                        {
                                            invokeTrigger = (Trigger.oldMap.get(user.Id).BMDateFormat__c != user.BMDateFormat__c) ||
                                                (Trigger.oldMap.get(user.Id).BMCurrencyPreference__c != user.BMCurrencyPreference__c) ||
                                                (Trigger.oldMap.get(user.Id).BMLanguage__c != user.BMLanguage__c) ||
                                                (Trigger.oldMap.get(user.Id).BMNumberFormat__c != user.BMNumberFormat__c) ||
                                                (Trigger.oldMap.get(user.Id).BMUserGroup__c != user.BMUserGroup__c) ||
                                                (Trigger.oldMap.get(user.Id).BMUnit__c != user.BMUnit__c) ||
                                                (Trigger.oldMap.get(user.Id).BMTimeZone__c != user.BMTimeZone__c) ||
                                                (Trigger.oldMap.get(user.Id).BMUserType__c != user.BMUserType__c) ||
                                                (Trigger.oldMap.get(user.Id).BMUserAccessType__c != user.BMUserAccessType__c);
                                            
                                            System.debug('invokeTrigger after checking if any BM field values have been modified - ' + invokeTrigger);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    System.debug('invokeTrigger - ' + invokeTrigger);
                    
                    // Check if the trigger is true
                    if (invokeTrigger == true)
                    {
                        System.debug('Checking validateConfigRecord()');
                        //check if config record exists                     
                        if(adminEmail == null)
                        {
                            user.isBMEnabled__c = false;                        
                            user.addError(BMGlobal.ERROR_NO_CONFIG_RECORD);
                        }
                        else
                        {
                            // Check if the user is not active, then force the is BM Enabled to false
                            if (user.IsActive == false) 
                                user.isBMEnabled__c = false;
                            
                            String errorMessage = '';
                            // check if user's configuration is valid
                            if (user.ContactId != null && user.BMUserType__c == BMGlobal.BM_INTERNAL_USER) {
                                System.debug('Invalid BMUserType because user is tied to contact meaning it is either Partner Portal user or Customer Portal user');
                                errorMessage = 'User ' + userName + ' was not updated/inserted.<br/>\'' + BMGlobal.BM_INTERNAL_USER + 
                                    '\' is not valid for Customer Portal Manager User License or Partner User License. Please select \'' + BMGlobal.BM_PARTNER_USER + '\' for BM User Type.';
                            } else if (user.ContactId == null && user.BMUserType__c == BMGlobal.BM_PARTNER_USER) {
                                System.debug('Invalid BMUserType because user is not tied to contact meaning it is Sales force user');
                                errorMessage = 'User ' + userName + ' was not updated/inserted. <br/>\'' + BMGlobal.BM_PARTNER_USER + 
                                    '\' is not valid for Salesforce User License. Please select \'' + BMGlobal.BM_INTERNAL_USER + '\' for BM User Type.';
                            } 
                            if (user.BMUserAccessType__c == null) {
                                System.debug('Invalid BMUserType, BMUserAccessType, BMPartnerCompanyName configuration');
                                if (errorMessage.length()==0) {
                                    errorMessage = 'User ' + userName + ' was not updated/inserted.<br/>Please select valid BM User Access Type.';
                                } else {
                                    errorMessage += '<br/>Please select valid BM User Access Type.';
                                }
                            } 
                            if (errorMessage.length() == 0){
                                System.debug('before UserMaintenance.insertUpdateUser');
                                
                                System.debug('after UserMaintenance.insertUpdateUser');
                            } else {
                                user.addError(errorMessage);
                            }
                            System.debug('user.isBMEnabled__c - ' + user.isBMEnabled__c);
                        }
                    } else {
                        System.debug('invokeTrigger false');
                    }
                }
                else
                    System.debug('invokeTrigger false - user.BMMassProvisioning__c = true');
            }
            else
                System.debug('invokeTrigger false - UserMaintenance.allowFutureCall = false');
        }
    }
    catch(System.AsyncException asyncEx){
        System.debug('System.AsyncException in UserInsertUpdate trigger: ' + asyncEx.getMessage());
        //send an email to the specified email address
        if (adminEmail != null && adminEmail.length() > 0)
        {   if(asyncEx.getMessage().contains(BMGlobal.ERROR_SFDC_CALLOUT_LIMIT_REACHED))         
            UserMaintenance.SendExceptionMessage(adminEmail, BMGlobal.ERROR_CALLOUT_LIMIT_REACHED + ' User ' + userName + ' was not updated/inserted');         
        }
        
        // Check current user id 
        if(userForErrorReport != null)
        {
            if(asyncEx.getMessage().contains(BMGlobal.ERROR_SFDC_CALLOUT_LIMIT_REACHED))
                userForErrorReport.addError(BMGlobal.ERROR_CALLOUT_LIMIT_REACHED + ' User ' + userForErrorReport.Username + ' was not updated/inserted');
            else
                userForErrorReport.addError(asyncEx.getMessage());
        }   
    }
    System.debug('Exiting UserInsertUpdate trigger');   
}