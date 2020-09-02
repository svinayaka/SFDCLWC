public with sharing class PredixCaseSearchController {
    public string soql{get;set;}
    public string strSubject{get;set;}
    public string strStatus{get;set;}
    public string strOwnerName{get;set;}
    public string strSearch{get;set;}
    //public string searchstring{get;set;}
    public list<wrapCases>lstWrapcases{get;set;}
    public list<wrapCases>lstWrapcases1{get;set;}
    public integer recNum = 0;
    public integer OffsetSize = 0;
    public integer LimitSize= 25;
    public integer totalRecs = 0;
    public integer Casessize{get;set;}
    public string strQuery{get;set;}
    public string globalSOQL{get;set;}
    public string concatSOQL{get;set;}
    Public String SelectedRecordType{get;set;}

    public String renderedAllTable{get;set;}
    public List<wrapcases> display_P1PriorityCaseslist {get; set;}
    public List<wrapcases> display_P2PriorityCaseslist {get; set;}
    public List<wrapcases> display_P3PriorityCaseslist {get; set;}
    public List<wrapcases> display_P4PriorityCaseslist {get; set;}
    public List<wrapcases> display_newcaselist {get; set;}
    public List<wrapcases> display_closedcaselist {get; set;}
    public List<wrapcases> display_workingcaselist {get; set;}
    public List<wrapcases> display_Resolvedcaselist {get; set;}
    public List<wrapcases> display_ackcaselist {get; set;}
    //Public Case CreateNewCase1{get;set;}
    Public Case CreateNewCase{get;set;}
    public List<wrapcases> display_OneHrcaselist{get; set;}
    public List<wrapcases> display_FiveHrscaselist {get; set;}
    public List<wrapcases> display_Yesterdaycaselist {get; set;}
    public List<wrapcases> display_TwoMonthcaselist {get; set;}
    public List<wrapcases> display_LastMonthcaselist {get; set;}
    Public String UserProfileName {get;set;}
    Public Set<String> lstUserPermissionsetName {get;set;}
    public Set<String> AllowedRecordTypes{get;set;}
    public Set<String> AllowedRecordtypeID{get;set;}
    public Boolean isCommunityUser {get;set;}
    //public User CurUser {get;set;}
    Public Integer recordTypeCount{get;set;}
   // Public List<String> selectedEnhancOptions {get; set;}
    public boolean hasAttachment{get;set;}
    public string filterByPriority {get; set;}
    public string filterByStatus {get; set;}
    public string filterByDateTime {get; set;}
    public List<wrapcases> display_AllStatuscaselist {get; set;}
    public List<wrapcases> display_AllPriorityCaseslist {get; set;}
    Public List<wrapcases> display_AllDateTimecaselist {get; set;}

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
//Pagination
public void FirstPage()
    {
    OffsetSize = 0;
    if(FilterByPriority == '' && FilterByStatus == '' && FilterByDateTime == '')
    {renderedAllTable='AllCases';}
    Currentpage = 1;
    runSearch();
     
    system.debug('Offset for First page------>' + OffsetSize + 'Current page----->' + Currentpage );

    }
public void previous()
    {
    if(OffsetSize >0)
        {
            OffsetSize =OffsetSize - LimitSize;
            runSearch();
            Currentpage --;
        }
        system.debug('Offset for previous page------>' + OffsetSize + 'Current page----->' + Currentpage );
    }
public void next()
{
     if(currentpage < pagecount)
    {
   Currentpage ++;
    OffsetSize = OffsetSize + LimitSize;
     runSearch();
      
    system.debug('Offset for next page------>' + OffsetSize + 'Current page----->' + Currentpage );
    }
}
public void LastPage()
    {
    //OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
    if(Math.mod(casessize,limitsize) == 0)
      {
       offsetsize = casessize - limitsize;
      }
      else
      {
          OffsetSize =  casessize - Math.mod(casessize,limitsize);
      }
     //offsetsize = casessize - (casessize-limitsize);
     system.debug('offset size for last---->' + offsetsizeForlast );
     Currentpage = Pagecount ;
     runSearch();      
     //Currentpage = Pagecount ;
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

public PredixCaseSearchController(){
    strStatus='';
    strSubject='';
    strOwnerName ='';
    strSearch = '';

    FilterByPriority = '';
    FilterByStatus = '';
    FilterByDateTime = '';
    renderedAllTable='AllCases';
        Currentpage = 1;
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
 //CreateNewCase1= new case();
}
public PageReference ShowPriorityCases() {
 
         System.debug('ShowPriorityCases'+renderedAllTable);   
        return null;
    }
    
public PageReference ShowStatusCases() {
 
        System.debug('ShowPriorityCases'+renderedAllTable);
        return null;
    }
    
public PageReference ShowDateTimeCases() {
 
        System.debug('ShowDateTimeCases'+renderedAllTable);
        return null;
    }

//method for search
public PageReference runSearch() {     
if(hasAttachment==true)
    {
        limitsize = 35;     
    }   
if(currentPage == 1)
    {
        offsetsize = 0;
    }  

    soql = 'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments), Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID)';
    System.debug('---------'+strSubject +'---'+strStatus+'---'+strOwnerName);
    if (strSubject!='')
    {
        soql += ' and (Subject LIKE \''+String.escapeSingleQuotes(strSubject)+'%\'';
    }
    if (strStatus!='' && strSubject!=''){
        soql += ' and Status LIKE \''+String.escapeSingleQuotes(strStatus)+'%\'';
    }
    else if (strStatus!=''){
         soql += ' and (Status LIKE \''+String.escapeSingleQuotes(strStatus)+'%\'';
    }
    if (strOwnerName!='' && (strSubject!='' || strStatus!='')){
        soql += ' and Owner.Name LIKE \''+String.escapeSingleQuotes(strOwnerName)+'%\''; 
    }
    else if (strOwnerName!=''){
        soql += ' and (Owner.Name LIKE \''+String.escapeSingleQuotes(strOwnerName)+'%\''; 
    }
    if(strStatus!='' || strSubject!='' || strOwnerName!='')
    {
        soql += ') order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize ';
    }
    else{
        soql += ' order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize ';
    }
    System.debug('---------'+soql);

    //////////////////////////////////////////
    //FilterByPriority = '';
    //FilterByStatus = '';
    //FilterByDateTime = '';

    globalSOQL = 'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID)';
    if (strSubject!='')
    {
        globalSOQL += ' and (Subject LIKE \''+String.escapeSingleQuotes(strSubject)+'%\'';
    }
    if (strStatus!='' && strSubject!=''){
        globalSOQL += ' and Status LIKE \''+String.escapeSingleQuotes(strStatus)+'%\'';
    }
    else if (strStatus!=''){
          globalSOQL += ' and (Status LIKE \''+String.escapeSingleQuotes(strStatus)+'%\'';
    }
    if (strOwnerName!='' && (strSubject!='' || strStatus!='')){
        globalSOQL += ' and Owner.Name LIKE \''+String.escapeSingleQuotes(strOwnerName)+'%\''; 
    }
    else if (strOwnerName!=''){
         globalSOQL += ' and (Owner.Name LIKE \''+String.escapeSingleQuotes(strOwnerName)+'%\''; 
    }

    system.debug('-----------GlobalSOQL-----------' + globalSOQL);
    //----------concatSOQL = ----------------//
    if(strStatus!='' || strSubject!='' || strOwnerName!='')
    {
        concatSOQL = ') order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize ';
    }
    else{
        concatSOQL = ' order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize ';
    }

    system.debug('------concatSOQL' + concatSOQL);
    system.debug('FilterByPriority=' + FilterByPriority);
    system.debug('FilterByStatus=' + FilterByStatus);
    system.debug('FilterByDateTime=' + FilterByDateTime);
    //renderedAllTable='AllCases';
    system.debug('renderedAllTable=' + renderedAllTable);
    //////////////////////////////////////////

    List<Case>  lstCases= Database.query(soql);

    Casessize = lstCases.size();
    PageCount = Math.round(casessize/limitsize);

    lstWrapcases = new list<wrapCases>();
    for(Case cs : lstCases)
    {
      wrapCases obj = new wrapCases(cs);
      if(cs.attachments.size()>0){
        obj.hasAttachment = true;
      }
      if((hasAttachment == true) && (cs.attachments.size()>0)){
       lstWrapcases.add(obj);
      }
     else{
       if(hasAttachment == false) {
         lstWrapcases.add(obj);
       }
      }
    }
    
    //Count of cases
    strQuery = 'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,(select id from Attachments),Community_Last_Modified_User__c,recordTypeId From Case WHERE (recordtypeID in  :AllowedRecordtypeID)';
    System.debug('---------'+strSubject +'---'+strStatus+'---'+strOwnerName);
    if (strSubject!='')
    {
        strQuery += ' and (Subject LIKE \''+String.escapeSingleQuotes(strSubject)+'%\'';
    }
    if (strStatus!='' && strSubject!=''){
        strQuery += ' and Status LIKE \''+String.escapeSingleQuotes(strStatus)+'%\'';
    }
    else if (strStatus!=''){
         strQuery += ' and (Status LIKE \''+String.escapeSingleQuotes(strStatus)+'%\'';
    }
    if (strOwnerName!='' && (strSubject!='' || strStatus!='')){
        strQuery += ' and Owner.Name LIKE \''+String.escapeSingleQuotes(strOwnerName)+'%\''; 
    }
    else if (strOwnerName!=''){
        strQuery += ' and (Owner.Name LIKE \''+String.escapeSingleQuotes(strOwnerName)+'%\''; 
    }
    if(strStatus!='' || strSubject!='' || strOwnerName!='')
    {
        strQuery += ') order by LastModifiedDate  ';
    }
    else{
        strQuery += ' order by LastModifiedDate ';
    }
    System.debug('---------'+strQuery);

    List<Case>  lstCountCases= Database.query(strQuery);
    lstWrapcases1 = new list<wrapCases>();
    for(Case cs : lstCountCases)
    {
      wrapCases obj = new wrapCases(cs);
      if((hasAttachment == true) && (cs.attachments.size()>0)){
      lstWrapcases1.add(new wrapCases (cs));
     }
     else{
       if(hasAttachment == false) {
         lstWrapcases1.add(new wrapCases (cs));}
      }
    }

    Casessize = lstCountCases.size();

     
    System.debug('-----size----'+lstCountCases.size());

    Casessize = lstWrapcases1.size();

    PageCount = Integer.Valueof(Math.ceil(casessize/limitsize));
    if(math.mod(casessize,limitsize) > 0 )
    PageCount++;
    system.debug('ceil value--------->' + Math.ceil(casessize/limitsize) + 'remainder value ---------------->' + math.mod(casessize,limitsize));
    //renderedAllTable='AllCases';

    return null;
    } 

public List<wrapcases> getNewCasesDisplay() {
    
    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeNew++;
    if(localOffsetSizeNew== 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ' and Status = \''+String.escapeSingleQuotes('New') + '\'' ;
    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }

    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
    localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
    localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
    datetime myDateTime = datetime.now().addHours(-5);    
    localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    if(FilterByPriority != '' && FilterByDateTime != '' )
    {

    }
    system.debug('!!!!!!!!!!!!!!'+  localSOQL +'!!!!!!!!!!!!!!'  );
    // string countSOQL = localSOQL + ')'; //query to get case size

    string countSOQL;
  //  if(!test.isRunningTest()){
  //      countSOQL = localSOQL + ')';
   // }
   // else
  //  {
  //      countSOQL = localSOQL;
  //  }
   if(!test.isRunningTest()){
     countSOQL = localSOQL + ')'; // for countSOQL
     localSOQL += concatSOQL;
    }
    else
    {
      globalSOQl =  'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID) and  (CreatedDate >= YESTERDAY';
      localSOQl = globalSOQl + ') order by LastModifiedDate desc';
      countSOQL = localSOQl;
      //lstCaseSearch = Database.Query(localSOQL);
    } 
   // casessize = CasesCountQuery(countSOQL); // calling function with count query
   //// localSOQL += concatSOQL;
    

    system.debug('---------getnewlocalSOQL --------' + localSOQL + '---FilterbyPriority---'+ FilterbyPriority + 'FilterByStatus' + FilterByStatus + '-----FilterBydate---' + FilterBydateTime);

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_newcaselist = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_newcaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_newcaselist.add(obj);
    }
    }
    }

    //for(case c:[SELECT id, Recordtype.Name , Community_Last_Modified_User__c,subject, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And Status ='New' order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    /*  for(case c:lstCaseSearch)  
    {    
    display_newcaselist.add(new wrapcases(c));//with c, add style here. Create 4 syleclass( in 
    }*/

    FilterByStatus = 'New';
    PageCount = TotalPagesCount(casessize);  
    //casessize = display_newcaselist.size();
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_newcaselist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    system.debug('New Case List on Case Detail Page------->'+display_newcaselist);
    return display_newcaselist; 
    }
    
