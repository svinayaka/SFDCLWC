trigger UpdateNewRecords on Account_Request__c (before insert, after insert) {
public string strAccId;
//strAccId=ApexPages.currentPage().getParameters().get('id');

public list<Account> accRec=new list<Account>();

if(Trigger.isBefore){

for(Account_Request__c accReq:Trigger.new)
{

accRec=[select id,name,GE_HQ_DUNS_Number__c,GE_HQ_Site_Use_Code__c,ShippingCity,ShippingStreet,
ShippingCountry,ShippingState,ShippingPostalCode,BillingCity,BillingStreet,BillingCountry,
BillingState,BillingPostalCode,GE_HQ_Marketing_Name__c,
GE_HQ_Latitude__c,GE_HQ_Longitude__c from Account where id=:accReq.GE_HQ_Account__c limit 1];
  
   accReq.AccountName_Up__c=accRec[0].name;
   accReq.DUNS_Up__c=accRec[0].GE_HQ_DUNS_Number__c; 
   accReq.Billing_City_Up__c=accRec[0].BillingCity;
   accReq.Billing_Street_Up__c=accRec[0].BillingStreet;
   accReq.Billing_Country_Up__c=accRec[0].BillingCountry;
   accReq.Billing_State_Province_Up__c=accRec[0].BillingState;
   accReq.Billing_Zip_Postal_Code_Up__c=accRec[0].BillingPostalCode;
   accReq.Shipping_City_Up__c=accRec[0].ShippingCity;
   accReq.Shipping_Street_Up__c=accRec[0].ShippingStreet;
   accReq.Shipping_Country_Up__c=accRec[0].ShippingCountry;
   accReq.Shipping_State_Province_Up__c=accRec[0].ShippingState;
   accReq.Shipping_PostalCode_Up__c=accRec[0].ShippingPostalCode;
   accReq.GE_HQ_Requested_Account_Name_Up__c=accRec[0].name;
   accReq.GE_HQ_Marketing_Name_Up__c=accRec[0].GE_HQ_Marketing_Name__c;
   
    accReq.GE_HQ_Latitude_Up__c=accRec[0].GE_HQ_Latitude__c;
    accReq.GE_HQ_Longitude_Up__c=accRec[0].GE_HQ_Longitude__c;  
    
   accReq.GE_HQ_DUNS_Number__c=accRec[0].GE_HQ_DUNS_Number__c;     
 /*   
    //Added by Harsh
    accReq.GE_HQ_City__c=accRec[0].ShippingCity;
    accReq.GE_HQ_Country__c=accRec[0].ShippingCountry;
    accReq.GE_HQ_State_Province__c=accRec[0].ShippingState;
    accReq.GE_HQ_Billing_City__c=accRec[0].BillingCity;
    accReq.GE_HQ_Billing_Country__c=accRec[0].BillingCountry;
    accReq.GE_HQ_Billing_State_Province__c=accRec[0].BillingState;
*/
   }
}

else if(Trigger.isAfter){
        Set<Id> accReqsIds =new Set<Id>();
        list<Account_Request__c> accReqs = new list<Account_Request__c>();
        for(Account_Request__c accReqObj:Trigger.new)
        {
            accReqsIds.add(accReqObj.id);    
        }
        if(accReqsIds.size()>0)
            accReqs = [select id , name from Account_Request__c where id in :accReqsIds];    
        for(Account_Request__c accReqObj: accReqs){
            String fullRecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + accReqObj.Id;
            accReqObj.GE_HQ_Documentation3__c = fullRecordURL;
            }
            
        if(accReqs.size()>0)            
            update accReqs;
}   
  

}