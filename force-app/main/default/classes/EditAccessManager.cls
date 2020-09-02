public class EditAccessManager {

    public List<SelectOption> allAccessType{get;set;}
    public List<SelectOption> enabledAccessType{get;set;}
    public List<SelectOption> allPermissionSets{get;set;}
    public List<SelectOption> enabledPermissionSets{get;set;}
    public List<SelectOption> allManagedPackages{get;set;}
    public List<SelectOption> enabledManagedPackages{get;set;}
    public List<SelectOption> allProfiles{get;set;}
    public List<SelectOption> enabledProfiles{get;set;}
    public List<SelectOption> allGroups{get;set;}
    public List<SelectOption> enabledGroups{get;set;}
    public List<SelectOption> allQueues{get;set;}
    public List<SelectOption> enabledQueues{get;set;}
    private ApexPages.StandardController cont;
    private boolean isClone;

    public EditAccessManager(ApexPages.StandardController controller) {
        cont = controller;
        allAccessType = new List<SelectOption>();
        enabledAccessType = new List<SelectOption>();
        allPermissionSets = new List<SelectOption>();
        enabledPermissionSets = new List<SelectOption>();
        allManagedPackages = new List<SelectOption>();
        enabledManagedPackages = new List<SelectOption>();
        allProfiles = new List<SelectOption>();
        enabledProfiles = new List<SelectOption>();
        allGroups = new List<SelectOption>();
        enabledGroups = new List<SelectOption>();
        allQueues = new List<SelectOption>();
        enabledQueues = new List<SelectOption>();
        isClone = false;
        GE_OG_AccessManager__c am = (GE_OG_AccessManager__c)controller.getRecord();
        if(ApexPages.currentPage().getParameters().get('clone')!=null){
            isClone = true;
            am.GE_OG_Super_User__c = null;
        }
        //For AccessType
        Set<String> enabledItems = new Set<String>();
        
        if(am.GE_OG_Access_Type__c!=null && !am.GE_OG_Access_Type__c.equals('')){
            for(String s:am.GE_OG_Access_Type__c.split('\r\n'))
                enabledItems.add(s);
        }
        for(String s:'Managed Packages,Managed Package Dashboard,Profile/Role Updates,Permission Sets,Permission Set Dashboard,Public Groups,Public Group Dashboard,Queues,Queue Dashboard,Tiers'.split(','))
            if(enabledItems.contains(s))
                enabledAccessType.add(new SelectOption(s,s));
            else
                allAccessType.add(new SelectOption(s,s));
        //For PermissionSets
        List<PermissionSet> allPermissions = [Select Name, Label FROM PermissionSet where IsOwnedByProfile = false];
        Map<String, PermissionSet> allPermissionsMap = new Map<String, PermissionSet>();
        for(PermissionSet ps:allPermissions)
            allPermissionsMap.put(ps.Label+allPermissionsMap.size(),ps);
        List<String> allPermissionsSorted = new List<String>();
        allPermissionsSorted.addAll(allPermissionsMap.keySet());
        allPermissionsSorted.sort();
        Set<String> enabledPermissions = new Set<String>();
        if(am.GE_OG_Assigned_Permission_Sets__c!=null && !am.GE_OG_Assigned_Permission_Sets__c.equals('')){
            for(String s:am.GE_OG_Assigned_Permission_Sets__c.split('\r\n'))
                enabledPermissions.add(s);
        }
        for(String s:allPermissionsSorted){
            PermissionSet ps = allPermissionsMap.get(s);
            if(enabledPermissions.contains(ps.Name))
                enabledPermissionSets.add(new SelectOption(ps.Name,ps.Label));
            else
                allPermissionSets.add(new SelectOption(ps.Name,ps.Label));
        }
        //For Profiles
        List<Profile> allProfile = [Select Name FROM Profile];
        Map<String, Profile> allProfilesMap = new Map<String, Profile>();
        for(Profile ps:allProfile)
            allProfilesMap.put(ps.Name+allProfilesMap.size(),ps);
        List<String> allProfilesSorted = new List<String>();
        allProfilesSorted.addAll(allProfilesMap.keySet());
        allProfilesSorted.sort();
        Set<String> enabledProfile = new Set<String>();
        if(am.GE_OG_Assigned_Profiles__c!=null && !am.GE_OG_Assigned_Profiles__c.equals('')){
            for(String s:am.GE_OG_Assigned_Profiles__c.split('\r\n'))
                enabledProfile.add(s);
        }
        for(String s:allProfilesSorted){
            Profile ps = allProfilesMap.get(s);
            if(enabledProfile.contains(ps.Name))
                enabledProfiles.add(new SelectOption(ps.Name,ps.Name));
            else
                allProfiles.add(new SelectOption(ps.Name,ps.Name));
        }
        //For Managed Package
        List<PackageLicense> allManagedPackage = [Select NamespacePrefix FROM PackageLicense where UsedLicenses > 0];
        Map<String, PackageLicense> allManagedPackageMap = new Map<String, PackageLicense>();
        for(PackageLicense ps:allManagedPackage)
            allManagedPackageMap.put(ps.NamespacePrefix+allManagedPackage.size(),ps);
        List<String> allManagedPackageSorted = new List<String>();
        allManagedPackageSorted.addAll(allManagedPackageMap.keySet());
        allManagedPackageSorted.sort();
        Set<String> enabledManagedPackage = new Set<String>();
        if(am.GE_OG_Assigned_Managed_Packages__c!=null && !am.GE_OG_Assigned_Managed_Packages__c.equals('')){
            for(String s:am.GE_OG_Assigned_Managed_Packages__c.split('\r\n'))
                enabledManagedPackage.add(s);
        }
        for(String s:allManagedPackageSorted){
            PackageLicense ps = allManagedPackageMap.get(s);
            if(enabledManagedPackage.contains(ps.NamespacePrefix))
                enabledManagedPackages.add(new SelectOption(ps.NamespacePrefix,ps.NamespacePrefix));
            else
                allManagedPackages.add(new SelectOption(ps.NamespacePrefix,ps.NamespacePrefix));
        }
        //For Group
        List<Group> allGroup = [Select Name, DeveloperName From Group where Type = 'Regular'];
        Map<String, Group> allGroupMap = new Map<String, Group>();
        for(Group ps:allGroup)
            allGroupMap.put(ps.Name+allGroup.size(),ps);
        List<String> allGroupSorted = new List<String>();
        allGroupSorted.addAll(allGroupMap.keySet());
        allGroupSorted.sort();
        Set<String> enabledGroup = new Set<String>();
        if(am.GE_OG_Assigned_Groups__c!=null && !am.GE_OG_Assigned_Groups__c.equals('')){
            for(String s:am.GE_OG_Assigned_Groups__c.split('\r\n'))
                enabledGroup.add(s);
        }
        for(String s:allGroupSorted){
            Group ps = allGroupMap.get(s);
            if(enabledGroup.contains(ps.DeveloperName))
                enabledGroups.add(new SelectOption(ps.DeveloperName,ps.Name));
            else
                allGroups.add(new SelectOption(ps.DeveloperName,ps.Name));
        }
        //For Queue
        List<Group> allQueue = [Select Id, Name, DeveloperName From Group where Type = 'Queue'];
        Map<String, Group> allQueueMap = new Map<String, Group>();
        for(Group ps:allQueue)
            allQueueMap.put(ps.Name+allQueueMap.size(),ps);
        List<String> allQueueSorted = new List<String>();
        allQueueSorted.addAll(allQueueMap.keySet());
        allQueueSorted.sort();
        Set<String> enabledQueue = new Set<String>();
        if(am.GE_OG_Assigned_Queues__c!=null && !am.GE_OG_Assigned_Queues__c.equals('')){
            for(String s:am.GE_OG_Assigned_Queues__c.split('\r\n'))
                enabledQueue.add(s);
        }
        String label = '';
        for(String s:allQueueSorted){
            Group ps = allQueueMap.get(s);
            if(enabledQueue.contains(ps.DeveloperName))
                enabledQueues.add(new SelectOption(ps.DeveloperName,ps.Name));
            else
                allQueues.add(new SelectOption(ps.DeveloperName,ps.Name));
        }
    }
   
    public PageReference save(){
        GE_OG_AccessManager__c am = (GE_OG_AccessManager__c)cont.getRecord();
        String enabled = '';
        for(SelectOption s:enabledAccessType)
            enabled += s.getValue() + '\r\n';
        am.GE_OG_Access_Type__c = enabled.removeEnd('\r\n');
        enabled = '';
        for(SelectOption s:enabledPermissionSets)
            enabled += s.getValue() + '\r\n';
        am.GE_OG_Assigned_Permission_Sets__c = enabled.removeEnd('\r\n');
        enabled = '';
        for(SelectOption s:enabledProfiles)
            enabled += s.getValue() + '\r\n';
        am.GE_OG_Assigned_Profiles__c = enabled.removeEnd('\r\n');
        enabled = '';
        for(SelectOption s:enabledManagedPackages)
            enabled += s.getValue() + '\r\n';
        am.GE_OG_Assigned_Managed_Packages__c = enabled.removeEnd('\r\n');
        enabled = '';
        for(SelectOption s:enabledGroups)
            enabled += s.getValue() + '\r\n';
        am.GE_OG_Assigned_Groups__c= enabled.removeEnd('\r\n');
        enabled = '';
        for(SelectOption s:enabledQueues)
            enabled += s.getValue() + '\r\n';
        am.GE_OG_Assigned_Queues__c= enabled.removeEnd('\r\n');
        if(isClone)
            am.id = null;
        upsert am;
        return new PageReference('/'+am.id);
    }
}