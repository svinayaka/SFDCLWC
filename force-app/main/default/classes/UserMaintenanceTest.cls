@isTest(SeeAllData=false)
public class UserMaintenanceTest {
    
    
    
    public static BMUserSecurity__c userSecurity;
    public static String adminEmail;
    public static Boolean isrunningtestagain = false;
    
    @Testsetup
    public static void getUserInfo()
    {
        
        Profile p = [Select Id from Profile where Name = 'System Administrator' Limit 1];
        User u = new User (CompanyName = 'Test Company', 
                           Username = 'testusername_12c4a@bm.com', 
                           FirstName = 'Firstname', 
                           LastName = 'lastname', 
                           Title = 'Title', 
                           Alias = 'alias',
                           TimeZoneSidKey='America/Los_Angeles',
                           LocaleSidKey='en_US',
                           EmailEncodingKey='UTF-8',
                           ProfileId = p.Id,
                           LanguageLocaleKey='en_US',
                           Email = 'testusername_12c4a@ge.com', 
                           Phone = '1234567890', Fax = '1234567890', Street = '123 main street', City = 'Atlanta', State = 'GA', 
                           PostalCode = '30005', Country ='USA',
                           BMCurrencyPreference__c ='USD', BMLanguage__c = 'English', BMNumberFormat__c = '####.##', BMDateFormat__c = 'MM/dd/yyyy h:mm a',
                           BMTimeZone__c = '(GMT-5:00 GMT-4:00) US Eastern Time', BMUnit__c = 'System Default', 
                           BMUserGroup__c = '', isBMEnabled__c = false, 
                           BMUserAccessType__c = 'FullAccess', BMUserType__c = BMGlobal.BM_PARTNER_USER
                          );
        insert u;                 
        BMUserSecurity__c   userSecurities = new BMUserSecurity__c ( APIUserName__c = 'SFDCIntegrationUser', APIUserPassword__c = 'Marietta_2400', APISubDomain__c = 'dev2ge', BMSSLRequired__c  = true, AdminEmail__c ='kiranyerneni@ge.com' , isActive__c = true );
        insert     userSecurities;
    }
    
    private static testMethod void testRemoveIsBMEnabled()
    {
        
        UserMaintenance.ConfigException  t = new UserMaintenance.ConfigException ();
        User user = [Select u.Id, u.CompanyName, u.Username, u.FirstName, u.LastName, u.Title, u.Email, 
                     u.Phone, u.Fax, u.Street, u.City, u.State, u.PostalCode, u.Country,
                     u.BMCurrencyPreference__c, u.BMLanguage__c, u.BMNumberFormat__c, u.BMDateFormat__c,
                     u.BMTimeZone__c, u.BMUnit__c, BMUserGroup__c, isBMEnabled__c,
                     u.BMUserAccessType__c, u.BMPartnerCompanyNameFormula__c  , u.BMUserType__c                               
                     from User u where u.isActive=true LIMIT 1];
        
        UserMaintenance.removeIsBMEnabled(user.Username);
        UserMaintenance.buildEmailBody( user.username, 'test', 'FullAccess', 'bsl', true, true, 'testing') ;
        List<User> lstUser = new List<User>();
        lstUser.add(user);
        try{
            UserMaintenance.massProvisionUsers(lstUser);
        }
        catch(Exception ex)
        {
            try{
                isrunningtestagain = true;
                UserMaintenance.massProvisionUsers(lstUser);
            }
            catch (Exception e)
            {
                System.debug('Beginning of exception');
                System.assert(e!=null);
                System.debug('Handled exception in testmtethod: ' + e.getMessage());
            }
        }
    }
    
    private static testMethod void updateIsBMEnabledTest()
    {
        try
        {
            List<User> users = [Select 
                                u.Id, u.CompanyName, u.Username, u.FirstName, u.LastName, u.Title, u.Email, 
                                u.Phone, u.Fax, u.Street, u.City, u.State, u.PostalCode, u.Country,
                                u.BMCurrencyPreference__c, u.BMLanguage__c, u.BMNumberFormat__c, u.BMDateFormat__c,
                                u.BMTimeZone__c, u.BMUnit__c, BMUserGroup__c, isBMEnabled__c,
                                u.BMUserAccessType__c, u.BMPartnerCompanyNameFormula__c      ,u.BMUserType__c                           
                                from User u where u.isActive=true LIMIT 1];
            users[0].isBMEnabled__c = false;
            users[0].BMMassProvisioning__c = false;
            
            UserMaintenance.updateIsBMEnabled(users);
            System.assert(users[0].isBMEnabled__c==false);
            System.assert(users[0].BMMassProvisioning__c==false);
        }
        catch(Exception e)
        {
            System.debug('Beginning of exception');
            System.assert(e!=null);
            System.debug('Handled exception in testmtethod: ' + e.getMessage());
        }
        
    }
    
