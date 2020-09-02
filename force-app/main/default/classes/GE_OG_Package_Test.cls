@isTest(seealldata=false)
public class GE_OG_Package_Test {
    
    static testMethod void GE_OG_Package_Test() {
        
        test.startTest();
        
        
        // Create the package records
       /* PackageLicense__c packageLicense = new PackageLicense__c();
        packageLicense.Name='ServiceMax';
        packageLicense.Package_Id__c='050A00000009BzEIAU';
        packageLicense.User_Field_Id__c='GE_Is_ServiceMax_User__c';
        
        // Create the package custom setting record
        PackageLicense__c packageLicense2 = new PackageLicense__c();
        packageLicense2.Name='MapAnything';
        packageLicense2.Package_Id__c='050K00000004K4KIAU';
        packageLicense2.User_Field_Id__c='GE_OG_MapAnything_User__c';
		*/
        Package__c SMax = new Package__c();
        SMax.Name='ServiceMax';
        SMax.Package_Id__c='050A00000009BzEIAU';
        SMax.UserFieldApiName__c='GE_Is_ServiceMax_User__c';
        
        Insert Smax;
        
        // Create the package custom setting record
        Package__c mapAnything = new Package__c();
        mapAnything.Name='MapAnything';
        mapAnything.Package_Id__c='050K00000004K4KIAU';
        mapAnything.UserFieldApiName__c='GE_OG_MapAnything_User__c';
        
        insert(mapAnything);
        
        // Get profiles which will be used by users created below
        map<String,Profile> profiles = new map<String,Profile>();
        for(Profile p : ([select Name, Id from Profile]))
            profiles.put(p.Name, p);
        
        System.debug('map size: ' + profiles.size());
                
        // Create the profile mapping list for profile to license type mapping
        List<Package_Profile_Map__c> profMapList = new List<Package_Profile_Map__c>{};
            
        Package_Profile_Map__c profMap = new Package_Profile_Map__c();
        profMap.Salesforce_Profile_Name__c = 'GE_AL_SM Read Only';
        profMap.Package__c = Smax.Id;
        profMap.Commercial_SFDC_license_used__c=FALSE;
        profMap.License_Type__c = 'Read Only';
        
        profMapList.add(profMap);
        
        profMap = new Package_Profile_Map__c();
        profMap.Salesforce_Profile_Name__c = 'GE_PC_Titanium Service Manager';
        profMap.Package__c = Smax.Id;
        profMap.Commercial_SFDC_license_used__c=FALSE;
        profMap.License_Type__c = 'Restricted';
        
        profMapList.add(profMap);
        
        profMap = new Package_Profile_Map__c();
        profMap.Salesforce_Profile_Name__c = 'GE_OG_SFDC_SMax_Gold';
        profMap.Package__c = Smax.Id;
        profMap.Commercial_SFDC_license_used__c=TRUE;
        profMap.License_Type__c = 'Bundle I';
        
        profMapList.add(profMap);
        
        profMap = new Package_Profile_Map__c();
        profMap.Salesforce_Profile_Name__c = 'GE_OG_SFDC_SMax_Titanium';
        profMap.Package__c = Smax.Id;
        profMap.Commercial_SFDC_license_used__c=FALSE;
        profMap.License_Type__c = 'Bundle II';
        
        profMapList.add(profMap);
        
        profMap = new Package_Profile_Map__c();
        profMap.Salesforce_Profile_Name__c = 'GE_DS_FS Technician';
        profMap.Package__c = Smax.Id;
        profMap.Commercial_SFDC_license_used__c=FALSE;
        profMap.License_Type__c = 'Bundle II';
        
        profMapList.add(profMap);
        
        insert(profMapList);
        
        
        
        //-----------------------------------------------------------------------------
        
        // Create the mapping of permission set to license type
        List<Package_PermSet_Map__c> permSetMapList = new List<Package_PermSet_Map__c>{};
        
        Package_PermSet_Map__c permSetMap = new Package_PermSet_Map__c();
        permSetMap.Package__c=SMax.Id;
        permSetMap.Salesforce_PermSet__c = 'Servicemax Data Read Only';
        permSetMap.License_Type__c='Read Only';
        
        permSetMapList.add(permSetMap);
        
        permSetMap = new Package_PermSet_Map__c();
        permSetMap.Package__c=SMax.Id;
        permSetMap.Salesforce_PermSet__c = 'Servicemax Restricted';
        permSetMap.License_Type__c='Restricted';
        
        permSetMapList.add(permSetMap);
        
        permSetMap = new Package_PermSet_Map__c();
        permSetMap.Package__c=SMax.Id;
        permSetMap.Salesforce_PermSet__c = 'ServiceMax DS AL Admin';
        permSetMap.License_Type__c='Bundle II';
        
        permSetMapList.add(permSetMap);
        
        permSetMap = new Package_PermSet_Map__c();
        permSetMap.Package__c=SMax.Id;
        permSetMap.Salesforce_PermSet__c = 'Opportuntiy Read Create Edit Access';
        permSetMap.License_Type__c='Sales';
        
        permSetMapList.add(permSetMap);
        
        insert (permSetMapList);
        
        //-----------------------------------------------------------------------------        
        
        // Create users in the system
        List<User> usrlist = new List <User>{};           
            User usr = new User();
        usr.FirstName = 'Test';
        usr.LastName = 'User 1';
        usr.email='yehho@ge.com';
        usr.Alias='100j';
        usr.TimeZoneSidKey='America/New_York';
        usr.LocaleSidKey='en_US';
        usr.EmailEncodingKey='ISO-8859-1';
        usr.LanguageLocaleKey ='en_US';
        usr.Username='yomama_koshay@ge-forever.com';
        usr.ProfileId = profiles.get('GE_AL_SM Read Only').Id;
        usr.GE_HQ_SSO_ID__c='77&644*2811A';
        
        usrList.add(usr);
        
        usr = new User();
        usr.FirstName = 'Test';
        usr.LastName = 'User 2';
        usr.email='yehho@ge.com';
        usr.Alias='13j1j';
        usr.TimeZoneSidKey='America/New_York';
        usr.LocaleSidKey='en_US';
        usr.EmailEncodingKey='ISO-8859-1';
        usr.LanguageLocaleKey ='en_US';
        usr.Username='yomama_koshay@ge-forever2.com';
        usr.ProfileId = profiles.get('GE_OG_SFDC_SMax_Gold').Id;
        usr.GE_HQ_SSO_ID__c='77&655*2822B';
        
        usrList.add(usr);
        
        usr = new User();
        usr.FirstName = 'Test';
        usr.LastName = 'User 3';
        usr.email='yehho@ge.com';
        usr.Alias='1jj1j';
        usr.TimeZoneSidKey='America/New_York';
        usr.LocaleSidKey='en_US';
        usr.EmailEncodingKey='ISO-8859-1';
        usr.LanguageLocaleKey ='en_US';
        usr.Username='yomama_koshay@ge-forever3.com';
        usr.ProfileId = profiles.get('GE_OG_SFDC_SMax_Titanium').Id;
        usr.GE_HQ_SSO_ID__c='77&666*2844C';
        
        usrList.add(usr);
        
        usr = new User();
        usr.FirstName = 'Test';
        usr.LastName = 'User 4';
        usr.email='yehho@ge.com';
        usr.Alias='1jj33';
        usr.TimeZoneSidKey='America/New_York';
        usr.LocaleSidKey='en_US';
        usr.EmailEncodingKey='ISO-8859-1';
        usr.LanguageLocaleKey ='en_US';
        usr.Username='yomama_koshay@ge-forever4.com';
        usr.ProfileId = profiles.get('Chatter Free User').Id;
        usr.GE_HQ_SSO_ID__c='77&677*2855D';
        usr.GE_Is_ServiceMax_User__c = true;
        
        usrList.add(usr);
        
        usr = new User();
        usr.FirstName = 'Test';
        usr.LastName = 'User 5';
        usr.email='yehho@ge.com';
        usr.Alias='1j22j';
        usr.TimeZoneSidKey='America/New_York';
        usr.LocaleSidKey='en_US';
        usr.EmailEncodingKey='ISO-8859-1';
        usr.LanguageLocaleKey ='en_US';
        usr.Username='yomama_koshay@ge-forever5.com';
        usr.ProfileId = profiles.get('GE_DS_FS Technician').Id;
        usr.GE_HQ_SSO_ID__c='77&688*2866E';
        
        usrList.add(usr);
        
        usr = new User();
        usr.FirstName = 'Test';
        usr.LastName = 'User 6';
        usr.email='yehho@ge.com';
        usr.Alias='1j2pj';
        usr.TimeZoneSidKey='America/New_York';
        usr.LocaleSidKey='en_US';
        usr.EmailEncodingKey='ISO-8859-1';
        usr.LanguageLocaleKey ='en_US';
        usr.Username='yomama_koshay@ge-forever6.com';
        usr.ProfileId = profiles.get('GE_PC_Titanium Service Manager').Id;
        usr.GE_HQ_SSO_ID__c='77&600*2877F';
        
        insert(usrList);
        
        
        //-----------------------------------------------------------------------------
        
        List<Package_License__c> customPackageLicenseList = new List<Package_License__c>();
        
        // give some users an existing package license record
        Package_License__c tempPackLicRec = new Package_License__c();
        tempPackLicRec.Active_License__c=true;
        tempPackLicRec.Package__c=Smax.Id;
        tempPackLicRec.Package_License_Type__c='Standard';
        tempPackLicRec.SFDC_License_Type__c='Standard';
        tempPackLicRec.User__c=usrList.get(1).Id;
        
        customPackageLicenseList.add(tempPackLicRec);
        
		tempPackLicRec = new Package_License__c();        
        tempPackLicRec.Active_License__c=true;
        tempPackLicRec.Package__c=Smax.Id;
        tempPackLicRec.Package_License_Type__c='Standard';
        tempPackLicRec.SFDC_License_Type__c='Standard';
        tempPackLicRec.User__c=usrList.get(2).Id;
        
        customPackageLicenseList.add(tempPackLicRec);
        
        tempPackLicRec = new Package_License__c();        
        tempPackLicRec.Active_License__c=true;
        tempPackLicRec.Package__c=Smax.Id;
        tempPackLicRec.Package_License_Type__c='Standard';
        tempPackLicRec.SFDC_License_Type__c='Standard';
        tempPackLicRec.User__c=usrList.get(3).Id;
        
        customPackageLicenseList.add(tempPackLicRec);
        
		tempPackLicRec = new Package_License__c();        
        tempPackLicRec.Active_License__c=true;
        tempPackLicRec.Package__c=mapAnything.Id;
        tempPackLicRec.Package_License_Type__c='Standard';
        tempPackLicRec.SFDC_License_Type__c='Standard';
        tempPackLicRec.User__c=usrList.get(4).Id;
        
        customPackageLicenseList.add(tempPackLicRec);
        
        insert customPackageLicenseList;
        
        // give users ServiceMax licenses
        //userPackageLicense mytest = new userPackageLicense(PackageLicenseId='050A00000009BzEIAU', UserId=usrList.get(0).Id);
        List<userPackageLicense> packageLicenseList = new List<userPackageLicense>();
        packageLicenseList.add(new userPackageLicense(PackageLicenseId='050A00000009BzEIAU', UserId=usrList.get(0).Id));
        packageLicenseList.add(new userPackageLicense(PackageLicenseId='050A00000009BzEIAU', UserId=usrList.get(2).Id));
        packageLicenseList.add(new userPackageLicense(PackageLicenseId='050A00000009BzEIAU', UserId=usrList.get(4).Id));

        System.runAs(new User(Id = Userinfo.getUserId())) 
        {
            Database.Saveresult[] updateRes;
            updateRes = database.insert(packageLicenseList);
        }
                        
        // Run the actual test
        //List<String> packageList = new List<String>{'ServiceMax'};
        //pu.flagPackageUsers(packageList);
        //pu.createPackageUsers('ServiceMax');                      
        GE_OG_PackageLicenseBatch batch = new GE_OG_PackageLicenseBatch();
        ID batchprocessid = database.executeBatch(batch, 10);
         
        /*map<String,User> userMap = new map<String,User>([select Username, SMax_License_Type__c from User where username in ('yomama_koshay@ge-forever.com, yomama_koshay@ge-forever2.com,yomama_koshay@ge-forever3.com, yomama_koshay@ge-forever4.com,yomama_koshay@ge-forever5.com,yomama_koshay@ge-forever6.com')]);
        
        // Asert the license types get set correctly
        if(userMap.containsKey('yomama_koshay@ge-forever.com'))
            System.assert(userMap.get('yomama_koshay@ge-forever.com').SMax_License_Type__c == 'Read Only');
        if(userMap.containsKey('yomama_koshay@ge-forever2.com'))
            System.assert(userMap.get('yomama_koshay@ge-forever2.com').SMax_License_Type__c == 'Bundle I');
        if(userMap.containsKey('yomama_koshay@ge-forever3.com'))
            System.assert(userMap.get('yomama_koshay@ge-forever3.com').SMax_License_Type__c == 'Bundle II');
        if(userMap.containsKey('yomama_koshay@ge-forever4.com'))
            System.assert(userMap.get('yomama_koshay@ge-forever4.com').SMax_License_Type__c == 'Unknown');
        if(userMap.containsKey('yomama_koshay@ge-forever5.com'))
            System.assert(userMap.get('yomama_koshay@ge-forever5.com').SMax_License_Type__c == 'Bundle II');
        if(userMap.containsKey('yomama_koshay@ge-forever6.com'))
            System.assert(userMap.get('yomama_koshay@ge-forever6.com').SMax_License_Type__c == 'Restricted');
        
        */
        
        Test.stopTest();
    }
}