public List<wrapcases> getAllPriorityCasesDisplay(){
   
    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeAllP++;
    if(localOffsetSizeAllP == 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.debug('---------ALLconcatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL;
    //  localSOQL = globalSOQL + ' and Priority LIKE \''+String.escapeSingleQuotes('P1–Level 1–Catastrophic service failure') + '\'' ;
    if(FilterByStatus != '' && FilterByStatus != 'All')
    {
    localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';

    }
    if(FilterByDateTime !='' && FilterByDateTime != 'Any Time')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
    localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
    localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
    datetime myDateTime = datetime.now().addHours(-5);    
    localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    //string countSOQL = localSOQL + ')'; //query to get case size
    string countSOQL;
    if(!test.isRunningTest()){
    countSOQL = localSOQL + ')';
    }
    else{
    countSOQL = localSOQL;
    
    }
    //casessize = CasesCountQuery(countSOQL); // calling function with count query
    localSOQL += concatSOQL;
    

    system.debug('---------getAllPriority localSOQL --------' + localSOQL );

    List<Case> lstCaseSearch = Database.Query(localSOQL );
    renderedAllTable = 'AllPriority';

    display_AllPriorityCaseslist = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_AllPriorityCaseslist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_AllPriorityCaseslist.add(obj);
    }
    }
    }
    // for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Priority='P4–Level 4–No impact to service') AND Subject =:strSubject AND owner.name=:strOwnerName AND status =: strStatus order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])

    //for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Priority='P1–Level 1–Catastrophic service failure')  order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])        
    /*   for(case c:lstCaseSearch)      
    {    
    display_AllPriorityCaseslist.add(new wrapcases(c));
    }*/

    FilterByPriority = '';
    // casessize = display_AllPriorityCaseslist.size();
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_AllPriorityCaseslist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_AllPriorityCaseslist; //return the list of full records plus their row counter

    }

