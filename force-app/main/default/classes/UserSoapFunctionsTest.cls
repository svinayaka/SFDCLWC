@isTest
private class UserSoapFunctionsTest {
    
    // API user name and password
    private static BMUserSecurity__c getAPIUserInfo()
    {
        BMUserSecurity__c[] userSecurities = [SELECT APIUserName__c, APIUserPassword__c, APISubDomain__c, BMSSLRequired__c, AdminEmail__c FROM BMUserSecurity__c WHERE isActive__c = true LIMIT 1];
        BMUserSecurity__c userSecurity;
        if (userSecurities != null && userSecurities.size() > 0)
            userSecurity = userSecurities[0];
        
        return userSecurity;
    }
            
    private static BMUserSecurity__c getBmSec(){
        BMUserSecurity__c bmSec = new BMUserSecurity__c();
        bmSec.isActive__c = true;       
        bmSec.APIUserName__c = 'BM API User';
        bmSec.APISubDomain__c = 'nsalesdemo';
        bmSec.APIUserPassword__c = 'BM password';
        bmSec.AdminEmail__c = 'email@email.com';    
        bmSec.BMSSLRequired__c = false;     
        return bmSec;   
    
    }

    private static User getUserInfo()
    {
        Profile p = [Select id from Profile where profile.Name = 'Standard User'];
        
        //User user;
        User user = new User(CompanyName='CompanyName', 
                              Username='testuser123@test.com', 
                              FirstName='FirstName1', 
                              LastName = 'LastName1', 
                              Title = 'Title', 
                              Email='testuser1@ge.com', 
                              Phone='1234567890', 
                              Fax = '9999999999', 
                              Street ='123 any street', 
                              City = 'Anytown', 
                              State = 'CA', 
                              PostalCode = '30097', 
                              Country = 'US',
                              BMCurrencyPreference__c = 'USD', 
                              BMLanguage__c = 'English', 
                              BMNumberFormat__c = '####.##', 
                              BMTimeZone__c = '(GMT-5:00 GMT-4:00) US Eastern Time', 
                              BMUnit__c= 'English', 
                              BMUserGroup__c = 'standard_group', 
                              BMDateFormat__c = '   MM/dd/yyyy h:mm a',
                              Alias = 'standt',
                              EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US',
                                    LocalesIdKey = 'en_US',
                                    TimeZonesIdKey = 'America/Los_Angeles',
                                    profileId = p.Id);
        return user;

    }
    

