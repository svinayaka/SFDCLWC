/*
Description     : This is data factory containing various method for creating Dummy Records for Test Classes Used by Accounts Scrum.
*/

@isTest (seealldata=True)


public class AccountTestDataFactory {

    static Integer count =1;
     /* Method to create new Competitor account */
    public static account createCompetitorAccount (String accountName) {
        account accnt= new account();
        accnt.name=accountName;
        accnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Competitor').getRecordTypeId();
        accnt.Account_Tier_GEOG__c = 'Global';
        accnt.Classification__c= 'Strategic';
        accnt.Type = 'Direct Customer';
        accnt.ShippingCountry = 'India';
        insert accnt;
        return accnt;
    }    
    
    /* Method to create new Competitor account with Tier */
     public static account createCompetitorAccount(String accountName,String acctTier) {
        account accnt= new account();
        accnt.name=accountName;
        accnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Competitor').getRecordTypeId();
        accnt.Account_Tier_GEOG__c = acctTier;
        accnt.Classification__c= 'Strategic';
        accnt.Type = 'Direct Customer';
        accnt.ShippingCountry = 'India';
        insert accnt;
        return accnt;
    }   
    
    
    
     public static account createAccountWithStrength(String accountName,String rectype,String accType,String accTier,String classification,
     String primaryIndustry,String strength) {
    
    //where rectype is relationship account etc.
        Account acnt = new Account();
         acnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account',rectype).getRecordTypeId();
         //acnt.Account_Tier_GEOG__c = 'Country';
         acnt.Account_Tier_GEOG__c = accTier;
         acnt.Name=accountName;
         //acnt.Type = 'EPC';
         acnt.Type = 'EPC';
         //acnt.Classification__c = 'Strategic';
         acnt.Classification__c =classification;
         //acnt.GE_ES_Primary_Industry__c = 'Industrial';
         acnt.GE_ES_Primary_Industry__c =primaryIndustry;
         //acnt.Strength__c = 'Medium';
         acnt.Strength__c =strength;
         insert acnt;
         return acnt;
         
         }
    
    /* Method to create new Relationship Account with Account_Tier_GEOG__c = 'Global';*/
    public static account createRelationshipAccountGlobal(String accountName,String accType) {
        account accnt= new account();
        accnt.name=accountName;
        accnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accnt.Account_Tier_GEOG__c = 'Global';
        accnt.Classification__c= 'Strategic';
        //accnt.Type = 'Competitor';
        accnt.Type = accType;
        accnt.ShippingCountry = 'India';
        insert accnt;
        return accnt;
    }    
    
    //Method to create new Relationship Account with Account tier
    
     public static account createRelationshipAccount(String accountName,String accTier,Id memberOf)
     {
        Account acc = new Account();
        String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.Name='TestAccount1';
        acc.Type = 'Direct Customer';
        acc.Classification__c = 'Strategic';
        acc.Member_of_GE_OG__c = memberOf;
        acc.Account_Tier_GEOG__c =accTier;
        acc.RecordTypeId=recordTypeName;
        insert acc;
        return acc;
        }
        
    //method to create relationship account with Duns number
    
    public static account createRelationshipAccount(String accountName,String dunsNumber,String accTier,String accType,String acctClassification)
    {
        Account acc = new Account();
        String recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        //acc.Name='TestAccount1';
        acc.Name=accountName;
        //acc.GE_HQ_DUNS_Number__c='GEGUL9999';
        acc.GE_HQ_DUNS_Number__c=dunsNumber;
        //acc.Account_Tier_GEOG__c ='Country';
        acc.Account_Tier_GEOG__c =accTier;
        acc.RecordTypeId=recordTypeName;
        //acc.Type = 'Direct Customer';
        acc.Type =accType;
        //acc.Classification__c = 'Strategic';
        acc.Classification__c = acctClassification;
        
        insert acc;
        return acc;
        }
    
    //method to create account with Duns,parentDuns and Address Information