    private static testMethod void invokeSoapRequestTest()
    {
        
        User user = [Select u.Id, u.CompanyName, u.Username, u.FirstName, u.LastName, u.Title, u.Email, 
                     u.Phone, u.Fax, u.Street, u.City, u.State, u.PostalCode, u.Country,
                     u.BMCurrencyPreference__c, u.BMLanguage__c, u.BMNumberFormat__c, u.BMDateFormat__c,
                     u.BMTimeZone__c, u.BMUnit__c, BMUserGroup__c, isBMEnabled__c,
                     u.BMUserAccessType__c, u.BMPartnerCompanyNameFormula__c     ,u.BMUserType__c                            
                     from User u where u.isActive=true LIMIT 1];
        try
        {
            //BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
            //if(userSecurities!=null && userSecurities.size()!=0)
            //  delete userSecurities;
            
            // BMUserSecurity__c bmSec = getBmSec();   
            // insert bmSec;
            UserMaintenance.callOut = false;
            UserMaintenance.insertUpdateUser(user.Username, user.BMUserType__c, user.BMUserAccessType__c, user.BMPartnerCompanyNameFormula__c, user.isBMEnabled__c);
            UserMaintenance.insertUpdateUser(user.Username, user.BMUserType__c, user.BMUserAccessType__c, user.BMPartnerCompanyNameFormula__c, false);
            UserMaintenance.insertUpdateUser(null, null, null, null, null);
            
        }
        catch(UserMaintenance.ConfigException ex)
        {
            System.assertEquals('Big Machine session was not established and therefore user was not provisioned!!!', ex.getMessage());
        }
    }
    
    public static testMethod void insertUpdateUserProvisionTest()
    {
        
        User user = [Select u.Id, u.CompanyName, u.Username, u.FirstName, u.LastName, u.Title, u.Email, 
                     u.Phone, u.Fax, u.Street, u.City, u.State, u.PostalCode, u.Country,
                     u.BMCurrencyPreference__c, u.BMLanguage__c, u.BMNumberFormat__c, u.BMDateFormat__c,
                     u.BMTimeZone__c, u.BMUnit__c, BMUserGroup__c, isBMEnabled__c,
                     u.BMUserAccessType__c, u.BMPartnerCompanyNameFormula__c      ,u.BMUserType__c                           
                     from User u where u.isActive=true LIMIT 1];
        try
        {
            UserMaintenance.callOut = false;
            UserMaintenance.insertUpdateUserProvision(user.Username, user.BMUserType__c, user.BMUserAccessType__c, user.BMPartnerCompanyNameFormula__c, user.isBMEnabled__c, false);
            UserMaintenance.insertUpdateUserProvision(user.Username, user.BMUserType__c, user.BMUserAccessType__c, user.BMPartnerCompanyNameFormula__c, false, false);
            UserMaintenance.insertUpdateUserProvision(null, user.BMUserType__c, user.BMUserAccessType__c, user.BMPartnerCompanyNameFormula__c, null, false);
            
        }
        catch(UserMaintenance.ConfigException ex)
        {
            System.assertEquals('Big Machine session was not established and therefore user was not provisioned!!!', ex.getMessage());
        }
    }
    
    //Email Body
    
    
    
    // Get the sesion id 
    public static testMethod void getSessionIDTest()
    {
        try
        {
            BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
            delete userSecurities;
            
            BMUserSecurity__c bmSec = getBmSec();   
            insert bmSec;
            UserMaintenance.callOut = false;
            String sessionID = UserMaintenance.getSessionID(true, false);
            System.assert(sessionID==BMGlobal.SESSIONID_VALUE);
            
            sessionID = UserMaintenance.getSessionID(false, false);
            System.assert(sessionID==null);
            
        }
        catch(Exception e)
        {
            System.debug('Exception in getSessionIDTest: ' + e.getMessage());
        }
    }
    