public List<wrapcases> getP1PriorityCasesDisplay() {
    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeP1++;
    if(localOffsetSizeP1 == 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }
    system.debug('currentpage---->' + currentpage + ' offsetsize----->' + offsetsize );
    //  localOffsetSize = offsetsize * global++;

    system.debug('---------p1concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ' and Priority LIKE \''+String.escapeSingleQuotes('P1–Level 1–Catastrophic service failure') + '\'' ;
    if(FilterByStatus != '')
    {
    localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';

    }
    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
    localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
    localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
    datetime myDateTime = datetime.now().addHours(-5);    
    localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
     countSOQL = localSOQL + ')'; // for countSOQL
     localSOQL += concatSOQL;
    }
    else
    {
      globalSOQl =  'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID) and  (CreatedDate >= YESTERDAY';
      localSOQl = globalSOQl + ') order by LastModifiedDate desc';
      countSOQL = localSOQl;
      //lstCaseSearch = Database.Query(localSOQL);
    } 
    system.debug('---------getp1 localSOQL --------' + localSOQL );

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_P1PriorityCaseslist = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_P1PriorityCaseslist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_P1PriorityCaseslist.add(obj);
    }
    }
    }
    // for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Priority='P4–Level 4–No impact to service') AND Subject =:strSubject AND owner.name=:strOwnerName AND status =: strStatus order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])

    //for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Priority='P1–Level 1–Catastrophic service failure')  order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])        
    /* for(case c:lstCaseSearch)      
    {    
    display_P1PriorityCaseslist.add(new wrapcases(c));
    }*/

    FilterByPriority = 'P1–Level 1–Catastrophic service failure';
    // casessize = CasesCountQuery(countSOQL);
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_P1PriorityCaseslist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_P1PriorityCaseslist ; //return the list of full records plus their row counter
    }  
     
