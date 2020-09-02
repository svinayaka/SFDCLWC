/*    
Class Name        : AccountRequestSearchController 
Purpose/Overview  : Keeping sync between diff systems through outbound call.
Author            : Chetan Vaidya
Test Class        : Test_AccountRequestSearchController 
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : Old Relaeses  : Chetan Vaidya      : Created : Created the class to handle outbound requests
                  : 8th Sep 2011  : Jayadev Rath       : Updated the class as per test class to increase coverage without any functionality change
                  : 25th May 2012 : Amit Kr. Singh     : Updated Submit() method for J-Release requirement.
                  : 21st May 2013 : Harsh Sharma       : Kyc phase 2 modification
*/
Public with sharing class AccountRequestSearchController {
    
    private string strAccReqID;
    //public string sub;
    Id AccId;
    public list<Account_Request__c> strAccName{get;set;}
    public list<Account_Request__c> DUNS{get;set;} 
    public list<Account> arrAccount{get;set;}
    public list<Account_Request__c> arrAccRequest{get;set;}
    public list<Account> strCurrentAcc{get;set;} 
    public list<Account_Request__c> AccOldRec{get;set;} 
    public AccountIntegrationWrapper ModifyAccReq;
    public Account_Request__c accReq;
    public Account_Request__c str = new Account_Request__c();
    public boolean FromTest=false;
    public boolean KYCRequired {get; set;}
    
    public AccountRequestSearchController(ApexPages.StandardController controller)
    {

        //Fetching the AccountID
        strAccReqID=ApexPages.currentPage().getParameters().get('id');
        FromTest=false; // Setting the varialble to false, to execute the outbound call
        System.debug('**************strAccReqID*******'+strAccReqID);
        //sub = strAccReqID.substring(0,3);
        
         AccId=[select id,GE_HQ_Account__c from Account_Request__c where id=:strAccReqID limit 1].GE_HQ_Account__c;
        //Fetching the Current Account Record
        strCurrentAcc=[select id, name,GE_HQ_Site_Use_Code__c,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,ShippingStreet,Phone,GE_HQ_DUNS_Number__c from Account where id =:AccId];
        System.debug('**************strCurrentAcc*******'+strCurrentAcc.size());
        
        //Fetching the similar Account names
        String strAccName=[select id, GE_HQ_Account_Name__c from Account_Request__c where id =:strAccReqID limit 1].GE_HQ_Account_Name__c;
        System.debug('**************strAccName*******'+strAccName);
        accReq=[select id,GE_HQ_Account__r.id, Shipping_Street_Up__c, GE_HQ_Street__c, Shipping_City_Up__c, GE_HQ_City__c, Shipping_State_Province_Up__c, GE_HQ_State_Province__c, Shipping_PostalCode_Up__c, GE_HQ_Postal_Code__c, Shipping_Country_Up__c, GE_HQ_Country__c, GE_PW_Modify_Requested_Account_Name__c, GE_HQ_Requested_Account_Name_Up__c, GE_HQ_Requested_Account_Name__c  from Account_Request__c where id=:strAccReqID];
        
        //Qerying the Account Object
        arrAccount=[select id ,name,GE_HQ_DUNS_Number__c,GE_HQ_New_Account_Street__c,GE_HQ_New_Account_City__c,GE_HQ_New_Account_State_Province__c,GE_HQ_New_Account_Zip_Postal_Code__c,GE_HQ_New_Account_Country__c,ShippingStreet,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,GE_HQ_Request_Status__c from account where name like :'%'+strAccName+'%' and GE_HQ_Request_Status__c='CMF Approved'];
        System.debug('**************arrAccount*******'+arrAccount);
        
        
        //Querying the Accountmodification Object
        
        String DUNS = [select id, name, GE_HQ_DUNS_Number__c  from Account_Request__C where id=:strAccReqID].GE_HQ_DUNS_Number__c;
        
        arrAccRequest=[select id, name, GE_HQ_Billing_City__c,GE_HQ_Billing_Country__c,GE_HQ_Billing_State_Province__c,GE_HQ_Billing_Street__c,GE_HQ_Billing_Zip_Postal_Code__c,GE_HQ_Account_Name__C, GE_HQ_DUNS_Number__c,GE_HQ_Street__c,GE_HQ_City__c,GE_HQ_Postal_Code__c,GE_HQ_State_Province__c,GE_HQ_Country__c,GE_HQ_Request_Status__c from Account_Request__c where id!=:strAccReqID and GE_HQ_DUNS_Number__c =:DUNS and (GE_HQ_Request_Status__c='Pending User Review' OR GE_HQ_Request_Status__c='Pending CMF') and GE_HQ_Account_Name__C like :'%'+strAccName + '%'];
        //To get the old record
        
        ModifyAccReq=new AccountIntegrationWrapper();
        AccOldRec=[select id, AccountName_Up__c,Shipping_City_Up__c,Shipping_Country_Up__c,Shipping_State_Province_Up__c,Shipping_Street_Up__c,Shipping_PostalCode_Up__c,Billing_City_Up__c,Billing_Country_Up__c,Billing_State_Province_Up__c,Billing_Street_Up__c,Billing_Zip_Postal_Code_Up__c,DUNS_Up__c from Account_Request__c where id =:strAccReqID];       
        System.debug('**************AccOldRec*******'+AccOldRec);
        
        validateAccModReqChanges();
        
        //controller.setPageSize(10);
    }
    
    Public PageReference Link1()  
    {
        PageReference RedirecttoAccLink = new PageReference('/'+strAccReqID); 
        return RedirecttoAccLink ;
    }
    public PageReference Link()
    {
        PageReference RedirecttoAcc = new PageReference('/'+ strAccReqID); 
        return RedirecttoAcc;  
    }
    public PageReference Cancel()
    {
        Account_Request__c strAccReq = new Account_Request__c();
        strAccReq = [select id from Account_Request__c where id =:strAccReqID];
        delete strAccReq ;
        PageReference RedirecttoAcc = new PageReference('/'+accReq.GE_HQ_Account__r.id); 
        return RedirecttoAcc;
    }
    
    public void InsertAccModNotes(){
    
     
  
        Account_Modification_Note__c arn1;
        Id AccId=[select id,GE_HQ_Account__c from Account_Request__c where id=:strAccReqID limit 1].GE_HQ_Account__c;
        System.debug('**********'+AccId);
        List <Account_Request__c> li= new List<Account_Request__c>([select id,GE_HQ_Nts_Comments__c from Account_Request__c where   GE_HQ_Account__c=:AccId and id=:strAccReqID ]);
        if(li.size()>0){
          
        
        for(Account_Request__c req: li){
                    arn1 = new Account_Modification_Note__c();
                    arn1.Account_Request__c=strAccReqID;
                    arn1.Type__c='User';
                    arn1.Comments__c=req.GE_HQ_Nts_Comments__c;
                    insert arn1;
            }
            }
                  
        } 
    
    public PageReference Submit()
    {
    
            
        PageReference RedirecttoAcc;
        Account_Request__c strAccReq = new Account_Request__c();
        //strAccReq=[select id,name,GE_HQ_Billing_Street__c,GE_HQ_City__c,GE_HQ_Country__c,GE_HQ_Postal_Code__c,GE_HQ_Account_Request_ID__c,GE_HQ_DUNS_Number__c,GE_HQ_Request_Type__c,GE_HQ_Site_Use_Code__c,GE_HQ_Billing_City__c,GE_HQ_Billing_Country__c,GE_HQ_Web_Request_Ref__c,GE_HQ_Billing_State_Province__c,GE_HQ_Billing_Zip_Postal_Code__c,GE_HQ_State_Province__c,GE_HQ_Street__c,GE_HQ_Phone__c,GE_HQ_Original_Web_Request_Id__c,GE_HQ_Documentation1__c,GE_HQ_Documentation2__c,GE_HQ_Documentation3__c,GE_HQ_Documentation4__c,GE_HQ_Legacy_System__c,GE_HQ_VAT_Registration__c,GE_HQ_Vat_Number__c,GE_HQ_VAT_Notes__c,GE_HQ_Account__c,GE_HQ_VAT_Group__c from Account_Request__c where id =:strAccReqID];            
        strAccReq=[select id,name from Account_Request__c where id =:strAccReqID];            
        String accmodreqobjid=String.valueof( strAccReq.id);
            If(!FromTest)AccountIntegrationWrapper.AccountModifyRequest(accmodreqobjid);
            InsertAccModNotes();
     
       // Commented due to the changes in the Account Integration Wrapper Classes 
       /* If(!FromTest) str = ModifyAccReq.AccountModifyRequest(strAccReq); // If the test class is calling this method then the outbound call is skipped.
        InsertAccModNotes();
        system.debug('*****************************************************************'+strAccReq);
       
       
        str.GE_HQ_WebService_Response_Status__c = ModifyAccReq.wsdlstatus;
        str.GE_HQ_Request_Status__c ='Submitted To CMF';
        system.debug('********************************************'+str.GE_HQ_Request_Status__c);
        If(ModifyAccReq.wsdlstatus == 'SUCCESS') {
            str.GE_HQ_CMF_Request_Status__c ='N';
        }
        else {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR, ModifyAccReq.wsdlstatus+':- '+ModifyAccReq.wsdldesc);
            Apexpages.addMessage(mymsg);
            return RedirecttoAcc;
        }  */    
        
        update str;  
        RedirecttoAcc = new PageReference('/'+str.id);
      
     
    
     
        return RedirecttoAcc;
    }
    
    public void validateAccModReqChanges(){
    
        KYCRequired = false;
        if(accReq.GE_HQ_State_Province__c != accReq.Shipping_State_Province_Up__c || accReq.GE_HQ_Country__c != accReq.Shipping_Country_Up__c || (accReq.GE_PW_Modify_Requested_Account_Name__c != true && accReq.GE_HQ_Requested_Account_Name__c != accReq.GE_HQ_Requested_Account_Name_Up__c))
            KYCRequired = true;    

    }
}