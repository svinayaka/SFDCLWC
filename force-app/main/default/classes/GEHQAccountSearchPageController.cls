/*    
Class Name        : GEHQAccountSearchPageController
Purpose/Overview  : Accounts Search
Author            : Jayadev Rath
Test Class        : GEHQAccountSearchPage_Test 
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 
                  :  27th March 2012    :  Rekha.N      : updated for R-7513 
                                           Praneetha T  : Updated for R-8162 Jerry Release
*/


public class GEHQAccountSearchPageController {
//----> Start of Code Added by Jayadev (for pagination)
String ViewName='My GE Accounts';
Public Integer NextCount=0;
Public Integer NoOfRows=20;
Public Boolean hasNext{get;set;}
Public Boolean hasPrev{get;set;}
Public Boolean hasFirst{get;set;}
Public Boolean hasLast{get;set;}
Public Integer StartRec{get;set;}
Public Integer EndRec{get;set;}
Public Integer TotalNoOfAccounts{get;set;}
public GE_HQ_Account_Plan__c AccPlanObj{get;set;}
public list<GE_HQ_Acc_AccPlan_Rel__c>  DelAcctMyGE{get;set;}    
PageReference redUrl = new PageReference('/001/o');    

 Public void getNext()
    {
        if(NextCount+NoOfRows <= TotalNoOfAccounts)
            NextCount+=NoOfRows;
        else
            NextCount = TotalNoOfAccounts - NoOfRows;
    }
    Public void getPrev()
    {
        if(NextCount-NoOfRows >=0)
            NextCount-=NoOfRows;
        else
            NextCount=0;
    }
    Public void getFirst()
    {
        NextCount=0;
    }
    Public void getLast()
    {
        NextCount=TotalNoOfAccounts - NoOfRows;
    }


//----> End of Code Added by Jayadev (for pagination)

    GE_HQ_Acc_AccPlan_Rel__c objAPA = new GE_HQ_Acc_AccPlan_Rel__c();
    private String accPlanId;
    
    public GEHQAccountSearchPageController(ApexPages.StandardController controller) {
    
        objAPA = (GE_HQ_Acc_AccPlan_Rel__c)controller.getRecord();
        AccountType = 'All Accounts';
        AccPlanObj = new GE_HQ_Account_Plan__c();
        //AccPlanObj.GE_PRM_Channel_Sales_Manager__c =null;
    }


    public boolean chkFlag{get; set;}
    
    public void chkAllBox()
    {
        
        if(chkFlag == true)
        {
            System.debug('****Before Adding, Chk All****'+selected);
            for(Account accEnt : accountResults )
            {
                Selected.add(accEnt.id);
            }
            
            System.debug('****After Adding, Chk All****'+selected);
        }
        else
        Selected.clear();
        
    }
    
    public id[] selected = new  id[]{};
    public id[] getSelected()
    {
       return Selected;
    }
    
    public void setSelected(id[] selected)
    {
           System.debug('****Before Set selected****'+this.Selected.size());

           this.Selected.addAll(selected);
           
           System.debug('****After Set Selected****'+this.Selected.size());
                 
    }    
    
    public void commonlySelected(){
           if(this.Selected.size()>0){
           this.Selected.sort();
           
           System.debug('****After Sort****'+this.Selected);

           Id[] uniqueIds = new Id[] {};
           Id temp;
           if(this.Selected.size()>0){
               temp= this.Selected[0];
           }               
           for(Integer i=1;i<this.Selected.size();i++){
               if(temp==this.Selected[i]){
                   uniqueIds.add(temp);
               }
               temp = this.Selected[i];
                  
           }
           
           System.debug('****Common Ids****'+uniqueIds);
           if(uniqueIds.size()>0){
           this.Selected.clear();
           this.Selected.addAll(uniqueIds);
           }
           System.debug('****At the end selected Ids****'+this.Selected);
           }
    }
/*    
    public void resetChkFlag(){
                System.debug('****Flag****'+chkFlag);
                if(chkFlag == true && 2*accountResults.size() != selected.size()){
                    commonlySelected();
                    chkFlag=false;
                }
                else commonlySelected();
  
                System.debug('****Flag****'+chkFlag);
                                
     
    }
 
*/
    private List<Account> accountResults= new List<Account>();

