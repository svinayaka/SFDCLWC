/*    
Class Name        : AccountSearchController
Purpose/Overview  : This class is used as the controller extension for AccountSearch VF page to search Account records with specific search criteria.
Author            : Chetan Vaidya
Created Date      : 29th July 2010
Test Class        : Test_AccountSearchController
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 29th July 2010: Chetan Vaidya      : Class Created : Created the class to search Accounts
                  : 08th Sep 2011 : Jayadev Rath       : Class Updated : To Increase the Coverage of the class without any change of the functionality
                  : 28th Feb 2012 : Lakshman Bugude    : Class Updated : Bug 9051, Limiting the query to 1000 Records.
                  : 19th Apr 2016 : venkatesh Boyina : R-24555 : Commented total code inorder to delete.
*/
public without sharing class AccountSearchController {
    public AccountSearchController() {}
    /*
    private string strAccID;
    private string strAccName{get;set;}
    public list<Account> arrAcc{get;set;}
    //Added    public list<Account> accTemp{get;set;}     //Added
    //private Integer i;
    public list<Account> arrCurrentAcc{get;set;}
    public list<Account_Request__c> arrAccRequest{get;set;}
    public AccountIntegrationWrapper NewAccReq; 
    public Account str = new Account();
    public boolean FromTest = false;
    
    public AccountSearchController(ApexPages.StandardController controller) {
        //Fetching the Current Record ID
        strAccID=ApexPages.currentPage().getParameters().get('id');
        FromTest=False;
        //Fetching the Current Account Record
        arrCurrentAcc=[select id, name, GE_HQ_Site_Use_Code__c, GE_HQ_New_Account_City__c, GE_HQ_New_Account_Street__c, GE_HQ_New_Account_State_Province__c, GE_HQ_New_Account_Zip_Postal_Code__c, GE_HQ_New_Account_Country__c, Phone from Account where id =:strAccID];
        
        //Fetching the corresponding Account Name  
        strAccName=[select id, name from Account where id =:strAccID].name;
        // accTemp=[select id,name from Account limit 1000];     
        
        //Fetching all the Account records whose id is not equal to the current Record id with Request Status as 'CMF Approved' or 'New' or 'Pending User Review' or 'Pending CMF' and name like current Account record name in descending order.
        
        // Lakshman - Changes made for Bug 9051
        
        arrAcc=[select Id ,Name, GE_HQ_New_Account_Street__c,  GE_HQ_New_Account_City__c, GE_HQ_New_Account_Zip_Postal_Code__c, GE_HQ_New_Account_State_Province__c, GE_HQ_New_Account_Country__c, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, GE_HQ_Request_Status__c, GE_HQ_DUNS_Number__c from account where id!=:strAccID and (GE_HQ_Request_Status__c='CMF Approved' OR GE_HQ_Request_Status__c='New' OR GE_HQ_Request_Status__c='Pending User Review' OR GE_HQ_Request_Status__c='Pending CMF' ) and name like :'%'+strAccName+'%' ORDER BY GE_HQ_Request_Status__c DESC LIMIT 1000];

        //Fetching all the Account records whose id is not equal to the current Record id with Request Status 'Pending User Review' or 'Pending CMF' and name like current Account record name. 
        
        arrAccRequest=[Select Id, Name, GE_HQ_Account_Name__C, GE_HQ_DUNS_Number__c, GE_HQ_Street__c,GE_HQ_City__c, GE_HQ_Postal_Code__c, GE_HQ_State_Province__c, GE_HQ_Country__c, GE_HQ_Request_Status__c  from Account_Request__c where id!=:strAccID and (GE_HQ_Request_Status__c='Pending User Review' OR GE_HQ_Request_Status__c='Pending CMF') and GE_HQ_Account_Name__C like :'%'+strAccName+'%'];
        
        NewAccReq = new AccountIntegrationWrapper();
        
       
    }

    // Method to bring user back to the Accounts detail page
    public PageReference Cancel() {
        PageReference RedirecttoAcc = new PageReference('/'+strAccID); 
        return RedirecttoAcc ;
    }

    // Method to Delete an Account if it has no related Opportunities and Contacts
    public PageReference DeleteRec() {
        Account strAccReq = [Select Id, Opportunity_Count__c,Number_of_Contacts__c from Account where id =:strAccID];
        If(strAccReq.Opportunity_Count__c != 0 || strAccReq.Number_of_Contacts__c != 0) {
            PageReference RedirecttoAcc ;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'You cannot Close this Record as it contains at least one open Opportunity or Contact.Please Delete or Migrate the Opportunity or Contact to another Account before closing the request. Click Go Back button to go to Previous Page');
            ApexPages.addmessage(myMsg);
            return RedirecttoAcc;
        }
        else {
            Delete strAccReq; 
        }  
        PageReference RedirecttoAcc = new PageReference('/001/o'); 
        return RedirecttoAcc;
    }
    
    //Method to submit the Account record to CMF.    
    public PageReference Submit() {
        PageReference RedirecttoAcc;
        Account strAccReq = new Account(id=strAccID);
        If(!FromTest) str = NewAccReq.NewAccountRequest(strAccReq);
      
       // Commented due to the changes in the Account InTegration Wrapper Class
        //str.GE_HQ_WebService_Response_Status__c = NewAccReq.wsdlstatus;
        //str.GE_HQ_Request_Status__c ='Submitted To CMF';
        //if(NewAccReq.wsdlstatus == 'SUCCESS') {
           // str.GE_HQ_CMF_Request_Status__c ='N';
       // }
       // else {
           // ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR, NewAccReq.wsdlstatus+':- '+NewAccReq.wsdldesc);
           // Apexpages.addMessage(mymsg);
          //  return RedirecttoAcc;
        //}
        update str;       
        RedirecttoAcc = new PageReference('/' + str.id);
        return RedirecttoAcc;
    }
    */
}