public class Predixdashboardpagecontroller{
     public Boolean caseFollowing{get;set;} 
 Public List<EntitySubscription> followedCases{get;set;}
Public Decimal myCases {get;set;}
Public Decimal NewCases{get;set;}
Public Decimal SolvedCases{get;set;}
Public Decimal CriticalCases{get;set;}
Public Decimal AvgMyCount{get;set;}
Public Decimal AvgNewCount{get;set;}
Public Decimal AvgSolvedCount{get;set;}
Public Decimal AvgCriticalCount{get;set;}
Public Case CreateNewCase{get;set;}
Public Case CreateCases{get;set;}
Public Case CreatemyCases{get;set;}
//Public Case CreateBugCases{get;set;}
//Public Case CreateSuggestionCases{get;set;}
//Public Enhancement__c Enhancement{get;set;}
//Public List<Case> viewRecentCases {get;set;}
public String NewCase { get; set; }
public String countMyCases{ get; set; }

public String FollowParentId{ get; set; }
public boolean viewAllCase{get;set;}
public boolean viewRecentCase {get;set;}
public list<Case> c{get;set;}
public List<wrapcase> display_recentcaselist{get; set;}
//Public List<Technical_Support__kav> RecentArticles{get; set;}
//Public List<Case> RecentArticles{get; set;} //Sunayana: Changed List type due to validation errors
//Public List<KnowledgeArticleVersion > PopularKnowledgeArticle  {get;set;}

//Public List<Case> Search {get;set;}
Public Integer recordTypeCount{get;set;}
Public String selectedBugOptions {get; set;}
Public String selectedSuggestOptions {get; set;}
public map<string,PredixCustomSetting__c> mapOfStingVsCustomSetting{get;set;}
public PredixCustomSetting__c tempCustomsetting{get;set;}
Public String SelectedRecordType{get;set;}
Public String SelectedCaseRecordType {get;set;}
public list<string> listOfPriority;
Public list<string> listOfStatus{get;set;}
Public string selectedProduct{get;set;}
 Public string selectedCompany{get;set;}
Public string selectedStatus{get;set;}
 public string selectedPriority{get;set;}
 public List<FeedComment> listFeedComment{get;set;}

public List<wrapFeedComments> display_feedCommentsList{get;set;}
Public String UserProfileName {get;set;}
Public Set<String> lstUserPermissionsetName {get;set;}
public Set<String> AllowedRecordTypes{get;set;}
public Set<String> AllowedRecordtypeID{get;set;}
public Boolean isCommunityUser {get;set;}
public User CurUser {get;set;}
Public String selectedEnhancOptions {get; set;} 
public List<wrapcase> display_P1PriorityCaseslist {get; set;}
public List<wrapcase> display_P2PriorityCaseslist {get; set;}
public List<wrapcase> display_P3PriorityCaseslist {get; set;}
public List<wrapcase> display_P4PriorityCaseslist {get; set;}
public List<wrapcase> display_newcaselist {get; set;}
public List<wrapcase> display_closedcaselist {get; set;}
public List<wrapcase> display_workingcaselist {get; set;}
public List<wrapcase> display_resolvedcaselist {get; set;}
public List<wrapcase> display_ackcaselist {get; set;}
public String renderedAllTable{get;set;}
public List<FeedItem> listFeedItem{get;set;}
    public List<wrapFeedItems> display_feedItemList{get;set;}

public Predixdashboardpagecontroller()
{
 //   IPSRecTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
  //  UORecTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Predix UO').getRecordTypeId();
renderedAllTable = 'RecentCases';
//GetCaseFollow();
 mapOfStingVsCustomSetting =new map<string,PredixCustomSetting__c>();
    tempCustomsetting = new PredixCustomSetting__c();
    listOfPriority = new list<string>();
    listOfStatus = new list<string>();

     //   renderedAllTable='Thismonth';
    AllowedRecordTypes = new Set<String>();
    lstUserPermissionsetName = new Set<String>();
    AllowedRecordtypeID = new Set<String>();
    isCommunityUser = false;
    List<PredixCustomSetting__c> ObjCommunitySetting = PredixCustomSetting__c.getall().values();
    UserProfileName = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() limit 1].name;
    for ( PermissionSetAssignment objPSA : [SELECT PermissionSetId ,PermissionSet.name FROM PermissionSetAssignment WHERE AssigneeId = :userinfo.getUserID()])
    {
        lstUserPermissionsetName.add(objPSA.PermissionSet.name) ;
    }
    for(PredixCustomSetting__c objComSet :ObjCommunitySetting)
    {
        if(objComSet.ProfileName__c == UserProfileName || lstUserPermissionsetName.contains(objComSet.PermissionSet_Name__c) )
        {       
            AllowedRecordTypes.add(objComSet.RecordType__c);
            isCommunityUser = true;
        }   
        
    }
    if(!isCommunityUser)
    {
        for(PredixCustomSetting__c objComSet :ObjCommunitySetting)
        {
            AllowedRecordTypes.add(objComSet.RecordType__c);
        }       
        
        
    }
    system.debug('AllowedRecordTypes----'+  AllowedRecordTypes);
    for(String objRecTypeName : AllowedRecordTypes)
    {
        AllowedRecordtypeID.add(Schema.SObjectType.Case.getRecordTypeInfosByName().get(objRecTypeName).getRecordTypeId());
        
        
    }
    
    recordTypeCount = AllowedRecordtypeID.size();
    
    // displays count of cases when page loads
    
    myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND recordtypeID in  :AllowedRecordtypeID ][0].get('mycases') ;
   if(isCommunityUser)
   {
        if(!test.isRunningTest())
     CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
      NewCases=(Integer) [select count(id)  NewCases from Case where accountId=:CurUser.Contact.AccountID AND recordtypeID in  :AllowedRecordtypeID  And Status ='New' ][0].get('NewCases') ;
system.debug('COUNT NEW CASES --> '+NewCases ) ;

 SolvedCases=(Integer) [select count(id)  SolvedCases from Case where accountId=:CurUser.Contact.AccountID AND  (Status ='Resolved' OR Status = 'Closed') AND recordtypeID in  :AllowedRecordtypeID  ][0].get('SolvedCases') ;
 system.debug('COUNT SOLVED CASES --> '+SolvedCases ) ;
 
 CriticalCases=(Integer) [select count(id)  CriticalCase from Case where accountId=:CurUser.Contact.AccountID AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND recordtypeID in  :AllowedRecordtypeID  ][0].get('CriticalCase') ;  
       
   }
   else{  
    
    NewCases=(Integer) [select count(id)  NewCases from Case where recordtypeID in  :AllowedRecordtypeID And Status ='New' ][0].get('NewCases') ;
    
    SolvedCases=(Integer) [select count(id)  SolvedCases from Case where   (Status ='Resolved' OR Status = 'Closed') AND recordtypeID in  :AllowedRecordtypeID ][0].get('SolvedCases') ;
    
    CriticalCases=(Integer) [select count(id)  CriticalCase from Case where  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND recordtypeID in  :AllowedRecordtypeID][0].get('CriticalCase') ;
    
   }
     //myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID )  ][0].get('mycases') ;
   // NewCases=(Integer) [select count(id)  NewCases from Case where (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) And Status ='New' ][0].get('NewCases') ;
    
    //SolvedCases=(Integer) [select count(id)  SolvedCases from Case where   (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) ][0].get('SolvedCases') ;
    
   // CriticalCases=(Integer) [select count(id)  CriticalCase from Case where  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) ][0].get('CriticalCase') ;
  
        System.debug('myCases--> '+myCases);
  
 

/*user u = [select id,profileid, ContactId  from user where id =:userinfo.getuserid()];
profile p =[select id,name from profile where id=:u.profileid];*/