 public static account createRelationshipAccount (string accName,String accountCity,String province,String zipPostalcode,String parentDuns,String dunsNumber) {

     Account Accct=new Account();
     Accct.Name='CUSTOMERLINX OF';
     Accct.GE_HQ_New_Account_City__c='AB7hhS';
     Accct.GE_PW_State_Province_Bill_To__c='Texaslp';
     Accct.GE_HQ_New_Account_Zip_Postal_Code__c='3353687';
     Accct.Parent_Duns__c='535366777';
     Accct.GE_HQ_DUNS_Number__c='535366777';
     Insert Accct;
     return Accct;

}

    
    
    //method to create account with Duns,parentDuns and Address Information
    
    
   /* public static account createRelationshipAccount (string accName,String accTier,String accCountry,String classification,String billingCntry,String shippingCntry,String dunsNumber,String primaryIndustry,String shippingState,String shippingCity,String shipppingStreet,String postalcode) {
        account Acc1 = new account();
        Acc1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        Acc1.Name = accname;
        Acc1.Account_Tier_GEOG__c = 'Country';
        Acc1.Country_GEOG__c = 'USA';
        Acc1.Classification__c= 'Strategic';
        Acc1.BillingCountry = 'USA';
        Acc1.ShippingCountry = 'USA';
        Acc1.GE_HQ_DUNS_Number__c='555126948';
        Acc1.GE_ES_Primary_Industry__c = 'Industrial';
        Acc1.ShippingState = 'AT';
        Acc1.ShippingCity = 'TestShipping City';
        Acc1.ShippingStreet = 'Test Shipping Street';
        Acc1.ShippingPostalCode = '101010';
        Insert Acc1;
        return Accct;

}
*/
    
    
    
    //Method to Create Account with Billing and Shipping Information:
    
    
     public static Account  createAccount(String name,String ShippingPostalCode)
    {

        Account Acc = new Account();
        Acc.Name = name;
        Acc.BillingCountry = 'USA';
        Acc.ShippingCountry = 'USA';
        Acc.ShippingState = 'AT';
        Acc.ShippingCity = 'TestShipping City';
        Acc.ShippingStreet = 'Test Shipping Street';
        Acc.ShippingPostalCode = '101010';
        
        insert Acc;
        return Acc;
    } 
    
    
    
    /* Method to create new account */
    public static account createAccount(string accName) {
        account acc = new account();
        acc.name = accname;
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.ShippingCountry = 'India';
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Classification__c= 'Strategic';
        acc.type='Direct Customer';
        acc.Region_GEOG__c = 'India';
        insert acc;
        return acc;
    }
    
    