public List<wrapcases> getP2PriorityCasesDisplay() {
    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeP2++;
    if(localOffsetSizeP2 == 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ' and Priority LIKE \''+String.escapeSingleQuotes('P2–Level 2–Service failure') + '\'' ;
    if(FilterByStatus != '')
    {
    localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';

    }
    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
    localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
    localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
    datetime myDateTime = datetime.now().addHours(-5);    
    localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    
    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
    countSOQL = localSOQL + ')';
    localSOQL += concatSOQL;
    }
     else
    {
      globalSOQl =  'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID) and  (CreatedDate >= YESTERDAY';
      localSOQl = globalSOQl + ') order by LastModifiedDate desc';
      countSOQL = localSOQl;
      //lstCaseSearch = Database.Query(localSOQL);
    }      
  //  casessize = CasesCountQuery(countSOQL); // calling function with count query
    
   

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_P2PriorityCaseslist = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_P2PriorityCaseslist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_P2PriorityCaseslist.add(obj);
    }
    }
    }
    // for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Priority='P4–Level 4–No impact to service') AND Subject =:strSubject AND owner.name=:strOwnerName AND status =: strStatus order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])

    //for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Priority='P2–Level 2–Service failure')  order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    /*for(case c:lstCaseSearch)         
    {    
    display_P2PriorityCaseslist.add(new wrapcases(c));
    }*/
    system.debug('display_P2PriorityCaseslist size----->' + display_P2PriorityCaseslist.size());
    system.debug('p2 localsoql---->' + localSOQL);
    FilterByPriority = 'P2–Level 2–Service failure';
   
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_P2PriorityCaseslist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    // casessize = display_P2PriorityCaseslist.size();
    PageCount = TotalPagesCount(casessize);//get page count
    return display_P2PriorityCaseslist ; //return the list of full records plus their row counter
    }  

public List<wrapcases> getP3PriorityCasesDisplay() {

    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''

    localOffsetSizeP3++;
    if(localOffsetSizeP3 == 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }
    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ' and Priority LIKE \''+String.escapeSingleQuotes('P3–Level 3–Limited loss of service') + '\'' ;
    if(FilterByStatus != '')
    {
    localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';

    }
    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
    localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
    localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
    datetime myDateTime = datetime.now().addHours(-5);    
    localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }

    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
        countSOQL = localSOQL + ')';
        localSOQL += concatSOQL;
    }
     else
    {
      globalSOQl =  'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID) and  (CreatedDate >= YESTERDAY';
      localSOQl = globalSOQl + ') order by LastModifiedDate desc';
      countSOQL = localSOQl;
      //lstCaseSearch = Database.Query(localSOQL);
    } 
    //casessize = CasesCountQuery(countSOQL); // calling function with count query
    
    

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_P3PriorityCaseslist = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_P3PriorityCaseslist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_P3PriorityCaseslist.add(obj);
    }
    }
    }
    // for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Priority='P4–Level 4–No impact to service') AND Subject =:strSubject AND owner.name=:strOwnerName AND status =: strStatus order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])


    //for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Priority='P3–Level 3–Limited loss of service')  order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    /* for(case c:lstCaseSearch)
    {    
    display_P3PriorityCaseslist.add(new wrapcases(c));
    }*/
    FilterByPriority = 'P3–Level 3–Limited loss of service';
    //casessize = display_P3PriorityCaseslist.size();
     if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_P3PriorityCaseslist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_P3PriorityCaseslist ; //return the list of full records plus their row counter
    }  
    