    public List<Account> getAccountResults() {
//----> Start of Code Added by Jayadev (for pagination)

//    NoOfRows=resultNo;
    if(accountResults.size()==0)
        return null;
    List<Account> AccResultSet = new List<Account>();
    For(Integer i=0; i<NoOfRows && NextCount+i < TotalNoOfAccounts; i++)
    {
        AccResultSet.add(accountResults[NextCount+i]);
    }
     if(NextCount <= 0)    
            {
                hasFirst=False;
                hasPrev=False;
            }
            else
            {
                hasFirst=True;
                hasPrev=True;
            }
            if(NextCount >= (TotalNoOfAccounts - NoOfRows))
            {
                hasLast=False;
                hasNext=False;
            }
            else
            {
                hasLast=True;
                hasNext=True;
            }
//            StartRecPL=NextCountPL+1;
            StartRec=(TotalNoOfAccounts == 0)?0:NextCount+1;
            if(StartRec+NoOfRows > TotalNoOfAccounts)
                EndRec=TotalNoOfAccounts;
            else
                EndRec=StartRec+NoOfRows -1;
                
//                ======
    
    
    if(AccResultSet.size()>0)
        return AccResultSet; 
    else { return null; }
//----> End of Code Added by Jayadev (for pagination)    

//        return accountResults;
    }

    public String searchText{get;set;}
    public String dunsNumber{get;set;}
    public String city{get;set;}
    public String country{get;set;}
    public String phone{get;set;}
    public string state{get;set;}
    public string salesRegion{get;set;}
    public PageReference search(){
    //Added Starts
        Set<ID> accId= new Set<ID>();
    /*        
    if(ApexPages.currentPage().getParameters().get('retURL')!=null)
    accPlanningId = ApexPages.currentPage().getParameters().get('retURL').replace('/',''); 
    System.debug('*********accPlanningId ********'+accPlanningId );
    */
    if(ApexPages.currentPage().getParameters().get('accPlanId')!=null)
        accPlanningId = ApexPages.currentPage().getParameters().get('accPlanId'); 
    System.debug('*********accPlanningId ********'+accPlanningId );
    List<GE_HQ_Acc_AccPlan_Rel__c> accPlan = [select id,GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c=:accPlanningId ];
    System.debug('*********accPlan ********'+accPlan );
    for(GE_HQ_Acc_AccPlan_Rel__c AP:accPlan){
    accId.add(AP.GE_HQ_Account__c);
     System.debug('*********accId********'+accId);
     }
   
    Selected.clear();
    String query = 'Select name, GE_HQ_DUNS_Number__c, ShippingCity, ShippingState, ShippingCountry,Phone,GE_HQ_Region_Tier1__c from account where id NOT IN:accId';
    System.debug('********************query *********************'+query );
//    String queryLimit = ' limit ' + resultNo;

    String conditions = '';
    if (searchText != null && searchText != '')
    {
    searchText=String.escapeSingleQuotes(searchText); /*Placed by Prasanth Nalle To avoid SOQL Injections */
        conditions += ' name LIKE \'%' + searchText + '%\'';
    }
    if (dunsNumber != null && dunsNumber != '') {
        dunsNumber=String.escapeSingleQuotes(dunsNumber);/*Placed by Prasanth Nalle To avoid SOQL Injections */
        if (conditions != '') conditions+= ' and ';
        conditions += ' GE_HQ_DUNS_Number__c Like \'%' + dunsNumber + '%\'';
    } 
    if (city != null && city  != '') {
        city=String.escapeSingleQuotes(city);/*Placed by Prasanth Nalle To avoid SOQL Injections */
        if (conditions != '') conditions+= ' and ';
        conditions += ' ShippingCity Like \'%' + city + '%\'';
    }
    if (country != null && country != '' ) {
        country=String.escapeSingleQuotes(country);/*Placed by Prasanth Nalle To avoid SOQL Injections */
        if (conditions != '') conditions+= ' and ';
        conditions += ' ShippingCountry Like \'%' + country + '%\'';
    }
    if (state != null && state != '' ) {
        state=String.escapeSingleQuotes(state);/*Placed by Prasanth Nalle To avoid SOQL Injections */
        if (conditions != '') conditions+= ' and ';
        conditions += ' ShippingState Like \'%' + state + '%\'';
    }
    /*if (salesRegion != null && salesRegion != '' ) {
        if (conditions != '') conditions+= ' and ';
        conditions += ' GE_HQ_Acc_Sal_Region__c Like \'%' + salesRegion + '%\'';
    }*/
    
    if (phone!= null && phone!= '' ) {
        phone=String.escapeSingleQuotes(phone);/*Placed by Prasanth Nalle To avoid SOQL Injections */
        if (conditions != '') conditions+= ' and ';
        conditions += ' Phone = \'' + phone+ '\'';
    }
    if (conditions != '')
        query += ' AND ' + conditions;
    query += ' order by CreatedDate DESC limit 1000';
    //apexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, query));
    accountResults = Database.query(query);
    TotalNoOfAccounts = accountResults.size();        // Code added by Jayadev for pagination
    NextCount = 0;        // Code added by Jayadev for pagination
    return null;
    }
    private boolean isDuplicate(string strAccId){
        boolean bRet = false;
        for(GE_HQ_Acc_AccPlan_Rel__c obj:lstExisting){
            if(strAccId==obj.GE_HQ_Account__c+''){
                bRet = true;  break;
            }
        }
        return bRet;
    }
    String accPlanningId = '';
    List<GE_HQ_Acc_AccPlan_Rel__c> lstExisting = new List<GE_HQ_Acc_AccPlan_Rel__c>();
    
