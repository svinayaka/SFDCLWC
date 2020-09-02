/*    
Class Name        : MyGEAccountAddRemoveAccTeamController
Purpose/Overview  : Serves two buttons on My GE Account list view:  'Add to Account Team', 'Remove from Account Team'
Author            : Malemleima Chanu
Created Date      : 8 March 2013
Test Class        : MyGEAccountAddRemoveController_Test
Change History    : 
*/


public class MyGEAccountAddRemoveAccTeamController{

//Define the Variables

    //String ViewName='My GE Accounts'; 
    String MyGEAccIds {get;set;}
    String SSIds {get;set;}
    String RelIds {get;set;}
    String Action {get;set;}
    Set<id> accIdSet = new set<id>(); 
   
    PageReference redUrl = new PageReference('/a0E/o');    
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
    
  
    
    //Constructor for fetching all the Account ID
    
        Public MyGEAccountAddRemoveAccTeamController() {
        
        Action = ApexPages.currentPage().getParameters().get('Action');
        MyGEAccIds = ApexPages.currentPage().getParameters().get('MyGEAccIds');  
        system.debug('***************'+MyGEAccIds); 
        SSIds = ApexPages.currentPage().getParameters().get('SSIds');  
        RelIds = ApexPages.currentPage().getParameters().get('RelIds');
        List<String> AllMyGEAccIds = MyGEAccIds.split(',');
        accIdSet = new set<id>();
        List<GE_HQ_Acc_AccPlan_Rel__c> MygeAcc=[select name, GE_HQ_Account__r.Id from GE_HQ_Acc_AccPlan_Rel__c where id IN: AllMyGEAccIds] ;
        system.debug('list of mygeaccountname with related Account'+MygeAcc);
        
        for(GE_HQ_Acc_AccPlan_Rel__c acc: MygeAcc){
            if(acc.GE_HQ_Account__r.id!=null)
                accIdSet.add(acc.GE_HQ_Account__r.id);
        } 
        system.debug('-------------'+accIdSet);
        }
        
       
        // Method to decide which submethod will be called
        Public PageReference reDirect() {
        
        If(Action == 'AT')    return getAccountNames(); 
        // If(Action == 'ADD')   return AddToAccountTeam(); // Not redirected. Stays in the page to select the Team Role.
        If(Action == 'RT')    return RemoveFromAccountTeam();
        // When the page is directly accessed, then without any action it is redirected to the Accounts Page (default).
        redUrl.setRedirect(True);
        return redUrl;
    }   
    
    
 // Get all the account names and display in the page
        private PageReference getAccountNames() {
        //List<String> AllAccIds = accIdSet.split(',');
        List<Account> AccNamesList = [Select Name from Account where Id =:accIdSet ];
        AccNames = new List<String>();
        For(Account a:AccNamesList)  AccNames.add(a.Name);
        system.debug('Account Names'+AccNames);
        return Null;    // Null is returned to stay in the same page.
    }
    
   
  
 // Method to add the user to the Team members of seleced Accounts
        Public PageReference AddToAccountTeam() {
       
        String ViewId;
        Id UsrId = UserInfo.getUserId();
        
        // Server side check, if any AccIds are coming in or not.
        If( MyGEAccIds == Null || MyGEAccIds =='')
        return new PageReference('/a0E/o');
        Set<Id> AllaccIdSet = accIdSet;
        List<AccountTeamMember> ExistingAccs = [Select AccountId from AccountTeamMember where UserId= :UsrId];
        For(AccountTeamMember atm: ExistingAccs) {
          for ( Id id : AllaccIdSet) {
                // Remove the Account Ids if they are already existing in the Account TeamMember Object for that user
                If(atm.AccountId == id) 
                { AllaccIdSet.remove(id); break; }
            }
        }
       
        List<AccountTeamMember> newATM = new List<AccountTeamMember>();
        for( Id id : accIdSet){
        system.debug('Account Id set'+accIdSet);
        newATM.add( new AccountTeamMember(UserId=UsrId, TeamMemberRole=SelectedRole, AccountId=id));
        }
        If(newATM != Null && newATM.size() >0) Insert newATM;
        system.debug('New AccountTeam Member'+newATM);
        redUrl = new pageReference('/a0E/o');
        redUrl.setRedirect(True);
        Return redUrl;
        
  }  
  
  public PageReference back() {    return redUrl; } // return to the Account Page
             
    
    
 // Method to remove the user from the Team members of selected Accounts
        Public PageReference RemoveFromAccountTeam() {
        // Server side check, if any AccIds are coming in or not.
        If(MyGEAccIds == Null || MyGEAccIds =='') return new PageReference('/a0E/o');
        Set<Id> AllaccIdSet = accIdSet;
        Id UsrId = UserInfo.getUserId();
        // Get the Accounts where the user is a member
        List<AccountTeamMember> ExistingATMRecs = [Select Id from AccountTeamMember where UserId =:UsrId and AccountId in :AllaccIdSet];
        // Delete the membership of the user
        If(ExistingATMRecs != Null && ExistingATMRecs.size() >0) Delete ExistingATMRecs;
        //Redirect to the Accounts page
        redUrl = new pageReference('/a0E/o');
        redUrl.setRedirect(True);
        Return redUrl;
       
    }
    
}