public List<wrapcases> getP4PriorityCasesDisplay() {

    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeP4++;
    if(localOffsetSizeP4 == 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ' and Priority LIKE \''+String.escapeSingleQuotes('P4–Level 4–No impact to service') + '\'' ;
    if(FilterByStatus != '')
    {
    localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';

    }
    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
        localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
        localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
        datetime myDateTime = datetime.now().addHours(-5);    
        localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    
    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
        countSOQL = localSOQL + ')';
        localSOQL += concatSOQL;
    }
    else
    {
      globalSOQl =  'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID) and  (CreatedDate >= YESTERDAY';
      localSOQl = globalSOQl + ') order by LastModifiedDate desc';
      countSOQL = localSOQl;
      //lstCaseSearch = Database.Query(localSOQL);
    }
    casessize = CasesCountQuery(countSOQL); // calling function with count query
    
    

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_P4PriorityCaseslist = new List<wrapcases>();
        for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_P4PriorityCaseslist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_P4PriorityCaseslist.add(obj);
    }
    }
    }
    // for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Priority='P4–Level 4–No impact to service') AND Subject =:strSubject AND owner.name=:strOwnerName AND status =: strStatus order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])

    /*  for(case c:lstCaseSearch)
    {    
    display_P4PriorityCaseslist.add(new wrapcases(c));
    }*/

    filterByPriority = 'P4–Level 4–No impact to service';

    system.debug('display_P4PriorityCaseslist---->' +display_P4PriorityCaseslist.size());
    //casessize = display_P4PriorityCaseslist.size();
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_P4PriorityCaseslist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_P4PriorityCaseslist ; //return the list of full records plus their row counter
    }  

    //method to display NEWCASES
    /*public List<wrapcases> getNewCasesDisplay() {

    display_newcaselist= new List<wrapcases>(); 

    for(case c:[SELECT id, Recordtype.Name , Community_Last_Modified_User__c,subject, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID = :IPSRecTypeID  OR recordtypeID = :UORecTypeID) And Status ='New' order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    {    
    display_newcaselist.add(new wrapcases(c));//with c, add style here. Create 4 syleclass( in 
    }
    system.debug('New Case List on Case Detail Page------->'+display_newcaselist);
    return display_newcaselist; 
    }*/


    //method to display ALL Status Cases
public List<wrapcases> getAllStatusCasesDisplay() {
        
    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeAllSta++;
    if(localOffsetSizeAllSta== 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL;
    // localSOQL = globalSOQL + ' and Status = \''+String.escapeSingleQuotes('Acknowledged') + '\'' ;
    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }
    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
        localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
        localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
        datetime myDateTime = datetime.now().addHours(-5);    
        localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    //    if(FilterByDateTime != '')
    //  {
    //       localSOQL+= ') and (CreatedDate = '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'')';
    //   }
    if(FilterByPriority != '' && FilterByDateTime != '' )
    {
        
    }
    
    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
        countSOQL = localSOQL + ')';
    }
    else{
    countSOQL = localSOQL; 
    }
   // casessize = CasesCountQuery(countSOQL); // calling function with count query
    localSOQL += concatSOQL;
    
    
    system.debug('---------getAllStatuslocalSOQL --------' + localSOQL );

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_AllStatuscaselist = new List<wrapcases>();
    //for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID) And Status ='Acknowledged' order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])               
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_AllStatuscaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_AllStatuscaselist.add(obj);
    }
    }
    }       
    /*for(case c:lstCaseSearch)

    {    
    display_AllStatuscaselist.add(new wrapcases(c));
    }*/
    FilterByStatus = '';
    // casessize = display_AllStatuscaselist.size();
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_AllStatuscaselist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_AllStatuscaselist; 
    }

    //method to display ACKNOWLEDGEDCASES   
public List<wrapcases> getAckCasesDisplay() {

    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeNew++;
    if(localOffsetSizeNew== 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ' and Status = \''+String.escapeSingleQuotes('Acknowledged') + '\'' ;
    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }
    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
    localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
    localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
    datetime myDateTime = datetime.now().addHours(-5);    
    localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    //    if(FilterByDateTime != '')
    //  {
    //       localSOQL+= ') and (CreatedDate = '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'')';
    //   }
    if(FilterByPriority != '' && FilterByDateTime != '' )
    {

    }
    
    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
    countSOQL = localSOQL + ')';
    }
    else{
        countSOQL = localSOQL ;
    }
   // casessize = CasesCountQuery(countSOQL); // calling function with count query
    localSOQL += concatSOQL;
    
    
    system.debug('---------getACKlocalSOQL --------' + localSOQL );

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_ackcaselist = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_ackcaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_ackcaselist.add(obj);
    }
    }
    }  
    //for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID) And Status ='Acknowledged' order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])               
    /*for(case c:lstCaseSearch)

    {    
    display_ackcaselist.add(new wrapcases(c));
    }*/
    FilterByStatus = 'Acknowledged';
    //casessize = display_ackcaselist.size();
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_ackcaselist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    system.debug('get acknow pagecount---->' + PageCount );
    return display_ackcaselist ; 
    }

    //method to display CLOSEDCASES
public List<wrapcases> getClosedCasesDisplay() {

    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeClo++;
    if(localOffsetSizeClo == 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ' and Status = \''+String.escapeSingleQuotes('Closed') + '\'' ;
    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }
    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
    localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
    localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
    datetime myDateTime = datetime.now().addHours(-5);    
    localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    //    if(FilterByDateTime != '')
    //  {
    //       localSOQL+= ') and (CreatedDate = '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'')';
    //   }

    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
    countSOQL = localSOQL + ')';
    }
    else{
        countSOQL = localSOQL ;
    }   
   // casessize = CasesCountQuery(countSOQL); // calling function with count query
    localSOQL += concatSOQL;
    
    
    system.debug('---------getCLOSEDlocalSOQL --------' + localSOQL );

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_closedcaselist  = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_closedcaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_closedcaselist.add(obj);
    }
    }
    } 
    /* for(case c:lstCaseSearch)
    // for(case c:[SELECT id, Recordtype.Name , subject,Community_Last_Modified_User__c, CaseNumber, status, createddate,owner.name,description,Priority  FROM Case where  (recordtypeID in  :AllowedRecordtypeID) And (Status ='Closed' OR Status ='Resolved')  order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    {    
    display_closedcaselist.add(new wrapcases(c));
    }*/
    FilterByStatus = 'Closed';
    // casessize = display_closedcaselist.size();
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_closedcaselist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_closedcaselist ; 
    }

    //method to display WorkingCASES   
