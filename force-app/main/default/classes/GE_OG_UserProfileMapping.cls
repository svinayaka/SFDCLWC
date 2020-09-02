/*************************************
* Name: GE_OG_UserProfileMapping
* Purpose:  This class will be called from the User trigger handler class and asign manage package licneses to the user and also place them into public groups
*       based on the profile assigned to the user
* Date: June 2016
*  * 
* */
public class GE_OG_UserProfileMapping {
    
    public static map<string,User_Profile_License_Group_Mapping__c> m_profileMapping;
    public static User_Profile_License_Group_Mapping__c m_mapping;
    public static list<sObject> updateList;
    public static list<UserPackageLicense> pacLicList;
    public static list<GroupMember> grpMemList;
    public static Set<String> packageIdSet;
    public static Set<String> UserPackageSet;
    public static boolean processToggle;
    
    public static void assignLicenseAndGroups(List<User> oldList, map<Id, User> oldMap, List<User> newList, boolean isInsert){
        m_profileMapping = User_Profile_License_Group_Mapping__c.getAll();
        updateList = new list<sObject>();
        pacLicList = new list<UserPackageLicense>();
        grpMemList = new list<GroupMember>();
        UserPackageSet = new Set<String>();
        
        try{
            if(Label.User_Profile_Mapping_Toggle == 'on')
                processToggle = true;
            else
                processToggle = false;
            
            System.debug('Toggle for process is set to : ' + processToggle);
            
        }
        Catch(Exception e){
            System.debug('Trying to access Custom Label failed: '+ e.getMessage());
            System.debug('Stack Trace: ' + e.getStackTraceString());
            processToggle = false;
        }
                
        packageIdSet = new Set<String>();
        
            
        // if the custom lable is set to on
        if(processToggle){
            
            for(User_Profile_License_Group_Mapping__c up : m_profileMapping.values()){
                String[] PackageIds = up.Managed_Package_License_IDs__c.split(';');
                for(String i : PackageIds)
                    packageIdSet.add(i);
            }
            
            for(UserPackageLicense upl : [Select PackageLicenseId, UserId from UserPackageLicense where PackageLicenseId in : packageIdSet])
                UserPackageSet.add(upl.PackageLicenseId + '' + upl.UserId);
            
            List<User> UserList = [select Id, ProfileId, Profile.name, isActive from User where Id in : newList];  
            
            // Insert scenario (users will be active)
            if(isInsert){
                for(User u : UserList)
                    assignLicenseAndGroupsHelper(u);
            }
            // Update scenario (users will be active)
            else{
                // only run this process if the user is going from inactive to active
                for(User u : UserList){
                    try{
                        if(!oldMap.get(u.Id).isActive){
                            assignLicenseAndGroupsHelper(u);
                            System.debug('Koshay: Ran the inactive to active logic');
                        }
                    }
                    Catch (Exception e){
                        System.debug('Exception when trying to access isActive field: ' + e.getMessage());
                    }
                } 
            }
        }
        
        // consolodate two lists into generic sObject list for update.  Need to keep the chunking to a minimal to avoid error
        for(UserPackageLicense u: pacLicList)
            updateList.add(u);
        for(GroupMember g : grpMemList)
            updateList.add(g);
            
        
        //run inserts on the list
        List<Database.SaveResult> insertResults;
        if(updateList.size() > 0){
            insertResults = Database.insert(updateList, false);
            for(Integer i=0;i<insertResults.size();i++){
                
                if (insertResults.get(i).isSuccess()){
                    insertResults.get(i).getId();
                }
                else if (!insertResults.get(i).isSuccess()){
                    // DML operation failed
                    Database.Error error = insertResults.get(i).getErrors().get(0);
                    System.debug('DML Error: ' + error.getMessage());
                    updateList.get(i);//failed record from the list
                    system.debug('Failed ID: '+updateList.get(i));
                } 
            }
        }
        
        /*
        //run upserts on the list
        try{
        if(updateList.size() > 0)
            upsert updateList;
        }
        Catch(Exception e){
            System.debug('Exception when trying to upsert sObject list: ' + e.getMessage());
            System.debug('Stack Trace: ' + e.getStackTraceString());
        }
        */
        
    }
    