    public PageReference ProcessSelected()
    {
        /*
        if(ApexPages.currentPage().getParameters().get('retURL')!=null){
            String retURL = ApexPages.currentPage().getParameters().get('retURL'); //Code added by Prasanna
            //accPlanningId = ApexPages.currentPage().getParameters().get('retURL').replace('/',''); 
            accPlanningId = retURL.substring(retURL.length()-15, retURL.length());   //Code added by Prasanna  
        */
        
          if(chkFlag)
          commonlySelected();

         if(ApexPages.currentPage().getParameters().get('accPlanId')!=null){
             accPlanningId = ApexPages.currentPage().getParameters().get('accPlanId'); 
             System.debug('*********accPlanningId ********'+accPlanningId ); 
                                 
            lstExisting = [select GE_HQ_Account__c, name from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c=:accPlanningId];
            System.debug('Raj accPlanningId :::::'+accPlanningId);
            System.debug('Raj selected:::::'+selected);
            List<GE_HQ_Acc_AccPlan_Rel__c> lstAPA = new List<GE_HQ_Acc_AccPlan_Rel__c>();
            for(Id accId:selected){
                
                    GE_HQ_Acc_AccPlan_Rel__c newAPA = new GE_HQ_Acc_AccPlan_Rel__c();
                    newAPA.GE_HQ_Account__c = accId;
                    newAPA.GE_HQ_Account_Plan__c = accPlanningId;
                    lstAPA.add(newAPA);
               
            }
            insert lstAPA;
            pagereference pg = new Pagereference('/' + accPlanningId);
            pg.setRedirect(true);
            return pg;
        }
        return null;
    } 
    //-----------Added Starts-------