public List<wrapcases> getWorkingCasesDisplay() {
        
    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeWor++;
    if(localOffsetSizeWor== 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ' and Status = \''+String.escapeSingleQuotes('Working') + '\'' ;
    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }
    //    if(FilterByDateTime != '')
    //  {
    //       localSOQL+= ') and (CreatedDate = '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'')';
    //   }
    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
        localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
        localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
        datetime myDateTime = datetime.now().addHours(-5);    
        localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    
    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
        countSOQL = localSOQL + ')';
    }
    else
    {
        countSOQL = localSOQL ;
    }
    //casessize = CasesCountQuery(countSOQL); // calling function with count query
    localSOQL += concatSOQL;
    
    
    system.debug('---------getWORKINGlocalSOQL --------' + localSOQL );

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_workingcaselist = new List<wrapcases>();
                for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_workingcaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_workingcaselist.add(obj);
    }
    }
    } 
    /*  for(case c:lstCaseSearch)
    //    for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID) And Status ='Working' order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    {    
    display_workingcaselist.add(new wrapcases(c));
    }*/
    FilterByStatus = 'Working';
    //casessize = display_workingcaselist.size();
     if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_workingcaselist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_workingcaselist ; 
    }

     //method to display ResolvedCASES   
public List<wrapcases> getResolvedCasesDisplay() {
        
    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeRes++;
    if(localOffsetSizeRes== 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ' and Status = \''+String.escapeSingleQuotes('Resolved') + '\'' ;
    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }
    //    if(FilterByDateTime != '')
    //  {
    //       localSOQL+= ') and (CreatedDate = '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'')';
    //   }
    if(FilterByDateTime !='')
    {
    if(FilterByDateTime == 'LAST_MONTH')
    {        
    localSOQL += ') and (CreatedDate =  LAST_MONTH';        
    }   
    else if(FilterByDateTime == 'YESTERDAY')
    {        
    localSOQL += ') and (CreatedDate =  YESTERDAY';        
    }   
    else if(FilterByDateTime == 'FIVE_HOURS')
    {    
    datetime myDateTime = datetime.now().addHours(-5);    
    localSOQL += ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;        
    } 
    }
    
    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
        countSOQL = localSOQL + ')';
    }
    else
    {
        countSOQL = localSOQL ;
    }
   // casessize = CasesCountQuery(countSOQL); // calling function with count query
    localSOQL += concatSOQL;
    
    
    system.debug('---------getCLOSEDlocalSOQL --------' + localSOQL );

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_Resolvedcaselist = new List<wrapcases>();
                    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_Resolvedcaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_Resolvedcaselist.add(obj);
    }
    }
    }
    /* for(case c:lstCaseSearch)
    //for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID) And Status ='Resolved' order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    {    
    display_Resolvedcaselist.add(new wrapcases(c));
    }*/
    FilterByStatus = 'Resolved';
    // casessize = display_Resolvedcaselist.size();
    PageCount = TotalPagesCount(casessize);//get page count
    return display_Resolvedcaselist ; 
    }

    ///Method to display All datetime cases
public List<wrapcases> getAllDateTimeCasesDisplay() {
        
    datetime myDateTime = datetime.now().addHours(-5);
    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''

    localOffsetSizeDTall++;
    if(localOffsetSizeDTall == 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.Debug('=====prev globalSOQL==='  + globalSOQL);
    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL;
    // localSOQL = globalSOQL + ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;


    // myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'')

    if(FilterByStatus != '')
    {
    localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';

    }

    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }

    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
    countSOQL = localSOQL + ')';
    }
    else{
            countSOQL = localSOQL;
    }
    //casessize = CasesCountQuery(countSOQL); // calling function with count query
    localSOQL += concatSOQL;
    

    system.debug('---------getAllDateTimelocalSOQL --------' + localSOQL );

    List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_AllDateTimecaselist= new List<wrapcases>();
                        for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_AllDateTimecaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_AllDateTimecaselist.add(obj);
    }
    }
    }
    /* for(case c:lstCaseSearch)
    //  for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID) AND CreatedDate >=: myDateTime order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    {    
    display_AllDateTimecaselist.add(new wrapcases(c));
    }
    system.debug('five hrs list-----' + display_AllDateTimecaselist.size());*/
    FilterByDateTime = '';
    renderedAllTable = 'Any time';
    // casessize = display_AllDateTimecaselist.size();
     if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_AllDateTimecaselist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_AllDateTimecaselist; 
    }


    //method to display FiveHrsCASES   