    private static void assignLicenseAndGroupsHelper(User u){
        boolean flag = false;
        boolean lengthIssue = false;
        
        // Have to do some dumb stuff because of custom setting length constraints on the Name field
        if(u.Profile.Name.length() > 35){
            flag = m_profileMapping.containsKey(u.Profile.Name.subString(0,36));
            lengthIssue = true;
        }
        else{
            flag = m_profileMapping.containsKey(u.Profile.Name);
            lengthIssue = false;
        }
        //if a match is found get the contents of the custom setting record
        if(flag){
            if(lengthIssue)
                m_mapping = m_profileMapping.get(u.Profile.Name.subString(0,36));
            else
                m_mapping = m_profileMapping.get(u.Profile.Name);
            //add a record into the package license upsert list if needed
            if(m_mapping.Managed_Package_License_IDs__c != null){
                String[] PackageIds = m_mapping.Managed_Package_License_IDs__c.split(';');
                for(String i : PackageIds){
                    // if the user doesn't already have a license for the specified package then add them to the update list
                    if(!UserPackageSet.contains(i +''+u.Id)){
                        //updateList.add(new UserPackageLicense(PackageLicenseId = i, UserId = u.Id));
                        pacLicList.add(new UserPackageLicense(PackageLicenseId = i, UserId = u.Id));
                        System.debug('Adding user ' + u.Id + ' to licensed package ' + i);
                    }
                }
            }
            // add a record into the public group upsert list if needed
            if(m_mapping.Public_Group_IDs__c != null){
                System.debug('Group field not null');
                String[] GroupIds = m_mapping.Public_Group_IDs__c.split(';');
                for(String i : GroupIds){
                    //updateList.add(new GroupMember(GroupId = i, UserOrGroupId = u.Id));
                    grpMemList.add(new GroupMember(GroupId = i, UserOrGroupId = u.Id));
                    System.debug('Adding user ' + u.Id + ' to group ' + i);
                }
            }
        }  
    }
    /*Commented below code as part of 0000025224       
    //R-26376 : Below code is written to remove the Servicemax Licence to the Inactive Users    
    public static List<Package_License__c> SmaxLicensesToDelete;
    public static Set<Id> usrSet; 
     @future(callout=true)  
    public static void deletePackageLicence(Set<Id> usrSetIds)
    {   
        List<User> newUserList = new List<User>();    
        List<Package_License__c> SmaxLicensesToDelete = new List<Package_License__c>();        
        Set<Id> usrSet = new Set<Id>();
        
        newUserList = [Select Id, name, IsActive from User where Id in: usrSetIds];
        if(newUserList.size()>0)
        {
            for(User usr:newUserList)
            {
                if(usr.IsActive==false)
                    usrSet.add(usr.Id);
            }
            if(usrSet.size()>0)
            {             
                SmaxLicensesToDelete = [select Id, name, Active_License__c, Package__r.Name, Package_License_Type__c,SFDC_License_Type__c from Package_License__c  where user__c in :usrSet and Package__r.Name='ServiceMax'];          
                List<Package_License__c> updatelist = new List<Package_License__c>();
                              
                if(SmaxLicensesToDelete.size()>0){
                        delete SmaxLicensesToDelete;  
                
                 }    
                 
             }
         } 
       }  
       
    @future(callout=true)  
    public static void deleteSmaxLicence(Set<Id> usrSetIds)
    {   
        List<User> newUserList = new List<User>();    
        List<Package_License__c> SmaxLicensesToDelete = new List<Package_License__c>();        
        Set<Id> usrSet = new Set<Id>();
        
        newUserList = [Select Id, name, IsActive from User where Id in: usrSetIds];
        if(newUserList.size()>0)
        {
            for(User usr:newUserList)
            {
                if(usr.IsActive==false)
                    usrSet.add(usr.Id);
            }
            if(usrSet.size()>0)
            {             
                            
                List<PackageLicense> smaxLicenseList = [SELECT Id, NamespacePrefix FROM PackageLicense WHERE NamespacePrefix ='SVMXC']; 
               if(smaxLicenseList.size() > 0)
                {
                   List<UserPackageLicense> userSmaxLicenseList = new List<UserPackageLicense>([select id,PackageLicenseid,Userid from UserPackageLicense where PackageLicenseid IN :smaxLicenseList AND userId IN :usrSet]);
                   if(userSmaxLicenseList.size()>0)
                   {
                       delete userSmaxLicenseList; 
                   }
                }
            }   
         } 
     }  */
}