    /* Method to create new account */
    public static account createInternalLegalEntity(string accName) {
        account acc = new account();
        acc.name = accname;
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        acc.ShippingCountry = 'India';
        acc.Account_Tier_GEOG__c = 'LE';
         acc.Type ='GE Internal';
        insert acc;
        return acc;
    }
    
    
    
    
    /* Method to create new Relationship account,Account_Tier_GEOG__c--country */
    public static account createRelationshipAccount (string accName) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c ='Industrial';
        acc.Country_GEOG__c = 'India';
        insert acc;
        return acc;
    }
    
    //Method to create Account with Duns number
     public static account createRelationshipAccount (string accName,String dunsNumber) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.GE_HQ_DUNS_Number__c=dunsNumber;
        acc.Type = 'Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';  
        acc.GE_ES_Primary_Industry__c = 'Industrial';
        acc.Country_GEOG__c = 'India';
        insert acc;
        return acc;
    }
    
    
    
    //Method to create Global Account with Duns number
     public static account createGlobalRelationshipAccount (string accName,String dunsNumber) {
       
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();    
        acc.Name='TestAccount1';
        acc.GE_HQ_DUNS_Number__c='GEGUL9999';
        //acc.RecordTypeId=recordTypeName;
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Classification__c= 'Strategic';
        acc.type='Direct Customer';
        insert acc;
        return acc;
    }
    /* Method to create new Relationship account */
    public static account createLegalEntityAccount1(string accName, ID accID,String acctType) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'LE';
        acc.Oil_Gas_Parent_Account__c = accID;
        
        Account accGlobal= AccountTestDataFactory.createAccount('TestAccount Global');    
        acc.Member_of_GE_OG__c = accGlobal.Id;//
        
        
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        //acc.Type = 'Competitor';
        acc.Type = acctType;
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        insert acc;
        return acc;
    }
     /* Method to create new Relationship Legal Entity account */
    public static account createLegalEntityAccount(string accName, ID glbalAcctId,Id cntryAcctIdId,Boolean finLock,Boolean compLock,String leAcctType) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'LE';
        
       
        acc.Member_of_GE_OG__c = glbalAcctId;
        acc.Oil_Gas_Parent_Account__c = cntryAcctIdId;
        
        acc.Finance_Lock_GEOG__c = finLock ;
       acc.Compliance_Lock_GEOG__c = compLock;
        
        acc.Country_GEOG__c = 'INDIA';
        acc.Type = leAcctType;
        acc.Classification__c= 'Strategic';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        insert acc;
        return acc;
    }
    
    /* Method to create new Legal account */
    public static account createLegalEntityAccountWithMember(string accName, ID accID, ID memberID) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'LE';
        acc.Oil_Gas_Parent_Account__c = accID;
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        acc.Member_of_GE_OG__c = memberID;
        insert acc;
        return acc;
    }
    
     /* Method to create new Commercial Parent account */
    public static account createCommercialParentAccount (string accName) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        insert acc;
        return acc;
    }
    
    /* Method to create new Commercial Parent account */
    /* Modified by Mohit - Comment Type as Competitor */
    public static account createCommercialParentAccountWithMember (string accName, ID accID) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.Member_of_GE_OG__c = accID;
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Industrial';
        insert acc;
        return acc;
    }
    
    /*Method to create Contract
    
    
    
    public static Contract createContract(String contractName,Id AcctId)
    {
    
    
        Contract c = new Contract(); 
         c.Name =contractName;
         c.AccountId = Cacc.Id;
         c.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
         c.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
         c.GE_HQ_Buss_Tier1__c = 'PII';
         c.GE_HQ_Buss_Tier2__c = 'Reuter Stokes';
         c.GE_OG_Legal_Entity__c = 'ALGESCO SPA';
         c.StartDate =  Date.Today();
         c.GE_OG_Contract_End_Date__c = Date.Today() +8 ;
         c.Status  =  'Generate Draft'; 
         c.GE_OG_FA_Type__c = 'Discount';
         c.GE_PRM_Commercial_Account__c = null;
         c.recordtypeid= Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();      
         insert c;
         return c;
    }
    
    */
    
    /* Method to create new opportunity */
    public static opportunity createOppty(string oppName, id accountId){
    
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();

        
        opportunity opp = new opportunity();
        opp.name= oppName;
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = accountId;
        opp.tier_2_ge_og__c ='Digital Solutions';
        opp.tier_3_ge_og__c ='Bently Nevada';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =1000.00;
        opp.install_country_ge_og__c= 'India';       
        insert opp;
        return opp;
    }
    
  //Method to Create Note Object
  
  
  public static Note createNote(String title,id parentid)
  {
      
      
      Note nott=new Note();     
    nott.Title='Unit Test Attachment';
    nott.parentId = parentid;
    insert nott;
    return nott;
      
  }
  
  //Method to create Attachment object
  public static Attachment createAttachment(String attachName,id parentId)
  {
      Attachment attach=new Attachment();     
    attach.Name='Unit Test Attachment';
    Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    attach.body=bodyBlob;
    attach.parentId = parentId;
    insert attach;
    return attach;
      
  }
  
    //Method to create contacts:
    
     public static contact createContact(ID  acctId,String fname,String Lname ) {
        
       
    //static Integer count =1;
       Contact objContact = new Contact();
        objContact.GE_OG_Contact_Audience__c='Customer Care';
        objContact.FirstName=fname;
        objContact.LastName=Lname;
        objContact.Salutation='Mr.';
        objContact.Email='blabla'+count+'@ge.com';
        objContact.Phone='111111111';
        objContact.Fax='1212121212';
        objContact.GE_ES_I_Agree_flag__c = TRUE;
        objContact.AccountId= acctId;
        count++;
        insert objContact;
         return objContact;
    
    
     }
     
     /*
     Method to create primary contacts
     */
      public static contact createPrimaryContact(ID  acctId,String fname,String Lname,Boolean isPrimaryContact ) {
        
       
    //static Integer count =1;
       Contact objContact = new Contact();
       objContact.GE_OG_Contact_Audience__c='Customer Care'; 
        objContact.FirstName=fname;
        objContact.LastName=Lname;
        objContact.Salutation='Mr.';
        objContact.Email='blabla'+count+'@ge.com';
        objContact.Phone='111111111';
        objContact.Fax='1212121212';
        objContact.GE_ES_I_Agree_flag__c = isPrimaryContact;
        objContact.AccountId= acctId;
        count++;
        insert objContact;
         return objContact;
    
    
     }
     //creating account contact relation object
     
      public static AccountContactRelation createAccountContactRelation(Account acct,Contact con,Boolean primConatct) 
      
      {
    
       AccountContactRelation acctrelobj = new AccountContactRelation();
        acctrelobj.AccountId =acct.id;
        acctrelobj.ContactId =con.id;
        acctrelobj.IsActive=True;
        acctrelobj.GE_OG_Primary_Contact__c =false;
        
     
        
        insert acctrelobj;
       return acctrelobj;
    
    
     }
     
     
     
     
     
    //Method for creating Regional Account
    
     public static Account createRegionalAccount(Id acctId,String acctName,String acctType) {
    
    account accRegional = new account();
    accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accRegional.name = acctName;
    accRegional.Account_Tier_GEOG__c = 'Regional';
    accRegional.Country_GEOG__c = 'INDIA';
    accRegional.Classification__c= 'Strategic';
    //accRegional.Type = 'Competitor';
    accRegional.Type = acctType;
    accRegional.ShippingCountry = 'India';
    accRegional.Member_of_GE_OG__c = acctId;
    accRegional.ParentId = acctId;
    insert accRegional;
    
    return accRegional;
    
     }
     
     /*Method for creating Regional Account by passing the following fields
     GE_HQ_New_Account_Country__c 
     
     
     */
    
     public static Account createRegionalAccountWithDunsNum(String acctName,String classification,String acctType,String dunsNumber) {
    
    account accRegional = new account();
    accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accRegional.name = acctName;
    accRegional.Account_Tier_GEOG__c = 'Regional';
    accRegional.GE_HQ_DUNS_Number__c=dunsNumber+count;
    accRegional.GE_HQ_New_Account_Country__c = 'AUSTRALIA';
    //accRegional.Country_GEOG__c = 'INDIA';
    //accRegional.Classification__c= 'Strategic';
    accRegional.Classification__c= classification;
    //accRegional.Type = 'Competitor';
    accRegional.Type = acctType;
    //accRegional.Member_of_GE_OG__c = acctId;
    //accRegional.ParentId = acctId;
    count++;
    insert accRegional;
    
    return accRegional;
    
    
    
    
        
    
     }
     
    //create a new regional account with Duns number and  Member_of_GE_OG__c
      public static Account createCountryLevelAccountWithDunNum(Account acctName,String classification,String acctType,String dunsNumber) {
    
    account accRegional = new account();
    accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accRegional.name = acctName.name;
    accRegional.Account_Tier_GEOG__c = 'Country';
    accRegional.GE_HQ_DUNS_Number__c=dunsNumber+count;
    //accRegional.GE_HQ_New_Account_Country__c = 'AUSTRALIA';
     accRegional.Classification__c= classification;
    accRegional.Type = 'Direct Customer';
    //accRegional.Type = acctType;
    accRegional.Member_of_GE_OG__c = acctName.id;
    //accRegional.ParentId = acctId;
    count++;
    insert accRegional;
    
    return accRegional;
    
    
    
    
        
    
     }
     
     
     
     /*Method for creating Regional Account
    
     public static Account createRegionalAccount(Id acctId,String acctName,String acctType) {
    
    account accRegional = new account();
    accRegional.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accRegional.name = acctName;
    accRegional.Account_Tier_GEOG__c = 'Regional';
    accRegional.Country_GEOG__c = 'INDIA';
    accRegional.Classification__c= 'Strategic';
    //accRegional.Type = 'Competitor';
    accRegional.Type = acctType;
    accRegional.ShippingCountry = 'India';
    accRegional.Member_of_GE_OG__c = acctId;
    accRegional.ParentId = acctId;
    insert accRegional;
    
    return accRegional;
    
     }
     
     */
     //Method for creating  Country Account
     
      public static Account createCountryaccount(id globalAcctId,id accRegional,String acctName,Boolean compReady,
     Boolean financeLockGEOGc,String ctryAcctType) {
    
     
    
    account accCountry = new account();
    accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
    accCountry.name = acctName;
    accCountry.Account_Tier_GEOG__c = 'Country';
    accCountry.Country_GEOG__c = 'INDIA';
    accCountry.Classification__c= 'Strategic';
    //accCountry.Type = 'Competitor';
    accCountry.Type =ctryAcctType;
    accCountry.ShippingCountry = 'India';
    accCountry.Member_of_GE_OG__c = globalAcctId;
    accCountry.ParentId = accRegional;
    accCountry.Finance_Lock_GEOG__c = financeLockGEOGc;
    accCountry.Compliance_Ready__c  =  compReady;
    insert accCountry;
     return accCountry ;
     
     
      }
      
      
      
      
      /*Method for creating Account acnt.Strength__c = 'Low','Medium','High';
      Call this method by passing different values for Strength__c field to
      create accounts with low,medium and high 
      
      */
      public static Account createAcctWithStrength( String accName,String acctStrength)
      {
          
          
           Account acnt = new Account();
           acnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
         acnt.Name='Customer value perception';
         acnt.Type = 'EPC';
         acnt.Classification__c = 'Strategic';
         acnt.Strength__c = acctStrength;
         acnt.GE_ES_Primary_Industry__c = 'Industrial';
         insert acnt;
         return acnt;
         
      }
      
         
      /*Method for creating Account acnt.Strength__c = 'Low','Medium','High';
      Call this method by passing different values for Strength__c field to
      create accounts with low,medium and high - with compliance ready flag
      
      */
           public static Account createAcctWithStrength( String accName,String acctStrength,Boolean isCompReady)
      {
          
          
           Account acnt = new Account();
           acnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
         acnt.Name=accName;
         acnt.Type = 'EPC';
         acnt.Classification__c = 'Strategic';
         acnt.Strength__c = acctStrength;
         acnt.GE_ES_Primary_Industry__c = 'Industrial';
         acnt.Compliance_Ready__c = True;
         insert acnt;
         return acnt;
         
      }

      //Method for creating ContactAccountSharing__c 
      public static ContactAccountSharing__c createcontactAccountSharing(ID accID,ID contId,Boolean primaryContact)
      {
          
           ContactAccountSharing__c conshar = new ContactAccountSharing__c ();
         conshar.Primary_Contact_GE_OG__c = primaryContact;
         conshar.Account_GEOG__c = accID;
         conshar.Contact_GEOG__c = contId;
         insert conshar;
         return conshar;
      }
      
      /*Method for creating AccountTeamMember,call this method by passing accountid and teammemberrole
      teammemberrole-can be Sales - Primary etc
      */
      
      public static AccountTeamMember createAccountTeamMember(ID accID,String teammemberrole)
      {
       AccountTeamMember atm = new AccountTeamMember();
        atm.AccountId = accID;
        atm.userid = UserInfo.getUserId();
        atm.TeamMemberRole = teammemberrole;
        insert atm;
        return atm;
        
      }
      
      //Create CMF Approved Account,call this method by passing regional account id:
      
      public static  Account accountCMFApproved(Id acctId)
      {
        account Cacc = new account();
        Cacc.name = 'Test2';
        Cacc.Account_Tier_GEOG__c='LE';
        Cacc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        Cacc.ShippingCountry = 'India';
        //Cacc.Account_Tier_GEOG__c = 'Global';
        Cacc.Oil_Gas_Parent_Account__c = acctId; 
        insert Cacc;
        return Cacc;
          
      }
      
       /* Method to create Custom Settinng */
    public static void createStaticCountryRegionMappingData(){
        Country_Region_Mapping_ge_og__c objcountryregmap = new Country_Region_Mapping_ge_og__c();
        objcountryregmap.Name = '2';
        objcountryregmap.country_name_ge_og__c = 'India';
        objcountryregmap.iso_code_ge_og__c = 'IN';
        objcountryregmap.region_ge_og__c = 'India';
        objcountryregmap.status_ge_og__c = 'Active';
        insert objcountryregmap;
    }
    
    public static Country_Region_Mapping_ge_og__c createCountryRegionMappingData(String name, String countryName, String isoCode, String region, String status){
        Country_Region_Mapping_ge_og__c objcountryregmap = new Country_Region_Mapping_ge_og__c();
        objcountryregmap.Name = name;
        objcountryregmap.country_name_ge_og__c = countryName;
        objcountryregmap.iso_code_ge_og__c = isoCode;
        objcountryregmap.region_ge_og__c = region;
        objcountryregmap.status_ge_og__c = status;
        //insert objcountryregmap;
        return objcountryregmap;
    }
      
      
    //create task with whatID  
    public static Task createTask(id Whatid,String status,String subject) 
    {
    Task t = new Task();
        //t.Status = 'Completed';
        t.Status = status;
        //  t.WhatId = acnt.Id; 
        t.WhatId = WhatId; 
        //t.Subject= 'Run Test Trigger';
        t.Subject= subject;
        t.ActivityDate= Date.today();
        insert t;   
        return t;   
    }
        
         public static Task createTaskWithWhoId(id acntid,String status,String subject,id conid) 
    {
    Task t = new Task();
        //t.Status = 'Completed';
        t.Status = status;
        //  tsk.WhoId= con.Id; 
         t.WhatId = acntid; 
        t.WhoId = conid; 
        //t.Subject= 'Run Test Trigger';
        t.Subject= subject;
        t.ActivityDate= Date.today();
        insert t;   
        return t;
    }
      
      /*
      Methods to create custom setting:
      
      GE_Account_Prepopulate_OG__c*/
      
       
       public static void createAccountPrepoulateDataData()
       
       {
    GE_Account_Prepopulate_OG__c cs = new GE_Account_Prepopulate_OG__c();
    cs.Name ='Test1';
    cs.Region_GEOG__c ='Sub-saharan';
    cs.Type__c ='Direct Customer';
    cs.Classification__c ='Key Account';
    cs.Country_GEOG__c ='EQUATORIAL GUINEA';
    cs.Member_of_GE_OG__c ='MARATHON OIL / HQ';
    cs.Oil_Gas_Parent_Account__c ='MARATHON OIL / EQUATORIAL GUINEA';
    cs.Account_Tier_GEOG__c ='LE';
    insert cs;
    }
     

