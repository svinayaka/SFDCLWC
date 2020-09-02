/* Class: GE_OG_PackageLicenseBatch
 * Purpose: This batch job will check for installed packages we are tracking licenses against and populate package license records for those who have a license
 * Author: Matt Koshay
 * Date: 9/2016
 * Tied to R-zzzzz 
 */

global class GE_OG_PackageLicenseBatch implements Database.Batchable<sObject>, Schedulable, Database.Stateful{
    
     // Class will hold simple data construct for internal use   
     public class simplePackageBean{
        public String m_LicenseType {get;set;}
        public boolean m_commLicense {get; set;}
        
        simplePackageBean (String p_LicenseType, boolean p_commLicense){
            m_LicenseType = p_LicenseType;
            m_commLicense = m_commLicense;
        }
         simplePackageBean(){}
    }
  
    
    public String query = 'Select Id, isactive, firstname, lastname, profile.name FROM User where usertype=\'Standard\'';
    
    
    
    global Set<Id> PermSetReadUser = new Set<Id>();
    global Set<Id> PermSetTitaniumUser = new Set<Id>();
    global Set<Id> PermSetSalesUser = new Set<Id>();
    global Set<Id> PermSetRestrictedUsers = new Set<Id>();
    
    //Pull the profile mappings for the package
    global Map<String,Map<String,String>>packageProfileMap = new Map<String,Map<String,String>>{};
    global Map<String,String> packageIdToNameMap = new Map<String,String>();
    global Map<String,String> packageNameToIDMap = new Map<String,String>();
    global Map<String,Boolean>profileMapSMaxLicense = new Map<String,Boolean>{};         
                
	global Map<String,Set<Id>> assignedLicenseMap;
    global List<Package_License__c> upsertList;
        
    // Constructor
    global GE_OG_PackageLicenseBatch(){           
        // populate the permission set information for ServiceMax license type association
        setPermSetVariables();
        
        upsertList = new list<Package_License__c>();  
        
        // Get the IDs of the packages we have flagged as active
        List<Package__c> packList = new List<Package__c>();
        packList = [select Id, Name, Package_Id__c from Package__c where Active__c = true];
        for(Package__c pack : packList){
            packageIdToNameMap.put(pack.Package_Id__c, pack.Name);
            packageNameToIDMap.put(pack.Name, pack.Id);
        }
        
        System.debug('Init: Number of packages: ' + packList.size());
        
        // Populate the Profile mappings and special info for Servicemax 
        Map<String,String> profileInfo;
        for (Package_Profile_Map__c pm : [select Package__r.Name, Package__r.Package_Id__c, Salesforce_Profile_Name__c, License_Type__c, Commercial_SFDC_license_used__c from Package_Profile_Map__c where Package__r.Active__c = true]){
            
            // create the mapping of package name to the mapping of profile to license type for that package
            if(!packageProfileMap.containsKey(pm.Package__r.Name)){      
                profileInfo = new Map<String,String>();
                profileInfo.put(pm.Salesforce_Profile_Name__c,pm.License_Type__c);
                packageProfileMap.put(pm.Package__r.Name,profileInfo);                
            }            
            else
                packageProfileMap.get(pm.Package__r.Name).put(pm.Salesforce_Profile_Name__c,pm.License_Type__c);                        
            
            // for ServiceMax track if the profile consums a standard salesforce license or not
            if(pm.Package__r.Name == 'ServiceMax')
                profileMapSMaxLicense.put(pm.Salesforce_Profile_Name__c,pm.Commercial_SFDC_license_used__c);
        }
        
        System.debug('Init: number of profile mappings: ' + packageProfileMap.size());
        
        // Populate the list of assigned licenses for the packages we are tracking
        List<UserPackageLicense> upl = new list<UserPackageLicense>();
        System.debug('Init: Keyset to get actual license allocation: ' + packageIdToNameMap.keySet());
        upl = [select PackageLicense.Id, UserId from UserPackageLicense where PackageLicense.Id = : packageIdToNameMap.keySet()];
        
        // put the assignments into our map collection
        assignedLicenseMap = new Map<String, Set<Id>>();
        Set<Id> tempIdSet;
        for(UserPackageLicense u : upl){
            // create an entry for the installed package if one does not exist
            if(!assignedLicenseMap.containsKey(packageIdToNameMap.get(u.PackageLicense.Id))){
                tempIdSet = new Set<Id>();
                tempIdSet.add(u.UserId);
                assignedLicenseMap.put(packageIdToNameMap.get(u.PackageLicense.Id), tempIdSet);
            }
            // we have a map entry so just add the userid to the set
            else{
                assignedLicenseMap.get(packageIdToNameMap.get(u.PackageLicense.Id)).add(u.UserId);
            }
        }
        
        System.debug('Init: Number of actuall assigned licenses: ' + assignedLicenseMap.size());

    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        //if a test is running we can only run one batch and need to look for the test account we setup in the related test class.
        if(test.isRunningTest()){
            List<String> usernameList = new List<String> {'yomama_koshay@ge-forever.com', 'yomama_koshay@ge-forever2.com','yomama_koshay@ge-forever3.com', 'yomama_koshay@ge-forever4.com','yomama_koshay@ge-forever5.com','yomama_koshay@ge-forever6.com'};
                query = 'Select Id, isactive, firstname, lastname, profile.name FROM User where usertype=\'Standard\' and username in : usernameList';
        }
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<User> scope) {
        System.debug('Koshay: GE_OG_PackageLicenseBatch Executing');
        upsertList = new list<Package_License__c>();
        
        List<Package_License__c> packLicList = new List<Package_License__c>();
        packLicList = [select Id, Package__c, Package__r.Name, Active_License__c, Package_License_Type__c, SFDC_License_Type__c, User__c from Package_License__c where User__c = : scope];
        
        System.debug('User: ' + scope.get(0).firstname + ' size: ' + scope.size()) ;
        // this map will hold the ID of the user and then a set of the packages they have a record for (just the name of the package)
        Map<Id, Set<String>> userLicenseMap = new Map<Id, Set<String>>();
		// this map will hold a string made up of the ID of the User + package name and hold the actual Package_License__c record for that user/package
        Map<String,Package_License__c> userPackLicRecMap = new Map<String,Package_License__c>();
        Set<String> tempSet;
        for(Package_License__c pl : packLicList){
            // if we don't have a map entry for a user, add one
            if(!userLicenseMap.containsKey(pl.User__c)){
                tempSet = new Set<String>();
                tempSet.add(pl.Package__r.Name);
                userLicenseMap.put(pl.User__c, tempSet);
            }
            // otherwise just add the package name to the map set
            else
                userLicenseMap.get(pl.User__c).add(pl.Package__r.Name);
            
            // add an entry for the actual package record
            userPackLicRecMap.put(pl.User__c+pl.Package__r.Name, pl);
        }
        System.debug('Size of userLicenseMap: ' + userLicenseMap.size());
        System.debug('Size of userPackLicRecMap: ' + userPackLicRecMap.size());
        System.debug('Exe: Number of actuall assigned licenses: ' + assignedLicenseMap.size());
        
        for(User u : scope){
            // used to hold temp package license record
            Package_License__c tempPackLicRec = new Package_License__c();
            // used to hold temp string value
            String tempString = '';
            
            // loop over the packages we are tracking
            for(String packageId : packageIdToNameMap.keySet()){
                // if we have assigned licenses for this package
                if(assignedLicenseMap.containsKey(packageIdToNameMap.get(packageId))){
                    // see if the user we are looping over has a license
                    if(assignedLicenseMap.get(packageIdToNameMap.get(packageId)).contains(u.Id)){
                        // check if the user has any package license records or not
                        if(userLicenseMap.containsKey(u.Id)){
                            // if user already has a package license record OR does not, run the process to update/insert record for this package
                            if(userLicenseMap.get(u.Id).contains(packageIdToNameMap.get(packageId))){
                                // validate the license type and that it is active
                                // set the string as the user id + package name
                                tempString = u.Id + packageIdToNameMap.get(packageId);
                                // try to get the package license record based on the user and package name map
                                try{
                                    tempPackLicRec = userPackLicRecMap.get(tempString);
                                }
                                Catch(Exception e){
                                    System.debug('Failed to fetch Package License from map: ' + e.getStackTraceString());
                                }
                                // call to method with true and existing record to update existing record
                                upsertPackageLicenseRecord(packageIdToNameMap.get(packageId), u, true, tempPackLicRec);
                            }
                            // user does not have a package license record for this particular package, so we need to create one
                            else{
                                // call to method with true and null to create the new record
                                upsertPackageLicenseRecord(packageIdToNameMap.get(packageId), u, true, null);
                            }                             
                        }
                        // User doesn't have any package license records so we need to create one
                        else{
                            // call to method with true and null to create the new record 
                            upsertPackageLicenseRecord(packageIdToNameMap.get(packageId), u, true, null);
                        }
                    } // end check if user has a license for the package we are looping over
                    // Check if user has a package license record for this package.  if they do it should be set to inactive since they don't have a license in the system
                    else if (userLicenseMap.containsKey(u.Id)){
                        // the user has a record for this particular package
                        if(userLicenseMap.get(u.Id).contains(packageIdToNameMap.get(packageId))){
                            // deactivate this record
                            // validate the license type and that it is active
                            tempString = u.Id + packageIdToNameMap.get(packageId);
                            try{
                                tempPackLicRec = userPackLicRecMap.get(tempString);
                            }
                            Catch(Exception e){
                                System.debug('Failed to fetch Package License from map: ' + e.getStackTraceString());
                            }
                            // call method with false to deactivate existing record
                            upsertPackageLicenseRecord(packageIdToNameMap.get(packageId), u, false, tempPackLicRec);
                        }                            
                    }
                    
                }// end if statement to see if there are any license assigned to the package we are tracking
                // there are no assigned licenses for this package, so we should deactivate all the package license records that are currently active against users
                // Check if the user has any package license records
                else if (userLicenseMap.containsKey(u.Id)){
                    // the user has a record for this particular package
                    if(userLicenseMap.get(u.Id).contains(packageIdToNameMap.get(packageId))){
                        // deactivate this record
                        tempString = u.Id + packageIdToNameMap.get(packageId);
                        try{
                            tempPackLicRec = userPackLicRecMap.get(tempString);
                        }
                        Catch(Exception e){
                            System.debug('Failed to fetch Package License from map: ' + e.getStackTraceString());
                        }
                        // call method with false to deactivate existing record
                        upsertPackageLicenseRecord(packageIdToNameMap.get(packageId), u, false, tempPackLicRec);
                    }                                                    
                }
                
            }// end loop over packageProfileMap 
        }// end loop on scope
        
        // upsert the data
        if (upsertList.size() > 0){
         System.debug('Running upsert command');
            upsert upsertList;
        }
        
    }
    
    // 
    private void upsertPackageLicenseRecord(String packageName, User theUser, boolean activeFlag, Package_License__c packLicRecord ){
        
        Package_License__c tempPackLicRec = new Package_License__c();
        Id IdVar = theUser.Id;
        // there is an existing record, so we will work with this record
        if(packLicRecord != null)
            tempPackLicRec = packLicRecord;
        
        simplePackageBean tempPackBean = new simplePackageBean();
        
        if(activeFlag){
            
            tempPackLicRec.Active_License__c=true;
            tempPackLicRec.Package__c=packageNameToIDMap.get(packageName);
            tempPackLicRec.User__c = IdVar;
            
            // if ServiceMax run the special mapping process
            if(packageName == 'ServiceMax'){
                tempPackBean = getSMaxDetails(theUser);
                tempPackLicRec.Package_License_Type__c = tempPackBean.m_LicenseType;        
                if(tempPackBean.m_commLicense)
                    tempPackLicRec.SFDC_License_Type__c = 'Dual (Standard + ServiceMax)';
                else
                    tempPackLicRec.SFDC_License_Type__c = 'ServiceMax';
            }
            // for all other license types just assign standard values
            else{
                tempPackLicRec.Package_License_Type__c = 'Standard';
                tempPackLicRec.SFDC_License_Type__c = 'Standard';
            }

        }
        // flag is false and package License record is not null so we udpate active flag to false on the existing record
        else if (!activeFlag && packLicRecord != null){
            tempPackLicRec.Active_License__c=false;
        }
        // this shouldn't happen
        else{
            System.debug('Application trying to set a record to non active status, but passed null for the existing packLicRecord parameter');
        }
        
        // add the temp record to the list
        upsertList.add(tempPackLicRec);
        
    }
    
    // use the User profile info to get the details of the SMax license type and if it consums a standard SFDC license
    private simplePackageBean getSMaxDetails(User theUser){
        
        simplePackageBean theBean = new simplePackageBean();
        
        // set license type
        if(packageProfileMap.get('ServiceMax').containsKey(theUser.Profile.name))
        {
            if((packageProfileMap.get('ServiceMax').get(theUser.Profile.name)=='Read Only' || packageProfileMap.get('ServiceMax').get(theUser.Profile.name)=='Restricted') && PermSetTitaniumUser.contains(theUser.Id))
                theBean.m_LicenseType = 'Bundle II';
            else
                theBean.m_LicenseType = packageProfileMap.get('ServiceMax').get(theUser.Profile.name);
        }
        else if (PermSetTitaniumUser.contains(theUser.Id))
            theBean.m_LicenseType = 'Bundle II';                    
        else if(PermSetReadUser.contains(theUser.Id)){
            theBean.m_LicenseType = 'Read Only';
            theBean.m_commLicense=TRUE;
        }
        else if(PermSetRestrictedUsers.contains(theUser.Id)){
            theBean.m_LicenseType = 'Restricted';
            theBean.m_commLicense=TRUE;
        }
        else{
            theBean.m_LicenseType = 'Unknown';
            theBean.m_commLicense=TRUE;
        }
        
        // set SFDC license or not
        if(PermSetSalesUser.contains(theUser.Id))
            theBean.m_commLicense=TRUE;
        else // use the checkbox off the profile mapping to determine if it should be true or false
        {
            if(profileMapSMaxLicense.containsKey(theUser.Profile.name))
                theBean.m_commLicense = profileMapSMaxLicense.get(theUser.Profile.name);
            else
                theBean.m_commLicense=TRUE;
        }
        
        return theBean;
    }
    
    // Email the user who started the job letting them know its finished
    global void finish(Database.BatchableContext BC) {
       
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String subject = 'OG SFDC: Package license run request';
        email.setSubject(subject);
        email.setTargetObjectId(userinfo.getUserId());
        email.setUseSignature(false);
        email.setSaveAsActivity(false);
        email.setPlainTextBody('Run Package License Process has completed.\n\n' + upsertList.size() + ' Records processed.');
        Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        System.debug('GE_OG_PackageLicenseBatch job finished');
        
    }
    
    global void execute(SchedulableContext sc)
    {
        GE_OG_PackageLicenseBatch batch = new GE_OG_PackageLicenseBatch();
        database.executeBatch(batch, 1000);  
    }    
    
    private void setPermSetVariables()
    {
        String baseQuery = 'select Assignee.Id From PermissionSetAssignment where PermissionSet.Label in ';
        String inQuery = '';
        String executeQuery = '';
        
        List<PermissionSetAssignment> permAssignee = new List<PermissionSetAssignment>{};
            List<Package_PermSet_Map__c> permSetList = new List<Package_PermSet_Map__c> ([select Salesforce_PermSet__c from Package_PermSet_Map__c where License_Type__c ='Read Only']);
        
        if(!permSetList.isEmpty())
        {
            for(Package_PermSet_Map__c str : permSetList)
                inQuery += '\'' + str.Salesforce_PermSet__c + '\',';
            inQuery = inQuery.lastIndexOf(',') > 0 ? '(' + inQuery.substring(0,inQuery.lastIndexOf(',')) + ')' : inQuery;
            
            System.debug('inQuery: ' + inQuery);
            executeQuery = baseQuery+inQuery;         
            System.debug('Execute query: ' + executeQuery);
            //Get Ids of users who have the read only permission set
            
            
            permAssignee = database.query(executeQuery);  
            for(PermissionSetAssignment ps : permAssignee)
                PermSetReadUser.add(ps.Assignee.Id);
        }
        
        permAssignee.clear();
        permSetList.clear();
        inQuery = '';
        executeQuery = '';
        
        //Get Ids of users who have the Titanium permission set
        permSetList = [select Salesforce_PermSet__c from Package_PermSet_Map__c where License_Type__c ='Bundle II'];
        if(!permSetList.isEmpty())
        {
            for(Package_PermSet_Map__c str : permSetList)
                inQuery += '\'' + str.Salesforce_PermSet__c + '\',';
            inQuery = inQuery.lastIndexOf(',') > 0 ? '(' + inQuery.substring(0,inQuery.lastIndexOf(',')) + ')' : inQuery;
            
            System.debug('inQuery: ' + inQuery);
            executeQuery = baseQuery+inQuery;
            
            permAssignee = database.query(executeQuery);
            for(PermissionSetAssignment ps : permAssignee)
                PermSetTitaniumUser.add(ps.Assignee.Id);
        }
        
        permAssignee.clear();
        permSetList.clear();
        inQuery = '';
        executeQuery = '';
        
        //Get Ids of users who have a Sales object permission set
        permSetList = [select Salesforce_PermSet__c from Package_PermSet_Map__c where License_Type__c ='Sales'];
        if(!permSetList.isEmpty())
        {
            for(Package_PermSet_Map__c str : permSetList)
                inQuery += '\'' + str.Salesforce_PermSet__c + '\',';
            inQuery = inQuery.lastIndexOf(',') > 0 ? '(' + inQuery.substring(0,inQuery.lastIndexOf(',')) + ')' : inQuery;
            
            System.debug('inQuery: ' + inQuery);
            executeQuery = baseQuery+inQuery;
            
            permAssignee = database.query(executeQuery);
            for(PermissionSetAssignment ps : permAssignee)
                PermSetSalesUser.add(ps.Assignee.Id);
        }
        
        permAssignee.clear();
        permSetList.clear();
        inQuery = '';
        executeQuery = '';
        
        //Get Ids of users who have a Restricted object permission set
        permSetList = [select Salesforce_PermSet__c from Package_PermSet_Map__c where License_Type__c ='Restricted'];
        if(!permSetList.isEmpty())
        {
            for(Package_PermSet_Map__c str : permSetList)
                inQuery += '\'' + str.Salesforce_PermSet__c + '\',';
            inQuery = inQuery.lastIndexOf(',') > 0 ? '(' + inQuery.substring(0,inQuery.lastIndexOf(',')) + ')' : inQuery;
            
            System.debug('inQuery: ' + inQuery);
            executeQuery = baseQuery+inQuery;
            
            permAssignee = database.query(executeQuery);
            for(PermissionSetAssignment ps : permAssignee)
                PermSetRestrictedUsers.add(ps.Assignee.Id);
        }
        
    }

}