    static testMethod void createEachUserElementTest() {
        System.debug('piyush');
        try{
            BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
            delete userSecurities;
            
            BMUserSecurity__c bmSec = getBmSec();   
            insert bmSec;

            BMUserSecurity__c userSecurity = getAPIUserInfo();

            Boolean updateUser = false;
            Boolean removeUser = false;
            
            User user = getUserInfo();
            insert user;
            String userName = user.UserName;
            String loginName = userName.split('@', 0)[0];
            UserSoapFunctions userSoapFunctions = new UserSoapFunctions();
            String bmUserAccessType = '';
            BMXMLDom.Element eachRecord = userSoapFunctions.createEachUserElement(
                    userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c, 
                    loginName, false, user);

            System.assertEquals(BMGlobal.BM_EACH_RECORD,eachRecord.nodeName);
    
            System.assertEquals(BMGlobal.BM_COMPANY_VALUE.replace(BMGlobal.BM_SUB_DOMAIN, userSecurity.APISubDomain__c==null?'':userSecurity.APISubDomain__c), eachRecord.getElementByTagName(BMGlobal.BM_COMPANY_NAME).nodeValue);
            System.assertEquals(loginName, eachRecord.getElementByTagName(BMGlobal.BM_LOGIN).nodeValue);
            System.assertEquals(user.FirstName==null?'':user.FirstName, eachRecord.getElementByTagName(BMGlobal.BM_FIRST_NAME).nodeValue);
            System.assertEquals(user.LastName==null?'':user.LastName, eachRecord.getElementByTagName(BMGlobal.BM_LAST_NAME).nodeValue);
            System.assertEquals(user.Title==null?'':user.Title, eachRecord.getElementByTagName(BMGlobal.BM_JOB_TITLE).nodeValue);
            System.assertEquals(user.Email==null?'':user.Email, eachRecord.getElementByTagName(BMGlobal.BM_EMAIL).nodeValue);
            System.assertEquals(user.Phone==null?'':user.Phone, eachRecord.getElementByTagName(BMGlobal.BM_PHONE).nodeValue);
            System.assertEquals(user.Fax==null?'':user.Fax, eachRecord.getElementByTagName(BMGlobal.BM_FAX).nodeValue);
            System.assertEquals(user.Street==null?'':user.Street, eachRecord.getElementByTagName(BMGlobal.BM_BILL_ADDRESS).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_BILL_ADDRESS_2).nodeValue);
            System.assertEquals(user.City==null?'':user.City, eachRecord.getElementByTagName(BMGlobal.BM_BILL_CITY).nodeValue);
            System.assertEquals(user.State==null?'':user.State, eachRecord.getElementByTagName(BMGlobal.BM_BILL_STATE).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_BILL_STATE_PROVINCE).nodeValue);
            System.assertEquals(user.PostalCode==null?'':user.PostalCode, eachRecord.getElementByTagName(BMGlobal.BM_BILL_ZIP).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_BILL_COUNTRY).nodeValue);
            System.assertEquals('false', eachRecord.getElementByTagName(BMGlobal.BM_SEPARATE_SHIP_ADDR).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_ADDRESS_1).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_ADDRESS_2).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_CITY).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_STATE).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_STATE_PROVINCE).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_ZIP).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_COUNTRY).nodeValue);
            System.assertEquals('false', eachRecord.getElementByTagName(BMGlobal.BM_NOTIFICATION_PREF).getElementByTagName(BMGlobal.BM_IS_NOTIFY_PREF).nodeValue);
            System.assertEquals(user.BMLanguage__c==null?'':user.BMLanguage__c, eachRecord.getElementByTagName(BMGlobal.BM_LANGUAGE).nodeValue);
            System.assertEquals(user.BMCurrencyPreference__c==null?'':user.BMCurrencyPreference__c, eachRecord.getElementByTagName(BMGlobal.BM_CURRENCY_PREFERENCE).nodeValue);
            System.assertEquals(user.FirstName==null?'':user.FirstName, eachRecord.getElementByTagName(BMGlobal.BM_BILL_FIRST_NAME).nodeValue);
            System.assertEquals(user.LastName==null?'':user.LastName, eachRecord.getElementByTagName(BMGlobal.BM_BILL_LAST_NAME).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_BILL_COMPANY).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_BILL_COMPANY_2).nodeValue);
            System.assertEquals(user.Phone==null?'':user.Phone, eachRecord.getElementByTagName(BMGlobal.BM_BILL_PHONE).nodeValue);
            System.assertEquals(user.Fax==null?'':user.Fax, eachRecord.getElementByTagName(BMGlobal.BM_BILL_FAX).nodeValue);
            System.assertEquals(user.Email==null?'':user.Email, eachRecord.getElementByTagName(BMGlobal.BM_BILL_EMAIL).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_FIRST_NAME).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_LAST_NAME).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_COMPANY).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_COMPANY_2).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_PHONE).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_FAX).nodeValue);
            System.assertEquals('', eachRecord.getElementByTagName(BMGlobal.BM_SHIP_EMAIL).nodeValue);
            System.assertEquals(user.BMUnit__c==null?'':user.BMUnit__c, eachRecord.getElementByTagName(BMGlobal.BM_UNITS).nodeValue);
            System.assertEquals(user.BMDateFormat__c==null?'':user.BMDateFormat__c, eachRecord.getElementByTagName(BMGlobal.BM_DATE_FORMAT).nodeValue);
            System.assertEquals(user.BMTimeZone__c==null?'':user.BMTimeZone__c, eachRecord.getElementByTagName(BMGlobal.BM_TIME_ZONE).nodeValue);
            System.assertEquals(user.BMNumberFormat__c==null?'':user.BMNumberFormat__c, eachRecord.getElementByTagName(BMGlobal.BM_NUMBER_FORMAT).nodeValue);

            System.assertEquals(user.Username==null?'':user.Username, eachRecord.getElementByTagName(BMGlobal.BM_PARTNER_LOGIN).nodeValue);
            System.assertEquals(BMGlobal.BM_PARTNER_PASSWORD_VALUE, eachRecord.getElementByTagName(BMGlobal.BM_PARTNER_PASSWORD).nodeValue);
            System.assertEquals('false', eachRecord.getElementByTagName(BMGlobal.BM_SEND_PASSWORD_EMAIL).nodeValue);

            System.assertEquals('Active', eachRecord.getElementByTagName(BMGlobal.BM_STATUS).nodeValue);
    
            if (user.BMUserGroup__c != null && user.BMUserGroup__c.length() > 0)
            {
                String[] groupsForUser = user.BMUserGroup__c.split(';', 0);
                for (String g : groupsForUser)
                {
                    if (g.trim() == eachRecord.getElementByTagName(BMGlobal.BM_GROUP_LIST).getElementByTagName(BMGlobal.BM_GROUP).getElementByTagName(BMGlobal.BM_VARIABLE_NAME).nodeValue)
                        System.assertEquals(g.trim(), eachRecord.getElementByTagName(BMGlobal.BM_GROUP_LIST).getElementByTagName(BMGlobal.BM_GROUP).getElementByTagName(BMGlobal.BM_VARIABLE_NAME).nodeValue);
                }
            }
        }
        catch(Exception e){
            System.debug('Exception in createEachUserElementTest: ' + e.getMessage());
        }           
    }   
}