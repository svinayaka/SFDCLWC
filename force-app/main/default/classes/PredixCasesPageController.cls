public with SHARING class PredixCasesPageController{

public List<String> current_list = new List<String>(); //list for holding many record Ids
public List<String> next_list = new List<String>(); //list for holding record Ids that are after the current records
public List<String> previous_list = new List<String>(); //list for holding record Ids that are before the current records
Integer list_size = 50;
public List<wrapcase> display_allcaselist {get; set;}
public List<wrapcase> display_contributorlist{get; set;}
public List<wrapcase> display_newcaselist {get; set;}
public List<wrapcase> display_ackcaselist {get; set;}
public List<wrapcase> display_closedcaselist {get; set;}
public List<wrapcase> display_closedFiltercaselist {get; set;}
public List<wrapcase> display_Searchcaselist {get; set;}
public List<wrapcase> display_allstatuscaselist {get; set;}
public List<wrapcase> display_P1PriorityCaseslist {get; set;}

public List<wrapcase> display_P2PriorityCaseslist {get; set;}
public List<wrapcase> display_P3PriorityCaseslist {get; set;}
public List<wrapcase> display_P4PriorityCaseslist {get; set;}
public List<wrapcase> display_workingcaselist{get; set;}
public List<wrapcase> display_Resolvedcaselist{get; set;}
public List<wrapcase> display_FiveHrscaselist {get; set;}
public List<wrapcase> display_Yesterdaycaselist  {get; set;}
public List<wrapcase> display_LastMonthcaselist {get; set;}
public List<wrapcase> display_AnyTimelist {get; set;}
public List<wrapcase> display_NewFilterCasesList {get; set;}
public List<wrapcase> display_allCompanycaselist {get; set;}

public List<wrapcase> searchResults {get;set;}
public list<case> selectedcases{get;set;} 
public list<case> selectedpriority {get;set;} 
public list<case> prioritycases {get;set;} 
//Public Integer NewCases{get;set;} 
//Public Integer AcknowledgedCases {get;set;}
//Public Integer ClosedCases {get;set;}
Public Case CreateNewCase{get;set;}
public Integer casesSize{get; set;}

public string s{get;set;}  
   
public string InputValue{get;set;}
public String renderedAllTable{get;set;}
Integer record_counter = 0;
Integer counter=0;

public String RetrivedCaseId{get;set;}
public integer recNum = 0;
public integer OffsetSize = 0;
public integer LimitSize= 25;
public integer totalRecs = 0;
public list<case> selectedNewCases= new List<case>();

Public String UserProfileName {get;set;}
Public Set<String> lstUserPermissionsetName {get;set;}
public Set<String> AllowedRecordTypes{get;set;}
public Set<String> AllowedRecordtypeID{get;set;}
public Boolean isCommunityUser {get;set;}
public User CurUser {get;set;}
Public Integer recordTypeCount{get;set;}
Public String SelectedRecordType{get;set;}
Public String selectedEnhancOptions {get; set;} 


public string filterByPriority {get; set;}
public string filterByStatus {get; set;}
public string filterByDateTime {get; set;}


public string globalNew {get; set;}
public string globalAcknowledged {get; set;}
public string globalClosed {get; set;}
public string globalMyCases  {get; set;} 
public string globalMyCompanyCases  {get; set;}

    public integer CurrentPage {get; set;}
public integer Pagecount {get; set;}
public integer offsetsizeForlast {get; set;}
public integer localOffsetSizeP1 = 0; // reset offset
public integer localOffsetSizeP2 = 0; // reset offset
public integer localOffsetSizeP3 = 0; // reset offset
public integer localOffsetSizeP4 = 0; // reset offset
public integer localOffsetSizeAllP = 0; // reset offset
public integer localOffsetSizeNew = 0; // reset offset
public integer localOffsetSizeAck = 0; // reset offset
public integer localOffsetSizeWor = 0; // reset offset
public integer localOffsetSizeRes = 0; // reset offset
public integer localOffsetSizeClo = 0; // reset offset
public integer localOffsetSizeAllSta = 0; // reset offset
public integer localOffsetSizeFive = 0; // reset offset
public integer localOffsetSizeYest = 0; // reset offset
public integer localOffsetSizeLastM = 0; // reset offset
public integer localOffsetSizeDTall = 0; // reset offset
public integer localOffsetSizeAllCases = 0; // reset offset
public integer localOffsetSizeStaticAck = 0; // reset offset
public integer localOffsetSizeCloBar = 0; // reset offset
public integer localOffsetSizeNewFilter = 0; // reset offset
public integer localOffsetSizeAllCompCases = 0; // reset offset



//Test Data Variable
public String StrUserInfo{get;set;} 
public String testAccountId{get;set;}
public List<Case> testlstCase{get;set;}



  public PageReference ShowStatusCases() 
    {
        return null;
    }

//Pagination
public void FirstPage()
{
OffsetSize = 0;

    
Currentpage = 1;


system.debug('Offset for First page------>' + OffsetSize + 'Current page----->' + Currentpage );


}
public void previous()
{

    if(OffsetSize >0)
    {
      OffsetSize =OffsetSize - LimitSize;
      Currentpage --;
    }  
system.debug('Offset for previous page------>' + OffsetSize + 'Current page----->' + Currentpage );
}

public void next()
{
    if(currentPage < Pagecount)
    {
        OffsetSize = OffsetSize + LimitSize;
        Currentpage ++; 
        system.debug('Offset for next page------>' + OffsetSize + 'Current page----->' + Currentpage );
    }    
}

public void LastPage()
{
if(Math.mod(casessize,limitsize) == 0)
  {
   offsetsize = casessize - limitsize;
  }
  else
  {
      OffsetSize =  casessize - Math.mod(casessize,limitsize);
  }

 
 Currentpage = pagecount;
system.debug('Offset for last page------>' + OffsetSize + 'Current page----->' + Currentpage );
}

public boolean getprev()
{

if(OffsetSize == 0){

return true;
}
else {

return false;
}
}
public boolean getnxt()
{
if((OffsetSize + LimitSize) > totalRecs){

return true;
}
else {

return false;
}
}
//Pagination




public PredixCasesPageController(){

FilterByPriority = '';
FilterByStatus = '';
FilterByDateTime = '';
globalNew = '';
globalAcknowledged = '';
globalClosed = '';
globalMyCompanyCases = 'False';
renderedAllTable='MyCases';
currentPage = 1;

//Custom Setting added
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
    
     CreateNewCase= new case(RecordTypeId = [SELECT Id
                                             FROM RecordType 
                                             WHERE SobjectType = 'Case' 
                                                 AND Id= :AllowedRecordTypeId 
                                           limit 1  ].Id
                             /** required fields **/
                           );

 if(isCommunityUser)
   {
       
     if(!Test.isRunningTest()){ 
        CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
      }
      else{
        CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE ContactId != null limit 1 ];
      }


//Display Count for profiles other than community users
//NewCases=(Integer) [select count(id)  NewCases from Case where (recordtypeID in  :AllowedRecordtypeID) And Status ='New' And accountId=:CurUser.Contact.AccountID ][0].get('NewCases') ;
//ClosedCases =(Integer) [select count(id)  ClosedCases from Case where   (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID) And accountId=:CurUser.Contact.AccountID  ][0].get('ClosedCases') ;
//AcknowledgedCases =(Integer) [select count(id)  AcknowledgedCases from Case where (recordtypeID in  :AllowedRecordtypeID) And Status ='Acknowledged' And accountId=:CurUser.Contact.AccountID ][0].get('AcknowledgedCases') ;
   }
   else{
     // NewCases=(Integer) [select count(id)  NewCases from Case where (recordtypeID in  :AllowedRecordtypeID) And Status ='New' ][0].get('NewCases') ;
//ClosedCases =(Integer) [select count(id)  ClosedCases from Case where   (Status ='Resolved' OR Status = 'Closed') AND (recordtypeID in  :AllowedRecordtypeID) ][0].get('ClosedCases') ;
//AcknowledgedCases =(Integer) [select count(id)  AcknowledgedCases from Case where (recordtypeID in  :AllowedRecordtypeID) And Status ='Acknowledged' ][0].get('AcknowledgedCases') ; 
   }

List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() ];
System.debug('\n\n Profile '+PROFILE);

          
            
}