List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() ];
System.debug('\n\n Profile '+PROFILE);

 
 /*if(PROFILE[0].name.contains('II Partner Community IPS')|| PROFILE[0].name.contains('II Partner Community UO'))
 {
 
                  List<User> lstCurUser = [SELECT Id, ContactId, Contact.AccountId 
                                     FROM   User 
                                     WHERE  Id =: UserInfo.getUserId()
                                     AND    ContactId != null ];
                  system.debug('lstCurUser --> '+lstCurUser ) ;
              
                  List<Contact> con  =[Select AccountID from Contact where id =: lstCurUser[0].ContactId ];
                   system.debug('con --> '+con ) ;
 
 NewCases=(Integer) [select count(id)  NewCases from Case where accountId=:con[0].AccountID AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) And Status ='New' ][0].get('NewCases') ;
system.debug('COUNT NEW CASES --> '+NewCases ) ;

 SolvedCases=(Integer) [select count(id)  SolvedCases from Case where accountId=:con[0].AccountID AND  (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) ][0].get('SolvedCases') ;
 system.debug('COUNT SOLVED CASES --> '+SolvedCases ) ;
 
 CriticalCases=(Integer) [select count(id)  CriticalCase from Case where accountId=:con[0].AccountID AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) ][0].get('CriticalCase') ;
 system.debug('COUNT CRITICAL CASES --> '+CriticalCases ) ;
 }
 */ 
        
        
    /*IPSRecTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
    UORecTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Predix UO').getRecordTypeId();
   
    System.debug('myCases--> '+myCases);
    myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID )  ][0].get('mycases') ;
    
    NewCases=(Integer) [select count(id)  NewCases from Case where (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) And Status ='New' ][0].get('NewCases') ;
    
    SolvedCases=(Integer) [select count(id)  SolvedCases from Case where   (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) ][0].get('SolvedCases') ;
    
    CriticalCases=(Integer) [select count(id)  CriticalCase from Case where  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) ][0].get('CriticalCase') ;
  
        System.debug('myCases--> '+myCases);*/
  
 