    // Get the sesion id 
    public static testMethod void addRemoveUserTest()
    {
        User user = [Select u.Id, u.CompanyName, u.Username, u.FirstName, u.LastName, u.Title, u.Email, 
                     u.Phone, u.Fax, u.Street, u.City, u.State, u.PostalCode, u.Country,
                     u.BMCurrencyPreference__c, u.BMLanguage__c, u.BMNumberFormat__c, u.BMDateFormat__c,
                     u.BMTimeZone__c, u.BMUnit__c, BMUserGroup__c, isBMEnabled__c,
                     u.BMUserAccessType__c, u.BMPartnerCompanyNameFormula__c    ,u.BMUserType__c                             
                     from User u where u.isActive=true LIMIT 1];
        try
        {
            BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
            delete userSecurities;
            
            BMUserSecurity__c bmSec = getBmSec();   
            insert bmSec;
            UserMaintenance.callOut = false;
            UserMaintenance.addRemoveUser(BMGlobal.SESSIONID_VALUE, user.UserName, user.UserName, user.BMUserType__c, user.BMUserAccessType__c, user.BMPartnerCompanyNameFormula__c, user.IsBMEnabled__c, false);
            UserMaintenance.addRemoveUser(BMGlobal.SESSIONID_VALUE, user.UserName, user.UserName, user.BMUserType__c, user.BMUserAccessType__c, user.BMPartnerCompanyNameFormula__c, user.IsBMEnabled__c, false);
            
        }
        catch(Exception e)
        {
            System.debug('Exception in addRemoveUserTest: ' + e.getMessage());
        }
    }
    
    static BMUserSecurity__c getAPIUserInfo()
    {
        BMUserSecurity__c[] userSecurities = [SELECT APIUserName__c, APIUserPassword__c, APISubDomain__c, BMSSLRequired__c, AdminEmail__c FROM BMUserSecurity__c WHERE isActive__c = true LIMIT 1];
        if (userSecurities.size() > 0)
            userSecurity = userSecurities[0];
        return userSecurity;
    }
    