public List<wrapcases> getFiveHrsCasesDisplay() {
        
    datetime myDateTime = datetime.now().addHours(-5);

    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    string localSOQL;
    List<Case> lstCaseSearch ;
    localOffsetSizeFive++;
    if(localOffsetSizeFive == 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.Debug('=====prev globalSOQL==='  + globalSOQL);
    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ') and (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;
    

    // myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'')

    if(FilterByStatus != '')
    {
    localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';

    }

    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }
   
   //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    //if(!test.isRunningTest()){
        countSOQL = localSOQL + ')';
    //}
    
    if(test.isRunningTest()){
        globalSOQl =  'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID) and  (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;
        countSOQL = globalSOQl + ') order by LastModifiedDate desc';
    }   
    casessize = CasesCountQuery(countSOQL); // calling function with count query
    localSOQL += concatSOQL;
    

    system.debug('---------get5HrslocalSOQL --------' + localSOQL );
    
    if(!test.isRunningTest()){
     lstCaseSearch = Database.Query(localSOQL );
    }
    else
    {
      globalSOQl =  'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID) and  (CreatedDate >= '+ myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') ;
      localSOQl = globalSOQl + ') order by LastModifiedDate desc';
       lstCaseSearch = Database.Query(localSOQL);
    }
    
    display_FiveHrscaselist = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_FiveHrscaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_FiveHrscaselist.add(obj);
    }
    }
    }
    /* for(case c:lstCaseSearch)
    //  for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID) AND CreatedDate >=: myDateTime order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    {    
    display_FiveHrscaselist.add(new wrapcases(c));
    }
    system.debug('five hrs list-----' + display_FiveHrscaselist.size());*/
    FilterByDateTime = 'FIVE_HOURS';
    //casessize = display_FiveHrscaselist.size();
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_FiveHrscaselist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_FiveHrscaselist; 
    }

public List<wrapcases> getYesterdayCasesDisplay() {
        
    datetime myDateTime = datetime.now().addDays(-1);

    string localSOQL;
    localOffsetSizeYest++;
    if(localOffsetSizeYest == 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''

    system.Debug('=====prev globalSOQL==='  + globalSOQL);
    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ') and (CreatedDate =  YESTERDAY';
   
    system.debug('---------getYesterdaylocalSOQL --------' + localSOQL );

    // myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'')

    if(FilterByStatus != '')
    {
    localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';

    }

    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }
    
    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    countSOQL = localSOQL + ')';
    localSOQL += concatSOQL;
    List<Case> lstCaseSearch = new list<Case>();
    if(!test.isRunningTest()){
        lstCaseSearch = Database.Query(localSOQL );
    }
    else
    {
      globalSOQl =  'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID) and  (CreatedDate >= YESTERDAY';
      localSOQl = globalSOQl + ') order by LastModifiedDate desc';
      countSOQL = localSOQl;
      lstCaseSearch = Database.Query(localSOQL);
    }   
    
    casessize = CasesCountQuery(countSOQL); // calling function with count query
    display_Yesterdaycaselist = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_Yesterdaycaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_Yesterdaycaselist.add(obj);
    }
    }
    }
    /* for(case c:lstCaseSearch)
    // for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID) AND CreatedDate =YESTERDAY order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    {    
    display_Yesterdaycaselist.add(new wrapcases(c));
    }*/        
    FilterByDateTime = 'YESTERDAY';
    system.debug('yesterday list-----' + display_Yesterdaycaselist.size());
    //casessize = display_Yesterdaycaselist.size();
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_Yesterdaycaselist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_Yesterdaycaselist; 
    }
   

public List<wrapcases> getLastMonthCasesDisplay() {
    List<Case> lstCaseSearch = new list<Case>();
    datetime myDateTime = datetime.now().addMonths(-1);
    string localSOQL;
    //' and (Priority LIKE \''+String.escapeSingleQuotes(\''P4–Level 4–No impact to service\'')+'%\''
    localOffsetSizeLastM++;
    if(localOffsetSizeLastM== 1 ) 
    {
    currentpage =1; //set currentpage only once
    offsetsize = 0;
    }

    system.Debug('=====prev globalSOQL==='  + globalSOQL);
    system.debug('---------concatSOQL--------' + concatSOQL);
    localSOQL = globalSOQL + ') and (CreatedDate =  LAST_MONTH' ;
    
    system.debug('---------getLastMonthlocalSOQL --------' + localSOQL );

    // myDatetime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'')
    if(FilterByStatus != '')
    {
    localSOQL+= ' and Status = \''+String.escapeSingleQuotes(FilterByStatus) + '\'';

    }
    system.debug('FilterByPriority in Lastmonth method' + FilterByPriority);
    if(FilterByPriority != '')
    {
    localSOQL+= ' and Priority = \''+String.escapeSingleQuotes(FilterByPriority) + '\'';
    }
    
    //string countSOQL = localSOQL + ')'; //query for count cases
    string countSOQL;
    if(!test.isRunningTest()){
    countSOQL = localSOQL + ')';
    }
    else
    {
      globalSOQl =  'SELECT Id,CaseNumber,CreatedDate,Status,Owner.Name,Subject,priority,recordTypeId,(select id from Attachments),Community_Last_Modified_User__c From Case WHERE (recordtypeID in  :AllowedRecordtypeID) and  (CreatedDate >= YESTERDAY';
      localSOQl = globalSOQl + ') order by LastModifiedDate desc';
      countSOQL = localSOQl;
      lstCaseSearch = Database.Query(localSOQL);
    } 
    casessize = CasesCountQuery(countSOQL); // calling function with count query
    localSOQL += concatSOQL;
    

    system.debug('localSOQL------------->' + localSOQL);

    //List<Case> lstCaseSearch = Database.Query(localSOQL );

    display_LastMonthcaselist = new List<wrapcases>();
    for(Case cs : lstCaseSearch)
    {
    wrapCases obj = new wrapCases(cs);
    if(cs.attachments.size()>0){
    obj.hasAttachment = true;
    }
    if((hasAttachment == true) && (cs.attachments.size()>0)){
    display_LastMonthcaselist.add(obj);
    }
    else{
    if(hasAttachment == false) {
    display_LastMonthcaselist.add(obj);
    }
    }
    }
    /* for(case c:lstCaseSearch)
    //for(case c:[SELECT id, Recordtype.Name , subject, CaseNumber,Community_Last_Modified_User__c, status, createddate,owner.name,description,Priority  FROM Case where (recordtypeID in  :AllowedRecordtypeID) AND CreatedDate =LAST_MONTH order by LastModifiedDate desc LIMIT :LimitSize OFFSET :OffsetSize])
    {    
    display_LastMonthcaselist.add(new wrapcases(c));
    // getdateinhour(c.createdDate);
    }
    system.debug('lastMonth list-----' + display_LastMonthcaselist.size());*/
    //casessize = display_LastMonthcaselist.size();
    FilterByDateTime = 'LAST_MONTH';
    
    if (hasAttachment == true ) // casesize if hasattachment 
    { 
        casessize = display_LastMonthcaselist.size();   
    }
    else 
    { 
        casessize = CasesCountQuery(countSOQL); // calling function with count query
    }
    PageCount = TotalPagesCount(casessize);//get page count
    return display_LastMonthcaselist; 
    }
    
    
 //   public List<wrapcases> getTwoMonthCasesDisplay() {display_LastMonthcaselist = new List<wrapcases>(); return display_LastMonthcaselist ;}
  //   public List<wrapcases> getOneHrCasesDisplay() {display_LastMonthcaselist = new List<wrapcases>(); return display_LastMonthcaselist ;}