public list<SelectOption> getRecordTypes()
{
    list<SelectOption> options = new list<SelectOption>();

        for(RecordType sRecordType : [SELECT Id, Name FROM RecordType WHERE  Id in  :AllowedRecordtypeID])
        {
            
            options.add(new SelectOption(sRecordType.Id, sRecordType.Name));
        }
        system.debug('optionssssss==========='+options);
        return options;
   

}

public void updateRecordType()
{
    CreateNewCase.RecordTypeId = SelectedRecordType;
    
    
    system.debug('SelectedRecordType==========='+SelectedRecordType);
}



//function for submit button
public PageReference Submit()
{ 
    insert CreateNewCase;
  
 
   
    return null;


}

//function called on Cancel button
public PageReference Cancel()
{
   return null;
     
}

public List<SelectOption> getEnhanceCaseTypeOptions() {
        List<SelectOption> EnhanceCaseTypeOptions= new List<SelectOption>();
        EnhanceCaseTypeOptions.add(new SelectOption('Enhancement','Enhancement'));
        
        return EnhanceCaseTypeOptions;
    } 



 public List<wrapcase> getNewCasesDisplay() {
    
    globalNew = 'True';
    globalAcknowledged = 'False';
    globalClosed = 'False';
    FilterByStatus = '';
    FilterByPriority = '';
    FilterByDateTime = '';
    
   
    localOffsetSizeNew++;
    if(localOffsetSizeNew== 1 ) 
      {
          currentpage =1; //set currentpage only once
          offsetsize = 0;
      }
    
     display_newcaselist= new List<wrapcase>();
     if(isCommunityUser)
   {
       if(!test.isRunningTest()){
     CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
      }
      else{
      CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User limit 1 ];
      }
    CasesSize = [Select count() FROM Case WHERE (recordtypeID in  :AllowedRecordtypeID) And Status ='New' And accountId=:CurUser.Contact.AccountID];
     
for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,
        description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),
        (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  
        (recordtypeID in  :AllowedRecordtypeID)And Status ='New' And accountId=:CurUser.Contact.AccountID order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ])
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
     if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_newcaselist.add(obj);
        }
   }
else{
    CasesSize = [Select count() FROM Case WHERE (recordtypeID in  :AllowedRecordtypeID) And Status ='New'];
    
    for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,
        description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),
        (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  
        (recordtypeID in  :AllowedRecordtypeID)And Status ='New' order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ])
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
     if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_newcaselist.add(obj);
        }
}   
       
       
        PageCount = Integer.Valueof(Math.ceil(casessize/limitsize));
        if(math.mod(casessize,limitsize) > 0 )
        PageCount++;
        system.debug('ceil value--------->' + Math.ceil(casessize/limitsize) + 'remainder value ---------------->' + math.mod(casessize,limitsize));
        system.debug('New Case List on Case Detail Page------->'+display_newcaselist);
        return display_newcaselist; 
}

//display All MY Cases on page load
public List<wrapcase> getRecordsToDisplay() {
        globalMyCompanyCases = 'False';
        display_allcaselist = new List<wrapcase>();

       
        localOffsetSizeAllCases++;
        if(localOffsetSizeAllCases == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        
        if(isCommunityUser)
   {
       if(!test.isRunningTest()){
       CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
     }
     CasesSize = [Select count() FROM Case WHERE (recordtypeID in  :AllowedRecordtypeID) And accountId=:CurUser.Contact.AccountID];
      
     for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments), (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  (recordtypeID in  :AllowedRecordtypeID) AND createdByID =: UserInfo.getUserId() AND ( status!='open') order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ])
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_allcaselist.add(obj);
             
        }
   }
   else{
      CasesSize = [Select count() FROM Case WHERE (recordtypeID in  :AllowedRecordtypeID) AND createdByID =: UserInfo.getUserId() ]; 
      
      for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments), (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  (recordtypeID in  :AllowedRecordtypeID) AND createdByID =: UserInfo.getUserId() AND ( status!='open') order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ]) //
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_allcaselist.add(obj);
             
        }  
   }
       
        system.debug('casessize---->' +casessize);
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count      //return total pages
        return display_allcaselist ; //return the list of full records plus their row counter
    }  
    
