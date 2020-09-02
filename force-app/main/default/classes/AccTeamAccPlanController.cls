/*    
Class Name        : AccTeamAccPlanController
Purpose/Overview  : Serves three buttons on Account list view: 'Add to My Accounts', 'Add to Account Team', 'Remove from Account Team'
Author            : Jayadev Rath
Created Date      : 15th Sept 2011
Test Class        : AccTeamAccPlanController_Test
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 15th Sept 2011 : Jayadev Rath      : Created : Created three methods to process the incoming request from the account page and after processing redirecting to respective pages
                  : 19th Sept 2011 : Jayadev Rath      : AddToAccountPlan() : Previously it was redirecting to Account Plan page. Now redirecting to the junction object (Planned Account) and directly pointing to the user's view.
                  : 26th Sept 2011 : Jayadev Rath      : getAccountNames(), Back(), getRoles() : Added these methods to enable selection of the teamrole by the user.
*/
Public class AccTeamAccPlanController { 

    String ViewName='My GE Accounts'; // Set to the view name that is assigned to the users.
    String AccIds {get;set;}
    String AccPlanId;
    String SSIds {get;set;}
    String IBIds  {get;set;}
    String RelIds {get;set;}
    String Action {get;set;}      
    PageReference redUrl = new PageReference('/001/o');    
    public String SelectedRole {get; set;}
    Public List<String> AccNames {get;set;}
    public List<SelectOption> getRoles() {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult Roles =AccountTeamMember.TeamMemberRole.getDescribe();
        List<Schema.PicklistEntry> ple = Roles.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        return options;
    }
    
    // Constructor to fetch the Account Ids and select the Action
    Public AccTeamAccPlanController() {
        Action = ApexPages.currentPage().getParameters().get('Action');
        IBIds  = ApexPages.currentPage().getParameters().get('IBIds'); 
        AccIds = ApexPages.currentPage().getParameters().get('AccIds');   
        SSIds = ApexPages.currentPage().getParameters().get('SSIds');  
       RelIds = ApexPages.currentPage().getParameters().get('RelIds');    
    }

    // Method to decide which submethod will be called
    Public PageReference reDirect() {
        // For Action::  AA:- Add Accounts, AT:- Add to Account Teams, RT:- Remove from Account Teams
        //If(Action == 'AA')    return AddToAccountPlan();
        If(Action == 'AA')    return AddToAccountPlan();
        If(Action == 'IB')    return AddIBAccountsToAccountPlan();
        If(Action == 'AT')    return getAccountNames(); // return AddToAccountTeam(); // Not redirected. Stays in the page to select the Team Role.
        If(Action == 'RT')    return RemoveFromAccountTeam();
        If(Action == 'SS')    return AddSSAccountsToAccountPlan();
        If(Action == 'Del')    return DeleteAccsSelected ();
        // When the page is directly accessed, then without any action it is redirected to the Accounts Page (default).
        redUrl.setRedirect(True);
        return redUrl;
    }
    
    // Get all the account names and display in the page
    private PageReference getAccountNames() {
        List<String> AllAccIds = AccIds.split(',');
        List<Account> AccNamesList = [Select Name from Account where Id in :AllAccIds];
        AccNames = new List<String>();
        For(Account a:AccNamesList)  AccNames.add(a.Name);
        return Null;    // Null is returned to stay in the same page.
    }
    
    // Takes back the control to the Account page
    public PageReference back() {    return redUrl; }

    // Method to add IB accounts in the Personal Account Plan
    Public PageReference AddIBAccountsToAccountPlan() {
    
        String ViewId;
        // Server side check, if any AccIds are coming in or not.
        If(IBIds  == Null || IBIds  =='') return new PageReference('/a0M/o');
        // Split the input parameter to get all the Account Ids
        List<String> AllIBIds = IBIds.split(',');
        // Fetching/Creating Account Plan for adding new Accounts to the Account Plan
        User UserRec = [Select Id,GE_HQ_Tier_1_P_L__c,GE_HQ_SSO_ID__c from User where id = :UserInfo.getUserId()][0];
        //List<GE_HQ_Account_Plan__c> PersonalAccPlan = [Select Id from GE_HQ_Account_Plan__c where OwnerId= :UserRec.Id and GE_HQ_Acc_Type__c = 'Private Plan' limit 1];
        List<GE_HQ_Acc_AccPlan_Rel__c> PersonalAccPlan = [Select Id,GE_HQ_Account_Plan__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Acc_Type__c = 'Private Plan' and GE_HQ_Account_Plan__r.OwnerId = :UserRec.Id limit 1];
        If(PersonalAccPlan == null || PersonalAccPlan.size() == 0) {
            System.debug('*** Create a new Account Plan');
            String APName= 'Private Plan ('+UserRec.GE_HQ_SSO_ID__c+')'; // If required first name can be provided for better look n feel
            String Btier = (UserRec.GE_HQ_Tier_1_P_L__c == 'Energy Services') ? 'ES' : ( (UserRec.GE_HQ_Tier_1_P_L__c == 'Power & Water') ? 'P&W' : ( (UserRec.GE_HQ_Tier_1_P_L__c == 'Oil & Gas') ? 'O&G' : ''));
            // GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, GE_HQ_Acc_Type__c = 'Private Plan', OwnerId =UserRec.Id, GE_HQ_Business_Tier1__c = Btier);
            //Added By Raj  
            //GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, OwnerId =UserRec.Id, GE_HQ_Business_Tier1__c = Btier);
            String recordTypeName = Schema.SObjectType.GE_HQ_Account_Plan__c.getRecordTypeInfosByName().get('Private Plan').getRecordTypeId();
            GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, OwnerId =UserRec.Id, GE_HQ_Business_Tier1__c = Btier, RecordTypeId = recordTypeName);
            Insert newAccPlan;
            AccPlanId = newAccPlan.Id;
            System.debug('Record Type::** '+newAccPlan.RecordType );
            System.debug('Acc Plan created::** '+AccPlanId );
        }
        // Acc Plan exists. So Add Accounts directly
        else {    AccPlanId = PersonalAccPlan[0].GE_HQ_Account_Plan__c; }
        
        //Get all Existing Accounts for the selected IB's
        List<GE_Installed_Base__c> IBList = [Select Id, Account__c from GE_Installed_Base__c where Id in :AllIBIds Limit 49999];
        Set<String> AccIds = new Set<String>();
        List<String> AllAccIds = new List<String>();
        For(GE_Installed_Base__c IB :IBList) AccIds.add(IB.Account__c);
        For(String Id : AccIds ) AllAccIds.add(Id);
        
        // Get all Existing Accounts for the Account Plan
        List<GE_HQ_Acc_AccPlan_Rel__c> AAPRel= [Select GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c = :AccPlanId ];
        For(GE_HQ_Acc_AccPlan_Rel__c temp: AAPRel) {
            For(integer i=0; i<AllAccIds.size(); i++) {
                // Remove the Account Ids if they are already existing in the Account Plan
                If(temp.GE_HQ_Account__c == AllAccIds[i]) { AllAccIds.remove(i); break; }
            }
        }
        // Now add the rest Accounts into the Account Plan.
        List<GE_HQ_Acc_AccPlan_Rel__c> NewAAPRels = new List<GE_HQ_Acc_AccPlan_Rel__c>();
        For(integer i=0 ; i < AllAccIds.size(); i++) {
            // Create the New junction obj records
            if(AllAccIds[i]!=null)
                NewAAPRels.add( new GE_HQ_Acc_AccPlan_Rel__c(GE_HQ_Account__c = AllAccIds[i], GE_HQ_Account_Plan__c=AccPlanId, GE_HQ_Acc_Type__c = 'Private Plan') );
        }
        // If any record exists for creation, insert them
        If(NewAAPRels != Null && NewAAPRels.size()>0)    Insert NewAAPRels;
        String keyPref = GE_HQ_Acc_AccPlan_Rel__c.getsObjectType().getDescribe().keyPrefix;
        // Find the View Name for the user
        List<SelectOption> views = new ApexPages.StandardSetController(NewAAPRels).getListViewOptions();

        For(SelectOption v: views)  If(v.getLabel() == ViewName) { ViewId = v.getValue(); break; }
        // Redirect to the Planned Account object.
        redUrl= (ViewId != Null) ? new PageReference('/'+keyPref+'?fcf='+ViewId.substring(0,15)) : new PageReference('/'+keyPref+'/o');
        redUrl.setRedirect(True);
        Return redUrl;
        // Redirect to the Account Plan Page        // Return new PageReference('/'+AccPlanId);
    }
    
    
    // Method to add accounts in the Personal Account Plan
    Public PageReference AddToAccountPlan() {
        String ViewId;
        // Server side check, if any AccIds are coming in or not.
        If(AccIds == Null || AccIds =='') return new PageReference('/001/o');
        // Split the input parameter to get all the Account Ids
        List<String> AllAccIds = AccIds.split(',');
        // Fetching/Creating Account Plan for adding new Accounts to the Account Plan
        User UserRec = [Select Id,GE_HQ_Tier_1_P_L__c,GE_HQ_SSO_ID__c from User where id = :UserInfo.getUserId()][0];
        System.debug('UserRec::'+ UserRec );
        List<GE_HQ_Acc_AccPlan_Rel__c> PersonalAccPlan = [Select Id,GE_HQ_Account_Plan__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Acc_Type__c = 'Private Plan' and GE_HQ_Account_Plan__r.OwnerId = :UserRec.Id limit 1];
        System.debug('PersonalAccPlan ::'+PersonalAccPlan );        
        If(PersonalAccPlan == null || PersonalAccPlan.size() == 0) {
            System.debug('*** Create a new Account Plan');
            String APName= 'Private Plan ('+UserRec.GE_HQ_SSO_ID__c+')'; // If required first name can be provided for better look n feel
            String Btier = (UserRec.GE_HQ_Tier_1_P_L__c == 'Energy Services') ? 'ES' : ( (UserRec.GE_HQ_Tier_1_P_L__c == 'Power & Water') ? 'P&W' : ( (UserRec.GE_HQ_Tier_1_P_L__c == 'Oil & Gas') ? 'O&G' : ''));
            // GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, GE_HQ_Acc_Type__c = 'Private Plan', OwnerId =UserRec.Id, GE_HQ_Business_Tier1__c = Btier);
            //Added By Raj  
            //GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, OwnerId =UserRec.Id, GE_HQ_Business_Tier1__c = Btier);
            String recordTypeName = Schema.SObjectType.GE_HQ_Account_Plan__c.getRecordTypeInfosByName().get('Private Plan').getRecordTypeId();
            GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, OwnerId =UserRec.Id, GE_HQ_Business_Tier1__c = Btier, RecordTypeId = recordTypeName);
            Insert newAccPlan;
            AccPlanId = newAccPlan.Id;
            System.debug('Record Type::** '+newAccPlan.RecordType );
            System.debug('Acc Plan created::** '+AccPlanId );
        }
        // Acc Plan exists. So Add Accounts directly
        else {    AccPlanId = PersonalAccPlan[0].GE_HQ_Account_Plan__c; }
        
        // Get all Existing Accounts for the Account Plan
        List<GE_HQ_Acc_AccPlan_Rel__c> AAPRel= [Select GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c = :AccPlanId ];
        For(GE_HQ_Acc_AccPlan_Rel__c temp: AAPRel) {
            For(integer i=0; i<AllAccIds.size(); i++) {
                // Remove the Account Ids if they are already existing in the Account Plan
                If(temp.GE_HQ_Account__c == AllAccIds[i]) { AllAccIds.remove(i); break; }
            }
        }
        // Now add the rest Accounts into the Account Plan.
        List<GE_HQ_Acc_AccPlan_Rel__c> NewAAPRels = new List<GE_HQ_Acc_AccPlan_Rel__c>();
        For(integer i=0 ; i < AllAccIds.size(); i++) {
            // Create the New junction obj records
            NewAAPRels.add( new GE_HQ_Acc_AccPlan_Rel__c(GE_HQ_Account__c = AllAccIds[i], GE_HQ_Account_Plan__c=AccPlanId, GE_HQ_Acc_Type__c = 'Private Plan') );
        }
        // If any record exists for creation, insert them
        If(NewAAPRels != Null && NewAAPRels.size()>0)    Insert NewAAPRels;
        String keyPref = GE_HQ_Acc_AccPlan_Rel__c.getsObjectType().getDescribe().keyPrefix;
        // Find the View Name for the user
        List<SelectOption> views = new ApexPages.StandardSetController(NewAAPRels).getListViewOptions();

        For(SelectOption v: views)  If(v.getLabel() == ViewName) { ViewId = v.getValue(); break; }
        // Redirect to the Planned Account object.
        redUrl= (ViewId != Null) ? new PageReference('/'+keyPref+'?fcf='+ViewId.substring(0,15)) : new PageReference('/'+keyPref+'/o');
        redUrl.setRedirect(True);
        Return redUrl;
        // Redirect to the Account Plan Page        // Return new PageReference('/'+AccPlanId);
    }
    
    // Method to add the user to the Team members of seleced Accounts
    Public PageReference AddToAccountTeam() {
        Id UsrId = UserInfo.getUserId();
        // Server side check, if any AccIds are coming in or not.
        If(AccIds == Null || AccIds =='') return new PageReference('/001/o');
        // Split the input parameter to get all the Account Ids
        List<String> AllAccIds = AccIds.split(',');
        List<AccountTeamMember> ExistingAccs = [Select AccountId from AccountTeamMember where UserId= :UsrId];
        For(AccountTeamMember atm: ExistingAccs) {
            For(integer i=0; i<AllAccIds.size(); i++) {
                // Remove the Account Ids if they are already existing in the Account TeamMember Object for that user
                If(atm.AccountId == AllAccIds[i]) { AllAccIds.remove(i); break; }
            }
        }
        List<AccountTeamMember> newATM = new List<AccountTeamMember>();
        For(integer i=0; i<AllAccIds.size(); i++) {
            newATM.add( new AccountTeamMember(UserId=UsrId, TeamMemberRole=SelectedRole, AccountId= AllAccids[i]));
        }
        If(newATM != Null && newATM.size() >0) Insert newATM;
        
        redUrl = new pageReference('/001/o');
        redUrl.setRedirect(True);
        Return redUrl;

    }
    
    // Method to remove the user from the Team members of seleced Accounts
    Public PageReference RemoveFromAccountTeam() {
        // Server side check, if any AccIds are coming in or not.
        If(AccIds == Null || AccIds =='') return new PageReference('/001/o');
        // Split the input parameter to get all the Account Ids
        List<String> AllAccIds = AccIds.split(',');
        Id UsrId = UserInfo.getUserId();
        // Get the Accounts where the user is a member
        List<AccountTeamMember> ExistingATMRecs = [Select Id from AccountTeamMember where UserId = :UsrId and AccountId in :AllAccIds];
        // Delete the membership of the user
        If(ExistingATMRecs != Null && ExistingATMRecs.size() >0) Delete ExistingATMRecs;
        // Redirect to the Accounts page
        redUrl = new pageReference('/001/o');
        redUrl.setRedirect(True);
        Return redUrl;
    }
    // Method to add Subscribed Systems accounts in the Personal Account Plan
    Public PageReference AddSSAccountsToAccountPlan() {
    
        String ViewId;
        // Server side check, if any SSIds are coming in or not.
        If(SSIds  == Null || SSIds  =='') return new PageReference('/a0M/o');
        // Split the input parameter to get all the Subscribed Systems Ids
        List<String> AllSSIds = SSIds.split(',');
        // Fetching/Creating Account Plan for adding new Subscribed Systems to the Account Plan
        User UserRec = [Select Id,GE_HQ_Tier_1_P_L__c,GE_HQ_SSO_ID__c from User where id = :UserInfo.getUserId()][0];
        //List<GE_HQ_Account_Plan__c> PersonalAccPlan = [Select Id from GE_HQ_Account_Plan__c where OwnerId= :UserRec.Id and GE_HQ_Acc_Type__c = 'Private Plan' limit 1];
        List<GE_HQ_Acc_AccPlan_Rel__c> PersonalAccPlan = [Select Id,GE_HQ_Account_Plan__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Acc_Type__c = 'Private Plan' and GE_HQ_Account_Plan__r.OwnerId = :UserRec.Id limit 1];
        If(PersonalAccPlan == null || PersonalAccPlan.size() == 0) {
            System.debug('*** Create a new Account Plan');
            String APName= 'Private Plan ('+UserRec.GE_HQ_SSO_ID__c+')'; // If required first name can be provided for better look n feel
            String Btier = (UserRec.GE_HQ_Tier_1_P_L__c == 'Energy Services') ? 'ES' : ( (UserRec.GE_HQ_Tier_1_P_L__c == 'Power & Water') ? 'P&W' : ( (UserRec.GE_HQ_Tier_1_P_L__c == 'Oil & Gas') ? 'O&G' : ''));
            // GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, GE_HQ_Acc_Type__c = 'Private Plan', OwnerId =UserRec.Id, GE_HQ_Business_Tier1__c = Btier);
            //Added By Raj  
            //GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, OwnerId =UserRec.Id, GE_HQ_Business_Tier1__c = Btier);
            String recordTypeName = Schema.SObjectType.GE_HQ_Account_Plan__c.getRecordTypeInfosByName().get('Private Plan').getRecordTypeId();
            GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, OwnerId =UserRec.Id, GE_HQ_Business_Tier1__c = Btier, RecordTypeId = recordTypeName);
            Insert newAccPlan;
            AccPlanId = newAccPlan.Id;
            System.debug('Record Type::** '+newAccPlan.RecordType );
            System.debug('Acc Plan created::** '+AccPlanId );
        }
        // Acc Plan exists. So Add Accounts directly
        else {    AccPlanId = PersonalAccPlan[0].GE_HQ_Account_Plan__c; }
        
        //Get all Existing Accounts for the selected Subscribed Systems
        List<GE_HQ_SUBSCR_SYSTEMS__c> SSList = [Select Id, GE_HQ_Account__c from GE_HQ_SUBSCR_SYSTEMS__c where Id in :AllSSIds Limit 49999];
        Set<String> AccIds = new Set<String>();
        List<String> AllAccIds = new List<String>();
        For(GE_HQ_SUBSCR_SYSTEMS__c SS :SSList) AccIds.add(SS.GE_HQ_Account__c);
        For(String Id : AccIds ) AllAccIds.add(Id);
        
        // Get all Existing Accounts for the Account Plan
        List<GE_HQ_Acc_AccPlan_Rel__c> AAPRel= [Select GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c = :AccPlanId ];
        For(GE_HQ_Acc_AccPlan_Rel__c temp: AAPRel) {
            For(integer i=0; i<AllAccIds.size(); i++) {
                // Remove the Account Ids if they are already existing in the Account Plan
                If(temp.GE_HQ_Account__c == AllAccIds[i]) { AllAccIds.remove(i); break; }
            }
        }
        // Now add the rest Accounts into the Account Plan.
        List<GE_HQ_Acc_AccPlan_Rel__c> NewAAPRels = new List<GE_HQ_Acc_AccPlan_Rel__c>();
        For(integer i=0 ; i < AllAccIds.size(); i++) {
            // Create the New junction obj records
            if(AllAccIds[i]!=null)
                NewAAPRels.add( new GE_HQ_Acc_AccPlan_Rel__c(GE_HQ_Account__c = AllAccIds[i], GE_HQ_Account_Plan__c=AccPlanId, GE_HQ_Acc_Type__c = 'Private Plan') );
        }
        // If any record exists for creation, insert them
        If(NewAAPRels != Null && NewAAPRels.size()>0)    Insert NewAAPRels;
        String keyPref = GE_HQ_Acc_AccPlan_Rel__c.getsObjectType().getDescribe().keyPrefix;
        // Find the View Name for the user
        List<SelectOption> views = new ApexPages.StandardSetController(NewAAPRels).getListViewOptions();

        For(SelectOption v: views)  If(v.getLabel() == ViewName) { ViewId = v.getValue(); break; }
        // Redirect to the Planned Account object.
        redUrl= (ViewId != Null) ? new PageReference('/'+keyPref+'?fcf='+ViewId.substring(0,15)) : new PageReference('/'+keyPref+'/o');
        redUrl.setRedirect(True);
        Return redUrl;
        // Redirect to the Account Plan Page        // Return new PageReference('/'+AccPlanId);
    }
    
    public pageReference DeleteAccsSelected(){
       String ViewId;
    // Server side check, if any RelIds are coming in or not.
        If(RelIds == Null || RelIds =='') return new pageReference('/a0E/o');
        // Split the input parameter to get all the Ids       
        List<String> AllRelIds = RelIds.split(',');
        // Set<String> RelIds1 = new Set<String>();
         System.debug('*** Delete MY GE Accts');
        List<GE_HQ_Acc_AccPlan_Rel__c> AcctMyGE = [Select Id,GE_HQ_Account_Plan__c from GE_HQ_Acc_AccPlan_Rel__c where id = :AllRelIds ];
        System.debug('*** Delete MY GE Accts');
        If(AcctMyGE != Null && AcctMyGE.size() >0) Delete AcctMyGE;  
        String keyPref = GE_HQ_Acc_AccPlan_Rel__c.getsObjectType().getDescribe().keyPrefix;
        List<SelectOption> views = new ApexPages.StandardSetController(AcctMyGE).getListViewOptions();
        For(SelectOption v: views)  If(v.getLabel() == ViewName) { ViewId = v.getValue(); break; }
        // Redirect to the Planned Account object.
        redUrl= (ViewId != Null) ? new PageReference('/'+keyPref+'?fcf='+ViewId.substring(0,15)) : new PageReference('/'+keyPref+'/o');
        redUrl.setRedirect(True);
        Return redUrl;
        // return new pageReference('/'+keyPref+'/o');
        

    } 
    
}