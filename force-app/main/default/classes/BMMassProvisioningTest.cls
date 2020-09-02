@isTest
private class BMMassProvisioningTest 
{
static testMethod void testBMMassProvisioning()
    {
      BMMassProvisioning massProvisioning = new BMMassProvisioning();
     }
/*
    static testMethod void testBMMassProvisioning()
    {
        try
        {            
            //Use the PageReference Apex class to instantiate a page
            PageReference pageRef = Page.BMMassProvisioning;
            
            //In this case, the Visualforce page named 'success' is the starting point of this test method. 
            Test.setCurrentPage(pageRef);
          
            BMUserSecurity__c userSecurity = new BMUserSecurity__c();
            ApexPages.StandardController stdController = new ApexPages.StandardController(userSecurity);
            //Instantiate and construct the controller class.   
            BMMassProvisioning massProvisioning = new BMMassProvisioning(stdController);
            
            System.AssertNotEquals(userSecurity, null);
            
            //System.assertEquals(userSecurity.isActive__c,false);
            //System.assertEquals(userSecurity.APIUserName__c,'BM User API');

            Profile[] profiles = [Select p.name, p.id From Profile p WHERE Name = 'Standard User'];
            Profile profile;
            if (profiles.size() > 0)
                profile = profiles[0];
            System.Debug('User.ProfileId - ' + profile.Id);
            String profileId = profile.Id;
            
            //Now insert data causing an contact trigger to fire. 
            User u = new User(alias = 'tst_ZZZ', email='bmtestuser@ge.com', 
                emailencodingkey='UTF-8', lastname='testuser_ZZZ', languagelocalekey='en_US', 
                localesidkey='en_US', profileid = profileId, isActive=true, 
                BMUserType__c = BMGlobal.BM_INTERNAL_USER, BMUserAccessType__c = 'FullAccess',                      
                timezonesidkey='America/New_York', username='testuser_KKK@comitydesigns.com');
            u.BMMassProvisioning__c = true;
            u.isBMEnabled__c = false;
            u.Department = 'Test User';
                    
            Test.startTest();
            insert u;
            
            massProvisioning.provisionUsers(false);
            integer getUsersToProvisionCount = massProvisioning.getUsersToProvision();
            Boolean buttonDisabled = massProvisioning.getDisableMassProvisioningButton();
            System.AssertEquals(buttonDisabled,true);
               
            massProvisioning.provisionUsers();
            User[] allUsers = [SELECT u.Username, u.BMMassProvisioning__c FROM User u WHERE u.BMMassProvisioning__c = true and isActive = true];
            for (User userToHide :allUsers)
            {
                userToHide.BMMassProvisioning__c = false;
            }
            update allUsers;
            massProvisioning.addError('dummy message');
            //Now insert data causing an contact trigger to fire. 
            Test.stopTest();
        }
        catch (Exception ex)
        {
            System.debug('Error : ' + ex.getMessage());
        }
    }  
    
    static testMethod void testGetDisableMassProvisioningButton()
    {
        try
        {
            //Use the PageReference Apex class to instantiate a page
            PageReference pageRef = Page.BMMassProvisioning;
            
            //In this case, the Visualforce page named 'success' is the starting point of this test method. 
            Test.setCurrentPage(pageRef);
          
            BMUserSecurity__c userSecurity = new BMUserSecurity__c();
            ApexPages.StandardController stdController = new ApexPages.StandardController(userSecurity);
            //Instantiate and construct the controller class.   
            BMMassProvisioning massProvisioning = new BMMassProvisioning(stdController);
            massProvisioning.getDisableMassProvisioningButton();
        }
        catch(Exception ex)
        {
            System.debug('Exception for insert/update 20 user ' + ex.getMessage());
        }
    }
        
    static testMethod void testInsertUpdateHundredUsers()
    {
        try
        {
            //Use the PageReference Apex class to instantiate a page
            PageReference pageRef = Page.BMMassProvisioning;
            
            //In this case, the Visualforce page named 'success' is the starting point of this test method. 
            Test.setCurrentPage(pageRef);
          
            BMUserSecurity__c userSecurity = new BMUserSecurity__c();
            ApexPages.StandardController stdController = new ApexPages.StandardController(userSecurity);
            //Instantiate and construct the controller class.   
            BMMassProvisioning massProvisioning = new BMMassProvisioning(stdController);
            Profile[] profiles = [Select p.name, p.id From Profile p WHERE Name = 'Standard User'];
            Profile profile;
            if (profiles.size() > 0)
                profile = profiles[0];
            System.Debug('User.ProfileId - ' + profile.Id);
            String profileId = profile.Id;
            List<User> users = new List<User>();
            System.debug('Before 20 Insert');
            for (integer i=0; i <= 20; i++)
            {
                //Database.DMLOptions dmo = new Database.DMLOptions();
                //dmo.EmailHeader.triggerUserEmail = true;
                User u = new User(alias = 'tst_' + i, email='bmtestuser_' + i + '@ge.com', 
                    emailencodingkey='UTF-8', lastname='testuser_' + i, languagelocalekey='en_US', 
                    localesidkey='en_US', profileid = profileId, isActive=true, 
                    BMUserType__c = BMGlobal.BM_INTERNAL_USER, BMUserAccessType__c = 'FullAccess',                      
                    timezonesidkey='America/New_York', username='testuser_' + i + '@comitydesigns.com');
                u.BMMassProvisioning__c = true;
                
                u.Department = BMGlobal.TEST_USER_100;
                //u.setOptions(dmo);
                users.add(u);
            }
                System.debug('After 20 Insert');
            //Now insert data causing an contact trigger to fire. 
            insert users;
            massProvisioning.provisionUsers(false);
            System.AssertEquals(users.size(),[Select Name FROM User WHERE Department = :BMGlobal.TEST_USER_100].size());
        }
        catch(Exception ex)
        {
            System.debug('Exception for insert/update 20 user ' + ex.getMessage());
        }
    }   
    
    static testMethod void     testSetCurrentlySelectedUserId(){
                    //clean the data
            BMUserSecurity__c[] deleteConfigs = [select id from BMUserSecurity__c];
            delete deleteConfigs;
             
            BMUserSecurity__c userSecurity = new BMUserSecurity__c();
            ApexPages.StandardController stdController = new ApexPages.StandardController(userSecurity);
            //Instantiate and construct the controller class.   
            BMMassProvisioning massProvisioning = new BMMassProvisioning(stdController);
            String testId = '12345678';
            massProvisioning.setCurrentlySelectedUserId(testId);        
            System.assertEquals(testId, massProvisioning.getCurrentlySelectedUserId());
    }
    
    static testMethod void testGetUsersInvalidForProvision() {
            BMUserSecurity__c[] deleteConfigs = [select id from BMUserSecurity__c];
            delete deleteConfigs;
             
            BMUserSecurity__c userSecurity = new BMUserSecurity__c();
            ApexPages.StandardController stdController = new ApexPages.StandardController(userSecurity);
            //Instantiate and construct the controller class.   
            BMMassProvisioning massProvisioning = new BMMassProvisioning(stdController);
            List<User> inValidUsers = massProvisioning.getUsersInvalidForProvision();
            System.assertEquals(true, inValidUsers.size() >= 0);
    }
    
    static testMethod void testProvisionUsers() {
            BMUserSecurity__c[] deleteConfigs = [select id from BMUserSecurity__c];
            delete deleteConfigs;
             
            BMUserSecurity__c userSecurity = new BMUserSecurity__c();
            ApexPages.StandardController stdController = new ApexPages.StandardController(userSecurity);
            //Instantiate and construct the controller class.   
            BMMassProvisioning massProvisioning = new BMMassProvisioning(stdController);
            massProvisioning.provisionUsers();
            System.assert(true);
    }

    static testMethod void testNewTab()
    {
        try{        
        
            //clean the data
            BMUserSecurity__c[] deleteConfigs = [select id from BMUserSecurity__c];
            delete deleteConfigs;
             
            BMUserSecurity__c userSecurity = new BMUserSecurity__c();
            ApexPages.StandardController stdController = new ApexPages.StandardController(userSecurity);
            //Instantiate and construct the controller class.   
            BMMassProvisioning massProvisioning = new BMMassProvisioning(stdController);
            
            //create test data
            List<BMUserSecurity__c> configList = new List<BMUserSecurity__c>();
            Integer size = 5;
            for(integer i=0;i<size;i++){
                BMUserSecurity__c tmp = new BMUserSecurity__c();
                tmp.isActive__c = false;
                tmp.BMSSLRequired__c = false;
                tmp.AdminEmail__c = 'email@email.com';
                tmp.APIUserPassword__c = 'password' + i;
                tmp.APIUserName__c = 'username' + i;
                tmp.APISubDomain__c = 'domainname' + i;
                
                configList.add(tmp);
            }
            
            configList[0].isActive__c = true;
            insert configList;
            
            //Select b.isActive__c, b.Name, b.Id, b.AdminEmail__c, b.APIUserPassword__c, b.APIUserName__c, b.APISubDomain__c From BMUserSecurity__c b
            
            System.assertNotEquals(massProvisioning.getLSecurities(), null);
            //set currently selected id
            massProvisioning.setCurrentlySelectedConfigId(configList[0].Id);
            System.assertEquals(massProvisioning.getCurrentlySelectedConfigId(), configList[0].Id);
            
            massProvisioning.selectConfig();
            massProvisioning.security = null;
            System.assertEquals(massProvisioning.getSecurity().Id, configList[0].Id);
            
            //change some information and save the configuration
            massProvisioning.getSecurity().AdminEmail__c = 'newemail@email.com';
            massProvisioning.saveConfig();
            System.assertEquals(massProvisioning.getSecurity().AdminEmail__c, 'newemail@email.com');
            //delete the selected config record
            massProvisioning.deleteConfig();
            System.assertEquals(massProvisioning.getSecurity().Name,null);
            
            //check an exception
            massProvisioning.newConfig();       
            try{
                massProvisioning.getSecurity().isActive__c = false;
                massProvisioning.getSecurity().BMSSLRequired__c = false;
                massProvisioning.getSecurity().AdminEmail__c = 'email@email.com';
                massProvisioning.getSecurity().APIUserPassword__c = 'password';
                massProvisioning.getSecurity().APIUserName__c = 'username';
                massProvisioning.getSecurity().APISubDomain__c = 'domainname';
            
                System.debug('before saveConfig');
                massProvisioning.saveConfig();    
                System.debug('After saveConfig ');  
            }
            catch(Exception e){
                System.debug('Beginning of exception');
                System.assert(e!=null);
                System.debug('Handled exception in testmtethod: ' + e.getMessage());
            }
        }
        catch(Exception e){
            System.debug('Exeption in testNewTab ' + e.getMessage());
        }
    }
    */
}