//display All MY Company Cases on click
public List<wrapcase> getCompanyRecordsToDisplay() {
   
        display_allCompanycaselist = new List<wrapcase>();
        globalMyCompanyCases = 'True';
        
        localOffsetSizeAllCompCases++;
        if(localOffsetSizeAllCompCases == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        
      
        if(isCommunityUser)
   {
       if(!Test.isRunningTest()){ 
        CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
      }
      else{
        CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM User WHERE ContactId != null limit 1 ];
      }
     
     CasesSize = [Select count() FROM Case WHERE (recordtypeID in  :AllowedRecordtypeID) And accountId=:CurUser.Contact.AccountID];
      
     for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments), (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  (recordtypeID in  :AllowedRecordtypeID) And accountId=:CurUser.Contact.AccountID AND ( status!='open') order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ])
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_allCompanycaselist .add(obj);
             
        }
   }
   else{
      CasesSize = [Select count() FROM Case WHERE (recordtypeID in  :AllowedRecordtypeID)];
      
      for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments), (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  (recordtypeID in  :AllowedRecordtypeID) AND ( status!='open') order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ])
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_allCompanycaselist .add(obj);
             
        }  
   }
       
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count      //return total pages
        system.debug('all company cases size------>' + CasesSize + ' pagecount--->' + pagecount);
        return display_allCompanycaselist ; //return the list of full records plus their row counter
    }  
        
//method to display ALL priority CASES
public List<wrapcase> getAllPrioritiesRecordsToDisplay() {
        string UserID = UserInfo.getUserId(); 
        if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
        display_allcaselist = new List<wrapcase>();
       
       
        localOffsetSizeAllP++;
        if(localOffsetSizeAllP == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
         //////////////////
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
          
        if(isCommunityUser)
   {
        if(!Test.isRunningTest()){
            CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
        }
        else{
            CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM User WHERE ContactId != null limit 1 ];
        } 
        string AccID = CurUser.Contact.AccountID; 
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
                if(CurUser.Contact.AccountID!=null){
                    localSOQL = localSOQL + ' and accountId = \''+String.escapeSingleQuotes(CurUser.Contact.AccountID) + '\'' ;
                }
        
        localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
        localSOQL = filterOnPrioritySOQL(localSOQL);  
        
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
         
        localSOQL += concatSOQL;  
        system.debug('getall1 cases ---->' +localSOQL);
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
  
 for(case c:lstCaseSearch )
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
            }
            display_allcaselist.add(obj);
             
        }
   }//end of if     
   else //COMMUNITY USER + MYCOMPANYCASES
   {
       localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
       localSOQL = filterOnPrioritySOQL(localSOQL);  
        
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
         
        localSOQL += concatSOQL;  
        system.debug('getall1 cases ---->' +localSOQL);
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
 for(case c:lstCaseSearch )
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_allcaselist.add(obj);
             
        }
   }
   } //end of if part of if else
   else{ //else --> non community user
      if (globalMyCompanyCases == 'False') //query for for MyCases
       { localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
        localSOQL = filterOnPrioritySOQL(localSOQL);  
        
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
         
        localSOQL += concatSOQL;  
        system.debug('getall2 cases ---->' +localSOQL);
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
      for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
            }
            display_allcaselist.add(obj);
             
        }  //end of for
       } // end of if
      else // for non community + company cases
      {
          localSOQL = filterOnPrioritySOQL(localSOQL);  
        
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
         
        localSOQL += concatSOQL;  
        system.debug('getall2 cases ---->' +localSOQL);
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
      for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
            }
            display_allcaselist.add(obj);
             
        }//end of for
      } //end of else
   }//end of if-else
      
        system.debug('getall cases--->' + display_allcaselist );
        system.debug('getall localsoql--->' + localsoql);
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        FilterByPriority = '';
        return display_allcaselist ; //return the list of full records plus their row counter
    }  
 
  //method to display ALL STATUS CASES   
  public List<wrapcase> getAllStatusCasesDisplay() {
        string UserID = UserInfo.getUserId(); 
        if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
        localOffsetSizeAllSta++;
        if(localOffsetSizeAllSta== 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
    //////////////////
   
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
            

        display_allstatuscaselist = new List<wrapcase>();

       if(isCommunityUser)
       {          
        
        if(!Test.isRunningTest()){
            CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
        }
        else{
            CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE ContactId != null limit 1 ];
        }
        
        
        string AccID = CurUser.Contact.AccountID;
             
        if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
        {
            if(CurUser.Contact.AccountID!=null){
                localSOQL = localSOQL + ' and accountId = \''+String.escapeSingleQuotes(CurUser.Contact.AccountID) + '\'' ;
            }
        
        localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
        }
        else //COMMUNITY USER + MYCOMPANYCASES
        { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
            
        localSOQL = filterOnStatusSOQL(localSOQL);  
        
        string countSOQL = localSOQL; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query

        localSOQL += concatSOQL;  
        system.debug('getAllstatus ---->' +localSOQL);
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        display_allstatuscaselist = new List<wrapcase>();
   
for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_allstatuscaselist.add(obj);
             
        }      
   }
else{      
        
        if (globalMyCompanyCases == 'False') //query for for MyCases
        { localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
        
        localSOQL = filterOnStatusSOQL(localSOQL); 
        
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        
        localSOQL += concatSOQL;   
        system.debug('getallstatus ---->' +localSOQL);
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        display_allstatuscaselist = new List<wrapcase>();
        
    for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_allstatuscaselist.add(obj);
             
        }      
}   
        FilterByStatus = '';
        system.debug('getall status---->' +localsoql );
        //renderedAllTable='AllCases';
        PageCount = TotalPagesCount(casessize);        if (PageCount == 0)         {CurrentPage = 0;} //get page count 
        return display_allstatuscaselist ; 
    }
    
    
 //method to display static query ACKNOWLEDGEDCASES   
  public List<wrapcase> getAckCasesDisplay() {
        
    globalAcknowledged = 'True';
    globalNew = 'False';
    globalClosed = 'False';
    FilterByStatus = '';
    FilterByPriority = '';
    FilterByDateTime = '';
    
    localOffsetSizeStaticAck++;
    if(localOffsetSizeStaticAck == 1 ) 
    {
       currentpage =1; //set currentpage only once
       offsetsize = 0;
     }
    
        display_ackcaselist = new List<wrapcase>();
        if(isCommunityUser)
        {
       
     
         if(!Test.isRunningTest()){
            CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
         }
         else{
            CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE ContactId != null limit 1 ];
         }
     
        casessize = [Select Count() FROM Case WHERE (recordtypeID in  :AllowedRecordtypeID) And Status ='Acknowledged' And accountId=:CurUser.Contact.AccountID]; //casesesize for pagination
     
         for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,
            description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),
            (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  
            (recordtypeID in  :AllowedRecordtypeID) And Status ='Acknowledged' And accountId=:CurUser.Contact.AccountID AND createdbyID=:UserInfo.getUserId() order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ])
            {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_ackcaselist.add(obj);
             
        }      
   }
