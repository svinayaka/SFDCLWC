/*
Type Name [Class/Trigger/Page Name] : Class - GE_MCS_AttactContactCtrl
Purpose                             : Attaching single contact out of the Possible contacts with same email address
Functional Area                     : Serice 
Author                              : Ashish Shishodiya 
Created Date                        : 11 Feb 2013
Test Class                          : GE_MCS_AttactContactCtrl
*/


public with sharing class GE_MCS_AttactContactCtrl {

public Id caseId{get;set;}
public case cs{get;set;}
public Id contactId{get;set;}
public Id accountId{get;set;}
public String contactEmail{get;set;}
public List<Contact> lstContact{get;set;}
public string radioOption{get;set;}
public Id contactIdNew{get;set;}
public Id accountIdNew{get;set;}
public Boolean refreshPage {get; set;}
public Boolean refresh{get;set;}
PageReference pg;
Public Boolean displayTable{get;set;}
Public Boolean hidden{get;set;}
Public Boolean displayMessage{get;set;}
public String currentUrl{get;set;}
public String redUrl{get;set;}
public String contactURL{get;set;}
public String accountURL{get;set;}
public List<WrapContacts> lstWrapContact{get;set;}
public boolean isErrored{get;set;}
List<Case> cs1= new List<Case>();

ApexPages.StandardController controller{get;set;}
    public GE_MCS_AttactContactCtrl(ApexPages.StandardController controller) {
    isErrored = false ;
   refreshPage = false;
   displayTable = false;
   displayMessage = false;
   refresh = false ;
   contactURL = '';
   accountURL = '';
   contactEmail = '';
   currentUrl = '';   
   redUrl = '';
   hidden=true;
  currentUrl = Apexpages.currentpage().getparameters().get('host');

  caseId= Apexpages.currentpage().getparameters().get('id');

  cs=[Select c.Contact.Email, c.ContactId,c.contact.accountid,c.account.GE_HQ_DUNS_Number__c,c.SuppliedEmail,GE_ES_Sub_Type__c From Case c where id =:caseId Limit 1];
   //List<Case> cs1= new List<Case>();
   
   contactId = cs.contactId;
   accountId = cs.contact.accountId;
   if(cs.SuppliedEmail != '' && cs.SuppliedEmail != null){
   displayTable = true;
   contactEmail = cs.SuppliedEmail ;
    if(contactEmail != null && contactEmail != '' ){
   lstContact = [Select c.Name, c.MailingCountry, c.MailingState,c.MailingCity, c.Email,c.GE_HQ_CONTACT_STATUS__c,c.account.GE_HQ_DUNS_Number__c,id ,c.Account.Name,c.account.ShippingStreet,c.account.ShippingCity, c.account.ShippingState,c.account.ShippingPostalCode,c.account.ShippingCountry, c.AccountId From Contact c where email =: contactEmail] ;
    if(lstContact.size()>0){
    lstWrapContact = new List<WrapContacts>();
    for(contact c :lstContact){
    WrapContacts wrpCon = new WrapContacts(c.Name,c.Email,c.Account.Name,c.account.GE_HQ_DUNS_Number__c,c.MailingCity,c.MailingState,c.MailingCountry,c.id,c.accountid,(c.id == contactId && c.accountid == accountId)?'Linked':'',c.account.ShippingStreet+','+c.account.ShippingCity+','+c.account.ShippingState+','+c.account.ShippingPostalCode+','+c.account.ShippingCountry,c.GE_HQ_CONTACT_STATUS__c);
    lstWrapContact.add(wrpCon);
    }
    } else {
    displayMessage = true;
     displayTable = false;

    }
    }
     }else{
    displayMessage = true;
    }
    this.controller = controller;
    }
  public PageReference Attach(){
      isErrored  = false ;
  ApexPages.Message msg;
accountIdNew = [select accountid from contact where id=:contactIdNew].accountid;
cs.contactId = contactIdNew ;
cs.accountId = accountIdNew ;
try
{
update cs ;
}catch(DMLException e)
{
System.debug('catched exception-----------');
//cs.GE_ES_Sub_Type__c.addError('error---------------');
 isErrored = true ;
//ApexPages.Message MyMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Subtype is Mandatory---------');
//ApexPages.addMessage(MyMsg);
 // hidden=true;       
 return null;                
}
        
refreshPage = true;
refresh = true ;


//return controller.save();
return null;

}

public Class WrapContacts{
public String status{get;set;}
public String name{get;set;}
public String email{get;set;}
public String accountName{get;set;}
public String DUNS{get;set;}
public String city{get;set;}
public String state{get;set;}
public String country{get;set;}
public String contactId{get;set;}
public String accountId{get;set;}
public String accountAddress{get;set;}
public String contactStatus{get;set;}


public WrapContacts(String name,String email,String accountName,String DUNS,String city,String state,String country,String contactId,String accountId,String status,String accountAddress,String contactStatus){
this.name = name; 
this.email = email;
this.accountName = accountName ; 
this.DUNS = DUNS ; 
this.city = city ;
this.state = state;
this.country = country;
this.contactId = contactId;
this.accountId = accountId;
this.status = status;
this.accountAddress = accountAddress;
this.contactStatus = contactStatus;
}

}
}