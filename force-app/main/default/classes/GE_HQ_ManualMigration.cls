public with sharing class GE_HQ_ManualMigration{
    
    /*public String systemURL = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/';
    public String strMergeDuns{get;set;}
    public String strMasterDuns {get;set;}
    public String OrigDUNS{get;set;}
    public String NewDUNS{get;set;}
    List<String> usrEmail1= new List<String>();
    Integer i;
    Set<ID> OwnrId= new Set<ID>();
    Set<ID> AccmergId= new Set<ID>();
    public ID oppId;
    public Account accMergeDuns{get;set;}
    public Account accMasterDuns{get;set;}
    public Merged_Account_History__c mergdAccRec{get;set;}
    public Merged_Account_History__c mergdAcc1 ;
    public Merged_Account_History__c mergdAcc;
    public List<OpportunityTeamMember> oppTMRec;
    List<User > usr= new List<User >();

    public GE_HQ_ManualMigration(ApexPages.StandardController controller)
    {

    }

    public pageReference Search()
    {
    pageReference pgRef;

    system.debug('*******************OrigDUNS********'+OrigDUNS);
    system.debug('*******************NewDUNS********'+NewDUNS);

    try
    {

    accMergeDuns=[select id,ownerId,GE_HQ_MERGE_STATUS__c,name,GE_HQ_DUNS_Number__c,GE_HQ_Merge_To_DUNS__c,GE_HQ_Org_ID__c,
                           BillingCity,BillingCountry,BillingState,BillingStreet,
                           BillingPostalCode,ShippingCity,ShippingCountry,
                           ShippingPostalCode,ShippingState,ShippingStreet,GE_HQ_Error_Time__c,
                           GE_HQ_Banner__c,GE_HQ_GE_Status_Flag__c,(select id,UserId from AccountTeamMembers ),
                           (select id,ownerId from Opportunities) 
                           from Account where GE_HQ_DUNS_Number__c =:OrigDUNS];
    system.debug('*****************'+accMergeDuns);

    SObject queryParentObject = accMergeDuns;

    SObject[] accTmRec= queryParentObject.getSObjects('AccountTeamMembers');
    SObject[] oppRec= queryParentObject.getSObjects('Opportunities');

    if (accTmRec!= null) {
            for (SObject accTmRec1: accTmRec){ 
            Id accTmUsrId= (Id) accTmRec1.get('UserId');
    System.debug('**************************************'+accTmUsrId);
    OwnrId.add(accTmUsrId);

         }
       }

    if (oppRec!= null) {
            for (SObject oppRec1: oppRec){ 
            Id oppOwnerId= (Id)oppRec1.get('ownerId'); 
            oppId=(Id)oppRec1.get('id');
    System.debug('**************************************'+oppOwnerId);
    OwnrId.add(oppOwnerId);

         }
       }
    OwnrId.add(accMergeDuns.ownerId);

    try
       {
       oppTMRec=[select id,UserId FROM OpportunityTeamMember where teammemberrole = 'Commercial Primary Resource' AND opportunityId=:oppId];
       
       }
       catch(Exception e)
       {
       
       e.getMessage();
       }
       if(oppTMRec!=null)
       {
       for(OpportunityTeamMember oppTMRec1:oppTMRec)
       {
       OwnrId.add(oppTMRec1.UserId);
       }
       }
    if(OwnrId!=null)
       {
       try
       {
       usr=[select id,email from User where Id IN:OwnrId];
       }
       catch(Exception e)
       {
       e.getMessage();
       }
       for(User usr1:usr)
       {
        usrEmail1.add(usr1.email);
        }

    }
    System.debug('**************************************'+usrEmail1);
      
    }
    catch(Exception e)
    {
    e.getMessage();
    }

    try
    {
    accMasterDuns=[select id,Name,GE_HQ_DUNS_Number__c,ShippingStreet,ShippingCity,ShippingState,ShippingPostalCode,ShippingCountry from Account where GE_HQ_DUNS_Number__c=:NewDUNS];
    system.debug('*****************'+accMasterDuns);
    }
    catch(Exception e)
    {
    e.getMessage();
    }

    if(accMergeDuns==null || accMasterDuns==null)
    {
    system.debug('**********************111111*****');
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR, 'DUNS Numbers entered are Invalid.'+' '+ 'Please enter valid DUNS Numbers');     
    Apexpages.addMessage(mymsg);
    return pgRef;
    }
    pgRef = new pageReference('/apex/GE_HQ_AccountMergeManual_Merge');
    pgRef .setRedirect(false);
    return pgRef;
    }


    public pageReference migrate(){

    pageReference pgRef;

    try
    {
    try{
    mergdAccRec = [select id from Merged_Account_History__c where Name=:accMergeDuns.name];
    }
    catch(Exception e)
    {
    e.getMessage();
    }

    if(mergdAccRec !=null)
    {
     try{
        mergdAcc1=[select id,GE_HQ_Account_Name__c,GE_HQ_DUNS_Number__c,
        GE_HQ_Billing_City__c,GE_HQ_Billing_Country__c,GE_HQ_Billing_State_Province__c,
        GE_HQ_Billing_Street__c,GE_HQ_Billing_Zip_Postal_Code__c,GE_HQ_Shipping_City__c,
        GE_HQ_Shipping_Country__c,GE_HQ_Postal_Code__c,GE_HQ_Shipping_State_Province__c,
        GE_HQ_Shipping_Street__c, GE_HQ_GE_Status_Flag__c  from Merged_Account_History__c where id=:mergdAccRec.id];
    }
    catch(Exception e)
    {
    e.getMessage();
    }
    //Previous Account details
    mergdAcc1.GE_HQ_Billing_City__c =accMergeDuns.BillingCity;
    mergdAcc1.GE_HQ_Billing_Country__c=accMergeDuns.BillingCountry;
    mergdAcc1.GE_HQ_Billing_State_Province__c=accMergeDuns.BillingState;
    mergdAcc1.GE_HQ_Billing_Street__c=accMergeDuns.BillingStreet;
    mergdAcc1.GE_HQ_Billing_Zip_Postal_Code__c=accMergeDuns.BillingPostalCode;
    mergdAcc1.GE_HQ_Shipping_City__c=accMergeDuns.ShippingCity;
    mergdAcc1.GE_HQ_Shipping_Country__c=accMergeDuns.ShippingCountry;
    mergdAcc1.GE_HQ_Postal_Code__c=accMergeDuns.ShippingPostalCode;
    mergdAcc1.GE_HQ_Shipping_State_Province__c=accMergeDuns.ShippingState;
    mergdAcc1.GE_HQ_Shipping_Street__c =accMergeDuns.ShippingStreet;
    if ( accMergeDuns.GE_HQ_GE_Status_Flag__c == 'A')
      {
       mergdAcc1.GE_HQ_GE_Status_Flag__c = 'Active';
      }
      else{
       mergdAcc1.GE_HQ_GE_Status_Flag__c = 'Inactive';
      }
      mergdAcc1.GE_HQ_DUNS_Number__c =accMergeDuns.GE_HQ_DUNS_Number__c;
      
      update mergdAcc1;
    AccmergId.add(mergdAcc1.id);
    }

    else{
  
   mergdAcc = new Merged_Account_History__c(name=accMergeDuns.name,
  GE_HQ_Account_Name__c=accMergeDuns.id,GE_HQ_Billing_City__c =accMergeDuns.BillingCity,
  GE_HQ_Billing_Country__c=accMergeDuns.BillingCountry,GE_HQ_Billing_State_Province__c=accMergeDuns.BillingState,
  GE_HQ_Billing_Street__c=accMergeDuns.BillingStreet,GE_HQ_Billing_Zip_Postal_Code__c=accMergeDuns.BillingPostalCode,
  GE_HQ_Shipping_City__c=accMergeDuns.ShippingCity,GE_HQ_Shipping_Country__c=accMergeDuns.ShippingCountry,
  GE_HQ_Postal_Code__c=accMergeDuns.ShippingPostalCode,GE_HQ_Shipping_State_Province__c=accMergeDuns.ShippingState,
  GE_HQ_Shipping_Street__c=accMergeDuns.ShippingStreet,GE_HQ_DUNS_Number__c =accMergeDuns.GE_HQ_DUNS_Number__c);
      
      insert mergdAcc;
      AccmergId.add(mergdAcc.id);
      System.debug('**************************************'+AccmergId);

     }
    merge accMasterDuns accMergeDuns;

    //Success E-mail to Account owner,Account Team and Opportunity Owner

     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      
      
     // for(i=0;i<usrEmail1.size();i++)
      //{
       String[] toAddresses = new String[]{usrEmail1[i]};
    //mail.setToAddresses(toAddresses);
    mail.setToAddresses(usrEmail1);
    mail.setSaveAsActivity(false);
    system.debug('******************'+usrEmail1[i]);

    mail.setSubject('Merge Process - Email Notification');

    string htmlbodyS ='<HTML><BODY>';
    htmlbodyS += '\n'+accMergeDuns.GE_HQ_Banner__c + 
    '<br/>No Action Required: An account you are associated with has been merged with another account: '+
    '<br/><br/>Previous Account: '+
    '<br/>Account Name:' +accMergeDuns.name+
    '<br/>Duns Number:'+accMergeDuns.GE_HQ_DUNS_Number__c+
    '<br/>Account Address:'+accMergeDuns.ShippingStreet+','+accMergeDuns.ShippingCity+','+accMergeDuns.ShippingState+','+accMergeDuns.ShippingCountry+','+accMergeDuns.ShippingPostalCode+','+
    '<br/><br/>New Account: '+
    '<br/>Account Name: '+accMasterDuns.name+
    '<br/>Duns Number: '+accMasterDuns.GE_HQ_DUNS_Number__c+
    '<br/>Account Address:  '+accMasterDuns.ShippingStreet+','+accMasterDuns.ShippingCity+','+accMasterDuns.ShippingState+','+accMasterDuns.ShippingCountry+','+accMasterDuns.ShippingPostalCode+
    '<br/><br/>Account URL: '+systemURL+accMasterDuns.id+
    '<br/><br/>All related lists have been migrated to the new account.'+
    '<br/><br/>Thank You,'+
    '<br/>Compass System Administrators'+
    '<br/><br/>*This is an unmonitored email box please do not reply.';
    htmlbodyS += '</BODY></HTML>';

    mail.sethtmlbody(htmlbodyS);

    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    //}
    }
    catch(Exception e)
    {
    e.getMessage();
    }

    pgRef = new pageReference('/apex/GE_HQ_AccountMergeManual_Result');
    System.debug('****************************************'+pgRef);
    return pgRef;

    }
    public pageReference Back()
    {
    pageReference pgRef;

    pgRef = new pageReference('/apex/GE_HQ_AccountMergeManual_Search');
    return pgRef;

    }
    public pageReference MastrAccPage()
    {
    pageReference pgRef;

    pgRef = new pageReference('/'+accMasterDuns.id);
    return pgRef;

    }
    //----------------------
    public static testmethod void SearchInActive()
    {

    //Parent Account
    Account TestAcc01 = New Account(Name='JCTest01');
    TestAcc01.GE_HQ_DUNS_Number__c='587';
    insert TestAcc01;
    Account retTestAcc01 = [Select id, name from Account where id=:testAcc01.id];
    system.debug('********retrieved account name = '+retTestAcc01.name);

    //Child Account
    Account TestAcc02 = New Account(Name='JCTest02');
    TestAcc02.GE_HQ_DUNS_Number__c='389';
    TestAcc02.GE_HQ_Merge_To_DUNS__c='587';
    TestAcc02.GE_HQ_GE_Status_Flag__c='';

    insert TestAcc02;
    Account retTestAcc02 = [Select id, ownerId, name from Account where id=:testAcc02.id];
    system.debug('********retrieved account name = '+retTestAcc02.name);

    Merged_Account_History__c  MAH = new Merged_Account_History__c();
    MAH.Name=TestAcc02.name;
    insert MAH;
    PageReference pageRef = Page.GE_HQ_AccountMergeManual_Search;
    Test.setCurrentPage(pageRef);

    ApexPages.StandardController conPage = new ApexPages.StandardController(retTestAcc01);
    GE_HQ_ManualMigration manualMig = new GE_HQ_ManualMigration(conPage);

    manualMig.OrigDUNS = '389';
    manualMig.NewDUNS ='587';

    manualMig.search();
    manualMig.migrate();
    manualMig.MastrAccPage();
    manualMig.Back();
    }
    public static testmethod void SearchMAH()
    {

    //Parent Account
    Account TestAcc01 = New Account(Name='JC01');
    TestAcc01.GE_HQ_DUNS_Number__c='7856';
    insert TestAcc01;
    Account retTestAcc01 = [Select id, name from Account where id=:testAcc01.id];
    system.debug('********retrieved account name = '+retTestAcc01.name);

    //Child Account
    Account TestAcc02 = New Account(Name='JC02');
    TestAcc02.GE_HQ_DUNS_Number__c='78';
    TestAcc02.GE_HQ_Merge_To_DUNS__c='7856';
    insert TestAcc02;

    Account retTestAcc02 = [Select id, ownerId, name from Account where id=:testAcc02.id];
    system.debug('********retrieved account name = '+retTestAcc02.name);
    Merged_Account_History__c  MAH = new Merged_Account_History__c();
    MAH.Name=TestAcc02.name;
    insert MAH;
    Merged_Account_History__c  recMAH =[select id from Merged_Account_History__c where id=:MAH.id];
    delete recMAH ;
    PageReference pageRef = Page.GE_HQ_AccountMergeManual_Search;
    Test.setCurrentPage(pageRef);

    ApexPages.StandardController conPage = new ApexPages.StandardController(retTestAcc01);
    GE_HQ_ManualMigration manualMig = new GE_HQ_ManualMigration(conPage);

    manualMig.OrigDUNS = '78';
    manualMig.NewDUNS ='7856';

    manualMig.search();
    manualMig.migrate();
    manualMig.MastrAccPage();
    }
    /*public static testmethod void ManualMigrationSearch()
    {

    //Parent Account
    Account TestAcc01 = New Account(Name='JCTest01');
    TestAcc01.GE_HQ_DUNS_Number__c='587';
    insert TestAcc01;
    Account retTestAcc01 = [Select id, name from Account where id=:testAcc01.id];
    system.debug('********retrieved account name = '+retTestAcc01.name);

    //Child Account
    Account TestAcc02 = New Account(Name='JCTest02');
    TestAcc02.GE_HQ_DUNS_Number__c='389';
    TestAcc02.GE_HQ_Merge_To_DUNS__c='587';
    TestAcc02.BillingCity='Hyd';
    TestAcc02.BillingCountry='INDIA';
    TestAcc02.BillingState='AP';
    TestAcc02.BillingStreet='Str';
    TestAcc02.BillingPostalCode='45435';
    TestAcc02.ShippingCity='BBSR';
    TestAcc02.ShippingCountry='INDIA';
    TestAcc02.ShippingPostalCode='75345';
    TestAcc02.ShippingState='OR';
    TestAcc02.ShippingStreet='Str1';
    TestAcc02.GE_HQ_GE_Status_Flag__c='A';

    insert TestAcc02;
    Account retTestAcc02 = [Select id, ownerId, name from Account where id=:testAcc02.id];
    system.debug('********retrieved account name = '+retTestAcc02.name);

    //Account Team Member
    accountTeamMember accTm = new AccountTeamMember();
    accTm.accountId=retTestAcc02.id;
    accTm.userID=retTestAcc02.ownerId; 
    insert accTm;

    //Opportunity on child account
      CommonTestDataFactory_GE_OG objCTDF =  new CommonTestDataFactory_GE_OG ();
        
        Account objacc = CommonTestDataFactory_GE_OG.createRelationshipAccount('test account');
        system.assertEquals('test account',objacc.Name);
        Opportunity opp= CommonTestDataFactory_GE_OG.createOppty('TestOppty',objacc.id);
        system.assertEquals('TestOppty',opp.Name);

    /*Opportunity opp = new Opportunity();
    opp.name='Testopp1';
    opp.accountid=retTestAcc02.id;
    opp.StageName='Prospecting';
    opp.closedate=date.today(); 
    insert opp; 


    //OpportunityTeamMember on child account
    OpportunityTeamMember  oppTm = New OpportunityTeamMember();
    oppTm.teammemberrole = 'Commercial Primary Resource';
    oppTm.opportunityId=opp.Id;
    oppTm.userID=retTestAcc02.ownerId;
    insert oppTm;

    Merged_Account_History__c  MAH = new Merged_Account_History__c();
    MAH.Name=TestAcc02.name;
    insert MAH;
    PageReference pageRef = Page.GE_HQ_AccountMergeManual_Search;
    Test.setCurrentPage(pageRef);

    ApexPages.StandardController conPage = new ApexPages.StandardController(retTestAcc01);
    GE_HQ_ManualMigration manualMig = new GE_HQ_ManualMigration(conPage);

    manualMig.OrigDUNS = '389';
    manualMig.NewDUNS ='587';

    manualMig.search();
    manualMig.migrate();
    manualMig.MastrAccPage();
    }
    public static testmethod void ManualMigrationCatch(){

    //Parent Account
    Account TestAcc01 = New Account(Name='JCTest01');
    TestAcc01.GE_HQ_DUNS_Number__c='587';
    insert TestAcc01;
    Account retTestAcc01 = [Select id, name from Account where id=:testAcc01.id];
    system.debug('********retrieved account name = '+retTestAcc01.name);

    PageReference pageRef = Page.GE_HQ_AccountMergeManual_Search;
    Test.setCurrentPage(pageRef);

    ApexPages.StandardController conPage = new ApexPages.StandardController(retTestAcc01);
    GE_HQ_ManualMigration manualMig = new GE_HQ_ManualMigration(conPage);

    manualMig.OrigDUNS = '389';
    manualMig.NewDUNS ='254123452';

    manualMig.search();
}
*/
    public GE_HQ_ManualMigration()  { }

    public static testmethod void GE_HQ_ManualMigrationMethod(){
        GE_HQ_ManualMigration m= new GE_HQ_ManualMigration(); 
    }

    }