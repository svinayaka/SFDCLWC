public  class CaseDetailControllerNew {
    
    public ID IPSRecTypeID {get;set;}
    public ID UORecTypeID {get;set;}
    public List<wrapcase> display_showallcaselist {get; set;}
    public case getCaseDetails { get; set; }
    public case caseDetails { get; set; }
    public string getCasePriority { get; set; }
    public integer counter { get; set; }
    public string getCaseStatus { get; set; }
    public string caseStatus { get; set;}
    transient public string casePriority { get; set;}
    public String PostComments{get;set;}
    List<EntitySubscription> followers{get;set;}
    List<EntitySubscription> followedCases{get;set;}
    public List<User> lstfollowerUser{get;set;}
    public List<CaseFeed> listCasefeed{get;set;}
    public List<Attachment> listAttachment{get;set;}
    public List<KnowledgeArticleVersion> listKnowledgeArticleVersion{get;set;}
    public Boolean caseFollowing{get;set;}
    Public Case CreateNewCase{get;set;}
    public String feedItemId {get;set;}
    public string firstUser{get;set;}
    public string secUser{get;set;}
    public string thirdUser{get;set;}
    public string fourthUser{get;set;}
    public string fifthUser{get;set;}
    public String renderedAllTable{get;set;}
    public List<wrapFeedItems> display_RecentFeedslist{get; set;}
    public Integer FeedItemsSize {get; set;}
    public boolean hasAttachment{get;set;}
    public boolean hasArticle{get;set;}
    public String commentToAdd {get;set;}
    public String feedItemstatus{get;set;}
Public String UserProfileName {get;set;}
Public Set<String> lstUserPermissionsetName {get;set;}
public Set<String> AllowedRecordTypes{get;set;}
public Set<String> AllowedRecordtypeID{get;set;}
public Boolean isCommunityUser {get;set;}
public User CurUser {get;set;}
Public Integer recordTypeCount{get;set;}
Public String SelectedRecordType{get;set;}
Public String selectedEnhancOptions {get; set;}
Public List<CaseFeed> CaseFeedList {get; set;}
  public List<FeedComment> listFeedComment{get;set;}
     public List<wrapFeedComments> display_feedCommentsList{get;set;}
    //public GetCaseFollow{get;set;}
    public String renderedOutputPanel{get;set;}
    public List<FeedItem> listFeedItem{get;set;}
    public List<wrapFeedItems> display_feedItemList{get;set;}
    public CaseDetailControllerNew ()
    {

    renderedAllTable='AllFeeds'; 
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
    
 //CreateNewCase= new case();

firstUser = 'No User';
         secUser = 'No User';
         thirdUser= 'No User';
         fourthUser= 'No User';
         fifthUser= 'No User';
       string CaseId = apexpages.currentpage().getparameters().get('Id');
       caseDetails = [SELECT GE_PRM_Parent_Id__r.CaseNumber, Contact.Phone,Contact.Email, SuppliedEmail, id, Recordtype.Name ,Account.Name,Contact.Name,GE_OG_Predix_Company__c,GE_OG_Predix_Product__c,GE_ES_INDS_SubSts__c,GE_OG_Case_Issue_Type__c,CaseNumber, status, createddate,owner.name,Priority,Age_Days__c,Origin,Subject,Description,GE_OG_MC_Con_Email__c,GE_Expected_Completion_Date__c, Community_Last_Modified_User__c
       FROM case WHERE Id=: CaseId  LIMIT 1] ;
       
       If(caseDetails!=null){
       if(caseDetails.Community_Last_Modified_User__c!=null && caseDetails.Community_Last_Modified_User__c.split(',').size()==1) {
            firstUser = caseDetails.Community_Last_Modified_User__c.split(',')[0];
         }
         else if(caseDetails.Community_Last_Modified_User__c!=null && caseDetails.Community_Last_Modified_User__c.split(',').size()==2) {
            firstUser = caseDetails.Community_Last_Modified_User__c.split(',')[0];
            secUser = caseDetails.Community_Last_Modified_User__c.split(',')[1];
         }
         else if(caseDetails.Community_Last_Modified_User__c!=null && caseDetails.Community_Last_Modified_User__c.split(',').size()==3) {
            firstUser = caseDetails.Community_Last_Modified_User__c.split(',')[0];
            secUser = caseDetails.Community_Last_Modified_User__c.split(',')[1];
            thirdUser = caseDetails.Community_Last_Modified_User__c.split(',')[2];
         }
          else if(caseDetails.Community_Last_Modified_User__c!=null && caseDetails.Community_Last_Modified_User__c.split(',').size()==4) {
            firstUser = caseDetails.Community_Last_Modified_User__c.split(',')[0];
            secUser = caseDetails.Community_Last_Modified_User__c.split(',')[1];
            thirdUser = caseDetails.Community_Last_Modified_User__c.split(',')[2];
            fourthUser = caseDetails.Community_Last_Modified_User__c.split(',')[3];
         }
          else if(caseDetails.Community_Last_Modified_User__c!=null && caseDetails.Community_Last_Modified_User__c.split(',').size()==5) {
            firstUser = caseDetails.Community_Last_Modified_User__c.split(',')[0];
            secUser = caseDetails.Community_Last_Modified_User__c.split(',')[1];
            secUser = caseDetails.Community_Last_Modified_User__c.split(',')[1];
            thirdUser = caseDetails.Community_Last_Modified_User__c.split(',')[2];
            fourthUser = caseDetails.Community_Last_Modified_User__c.split(',')[3];
            fifthUser = caseDetails.Community_Last_Modified_User__c.split(',')[4];
         }
       }
       GetCaseFollow();
       GetAlllistFollower();
       ShowFeed_Comment();
       ShowlistAttachment();
       ShowArticles();
       renderedOutputPanel='Follow';
       ShowCommentsOnFeeds();      
                    
              
     
    
         
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
    // by me
    
    //RecordType tempRecordObj =[SELECT Id, Name FROM RecordType WHERE sObjectType = 'Case' and ID =:SelectedRecordType];
    //system.debug('+++++tempRecordObj'+tempRecordObj);
  /*   tempCustomsetting=  mapOfStingVsCustomSetting.get(tempRecordObj.name);
           system.debug('****tempCustomsetting**'+tempCustomsetting);
           listOfPriority= tempCustomsetting.Priority__c.split(';');
           listOfStatus= tempCustomsetting.Status__c.split(';');
           system.debug('****listOfPriority**'+listOfPriority);
           system.debug('****listOfStatus**'+listOfStatus);
            system.debug('****tempCustomsetting**'+tempCustomsetting);*/
            
    getRecordTypes();
    
    system.debug('SelectedRecordType==========='+SelectedRecordType);
}



//function for submit button
public PageReference Submit()
{ 
    insert CreateNewCase;
  
 
   /* PageReference pg= new PageReference('/apex/Predix_demo_page');
    pg.setRedirect(true);
    return pg;*/
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

public PageReference ShowRecentActivityFeeds() 
{
 
        System.debug('ShowRecentActivityFeeds'+renderedAllTable);
        return null;
}

      
    //get detail of case
     public case getCaseDetails() {
          
         system.debug('id:'+ caseDetails.id + 'casenumber:' + caseDetails.casenumber );
           string str = caseDetails.priority;
         str = str.substring(0,2);
         caseDetails.priority = str;
         this.casePriority = str;
         system.debug('priority-------->' + casePriority);
       return caseDetails;
    } 
    
    public Pagereference PostComment(){
        system.debug('Post Text----'+PostComments);
        FeedItem post = new FeedItem();
        post.ParentId = caseDetails.Id; //eg. Opportunity id, custom object id..
        post.Body = PostComments;
        //post.Visibility = 'AllUsers';
        try{
        insert post;
        }
        catch(DMLException e)
        {
            System.Debug('---InsertPost DML Exception---' + e);
        }
        ShowFeed_Comment(); 
        return null;
    }

public void addCommentToFeedItem(){
    
  /*  List<FeedItem> myfeed = [Select ID,Body,CreatedDate,  CreatedBy.Name, Parent.Type,InsertedBy.Name, (SELECT CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes) From FeedItem WHERE Type = 'TextPost' AND parentid =:apexpages.currentpage().getparameters().get('Id') LIMIT 1];*/
        FeedComment fcomment = new FeedComment();

        fcomment.FeedItemId = feedItemId; 
       // fcomment.FeedItemId = myfeed.get(0).id;
        fcomment.CommentBody = commentToAdd; 
        system.debug('============='+fcomment);
       try{ insert fcomment;}catch(DMLException e)
        {
            System.Debug('---InsertComment DML Exception---' + e);
        }
        system.debug('============='+fcomment);
       ShowCommentsOnFeeds();
}   





public void ShowCommentsOnFeeds(){

   display_feedCommentsList = new List<wrapFeedComments>();
   
   Set<id>Id1s = new Set<id>();
for(CaseFeed cf : [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' and parentid =:apexpages.currentpage().getparameters().get('Id') limit 20]){
Id1s.add(cf.Id);
}

Set<id>Ids = new Set<id>();
for(FeedItem fitem : [SELECT Id,ParentId, CommentCount FROM FeedItem Where Type = 'TextPost' and parentid =:apexpages.currentpage().getparameters().get('Id') and Id in : Id1s  limit 20]){
Ids.add(fitem.Id);
}
        listFeedComment = new list<FeedComment>([Select CommentBody,CommentType,CreatedById,CreatedDate,FeedItemId,Id,ParentId from FeedComment Where CommentType = 'TextComment' 
        and parentid =:apexpages.currentpage().getparameters().get('Id') and FeedItemId in : Ids ORDER BY CreatedDate DESC LIMIT 20]);
        
        for(FeedComment tmpFeedComment : listFeedComment )
        {system.debug('======tmpFeedComment ==='+tmpFeedComment);
         
          string  tmpStr = tmpFeedComment.CommentBody;
           // tmpFeedItem.body = tmpStr.subString(4,tmpStr.length() -4);
            tmpFeedComment.CommentBody = tmpStr.replaceAll('<[^>]+>',' ');
            string strDT = getDateTimeFeeds(tmpFeedComment.createddate);
            
            display_feedCommentsList.add(new wrapFeedComments(tmpFeedComment,strDT ));
        }


} 
    
    
     public string getCasePriority() {
          string str = caseDetails.priority;
         str = str.substring(0,2);
         caseDetails.priority = str;
         this.casePriority = str;
         system.debug('casepriority-------->' + casePriority);
       
         return casePriority;
    }   
    
    public string getCaseStatus() {
       caseStatus = 'attended' ;
       return 'Attended';
    }   
    
public List<wrapcase> getShowAllCases() {
         display_showallcaselist = new List<wrapcase>(); //set the display_list object to a new accountWrapper List
       string caseNumber = apexpages.currentpage().getparameters().get('caseNumber');

         for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber, status, createddate,owner.name,description,Priority FROM case WHERE caseNumber=: caseNumber LIMIT 1])
        {    
        display_showallcaselist.add(new wrapcase(c));
         }
        return display_showallcaselist ; //return the list of full records plus their row counter
    }  
public void GetAlllistFollower(){
          followers = new List<EntitySubscription>();   
          followers = [select id, subscriberid, subscriber.name from EntitySubscription where parentid =:apexpages.currentpage().getparameters().get('Id') LIMIT 1000]; 
          
          lstfollowerUser = new list<User>();
          Set<Id> setUser = new Set<Id>();
          for(EntitySubscription es : followers){
            setUser.add(es.subscriberid);
          }     
          lstfollowerUser = [Select Id, UserRoleId, UserRole.Name, Name, FullPhotoUrl  from user where Id in : setUser] ;
 }  
 
 // Filter FeedItems With Most Recent Activity
  public List<wrapFeedItems> getMostRecentFeedsDisplay() {
       // List<Id> ids = New List<ID>();
        system.debug('getMostRecentFeedsDisplay called');
        display_RecentFeedslist= new List<wrapFeedItems>(); 
        Set<id>Ids = new Set<id>();
for(CaseFeed cf : [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' and parentid =:apexpages.currentpage().getparameters().get('Id') limit 20]){
Ids.add(cf.Id);
}
      
        for(FeedItem Fi:[Select ID,Body,CreatedDate,  CreatedBy.Name, Parent.Type,InsertedBy.Name, (SELECT InsertedByID, CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes) From FeedItem WHERE Type = 'TextPost' AND parentid =:apexpages.currentpage().getparameters().get('Id') and id in : Ids  ORDER BY CreatedDate DESC LIMIT 6])
        {    
              string tmpStr = Fi.body;
           // tmpFeedItem.body = tmpStr.subString(4,tmpStr.length() -4);
            Fi.body = tmpStr.replaceAll('<[^>]+>',' ');
            string strDT = getDateTimeFeeds(Fi.createddate);
             //-----------------------------------------------------------------
                  List<FeedLike> listFL = Fi.FeedLikes;
                system.debug('listFL---->' + listFL);
                
                Set<FeedLike> FL = new Set<FeedLike>(listFL);
                system.debug('FL---------->' + FL);
                string FIS = 'Like' ;
               for(FeedLike tmpFL :listFL)
                {
                 if(tmpFL.InsertedById == UserInfo.getUserId() )
                  {   FIS = 'UnLike';
                     break;
                  }   
                 else
                     FIS = 'Like';
                }
                //-----------------------------------------------------------------
            display_RecentFeedslist.add(new wrapFeedItems(Fi,strDT,FIS));
           // getdateinhour(c.createdDate);
        }
        system.debug('getMostRecentFeedsDisplay list-----' + display_RecentFeedslist);
        FeedItemsSize = display_RecentFeedslist.size();
       
        return display_RecentFeedslist; 
    }
    
     // Filter FeedItems With Last post
  public List<wrapFeedItems> getLastPostDisplay() {
       // List<Id> ids = New List<ID>();
        system.debug('getLastPostDisplay called');
        display_RecentFeedslist= new List<wrapFeedItems>(); 
Set<id>Ids = new Set<id>();
for(CaseFeed cf : [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' and parentid =:apexpages.currentpage().getparameters().get('Id') limit 20]){
Ids.add(cf.Id);
}
        DateTime dt = DateTime.Now().AddHours(-2);
        for(FeedItem Fi:[Select ID,Body,CreatedDate,  CreatedBy.Name, Parent.Type,InsertedBy.Name, (SELECT CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes) From FeedItem WHERE Type = 'TextPost' AND parentid =:apexpages.currentpage().getparameters().get('Id') and  id in : Ids AND createddate >= :dt ORDER BY CreatedDate DESC LIMIT 6])
        {    
              string tmpStr = Fi.body;
           // tmpFeedItem.body = tmpStr.subString(4,tmpStr.length() -4);
            Fi.body = tmpStr.replaceAll('<[^>]+>',' ');
            string strDT = getDateTimeFeeds(Fi.createddate);
              //-----------------------------------------------------------------
                  List<FeedLike> listFL = Fi.FeedLikes;
                system.debug('listFL---->' + listFL);
                
                Set<FeedLike> FL = new Set<FeedLike>(listFL);
                system.debug('FL---------->' + FL);
                string FIS = 'Like' ;
               for(FeedLike tmpFL :listFL)
                {
                 if(tmpFL.InsertedById == UserInfo.getUserId() )
                  {   FIS = 'UnLike';
                     break;
                  }   
                 else
                     FIS = 'Like';
                }
                //-----------------------------------------------------------------
            display_RecentFeedslist.add(new wrapFeedItems(Fi,strDT,FIS));
           // getdateinhour(c.createdDate);
        }
        system.debug('getMostRecentFeedsDisplay list-----' + display_RecentFeedslist);
        FeedItemsSize = display_RecentFeedslist.size();
       
        return display_RecentFeedslist; 
    
}
 
  public String likeCommentId{get;set;}
  
  public Pagereference likeunlike1(){
    system.debug('===feedItemstatus==='+feedItemstatus);
     if(feedItemstatus == 'Like'){
               // FeedItem myfeed = [Select ID,Body,CreatedDate,  CreatedBy.Name, Parent.Type,InsertedBy.Name,likecount, (SELECT CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes) From FeedItem WHERE Type = 'TextPost' AND parentid =:apexpages.currentpage().getparameters().get('Id') LIMIT 1];

          
          //  FeedItem myfeed = [Select ID,Body,CreatedDate, CreatedBy.Name, Parent.Type,InsertedBy.Name,likecount, (SELECT CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes) From FeedItem WHERE Id =:likeCommentId LIMIT 1];
         
          FeedLike flike = new FeedLike();
          
          likeCommentId = Apexpages.currentPage().getParameters().get('likeCommentId');
          system.debug('likeCommentId ---->' + likeCommentId );
          
          flike.FeedItemId=likeCommentId;
          system.debug('likeCommentId'+likeCommentId);
         // try{ 
            insert  flike;
            system.debug('likes'+flike.id);
            //feedItemstatus = 'UnLike';
            //}
            //catch(DMLException  e)
            //{
                //system.debug('DML Exception: ' + e);
            //}  
     }
    else if(feedItemstatus == 'UnLike'){
         //----------------------------------
      /*   Set<id>Ids = new Set<id>();
         for(CaseFeed cf : [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' and parentid =:apexpages.currentpage().getparameters().get('Id') limit 20]){
         Ids.add(cf.Id);
         }
            List<FeedItem> listFeedItem = new list<FeedItem>([Select ID,Body,CreatedDate,  CreatedBy.Name, Parent.Type,InsertedBy.Name, (SELECT FeedItemID, InsertedById, CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes)
            From FeedItem Where Type = 'TextPost' 
            and parentid =:apexpages.currentpage().getparameters().get('Id') and id in:Ids AND InsertedByID =:UserInfo.getUserId() ORDER BY CreatedDate DESC LIMIT 20]);
            
           // listFeedItem.FeedLikes;
            system.debug('===myfeed==='+listFeedItem);
          //  List<FeedLike> LstFL = listFeedItem.FeedLikes;
           // system.debug('===LstFL==='+LstFL);
            //delete LstFL ;
         //-----------------------------------*/
    ////  FeedItem myfeed = [Select ID,Body,CreatedDate, CreatedBy.Name, Parent.Type,InsertedBy.Name,likecount, (SELECT Id,CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes) From FeedItem WHERE Id =:likeCommentId LIMIT 1];
       // FeedLike flike = feed.FeedLikes;
       FeedItem myfeed = [Select ID,Body,CreatedDate, CreatedBy.Name, Parent.Type,InsertedBy.Name,likecount, (SELECT InsertedByID, Id,CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes) From FeedItem WHERE Id =:likeCommentId AND ParentID=:apexpages.currentpage().getparameters().get('Id') ];
       system.debug('===myfeed==='+myfeed);
       List<FeedLike> LstFL = myfeed.FeedLikes;
       system.debug('===LstFL==='+LstFL);
       FeedLike deleteFL;
       for(FeedLike tmpFL: LstFL)
       {
           if (tmpFL.InsertedByID == UserInfo.GetUserID())
               deleteFL = tmpFL;
       }
     //  if(deleteFL.Size() > 0)
       delete deleteFL;
        //feedItemstatus = 'Like';
    }
    
    PageReference pg= new PageReference('/apex/Predixcasedetailpage?id=' + apexpages.currentpage().getparameters().get('Id'));
    pg.setRedirect(false);
    return pg;
    
    // return null;
}
 
 public void ShowFeed_Comment(){
         
      //  listCasefeed = new list<CaseFeed>([SELECT Id, Type, CreatedById, CreatedBy.Name, CreatedBy.FirstName, CreatedBy.LastName, ParentId, Body, Title, LinkUrl, ContentData, ContentFileName, (SELECT Id, CommentBody, CreatedDate,  CreatedBy.FirstName, CreatedBy.LastName FROM FeedComments ORDER BY CreatedDate LIMIT 10), (SELECT CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes) FROM CaseFeed WHERE ParentID = :apexpages.currentpage().getparameters().get('Id') and Type='TextPost' ORDER BY CreatedDate DESC LIMIT 20]);
        
        system.debug('======listCasefeed ==='+listCasefeed );
            display_feedItemList = new List<wrapFeedItems>();
    Set<id>Ids = new Set<id>();
    for(CaseFeed cf : [SELECT Id,ParentId FROM CaseFeed Where Type = 'TextPost' and parentid =:apexpages.currentpage().getparameters().get('Id') limit 20]){
    Ids.add(cf.Id);
    }
            listFeedItem = new list<FeedItem>([Select ID,Body,CreatedDate,  CreatedBy.Name, Parent.Type,InsertedBy.Name, (SELECT FeedItemID, InsertedById, CreatedBy.FirstName, CreatedBy.LastName FROM FeedLikes)
            From FeedItem Where Type = 'TextPost' 
            and parentid =:apexpages.currentpage().getparameters().get('Id') and id in:Ids ORDER BY CreatedDate DESC LIMIT 20]);
            
            for(FeedItem tmpFeedItem : listFeedItem )
            {
                string tmpStr = tmpFeedItem.body;
                string FIS;
               // tmpFeedItem.body = tmpStr.subString(4,tmpStr.length() -4);
                tmpFeedItem.body = tmpStr.replaceAll('<[^>]+>',' ');
                string strDT = getDateTimeFeeds(tmpFeedItem.createddate);
               
                List<FeedLike> listFL = tmpFeedItem.FeedLikes;
                system.debug('listFL---->' + listFL);
                
                Set<FeedLike> FL = new Set<FeedLike>(listFL);
                system.debug('FL---------->' + FL);
                FIS = 'Like' ;
               for(FeedLike tmpFL :listFL)
                {
                 if(tmpFL.InsertedById == UserInfo.getUserId() )
                  {   FIS = 'UnLike';
                     break;
                  }   
                 else
                     FIS = 'Like';
                }
          //    if(FL.Contains( UserInfo.getUserId()) )
//                if (FL.size() == 1)
  //                  FIS = 'UnLike';
    //            else //if(FL.size() == 0)
      //              FIS = 'Like';
                display_feedItemList.add(new wrapFeedItems(tmpFeedItem, strDT, FIS));
            }

         system.debug('======listFeedItem ==='+display_feedItemList);
    } 


public void ShowlistAttachment(){
     
    //sunayana: Removed fields ConnectionReceivedId & ConnectionSentId from attachment object.
    //listAttachment = new list<Attachment>([SELECT Body,BodyLength,ConnectionReceivedId,ConnectionSentId,ContentType,CreatedById,CreatedDate,Description,Id,IsDeleted,IsPartnerShared,IsPrivate,LastModifiedById,LastModifiedDate,Name,OwnerId,ParentId,SystemModstamp FROM Attachment where ParentId = :apexpages.currentpage().getparameters().get('Id')]);
    listAttachment = new list<Attachment>([SELECT Body,BodyLength,ContentType,CreatedById,CreatedDate,Description,Id,IsDeleted,IsPrivate,LastModifiedById,LastModifiedDate,Name,OwnerId,ParentId,SystemModstamp FROM Attachment where ParentId = :apexpages.currentpage().getparameters().get('Id')]);
    system.debug('======listCasefeed ==='+listCasefeed );
}   

public void ShowArticles(){
    List<CaseArticle> lstCaseArticle = new list<CaseArticle>([SELECT CaseId, Id, KnowledgeArticleId FROM CaseArticle WHERE CaseId =:apexpages.currentpage().getparameters().get('Id')]);
    Set<Id> IdKA = new Set<Id>();
    
    for(CaseArticle ca : lstCaseArticle)
    {
        IdKA.add(ca.KnowledgeArticleId);
    }   
    
    listKnowledgeArticleVersion = new List<KnowledgeArticleVersion> ([SELECT Summary,Title,UrlName, Language, PublishStatus, KnowledgeArticleId FROM KnowledgeArticleVersion where KnowledgeArticleId = :IdKA and PublishStatus ='Online' and Language='en_US']);
}   

 public class wrapFeedItems{
        
        public FeedItem feedItemObject{get;set;}
        public string dateTimeFeed{get;set;}
        public string FeedItemStatus{get;set;}
        
            public wrapFeedItems(FeedItem fi, string strDT, string FIS){
             feedItemObject = fi;
             dateTimeFeed = strDT;
             FeedItemStatus = FIS;
             
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

public class wrapcase{
    
    public case caseObj{get;set;}
    public boolean isSelected{get;set;}
    public string dateTimeFeed{get;set;}
 
        public wrapcase(case c){
         caseObj=c;
         isselected=false;
         dateTimeFeed = '';
         
       }
}
 
    public void FollowUnFollow(){
        
//followedCases = new List<EntitySubscription>();   
        //  followedCases = [select id, subscriber.name from EntitySubscription where subscriberid =:UserInfo.getUserId()];    
        
    }
    
    public PageReference FollowCase(){
        
        
          if(strFollowUnFollow == 'UnFollow'){
              followedCases = new List<EntitySubscription>();   
              followedCases = [select id, parentid, subscriberid, subscriber.name from EntitySubscription where subscriberid =:UserInfo.getUserId()LIMIT 1000]; 
              //set in entity subcription
              for(EntitySubscription tmpES : followedCases)
              {
                  if (tmpES.ParentId == apexpages.currentpage().getparameters().get('Id') && tmpES.SubscriberId == UserInfo.getUserId())
                   {  
                      system.debug('entered in IF---yes the id exists in ES');
                      delete tmpES;
                      strFollowUnFollow = 'Follow';
                    }  
              }
              
          }
          else{
              EntitySubscription newES = new EntitySubscription();
              newES.ParentId = apexpages.currentpage().getparameters().get('Id');
              newES.SubscriberId = UserInfo.getUserId();
              if(Network.getNetworkId() != null){
                    newES.NetworkId=Network.getNetworkId();
              }
              try{Insert newES;
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
    public void GetCaseFollow()
    { 
        followedCases = new List<EntitySubscription>();  
        followedCases = [select id, parentid, subscriberid, subscriber.name from EntitySubscription where ParentId =: apexpages.currentpage().getparameters().get('Id') and subscriberid =:UserInfo.getUserId() LIMIT 1000]; 
        strFollowUnFollow = 'Follow';
        caseFollowing = False;
         
        if (followedCases.size()>0)
        {  
          system.debug('the case is being followed by the user');
          caseFollowing = True;
          strFollowUnFollow = 'UnFollow';
          //return null;
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
    
    //Follow
    
      /* global static string unFollowItem(string itemId, string userId){
        try{

        EntitySubscription es = [select id from EntitySubscription where parentId=apexpages.currentpage().getparameters().get('Id') and subscriberId=UserInfo.getUserId() limit 1000];
        delete es;
        return itemId;
        }catch(System.Exception ex){
            system.debug(ex);
            return 'error';
        }

        return 'error';
    } 

    @RemoteAction
    global static string followItem(string itemId, string userId){
        try{
        EntitySubscription es = new EntitySubscription(parentId=apexpages.currentpage().getparameters().get('Id'), SubscriberId=UserInfo.getUserId());
        insert es;
        return itemId;
        }catch(System.Exception ex){
            system.debug(ex);
            return 'error';
        }

        return 'error';
    }  */
    
    
    
}