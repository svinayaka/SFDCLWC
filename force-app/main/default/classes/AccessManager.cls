public without sharing class AccessManager {
    
    public Boolean pagePermissionFlag {get; set;}
    public Boolean addRemoveFlag{get; set;}
    public Boolean roleProfile{get; set;}
    public Boolean Tiers{get; set;}
    public User mUser{get; set;}
    public String searchUserString {get; set;}
    public String accessSelected{get; set;}
    public SelectOption[] enableditems {get;set;}
    public SelectOption[] allitems {get;set;}     
    public Boolean removeDatabaseFlag{get; set;}
    public Boolean addedDatabaseFlag{get; set;}
    public String profileSelected{get; set;}
    public String ProfileName{get; set;}
    public String Selected{get; set;}
    public SelectOption[] allroles{get; set;}
    public String roleSelected{get; set;}
    public String searchTypes{get; set;}
    
    public String userId{get;set;}
    public String roleid{get; set;}
    public String UserLicense{get;set;}
    public String header{get;set;}
    public String header2{get;set;}
    
    private String base;
    private String assignment;
    private String baseId;
    private String baseName;
    private String baseLabel;
    private String condition;
    private String asignee;
    private String extra;
    private Map<String,String> roleMap;
    public String roles{get;set;}
    
    public List<selectOption> selectMode{get;set;}
   
    public AccessManager() {
        mUser = new user () ;
        checkPagePermission();
        roleMap = new Map<String,String>();
        roleMap.put('Regular','Public Group');
        roleMap.put('Role','Role');
        roleMap.put('RoleAndSubordinates','Role and Internal Subordinates');
        roleMap.put('RoleAndSubordinatesInternal','Role, Internal and Portal Subordiantes');
        roleMap.put('Users','User');
        roles = 'User Roles\n';
        for(UserRole u:[Select Id, Name from UserRole where PORTALTYPE = 'None' Order By Name])
            roles = roles + u.Name + '\n';
    }
    
    public PageReference redirectToXL(){
        return new PageReference('/apex/roleslistxl');
    }
    
    public void checkPagePermission() {
        pagePermissionFlag = false;
        List<GE_OG_AccessManager__c> superUserAccessList = [SELECT Id, GE_OG_Super_User__c, Is_Active__c, GE_OG_Access_Type__c,
                                  GE_OG_Assigned_Permission_Sets__c FROM GE_OG_AccessManager__c
                                  Where Is_Active__c=true and GE_OG_Super_User__c=: userinfo.getUserId()];
        if(superUserAccessList.size() > 0)  {
            pagePermissionFlag = true;
            
            selectMode = new List<selectOption>();
            Set<String> typeList = new Set<String>();
            typeList.addAll(parseMultiPicklist(superUserAccessList[0].GE_OG_Access_Type__c));
            for (String s:new List<String>{'Managed Packages','Managed Package Dashboard','Profile/Role Updates','Permission Sets','Permission Set Dashboard','Public Groups','Public Group Dashboard','Queues','Queue Dashboard','Tiers'})
                if(typeList.contains(s)){
                    selectMode.add(new SelectOption(s,s));
                }
            
        } else {
            pagePermissionFlag = false;
        }  
    }
    
    @RemoteAction
    public static List<Options> searchItems(String searchTerm, String accessSelected, String selectType) {
        
        searchTerm = String.escapeSingleQuotes(searchTerm);
        if(!('Queues'.equals(accessSelected)||'Public Groups'.equals(accessSelected))||
                    (('Queues'.equals(accessSelected)||'Public Groups'.equals(accessSelected))&&'Users'.equals(selectType))){
            List<Options> searchedItems = new List<Options>();
            if(searchTerm!=null) {
                for(User u : Database.query('Select Id, Name, GE_HQ_SSO_ID__c  from User where isactive=true and ' + 
                        (('Permission Sets'.equals(accessSelected)||'Profile/Role Updates'.equals(accessSelected))?'':'Profile.UserLicense.Name=\'Salesforce\' and ') +
                        '(FirstName like \'' + searchTerm + '%\' or ' +
                        'LastName like \'' + searchTerm + '%\' or ' +
                        'Name like \'' + searchTerm + '%\' or ' +
                        'GE_HQ_SSO_ID__c like \'' + searchTerm + '%\') limit 8'))
                    searchedItems.add(new Options(u.Id,u.Name+' ('+u.GE_HQ_SSO_ID__c+')'));
            }
            return searchedItems;
        } else {
            if('Regular'.equals(selectType)) {
                List<Options> searchedItems = new List<Options>();
                List<Group> groupList = [Select Id, Name From Group where Type =:selectType AND Name LIKE :'%'+searchTerm+'%' LIMIT 8];
                for(Group u : groupList)
                    searchedItems.add(new Options(u.Id, u.Name));
                return searchedItems;
            } else
                return searchRoles(selectType, searchTerm);
        }
    }
    
    public class Options {
        public String id {get; set;}
        public String label {get; set;}
        public String descr {get; set;}
        
        public Options(String id, String label){
            this.id = id;
            this.label = label;
        }
    }
    
    private static List<Options> searchRoles(String type, String searchString) {
        List<Options> searchedItems = new List<Options>();
        Map<Id,UserRole> roleMap = new Map<Id,UserRole>([Select Id, Name from UserRole where PORTALTYPE = 'None' AND Name LIKE :'%'+searchString+'%' LIMIT 8]);
        for(Group g:[Select Id, RELATEDID From Group where Type = :type AND RELATEDID IN : roleMap.keySet()])
            searchedItems.add(new Options(g.Id,((UserRole) roleMap.get(g.RELATEDID)).Name));
        return searchedItems;
    }
    
    @RemoteAction
    public static List<UserRole> searchRoles(String searchTerm){
        List<UserRole> roleList = new List<UserRole>();
        if(searchTerm!=null) {
            roleList = Database.query('Select Id, Name From UserRole where PortalType = \'None\' and '+
                                    'Name Like \'%' + String.escapeSingleQuotes(searchTerm) + '%\' ORDER BY Name Limit 8');
        }
        return roleList;
    }
    
    public List<String> parseMultiPicklist(String multiValuesInp ) {
        String[] multiList = multiValuesInp.split('\r\n');
        List<String> retPermVal = new List<String>();
        for (String pa : multiList) {
            retPermVal.add(pa);
        }
        return retPermVal;
    }
    
    public void searchExistingItems(String inputUserId) {
        
        system.debug('InputUserID: ' + inputUserId);        
        
        enableditems = new List<SelectOption>();
        allitems = new List<SelectOption>();
                                  
        List<String> avlItem = getEnabledItems();
                                  
        if('Permission Sets'.equals(accessSelected)){
        
            Map<Id,PermissionSet> avlList = new Map<Id,PermissionSet>([Select Id, Name, Label FROM PermissionSet where Name in: avlItem and License.Name=:userLicense]);
            Set<String> assigneditem = new Set<String>();

            for(PermissionSetAssignment asg:[Select PermissionSetId, PermissionSet.Label, PermissionSet.Name from PermissionSetAssignment 
                                              where AssigneeId=:userId and PermissionSetId in:avlList.keySet() and PermissionSet.License.Name=:userLicense]) {
                assigneditem.add(asg.PermissionSet.Name);            
                enableditems.add(new SelectOption(asg.PermissionSetId, asg.PermissionSet.Label)); 
            }
            for(String s:avlItem)
                if(!assigneditem.contains(s))
                    for(PermissionSet ps:avlList.values())
                        if(s.equals(ps.Name)){
                            allitems.add(new SelectOption(ps.Id,ps.label));
                            break;
                        }
            if(enableditems.size()==0&&allitems.size()==0)
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'Whoops! You dont have Permission Sets for User License: '+userLicense));
                
        } else if('Profile/Role Updates'.equals(accessSelected)){
        
            User u = [Select UserRole.Name, UserRoleId, Profile.Name, ProfileId From User where Id=:userId];
           
            String userProfile = u.Profile.Name;
            profileSelected = u.ProfileId;
            ProfileName =u.Profile.Name;
         
      
            if (ProfileName == 'GE_OG_GS_External RM')
            
              {
                roleSelected = 'None';
                roleid= null;
               
              }
        
            else
            {
            
            roleSelected = u.UserRole.Name;
            roleid = u.UserRoleId;
            
            avlItem.add(userProfile); 
            
            }
            
            List<Profile> avlList = [Select Id, Name FROM Profile where Name in: avlItem and UserLicense.Name=:userLicense];
            
            for(Profile ps:avlList)
                allitems.add(new SelectOption(ps.Id,ps.Name));
            
        } 
        else if('Tiers'.equals(accessSelected)){
          system.debug('userId:' + userId);  
        List<User> uList = [Select Id, GE_HQ_SSO_Id__c, Name, Profile.UserLicense.Name from user where id=: userId];
            
    mUser = [SELECT GE_HQ_Tier_1_P_L__c, GE_HQ_Tier_2_P_L__c, GE_HQ_Tier_3_P_L__c FROM User where GE_HQ_SSO_Id__c =:uList[0].GE_HQ_SSO_Id__c];
    System.debug('Set values of User: ' + uList[0].GE_HQ_SSO_Id__c + ' Tier 1: ' + mUser.GE_HQ_Tier_1_P_L__c + ' Tier 2: '+ mUser.GE_HQ_Tier_2_P_L__c + ' Tier 3: ' + mUser.GE_HQ_Tier_3_P_L__c);  
        }
        
        else if('Managed Packages'.equals(accessSelected)){
        
            //Ravi: fetch unique package license ids from Package__c table
            List<Package__c> packageList = new List<Package__c>([Select Package_Id__c FROM Package__c]);
            List<String> packIdlist = new List<String>();           
            for(Package__c pkg : packageList)
            {
                packIdlist.add(pkg.Package_Id__c);
            }
            //Fetch the Package License Ids based on namespaceprefix and fetch them only if they also exist in the Package__c table
            //This approach will avoid fetching wrong packages which have the same namespaceprefix
            Map<Id,PackageLicense> avlList = new Map<Id,PackageLicense>([Select Id, NamespacePrefix FROM PackageLicense where UsedLicenses > 0 AND NamespacePrefix in: avlItem AND Id in: packIdlist]);
            //End of changes. Below was the orginal line
            //Map<Id,PackageLicense> avlList = new Map<Id,PackageLicense>([Select Id, NamespacePrefix FROM PackageLicense where UsedLicenses > 0 AND NamespacePrefix in: avlItem]);
            Set<String> assigneditem = new Set<String>();

            for(UserPackageLicense asg:[Select PackageLicenseId, PackageLicense.NamespacePrefix from UserPackageLicense
                                              where UserId=:userId and PackageLicenseId in:avlList.keySet()]) {
                assigneditem.add(asg.PackageLicense.NamespacePrefix);            
                enableditems.add(new SelectOption(asg.PackageLicenseId, asg.PackageLicense.NamespacePrefix)); 
            }
            for(String s:avlItem)
                if(!assigneditem.contains(s))
                    for(PackageLicense ps:avlList.values())
                        if(s.equals(ps.NamespacePrefix)){
                            allitems.add(new SelectOption(ps.Id,ps.NamespacePrefix));
                            break;
                        }
        } else if('Public Groups'.equals(accessSelected)||'Queues'.equals(accessSelected)){
        
            String type = 'Public Groups'.equals(accessSelected)?'Regular':'Queue';
            Map<Id,Group> avlList = new Map<Id,Group>([Select Id, Name, DeveloperName From Group where Type =:type AND DeveloperName in: avlItem]);
            Set<String> assigneditem = new Set<String>();

            for(GroupMember asg:[Select GroupId, Group.Name, Group.DeveloperName from GroupMember
                                              where UserOrGroupId=:userId and GroupId in:avlList.keySet()]) {
                assigneditem.add(asg.Group.DeveloperName);            
                enableditems.add(new SelectOption(asg.GroupId, asg.Group.Name)); 
            }
            for(String s:avlItem)
                if(!assigneditem.contains(s))
                    for(Group ps:avlList.values())
                        if(s.equals(ps.DeveloperName)){
                            allitems.add(new SelectOption(ps.Id,ps.Name));
                            break;
                        }
        }
    }
          
    public PageReference refresh(){
        
        
        if(!('Queues'.equals(accessSelected)||'Public Groups'.equals(accessSelected))||
                    (('Queues'.equals(accessSelected)||'Public Groups'.equals(accessSelected))&&'Users'.equals(searchTypes))){
            List<User> uList = [Select Id, GE_HQ_SSO_Id__c, Name, Profile.UserLicense.Name from user where id=: userId];
            userLicense = uList[0].Profile.UserLicense.Name;
            if('Profile/Role Updates'.equals(accessSelected)){
                addRemoveFlag = false;
                tiers = false;
                roleProfile = true;
                header = 'Update Profile and Role for '+uList[0].Name+' ('+uList[0].GE_HQ_SSO_Id__c+')';
            } 
            else if('Tiers'.equals(accessSelected)){
                
                   addRemoveFlag = false;
                   tiers = true;
                   roleProfile = false;
                   header = 'Update Tiers for '+uList[0].Name+' ('+uList[0].GE_HQ_SSO_Id__c+')';
               }    
                        
                else {
                roleProfile = false;
                tiers = false;
                addRemoveFlag = true;
                header = 'Grant / Revoke '+accessSelected+' for '+uList[0].Name+' ('+uList[0].GE_HQ_SSO_Id__c+')';
            }
            searchExistingItems(userId);
        } else {
            List<Group> groupList = [Select Id, Name, RelatedId From Group where Type =:searchTypes AND Id =:userId];
            List<UserRole> roleList = new List<UserRole>([Select Id, Name from UserRole where Id = :groupList[0].RelatedId]);
                
            userLicense = searchTypes;
            roleProfile = false;
            addRemoveFlag = true;
            header = 'Grant / Revoke '+accessSelected+' membership for '+roleMap.get(searchTypes)+': '+(groupList[0].Name!=null?groupList[0].Name:roleList[0].Name);
            searchExistingItems(userId);
        }
        return null;
    }
    
    public PageReference cancelPage() {
        PageReference pr = Page.AccessManager;
        return pr.setRedirect(true);        
    }
    
    public PageReference  saveUser() {
      system.debug('INSIDE SAVE USER');
        String message = '';
        try {
            if (!Test.isRunningTest())
         {   

             //if(ProfileName == 'GE_OG_GS_External RM')
             if(profileSelected =='00ec0000000MS78AAG')
      {
         system.debug('jollyin saveuser'+ProfileName);
          
          update new User(Id=userId, ProfileId=profileSelected, UserRoleId= Null);
            system.debug('jollyin saveuser'+roleid);
      }
      
       else{
                update new User(Id=userId, ProfileId=profileSelected, UserRoleId=roleid);
                
           }
         }
            message = '<font size="2px">User updated successfully!</font>';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,message));
        } catch (Exception e) {
            message = 'Whoops! An error occurred -- ' + e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,message));      
        }
        return null;  
    }
  
        public PageReference saveTiers(){
        String message = '';
    try{
                    if(mUser.GE_HQ_Tier_1_P_L__c==null){
                    message = '<font size="2px">Tier 1 must be given a value.</font>';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,message));
                }
        else{
        update mUser;
        message = 'Tier(s) updated successfully!';
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,message));
            }
    }
     catch(Exception e){    
        message= 'Whoops! An error occurred -- ' + e.getMessage();
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,message));
    system.debug('Error message: ' + message);
     }
            

    return null;         
    }
    
    public PageReference  saveItems() {
    system.debug('INSIDE SAVE ITEMS');
        String message = '';
        removeDatabaseFlag = false;
        addedDatabaseFlag = false;
        
        try {
            if(allitems.size() > 0) {
                List<String> allLeftList = new List<String>();
                for(SelectOption opt: allitems) {
                    allLeftList.add(opt.getValue());         
                }
                List<sObject> removeAsg;
                if('Permission Sets'.equals(accessSelected))
                    removeAsg = [Select Id from PermissionSetAssignment where AssigneeId=:userId and PermissionSetId in:allLeftList];
                else if('Managed Packages'.equals(accessSelected))
                    removeAsg = [Select Id from UserPackageLicense where UserId=:userId and PackageLicenseId in:allLeftList];
                else if('Public Groups'.equals(accessSelected)||'Queues'.equals(accessSelected))
                    removeAsg = [Select Id from GroupMember where UserOrGroupId=:userId and GroupId in:allLeftList];
                if(removeAsg.size() > 0) {
                    if (!Test.isRunningTest())
                        delete removeAsg;
                    removeDatabaseFlag = true;
                }
            }
            if(enableditems.size() > 0) {
                List<String> allRightList = new List<String>();
                for(SelectOption opt: enableditems) {
                    allRightList.add(opt.getValue());         
                }
                List<sObject> addAsg;
                if('Permission Sets'.equals(accessSelected)){
                    List<PermissionSetAssignment> removeAsg = [Select PermissionSetId from PermissionSetAssignment where AssigneeId=:userId and PermissionSetId in:allRightList];
                    Set<String> removeAsgIds = new Set<String>();
                    for(PermissionSetAssignment psa:removeAsg)
                        removeAsgIds.add(psa.PermissionSetId);
                    addAsg = new List<sObject>();
                    for(String s:allRightList)
                        if(!(removeAsgIds.contains(s))) {
                            PermissionSetAssignment pAsg = new PermissionSetAssignment(PermissionSetId=s,AssigneeId=userId);
                            addAsg.add(pAsg);
                        }
                } else if('Managed Packages'.equals(accessSelected)){
                    List<UserPackageLicense> removeAsg = [Select PackageLicenseId from UserPackageLicense where UserId=:userId and PackageLicenseId in:allRightList];
                    Set<String> removeAsgIds = new Set<String>();
                    for(UserPackageLicense psa:removeAsg)
                        removeAsgIds.add(psa.PackageLicenseId);
                    addAsg = new List<sObject>();
                    for(String s:allRightList)
                        if(!(removeAsgIds.contains(s))) {
                            UserPackageLicense pAsg = new UserPackageLicense(PackageLicenseId=s,UserId=userId);
                            addAsg.add(pAsg);
                        }
                } else if('Public Groups'.equals(accessSelected)||'Queues'.equals(accessSelected)){
                    List<GroupMember> removeAsg = [Select GroupId from GroupMember where UserOrGroupId=:userId and GroupId in:allRightList];
                    Set<String> removeAsgIds = new Set<String>();
                    for(GroupMember psa:removeAsg)
                        removeAsgIds.add(psa.GroupId);
                    addAsg = new List<sObject>();
                    for(String s:allRightList)
                        if(!(removeAsgIds.contains(s))) {
                            GroupMember pAsg = new GroupMember(GroupId=s,UserOrGroupId=userId);
                            addAsg.add(pAsg);
                        }
                }
                if(addAsg.size()>0) {
                    if (!Test.isRunningTest())
                        insert addAsg;                
                    addedDatabaseFlag = true;
                }                     
            }
            if(removeDatabaseFlag && addedDatabaseFlag)
                message = '<font size="2px">Grant/Revoke operation completed successfully!</font>';
            else if(removeDatabaseFlag)
                message = '<font size="2px">Revoke operation completed successfully!</font>';
            else if(addedDatabaseFlag)               
                message = '<font size="2px">Grant operation completed successfully!</font>';
            else
                message = '<font size="2px">No changes made to '+accessSelected.removeEnd('s')+' assignments.</font>';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,message));
        } catch (Exception e) {
            message = 'Whoops! An error occurred -- ' + e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,message));
        }
        return null;  
    }
    
    public List<ExportItems> exportPermList {get; set;}
    public class ExportItems {
        public String id {get; set;}
        public String label {get; set;}
        public Integer assignedUsers {get; set;}
        public Integer activeCount {get; set;}
        public Integer totalCount {get; set;}
        public Integer availableCount {get; set;}
        public Integer assignedGroups {get; set;}
        public Integer assignedRoles {get; set;}  
    }
    
    public void exportItems(){
        
        List<String> avlItem = getEnabledItems();
        
        Map<String,Integer> assignedUsersMap = new Map<String,Integer>();
        Map<String,Integer> activeCountMap = new Map<String,Integer>();
        Map<String,Integer> availableCountMap = new Map<String,Integer>();
        Map<String,Integer> assignedGroupsMap = new Map<String,Integer>();
        Map<String,Integer> assignedRolesMap = new Map<String,Integer>();
        
        if(avlItem.size() > 0 ) {
            
            Map<Id,sObject> mapsObject = new Map<Id,sObject>(Database.query('Select Id,'+baseLabel+extra+' FROM '+base+' where '+condition+
                                                baseName+' in: avlItem order by '+baseLabel));
            Set<Id> keySet = mapsObject.keySet();
            
            for(AggregateResult asg : Database.query('Select count(Id) ct,'+baseId+' from '+assignment+
                                            ' where '+baseId+' in:keySet group by '+baseId)) {
                  assignedUsersMap.put((String)asg.get(baseId), (Integer)asg.get('ct'));
            }
            
            if('Permission Set Dashboard'.equals(accessSelected))
                for(AggregateResult asg : Database.query('Select count(Id) ct,'+baseId+','+asignee+'.isActive act from '+assignment+
                                            ' where '+baseId+' in:keySet group by '+baseId+','+asignee+'.isActive order by '+baseId+','+asignee+'.isActive')) {
                    activeCountMap.put((String)asg.get(baseId), (Integer)asg.get('ct'));    
                                              
            } else {
                Map<String,Set<String>> asigneeIdMap = new Map<String,Set<String>>();
                for(sObject sObj : Database.query('Select '+baseId+','+asignee+'Id from '+assignment+
                                                                    ' where '+baseId+' in:keySet order by '+baseId)){
                    String base = (String)sObj.get(baseId);
                    String assg = (String)sObj.get(asignee+'Id');
                    if(!asigneeIdMap.containskey(base))
                        asigneeIdMap.put(base, new Set<String>());
                    asigneeIdMap.get(base).add(assg);
                }
                
                for(String s:asigneeIdMap.keySet()){
                    Set<String> asigneeIds = asigneeIdMap.get(s);
                    AggregateResult asg = Database.query('Select count(Id) ct from User where IsActive = true AND Id IN:asigneeIds');
                    activeCountMap.put(s,(Integer)asg.get('ct'));
                    
                    if('Public Group Dashboard'.equals(accessSelected)||'Queue Dashboard'.equals(accessSelected)){
                        asg = Database.query('Select count(Id) ct From Group where Type =\'Regular\' AND Id IN: asigneeIds');
                        assignedGroupsMap.put(s,(Integer)asg.get('ct'));
                    
                        asg = Database.query('Select count(Id) ct From Group where Type IN (\'Role\',\'RoleAndSubordinates\',\'RoleAndSubordinatesInternal\') AND Id IN: asigneeIds');
                        assignedRolesMap.put(s,(Integer)asg.get('ct'));
                        system.debug('+++J'+assignedRolesMap);
                    }
                }
            }
            exportPermList = new List<ExportItems>();
                    
            for (sObject avl : mapsObject.values()) {
                ExportItems cp = new ExportItems();
                cp.id = avl.Id;
                cp.label = (String)avl.get(baseLabel);
                cp.assignedUsers = assignedUsersMap.get(avl.id);
                if('Managed Package Dashboard'.equals(accessSelected)){
                    cp.totalCount = (Integer)avl.get('AllowedLicenses');
                    cp.availableCount = cp.totalCount - cp.assignedUsers;
                }
                cp.activeCount = activeCountMap.get(avl.id);
                cp.assignedGroups = assignedGroupsMap.get(avl.id);
                cp.assignedRoles = assignedRolesMap.get(avl.id);
                system.debug('+++J'+ cp.assignedRoles);
                exportPermList.add(cp);               
            }
        }
    }
    
    private List<String> getEnabledItems() {
    
        List<GE_OG_AccessManager__c> permList = [SELECT GE_OG_Assigned_Permission_Sets__c, 
                                                      GE_OG_Assigned_Managed_Packages__c, GE_OG_Assigned_Groups__c, 
                                                      GE_OG_Assigned_Queues__c, GE_OG_Assigned_Profiles__c
                                                      FROM GE_OG_AccessManager__c Where Is_Active__c=true and 
                                                      GE_OG_Super_User__c=:userinfo.getUserId()];
                                                      
        GE_OG_AccessManager__c am = permList[0];
        
        if('Permission Sets'.equals(accessSelected)||'Permission Set Dashboard'.equals(accessSelected)){
            header2 = 'Permission Set';
            base = 'PermissionSet';
            assignment = 'PermissionSetAssignment';
            baseId = 'PermissionSetId';
            baseName = 'Name';
            baseLabel = 'Label';
            condition = '';
            asignee = 'Assignee';
            extra = '';
            return parseMultiPicklist(am.GE_OG_Assigned_Permission_Sets__c);
        } else if('Profile/Role Updates'.equals(accessSelected))
            return parseMultiPicklist(am.GE_OG_Assigned_Profiles__c);
        else if('Managed Packages'.equals(accessSelected)||'Managed Package Dashboard'.equals(accessSelected)){
            header2 = 'Managed Package';
            base = 'PackageLicense';
            assignment = 'UserPackageLicense ';
            baseId = 'PackageLicenseId';
            baseName = 'NamespacePrefix';
            baseLabel = 'NamespacePrefix';
            condition = 'UsedLicenses > 0 AND ';
            asignee = 'User';
            extra = ', AllowedLicenses';
            return parseMultiPicklist(am.GE_OG_Assigned_Managed_Packages__c);
        } else if('Public Groups'.equals(accessSelected)||'Public Group Dashboard'.equals(accessSelected)){
            header2 = 'Public Group';
            base = 'Group';
            assignment = 'GroupMember ';
            baseId = 'GroupId';
            baseName = 'DeveloperName';
            baseLabel = 'Name';
            condition = 'Type =\'Regular\' AND ';
            asignee = 'UserOrGroup';
            extra = '';
            return parseMultiPicklist(am.GE_OG_Assigned_Groups__c);
        } else if('Queues'.equals(accessSelected)||'Queue Dashboard'.equals(accessSelected)){
            header2 = 'Queue';
            base = 'Group';
            assignment = 'GroupMember ';
            baseId = 'GroupId';
            baseName = 'DeveloperName';
            baseLabel = 'Name';
            condition = 'Type =\'Queue\' AND ';
            asignee = 'UserOrGroup';
            extra = '';
            return parseMultiPicklist(am.GE_OG_Assigned_Queues__c);
        }
        return null;
    }
    }