//Creating an HQ Account:

public static Account createHQAccnt(String accName)
{
    
     
           
    
    Account oGAct = new Account();
    oGAct.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId(); 
    
    oGAct.Name=accName;
    oGAct.Phone='8963217452';
    //oGAct.RecordTypeId=recordTypeName;
    oGAct.GE_HQ_Site_Use_Code__c= 'Country';
    oGAct.GE_HQ_New_Account_Street__c ='test';
    oGAct.GE_HQ_New_Account_City__c ='test';
    oGAct.GE_HQ_New_Account_State_Province__c = 'test';
    oGAct.GE_HQ_New_Account_Zip_Postal_Code__c ='201301';
    oGAct.GE_HQ_New_Account_Country__c ='India';
    oGAct.Type = 'Direct Customer';
    oGAct.Classification__c = 'Strategic';
    insert oGAct;
    return oGAct;
}



// Account planning test data factory  - begin 


 Public static Account GlobalAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global / HQ','Customer');
 public static Contact con =AccountTestDataFactory.createContact(GlobalAcc.id ,'Test','contact');
    public static Account_Planning__c createAccountPlanning(string year , string Status) 
    {
       // Account GlobalAcc=AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global / HQ','Customer');
        Account_Planning__c ap = new Account_Planning__c();
        ap.Account_Name_GEOG__c = GlobalAcc.id;
        ap.Year_GEOG__c =year;
        ap.Plan_Target_Geog__c= 1000;
        ap.Status_GEOG__c = Status;
        
        insert ap;
        
        return ap;
    }
   
    public static Key_Customer_Contacts__c createKCC(id acp)
    {
        Key_Customer_Contacts__c kc= new Key_Customer_Contacts__c();
        kc.Contact__c=con.id;
        kc.Account_Planning__c=acp;
        system.debug('account plan id is --'+kc);

        
        insert kc;
        return kc;
    }
    
    
     public static Customer_Strategy_Map_item__c createCSMI(id acp1)
    {
        
        Id csm_recordtype_id = Schema.SObjectType.Customer_Strategy_Map_item__c.getRecordTypeInfosByName().get('Customer\'s Initiatives').getRecordTypeId();
        Customer_Strategy_Map_item__c csm = new Customer_Strategy_Map_item__c();
        csm.RecordTypeId=csm_recordtype_id;
        csm.Account_Planning__c =acp1;
        csm.Status__c= 'Active';
        csm.Title__c = 'test title';
        insert csm;
        return csm;
    }
    
     public static Customer_Strategy_Map_Contacts__c createCSMI_contact(id csm_id)
    {
        
        Customer_Strategy_Map_Contacts__c csm_contact = new Customer_Strategy_Map_Contacts__c();
        csm_contact.Customer_Strategy_Map_item__c = csm_id;
        csm_contact.Contact__c =con.id;
        insert csm_contact;
        return csm_contact;
    }
      public static Customer_Strategy_Map_Users__c createCSMI_user(id csm_id1)
    {
        
        Customer_Strategy_Map_Users__c csm_user = new Customer_Strategy_Map_Users__c();
        csm_user.Customer_Strategy_Map_item__c =csm_id1;
        csm_user.Strategy_Map_User__c =UserInfo.getUserId() ;
        insert csm_user;
        return csm_user;
    }
    public static Key_Project_ge_og__c  createKeyProject(id acp2)
    {
    Project_ge_og__c  proj = new Project_ge_og__c ();
        proj.Name ='Test Project';
        proj.Project_Stage_ge_og__c = 'Awarded';
        proj.Status_ge_og__c='Not Started';
        proj.Project_Summary_ge_og__c ='scope of this project is for testing';
        proj.project_account_ge_og__c=GlobalAcc.id;
        proj.GE_ES_Tier_2_P_L__c ='Digital Solutions';
        
        insert proj;
        
        
        Key_Project_ge_og__c keypro = new Key_Project_ge_og__c();
        keypro.Project_ge_og__c = proj.id;
        keypro.Account_Plan_ge_og__c = acp2;
        
        insert  keypro;
        return  keypro;
    }
     public static Key_Asset_ge_og__c createKeyAsset(id acp3)
     {
        //Asset ast = [select id from Asset limit 1];
        //system.debug('asset is'+ast);
        Key_Asset_ge_og__c kast = new Key_Asset_ge_og__c();
        kast.Account_Planning_ge_og__c = acp3;
       // kast.Asset_ge_og__c = ast.id ;
        
        Insert kast;
        system.debug(' instered test asset is'+kast);

        return kast;
     }
     
   
// Account planning test data factory  - end

     
      
}