  public PageReference Cancel()
    {  
        /* if(ApexPages.currentPage().getParameters().get('retURL')!=null){
        accPlanningId = ApexPages.currentPage().getParameters().get('retURL').replace('/','');            
        System.debug('*********accPlanningId *****'+accPlanningId );            
        }*/
         if(ApexPages.currentPage().getParameters().get('accPlanId')!=null)
             accPlanningId = ApexPages.currentPage().getParameters().get('accPlanId'); 
         System.debug('*********accPlanningId ********'+accPlanningId ); 
         PageReference BacktoAccPlan = new PageReference('/'+accPlanningId);
         BacktoAccPlan.setRedirect(true); 
        return BacktoAccPlan;
   }
     //-----------Added Ends-------
 
      public List<SelectOption> accSalesRegions {
        get { 
            if (accSalesRegions == null) {
                accSalesRegions = new List<SelectOption>();
                //Set<String> setAccount = new Set<String>();
                accSalesRegions.add(new SelectOption('','--None--'));
                // Updated this logic to get only the unique Sales Region values
                List<AggregateResult> ar = [Select Name nm From GE_ES_Sales_Region__c Group by Name Order By Name ASC limit 999];
                //List<AggregateResult>ar =[select GE_HQ_Acc_Sal_Region__c nm from account Group by GE_HQ_Acc_Sal_Region__c Order By GE_HQ_Acc_Sal_Region__c ASC limit 999];
                For(AggregateResult a :ar) 
                    accSalesRegions.add(new SelectOption((String)a.get('nm'),(String)a.get('nm')));
            }
            return accSalesRegions;          
        }
        set;
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
  public void myGEAccount(){
       if(AccountType=='My GE Accounts'){
       
           isGEAccount = true;
           //Getting current user
           User userObj = [select id from User where id =: UserInfo.getUserId()];
           //User userObj = [select id from User where id ='005K0000000Q55o'];
           Map<Id,GE_HQ_Account_Plan__c> myGEAccountsMap;
           Map<Id, RecordType> recordTypeMap;
           recordTypeMap = new Map<Id,RecordType>([select id,Developername,name from RecordType where sObjectType ='GE_HQ_Account_Plan__c' and Developername='Private_Plan']);
           //Getting Private Plan ID and Child Accounts
           myGEAccountsMap = new Map<Id,GE_HQ_Account_Plan__c>([select id, name, (select id, GE_HQ_Account__c, GE_HQ_Account_Plan__c from AccAccPlanRel__r) from GE_HQ_Account_Plan__c where RecordTypeId in: recordTypeMap.keyset() and ownerId=:userObj.id]);
           Set<Id> accIds = new Set<Id>();
           for(GE_HQ_Account_Plan__c accountPlanObj: myGEAccountsMap.values())
               for(GE_HQ_Acc_AccPlan_Rel__c myGEAccObj: accountPlanObj.AccAccPlanRel__r)
                   accIds.add(myGEAccObj.GE_HQ_Account__c);
           String query = 'Select name, GE_HQ_DUNS_Number__c, ShippingCity, ShippingState, ShippingCountry,Phone,GE_HQ_Region_Tier1__c from account where id IN:accIds  order by name limit 9999';
           accountResults = Database.query(query);
           TotalNoOfAccounts = accountResults.size();
           NextCount = 0;
                         
       }           
       else{
           isGEAccount = false;
           accountResults = new List<Account>();  
       }           
       System.debug('****Acc Type****'+AccountType);
       System.debug('****ISGEAccount****'+isGEAccount);              
            
  } 
  
  /* Code Added for J Release, R-8162 (S-05631) - Praneetha T on 18th May 2012 */
   
      public void MyGEAccts(){    
      AccPlanID=ApexPages.currentPage().getParameters().get('AccPlanid');
      System.debug('Acc Plan ID::** '+AccPlanId );  
      DelAcctMyGE = [SELECT  id,name,GE_HQ_Account__c,GE_HQ_Site_Use_Code__c,GE_HQ_State__c,GE_HQ_Street__c,GE_HQ_Phone__c,GE_HQ_Station_Name__c,GE_Energy_HQ_Region__c,GE_HQ_Account_Plan__c,GE_HQ_City__c,GE_HQ_Country__c,GE_HQ_DUNS_Number__c,GE_HQ_Sales_Region__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c =:AccPlanId];
      System.debug('Acc Plan ID::** '+AccPlanId );  
      System.debug('Acc Plan ID::** '+DelAcctMyGE );
      System.debug('****Size of List****'+DelAcctMyGE.size());
           TotalNoOfAccounts = DelAcctMyGE.size();
           NextCount = 0;
            
          }
      
    public boolean chkFlag1{get; set;}    
    public void chkAllBox1()
    {
        if(chkFlag1 == true)
        {
            for(GE_HQ_Acc_AccPlan_Rel__c accEnt : DelAcctMyGE)
            {
                selected1.add(accEnt.id);
            }
        }
        else
        Selected1.clear();
    }
    
    public List<id> selected1 = new  id[]{};
    public id[] getSelected1()
    {
       return Selected1;
    }
    public void setSelected1(id[] selected1)
    {  
       this.Selected1.addAll(selected1);
    }
    
    
     public void commonlySelected1(){
           this.Selected1.sort();
           
           System.debug('****After Sort****'+this.Selected1);

           Id[] uniqueIds = new Id[] {};
           Id temp;
           if(this.Selected1.size()>0){
               temp= this.Selected1[0];
           }               
           for(Integer i=1;i<this.Selected1.size();i++){
               if(temp==this.Selected1[i]){
                   uniqueIds.add(temp);
               }
               temp = this.Selected1[i];
                  
           }
           
           System.debug('****Common Ids****'+uniqueIds);
           
           this.Selected1.clear();
           this.Selected1.addAll(uniqueIds);
           System.debug('****At the end selected Ids****'+this.Selected1);

    }
    
   // private List<GE_HQ_Acc_AccPlan_Rel__c> DelAcctMyGE1= new List<GE_HQ_Acc_AccPlan_Rel__c>();

    public List<GE_HQ_Acc_AccPlan_Rel__c> getAccountResults1() {

    if(DelAcctMyGE.size()==0)
        return null;
    List<GE_HQ_Acc_AccPlan_Rel__c> GEAcctSet = new List<GE_HQ_Acc_AccPlan_Rel__c>();
    For(Integer i=0; i<NoOfRows && NextCount+i < TotalNoOfAccounts; i++)
    {
        GEAcctSet.add(DelAcctMyGE[NextCount+i]);
    }
     if(NextCount <= 0)    
            {
                hasFirst=False;
                hasPrev=False;
            }
            else
            {
                hasFirst=True;
                hasPrev=True;
            }
            if(NextCount >= (TotalNoOfAccounts - NoOfRows))
            {
                hasLast=False;
                hasNext=False;
            }
            else
            {
                hasLast=True;
                hasNext=True;
            }
            StartRec=(TotalNoOfAccounts == 0)?0:NextCount+1;
            if(StartRec+NoOfRows > TotalNoOfAccounts)
                EndRec=TotalNoOfAccounts;
            else
                EndRec=StartRec+NoOfRows -1;
                
   
    if(GEAcctSet.size()>0)
        return GEAcctSet; 
    else { return null; }
    }
      
    
    public PageReference DeleteSelected()
    {       
             if(chkFlag1)
             commonlyselected1();
             if(selected1.size()>0){
                  delete [select id from GE_HQ_Acc_AccPlan_Rel__c where id in:selected1];
              }       
             
            if(ApexPages.currentPage().getParameters().get('AccPlanid')!=null)
            {
            accPlanningId = ApexPages.currentPage().getParameters().get('AccPlanid');   
            pagereference pg = new Pagereference('/'+accPlanningId);
            pg.setRedirect(true);
            return pg;
            }
            return null;
                            
    }
    /* End of code for J Release, R-8162 (S-05631) - Praneetha T on 18th May 2012 */
    
    
    /* Code Added for J Release, R-7849 (S-05610) - Ramakrishna Kolluri on 21 May 2012 */
      public void goButton(){
           System.debug('****** UserId ******'+AccPlanObj.GE_HQ_Select_User__c);
           
           try{
           User userObj = [select id from User where id =:AccPlanObj.GE_HQ_Select_User__c];
           
           IF(userobj!=null)
           {
           //User userObj = [select id from User where id ='005K0000000Q55o'];
           Map<Id,GE_HQ_Account_Plan__c> myGEAccountsMap;
           Map<Id, RecordType> recordTypeMap;
           recordTypeMap = new Map<Id,RecordType>([select id,Developername,name from RecordType where sObjectType ='GE_HQ_Account_Plan__c' and Developername='Private_Plan']);
           //Getting Private Plan ID and Child Accounts
           myGEAccountsMap = new Map<Id,GE_HQ_Account_Plan__c>([select id, name, (select id, GE_HQ_Account__c, GE_HQ_Account_Plan__c from AccAccPlanRel__r) from GE_HQ_Account_Plan__c where RecordTypeId in: recordTypeMap.keyset() and ownerId=:userObj.id]);
           if(myGEAccountsMap.size()==0){
               ApexPages.Message message = new ApexPages.message(ApexPages.severity.FATAL,'No private plan exist for the selected user');
               ApexPages.addMessage(message);
            }    
           Set<Id> accIds = new Set<Id>();
           for(GE_HQ_Account_Plan__c accountPlanObj: myGEAccountsMap.values())
               for(GE_HQ_Acc_AccPlan_Rel__c myGEAccObj: accountPlanObj.AccAccPlanRel__r)
                   accIds.add(myGEAccObj.GE_HQ_Account__c);
           String query = 'Select name, GE_HQ_DUNS_Number__c, ShippingCity, ShippingState, ShippingCountry,Phone,GE_HQ_Region_Tier1__c from account where id IN:accIds  order by name limit 9999';
           accountResults = Database.query(query);
           TotalNoOfAccounts = accountResults.size();
           NextCount = 0;
           NoOfRows=50;
           AccPlanObj = new GE_HQ_Account_Plan__c();
           }
           }
    catch(Exception e)
    {
    
      ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Please Select User.');
       ApexPages.addMessage(myMsg);
 
    }
      
  }
  
  public PageReference processSelectButton(){
        if(chkFlag)
          commonlySelected();
      User UserObj = [Select Id,GE_HQ_Tier_1_P_L__c,GE_HQ_SSO_ID__c from User where id = :UserInfo.getUserId()][0];
      System.debug('****User Obj****'+ UserObj);
      Map<Id,GE_HQ_Account_Plan__c> myGEAccountsMap;
      Map<Id, RecordType> recordTypeMap;
      recordTypeMap = new Map<Id,RecordType>([select id,Developername,name from RecordType where sObjectType ='GE_HQ_Account_Plan__c' and Developername='Private_Plan']);
      //Getting Private Plan ID and Child Accounts
      myGEAccountsMap = new Map<Id,GE_HQ_Account_Plan__c>([select id, name, (select id, GE_HQ_Account__c, GE_HQ_Account_Plan__c from AccAccPlanRel__r) from GE_HQ_Account_Plan__c where RecordTypeId in: recordTypeMap.keyset() and ownerId=:userObj.id]);
      if(myGEAccountsMap.size()==0 || myGEAccountsMap == null){        
          System.debug('**** Create a new Account Plan****');
          String APName= 'Private Plan ('+UserObj.GE_HQ_SSO_ID__c+')'; // If required first name can be provided for better look n feel
          String Btier = (UserObj.GE_HQ_Tier_1_P_L__c == 'Energy Services') ? 'ES' : ( (UserObj.GE_HQ_Tier_1_P_L__c == 'Power & Water') ? 'P&W' : ( (UserObj.GE_HQ_Tier_1_P_L__c == 'Oil & Gas') ? 'O&G' : ''));
          String recordTypeName = Schema.SObjectType.GE_HQ_Account_Plan__c.getRecordTypeInfosByName().get('Private Plan').getRecordTypeId();
          GE_HQ_Account_Plan__c newAccPlan = new GE_HQ_Account_Plan__c(Name = APName, OwnerId =UserObj.Id, GE_HQ_Business_Tier1__c = Btier, RecordTypeId = recordTypeName);
          Insert newAccPlan;
          AccPlanId = newAccPlan.Id;
          System.debug('Record Type::** '+newAccPlan.RecordType );
          System.debug('****Private Plan created for the current User**** '+AccPlanId );
       }
            // Acc Plan exists. So Add Accounts directly
       else {    
                 AccPlanId = myGEAccountsMap.values()[0].id;
                 System.debug('****Private Plan Acc Id****'+AccPlanId);
                 System.debug('****Private Plan is already exist for the current User****'); 
       }
        
      // Get all Existing Accounts for the Account Plan
      lstExisting = [select GE_HQ_Account__c, name from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c=:accPlanId];
      List<GE_HQ_Acc_AccPlan_Rel__c> lstAPA = new List<GE_HQ_Acc_AccPlan_Rel__c>();
      for(Id accId:selected){
          if(!isDuplicate(accId)){ //avoid duplication
              System.debug('****Selected '+accId+' is not duplicate****');
              GE_HQ_Acc_AccPlan_Rel__c newAPA = new GE_HQ_Acc_AccPlan_Rel__c();
              newAPA.GE_HQ_Account__c = accId;
              newAPA.GE_HQ_Account_Plan__c = accPlanId;
              newAPA.GE_HQ_Acc_Type__c = 'Private Plan';
              lstAPA.add(newAPA);
          }
      }
      System.debug('****Total New Accounts****'+lstAPA.size());
      if(lstAPA.size()>0){
          insert lstAPA;
          System.debug('**** Inserted My GE Accounts ****');
      } 
      selected.clear();
      chkFlag=false;
      String ViewId;
      String keyPref = GE_HQ_Acc_AccPlan_Rel__c.getsObjectType().getDescribe().keyPrefix;
        List<SelectOption> views = new ApexPages.StandardSetController(lstAPA).getListViewOptions();
        For(SelectOption v: views)  If(v.getLabel() == ViewName) { ViewId = v.getValue(); break; }
        // Redirect to the Planned Account object.
        redUrl= (ViewId != Null) ? new PageReference('/'+keyPref+'?fcf='+ViewId.substring(0,15)) : new PageReference('/'+keyPref+'/o');
        redUrl.setRedirect(True);
        Return redUrl;
   
    }
    public pageReference CancelClone(){
    String ViewId;
    List<GE_HQ_Acc_AccPlan_Rel__c> lstAPA = new List<GE_HQ_Acc_AccPlan_Rel__c>();
    String keyPref = GE_HQ_Acc_AccPlan_Rel__c.getsObjectType().getDescribe().keyPrefix;
        List<SelectOption> views = new ApexPages.StandardSetController(lstAPA).getListViewOptions();
        For(SelectOption v: views)  If(v.getLabel() == ViewName) { ViewId = v.getValue(); break; }
        // Redirect to the Planned Account object.
        redUrl= (ViewId != Null) ? new PageReference('/'+keyPref+'?fcf='+ViewId.substring(0,15)) : new PageReference('/'+keyPref+'/o');
        redUrl.setRedirect(True);
        Return redUrl;
       // return new pageReference('/a0E?fcf=00BA0000007ChKd');
    
    }
     /* end of Code Added for J Release, R-7849 (S-05610) - Ramakrishna Kolluri on 21 May 2012 */               
}