//Average Calculation
AvgMyCount=((MyCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgMyCount==============='+AvgMyCount); 

 AvgNewCount=((NewCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgNewCount==============='+AvgNewCount); 
    
 AvgSolvedCount=((SolvedCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgSolvedCount==============='+AvgSolvedCount); 
    
 AvgCriticalCount=((Criticalcases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgCriticalCount==============='+AvgCriticalCount); 

/*user u = [select id,profileid, ContactId  from user where id =:userinfo.getuserid()];
profile p =[select id,name from profile where id=:u.profileid];*/

/*List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() ];
System.debug('\n\n Profile '+PROFILE);*/

 
/* if(PROFILE[0].name.contains('II Partner Community IPS')|| PROFILE[0].name.contains('II Partner Community UO'))
 {
 
                  List<User> lstCurUser = [SELECT Id, ContactId, Contact.AccountId 
                                     FROM   User 
                                     WHERE  Id =: UserInfo.getUserId()
                                     AND    ContactId != null ];
                  system.debug('lstCurUser --> '+lstCurUser ) ;
              
                  List<Contact> con  =[Select AccountID from Contact where id =: lstCurUser[0].ContactId ];
                   system.debug('con --> '+con ) ;
 
 NewCases=(Integer) [select count(id)  NewCases from Case where accountId=:con[0].AccountID AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) And Status ='New' ][0].get('NewCases') ;
system.debug('COUNT NEW CASES --> '+NewCases ) ;

 SolvedCases=(Integer) [select count(id)  SolvedCases from Case where accountId=:con[0].AccountID AND  (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) ][0].get('SolvedCases') ;
 system.debug('COUNT SOLVED CASES --> '+SolvedCases ) ;
 
 CriticalCases=(Integer) [select count(id)  CriticalCase from Case where accountId=:con[0].AccountID AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID = :IPSRecTypeID OR recordtypeID = :UORecTypeID ) ][0].get('CriticalCase') ;
 system.debug('COUNT CRITICAL CASES --> '+CriticalCases ) ;
 }*/
 


//Enhancement = new Enhancement__c();


/*if(!ObjCommunitySetting.isEmpty())
      {
          for(PredixCustomSetting__c Obj :ObjCommunitySetting )
             mapOfStingVsCustomSetting.put(Obj.RecordType__c, Obj ); 
      }
      system.debug('********mapOfStingVsCustomSetting'+mapOfStingVsCustomSetting);*/
      
 CreateNewCase= new case(RecordTypeId = [SELECT Id
                                             FROM RecordType 
                                             WHERE SobjectType = 'Case' 
                                                 AND Id= :AllowedRecordTypeId 
                                           limit 1  ].Id
                             /** required fields **/
                           );
                        
  
        
                         
 system.debug('============CreateNewCase======='+CreateNewCase);
 
 
 CreateCases= new case(RecordTypeId = [SELECT Id
                                             FROM RecordType 
                                             WHERE SobjectType = 'Case' 
                                                 AND Id= :AllowedRecordTypeId 
                                           limit 1  ].Id
                             /** required fields **/
                           );
                        
  
        
                         
 system.debug('============CreateCases======='+CreateCases);
 
 CreatemyCases= new case(RecordTypeId = [SELECT Id
                                             FROM RecordType 
                                             WHERE SobjectType = 'Case' 
                                                 AND Id= :AllowedRecordTypeId 
                                           limit 1  ].Id
                             /** required fields **/
                           );
                        
  
        
                         
 system.debug('============CreatemyCases======='+CreatemyCases);
 

 
 /*if(AllowedRecordTypes.size()>1){
 CreateNewCase= new case();
 }*/
    
/* if(PROFILE[0].name.contains('II Partner Community IPS'))
 { 
     
     CreateNewCase.recordtypeid=IPSRecTypeID;
     system.debug('1111111111111111' + CreateNewCase);
   //  insert CreateNewCase;
 } else if (PROFILE[0].name.contains('II Partner Community UO'))
 {
 
     CreateNewCase.recordtypeid=UORecTypeID;
     system.debug('11111111111111112' + CreateNewCase);
    // insert CreateNewCase;
     
 }else if(PROFILE[0].name.contains('GE_ES Developer') || PROFILE[0].name.contains('System Administrator') || PROFILE[0].name.contains('GE OG Predix Agent')){
 
     CreateNewCase.recordtypeid=IPSRecTypeID;
    // CreateNewCase.recordtypeid=UORecTypeID;
     system.debug('11111111111111112' + CreateNewCase);
    // insert CreateNewCase;
 }*/

//Populate Recently Updated Articles
/*RecentArticles=[select id, title, summary, LastModifiedDate from Technical_Support__kav where publishStatus = 'Online' AND language = 'en_US' order by LastModifiedDate Limit 8 ];
system.debug('RecentArticles----->'+RecentArticles);*/


//Populate Popular Knowledge article/popular documentation
/*Set<id> Ids = new Set<id>();

for(KnowledgeArticleViewStat ka : [SELECT  ParentId, NormalizedScore FROM KnowledgeArticleViewStat where Channel='AllChannels' order by NormalizedScore desc]) {
Ids.add(ka.ParentId);
}


PopularKnowledgeArticle =[SELECT id,Title , UrlName, KnowledgeArticleId, PublishStatus, language FROM KnowledgeArticleVersion WHERE PublishStatus='Online' AND language ='en_US' AND KnowledgeArticleId IN:Ids LIMIT 5];

system.debug('PopularKnowledgeArticle ----->'+PopularKnowledgeArticle );*/
       
       ShowCommentsOnFeeds(); //added to show Feed Comments   
}

//method for 6months, 1year and for lastMonth
public void displayMonthCount() {
System.debug('countMyCases --> '+countMyCases );
   if(countMyCases == 'Thismonth'){
       
       if(isCommunityUser)
   {
    myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=THIS_MONTH AND  (recordtypeID in  :AllowedRecordtypeID  )  ][0].get('mycases') ;
    if(!test.isRunningTest())
        CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
    NewCases=(Integer) [select count(id)  NewCases from Case where createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND (recordtypeID in  :AllowedRecordtypeID  ) And Status ='New' ][0].get('NewCases') ;
    SolvedCases=(Integer) [select count(id)  SolvedCases from Case where  createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID  ) ][0].get('SolvedCases') ;
    CriticalCases=(Integer) [select count(id)  CriticalCase from Case where createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID )][0].get('CriticalCase') ;
  
        System.debug('myCasesThisMonth--> '+myCases);
        System.debug('NewCasesThisMonth--> '+NewCases);
        System.debug('SolvedCasesThisMonth--> '+SolvedCases);
        System.debug('CriticalCasesThisMonth--> '+CriticalCases);
        
            if(myCases!=0){
        AvgMyCount=((MyCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgMyCount==============='+AvgMyCount); 
}else{
AvgMyCount=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=THIS_MONTH AND  (recordtypeID in  :AllowedRecordtypeID  )  ][0].get('mycases') ;
}
if(NewCases!=0){
 AvgNewCount=((NewCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgNewCount==============='+AvgNewCount); 
}else {
AvgNewCount=    (Integer) [select count(id)  NewCases from Case where createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND (recordtypeID in  :AllowedRecordtypeID  ) And Status ='New' ][0].get('NewCases') ;
}
if(SolvedCases!=0){
 AvgSolvedCount=((SolvedCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgSolvedCount==============='+AvgSolvedCount); 
}else {
    AvgSolvedCount=(Integer) [select count(id)  SolvedCases from Case where  createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID  ) ][0].get('SolvedCases') ;
}

if(Criticalcases!=0){
 AvgCriticalCount=((Criticalcases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgCriticalCount==============='+AvgCriticalCount);  
}   else {
    AvgCriticalCount=(Integer) [select count(id)  CriticalCase from Case where createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID )][0].get('CriticalCase') ;
    
}
   }else {
       
    myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=THIS_MONTH AND  (recordtypeID in  :AllowedRecordtypeID  )  ][0].get('mycases') ;
    
    NewCases=(Integer) [select count(id)  NewCases from Case where createdDate=THIS_MONTH AND  (recordtypeID in  :AllowedRecordtypeID  ) And Status ='New' ][0].get('NewCases') ;
    SolvedCases=(Integer) [select count(id)  SolvedCases from Case where  createdDate=THIS_MONTH AND  (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID  ) ][0].get('SolvedCases') ;
    CriticalCases=(Integer) [select count(id)  CriticalCase from Case where createdDate=THIS_MONTH AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID )][0].get('CriticalCase') ;
  
        System.debug('myCasesThisMonth--> '+myCases);
        System.debug('NewCasesThisMonth--> '+NewCases);
        System.debug('SolvedCasesThisMonth--> '+SolvedCases);
        System.debug('CriticalCasesThisMonth--> '+CriticalCases);
        if(myCases!=0){
        AvgMyCount=((MyCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgMyCount==============='+AvgMyCount); 
}else{
AvgMyCount=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=THIS_MONTH AND  (recordtypeID in  :AllowedRecordtypeID  )  ][0].get('mycases') ;
}
if(NewCases!=0){
 AvgNewCount=((NewCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgNewCount==============='+AvgNewCount); 
}else {
AvgNewCount=    (Integer) [select count(id)  NewCases from Case where createdDate=THIS_MONTH AND  (recordtypeID in  :AllowedRecordtypeID  ) And Status ='New' ][0].get('NewCases') ;
}
if(SolvedCases!=0){
 AvgSolvedCount=((SolvedCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgSolvedCount==============='+AvgSolvedCount); 
}else {
    AvgSolvedCount=(Integer) [select count(id)  SolvedCases from Case where  createdDate=THIS_MONTH AND  (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID  ) ][0].get('SolvedCases') ;
}

if(Criticalcases!=0){
 AvgCriticalCount=((Criticalcases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgCriticalCount==============='+AvgCriticalCount);  
}   else {
    AvgCriticalCount=(Integer) [select count(id)  CriticalCase from Case where createdDate=THIS_MONTH AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID )][0].get('CriticalCase') ;
    
}  
   }
   }
        
        else  if(countMyCases == 'Sixmonths'){
            if(isCommunityUser)
   {
             myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=LAST_N_DAYS:180 AND  (recordtypeID in  :AllowedRecordtypeID )  ][0].get('mycases') ;
     if(!test.isRunningTest())
         CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
    NewCases=(Integer) [select count(id)  NewCases from Case where createdDate=LAST_N_DAYS:180 AND accountId=:CurUser.Contact.AccountID AND (recordtypeID in  :AllowedRecordtypeID  ) And Status ='New' ][0].get('NewCases') ;
    SolvedCases=(Integer) [select count(id)  SolvedCases from Case where  createdDate=LAST_N_DAYS:180 AND accountId=:CurUser.Contact.AccountID AND (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID ) ][0].get('SolvedCases') ;
    CriticalCases=(Integer) [select count(id)  CriticalCase from Case where createdDate=LAST_N_DAYS:180 AND accountId=:CurUser.Contact.AccountID AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID ) ][0].get('CriticalCase') ;
  
        System.debug('myCasesSixMonth--> '+myCases);
        System.debug('NewCasesSixMonth--> '+NewCases);
        System.debug('SolvedCasesSixMonth--> '+SolvedCases);
        System.debug('CriticalCasesSixMonth--> '+CriticalCases);
        AvgMyCount=((MyCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgMyCount==============='+AvgMyCount); 

 AvgNewCount=((NewCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgNewCount==============='+AvgNewCount); 
    
 AvgSolvedCount=((SolvedCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgSolvedCount==============='+AvgSolvedCount); 
    
 AvgCriticalCount=((Criticalcases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgCriticalCount==============='+AvgCriticalCount);
   } else {
       myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=LAST_N_DAYS:180 AND  (recordtypeID in  :AllowedRecordtypeID )  ][0].get('mycases') ;
    NewCases=(Integer) [select count(id)  NewCases from Case where createdDate=LAST_N_DAYS:180 AND  (recordtypeID in  :AllowedRecordtypeID  ) And Status ='New' ][0].get('NewCases') ;
    SolvedCases=(Integer) [select count(id)  SolvedCases from Case where  createdDate=LAST_N_DAYS:180 AND  (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID ) ][0].get('SolvedCases') ;
    CriticalCases=(Integer) [select count(id)  CriticalCase from Case where createdDate=LAST_N_DAYS:180 AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID ) ][0].get('CriticalCase') ;
  
        System.debug('myCasesSixMonth--> '+myCases);
        System.debug('NewCasesSixMonth--> '+NewCases);
        System.debug('SolvedCasesSixMonth--> '+SolvedCases);
        System.debug('CriticalCasesSixMonth--> '+CriticalCases);
        AvgMyCount=((MyCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgMyCount==============='+AvgMyCount); 

 AvgNewCount=((NewCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgNewCount==============='+AvgNewCount); 
    
 AvgSolvedCount=((SolvedCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgSolvedCount==============='+AvgSolvedCount); 
    
 AvgCriticalCount=((Criticalcases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgCriticalCount==============='+AvgCriticalCount);
   }    
        }
        else if(countMyCases == 'OneYear'){
            if(isCommunityUser)
   {
             myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=LAST_N_DAYS:365 AND  (recordtypeID in  :AllowedRecordtypeID  )  ][0].get('mycases') ;
     if(!test.isRunningTest())
    CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
    NewCases=(Integer) [select count(id)  NewCases from Case where createdDate=LAST_N_DAYS:365 AND accountId=:CurUser.Contact.AccountID AND (recordtypeID in  :AllowedRecordtypeID ) And Status ='New' ][0].get('NewCases') ;
    SolvedCases=(Integer) [select count(id)  SolvedCases from Case where  createdDate=LAST_N_DAYS:365 AND accountId=:CurUser.Contact.AccountID AND (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID ) ][0].get('SolvedCases') ;
    CriticalCases=(Integer) [select count(id)  CriticalCase from Case where createdDate=LAST_N_DAYS:365 AND accountId=:CurUser.Contact.AccountID AND (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID ) ][0].get('CriticalCase') ;
  
        System.debug('myCasesSixMonth--> '+myCases);
        System.debug('NewCasesSixMonth--> '+NewCases);
        System.debug('SolvedCasesSixMonth--> '+SolvedCases);
        System.debug('CriticalCasesSixMonth--> '+CriticalCases);
        AvgMyCount=((MyCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgMyCount==============='+AvgMyCount); 

 AvgNewCount=((NewCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgNewCount==============='+AvgNewCount); 
    
 AvgSolvedCount=((SolvedCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgSolvedCount==============='+AvgSolvedCount); 
    
 AvgCriticalCount=((Criticalcases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgCriticalCount==============='+AvgCriticalCount); 
        }else {
            
    myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=LAST_N_DAYS:365 AND  (recordtypeID in  :AllowedRecordtypeID  )  ][0].get('mycases') ;
    NewCases=(Integer) [select count(id)  NewCases from Case where createdDate=LAST_N_DAYS:365 AND  (recordtypeID in  :AllowedRecordtypeID ) And Status ='New' ][0].get('NewCases') ;
    SolvedCases=(Integer) [select count(id)  SolvedCases from Case where  createdDate=LAST_N_DAYS:365 AND  (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID ) ][0].get('SolvedCases') ;
    CriticalCases=(Integer) [select count(id)  CriticalCase from Case where createdDate=LAST_N_DAYS:365 AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID ) ][0].get('CriticalCase') ;
  
        System.debug('myCasesSixMonth--> '+myCases);
        System.debug('NewCasesSixMonth--> '+NewCases);
        System.debug('SolvedCasesSixMonth--> '+SolvedCases);
        System.debug('CriticalCasesSixMonth--> '+CriticalCases);
        AvgMyCount=((MyCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgMyCount==============='+AvgMyCount); 

 AvgNewCount=((NewCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgNewCount==============='+AvgNewCount); 
    
 AvgSolvedCount=((SolvedCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgSolvedCount==============='+AvgSolvedCount); 
    
 AvgCriticalCount=((Criticalcases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgCriticalCount==============='+AvgCriticalCount);       
            
            
        }
        }else if(countMyCases == 'AnyTime') {
            
            
   if(isCommunityUser)
   {
       myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND recordtypeID in  :AllowedRecordtypeID ][0].get('mycases') ;
      if(!test.isRunningTest())
     CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
      NewCases=(Integer) [select count(id)  NewCases from Case where accountId=:CurUser.Contact.AccountID AND recordtypeID in  :AllowedRecordtypeID  And Status ='New' ][0].get('NewCases') ;
system.debug('COUNT NEW CASES --> '+NewCases ) ;

 SolvedCases=(Integer) [select count(id)  SolvedCases from Case where accountId=:CurUser.Contact.AccountID AND  (Status ='Resolved' OR Status = 'Closed') AND recordtypeID in  :AllowedRecordtypeID  ][0].get('SolvedCases') ;
 system.debug('COUNT SOLVED CASES --> '+SolvedCases ) ;
 
 CriticalCases=(Integer) [select count(id)  CriticalCase from Case where accountId=:CurUser.Contact.AccountID AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND recordtypeID in  :AllowedRecordtypeID  ][0].get('CriticalCase') ;  
                 if(myCases!=0){
        AvgMyCount=((MyCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgMyCount==============='+AvgMyCount); 
}else{
AvgMyCount=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=THIS_MONTH AND  (recordtypeID in  :AllowedRecordtypeID  )  ][0].get('mycases') ;
}
if(NewCases!=0){
 AvgNewCount=((NewCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgNewCount==============='+AvgNewCount); 
}else {
AvgNewCount=    (Integer) [select count(id)  NewCases from Case where createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND (recordtypeID in  :AllowedRecordtypeID  ) And Status ='New' ][0].get('NewCases') ;
}
if(SolvedCases!=0){
 AvgSolvedCount=((SolvedCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgSolvedCount==============='+AvgSolvedCount); 
}else {
    AvgSolvedCount=(Integer) [select count(id)  SolvedCases from Case where  createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID  ) ][0].get('SolvedCases') ;
}

if(Criticalcases!=0){
 AvgCriticalCount=((Criticalcases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgCriticalCount==============='+AvgCriticalCount);  
}   else {
    AvgCriticalCount=(Integer) [select count(id)  CriticalCase from Case where createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID )][0].get('CriticalCase') ;
    
} 
   }
   else{  
    myCases=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND recordtypeID in  :AllowedRecordtypeID ][0].get('mycases') ;
    NewCases=(Integer) [select count(id)  NewCases from Case where recordtypeID in  :AllowedRecordtypeID And Status ='New' ][0].get('NewCases') ;
    
    SolvedCases=(Integer) [select count(id)  SolvedCases from Case where   (Status ='Resolved' OR Status = 'Closed') AND recordtypeID in  :AllowedRecordtypeID ][0].get('SolvedCases') ;
    
    CriticalCases=(Integer) [select count(id)  CriticalCase from Case where  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND recordtypeID in  :AllowedRecordtypeID][0].get('CriticalCase') ;
               if(myCases!=0){
        AvgMyCount=((MyCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgMyCount==============='+AvgMyCount); 
}else{
AvgMyCount=(Integer) [select count(id)  mycases from Case where createdByID = :UserInfo.GetUserID() AND createdDate=THIS_MONTH AND  (recordtypeID in  :AllowedRecordtypeID  )  ][0].get('mycases') ;
}
if(NewCases!=0){
 AvgNewCount=((NewCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgNewCount==============='+AvgNewCount); 
}else {
AvgNewCount=    (Integer) [select count(id)  NewCases from Case where createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND (recordtypeID in  :AllowedRecordtypeID  ) And Status ='New' ][0].get('NewCases') ;
}
if(SolvedCases!=0){
 AvgSolvedCount=((SolvedCases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgSolvedCount==============='+AvgSolvedCount); 
}else {
    AvgSolvedCount=(Integer) [select count(id)  SolvedCases from Case where  createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID  ) ][0].get('SolvedCases') ;
}

if(Criticalcases!=0){
 AvgCriticalCount=((Criticalcases)/(myCases+NewCases+SolvedCases+Criticalcases)*100);
    system.debug('AvgCriticalCount==============='+AvgCriticalCount);  
}   else {
    AvgCriticalCount=(Integer) [select count(id)  CriticalCase from Case where createdDate=THIS_MONTH AND accountId=:CurUser.Contact.AccountID AND  (Priority = 'P1–Level 1–Catastrophic service failure' OR Priority = 'P2–Level 2–Service failure') AND (recordtypeID in  :AllowedRecordtypeID )][0].get('CriticalCase') ;
    
}
   }
            
        }

}


//function for submit button
public PageReference Submit()
{ 
 
 system.debug('============INSERTCreateNewCase======='+CreateNewCase);
   try{ insert CreateNewCase;
  
 system.debug('============INSERTCreateNewCase======='+CreateNewCase);
 ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Success! Your case has been created.');
            ApexPages.addMessage(msg);
   // PageReference pg= new PageReference('/apex/Predix_demo_page');
   // pg.setRedirect(true);
   //  return pg;
   CreateNewCase=new case();
   CreateNewCase.clear();
return null ;} catch (Exception e) {
                ApexPages.addMessages(e);
                return null;
            }

}

//function called on Cancel button
public PageReference Cancel()
{
   return null;
     
}

public PageReference Save()
{ 
 
 system.debug('============INSERTCreateCases======='+CreateCases);
   try{ insert CreateCases;
  
 system.debug('============INSERTCreateCases======='+CreateCases);
 ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Success! Your case has been created.');
            ApexPages.addMessage(msg);
   // PageReference pg= new PageReference('/apex/Predix_demo_page');
   // pg.setRedirect(true);
   //  return pg;
   CreateCases=new case();
   CreateCases.clear();
return null ;} catch (Exception e) {
                ApexPages.addMessages(e);
                return null;
            }

}

public PageReference Savemycase()
{ 
 
 system.debug('============INSERTCreatemyCases======='+CreatemyCases);
   try{ insert CreatemyCases;
  
 system.debug('============INSERTCreatemyCases======='+CreatemyCases);
 ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Success! Your case has been created.');
            ApexPages.addMessage(msg);
   // PageReference pg= new PageReference('/apex/Predix_demo_page');
   // pg.setRedirect(true);
   //  return pg;
   CreatemyCases=new case();
   CreatemyCases.clear();
return null ;} catch (Exception e) {
                ApexPages.addMessages(e);
                return null;
            }

}

/*public PageReference SaveBugcase()
{ 
 
 system.debug('============INSERTCreateBugCases======='+CreateBugCases);
   try{ insert CreateBugCases;
  
 system.debug('============INSERTCreateBugCases======='+CreateBugCases);
 ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Success! Your case has been created.');
            ApexPages.addMessage(msg);
   // PageReference pg= new PageReference('/apex/Predix_demo_page');
   // pg.setRedirect(true);
   //  return pg;
   CreateBugCases=new case();
   CreateBugCases.clear();
return null ;} catch (Exception e) {
                ApexPages.addMessages(e);
                return null;
            }

}

public PageReference SaveSuggestioncase()
{ 
 
 system.debug('============INSERTCreateSuggestionCases======='+CreateSuggestionCases);
   try{ insert CreateSuggestionCases;
  
 system.debug('============INSERTCreateSuggestionCases======='+CreateSuggestionCases);
 ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Success! Your case has been created.');
            ApexPages.addMessage(msg);
   // PageReference pg= new PageReference('/apex/Predix_demo_page');
   // pg.setRedirect(true);
   //  return pg;
   CreateSuggestionCases=new case();
   CreateSuggestionCases.clear();
return null ;} catch (Exception e) {
                ApexPages.addMessages(e);
                return null;
            }

}*/

public list<SelectOption> getCaseRecordTypes()
{
    list<SelectOption> options = new list<SelectOption>();

        for(RecordType sRecordType : [SELECT Id, Name FROM RecordType WHERE sObjectType = 'Case' and Name=:AllowedRecordTypes  ])
        {
            
            options.add(new SelectOption(sRecordType.Id, sRecordType.Name));
        }
        system.debug('optionssssss==========='+options);
        return options;
   }

    
public void updateCaseRecordType()
{

 
    CreateCases.RecordTypeId = SelectedCaseRecordType;

    
    system.debug('SelectedRecordType==========='+SelectedRecordType);
}


public List<SelectOption> getEnhanceCaseTypeOptions() {
        List<SelectOption> EnhanceCaseTypeOptions= new List<SelectOption>();
        EnhanceCaseTypeOptions.add(new SelectOption('Enhancement','Enhancement'));
        
        return EnhanceCaseTypeOptions;
    } 
    
public List<SelectOption> getBugCaseTypeOptions() {
        List<SelectOption> BugCaseTypeOptions= new List<SelectOption>();
        BugCaseTypeOptions.add(new SelectOption('Bug','Bug'));
        
        return BugCaseTypeOptions;
    }     
    
    
public List<SelectOption> getSuggestCaseTypeOptions() {
        List<SelectOption> SuggestCaseTypeOptions= new List<SelectOption>();
        SuggestCaseTypeOptions.add(new SelectOption('Suggestion','Suggestion'));
        
        return SuggestCaseTypeOptions;
    }     
    

public list<SelectOption> getRecordTypes()
{
    list<SelectOption> options = new list<SelectOption>();

        for(RecordType sRecordType : [SELECT Id, Name FROM RecordType WHERE sObjectType = 'Case' and Name=:AllowedRecordTypes  ])
        {
            
            options.add(new SelectOption(sRecordType.Id, sRecordType.Name));
        }
        system.debug('optionssssss==========='+options);
        return options;
   }

    
public void updateRecordType()
{

/*CreateNewCase= new case(RecordTypeId = [SELECT Id
                                             FROM RecordType 
                                             WHERE SobjectType = 'Case' 
                                                 AND Name= :SelectedRecordType
                                           limit 1  ].Id
                             /** required fields **/
                          // );

 
    CreateNewCase.RecordTypeId = SelectedRecordType;
    
    //RecordType tempRecordObj =[SELECT Id, Name FROM RecordType WHERE sObjectType = 'Case' and ID =:SelectedRecordType];
   // system.debug('+++++tempRecordObj'+tempRecordObj);
    //CreateNewCase.RecordType.Name = SelectedRecordType;
     /*tempCustomsetting=  mapOfStingVsCustomSetting.get(tempRecordObj.name);
           system.debug('****tempCustomsetting**'+tempCustomsetting);
           listOfPriority= tempCustomsetting.Priority__c.split(';');
           listOfStatus= tempCustomsetting.Status__c.split(';');
           system.debug('****listOfPriority**'+listOfPriority);
           system.debug('****listOfStatus**'+listOfStatus);
            system.debug('****tempCustomsetting**'+tempCustomsetting);*/
            
    //getRecordTypes();
    
    system.debug('SelectedRecordType==========='+SelectedRecordType);
}
  
 public List<SelectOption> getPriortyPicklist() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--select--','--select--'));
            for(string obj :listOfPriority)
                options.add(new SelectOption(obj ,obj ));
            
            system.debug('****options '+options );
            return options;
        }
     public List<SelectOption> getStatusPicklist() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('--select--','--select--'));
            for(string obj :listOfStatus)
                options.add(new SelectOption(obj ,obj ));
            
            system.debug('****options '+options );
            return options;
        }
        
        public List<selectoption> getProductPicklist() {
        List<selectoption> options = new List<selectoption>();
        //options.add(new SelectOption('--select--','--select--'));
        if(tempCustomsetting.Product__c != null && tempCustomsetting.Product__c != '')
            options.add(new selectOption(tempCustomsetting.Product__c,tempCustomsetting.Product__c));
            system.debug('****options '+options );
        return options;
        }
        
        
        public List<selectoption> getCompanyPicklist() {
        List<selectoption> options = new List<selectoption>();
        //options.add(new SelectOption('--select--','--select--'));
        if(tempCustomsetting.Company__c != null && tempCustomsetting.Company__c != '')
            options.add(new selectOption(tempCustomsetting.Company__c,tempCustomsetting.Company__c));
        system.debug('****options '+options );
        return options;
        }   
       // pRIORITY 
       
        public List<wrapcase> getP1PriorityCasesDisplay() {
       
        display_P1PriorityCaseslist = new List<wrapcase>();
         for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID ) And (Priority='P1–Level 1–Catastrophic service failure')  order by LastModifiedDate desc LIMIT 100])
        {    
            display_P1PriorityCaseslist.add(new wrapcase(c));
        }
        return display_P1PriorityCaseslist ; //return the list of full records plus their row counter
    }  
     
     public List<wrapcase> getP2PriorityCasesDisplay() {
       
        display_P2PriorityCaseslist = new List<wrapcase>();
         for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID ) And (Priority='P2–Level 2–Service failure')  order by LastModifiedDate desc LIMIT 100])
        {    
            display_P2PriorityCaseslist.add(new wrapcase(c));
        }
        return display_P2PriorityCaseslist ; //return the list of full records plus their row counter
    }  
      
      public List<wrapcase> getP3PriorityCasesDisplay() {
       
        display_P3PriorityCaseslist = new List<wrapcase>();
         for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID ) And (Priority='P3–Level 3–Limited loss of service')  order by LastModifiedDate desc LIMIT 100])
        {    
            display_P3PriorityCaseslist.add(new wrapcase(c));
        }
        return display_P3PriorityCaseslist ; //return the list of full records plus their row counter
    }  
    
      public List<wrapcase> getP4PriorityCasesDisplay() {
       
        display_P4PriorityCaseslist = new List<wrapcase>();
         for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID ) And (Priority='P4–Level 4–No impact to service')  order by LastModifiedDate desc LIMIT 100])
        {    
            display_P4PriorityCaseslist.add(new wrapcase(c));
        }
         return display_P4PriorityCaseslist ;
        }
 public List<wrapcase> getNewCasesDisplay() {
    
        display_newcaselist= new List<wrapcase>(); 
       
         for(case c:[SELECT id, Recordtype.Name , Community_Last_Modified_User__c,subject, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID ) And Status ='New' order by LastModifiedDate desc LIMIT 100])
        {    
           display_newcaselist.add(new wrapcase(c));//with c, add style here. Create 4 syleclass( in 
        }
        system.debug('New Case List on Case Detail Page------->'+display_newcaselist);
        return display_newcaselist; 
    }
public List<wrapcase> getAckCasesDisplay() {
        
        display_ackcaselist = new List<wrapcase>(); 
         for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID ) And Status ='Acknowledged' order by LastModifiedDate desc LIMIT 100])
        {    
        display_ackcaselist.add(new wrapcase(c));
        }
        return display_ackcaselist ; 
    }
    
    //method to display CLOSEDCASES
     public List<wrapcase> getClosedCasesDisplay() {
      
        display_closedcaselist = new List<wrapcase>(); 
         for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID ) And (Status ='Closed' )  order by LastModifiedDate desc LIMIT 100])
        {    
        display_closedcaselist.add(new wrapcase(c));
        }
        return display_closedcaselist ; 
    }
    
    
    //method to display RESOLVED
     public List<wrapcase> getResolvedCasesDisplay() {
      
        display_resolvedcaselist = new List<wrapcase>(); 
         for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID ) And (Status ='Resolved')  order by LastModifiedDate desc LIMIT 100])
        {    
        display_resolvedcaselist.add(new wrapcase(c));
        }
        return display_resolvedcaselist ; 
    }
    
    //method to display WorkingCASES   
  public List<wrapcase> getWorkingCasesDisplay() {
        
        display_workingcaselist = new List<wrapcase>(); 
         for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID ) And Status ='Working' order by LastModifiedDate desc LIMIT 100])
        {    
        display_workingcaselist.add(new wrapcase(c));
        }
        return display_workingcaselist ; 
    }   
       public PageReference ShowPriorityCases() {
 
         System.debug('ShowPriorityCases'+renderedAllTable);   
        return null;
    }
    
 public PageReference ShowStatusCases() {
 
        System.debug('ShowPriorityCases'+renderedAllTable);
        return null;
    }     
 /*   public PageReference save() {
    
    insert Enhancement;
    
   
   
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          String Body= 'Account Name:' +Enhancement.Account_Name__c+ '<br></br> Contact Name : ' +Enhancement.Contact_Name__c +'<br></br> Subject : ' + Enhancement.Subject__c +'<br></br> Description : ' + Enhancement.Description__c
+'<br></br> Case Type : ' + Enhancement.Case_Type__c+

'<br></br> Product: ' + Enhancement.Product__c

  + '<br></br> This is an auto-generated  email sent from an unmonitored mailbox.'+
'Please do not reply to this email ';

String Subject = 'Predix -' + ' ' +Enhancement.Subject__c;
   
   String[] toAddresses = new String[] {'nehal.jain@birlasoft.com','nehal.jain@ge.com'}; 
   String[] ccAddresses = new String[] {'akanksha.singh@birlasoft.com','sunayana.kushwaha@birlasoft.com','pragati.goel@birlasoft.com'};
   mail.setToAddresses(toAddresses);
   mail.setCcAddresses(ccAddresses);
  // mail.setReplyTo('nehal.jain@birlasoft.com');
  // mail.setSenderDisplayName('userinfo.getuserid()');
   mail.setSubject(Subject);
   mail.setHTMLBody(Body);
   mail.setBccSender(false);
   mail.setUseSignature(false);
   mail.setPlainTextBody('This is test email body for Enhancement Feedback section. This mail is being sent from apex code');
   //mail.setHtmlBody('<b> This is HTML body </b>' );
   mail.saveasactivity = false;
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   
   /*PageReference pg= new PageReference('/apex/Predix_demo_page');
   pg.setRedirect(true);
   return pg;*/
  // return null;
    
  // }
    


    public List<wrapcase> getRecentCasesDisplay() {
      
        display_recentcaselist= new List<wrapcase>(); 
        
        //Map<Id, Case> mapCases = new Map<Id, Case>([SELECT id,Case_Record_Type__c,subject,CaseNumber,createdDate, status,priority,description  FROM Case WHERE recordtypeID in  :AllowedRecordtypeID AND createdByID = :UserInfo.GetUserID() AND ( priority!='Other' AND priority!='' AND priority!='high' AND priority!='medium' AND priority!='low' AND priority!='critical') AND ( status!='open') order by LastViewedDate desc limit 50]);
        //In order to remove error for Last View date not found, Sunayana
        Map<Id, Case> mapCases = new Map<Id, Case>([SELECT id,Case_Record_Type__c,subject,CaseNumber,createdDate, status,priority,description  FROM Case WHERE recordtypeID in  :AllowedRecordtypeID AND createdByID = :UserInfo.GetUserID() AND ( priority!='Other' AND priority!='' AND priority!='high' AND priority!='medium' AND priority!='low' AND priority!='critical') AND ( status!='open') limit 50 FOR VIEW]);
 
         List<EntitySubscription> lstEntitysubs = [select id, parentid, subscriberid, subscriber.name from EntitySubscription where (subscriberid =:UserInfo.getUserId() AND ParentId in :mapCases.KeySet()) Limit 1000];
         
         Map<Id, Id> mapEntitySubs =  new Map<Id, Id>();
         for(EntitySubscription es : lstEntitysubs){
              mapEntitySubs.put(es.ParentId, es.Id);
             }
         for(case c:mapCases.values())
        {    

        if(mapEntitySubs.get(c.Id)!=null){
        wrapcase obj = new wrapcase(c);
        obj.HasFollow = 'UnFollow';
        display_recentcaselist.add(obj);
        }
        else{
        wrapcase obj = new wrapcase(c);
        obj.HasFollow = 'Follow';
        display_recentcaselist.add(obj);
        }
        
        }
        system.debug('display_recentcaselist--->'+display_recentcaselist);
        return display_recentcaselist; //return the list of full records plus their row counter
        
    }
    
    
  /*  public List<wrapFeedsData> getfeedItems()
     { 
     
        List<wrapFeedsData> wrapFeeds = new List<wrapFeedsData>();
        List<Id> ids = New List<ID>();
        Date d = Date.today();
        String s = d.month()+'/'+d.day()+'/'+d.year();
        If ( Predix_Feed_Item__c.getValues(String.ValueOf(s)) !=null)
        {
        Ids = Predix_Feed_Item__c.getValues(String.ValueOf(s)).Record_Id__c.Split(',');
        
        List<FeedItem> fietms = [Select ID,Body,CreatedDate, Parent.Type,InsertedBy.Name 
        From FeedItem Where Type = 'TextPost' 
        and InsertedById=:userInfo.getuserId() 
        and id in : ids
        
        order by createdDate desc Limit 15 ]; 
        
        
        
        // To replace the body of FeedItem as it is in RichText field.
        For(FeedItem fi :  fietms )
        {             
             fi.body = fi.body.replaceAll('<[^>]+>',' '); 
             wrapFeeds.Add( New wrapFeedsData(fi));   
        }
        
        return wrapFeeds ;
        }
        
        else
        {
         return null;
        }
          
     }  
     
      public List<wrapFeedsData> getFeedComments()
      {
     
           List<wrapFeedsData> wrapcomms = new List<wrapFeedsData>();
           Set<ID> fids = New Set<ID>();
           
           
           List<FeedComment> fcomments = [SELECT Id,CommentBody,CreatedDate,Insertedby.Name,FeedItemId
           FROM FeedComment where InsertedById =:userInfo.getuserId() order by createdDate desc Limit 15];
           
            
           For( FeedComment fi : fcomments )
           {
              fids.add(fi.FeedItemId);
           }
           
           Map<Id,FeedItem> fitems = New Map<ID,FeedItem>(
           [Select ID, Parent.Type,InsertedBy.Name From FeedItem where id in : fids ]);
                         
           
           
           For( FeedComment fc : fcomments )
           {
             wrapcomms.Add( New wrapFeedsData(fc, fitems.get(fc.FeedItemId).Parent.Type));    
           }
           
           return wrapcomms ; 
        
       }*/
       
       
        
        
       
      /*  Public PageReference feedcommReferesh()
        {
           getfeedItems();
           getFeedComments();
           return null;
        }*/
        
      
   /*     Public static string calculateTimeOfFeeds(DateTime FeedCreatedTime)
        {
        
        String resultTime ;
        
        Datetime FeedTime = FeedCreatedTime ;
        Datetime currentTime = DateTime.now() ;
        
        decimal decHours = ((currentTime.getTime())/1000/60/60) - ((FeedTime.getTime())/1000/60/60);
        decimal decMinutes = ((currentTime.getTime())/1000/60) - ((FeedTime.getTime())/1000/60);

        System.Debug( decHours + ' min  ' + decMinutes  );
        If( decMinutes <= 60 ){
            resultTime = decMinutes + ' min(s) ago ';
        }
        Else If( decHours >=1 && decHours <=23){
            resultTime = decHours + ' hour(s) ago ';
        }
        Else If ( decHours >=24 )
        {
            integer intDays =  FeedTime.Date().daysBetween(currentTime.Date());
            
            resultTime =  intDays + ' day(s) ago ';
        }
        
        return resultTime ;
        
       }*/
        
       /* Public List<wrapFeedsData> getNewsFeed() 
        {
            ConnectApi.FeedItemPage feed = ConnectApi.ChatterFeeds.getFeedItemsFromFeed(null, ConnectApi.FeedType.News, 'me');     
            
            List<wrapFeedsData> result = new List<wrapFeedsData>();
            for (ConnectApi.FeedItem item : feed.items) {
            result.add(new wrapFeedsData(item, FeedFormatter.formatBodyText(item.body)));
            }            
            
            return result;
        }*/
        
        public void ShowCommentsOnFeeds(){

   display_feedCommentsList = new List<wrapFeedComments>();
   
 if(isCommunityUser)
   {
       if(!test.isRunningTest())
         CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId() and ContactId != null   limit 1 ];
system.debug('=======CommentCurUser======'+CurUser);
        Set<Id> Id11= new Set<Id>();
        for(Case  caselst : [SELECT Id,caseNumber FROM Case Where accountId=:CurUser.Contact.AccountID AND 
    recordtypeID in  :AllowedRecordtypeID  limit 99]){
Id11.add(caselst.Id);
system.debug('=======Commentcaselst======'+caselst);
}
   Set<id>Id1s = new Set<id>();
for(CaseFeed cf : [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' and parentid in :Id11 limit 20]){
Id1s.add(cf.Id);
system.debug('=======Commentcf======'+cf);
}

Set<id>Ids = new Set<id>();
for(FeedItem fitem : [SELECT Id,ParentId FROM FeedItem Where Type = 'TextPost' and parentid in :Id11 and Id in : Id1s  limit 20]){
Ids.add(fitem.Id);
system.debug('=======Commentfitem======'+fitem);
}
        listFeedComment = new list<FeedComment>([Select CommentBody,CommentType,CreatedById,CreatedDate,FeedItemId,Id,ParentId from FeedComment Where CommentType = 'TextComment' 
        and parentid in :Id11 and FeedItemId in : Ids ORDER BY CreatedDate DESC LIMIT 20]);
        
        for(FeedComment tmpFeedComment : listFeedComment )
        {system.debug('======tmpFeedComment ==='+tmpFeedComment);
         
          string  tmpStr = tmpFeedComment.CommentBody;
           // tmpFeedItem.body = tmpStr.subString(4,tmpStr.length() -4);
            tmpFeedComment.CommentBody = tmpStr.replaceAll('<[^>]+>',' ');
            string strDT = getDateTimeFeeds(tmpFeedComment.createddate);
            
            display_feedCommentsList.add(new wrapFeedComments(tmpFeedComment,strDT ));
        }
   } else {
     
       CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()    limit 1 ];
system.debug('=======CommentCurUser======'+CurUser);
        Set<Id> Id11= new Set<Id>();
        for(Case  caselst : [SELECT Id,caseNumber FROM Case Where accountId=:CurUser.Contact.AccountID limit 99]){
Id11.add(caselst.Id);
system.debug('=======CommentCaselst======'+caselst);
}
Set<id>Id1s = new Set<id>();
for(CaseFeed cf : [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' and parentid in :Id11 limit 20]){
Id1s.add(cf.Id);
system.debug('=======Commentcf======'+cf);
}

Set<id>Ids = new Set<id>();
for(FeedItem fitem : [SELECT Id,ParentId FROM FeedItem Where Type = 'TextPost' and parentid in :Id11 and Id in : Id1s  limit 20]){
Ids.add(fitem.Id);
system.debug('=======Commentfitem======'+fitem);
}
        listFeedComment = new list<FeedComment>([Select CommentBody,CommentType,CreatedById,CreatedDate,FeedItemId,Id,ParentId from FeedComment Where CommentType = 'TextComment' 
        and parentid in :Id11 and FeedItemId in : Ids ORDER BY CreatedDate DESC LIMIT 20]);
        
        for(FeedComment tmpFeedComment : listFeedComment )
        {system.debug('======tmpFeedComment ==='+tmpFeedComment);
         
          string  tmpStr = tmpFeedComment.CommentBody;
           // tmpFeedItem.body = tmpStr.subString(4,tmpStr.length() -4);
            tmpFeedComment.CommentBody = tmpStr.replaceAll('<[^>]+>',' ');
            string strDT = getDateTimeFeeds(tmpFeedComment.createddate);
            
            display_feedCommentsList.add(new wrapFeedComments(tmpFeedComment,strDT ));
        }
   }

system.debug('----display_feedCommentsList----' + display_feedCommentsList);
} 


        public void ShowFeed_Comment(){
  
        display_feedItemList = new List<wrapFeedItems>();
       

if(isCommunityUser)
   {
       if(!test.isRunningTest())
        CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId() and ContactId != null   limit 1 ];
system.debug('=======FeedCurUser======'+CurUser);
        Set<Id> Id1= new Set<Id>();
        for(Case  caselst : [SELECT Id,caseNumber FROM Case Where accountId=:CurUser.Contact.AccountID AND 
    recordtypeID in  :AllowedRecordtypeID limit 99]){
Id1.add(caselst.Id);
system.debug('=======Feedcf======'+caselst);
}
Set<id>Ids = new Set<id>();
for(CaseFeed  cf : [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' and parentid in :Id1 limit 99]){
Ids.add(cf.Id);
system.debug('=======Feedcf======'+cf);
}
        listFeedItem = new list<FeedItem>([Select ID,Body,CreatedDate,  CreatedBy.Name, Parent.Type,InsertedBy.Name, (SELECT CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes)
        From FeedItem Where Type = 'TextPost' 
        and parentid in :Id1 and Id in: Ids ORDER BY CreatedDate DESC LIMIT 20]);
system.debug('======listFeedItem ==='+listFeedItem );
        
        for(FeedItem tmpFeedItem : listFeedItem )
        {
            string tmpStr = tmpFeedItem.body;
           // tmpFeedItem.body = tmpStr.subString(4,tmpStr.length() -4);
            tmpFeedItem.body = tmpStr.replaceAll('<[^>]+>',' ');
            string strDT = getDateTimeFeeds(tmpFeedItem.createddate);
            
            display_feedItemList.add(new wrapFeedItems(tmpFeedItem, strDT ));
        }

     system.debug('======listFeedItem ==='+display_feedItemList);
     
   }else {
        if(!test.isRunningTest())
       CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()    limit 1 ];
system.debug('=======FeedCurUser======'+CurUser);
        Set<Id> Id1= new Set<Id>();
        for(Case  caselst : [SELECT Id,caseNumber FROM Case Where accountId=:CurUser.Contact.AccountID AND 
    recordtypeID in  :AllowedRecordtypeID limit 99]){
Id1.add(caselst.Id);
system.debug('=======Feedcf======'+caselst);
}
Set<id>Ids = new Set<id>();
for(CaseFeed  cf : [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' and parentid in :Id1 limit 99]){
Ids.add(cf.Id);
system.debug('=======Feedcf======'+cf);
}
        listFeedItem = new list<FeedItem>([Select ID,Body,CreatedDate,  CreatedBy.Name, Parent.Type,InsertedBy.Name, (SELECT CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes)
        From FeedItem Where Type = 'TextPost' 
        and parentid in :Id1 and Id in: Ids ORDER BY CreatedDate DESC LIMIT 20]);
system.debug('======listFeedItem ==='+listFeedItem );
        
       
        for(FeedItem tmpFeedItem : listFeedItem )
        {
            string tmpStr = tmpFeedItem.body;
           // tmpFeedItem.body = tmpStr.subString(4,tmpStr.length() -4);
            tmpFeedItem.body = tmpStr.replaceAll('<[^>]+>',' ');
            string strDT = getDateTimeFeeds(tmpFeedItem.createddate);
            
            display_feedItemList.add(new wrapFeedItems(tmpFeedItem, strDT ));
        }

     system.debug('======listFeedItem ==='+display_feedItemList);
       
   }
} 


public class wrapFeedComments{
public FeedComment feedCommentObject{get;set;}
 //public string  commentToAdd {get;set;}
    public string dateTimeFeed{get;set;}
public wrapFeedComments(FeedComment fcc, string strDT){
         feedCommentObject=fcc;
         dateTimeFeed = strDT;
         
       }
 }
 
        
        public class wrapFeedItems{
    
    public FeedItem feedItemObject{get;set;}
    public string dateTimeFeed{get;set;}
 
        public wrapFeedItems(FeedItem fi, string strDT){
         feedItemObject=fi;
         dateTimeFeed = strDT;
         
       }
}
        //DateTime on Feeds
    Public string getDateTimeFeeds(DateTime tmpCreatedTime )
    {
        //DateTime tmpCreatedTime = tmpFeedItem.CreatedDate;
        DateTime tmpNow = DateTime.Now();
        
        
        decimal decHours = ((tmpNow.getTime())/1000/60/60) - ((tmpCreatedTime.getTime())/1000/60/60);
        decimal decMinutes = ((tmpNow.getTime())/1000/60) - ((tmpCreatedTime.getTime())/1000/60);
        
        if(decHours < 24)
        {
            string tmpDateTime = 'Today at ' + tmpCreatedTime.format('hh:mm a');

            return tmpDateTime;
        }
        else if (decHours > 24 && decHours <= 48)
         {
             string tmpdateTime = 'Yesterday at ' + tmpCreatedTime.format('hh:mm a');
             return tmpDateTime;
         }
         else
         {
             string tmpDateTime = tmpCreatedTime.format('MMM dd, YYYY')+ ' at ' + tmpCreatedTime.format('hh:mm a');
             return tmpDateTime;
         }    
    }
        
        
      /*  public class wrapFeedsData
        {
        public ConnectApi.FeedItem feedData { get; private set; }
        public string FeedBody {get;set;}
        public FeedItem feedItem {get;set;}
        public FeedComment feedComment {get;set;}
        public string parentType {get;set;}
        public string timePostedBefore {get; set;}
        
        public wrapFeedsData(ConnectApi.FeedItem fi , string fBody)
        {
           FeedBody =  fBody ;
           feedData = fi ;
           Predixdashboardpagecontroller.calculateTimeOfFeeds(fi.CreatedDate);   
        }
        
        public wrapFeedsData(FeedComment feedComment , string parentType ){
        
        this.feedComment =  feedComment ;
        this.parentType  = parentType ;
        timePostedBefore = Predixdashboardpagecontroller.calculateTimeOfFeeds(feedComment.CreatedDate);     
        }
        
        public wrapFeedsData(FeedItem fitem){
        
        this.feedItem =  fitem;
        timePostedBefore = Predixdashboardpagecontroller.calculateTimeOfFeeds(fitem.CreatedDate);     
        }
        
        }*/
        
        //follow
        
         public PageReference FollowCase(){
        
        
          if(strFollowUnFollow == 'UnFollow'){
              followedCases = new List<EntitySubscription>();   
              followedCases = [select id, parentid, subscriberid, subscriber.name from EntitySubscription where subscriberid =:UserInfo.getUserId()LIMIT 1000]; 
              //set in entity subcription
              for(EntitySubscription tmpES : followedCases)
              {
                  if (tmpES.ParentId == FollowParentId && tmpES.SubscriberId == UserInfo.getUserId())
                   {  
                      system.debug('entered in IF---yes the id exists in ES');
                      delete tmpES;
                      strFollowUnFollow = 'Follow';
                    }  
              }
              
          }
          else{
              EntitySubscription newES = new EntitySubscription();
              newES.ParentId =FollowParentId;
              newES.SubscriberId = UserInfo.getUserId();
              if(Network.getNetworkId() != null){
newES.NetworkId=Network.getNetworkId();
  }

            try{  Insert newES;
              strFollowUnFollow = 'UnFollow';
          }
          catch(DMLException  e)
              {
                   system.debug('DML Exception: ' + e);
                  //  return null;
                  
                 //  PageReference pg= new PageReference('/apex/Predix_casedetail_pageNew');
                  // pg.setRedirect(false);
                  // return pg;
              }
          }
                 
          
          system.debug('exit out of IF---NO the id exist in ES');
          system.debug('insert done in ES');
          return null;
    } 
    public String strFollowUnFollow{get;set;}
   
    

public class wrapcase{
    
    public case caseObj{get;set;}
    public boolean isSelected{get;set;}
    public String HasFollow{get;set;}
   // public Integer numberOfRow {get; set;} 
      
      /* public wrapcase(case c, Integer rowCounter){
         caseObj=c;
         isselected=false;
         this.numberOfRow = rowCounter;}*/
         public wrapcase(case c){
         caseObj=c;
         isselected=false;
         
       }
  
}    

}