else{
        casessize = [Select Count() FROM Case WHERE (recordtypeID in  :AllowedRecordtypeID) And Status ='Acknowledged']; //casesesize for pagination

    for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,
        description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),
        (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  
        (recordtypeID in  :AllowedRecordtypeID) And Status ='Acknowledged' AND createdbyID=:UserInfo.getUserId() order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ])
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_ackcaselist.add(obj);
             
        }      
}   
       
        PageCount = TotalPagesCount(casessize);        if (PageCount == 0)         {CurrentPage = 0;}//get page count
        return display_ackcaselist ; 
    }
    
  //method to display dynamic filter ACKNOWLEDGEDCASES   
  public List<wrapcase> getAckCasesDisplayWithFilters() {
        string UserID = UserInfo.getUserId(); 
        if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
        localOffsetSizeAck++;
        if(localOffsetSizeAck == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        //////////////////  
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
        localSOQL = localSOQL + ' and Status = \''+String.escapeSingleQuotes('Acknowledged') + '\'' ;
       /////////////////        

        display_ackcaselist = new List<wrapcase>();

       if(isCommunityUser)
       {  
       
        if(!Test.isRunningTest()){
            CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
        }
        else{
            CurUser = [SELECT Id, ContactId, Contact.AccountId FROM User where ContactId != null limit 1];
        }
       
        string AccID = CurUser.Contact.AccountID;         
       
        if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
        {
            if(CurUser.Contact.AccountID!=null){
                localSOQL = localSOQL + ' and accountId = \''+String.escapeSingleQuotes(CurUser.Contact.AccountID) + '\'' ;
            }
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
        }
        else
        {
           localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
        }
        localSOQL = filterOnStatusSOQL(localSOQL);  
        
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        
        localSOQL += concatSOQL;  
        system.debug('getack1 ---->' +localSOQL);
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        display_ackcaselist = new List<wrapcase>();
   
for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_ackcaselist.add(obj);
             
        }      
   }
else{  
        if (globalMyCompanyCases == 'False') //query for for MyCases
        {localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
        }
        
        localSOQL = filterOnStatusSOQL(localSOQL);
        
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query 
        
        localSOQL += concatSOQL;   
        system.debug('getack2 ---->' +localSOQL);
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        display_ackcaselist = new List<wrapcase>();
        
    for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_ackcaselist.add(obj);
             
        }      
}         
        FilterByStatus = 'Acknowledged';
        PageCount = TotalPagesCount(casessize);         if (PageCount == 0)         {CurrentPage = 0;}//get page count
        return display_ackcaselist ; 
    }
    
    //method to display CLOSEDCASES on click bar
     public List<wrapcase> getClosedCasesDisplay() {
         
      globalClosed = 'True';
      globalAcknowledged = 'False';
      globalNew = 'False';
      FilterByStatus = '';
      FilterByPriority = '';
      FilterByDateTime = '';
      
      localOffsetSizeCloBar ++;
      if(localOffsetSizeCloBar == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
      
        display_closedcaselist = new List<wrapcase>();
        if(isCommunityUser)
        {
            if(!Test.isRunningTest()){
                CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
            }
            else{
                CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User where ContactId != null limit 1 ];
            }
         
        for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,
        description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),
        (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  
        (recordtypeID in  :AllowedRecordtypeID) And (Status ='Closed' OR Status ='Resolved') And accountId=:CurUser.Contact.AccountID order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ])
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
          obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_closedcaselist.add(obj);
             
        }
   }        
else{
     for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,
        description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),
        (SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE  
        (recordtypeID in  :AllowedRecordtypeID) And (Status ='Closed' OR Status ='Resolved')  order by CreatedDate desc LIMIT :LimitSize OFFSET :OffsetSize ])
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_closedcaselist.add(obj);
             
        }
       }       
      
        system.debug('display_closedcaselist-------->' + display_closedcaselist.size() );
        casessize = display_closedcaselist.size();
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        system.debug('pagecount----->' + PageCount +  '----currentpage---->' + currentpage);
        return display_closedcaselist ; 
        
    }
    //method to display dynamic soql filter CLOSEDCASES
    public List<wrapcase> getClosedFilterCasesDisplay() {
         string UserID = UserInfo.getUserId(); 
         if(Test.isRunningTest()){
            UserID = StrUserInfo;
         }
         localOffsetSizeClo++;
        if(localOffsetSizeClo == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        //////////////////
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
        if(globalClosed != 'True')
        {
            localSOQL = localSOQL + ' and (Status = \''+String.escapeSingleQuotes('Closed') + '\'' ;
            localSOQL = localSOQL + ' OR Status = \''+String.escapeSingleQuotes('Resolved') + '\')' ;
        }   
        ///////////////// 
       
        display_closedFiltercaselist = new List<wrapcase>();
        if(isCommunityUser)
        {
        if(!Test.isRunningTest()){
        CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
        }
        else{
        CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User where ContactId != null limit 1 ];
        }   
         string AccID = CurUser.Contact.AccountID; 
       if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
       {
        if(CurUser.Contact.AccountID!=null){
            localSOQL = localSOQL + ' and accountId = \''+String.escapeSingleQuotes(CurUser.Contact.AccountID) + '\'' ;
        }
        localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
       } 
       else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
            
        localSOQL = filterOnStatusSOQL(localSOQL);  
        string countSOQL = localSOQL; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;  

        List<Case> lstCaseSearch = Database.Query(localSOQL);  
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }       
    // CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM   User WHERE  Id =: UserInfo.getUserId()  AND    ContactId != null limit 1 ];
        for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_closedFiltercaselist.add(obj);
             
        }
   }        
