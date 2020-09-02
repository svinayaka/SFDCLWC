/*    
Class Name        : GE_HQ_Accounts360ViewController
Purpose/Overview  : Providing a 360 View of the Account and its related Object records (Opportunities, Contacts, Contracts, IBs, Account Team Members, Tasks, Events, Projects, Cases)
Author            : Jayadev Rath
Test Class        : GE_HQ_Accounts360ViewController_Test 
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : Felix Release : Jayadev Rath       : Created : Created the class to give the 360 view of Account
                  : 18th Oct 2011 : Jayadev Rath       : Updated for reducing the View state size and enhancing the performance.
                  :23rd feb 2012 : Rekha.N             : updated for Re-Org Changes
                  :  26th Mar 2012 :Rekha .N             : updated for R-5907
*/


Public With Sharing class GE_HQ_Accounts360ViewController {
    /*
    
    Private String AccPlanningId;
    Public Integer NoOfRows = 10;    // If any requirement comes for dynamically setting the no of records per page.
    Private Set<id> AllAccountids = new Set<id>();
    Private String SelectedTab='';   // Var to store the Selected tab name
    public String getSelectedTab(){ If(SelectedTab == '') return 'Acc';    else return SelectedTab; }
    Public void setSelectedTab(String s) { this.SelectedTab = s; }
    
    Public String dduns=null;    
    

    // Fetching Account Records
    transient List<Account> AllAccountRecs = new List<Account>();
    Private Integer NextCountAcc=0;
    Public Integer TotalAccRecords{get;set;}
    Public Integer StartRecAcc{get;set;}
    Public Integer EndRecAcc{get;set;}
    Public Boolean hasFirstAcc{get;set;}
    Public Boolean hasPrevAcc{get;set;}
    Public Boolean hasNextAcc{get;set;}
    Public Boolean hasLastAcc{get;set;}
    Public String SearchTextAcc{get;set;}
    Private String SearchStringAcc='%%';
    Public List<Account> AccountRecs;

    // Fetching Opportunity records
    transient List<Opportunity> AllOpportunityRecs = new List<Opportunity>();
    Private Integer NextCountOpp=0;
    Public Integer TotalOppRecords{get;set;}
    Public Integer StartRecOpp{get;set;}
    Public Integer EndRecOpp{get;set;}
    Public Boolean hasFirstOpp{get;set;}
    Public Boolean hasPrevOpp{get;set;}
    Public Boolean hasNextOpp{get;set;}
    Public Boolean hasLastOpp{get;set;}
    Public String SearchTextOpp{get;set;}
    Private String SearchStringOpp='%%';
    Public List<Opportunity> OpportunityRecs;

    // Fetching Contact records:-
    transient List<Contact> AllContactRecs = new List<Contact>();
    Private Integer NextCountContact=0;
    Public Integer TotalContactRecords{get;set;}
    Public Integer StartRecContact{get;set;}
    Public Integer EndRecContact{get;set;}
    Public Boolean hasFirstContact{get;set;}
    Public Boolean hasPrevContact{get;set;}
    Public Boolean hasNextContact{get;set;}
    Public Boolean hasLastContact{get;set;}
    Public String SearchTextContact{get;set;}
    Private String SearchStringContact='%%';
    Public List<Contact> ContactRecs;

    // Fetching Contract records
    transient List<Contract> AllContractRecs = new List<Contract>();
    Private Integer NextCountContract=0;
    Public Integer TotalContractRecords{get;set;}
    Public Integer StartRecContract{get;set;}
    Public Integer EndRecContract{get;set;}
    Public Boolean hasFirstContract{get;set;}
    Public Boolean hasPrevContract{get;set;}
    Public Boolean hasNextContract{get;set;}
    Public Boolean hasLastContract{get;set;}
    Public String SearchTextContract{get;set;}
    Private String SearchStringContract='%%';
    Public List<Contract> ContractRecs;

    // Fetching Installed Base records
    transient List<GE_Installed_Base__c> AllIBRecs = new List<GE_Installed_Base__c>();
    Private Integer NextCountIB=0;
    Public Integer TotalIBRecords{get;set;}
    Public Integer StartRecIB{get;set;}
    Public Integer EndRecIB{get;set;}
    Public Boolean hasFirstIB{get;set;}
    Public Boolean hasPrevIB{get;set;}
    Public Boolean hasNextIB{get;set;}
    Public Boolean hasLastIB{get;set;}
    Public String SearchTextIB{get;set;}
    Private String SearchStringIB='%%';
    Public List<GE_Installed_Base__c> IBRecs;

    // Fetching Account Team Members(ATM) records
    transient List<AccountTeamMember> AllATMRecs = new List<AccountTeamMember>();
    Private Integer NextCountATM=0;
    Public Integer TotalATMRecords{get;set;}
    Public Integer StartRecATM{get;set;}
    Public Integer EndRecATM{get;set;}
    Public Boolean hasFirstATM{get;set;}
    Public Boolean hasPrevATM{get;set;}
    Public Boolean hasNextATM{get;set;}
    Public Boolean hasLastATM{get;set;}
    Public String SearchTextATM{get;set;}
    Private String SearchStringATM='%%';
    Public List<AccountTeamMember> ATMRecs;

    // Fetching Task Records
    transient List<Task> AllTaskRecs = new List<Task>();
    Private Integer NextCountTask=0;
    Public Integer TotalTaskRecords{get;set;}
    Public Integer StartRecTask{get;set;}
    Public Integer EndRecTask{get;set;}
    Public Boolean hasFirstTask{get;set;}
    Public Boolean hasPrevTask{get;set;}
    Public Boolean hasNextTask{get;set;}
    Public Boolean hasLastTask{get;set;}
    Public String SearchTextTask{get;set;}
    Private String SearchStringTask='%%';
    Public List<Task> TaskRecs;    

    // Fetching Event Records
    transient List<Event> AllEventRecs = new List<Event>();
    Private Integer NextCountEvent=0;
    Public Integer TotalEventRecords{get;set;}
    Public Integer StartRecEvent{get;set;}
    Public Integer EndRecEvent{get;set;}
    Public Boolean hasFirstEvent{get;set;}
    Public Boolean hasPrevEvent{get;set;}
    Public Boolean hasNextEvent{get;set;}
    Public Boolean hasLastEvent{get;set;}
    Public String SearchTextEvent{get;set;}
    Private String SearchStringEvent='%%';
    Public List<Event> EventRecs;

    // Fetching Project Records
    transient List<Project_ge_og__c> AllProjectRecs = new List<Project_ge_og__c>();
    Private Integer NextCountProject=0;
    Public Integer TotalProjectRecords{get;set;}
    Public Integer StartRecProject{get;set;}
    Public Integer EndRecProject{get;set;}
    Public Boolean hasFirstProject{get;set;}
    Public Boolean hasPrevProject{get;set;}
    Public Boolean hasNextProject{get;set;}
    Public Boolean hasLastProject{get;set;}
    Public String SearchTextProject{get;set;}
    Private String SearchStringProject='%%';
    Public List<Project_ge_og__c> ProjectRecs;

    //Fetching Case Records
    transient List<Case> AllCaseRecs = new List<Case>();
    Private Integer NextCountCase=0;
    Public Integer TotalCaseRecords{get;set;}
    Public Integer StartRecCase{get;set;}
    Public Integer EndRecCase{get;set;}
    Public Boolean hasFirstCase{get;set;}
    Public Boolean hasPrevCase{get;set;}
    Public Boolean hasNextCase{get;set;}
    Public Boolean hasLastCase{get;set;}
    Public String SearchTextCase{get;set;}
    Private String SearchStringCase='%%';
    Public List<Case> CaseRecs;
    
    //Fetching AEPlan Records
    transient List<GE_HQ_Account_Plan__c> AllAEPlanRecs = new List<GE_HQ_Account_Plan__c>();
    Private Integer NextCountAEPlan=0;
    Public Integer TotalAEPlanRecords{get;set;}
    Public Integer StartRecAEPlan{get;set;}
    Public Integer EndRecAEPlan{get;set;}
    Public Boolean hasFirstAEPlan{get;set;}
    Public Boolean hasPrevAEPlan{get;set;}
    Public Boolean hasNextAEPlan{get;set;}
    Public Boolean hasLastAEPlan{get;set;}
    Public String SearchTextAEPlan{get;set;}
    Private String SearchStringAEPlan='%%';
    Public List<GE_HQ_Account_Plan__c> AEPlanRecs;
    
    //Fetching Energy Plans Records
    transient List<GE_HQ_Account_Plan__c> AllEnergyPlanRecs = new List<GE_HQ_Account_Plan__c>();
    Private Integer NextCountEnergyPlan=0;
    Public Integer TotalEnergyPlanRecords{get;set;}
    Public Integer StartRecEnergyPlan{get;set;}
    Public Integer EndRecEnergyPlan{get;set;}
    Public Boolean hasFirstEnergyPlan{get;set;}
    Public Boolean hasPrevEnergyPlan{get;set;}
    Public Boolean hasNextEnergyPlan{get;set;}
    Public Boolean hasLastEnergyPlan{get;set;}
    Public String SearchTextEnergyPlan{get;set;}
    Private String SearchStringEnergyPlan='%%';
    Public List<GE_HQ_Account_Plan__c> EnergyPlanRecs;
    Public Set<Id> EnergyPlanIds = new Set<Id>();    
    
    //Fetching PRM Plans Records
    transient List<GE_HQ_Account_Plan__c> AllPRMPlanRecs = new List<GE_HQ_Account_Plan__c>();
    Private Integer NextCountPRMPlan=0;
    Public Integer TotalPRMPlanRecords{get;set;}
    Public Integer StartRecPRMPlan{get;set;}
    Public Integer EndRecPRMPlan{get;set;}
    Public Boolean hasFirstPRMPlan{get;set;}
    Public Boolean hasPrevPRMPlan{get;set;}
    Public Boolean hasNextPRMPlan{get;set;}
    Public Boolean hasLastPRMPlan{get;set;}
    Public String SearchTextPRMPlan{get;set;}
    Private String SearchStringPRMPlan='%%';
    Public List<GE_HQ_Account_Plan__c> PRMPlanRecs;
    Public Set<Id> prmAccountPlanIds = new Set<Id>();
    
    //Fetching FieldOfPlay Records
    transient List<Field_of_Play__c> AllFieldOfPlayRecs = new List<Field_of_Play__c>();
    Private Integer NextCountFieldOfPlay=0;
    Public Integer TotalFieldOfPlayRecords{get;set;}
    Public Integer StartRecFieldOfPlay{get;set;}
    Public Integer EndRecFieldOfPlay{get;set;}
    Public Boolean hasFirstFieldOfPlay{get;set;}
    Public Boolean hasPrevFieldOfPlay{get;set;}
    Public Boolean hasNextFieldOfPlay{get;set;}
    Public Boolean hasLastFieldOfPlay{get;set;}
    Public String SearchTextFieldOfPlay{get;set;}
    Private String SearchStringFieldOfPlay='%%';
    Public List<Field_of_Play__c> FieldOfPlayRecs;
    
    //Fetching PlanActivity Records
    transient List<Task> AllPlanActivityRecs = new List<Task>();
    Private Integer NextCountPlanActivity=0;
    Public Integer TotalPlanActivityRecords{get;set;}
    Public Integer StartRecPlanActivity{get;set;}
    Public Integer EndRecPlanActivity{get;set;}
    Public Boolean hasFirstPlanActivity{get;set;}
    Public Boolean hasPrevPlanActivity{get;set;}
    Public Boolean hasNextPlanActivity{get;set;}
    Public Boolean hasLastPlanActivity{get;set;}
    Public String SearchTextPlanActivity{get;set;}
    Private String SearchStringPlanActivity='%%';
    Public List<Task> PlanActivityRecs;
    public set<Id> RelatedAccountPlanIds = new set<Id>();
    
    
    
     // Fetching Channel Appointment Records
    transient List<GE_PRM_Channel_Appointment__c> AllchanApptRecs = new List<GE_PRM_Channel_Appointment__c>();
    Private Integer NextCountchanAppt=0;
    Public Integer TotalchanApptRecords{get;set;}
    Public Integer StartRecchanAppt{get;set;}
    Public Integer EndRecchanAppt{get;set;}
    Public Boolean hasFirstchanAppt{get;set;}
    Public Boolean hasPrevchanAppt{get;set;}
    Public Boolean hasNextchanAppt{get;set;}
    Public Boolean hasLastchanAppt{get;set;}
    Public String SearchTextchanAppt{get;set;}
    Private String SearchStringchanAppt='%%';
    Public List<GE_PRM_Channel_Appointment__c> chanApptRecs;
    
    
    
    

    Public GE_HQ_Accounts360ViewController(ApexPages.StandardController controller) {
        AccPlanningId=ApexPages.currentPage().getParameters().get('id');
        // Fetch the List of Accounts related to an Account Plan
        List<GE_HQ_Acc_AccPlan_Rel__c> AllListOfAccounts = [Select Id,GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c = :AccPlanningID ];
        // Get all Account Ids
        For(GE_HQ_Acc_AccPlan_Rel__c acc: AllListOfAccounts)
            AllAccountids.add(acc.GE_HQ_Account__c);
        if(AccPlanningId!=null)
            dduns = [select id, GE_HQ_DDUNS_fm__c from GE_HQ_Account_Plan__c where Id =:  AccPlanningId].GE_HQ_DDUNS_fm__c;    
        AccountType = 'All Accounts';
        isGEAccount = false;
        myGEAccounts();                        
    }

        
    Public List<Account> getAccountRecs() {
        // Make other tab variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringAcc='%%';     
        If((AllAccountRecs == Null || AllAccountRecs.size() == 0 ) && SearchStringAcc == '%%') { // If the variable is null, and no search is performed then fetch the records
            AllAccountRecs = [Select Id, Name, GE_HQ_DUNS_Number__c,GE_OG_Region_Tier1__c,ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry from Account where Id IN :AllAccountIds Order by Name];
            TotalAccRecords = AllAccountRecs.size();
        }
        
        if(AccountType=='My GE Accounts' && AllAccountRecs != Null){
            List<Account> myGEAccountsList = new List<Account>();
            for(Account accObj: AllAccountRecs)
                if(myGEAccountIds.contains(accObj.id))
                    myGEAccountsList.add(accObj);
            if(myGEAccountsList.size()>0)
                AllAccountRecs = myGEAccountsList;
            else
                AllAccountRecs = new List<Account>(); 
            TotalAccRecords = AllAccountRecs.size();                               
        }
        
        // If no Account records found return null
        If(AllAccountRecs == Null || AllAccountRecs.size() == 0)    return null;
            
        List<Account> AccountRecs = new List<Account>();
        For(Integer i=0;i < NoOfRows && (NextCountAcc+i < TotalAccRecords); i++) {
            AccountRecs.add(AllAccountRecs[NextCountAcc+i]);
        }
        
        if(NextCountAcc <= 0) {
            hasFirstAcc=False;
            hasPrevAcc=False;
        }
        else {
            hasFirstAcc=True;
            hasPrevAcc=True;
        }
        if(NextCountAcc >= (TotalAccRecords - NoOfRows)) {
            hasLastAcc=False;
            hasNextAcc=False;
        }
        else {
            hasLastAcc=True;
            hasNextAcc=True;
        }

        StartRecAcc=(TotalAccRecords == 0)?0:NextCountAcc+1;
        if(StartRecAcc+NoOfRows >TotalAccRecords)
            EndRecAcc=TotalAccRecords;
        else
            EndRecAcc=StartRecAcc+NoOfRows-1;
        return AccountRecs;
    }

    // Method to Search in Account records
    Public void SearchAcc() {
        SearchStringAcc = '%'+SearchTextAcc.Trim()+'%';
        AllAccountRecs = [Select Id, Name, GE_HQ_DUNS_Number__c,GE_OG_Region_Tier1__c, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry From Account where Id in :AllAccountIds and (Name like :SearchStringAcc or GE_HQ_DUNS_Number__c like :SearchStringAcc or GE_HQ_Region_Tier1__r.name like :SearchStringAcc or ShippingStreet like :SearchStringAcc or ShippingCity like :SearchStringAcc or ShippingState like :SearchStringAcc or ShippingPostalCode like  :SearchStringAcc or ShippingCountry like :SearchStringAcc) Order by Name];
        TotalAccRecords = AllAccountRecs.size();
        NextCountAcc = 0;
    }
    
    // For fetching the next set of records
    Public void getNextAcc() {
        if(NextCountAcc+NoOfRows <= TotalAccRecords)
            NextCountAcc+=NoOfRows;
        else
            NextCountAcc= TotalAccRecords- NoOfRows;
    }
    // For Fetching the previous set of Accounts
    Public void getPrevAcc() {
        if(NextCountAcc-NoOfRows >=0)
            NextCountAcc-=NoOfRows;
        else
            NextCountAcc=0;
    }
    // For fetching the first Set of records
    Public void getFirstAcc() {
        NextCountAcc=0;
    }
    // For fetching the last set of records
    Public void getLastAcc() {
        NextCountAcc=TotalAccRecords- NoOfRows;
    }
    

    // For Fetching Opportunity records related to Account        
    Public List<Opportunity> getOpportunityRecs() {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringOpp='%%';
        //GE_ES_Request_Date__c removed and Expected Order Date(CloseDate) was included.
        If((AllOpportunityRecs == Null || AllOpportunityRecs.size() == 0) && SearchStringOpp =='%%') {
            AllOpportunityRecs = [select Id, Name, AccountId, Account.Name, OwnerId, Owner.Name,tier_2_ge_og__c,tier_3_ge_og__c, pipeline_amount_ge_og__c, StageName, CloseDate, end_user_ge_og__c from Opportunity where (AccountId in :AllAccountIds OR end_user_ge_og__c in :AllAccountIds) and StageName NOT IN('Closed Lost','Abandoned','Cancelled','Duplicate') Order by pipeline_amount_ge_og__c DESC];
            TotalOppRecords = AllOpportunityRecs.size();
        }
        
        if(AccountType=='My GE Accounts' && AllOpportunityRecs != Null){
            List<Opportunity> myGEOpportunityList = new List<Opportunity>();
            for(Opportunity oppObj: AllOpportunityRecs)
                if(myGEAccountIds.contains(oppObj.AccountId) || myGEAccountIds.contains(oppObj.end_user_ge_og__c))
                    myGEOpportunityList.add(oppObj);
            if(myGEOpportunityList.size()>0)
                AllOpportunityRecs = myGEOpportunityList;
            else
                AllOpportunityRecs = new List<Opportunity>(); 
            TotalOppRecords = AllOpportunityRecs.size();                               
        }

        // If no Oppty found return null
        If(AllOpportunityRecs == Null || AllOpportunityRecs.size() == 0) return null;
            
        List<Opportunity> OpportunityRecs = new List<Opportunity>();
        For(Integer i=0;i < NoOfRows && (NextCountOpp+i < TotalOppRecords); i++) {
            OpportunityRecs.add(AllOpportunityRecs[NextCountOpp+i]);
        }
        
        if(NextCountOpp <= 0) {
            hasFirstOpp=False;
            hasPrevOpp=False;
        }
        else {
            hasFirstOpp=True;
            hasPrevOpp=True;
        }
        if(NextCountOpp >= (TotalOppRecords - NoOfRows)) {
            hasLastOpp=False;
            hasNextOpp=False;
        }
        else {
            hasLastOpp=True;
            hasNextOpp=True;
        }

        StartRecOpp=(TotalOppRecords == 0)?0:NextCountOpp+1;
        if(StartRecOpp+NoOfRows >TotalOppRecords)
            EndRecOpp=TotalOppRecords;
        else
            EndRecOpp=StartRecOpp+NoOfRows-1;
        return OpportunityRecs;
    }
    
    // Method to Search in Opportunity records
    Public void SearchOpp() {
        SearchStringOpp = '%'+SearchTextOpp.Trim()+'%';
        Double SearchStringOpp_Amt;        // For searching in Pipeline amount. As strings can't be compared to nonstrings.
        Try {
            String Amount = SearchTextOpp.Trim().replace(',','').replace('U','').replace('u','').replace('S','').replace('s','').replace('D','').replace('d','');
            SearchStringOpp_Amt = Double.valueOf(Amount);
        }
        Catch(Exception ex) {
            SearchStringOpp_Amt = -1;    // If complete string is passed it is set to -1 so as not to include this criteria.
        }
        AllOpportunityRecs = [Select Id, Name, AccountId, Account.Name, ownerid, Owner.Name, Owner.Id, tier_2_ge_og__c,tier_3_ge_og__c, pipeline_amount_ge_og__c, StageName, CloseDate from Opportunity where (AccountId in :AllAccountIds OR end_user_ge_og__c in :AllAccountIds) and StageName NOT IN('Closed Lost','Abandoned','Cancelled','Duplicate') and (Name like :SearchStringOpp or Account.Name like :SearchStringOpp or Owner.Name like :SearchStringOpp or tier_2_ge_og__c like :SearchStringOpp  or tier_3_ge_og__c like :SearchStringOpp or StageName like :SearchStringOpp or pipeline_amount_ge_og__c = :SearchStringOpp_Amt) ];
        TotalOppRecords = AllOpportunityRecs.size();
        NextCountOpp = 0;
    }
    // For fetching the next set of records
    Public void getNextOpp() {
        if(NextCountOpp+NoOfRows <= TotalOppRecords)
            NextCountOpp+=NoOfRows;
        else
            NextCountOpp= TotalOppRecords- NoOfRows;
    }
    Public void getPrevOpp() {
        if(NextCountOpp-NoOfRows >=0)
            NextCountOpp-=NoOfRows;
        else
            NextCountOpp=0;
    }
    Public void getFirstOpp() {
        NextCountOpp=0;
    }
    Public void getLastOpp() {
        NextCountOpp=TotalOppRecords- NoOfRows;
    }    
    
    
    

 Public List<GE_PRM_Channel_Appointment__c> getchanApptRecs() {
        // Make other tab variables= Null to reduce the view state size.
        AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringchanAppt='%%';     
        If((AllchanApptRecs == Null || AllchanApptRecs.size() == 0 ) && SearchStringchanAppt == '%%') { // If the variable is null, and no search is performed then fetch the records
            AllchanApptRecs = [Select Id, Name, GE_PRM_Account_Name__c, GE_PRM_Current_Status__c, GE_PRM_Tier_2_P_L__c, LastModifiedDate from GE_PRM_Channel_Appointment__c where GE_PRM_Account_Name__c IN :AllAccountIds Order by LastModifiedDate DESC ];
            TotalchanApptRecords = AllchanApptRecs.size();
        }
        
        if(AccountType=='My GE Accounts' && AllchanApptRecs != Null){
            List<GE_PRM_Channel_Appointment__c> myGEchanApptList = new List<GE_PRM_Channel_Appointment__c>();
            for(GE_PRM_Channel_Appointment__c chanApptObj: AllchanApptRecs )
                if(myGEAccountIds.contains(chanApptObj.GE_PRM_Account_Name__c))
                    myGEchanApptList.add(chanApptObj);
            if(myGEchanApptList.size()>0)
                AllchanApptRecs = myGEchanApptList;
            else
                AllchanApptRecs = new List<GE_PRM_Channel_Appointment__c>(); 
            TotalchanApptRecords = AllchanApptRecs.size();                               
        }
        
        // If no Channel Appointment records found return null
        If(AllchanApptRecs == Null || AllchanApptRecs.size() == 0)    return null;
            
        List<GE_PRM_Channel_Appointment__c> chanApptRecs = new List<GE_PRM_Channel_Appointment__c>();
        For(Integer i=0;i < NoOfRows && (NextCountchanAppt+i < TotalchanApptRecords); i++) {
            chanApptRecs.add(AllchanApptRecs[NextCountchanAppt+i]);
        }
        
        if(NextCountchanAppt <= 0) {
            hasFirstchanAppt=False;
            hasPrevchanAppt=False;
        }
        else {
            hasFirstchanAppt=True;
            hasPrevchanAppt=True;
        }
        if(NextCountchanAppt >= (TotalchanApptRecords - NoOfRows)) {
            hasLastchanAppt=False;
            hasNextchanAppt=False;
        }
        else {
            hasLastchanAppt=True;
            hasNextchanAppt=True;
        }

        StartRecchanAppt=(TotalchanApptRecords == 0)?0:NextCountchanAppt+1;
        if(StartRecchanAppt+NoOfRows >TotalchanApptRecords)
            EndRecchanAppt=TotalchanApptRecords;
        else
            EndRecchanAppt=StartRecchanAppt+NoOfRows-1;
        return chanApptRecs;
    }

    // Method to Search in Channel Appointment records
    Public void SearchchanAppt() {
        SearchStringchanAppt = '%'+SearchTextchanAppt.Trim()+'%';
        AllchanApptRecs = [Select Id, Name, GE_PRM_Account_Name__c, GE_PRM_Current_Status__c, GE_PRM_Tier_2_P_L__c, LastModifiedDate From GE_PRM_Channel_Appointment__c where GE_PRM_Account_Name__c in :AllAccountIds and (Name like :SearchStringchanAppt or GE_PRM_Account_Name__r.name like :SearchStringchanAppt or GE_PRM_Current_Status__c like :SearchStringchanAppt or GE_PRM_Tier_2_P_L__c like :SearchStringchanAppt ) Order by LastModifiedDate DESC];
        TotalchanApptRecords = AllchanApptRecs.size();
        NextCountchanAppt = 0;
    }
    
    // For fetching the next set of records
    Public void getNextchanAppt() {
        if(NextCountchanAppt+NoOfRows <= TotalchanApptRecords)
            NextCountchanAppt+=NoOfRows;
        else
            NextCountchanAppt= TotalchanApptRecords- NoOfRows;
    }
    // For Fetching the previous set of Channel Appointments
    Public void getPrevchanAppt() {
        if(NextCountchanAppt-NoOfRows >=0)
            NextCountchanAppt-=NoOfRows;
        else
            NextCountchanAppt=0;
    }
    // For fetching the first Set of records
    Public void getFirstchanAppt() {
        NextCountchanAppt=0;
    }
    // For fetching the last set of records
    Public void getLastchanAppt() {
        NextCountchanAppt=TotalchanApptRecords- NoOfRows;
    }
       
    
    
    
    
    
    // For Fetching Contact records related to Account
    Public List<Contact> getContactRecs()
    {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringContact='%%';
        If((AllContactRecs == Null || AllContactRecs.size() ==0) && SearchStringContact=='%%') {
            AllContactRecs=[select  Name, AccountId, Account.Name, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, Phone,GE_ES_Function__c from Contact where AccountId in :AllAccountids];
            TotalContactRecords = AllContactRecs.size();
        }
        
        if(AccountType=='My GE Accounts' && AllContactRecs != Null){
            List<Contact> myGEContactList = new List<Contact>();
            for(Contact conObj: AllContactRecs)
                if(myGEAccountIds.contains(conObj.AccountId))
                    myGEContactList.add(conObj);
            if(myGEContactList.size()>0)
                AllContactRecs = myGEContactList;
            else
                AllContactRecs = new List<Contact>(); 
            TotalContactRecords = AllContactRecs.size();                               
        }
        
        If(AllContactRecs == Null || AllContactRecs.size() == 0)    return null;
            
        List<Contact> ContactRecs = new List<Contact>();
        For(Integer i=0;i < NoOfRows && (NextCountContact+i < TotalContactRecords); i++) {
            ContactRecs.add(AllContactRecs[NextCountContact+i]);
        }
        
        if(NextCountContact <= 0){
            hasFirstContact=False;
            hasPrevContact=False;
        }
        else {
            hasFirstContact=True;
            hasPrevContact=True;
        }
        if(NextCountContact >= (TotalContactRecords - NoOfRows)) {
            hasLastContact=False;
            hasNextContact=False;
        }
        else {
            hasLastContact=True;
            hasNextContact=True;
        }

        StartRecContact=(TotalContactRecords == 0)?0:NextCountContact+1;
        if(StartRecContact+NoOfRows >TotalContactRecords)
            EndRecContact=TotalContactRecords;
        else
            EndRecContact=StartRecContact+NoOfRows-1;
        return ContactRecs;
    }
    
    // Method to Search in Contact records
    Public void SearchContact() {
        SearchStringContact = '%'+SearchTextContact.Trim()+'%';
        AllContactRecs=[Select  Name, AccountId, Account.Name, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, Phone,GE_ES_Function__c from Contact where AccountId in :AllAccountids and (Name Like :SearchStringContact or Account.Name Like :SearchStringContact or MailingStreet Like :SearchStringContact or MailingCity Like :SearchStringContact or MailingState Like :SearchStringContact or MailingPostalCode Like :SearchStringContact or MailingCountry Like :SearchStringContact or Phone Like :SearchStringContact or GE_ES_Function__c Like :SearchStringContact)];
        TotalContactRecords = AllContactRecs.size();
        NextCountContact = 0;
    }
    // For fetching the next set of records
    Public void getNextContact() {
        if(NextCountContact+NoOfRows <= TotalContactRecords)
            NextCountContact+=NoOfRows;
        else
            NextCountContact= TotalContactRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevContact() {
        if(NextCountContact-NoOfRows >=0)
            NextCountContact-=NoOfRows;
        else
            NextCountContact=0;
    }
    // For fetching the first Set of records
    Public void getFirstContact() {
        NextCountContact=0;
    }
    // For fetching the last set of records
    Public void getLastContact() {
        NextCountContact=TotalContactRecords- NoOfRows;
    }
    
    
    // For Fetching Contract records related to Account        
    Public List<Contract> getContractRecs()
    {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringContract='%%';
        If((AllContractRecs== Null ||AllContractRecs.size() == 0) && SearchStringContract=='%%' ) {
            AllContractRecs = [select Id, ContractNumber, Name, AccountId, Account.Name, StartDate, EndDate, Status,GE_ES_Agreement_Title__c,GE_HQ_Buss_Tier1__c,GE_HQ_Buss_Tier2__c from Contract where AccountId in :AllAccountids];
            TotalContractRecords = AllContractRecs.size();
        }
        
        //Code added for J Release to get only myGEAccounts related Contracts, R-7713 (S-05787) by Ramakrishna Kolluri on 22nd May 2012
        if(AccountType=='My GE Accounts' && AllContractRecs!= Null){
            List<Contract> myGEContractList = new List<Contract>();
            for(Contract contractObj: AllContractRecs)
                if(myGEAccountIds.contains(contractObj.AccountId))
                    myGEContractList.add(contractObj);
            if(myGEContractList.size()>0)
                AllContractRecs = myGEContractList;
            else
                AllContractRecs = new List<Contract>(); 
            TotalContractRecords = AllContractRecs.size();                               
        }
        //End of Code added for J Release to get only myGEAccounts related Contracts, R-7713 (S-05787) by Ramakrishna Kolluri        

        If(AllContractRecs== Null || AllContractRecs.size() == 0) return null;
            
        List<Contract> ContractRecs = new List<Contract>();
        For(Integer i=0;i < NoOfRows && (NextCountContract+i < TotalContractRecords); i++) {
            ContractRecs.add(AllContractRecs[NextCountContract+i]);
        }
        
        if(NextCountContract <= 0){
            hasFirstContract=False;
            hasPrevContract=False;
        }
        else {
            hasFirstContract=True;
            hasPrevContract=True;
        }
        if(NextCountContract >= (TotalContractRecords - NoOfRows)) {
            hasLastContract=False;
            hasNextContract=False;
        }
        else {
            hasLastContract=True;
            hasNextContract=True;
        }

        StartRecContract=(TotalContractRecords == 0)?0:NextCountContract+1;
        if(StartRecContract+NoOfRows >TotalContractRecords)
            EndRecContract=TotalContractRecords;
        else
            EndRecContract=StartRecContract+NoOfRows-1;
        return ContractRecs;
    }
    // Method to Search in Contract records
    Public void SearchContract() {
        SearchStringContract = '%'+SearchTextContract.Trim()+'%';
        AllContractRecs = [Select Id, ContractNumber, Name, AccountId, Account.Name, StartDate, EndDate, Status, GE_ES_Agreement_Title__c,GE_HQ_Buss_Tier1__c,GE_HQ_Buss_Tier2__c  from Contract where AccountId in :AllAccountids and (ContractNumber Like :SearchStringContract or Name Like :SearchStringContract or Account.Name Like :SearchStringContract or Status  Like :SearchStringContract or GE_ES_Agreement_Title__c Like :SearchStringContract )];
        TotalContractRecords = AllContractRecs.size();
        NextCountContract = 0;
    }
    // For fetching the next set of records
    Public void getNextContract() {
        if(NextCountContract+NoOfRows <= TotalContractRecords)
            NextCountContract+=NoOfRows;
        else
            NextCountContract= TotalContractRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevContract() {
        if(NextCountContract-NoOfRows >=0)
            NextCountContract-=NoOfRows;
        else
            NextCountContract=0;
    }
    // For fetching the first Set of records
    Public void getFirstContract() {
        NextCountContract=0;
    }
    // For fetching the last set of records
    Public void getLastContract() {
        NextCountContract=TotalContractRecords- NoOfRows;
    }
    
    
    // For Fetching IB records related to Account
    Public List<GE_Installed_Base__c> getIBRecs() {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringIB='%%';
        If((AllIBRecs == Null || AllIBRecs.size() ==0) && SearchStringIB=='%%') {
            AllIBRecs = [select Id, Name, Account__c, Account__r.Name, GE_ES_Technology__c,GE_ES_Station_Name__c,GE_ES_Equip_Model__c from GE_Installed_Base__c where Account__c in :AllAccountids and( GE_ES_Equipment_Status__c != 'Inactive' AND GE_ES_Status__c != 'Inactive') ];
            TotalIBRecords = AllIBRecs.size();
        }
        
        //Code added for J Release to get only myGEAccounts related IBs, R-7713 (S-05787) by Ramakrishna Kolluri on 22nd May 2012
        if(AccountType=='My GE Accounts' && AllIBRecs != Null){
            List<GE_Installed_Base__c> myGEIBsList = new List<GE_Installed_Base__c>();
            for(GE_Installed_Base__c IBObj: AllIBRecs)
                if(myGEAccountIds.contains(IBObj.Account__c))
                    myGEIBsList.add(IBObj);
            if(myGEIBsList.size()>0)
                AllIBRecs = myGEIBsList;
            else
                AllIBRecs = new List<GE_Installed_Base__c>(); 
            TotalIBRecords = AllIBRecs.size();                               
        }
        //End of Code added for J Release to get only myGEAccounts related IBs, R-7713 (S-05787) by Ramakrishna Kolluri        
        
        
        If(AllIBRecs == Null || AllIBRecs.size() == 0) return null;
            
        List<GE_Installed_Base__c> IBRecs = new List<GE_Installed_Base__c>();
        For(Integer i=0;i < NoOfRows && (NextCountIB+i < TotalIBRecords); i++) {
            IBRecs.add(AllIBRecs[NextCountIB+i]);
        }
        
        if(NextCountIB <= 0) {
            hasFirstIB=False;
            hasPrevIB=False;
        }
        else {
            hasFirstIB=True;
            hasPrevIB=True;
        }
        if(NextCountIB >= (TotalIBRecords - NoOfRows)) {
            hasLastIB=False;
            hasNextIB=False;
        }
        else {
            hasLastIB=True;
            hasNextIB=True;
        }

        StartRecIB=(TotalIBRecords == 0)?0:NextCountIB+1;
        if(StartRecIB+NoOfRows >TotalIBRecords)
            EndRecIB=TotalIBRecords;
        else
            EndRecIB=StartRecIB+NoOfRows-1;
        return IBRecs;
    }
    // Method to Search in IB records
    Public void SearchIB() {
        SearchStringIB = '%'+SearchTextIB.Trim()+'%';
        AllIBRecs = [Select Id, Name, Account__c, Account__r.Name, GE_ES_Technology__c,GE_ES_Station_Name__c,GE_ES_Equip_Model__c from GE_Installed_Base__c where Account__c in :AllAccountids and (GE_ES_Equipment_Status__c != 'Inactive' AND GE_ES_Status__c != 'Inactive') and (Name Like :SearchStringIB or Account__r.Name Like :SearchStringIB or GE_ES_Technology__c Like :SearchStringIB or GE_ES_Station_Name__c Like :SearchStringIB or GE_ES_Equip_Model__c Like :SearchStringIB)];
        TotalIBRecords = AllIBRecs.size();
        NextCountIB = 0;
    }
    // For fetching the next set of records
    Public void getNextIB() {
        if(NextCountIB+NoOfRows <= TotalIBRecords)
            NextCountIB+=NoOfRows;
        else
            NextCountIB= TotalIBRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevIB() {
        if(NextCountIB-NoOfRows >=0)
            NextCountIB-=NoOfRows;
        else
            NextCountIB=0;
    }
    // For fetching the first Set of records
    Public void getFirstIB() {
        NextCountIB=0;
    }
    // For fetching the last set of records
    Public void getLastIB(){
        NextCountIB=TotalIBRecords- NoOfRows;
    }
    

    // For Fetching Account team member records
    Public List<AccountTeamMember> getATMRecs() {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringATM='%%';
        If((AllATMRecs == Null || AllATMRecs.size() ==0) && SearchStringATM=='%%') {
            AllATMRecs = [Select Id,UserId, TeamMemberRole, AccountId, Account.name From AccountTeamMember where AccountId in :AllAccountids];
            TotalATMRecords = AllATMRecs.size();
        }
        
        //Code added for J Release to get only myGEAccounts related AccountTeamMembers, R-7713 (S-05787) by Ramakrishna Kolluri on 22nd May 2012
        if(AccountType=='My GE Accounts' && AllATMRecs != Null){
            List<AccountTeamMember> myGEATMsList = new List<AccountTeamMember>();
            for(AccountTeamMember ATMObj: AllATMRecs)
                if(myGEAccountIds.contains(ATMObj.AccountId))
                    myGEATMsList.add(ATMObj);
            if(myGEATMsList.size()>0)
                AllATMRecs = myGEATMsList;
            else
                AllATMRecs = new List<AccountTeamMember>(); 
            TotalATMRecords = AllATMRecs.size();                               
        }
        //End of Code added for J Release to get only myGEAccounts related AccountTeamMembers, R-7713 (S-05787) by Ramakrishna Kolluri        
        
        If(AllATMRecs == Null || AllATMRecs.size() == 0) return null;
            
        List<AccountTeamMember> ATMRecs = new List<AccountTeamMember>();
        For(Integer i=0;i < NoOfRows && (NextCountATM+i < TotalATMRecords); i++) {
            ATMRecs.add(AllATMRecs[NextCountATM+i]);
        }
        
        if(NextCountATM <= 0) {
            hasFirstATM=False;
            hasPrevATM=False;
        }
        else {
            hasFirstATM=True;
            hasPrevATM=True;
        }
        if(NextCountATM >= (TotalATMRecords - NoOfRows)) {
            hasLastATM=False;
            hasNextATM=False;
        }
        else {
            hasLastATM=True;
            hasNextATM=True;
        }

        StartRecATM=(TotalATMRecords == 0)?0:NextCountATM+1;
        if(StartRecATM+NoOfRows >TotalATMRecords)
            EndRecATM=TotalATMRecords;
        else
            EndRecATM=StartRecATM+NoOfRows-1;
        return ATMRecs;
    }
    // Method to Search in Account Team Member records
    Public void SearchATM() {
        SearchStringATM = '%'+SearchTextATM.Trim()+'%';
        AllATMRecs = [Select Id,UserId, TeamMemberRole, AccountId, Account.name From AccountTeamMember where AccountId in :AllAccountids and (User.name Like :SearchStringATM or TeamMemberRole Like :SearchStringATM or Account.name Like :SearchStringATM )];
        TotalATMRecords = AllATMRecs.size();
        NextCountATM = 0;
    }
    // For fetching the next set of records
    Public void getNextATM() {
        if(NextCountATM+NoOfRows <= TotalATMRecords)
            NextCountATM+=NoOfRows;
        else
            NextCountATM= TotalATMRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevATM() {
        if(NextCountATM-NoOfRows >=0)
            NextCountATM-=NoOfRows;
        else
            NextCountATM=0;
    }
    // For fetching the first Set of records
    Public void getFirstATM() {
        NextCountATM=0;
    }
    // For fetching the last set of records
    Public void getLastATM() {
        NextCountATM=TotalATMRecords- NoOfRows;
    }
    
    
    // For Fetching Task records related to Account
    Public List<Task> getTaskRecs() {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringTask='%%';
        If((AllTaskRecs == Null || AllTaskRecs.size() ==0) && SearchStringTask=='%%' ) {
            AllTaskRecs =  [Select Id, AccountId, Account.name, Subject, WhoId, WhatId, Priority, ActivityDate, Status from task where AccountId in :AllAccountids];
            TotalTaskRecords = AllTaskRecs.size();
        }
        
        //Code added for J Release to get only myGEAccounts related Tasks, R-7713 (S-05787) by Ramakrishna Kolluri on 22nd May 2012
        if(AccountType=='My GE Accounts' && AllTaskRecs != Null){
            List<Task> myGETasksList = new List<Task>();
            for(Task TaskObj: AllTaskRecs)
                if(myGEAccountIds.contains(TaskObj.AccountId))
                    myGETasksList.add(TaskObj);
            if(myGETasksList.size()>0)
                AllTaskRecs = myGETasksList;
            else
                AllTaskRecs = new List<Task>(); 
            TotalTaskRecords = AllTaskRecs.size();                               
        }
        //End of Code added for J Release to get only myGEAccounts related Tasks, R-7713 (S-05787) by Ramakrishna Kolluri        
        

        If(AllTaskRecs == Null || AllTaskRecs.size() == 0) return null;
            
        List<Task> TaskRecs = new List<Task>();
        For(Integer i=0;i < NoOfRows && (NextCountTask+i < TotalTaskRecords); i++) {
            TaskRecs.add(AllTaskRecs[NextCountTask+i]);
        }
        
        if(NextCountTask <= 0) {
            hasFirstTask=False;
            hasPrevTask=False;
        }
        else {
            hasFirstTask=True;
            hasPrevTask=True;
        }
        if(NextCountTask >= (TotalTaskRecords - NoOfRows)) {
            hasLastTask=False;
            hasNextTask=False;
        }
        else {
            hasLastTask=True;
            hasNextTask=True;
        }

        StartRecTask=(TotalTaskRecords == 0)?0:NextCountTask+1;
        if(StartRecTask+NoOfRows >TotalTaskRecords)
            EndRecTask=TotalTaskRecords;
        else
            EndRecTask=StartRecTask+NoOfRows-1;
        return TaskRecs;
    }
    
    Public void SearchTask() {
        SearchStringTask = '%'+SearchTextTask.Trim()+'%';
        AllTaskRecs =  [Select Id, AccountId, Account.name, Subject, WhoId, WhatId, Priority, ActivityDate, Status from task where AccountId in :AllAccountids and (Account.name Like :SearchStringTask or Subject Like :SearchStringTask or Priority Like :SearchStringTask or Status Like :SearchStringTask or What.name Like :SearchStringTask or Who.name Like :SearchStringTask)];
        TotalTaskRecords = AllTaskRecs.size();
        NextCountTask = 0;
    }
    // For fetching the next set of records
    Public void getNextTask() {
        if(NextCountTask+NoOfRows <= TotalTaskRecords)
            NextCountTask+=NoOfRows;
        else
            NextCountTask= TotalTaskRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevTask() {
        if(NextCountTask-NoOfRows >=0)
            NextCountTask-=NoOfRows;
        else
            NextCountTask=0;
    }
    // For fetching the first Set of records
    Public void getFirstTask() {
        NextCountTask=0;
    }
    // For fetching the last set of records
    Public void getLastTask() {
        NextCountTask=TotalTaskRecords- NoOfRows;
    }
      


    // For Fetching Event records related to Account
    Public List<Event> getEventRecs() {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllProjectRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringEvent='%%';
        If((AllEventRecs == Null || AllEventRecs.size() ==0 ) && SearchStringEvent=='%%' ) {
            AllEventRecs = [Select Id, AccountId, Account.name, Subject, WhoId, WhatId, StartDateTime, EndDateTime, OwnerId from Event where AccountId in :AllAccountids];
            TotalEventRecords = AllEventRecs.size();
        }
        
        //Code added for J Release to get only myGEAccounts related Events, R-7713 (S-05787) by Ramakrishna Kolluri on 22nd May 2012
        if(AccountType=='My GE Accounts' && AllEventRecs != Null){
            List<Event> myGEEventsList = new List<Event>();
            for(Event EventObj: AllEventRecs)
                if(myGEAccountIds.contains(EventObj.AccountId))
                    myGEEventsList.add(EventObj);
            if(myGEEventsList.size()>0)
                AllEventRecs = myGEEventsList;
            else
                AllEventRecs = new List<Event>(); 
            TotalEventRecords = AllEventRecs.size();                               
        }
        //End of Code added for J Release to get only myGEAccounts related Events, R-7713 (S-05787) by Ramakrishna Kolluri        
        
        
        If(AllEventRecs == Null || AllEventRecs.size() == 0) return null;
            
        List<Event> EventRecs = new List<Event>();
        For(Integer i=0;i < NoOfRows && (NextCountEvent+i < TotalEventRecords); i++) {
            EventRecs.add(AllEventRecs[NextCountEvent+i]);
        }
        
        if(NextCountEvent <= 0) {
            hasFirstEvent=False;
            hasPrevEvent=False;
        }
        else {
            hasFirstEvent=True;
            hasPrevEvent=True;
        }
        if(NextCountEvent >= (TotalEventRecords - NoOfRows)) {
            hasLastEvent=False;
            hasNextEvent=False;
        }
        else {
            hasLastEvent=True;
            hasNextEvent=True;
        }

        StartRecEvent=(TotalEventRecords == 0)?0:NextCountEvent+1;
        if(StartRecEvent+NoOfRows >TotalEventRecords)
            EndRecEvent=TotalEventRecords;
        else
            EndRecEvent=StartRecEvent+NoOfRows-1;
        return EventRecs;
    }
    // Method to Search in Event records
    Public void SearchEvent() {
        SearchStringEvent = '%'+SearchTextEvent.Trim()+'%';
        AllEventRecs = [Select Id, AccountId, Account.name, Subject, WhoId, WhatId, StartDateTime, EndDateTime, OwnerId from Event where AccountId in :AllAccountids and (Account.name Like :SearchStringEvent or Subject Like :SearchStringEvent or Owner.name Like :SearchStringEvent or What.name Like :SearchStringEvent)];
        TotalEventRecords = AllEventRecs.size();
        NextCountEvent = 0;
    }
    // For fetching the next set of records
    Public void getNextEvent() {
        if(NextCountEvent+NoOfRows <= TotalEventRecords)
            NextCountEvent+=NoOfRows;
        else
            NextCountEvent= TotalEventRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevEvent() {
        if(NextCountEvent-NoOfRows >=0)
            NextCountEvent-=NoOfRows;
        else
            NextCountEvent=0;
    }
    // For fetching the first Set of records
    Public void getFirstEvent() {
        NextCountEvent=0;
    }
    // For fetching the last set of records
    Public void getLastEvent() {
        NextCountEvent=TotalEventRecords- NoOfRows;
    }


    // For Fetching Project records related to Account
    Public List<Project_ge_og__c> getProjectRecs()
    {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllCaseRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringProject='%%';
        If((AllProjectRecs == Null || AllProjectRecs.size() ==0) && SearchStringProject=='%%' ) {
            AllProjectRecs = [Select Id, Name, GE_ES_Account__c, GE_ES_Account_Region__c, GE_ES_Installed_Base_SN__c, GE_ES_Tier_2_P_L__c, RecordTypeId, OwnerId, GE_ES_Outage_Start_Date__c from Project_ge_og__c where GE_ES_Account__c in :AllAccountids];
            TotalProjectRecords = AllProjectRecs.size();
        }

        //Code added for J Release to get only myGEAccounts related Projects, R-7713 (S-05787) by Ramakrishna Kolluri on 22nd May 2012
        if(AccountType=='My GE Accounts' && AllProjectRecs != Null){
            List<Project_ge_og__c> myGEProjectsList = new List<Project_ge_og__c>();
            for(Project_ge_og__c ProjObj: AllProjectRecs)
                if(myGEAccountIds.contains(ProjObj.GE_ES_Account__c))
                    myGEProjectsList.add(ProjObj);
            if(myGEProjectsList.size()>0)
                AllProjectRecs = myGEProjectsList;
            else
                AllProjectRecs = new List<Project_ge_og__c>(); 
            TotalProjectRecords = AllProjectRecs.size();                               
        }
        //End of Code added for J Release to get only myGEAccounts related Projects, R-7713 (S-05787) by Ramakrishna Kolluri        

        If(AllProjectRecs == Null || AllProjectRecs.size() == 0) return null;
            
        List<Project_ge_og__c> ProjectRecs = new List<Project_ge_og__c>();
        For(Integer i=0;i < NoOfRows && (NextCountProject+i < TotalProjectRecords); i++) {
            ProjectRecs.add(AllProjectRecs[NextCountProject+i]);
        }
        
        if(NextCountProject <= 0) {
            hasFirstProject=False;
            hasPrevProject=False;
        }
        else {
            hasFirstProject=True;
            hasPrevProject=True;
        }
        if(NextCountProject >= (TotalProjectRecords - NoOfRows)) {
            hasLastProject=False;
            hasNextProject=False;
        }
        else {
            hasLastProject=True;
            hasNextProject=True;
        }

        StartRecProject=(TotalProjectRecords == 0)?0:NextCountProject+1;
        if(StartRecProject+NoOfRows >TotalProjectRecords)
            EndRecProject=TotalProjectRecords;
        else
            EndRecProject=StartRecProject+NoOfRows-1;
        return ProjectRecs;
    }
    // Method to Search in Project records
    Public void SearchProject() {
        SearchStringProject = '%'+SearchTextProject.Trim()+'%';
        AllProjectRecs = [Select Id, Name, GE_ES_Account__c, GE_ES_Account_Region__c, GE_ES_Installed_Base_SN__c, GE_ES_Tier_2_P_L__c, RecordTypeId, OwnerId, GE_ES_Outage_Start_Date__c from Project_ge_og__c where GE_ES_Account__c in :AllAccountids and (Name Like :SearchStringProject or GE_ES_Account__r.Name Like :SearchStringProject or GE_ES_Account_Region__c Like :SearchStringProject or GE_ES_Installed_Base_SN__c Like :SearchStringProject or GE_ES_Tier_2_P_L__c Like :SearchStringProject or RecordType.Name Like :SearchStringProject or Owner.Name Like :SearchStringProject)];
        TotalProjectRecords = AllProjectRecs.size();
        NextCountProject = 0;
    }
    // For fetching the next set of records
    Public void getNextProject() {
        if(NextCountProject+NoOfRows <= TotalProjectRecords)
            NextCountProject+=NoOfRows;
        else
            NextCountProject= TotalProjectRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevProject() {
        if(NextCountProject-NoOfRows >=0)
            NextCountProject-=NoOfRows;
        else
            NextCountProject=0;
    }
    // For fetching the first Set of records
    Public void getFirstProject() {
        NextCountProject=0;
    }
    // For fetching the last set of records
    Public void getLastProject() {
        NextCountProject=TotalProjectRecords- NoOfRows;
    }


    // For Fetching Case records related to Account
    Public List<Case> getCaseRecs() {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringCase='%%';
        If((AllCaseRecs == Null || AllCaseRecs.size() ==0) && SearchStringCase=='%%') {
            AllCaseRecs = [Select Id, RecordTypeId, CaseNumber, AccountId, ContactId, Subject, Status, Priority, CreatedDate, OwnerId, GE_HQ_Business_Tier1__c,GE_HQ_Business_Tier2__c,GE_Tier_3__c From Case where AccountId in :AllAccountids];
            TotalCaseRecords = AllCaseRecs.size();
        }
        
        //Code added for J Release to get only myGEAccounts related Cases, R-7713 (S-05787) by Ramakrishna Kolluri on 22nd May 2012
        if(AccountType=='My GE Accounts' && AllCaseRecs != Null){
            List<Case> myGECasesList = new List<Case>();
            for(Case caseObj: AllCaseRecs)
                if(myGEAccountIds.contains(caseObj.AccountId))
                    myGECasesList.add(caseObj);
            if(myGECasesList.size()>0)
                AllCaseRecs = myGECasesList;
            else
                AllCaseRecs = new List<Case>(); 
            TotalCaseRecords = AllCaseRecs.size();                               
        }
        //End of Code added for J Release to get only myGEAccounts related Cases, R-7713 (S-05787) by Ramakrishna Kolluri        
        
        If(AllCaseRecs == Null || AllCaseRecs.size() == 0) return null;
            
        List<Case> CaseRecs = new List<Case>();
        For(Integer i=0;i < NoOfRows && (NextCountCase+i < TotalCaseRecords); i++) {
            CaseRecs.add(AllCaseRecs[NextCountCase+i]);
        }
        
        if(NextCountCase <= 0) {
            hasFirstCase=False;
            hasPrevCase=False;
        }
        else {
            hasFirstCase=True;
            hasPrevCase=True;
        }
        if(NextCountCase >= (TotalCaseRecords - NoOfRows)) {
            hasLastCase=False;
            hasNextCase=False;
        }
        else {
            hasLastCase=True;
            hasNextCase=True;
        }

        StartRecCase=(TotalCaseRecords == 0)?0:NextCountCase+1;
        if(StartRecCase+NoOfRows >TotalCaseRecords)
            EndRecCase=TotalCaseRecords;
        else
            EndRecCase=StartRecCase+NoOfRows-1;
        return CaseRecs;
    }
    // Method to Search in Account records
    Public void SearchCase() {
        SearchStringCase = '%'+SearchTextCase.Trim()+'%';
        AllCaseRecs = [Select Id, RecordTypeId, CaseNumber, AccountId, ContactId, Subject, Status, Priority, CreatedDate, OwnerId, GE_HQ_Business_Tier1__c,GE_HQ_Business_Tier2__c,GE_Tier_3__c From Case where AccountId in :AllAccountids and (CaseNumber Like :SearchStringCase or Contact.Name Like :SearchStringCase or Subject Like :SearchStringCase or Status Like :SearchStringCase or Priority Like :SearchStringCase or Owner.Name Like :SearchStringCase or GE_HQ_Business_Tier1__c Like :SearchStringCase)];
        TotalCaseRecords = AllCaseRecs.size();
        NextCountCase = 0;
    }
    // For fetching the next set of records
    Public void getNextCase() {
        if(NextCountCase+NoOfRows <= TotalCaseRecords)
            NextCountCase+=NoOfRows;
        else
            NextCountCase= TotalCaseRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevCase() {
        if(NextCountCase-NoOfRows >=0)
            NextCountCase-=NoOfRows;
        else
            NextCountCase=0;
    }
    // For fetching the first Set of records
    Public void getFirstCase() {
        NextCountCase=0;
    }
    // For fetching the last set of records
    Public void getLastCase() {
        NextCountCase=TotalCaseRecords- NoOfRows;
    }
    
/*    
    // For Fetching AEPlan records
    Public List<GE_HQ_Account_Plan__c> getAEPlanRecs() {
        // Make other variables= Null to reduce the view state size.
        AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringCase='%%';
        If((AllAEPlanRecs == Null || AllAEPlanRecs.size() ==0) && SearchStringAEPlan=='%%') {
            //dduns = [select id, GE_HQ_DDUNS_fm__c from GE_HQ_Account_Plan__c where Id =:  AccPlanningId].GE_HQ_DDUNS_fm__c;
            List<RecordType> recTypeList = [select id, name from RecordType where sObjectType='GE_HQ_Account_Plan__c' and developername='AE_Account_Plan'];
            System.debug('****RecordType List****'+recTypeList);
            System.debug('****dduns****'+dduns);
            if(dduns!=null){
                AllAEPlanRecs = [Select Id, Name, GE_HQ_Buss_Tier__c, GE_HQ_Buss_Tier1__c, GE_HQ_DDUNS_Number__c, GE_HQ_DDUNS_fm__c, GE_HQ_Pb_Long_Term__c, GE_HQ_Pb_Short_Term__c, LastModifiedById  from GE_HQ_Account_Plan__c where GE_HQ_DDUNS_fm__c =: dduns and RecordTypeId in: recTypeList and Id !=: AccPlanningId order by name limit 50000];
                TotalAEPlanRecords = AllAEPlanRecs.size();
            }                
        }
        
        
        If(AllAEPlanRecs == Null || AllAEPlanRecs.size() == 0) return null;
            
        List<GE_HQ_Account_Plan__c> AEPlanRecs = new List<GE_HQ_Account_Plan__c>();
        For(Integer i=0;i < NoOfRows && (NextCountAEPlan+i < TotalAEPlanRecords); i++) {
           AEPlanRecs.add(AllAEPlanRecs[NextCountAEPlan+i]);
        }
        
        if(NextCountAEPlan <= 0) {
            hasFirstAEPlan=False;
            hasPrevAEPlan=False;
        }
        else {
            hasFirstAEPlan=True;
            hasPrevAEPlan=True;
        }
        if(NextCountAEPlan >= (TotalAEPlanRecords - NoOfRows)) {
            hasLastAEPlan=False;
            hasNextAEPlan=False;
        }
        else {
            hasLastAEPlan=True;
            hasNextAEPlan=True;
        }

        StartRecAEPlan=(TotalAEPlanRecords == 0)?0:NextCountAEPlan+1;
        if(StartRecAEPlan+NoOfRows >TotalAEPlanRecords)
            EndRecAEPlan=TotalAEPlanRecords;
        else
            EndRecAEPlan=StartRecAEPlan+NoOfRows-1;
        return AEPlanRecs;
    }
    // Method to Search in Account records
    Public void SearchAEPlan() {
        SearchStringAEPlan = '%'+SearchTextAEPlan.Trim()+'%';
        List<RecordType> recTypeList = [select id, name from RecordType where sObjectType='GE_HQ_Account_Plan__c' and developername='AE_Account_Plan'];
        if(dduns!=null){
            AllAEPlanRecs = [Select Id, Name, GE_HQ_Buss_Tier__c, GE_HQ_Buss_Tier1__c, GE_HQ_DDUNS_Number__c, GE_HQ_DDUNS_fm__c, GE_HQ_Pb_Long_Term__c, GE_HQ_Pb_Short_Term__c, LastModifiedById  from GE_HQ_Account_Plan__c where GE_HQ_DDUNS_fm__c =: dduns and RecordTypeId in: recTypeList and Id !=: AccPlanningId and (Name Like :SearchStringAEPlan or GE_HQ_Buss_Tier__c Like :SearchStringAEPlan or GE_HQ_DDUNS_fm__c Like :SearchStringAEPlan or  LastModifiedBy.name like :SearchStringAEPlan or GE_HQ_DDUNS_Number__r.name like :SearchStringAEPlan) order by name limit 50000];
            TotalAEPlanRecords = AllAEPlanRecs.size();
        }            
        NextCountAEPlan = 0;
    }
    
    // For fetching the next set of records
    Public void getNextAEPlan() {
        if(NextCountAEPlan+NoOfRows <= TotalAEPlanRecords)
            NextCountAEPlan+=NoOfRows;
        else
            NextCountAEPlan= TotalAEPlanRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevAEPlan() {
        if(NextCountAEPlan-NoOfRows >=0)
            NextCountAEPlan-=NoOfRows;
        else
            NextCountAEPlan=0;
    }
    // For fetching the first Set of records
    Public void getFirstAEPlan() {
        NextCountAEPlan=0;
    }
    // For fetching the last set of records
    Public void getLastAEPlan() {
        NextCountAEPlan=TotalAEPlanRecords- NoOfRows;
    }
   
    // For Fetching EnergyPlan records
    Public List<GE_HQ_Account_Plan__c> getEnergyPlanRecs() {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllAEPlanRecs = null;   AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringCase='%%';
        If((AllEnergyPlanRecs == Null || AllEnergyPlanRecs.size() ==0) && SearchStringEnergyPlan=='%%') {
            //String dduns = [select id, GE_HQ_DDUNS_fm__c from GE_HQ_Account_Plan__c where Id =:  AccPlanningId].GE_HQ_DDUNS_fm__c;

            if(AllAccountids.size()>0)
                for(GE_HQ_Acc_AccPlan_Rel__c myGEAccountObj: [select id, GE_HQ_Account_Plan__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account__c in: AllAccountids limit 50000])
                   EnergyPlanIds.add(myGEAccountObj.GE_HQ_Account_Plan__c);
                    
            List<RecordType> recTypeList = [select id, name from RecordType where sObjectType='GE_HQ_Account_Plan__c' and (developername='GE_Energy_Plan' or developername='ES_Account_Plan')];
            System.debug('****RecordType List****'+recTypeList);
            
            if( EnergyPlanIds.size()>0){
                AllEnergyPlanRecs = [Select Id, Name, GE_HQ_Buss_Tier__c, GE_HQ_Buss_Tier1__c, GE_HQ_DDUNS_Number__c, GE_HQ_DDUNS_fm__c, GE_HQ_Pb_Long_Term__c, GE_HQ_Pb_Short_Term__c, LastModifiedById from GE_HQ_Account_Plan__c where RecordTypeId in: recTypeList and Id !=: AccPlanningId and Id in: EnergyPlanIds order by name limit 50000];
                TotalEnergyPlanRecords = AllEnergyPlanRecs.size();
            }                

        }

        if(AccountType=='My GE Accounts' && AllEnergyPlanRecs != Null){
            EnergyPlanIds = new Set<Id>();
            Set<Id> myGEAccs = new Set<Id>();
            if(AllAccountids.size()>0){
                for(Id myGEaccId : AllAccountids)
                    if(myGEAccountIds.contains(myGEaccId))
                        myGEAccs.add(myGEaccId);
            }                               
            if(myGEAccs.size()>0){                        
                for(GE_HQ_Acc_AccPlan_Rel__c myGEAccountObj: [select id, GE_HQ_Account_Plan__c, GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account__c in: myGEAccs limit 50000])
                   EnergyPlanIds.add(myGEAccountObj.GE_HQ_Account_Plan__c);
                            
            }
            
            List<GE_HQ_Account_Plan__c> myGEEnergyPlansList = new List<GE_HQ_Account_Plan__c>();
            for(GE_HQ_Account_Plan__c accPlanObj: AllEnergyPlanRecs)
                if(EnergyPlanIds.contains(accPlanObj.Id))
                    myGEEnergyPlansList.add(accPlanObj);
            if(myGEEnergyPlansList.size()>0)
                AllEnergyPlanRecs = myGEEnergyPlansList;
            else
                AllEnergyPlanRecs = new List<GE_HQ_Account_Plan__c>(); 
            TotalEnergyPlanRecords = AllEnergyPlanRecs.size();                               
                    
        }
        
        
        If(AllEnergyPlanRecs == Null || AllEnergyPlanRecs.size() == 0) return null;
            
        List<GE_HQ_Account_Plan__c> EnergyPlanRecs = new List<GE_HQ_Account_Plan__c>();
        For(Integer i=0;i < NoOfRows && (NextCountEnergyPlan+i < TotalEnergyPlanRecords); i++) {
           EnergyPlanRecs.add(AllEnergyPlanRecs[NextCountEnergyPlan+i]);
        }
        
        if(NextCountEnergyPlan <= 0) {
            hasFirstEnergyPlan=False;
            hasPrevEnergyPlan=False;
        }
        else {
            hasFirstEnergyPlan=True;
            hasPrevEnergyPlan=True;
        }
        if(NextCountEnergyPlan >= (TotalEnergyPlanRecords - NoOfRows)) {
            hasLastEnergyPlan=False;
            hasNextEnergyPlan=False;
        }
        else {
            hasLastEnergyPlan=True;
            hasNextEnergyPlan=True;
        }

        StartRecEnergyPlan=(TotalEnergyPlanRecords == 0)?0:NextCountEnergyPlan+1;
        if(StartRecEnergyPlan+NoOfRows >TotalEnergyPlanRecords)
            EndRecEnergyPlan=TotalEnergyPlanRecords;
        else
            EndRecEnergyPlan=StartRecEnergyPlan+NoOfRows-1;
        return EnergyPlanRecs;
    }
    // Method to Search in EnergyPlan records
    Public void SearchEnergyPlan() {
        SearchStringEnergyPlan = '%'+SearchTextEnergyPlan.Trim()+'%';
        List<RecordType> recTypeList = [select id, name from RecordType where sObjectType='GE_HQ_Account_Plan__c' and (developername='GE_Energy_Plan' or developername='ES_Account_Plan')];
        if(EnergyPlanIds.size()>0){
            AllEnergyPlanRecs = [Select Id, Name, GE_HQ_Buss_Tier__c, GE_HQ_Buss_Tier1__c, GE_HQ_DDUNS_Number__c, GE_HQ_DDUNS_fm__c, GE_HQ_Pb_Long_Term__c, GE_HQ_Pb_Short_Term__c, LastModifiedById from GE_HQ_Account_Plan__c where RecordTypeId in: recTypeList and Id !=: AccPlanningId and Id in: EnergyPlanIds and (Name Like :SearchStringEnergyPlan or GE_HQ_Buss_Tier__c Like :SearchStringEnergyPlan or GE_HQ_DDUNS_fm__c Like :SearchStringEnergyPlan or  LastModifiedBy.name like :SearchStringEnergyPlan or GE_HQ_DDUNS_Number__r.name like :SearchStringEnergyPlan) order by name limit 50000];
            TotalEnergyPlanRecords = AllEnergyPlanRecs.size();
        }                
        NextCountEnergyPlan = 0;
    }
    // For fetching the next set of records
    Public void getNextEnergyPlan() {
        if(NextCountEnergyPlan+NoOfRows <= TotalEnergyPlanRecords)
            NextCountEnergyPlan+=NoOfRows;
        else
            NextCountEnergyPlan= TotalEnergyPlanRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevEnergyPlan() {
        if(NextCountEnergyPlan-NoOfRows >=0)
            NextCountEnergyPlan-=NoOfRows;
        else
            NextCountEnergyPlan=0;
    }
    // For fetching the first Set of records
    Public void getFirstEnergyPlan() {
        NextCountEnergyPlan=0;
    }
    // For fetching the last set of records
    Public void getLastEnergyPlan() {
        NextCountEnergyPlan=TotalEnergyPlanRecords- NoOfRows;
    }
    
    // For Fetching PRMPlan records
    Public List<GE_HQ_Account_Plan__c> getPRMPlanRecs() {
        // Make other variables= Null to reduce the view state size.
        AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null; AllFieldOfPlayRecs = null;  AllPlanActivityRecs = null;
        //SearchStringCase='%%';
        If((AllPRMPlanRecs == Null || AllPRMPlanRecs.size() ==0) && SearchStringPRMPlan=='%%') {
            //String dduns = [select id, GE_HQ_DDUNS_fm__c from GE_HQ_Account_Plan__c where Id =:  AccPlanningId].GE_HQ_DDUNS_fm__c;
            if(AllAccountids.size()>0)
                for(GE_HQ_Acc_AccPlan_Rel__c myGEAccountObj: [select id, GE_HQ_Account_Plan__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account__c in: AllAccountids limit 50000])
                    prmAccountPlanIds.add(myGEAccountObj.GE_HQ_Account_Plan__c);
                    
            List<RecordType> recTypeList = [select id, name from RecordType where sObjectType='GE_HQ_Account_Plan__c' and (developername='GE_PRM_Business_Plan')];
            System.debug('****RecordType List****'+recTypeList);
            
            if(prmAccountPlanIds.size()>0){
                AllPRMPlanRecs = [Select Id, Name, GE_HQ_Buss_Tier__c, GE_HQ_Buss_Tier1__c, GE_PRM_Tier_1__c,  GE_HQ_DDUNS_Number__c, GE_HQ_DDUNS_fm__c, GE_HQ_Pb_Long_Term__c, GE_HQ_Pb_Short_Term__c, LastModifiedById, GE_PRM_Status__c  from GE_HQ_Account_Plan__c where RecordTypeId in: recTypeList and Id !=: AccPlanningId and Id in: prmAccountPlanIds and GE_PRM_Status__c ='Approved' order by name limit 50000];
                TotalPRMPlanRecords = AllPRMPlanRecs.size();
            }                
        }
        
        if(AccountType=='My GE Accounts' && AllPRMPlanRecs != Null){
            prmAccountPlanIds = new Set<Id>();
            Set<Id> myGEAccs = new Set<Id>();
            if(AllAccountids.size()>0){
                for(Id myGEaccId : AllAccountids)
                    if(myGEAccountIds.contains(myGEaccId))
                        myGEAccs.add(myGEaccId);
            }                               
            if(myGEAccs.size()>0){                        
                for(GE_HQ_Acc_AccPlan_Rel__c myGEAccountObj: [select id, GE_HQ_Account_Plan__c, GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account__c in: myGEAccs limit 50000])
                   prmAccountPlanIds.add(myGEAccountObj.GE_HQ_Account_Plan__c);
                            
            }
            
            List<GE_HQ_Account_Plan__c> myGEPRMPlansList = new List<GE_HQ_Account_Plan__c>();
            for(GE_HQ_Account_Plan__c accPlanObj: AllPRMPlanRecs)
                if(prmAccountPlanIds.contains(accPlanObj.Id))
                    myGEPRMPlansList.add(accPlanObj);
            if(myGEPRMPlansList.size()>0)
                AllPRMPlanRecs = myGEPRMPlansList;
            else
                AllPRMPlanRecs = new List<GE_HQ_Account_Plan__c>(); 
            TotalPRMPlanRecords = AllPRMPlanRecs.size();                               
                    
        }
        
        If(AllPRMPlanRecs == Null || AllPRMPlanRecs.size() == 0) return null;
            
        List<GE_HQ_Account_Plan__c> PRMPlanRecs = new List<GE_HQ_Account_Plan__c>();
        For(Integer i=0;i < NoOfRows && (NextCountPRMPlan+i < TotalPRMPlanRecords); i++) {
           PRMPlanRecs.add(AllPRMPlanRecs[NextCountPRMPlan+i]);
        }
        
        if(NextCountPRMPlan <= 0) {
            hasFirstPRMPlan=False;
            hasPrevPRMPlan=False;
        }
        else {
            hasFirstPRMPlan=True;
            hasPrevPRMPlan=True;
        }
        if(NextCountPRMPlan >= (TotalPRMPlanRecords - NoOfRows)) {
            hasLastPRMPlan=False;
            hasNextPRMPlan=False;
        }
        else {
            hasLastPRMPlan=True;
            hasNextPRMPlan=True;
        }

        StartRecPRMPlan=(TotalPRMPlanRecords == 0)?0:NextCountPRMPlan+1;
        if(StartRecPRMPlan+NoOfRows >TotalPRMPlanRecords)
            EndRecPRMPlan=TotalPRMPlanRecords;
        else
            EndRecPRMPlan=StartRecPRMPlan+NoOfRows-1;
        return PRMPlanRecs;
    }
    // Method to Search in Account records
    Public void SearchPRMPlan() {
        SearchStringPRMPlan = '%'+SearchTextPRMPlan.Trim()+'%';
        List<RecordType> recTypeList = [select id, name from RecordType where sObjectType='GE_HQ_Account_Plan__c' and (developername='GE_PRM_Business_Plan') ];
        System.debug('****RecordType List****'+recTypeList);
            
        if(prmAccountPlanIds.size()>0){
           // AllPRMPlanRecs = [Select Id, Name, GE_HQ_Buss_Tier__c, GE_HQ_Buss_Tier1__c, GE_PRM_Tier_1__c, GE_PRM_Tier_2__c, GE_HQ_DDUNS_Number__c, GE_HQ_DDUNS_fm__c, GE_HQ_Pb_Long_Term__c, GE_HQ_Pb_Short_Term__c, LastModifiedById, GE_PRM_Status__c  from GE_HQ_Account_Plan__c where RecordTypeId in: recTypeList and Id !=: AccPlanningId and Id in: prmAccountPlanIds and GE_PRM_Status__c = 'Approved' and (Name Like :SearchStringPRMPlan or GE_PRM_Tier_1__c Like :SearchStringPRMPlan or GE_PRM_Tier_2__c Like :SearchStringPRMPlan or GE_HQ_DDUNS_fm__c Like :SearchStringPRMPlan or  LastModifiedBy.name like :SearchStringPRMPlan or GE_HQ_DDUNS_Number__r.name like :SearchStringPRMPlan) order by name limit 50000];
           AllPRMPlanRecs = [Select Id, Name, GE_HQ_Buss_Tier__c, GE_HQ_Buss_Tier1__c, GE_PRM_Tier_1__c,  GE_HQ_DDUNS_Number__c, GE_HQ_DDUNS_fm__c, GE_HQ_Pb_Long_Term__c, GE_HQ_Pb_Short_Term__c, LastModifiedById, GE_PRM_Status__c  from GE_HQ_Account_Plan__c where RecordTypeId in: recTypeList and Id !=: AccPlanningId and Id in: prmAccountPlanIds and GE_PRM_Status__c = 'Approved' and (Name Like :SearchStringPRMPlan or GE_PRM_Tier_1__c Like :SearchStringPRMPlan or GE_HQ_DDUNS_fm__c Like :SearchStringPRMPlan or  LastModifiedBy.name like :SearchStringPRMPlan or GE_HQ_DDUNS_Number__r.name like :SearchStringPRMPlan) order by name limit 50000];
            TotalPRMPlanRecords = AllPRMPlanRecs.size();
        }            
        NextCountPRMPlan = 0;
    }
    // For fetching the next set of records
    Public void getNextPRMPlan() {
        if(NextCountPRMPlan+NoOfRows <= TotalPRMPlanRecords)
            NextCountPRMPlan+=NoOfRows;
        else
            NextCountPRMPlan= TotalPRMPlanRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevPRMPlan() {
        if(NextCountPRMPlan-NoOfRows >=0)
            NextCountPRMPlan-=NoOfRows;
        else
            NextCountPRMPlan=0;
    }
    // For fetching the first Set of records
    Public void getFirstPRMPlan() {
        NextCountPRMPlan=0;
    }
    // For fetching the last set of records
    Public void getLastPRMPlan() {
        NextCountPRMPlan=TotalPRMPlanRecords- NoOfRows;
    }

    // For Fetching FieldOfPlay records
    Public List<Field_of_Play__c> getFieldOfPlayRecs() {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;    AllPlanActivityRecs = null;
        //SearchStringCase='%%';
        If((AllFieldOfPlayRecs == Null || AllFieldOfPlayRecs.size() ==0) && SearchStringFieldOfPlay=='%%') {
            AllFieldOfPlayRecs = [Select Id, Name,  mh_Charter_Statement__c, mh_Last_Updated_Gold_Sheet__c, mh_Additional_Notes_Exist__c, mh_Managers_Notes_Exist__c, mh_Managers_Review_Date__c,  LastModifiedDate, Account__c from Field_of_Play__c Account__c where Account__c in: AllAccountids order by name limit 50000];
            TotalFieldOfPlayRecords = AllFieldOfPlayRecs.size();
        }
        
        if(AccountType=='My GE Accounts' && AllFieldOfPlayRecs != Null){
            List<Field_of_Play__c> myGEFieldofPlaysList = new List<Field_of_Play__c>();
            for(Field_of_Play__c FieldofPlayObj: AllFieldOfPlayRecs)
                if(myGEAccountIds.contains(FieldofPlayObj.Account__c))
                    myGEFieldofPlaysList.add(FieldofPlayObj);
            if(myGEFieldofPlaysList.size()>0)
                AllFieldOfPlayRecs = myGEFieldofPlaysList;
            else
                AllFieldOfPlayRecs = new List<Field_of_Play__c>(); 
            TotalFieldOfPlayRecords = AllFieldOfPlayRecs.size();                               
        }
        
        If(AllFieldOfPlayRecs == Null || AllFieldOfPlayRecs.size() == 0) return null;
            
        List<Field_of_Play__c> FieldOfPlayRecs = new List<Field_of_Play__c>();
        For(Integer i=0;i < NoOfRows && (NextCountFieldOfPlay+i < TotalFieldOfPlayRecords); i++) {
           FieldOfPlayRecs.add(AllFieldOfPlayRecs[NextCountFieldOfPlay+i]);
        }
        
        if(NextCountFieldOfPlay <= 0) {
            hasFirstFieldOfPlay=False;
            hasPrevFieldOfPlay=False;
        }
        else {
            hasFirstFieldOfPlay=True;
            hasPrevFieldOfPlay=True;
        }
        if(NextCountFieldOfPlay >= (TotalFieldOfPlayRecords - NoOfRows)) {
            hasLastFieldOfPlay=False;
            hasNextFieldOfPlay=False;
        }
        else {
            hasLastFieldOfPlay=True;
            hasNextFieldOfPlay=True;
        }

        StartRecFieldOfPlay=(TotalFieldOfPlayRecords == 0)?0:NextCountFieldOfPlay+1;
        if(StartRecFieldOfPlay+NoOfRows >TotalFieldOfPlayRecords)
            EndRecFieldOfPlay=TotalFieldOfPlayRecords;
        else
            EndRecFieldOfPlay=StartRecFieldOfPlay+NoOfRows-1;
        return FieldOfPlayRecs;
    }
    // Method to Search in Account records
    Public void SearchFieldOfPlay() {
        SearchStringFieldOfPlay = '%'+SearchTextFieldOfPlay.Trim()+'%';
        AllFieldOfPlayRecs = [Select Id, Name,  mh_Charter_Statement__c, mh_Last_Updated_Gold_Sheet__c, mh_Additional_Notes_Exist__c, mh_Managers_Notes_Exist__c, mh_Managers_Review_Date__c, LastModifiedDate from Field_of_Play__c Account__c where Account__c in: AllAccountids and (name like : SearchStringFieldOfPlay) order by name limit 50000];
        TotalFieldOfPlayRecords = AllFieldOfPlayRecs.size();
        NextCountFieldOfPlay = 0;
    }
    // For fetching the next set of records
    Public void getNextFieldOfPlay() {
        if(NextCountFieldOfPlay+NoOfRows <= TotalFieldOfPlayRecords)
            NextCountFieldOfPlay+=NoOfRows;
        else
            NextCountFieldOfPlay= TotalFieldOfPlayRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevFieldOfPlay() {
        if(NextCountFieldOfPlay-NoOfRows >=0)
            NextCountFieldOfPlay-=NoOfRows;
        else
            NextCountFieldOfPlay=0;
    }
    // For fetching the first Set of records
    Public void getFirstFieldOfPlay() {
        NextCountFieldOfPlay=0;
    }
    // For fetching the last set of records
    Public void getLastFieldOfPlay() {
        NextCountFieldOfPlay=TotalFieldOfPlayRecords- NoOfRows;
    }
    
    // For Fetching PlanActivity records
    Public List<Task> getPlanActivityRecs() {
        // Make other variables= Null to reduce the view state size.
        AllchanApptRecs = Null; AllAccountRecs=Null; AllOpportunityRecs = Null; AllContactRecs = Null; AllContractRecs = Null; AllIBRecs = Null; AllATMRecs = Null; AllTaskRecs = Null; AllEventRecs = Null; AllProjectRecs = Null; AllAEPlanRecs = null;  AllEnergyPlanRecs = null;  AllPRMPlanRecs = null;  AllFieldOfPlayRecs = null; 
        //SearchStringCase='%%';
        If((AllPlanActivityRecs == Null || AllPlanActivityRecs.size() ==0) && SearchStringPlanActivity=='%%') {
        
            //List<RecordType> recTypeList = [select id, name from RecordType where sObjectType='GE_HQ_Account_Plan__c' and (developername='GE_Energy_Plan' or developername='ES_Account_Plan' or developername='AE_Account_Plan' or developername='GE_PRM_Business_Plan')];
            set<Id> accountPlanIds = new Set<Id>();        
            if(AllAccountids.size()>0)
                for(GE_HQ_Acc_AccPlan_Rel__c myGEAccountObj: [select id, GE_HQ_Account_Plan__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account__c in: AllAccountids limit 50000])                
                        accountPlanIds.add(myGEAccountObj.GE_HQ_Account_Plan__c);
                    
            //List<RecordType> recTypeList = [select id, name from RecordType where sObjectType='GE_HQ_Account_Plan__c' and (developername='GE_Energy_Plan' or developername='ES_Account_Plan')];
            //System.debug('****RecordType List****'+recTypeList);
            
            if( accountPlanIds.size()>0){
                for(GE_HQ_Account_Plan__c AccountPlanObj: [Select Id, Name, RecordType.DeveloperName, GE_HQ_DDUNS_fm__c, GE_PRM_Status__c from GE_HQ_Account_Plan__c where Id !=: AccPlanningId and Id in: accountPlanIds limit 50000]){
                    if(AccountPlanObj.RecordType.DeveloperName == 'GE_Energy_Plan' || AccountPlanObj.RecordType.DeveloperName == 'ES_Account_Plan' ||( AccountPlanObj.RecordType.DeveloperName == 'GE_PRM_Business_Plan' &&  AccountPlanObj.GE_PRM_Status__c == 'Approved'))    
                         RelatedAccountPlanIds.add(AccountPlanObj.id);
                }                    
            }
            
            
            if( RelatedAccountPlanIds.size()>0){                
                AllPlanActivityRecs = [select Id, whatId, Subject, OwnerId,  ActivityDate, Status, Priority, Type from task where whatId in: RelatedAccountPlanIds order by WhatId limit 50000];
                TotalPlanActivityRecords = AllPlanActivityRecs.size();
            }                
        }
        
        if(AccountType=='My GE Accounts' && AllPlanActivityRecs != Null){
            RelatedAccountPlanIds = new Set<Id>();
            set<Id> accountPlanIds = new Set<Id>();
            Set<Id> myGEAccs = new Set<Id>();
            if(AllAccountids.size()>0){
                for(Id myGEaccId : AllAccountids)
                    if(myGEAccountIds.contains(myGEaccId))
                        myGEAccs.add(myGEaccId);
            }                               
            if(myGEAccs.size()>0){                        
                for(GE_HQ_Acc_AccPlan_Rel__c myGEAccountObj: [select id, GE_HQ_Account_Plan__c, GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account__c in: myGEAccs limit 50000])
                   accountPlanIds.add(myGEAccountObj.GE_HQ_Account_Plan__c);
                            
            }
            
            if( accountPlanIds.size()>0){
                for(GE_HQ_Account_Plan__c AccountPlanObj: [Select Id, Name, RecordType.DeveloperName, GE_HQ_DDUNS_fm__c, GE_PRM_Status__c from GE_HQ_Account_Plan__c where Id !=: AccPlanningId and Id in: accountPlanIds limit 50000]){
                    if(AccountPlanObj.RecordType.DeveloperName == 'GE_Energy_Plan' || AccountPlanObj.RecordType.DeveloperName == 'ES_Account_Plan' ||( AccountPlanObj.RecordType.DeveloperName == 'GE_PRM_Business_Plan' &&  AccountPlanObj.GE_PRM_Status__c == 'Approved'))    
                         RelatedAccountPlanIds.add(AccountPlanObj.id);
                }                    
            }
            
            List<task> myGEtasksList = new List<task>();
            for(task taskObj: AllPlanActivityRecs)
                if(RelatedAccountPlanIds.contains(taskObj.whatId))
                    myGEtasksList.add(taskObj);
            if(myGEtasksList.size()>0)
                AllPlanActivityRecs = myGEtasksList;
            else
                AllPlanActivityRecs = new List<task>(); 
            TotalPlanActivityRecords = AllPlanActivityRecs.size();                               
                    
        }
        
        If(AllPlanActivityRecs == Null || AllPlanActivityRecs.size() == 0) return null;
            
        List<Task> PlanActivityRecs = new List<Task>();
        For(Integer i=0;i < NoOfRows && (NextCountPlanActivity+i < TotalPlanActivityRecords); i++) {
           PlanActivityRecs.add(AllPlanActivityRecs[NextCountPlanActivity+i]);
        }
        
        if(NextCountPlanActivity <= 0) {
            hasFirstPlanActivity=False;
            hasPrevPlanActivity=False;
        }
        else {
            hasFirstPlanActivity=True;
            hasPrevPlanActivity=True;
        }
        if(NextCountPlanActivity >= (TotalPlanActivityRecords - NoOfRows)) {
            hasLastPlanActivity=False;
            hasNextPlanActivity=False;
        }
        else {
            hasLastPlanActivity=True;
            hasNextPlanActivity=True;
        }

        StartRecPlanActivity=(TotalPlanActivityRecords == 0)?0:NextCountPlanActivity+1;
        if(StartRecPlanActivity+NoOfRows >TotalPlanActivityRecords)
            EndRecPlanActivity=TotalPlanActivityRecords;
        else
            EndRecPlanActivity=StartRecPlanActivity+NoOfRows-1;
        return PlanActivityRecs;
    }
    // Method to Search in PlanActivity records
    Public void SearchPlanActivity() {
        SearchStringPlanActivity = '%'+SearchTextPlanActivity.Trim()+'%';
        if( RelatedAccountPlanIds.size()>0){                
            AllPlanActivityRecs = [select Id, whatId, Subject, OwnerId,  ActivityDate, Status, Priority, Type from task where whatId in: RelatedAccountPlanIds and (subject like: SearchStringPlanActivity or owner.name like: SearchStringPlanActivity or status like: SearchStringPlanActivity or priority like: SearchStringPlanActivity or type like: SearchStringPlanActivity ) order by WhatId limit 50000];
            TotalPlanActivityRecords = AllPlanActivityRecs.size();
        }            
        NextCountPlanActivity = 0;
    }
    // For fetching the next set of records
    Public void getNextPlanActivity() {
        if(NextCountPlanActivity+NoOfRows <= TotalPlanActivityRecords)
            NextCountPlanActivity+=NoOfRows;
        else
            NextCountPlanActivity= TotalPlanActivityRecords- NoOfRows;
    }
    // For Fetching the previous set of Records
    Public void getPrevPlanActivity() {
        if(NextCountPlanActivity-NoOfRows >=0)
            NextCountPlanActivity-=NoOfRows;
        else
            NextCountPlanActivity=0;
    }
    // For fetching the first Set of records
    Public void getFirstPlanActivity() {
        NextCountPlanActivity=0;
    }
    // For fetching the last set of records
    Public void getLastPlanActivity() {
        NextCountPlanActivity=TotalPlanActivityRecords- NoOfRows;
    }
    
    public List<SelectOption> accountsType{
    
        get{
            if(accountsType == null){
            
                accountsType = new List<selectOption> ();
                accountsType.add(new SelectOption('All Accounts','All Accounts'));
                accountsType.add(new SelectOption('My GE Accounts','My GE Accounts'));
            }
            return accountsType;

        }
        set;
        
    }
    
    public String AccountType{
        get;set;
    }
    public Boolean isGEAccount{
        get;
        set;
    }
    public Set<Id> myGEAccountIds = new Set<Id>();
    public void myGEAccounts(){
    
        User userObj = [select id from User where id =: UserInfo.getUserId()];
        
        Map<Id,GE_HQ_Account_Plan__c> myGEAccountsMap;
        Map<Id, RecordType> recordTypeMap;
        recordTypeMap = new Map<Id,RecordType>([select id,Developername,name from RecordType where sObjectType ='GE_HQ_Account_Plan__c' and Developername='Private_Plan']);
        //Getting Private Plan ID and Child Accounts
        myGEAccountsMap = new Map<Id,GE_HQ_Account_Plan__c>([select id, name, (select id, GE_HQ_Account__c, GE_HQ_Account_Plan__c from AccAccPlanRel__r) from GE_HQ_Account_Plan__c where RecordTypeId in: recordTypeMap.keyset() and ownerId=:userObj.id]);
        for(GE_HQ_Account_Plan__c accountPlanObj: myGEAccountsMap.values())
            for(GE_HQ_Acc_AccPlan_Rel__c myGEAccObj: accountPlanObj.AccAccPlanRel__r)
                myGEAccountIds.add(myGEAccObj.GE_HQ_Account__c);
                       
    }
    
    public void refreshSearchStrings(){
        System.debug('****Refresh Search String****');
        SearchStringAcc='%%';
        SearchTextAcc ='';
        
        SearchStringchanAppt='%%';
        SearchTextchanAppt ='';
        
        SearchStringOpp='%%';
        SearchTextOpp ='';
        
        SearchStringContact='%%';
        SearchTextContact='';
        
        SearchStringContract='%%';
        SearchTextContract='';
        
        SearchStringIB='%%';
        SearchTextIB='';
        
        SearchStringATM='%%';
        SearchTextATM='';
        
        SearchStringTask='%%';
        SearchTextTask='';
        
        SearchStringEvent='%%';
        SearchTextEvent='';
        
        SearchStringProject='%%';
        SearchTextProject='';
        
        SearchStringCase='%%';
        SearchTextCase ='';        
    }
    */
    Public GE_HQ_Accounts360ViewController(ApexPages.StandardController controller) {}
    
    static testMethod void myTest() {
        
        GE_HQ_Accounts360ViewController obj = new GE_HQ_Accounts360ViewController(new ApexPages.StandardController(new GE_HQ_Account_Plan__c()));
    }
}