    // Get the sesion id 
    public static testMethod void getSessionIDRequestTest()
    {
        try
        {
            HttpRequest req = UserMaintenance.getSessionIDRequest(true);
            //System.Assert(req!=null);
            req = UserMaintenance.getSessionIDRequest(false);
        }
        catch(Exception e){
            System.debug('Exception in getSessionIDRequestTest: ' + e.getMessage());
        }
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
    
    // Send an error message
    public static testMethod void SendExceptionMessageTest()
    {
        //profile  chnlMagrId = [select id from profile where name ='OBSOLETEGE_OG_PII Sales Manager' limit 1];  -- commented tied to bug 0000024161
        profile  chnlMagrId = [select id from profile where name ='Standard User'];
        User chnlManr = new User(firstname = 'channel', lastname = 'manager', email = 'email@email.com', alias = 'chnUsr', profileId = chnlMagrId.id, Title = 'Channel Manager', Username = 'channelmagr11@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        try{
            BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
            delete userSecurities;
            
            BMUserSecurity__c bmSec = getBmSec();   
            insert bmSec;
            
            userSecurity = getAPIUserInfo();
            if (userSecurity != null)
            {
                String email;
                if (userSecurity.AdminEmail__c != null)
                    //System.Debug('userSecurity - ' + userSecurity);
                    email = userSecurity.AdminEmail__c; 
                else
                    email = 'vishkash@ge.com';
                String message = 'Test Message';
                UserMaintenance.SendExceptionMessage(email, message);
            }
        }
        catch(Exception e){
            System.debug('Exception in SendExceptionMessageTest: ' + e.getMessage());
        }
        
    }
    
    
    
    
    public static testMethod void extractMessageTest()
    {
        try{
            HttpResponse res = new HttpResponse();
            String sessionID = UserMaintenance.extractMessage(res, BMGlobal.BM_SESSIONID);
        }
        catch(Exception e){
            System.debug('Exception in extractMessageTest: ' + e.getMessage());
        }
    }
    
    private static testMethod void getElementByTagNameTest()
    {
        try{
            String xmlString = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">';
            xmlString = xmlString + '<soapenv:Header>';
            xmlString = xmlString + '<bm:userInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">';
            xmlString = xmlString + '<bm:sessionId>7f00000150447d8961f5a9447b8d23d0c9f7e9f8a1</bm:sessionId>;';
            xmlString = xmlString + '</bm:userInfo>';
            xmlString = xmlString + '<bm:category xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">Users</bm:category>';
            xmlString = xmlString + '<bm:xsdInfo xmlns:bm="urn:soap.bigmachines.com" soapenv:actor="http://schemas.xmlsoap.org/soap/actor/next" soapenv:mustUnderstand="0">';
            xmlString = xmlString + '<bm:schemaLocation>http://nsalesdemo.bigmachines.com/bmfsweb/nsalesdemo/schema/v1_0/users/Users.xsd</bm:schemaLocation>';
            xmlString = xmlString + '</bm:xsdInfo>';
            xmlString = xmlString + '</soapenv:Header>';
            
            UserMaintenance.getElementByTagName(xmlString, 'sessionId');
        }
        catch(Exception e){
            System.debug('Exception in getElementByTagNameTest: ' + e.getMessage());
        }
    }
    
    private static testMethod void testGetLoginName() {
        String inputUserName = 'ABC';
        String outputUserName = UserMaintenance.getLoginName(inputUserName);
        System.assert(true, inputUserName.equalsIgnoreCase(outputUserName));
    }
    
    public static testMethod void TestLogout()
    {
        try{
            HttpResponse res = new HttpResponse();
            String sessionID = UserMaintenance.extractMessage(res, BMGlobal.BM_SESSIONID);
            UserMaintenance.logout('test');
        }
        catch(Exception e){
            System.debug('Exception in extractMessageTest: ' + e.getMessage());
        }
    }
    
    public static testmethod void TestgetElementByTagName2()
    {
        BMXMLDom dom1 = new BMXMLDom();
        
        UserMaintenance.getElementByTagName2(dom1,'sessionId');   
    }
    
    public static testmethod void TestgetDetailRecordResponse()
    {
        BMXMLDom dom1 = new BMXMLDom();
        
        UserMaintenance.getDetailRecordResponse(dom1);  
    }
    
    
    public static testmethod  void testmassProvisionUsers() {
        User user = [Select u.Id, u.CompanyName, u.Username, u.FirstName, u.LastName, u.Title, u.Email, 
                     u.Phone, u.Fax, u.Street, u.City, u.State, u.PostalCode, u.Country,
                     u.BMCurrencyPreference__c, u.BMLanguage__c, u.BMNumberFormat__c, u.BMDateFormat__c,
                     u.BMTimeZone__c, u.BMUnit__c, BMUserGroup__c, isBMEnabled__c,
                     u.BMUserAccessType__c, u.BMPartnerCompanyNameFormula__c  , u.BMUserType__c                               
                     from User u where u.isActive=true LIMIT 1];
        
        //profile  chnlMagrId = [select id from profile where name ='OBSOLETEGE_OG_PII Sales Manager' limit 1];  -- commented related to bug 0000024161
        profile  chnlMagrId = [select id from profile where name ='Standard User' limit 1];
        User chnlManr = new User(firstname = 'channel', lastname = 'manager', email = 'email@email.com', alias = 'chnUsr', profileId = chnlMagrId.id, Title = 'Channel Manager', Username = 'channelmagr12@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        List<User> lstuser = new List<User>();
        lstuser.add(chnlManr );
        BigMachines__Configuration_Record__c bgmc=new BigMachines__Configuration_Record__c();
        bgmc.BigMachines__action_id_copy__c='4182068';
        bgmc.BigMachines__action_id_open__c ='4182057'; 
        bgmc.BigMachines__API_Login__c ='SFDCIntegrationUser';  
        bgmc.BigMachines__API_Password__c  ='Marietta_2400';
        bgmc.BigMachines__bm_site__c ='dev2ge';
        bgmc.BigMachines__Description__c ='BM Dev Site';
        bgmc.BigMachines__document_id__c = '4180720';
        bgmc.BigMachines__Is_Primary__c =true; 
        bgmc.BigMachines__process_id__c ='4180646'; 
        bgmc.BigMachines__process__c ='quotes_process_bmClone_16';
        //bgmc.BigMachines__Uses_SSL__c    
        bgmc.BigMachines__version_id__c ='4606851'; 
        // bgmc.CreatedById 
        // bgmc.CreatedDate 
        // bgmc.CurrencyIsoCode 
        //bgmc.GE_HQ_SFDC_LEGACY_ID__c  
        //bgmc.Name='SITE-729';   
        insert bgmc;
        Test.startTest();
        // Set mock callout class 
        // Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        try{
            UserMaintenance.massProvisionUsers(lstuser);
        }
        catch(Exception e)
        {
            System.debug('Beginning of exception');
            System.assert(e!=null);
            System.debug('Handled exception in testmtethod: ' + e.getMessage());
        }
        Test.stopTest();
    }
    
}