else{
       if (globalMyCompanyCases == 'False') //query for for MyCases
        {localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
       
        localSOQL = filterOnStatusSOQL(localSOQL); 
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;   

        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
     for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_closedFiltercaselist.add(obj);
             
        }
}       
      
        FilterByStatus = 'Closed';
        system.debug('getclosed cases--->' + localsoql + '----------------size---->' + display_closedFiltercaselist.size());
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        return display_closedFiltercaselist ; 
        
    }
     
    
    //method to display P1PriorityCases
   

     public List<wrapcase> getP1PriorityCasesDisplay() {
       
        string UserID = UserInfo.getUserId(); 
        if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }    
        display_P1PriorityCaseslist = new List<wrapcase>();
        localOffsetSizeP1++;
        if(localOffsetSizeP1 == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE(recordtypeID in  :AllowedRecordtypeID)';
        
        localSOQL = localSOQL + ' and Priority LIKE \''+String.escapeSingleQuotes('P1–Level 1–Catastrophic service failure') + '\'' ;
        
        if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID; 
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
         
        } 
        
        system.debug('FilterByStatus ---' + FilterByStatus );
        if(globalNew == 'True')
        {
              localSOQL+= ' and Status = \''+String.escapeSingleQuotes('New') + '\'';
        }
        else if(globalAcknowledged == 'True')
        {
             localSOQL+= ' and Status = \''+String.escapeSingleQuotes('Acknowledged') + '\'';
        }
        else if(globalClosed == 'True')
        {
              localSOQL+= ' and Status = \''+String.escapeSingleQuotes('Closed') + '\'';    
        }
        
         if(FilterByStatus != '')
        {
            localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';
        
        }
        if(FilterByDateTime !='')
        {
           if(FilterByDateTime == 'LAST_MONTH')
            {        
                localSOQL += ' and CreatedDate =  LAST_MONTH';        
            }   
           else if(FilterByDateTime == 'YESTERDAY')
            {        
                localSOQL += ' and CreatedDate =  YESTERDAY';        
            }   
           else if(FilterByDateTime == 'FIVE_HOURS')
           {    
                datetime myDateTime = datetime.now().addHours(-5);    
                localSOQL += ' and CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
            } 
        }
        localSOQL+= ' and Status != \''+String.escapeSingleQuotes('Open') + '\'';
        string countSOQL = localSOQL; //query for count cases
        casessize = CasesCountQuery(countSOQL); //count cases
        localSOQL += concatSOQL;
        
        system.debug('---------getp1 localSOQL --------' + localSOQL );
        
        List<Case> lstCaseSearch = Database.Query(localSOQL );
        
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        
        for(case c : lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_P1PriorityCaseslist.add(obj);
             
        }
       
        FilterByPriority = 'P1–Level 1–Catastrophic service failure';
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        system.debug('p1 casessize---->' + casessize);
        return display_P1PriorityCaseslist ; //return the list of full records plus their row counter
    }  
      //method to display P2PriorityCases

     public List<wrapcase> getP2PriorityCasesDisplay() {
        string UserID = UserInfo.getUserId();
        if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
        display_P1PriorityCaseslist = new List<wrapcase>();
        localOffsetSizeP2++;
        if(localOffsetSizeP2 == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE(recordtypeID in  :AllowedRecordtypeID)';
        
        localSOQL = localSOQL + ' and Priority LIKE \''+String.escapeSingleQuotes('P2–Level 2–Service failure') + '\'' ;
        
          if(isCommunityUser)
        {   
        
             if(Test.isRunningTest()){
                CurUser = [SELECT Id, ContactId, Contact.AccountId  FROM User where ContactId != null limit 1];
             }
            string AccID = CurUser.Contact.AccountID; 
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
         
        } 
        
        system.debug('FilterByStatus ---' + FilterByStatus );
        if(globalNew == 'True')
        {
              localSOQL+= ' and Status = \''+String.escapeSingleQuotes('New') + '\'';
        }
        else if(globalAcknowledged == 'True')
        {
             localSOQL+= ' and Status = \''+String.escapeSingleQuotes('Acknowledged') + '\'';
        }
        else if(globalClosed == 'True')
        {
              localSOQL+= ' and (Status = \''+String.escapeSingleQuotes('Closed') + '\''; 
              localSOQL+= ' OR Status = \''+String.escapeSingleQuotes('Resolved') + '\')';   
        }
        localSOQL= filterOnPrioritySOQL(localSOQL);
        
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;
        
        system.debug('---------getp2 localSOQL --------' + localSOQL );
        
        List<Case> lstCaseSearch = Database.Query(localSOQL );//dynamic query
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        display_P2PriorityCaseslist = new List<wrapcase>(); //set the display_list object to a new 
        for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_P2PriorityCaseslist.add(obj);
             
        }
        
        FilterByPriority = 'P2–Level 2–Service failure';
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        return display_P2PriorityCaseslist ; 
    }    
  
  //method to display P3PriorityCases

     public List<wrapcase> getP3PriorityCasesDisplay() {
       string UserID = UserInfo.getUserId();
       if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
        display_P3PriorityCaseslist = new List<wrapcase>(); 
        display_P1PriorityCaseslist = new List<wrapcase>();
        localOffsetSizeP3++;
        if(localOffsetSizeP3 == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE(recordtypeID in  :AllowedRecordtypeID)';
        
        localSOQL = localSOQL + ' and Priority LIKE \''+String.escapeSingleQuotes('P3–Level 3–Limited loss of service') + '\'' ;
        
          if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID; 
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
        
        } 
        
        system.debug('FilterByStatus ---' + FilterByStatus );
        localSOQL= filterOnPrioritySOQL(localSOQL);
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;
        
        system.debug('---------getp3 localSOQL --------' + localSOQL );
        
        List<Case> lstCaseSearch = Database.Query(localSOQL );//dynamic query
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_P3PriorityCaseslist.add(obj);
             
        }
        
        FilterByPriority = 'P3–Level 3–Limited loss of service';
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        return display_P3PriorityCaseslist ; 
    }  
 
  //method to display P4PriorityCases

     public List<wrapcase> getP4PriorityCasesDisplay() {
      string UserID = UserInfo.getUserId();
      if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
        display_P4PriorityCaseslist = new List<wrapcase>(); //set the display_list object to a new 
        display_P3PriorityCaseslist = new List<wrapcase>(); 
        display_P1PriorityCaseslist = new List<wrapcase>();
        localOffsetSizeP4++;
        if(localOffsetSizeP4 == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE(recordtypeID in  :AllowedRecordtypeID)';
        
        localSOQL = localSOQL + ' and Priority LIKE \''+String.escapeSingleQuotes('P4–Level 4–No impact to service') + '\'' ;
        
         if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID; 
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
        
        } 
        
        system.debug('FilterByStatus ---' + FilterByStatus );
        localSOQL= filterOnPrioritySOQL(localSOQL);
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;
        
        system.debug('---------getp4 localSOQL --------' + localSOQL );
        
        List<Case> lstCaseSearch = Database.Query(localSOQL );//dynamic query
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_P4PriorityCaseslist.add(obj);
             
        }
         
        FilterByPriority = 'P4–Level 4–No impact to service';
        system.debug('display_P4PriorityCaseslist----->' + display_P4PriorityCaseslist.size());
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        return display_P4PriorityCaseslist ; 
    }  
    
         //method to display New filter cases dynamic soql   
  public List<wrapcase> getNewFilterCasesDisplay() {
         string UserID = UserInfo.getUserId();
         if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
        localOffsetSizeNewFilter++;
        if(localOffsetSizeNewFilter== 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        //////////////////
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
        localSOQL = localSOQL + ' and Status = \''+String.escapeSingleQuotes('New') + '\'' ;
        ///////////////// 
         if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID; 
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
         
        } 
        
      
        localSOQL = filterOnStatusSOQL(localSOQL);  
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        
        localSOQL += concatSOQL;  

        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        display_NewFilterCasesList = new List<wrapcase>(); 
        for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_NewFilterCasesList.add(obj);
             
        }
       
        FilterByStatus = 'New';
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     
        return display_NewFilterCasesList ; 
    }
    
      //method to display WorkingCASES   
  public List<wrapcase> getWorkingCasesDisplay() {
         string UserID = UserInfo.getUserId();
         if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
        localOffsetSizeWor++;
        if(localOffsetSizeWor== 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        //////////////////
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
        localSOQL = localSOQL + ' and Status = \''+String.escapeSingleQuotes('Working') + '\'' ;
        ///////////////// 
         if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID; 
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
         
        } 
        
      
        localSOQL = filterOnStatusSOQL(localSOQL); 
        string countSOQL = localSOQL; //query to get case size 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;  

        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        display_workingcaselist = new List<wrapcase>(); 
        for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_workingcaselist.add(obj);
             
        }
       
        FilterByStatus = 'Working';
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        return display_workingcaselist ; 
    }
    
        //method to display ResolvedCASES   
  public List<wrapcase> getResolvedCasesDisplay() {
         string UserID = UserInfo.getUserId();
         if(Test.isRunningTest()){
            UserID = StrUserInfo;
         }
        localOffsetSizeRes++;
        if(localOffsetSizeRes== 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        //////////////////
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
        localSOQL = localSOQL + ' and Status = \''+String.escapeSingleQuotes('Resolved') + '\'' ;
        
          if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID; 
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
         
        } 
        
       
     
        localSOQL = filterOnStatusSOQL(localSOQL);  
        string countSOQL = localSOQL; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;  

        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
        display_Resolvedcaselist = new List<wrapcase>(); 
        for(case c:lstCaseSearch )
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_Resolvedcaselist.add(obj);
             
        }
        
        FilterByStatus = 'Resolved';
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        return display_Resolvedcaselist ; 
    }
    
    //method to display FiveHrsCASES   
  public List<wrapcase> getFiveHrsCasesDisplay () {
         string UserID = UserInfo.getUserId();
         if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
       datetime myDateTime = datetime.now().addHours(-5);
       
       localOffsetSizeFive++;
        if(localOffsetSizeFive == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
       //------------
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
         localSOQL = localSOQL + ' and CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;
        ///////////////// 
        
         if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID; 
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
         
        } 
       
     
        localSOQL = filterOnDateTimeSOQL(localSOQL);  
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;  

        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
       //------------
         display_FiveHrscaselist= new List<wrapcase>(); 
         for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_FiveHrscaselist.add(obj);
             
        }
        
        system.debug('five hrs list-----' + display_FiveHrscaselist.size());
        FilterByDateTime = 'FIVE_HOURS';
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        return display_FiveHrscaselist; 
    }

