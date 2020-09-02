/*
================================================================
Type Name   : AccountRelatedListMigration 
Author      : Chetan
Created Date: 29/07/2010
Reason      : This class is used for Account RelatedList Migration and would be used as a controller extension  
              for Initiate Migration VF page.
================================================================
*/

public without sharing class AccountRelatedListMigration 
    {
        public string strAccID;
        public list<Account> arrAcc{get;set;}
        public list<Account> strAccName{get;set;}
        public list<Account> strProposedDUNS{get;set;}
        public list<Account> arrAccDUNSInfo{get;set;}    
        public list<Account> arrAccMig{get;set;}
        public list<Opportunity> oppIDAcc{get;set;}
        public list<Opportunity> oppId  {get;set;}  
        public list<Contact> contRecord{get;set;}             
        public list<Contact> contactId {get;set;}
       
                      
     public AccountRelatedListMigration(ApexPages.StandardController controller)
     { 
        //Fetching the Current Account Record ID
        strAccID=ApexPages.currentPage().getParameters().get('id');
        
        //Fetching the corresponding Account Name  
        string strAccName=[select id, name from Account where id =:strAccID].name;
        
        //Fetching the Proposed DUNS number for current acount
        string strProposedDUNS=[select id,name,GE_HQ_Proposed_DUNS__c from Account where id=:strAccID].GE_HQ_Proposed_DUNS__c;   
        
        //Fetching Current Account details
       arrAccMig=[select id,  
        name,
        GE_HQ_Proposed_DUNS__c,
        GE_HQ_New_Account_Street__c,
        GE_HQ_New_Account_City__c,
        GE_HQ_New_Account_Zip_Postal_Code__c,
        GE_HQ_New_Account_State_Province__c, 
        GE_HQ_Request_Status__c,
        GE_HQ_New_Account_Country__c,
        Phone 
        from account 
        where id =:strAccID];               
        
        /*Records in Account Object whose DUNS Number matches Peroposed DUNS provided 
        in account object and Request Status ='CMF APPROVED'*/
        arrAccDUNSInfo=[select id,
        name,
        GE_HQ_Request_Status__c,
        GE_HQ_DUNS_Number__c,
        GE_HQ_New_Account_Street__c, 
        GE_HQ_New_Account_City__c,
        GE_HQ_New_Account_Zip_Postal_Code__c,
        GE_HQ_New_Account_State_Province__c,
        GE_HQ_New_Account_Country__c,
        ShippingStreet,
        ShippingCity,
        ShippingCountry,
        ShippingPostalCode,
        ShippingState,
        Phone
        from Account 
        where GE_HQ_DUNS_Number__c=:strProposedDUNS and GE_HQ_Request_Status__c='CMF APPROVED'];
        
           
        //Fetching related Opportunities of this Account 
        oppIDAcc=[select id,name from Opportunity where Account.id=:strAccID];
        
        //Fetching related Contacts of this Account
        contRecord=[select Name from Contact where Account.id=:strAccID];
              
     }
        
        //Method to Migrate Account Related List        
        public PageReference Migrate()
        {
           PageReference RedirecttoAcc;
                   
           if(arrAccDUNSInfo.isEmpty() == true)
           {
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Cannot Continue with Migration as there are no Similar Account Records with Proposed DUNS Number. Click Cancel Request to go to Previous Page.');
           ApexPages.addmessage(myMsg);
           }
                  
        try {
        merge arrAccDUNSInfo[0] arrAccMig; //Standard merge functionality
        
       RedirecttoAcc = new PageReference('/'+arrAccDUNSInfo[0].Id);
        return RedirecttoAcc;
       
             }
     
      catch(Exception e)
      {
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, e.getMessage());
      //ApexPages.addmessage(myMsg);
        return RedirecttoAcc;
      }
    }
    
        
    //Method to Cancel Migration Process
    public PageReference CancelMigration()
        {    
            PageReference RedirecttoAcc = new PageReference('/'+strAccID); 
            return RedirecttoAcc ;
        }  
        
 }