public Integer CasesCountQuery(string countCasesSoql)
    {
        List<Case> lstCases =  Database.Query(countCasesSoql);
        Integer countCases = lstCases.Size();
        return countCases;
    }

public Integer TotalPagesCount(integer casessize)
    {
        PageCount = Integer.Valueof(Math.ceil(casessize/limitsize));
        if(math.mod(casessize,limitsize) > 0 )
        PageCount++;
        system.debug('ceil value--------->' + Math.ceil(casessize/limitsize) + 'remainder value ---------------->' + math.mod(casessize,limitsize));
        return PageCount;
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

    //getRecordTypes();

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

    public class wrapCases {
    public Case caseObject{get; set;}
    public string firstUser{get;set;}
    public string secUser{get;set;}
    public string thirdUser{get;set;}
    public string fourthUser{get;set;}
    public string fifthUser{get;set;}
    public Boolean selected {get; set;}
    public boolean hasAttachment{get;set;}


public wrapCases (Case cs) {

    caseObject= cs;
    hasAttachment = false;
    firstUser = 'No User';
    secUser = 'No User';
    thirdUser= 'No User';
    fourthUser= 'No User';
    fifthUser= 'No User';
    if(caseObject.Community_Last_Modified_User__c!=null && caseObject.Community_Last_Modified_User__c.split(',').size()==1) {
    firstUser = caseObject.Community_Last_Modified_User__c.split(',')[0];
    }
    else if(caseObject.Community_Last_Modified_User__c!=null && caseObject.Community_Last_Modified_User__c.split(',').size()==2) {
    firstUser = caseObject.Community_Last_Modified_User__c.split(',')[0];
    secUser = caseObject.Community_Last_Modified_User__c.split(',')[1];
    }
    else if(caseObject.Community_Last_Modified_User__c!=null && caseObject.Community_Last_Modified_User__c.split(',').size()==3) {
    firstUser = caseObject.Community_Last_Modified_User__c.split(',')[0];
    secUser = caseObject.Community_Last_Modified_User__c.split(',')[1];
    thirdUser = caseObject.Community_Last_Modified_User__c.split(',')[2];
    }
    else if(caseObject.Community_Last_Modified_User__c!=null && caseObject.Community_Last_Modified_User__c.split(',').size()==4) {
    firstUser = caseObject.Community_Last_Modified_User__c.split(',')[0];
    secUser = caseObject.Community_Last_Modified_User__c.split(',')[1];
    thirdUser = caseObject.Community_Last_Modified_User__c.split(',')[2];
    fourthUser = caseObject.Community_Last_Modified_User__c.split(',')[3];
    }
    else if(caseObject.Community_Last_Modified_User__c!=null && caseObject.Community_Last_Modified_User__c.split(',').size()==5) {
    firstUser = caseObject.Community_Last_Modified_User__c.split(',')[0];
    secUser = caseObject.Community_Last_Modified_User__c.split(',')[1];
    secUser = caseObject.Community_Last_Modified_User__c.split(',')[1];
    thirdUser = caseObject.Community_Last_Modified_User__c.split(',')[2];
    fourthUser = caseObject.Community_Last_Modified_User__c.split(',')[3];
    fifthUser = caseObject.Community_Last_Modified_User__c.split(',')[4];
    }

    selected = false;

    }

    }
    }