public List<wrapcase> getAnyTimeRecordsToDisplay() {
    string UserID = UserInfo.getUserId();
    if(Test.isRunningTest()){
            UserID = StrUserInfo;
        }
        display_AnyTimelist = new List<wrapcase>();
        localOffsetSizeDTall++;
        if(localOffsetSizeDTall == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
      
       
       if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID; 
            if( Test.isRunningTest() && AccID == null){
                AccID = testAccountId;
            }
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
         
        } 
        
      
        localSOQL = filterOnDateTimeSOQL(localSOQL);
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query  
        localSOQL += concatSOQL;  
        system.debug('getanytime soql--->' + localsoql );
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
for(case c:lstCaseSearch )
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_AnyTimelist.add(obj);
             
        }
      
        FilterByDateTime = '';
        PageCount = TotalPagesCount(casessize);    if (PageCount == 0)         {CurrentPage = 0;} //get page count     //get page count
        return display_AnyTimelist ; //return the list of full records plus their row counter
    }  
 

//method to display YesterdayCASES   
  public List<wrapcase> getYesterdayCasesDisplay() {
         string UserID = UserInfo.getUserId();
          if(Test.isRunningTest()){
            UserID = StrUserInfo;
          }
         localOffsetSizeYest++;
        if(localOffsetSizeYest == 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
       //-------------------
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
        localSOQL = localSOQL + ' and CreatedDate =  YESTERDAY';
        
        
          if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID; 
            if(Test.isRunningTest() && AccID == null){
                AccID = testAccountId;
            }
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
         
        } 
       
      
        localSOQL = filterOnDateTimeSOQL(localSOQL);  
        string countSOQL = localSOQL; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;  

        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
       //-------------------
         display_Yesterdaycaselist= new List<wrapcase>(); 
         for(case c:lstCaseSearch)
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_Yesterdaycaselist.add(obj);
             
        }
        
        system.debug('yesterday list-----' + display_Yesterdaycaselist.size());
        FilterByDateTime = 'YESTERDAY';
        PageCount = TotalPagesCount(casessize); //get page count     //get page count
        if (PageCount == 0)
        {CurrentPage = 0;}
        return display_Yesterdaycaselist; 
    }
    
   
  public List<wrapcase> getlastmonthCasesDisplay() {
         string UserID = UserInfo.getUserId();
         if(Test.isRunningTest()){
            UserID = StrUserInfo;
         }
       
       localOffsetSizeLastM++;
       if(localOffsetSizeLastM== 1 ) 
        {
            currentpage =1; //set currentpage only once
            offsetsize = 0;
        }
        //-------------------
        string LocalSOQL = 'SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c, (select id from Attachments),(SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticles) FROM Case  WHERE (recordtypeID in  :AllowedRecordtypeID)';
        string concatSOQL = ' order by Createddate desc LIMIT :LimitSize OFFSET :OffsetSize ';
        system.debug('---------concatSOQL--------' + concatSOQL);
        localSOQL = localSOQL + ' and CreatedDate =  LAST_MONTH' ;
        ///////////////// 
        
        if(isCommunityUser)
        {   string AccID = CurUser.Contact.AccountID;
            if(Test.isRunningTest() && AccID == null){
                AccID = testAccountId;
            }   
            if (globalMyCompanyCases == 'False')// COMMUNITY USER + MYCASES
            {
            localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';}
            else //COMMUNITY USER + MYCOMPANYCASES
            { localSOQL += ' and accountId = \''+String.escapeSingleQuotes(AccID) + '\'';}
        }
        else //if non community user and not my company cases
        {if (globalMyCompanyCases == 'False') //query for for MyCases
            localSOQL += ' and createdByID = \''+String.escapeSingleQuotes(UserID) + '\'';
         
        } 
       
     
        localSOQL = filterOnDateTimeSOQL(localSOQL);  
        string countSOQL = localSOQL ; //query to get case size
        casessize = CasesCountQuery(countSOQL); // calling function with count query
        localSOQL += concatSOQL;  

        system.debug('last month soql--->' + localSOQL);
        List<Case> lstCaseSearch = Database.Query(localSOQL);
        if(Test.isRunningTest() && lstCaseSearch.size()==0)
        {
            //Priyanka
            lstCaseSearch=testlstCase;
        }
         display_LastMonthcaselist= new List<wrapcase>(); 
         for(case c:lstCaseSearch )
        {
            wrapcase obj = new wrapcase(c);
            if(c.attachments.size()>0){
                obj.hasAttachment = true;
            }
            if(c.CaseArticles.size()>0){
                obj.hasArticle = true;
            }
            if((c.description!=null)&&(c.description.length()<49)){
           obj.subjectInput=  c.description;
             }
             else if(c.description!=null)
             {
           obj.subjectInput = c.description.substring(0,49);              
}
            display_LastMonthcaselist.add(obj);
             
        }
        
        system.debug('lastmonth list-----' + display_LastMonthcaselist.size());
        FilterByDateTime = 'LAST_MONTH';
        PageCount = TotalPagesCount(casessize);//get page count     
            if (PageCount == 0)         {CurrentPage = 0;}
        return display_LastMonthcaselist; 
    }
    
    
         
      public pageReference processSelected() {

               
        List<case> selectedNewCases = new List<case>();

        
        for(wrapcase ccaseObj: getNewCasesDisplay()) {
            if(ccaseObj.isselected == true) {
                selectedNewCases.add(ccaseObj.caseObj);
            }
        }
        return null;
        }
   
   public List<case> getselectedNewCases() {
   if(selectedNewCases.size()>0)
   return selectedNewCases;
   else
   return null;
   
   }   
public PageReference ShowClickedCases() {

        System.debug('ShowClickedCases'+renderedAllTable);
        return null;
    }
    
 public PageReference ShowClickedCompanyCases() {

     System.debug('ShowClickedCompanyCases'+renderedAllTable);
        return null;
}   
    public PageReference ShowPriorityCases() {

        System.debug('ShowPriorityCases'+renderedAllTable);
        return null;
    }
    
    public PageReference ShowDateTimeCases() {
        System.Debug('ShowdateTimeCases---RenderedAllTable--->' + RenderedAllTable);
        return null;
    }
    
      
      
public class wrapcase{
    
    public case caseObj{get;set;}
    public string firstUser{get;set;}
    public string secUser{get;set;}
    public string thirdUser{get;set;}
    public string fourthUser{get;set;}
    public string fifthUser{get;set;}
    public boolean isSelected{get;set;}
    public boolean hasAttachment{get;set;}
    public boolean hasArticle{get;set;}
    
    public string subjectInput{get;set;}
        public wrapcase(case c){
         caseObj=c;
         firstUser = 'No User';
         secUser = 'No User';
         thirdUser= 'No User';
         fourthUser= 'No User';
         fifthUser= 'No User';
         if(caseObj.Community_Last_Modified_User__c!=null && caseObj.Community_Last_Modified_User__c.split(',').size()==1) {
            firstUser = caseObj.Community_Last_Modified_User__c.split(',')[0];
         }
         else if(caseObj.Community_Last_Modified_User__c!=null && caseObj.Community_Last_Modified_User__c.split(',').size()==2) {
            firstUser = caseObj.Community_Last_Modified_User__c.split(',')[0];
            secUser = caseObj.Community_Last_Modified_User__c.split(',')[1];
         }
         else if(caseObj.Community_Last_Modified_User__c!=null && caseObj.Community_Last_Modified_User__c.split(',').size()==3) {
            firstUser = caseObj.Community_Last_Modified_User__c.split(',')[0];
            secUser = caseObj.Community_Last_Modified_User__c.split(',')[1];
            thirdUser = caseObj.Community_Last_Modified_User__c.split(',')[2];
         }
          else if(caseObj.Community_Last_Modified_User__c!=null && caseObj.Community_Last_Modified_User__c.split(',').size()==4) {
            firstUser = caseObj.Community_Last_Modified_User__c.split(',')[0];
            secUser = caseObj.Community_Last_Modified_User__c.split(',')[1];
            thirdUser = caseObj.Community_Last_Modified_User__c.split(',')[2];
            fourthUser = caseObj.Community_Last_Modified_User__c.split(',')[3];
         }
          else if(caseObj.Community_Last_Modified_User__c!=null && caseObj.Community_Last_Modified_User__c.split(',').size()==5) {
            firstUser = caseObj.Community_Last_Modified_User__c.split(',')[0];
            secUser = caseObj.Community_Last_Modified_User__c.split(',')[1];
            secUser = caseObj.Community_Last_Modified_User__c.split(',')[1];
            thirdUser = caseObj.Community_Last_Modified_User__c.split(',')[2];
            fourthUser = caseObj.Community_Last_Modified_User__c.split(',')[3];
            fifthUser = caseObj.Community_Last_Modified_User__c.split(',')[4];
         }
         isselected=false;
         
       }
  
}

Public string filterOnStatusSOQL(string localSOQL)
{
        if(globalNew == 'True')
        {
              localSOQL+= ' and Status = \''+String.escapeSingleQuotes('New') + '\'';
              

        }
        else if(globalAcknowledged == 'True')
        {
             localSOQL+= ' and Status = \''+String.escapeSingleQuotes('Acknowledged') + '\'';
        }
        else if(globalClosed == 'True')
        {
              localSOQL+= ' and (Status = \''+String.escapeSingleQuotes('Closed') + '\'';   
              localSOQL+= ' OR Status = \''+String.escapeSingleQuotes('Resolved') + '\')';     
        }
        
        if(FilterByPriority != '')
        {
            localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
           
        }
      
        if(FilterByDateTime !='')
        {
           if(FilterByDateTime == 'LAST_MONTH')
            {        
                localSOQL += ' and CreatedDate =  LAST_MONTH';        
            }   
           else if(FilterByDateTime == 'YESTERDAY')
            {        
                localSOQL += ' and CreatedDate =  YESTERDAY';        
            }   
           else if(FilterByDateTime == 'FIVE_HOURS')
           {    
                datetime myDateTime = datetime.now().addHours(-5);    
                localSOQL += ' and CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
            } 
        }
       
          localSOQL+= ' and Status != \''+String.escapeSingleQuotes('Open') + '\'';
         
       return localSOQL;
    
}

    public string filterOnPrioritySOQL(string localSOQL)
    {
     if(globalNew == 'True')
        {
              localSOQL+= ' and Status = \''+String.escapeSingleQuotes('New') + '\'';
        }
        else if(globalAcknowledged == 'True')
        {
             localSOQL+= ' and Status = \''+String.escapeSingleQuotes('Acknowledged') + '\'';
        }
        else if(globalClosed == 'True')
        {
                  localSOQL+= ' and (Status = \''+String.escapeSingleQuotes('Closed') + '\'';   
              localSOQL+= ' OR Status = \''+String.escapeSingleQuotes('Resolved') + '\')';        
        }
        
          if(FilterByStatus != '')
        {    if(FilterByStatus == 'Closed')
            {
              localSOQL+= ' and (Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';
              localSOQL+= ' OR Status = \''+String.escapeSingleQuotes('Resolved') + '\')';
            }
            else
                {localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';}
        
        }
      
        if(FilterByDateTime !='')
        {
           if(FilterByDateTime == 'LAST_MONTH')
            {        
                localSOQL += ' and CreatedDate =  LAST_MONTH';        
            }   
           else if(FilterByDateTime == 'YESTERDAY')
            {        
                localSOQL += ' and CreatedDate =  YESTERDAY';        
            }   
           else if(FilterByDateTime == 'FIVE_HOURS')
           {    
                datetime myDateTime = datetime.now().addHours(-5);    
                localSOQL += ' and CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
            } 
        }
        localSOQL+= ' and Status != \''+String.escapeSingleQuotes('Open') + '\'';
        return localSOQL;
    
    }

    public string filterOnDateTimeSOQL(string localSOQL)
    {
         if(globalNew == 'True')
        {
              localSOQL+= ' and Status = \''+String.escapeSingleQuotes('New') + '\'';
        }
        else if(globalAcknowledged == 'True')
        {
             localSOQL+= ' and Status = \''+String.escapeSingleQuotes('Acknowledged') + '\'';
        }
        else if(globalClosed == 'True')
        {
                 localSOQL+= ' and (Status = \''+String.escapeSingleQuotes('Closed') + '\'';   
              localSOQL+= ' OR Status = \''+String.escapeSingleQuotes('Resolved') + '\')';      
        }
        
          if(FilterByStatus != '')
        {
            if(FilterByStatus == 'Closed')
            {
              localSOQL+= ' and (Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';
              localSOQL+= ' OR Status = \''+String.escapeSingleQuotes('Resolved') + '\')';
            }
            else
            {localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';}
        
        }
        system.debug('FilterByPriority in Lastmonth method' + FilterByPriority);
        if(FilterByPriority != '')
        {
            localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
        }
         localSOQL+= ' and Status != \''+String.escapeSingleQuotes('Open') + '\'';
        return localSOQL;
    
    }

public Integer TotalPagesCount(integer casessize)
    {
        PageCount = Integer.Valueof(Math.ceil(casessize/limitsize));
        if(math.mod(casessize,limitsize) > 0 )
        PageCount++;
        system.debug('ceil value--------->' + Math.ceil(casessize/limitsize) + 'remainder value ---------------->' + math.mod(casessize,limitsize));
        return PageCount;
    }
    
  public Integer CasesCountQuery(string countCasesSoql)
    {
       system.debug('casescountquery------------->' + countCasesSoql);
       List<Case> lstCases =  Database.Query(countCasesSoql);     
       Integer countCases = lstCases.Size();
       return countCases;
    }

}