/*
=====================================
Name       : ContactGalaxyIntegrationWrapper
testclass  : GE_ES_ContactGalaxyIntegrationTest (created bu kiru/sumit)
Author     : SaiKrishna V.
Created On : 14 Sept 2010 
Purpose    : To write the mapping between the SFDC and WebMethod fields and calling the webservice

//Number of SOQL queries: 3 out of 100
//Number of query rows: N out of 500, N<10 (insert or update batch size)
//Number of DML statements: 1
//Number of DML rows: 10
=====================================
*/

public class GE_ES_ContactGalaxyIntegrationWrapper
{  
   
    @TestVisible static boolean isTest = true ;       
    //This method will get the set of ContactIDs,UserIDs and AccountIDs and status from the trigger and call the webservice
    //by setting the corresponding webmethod variables.
    //Future annotation to mark the method as async.
    @Future(callout=true)
    Public static void newContactRequest(Set<ID> ContactIDs,Set<ID> UserIDs,Set<ID> AccountIDs)
    {
        IntegrationExecution IntegrationExecutionObj = new IntegrationExecution('PW');
        if(IntegrationExecutionObj.IsOrgName == true || !isTest ){
            List<Contact> srcList = [select ID,AccountID,FIRSTNAME,LASTNAME,TITLE,SALUTATION,EMAIL,PHONE,FAX,CREATEDDATE,CREATEDBYID,LastModifiedDate,LASTMODIFIEDBYID,GE_ES_Galaxy_Status__c,GE_ES_Galaxy_Error_Description__c,GE_HQ_CONTACT_STATUS__c, GE_HQ_SFDC_Legacy_Id__c from contact where id in :ContactIDs];
            GE_ES_PublishContact.GE_SFDC_RDBContact_Source_WebServices_publishContact_WSD_Port webclient;
            GE_ES_PublishContact.ContactDetailsResponse  objResponse;          
            GE_ES_PublishContact.ContactDetailsRequest conDetails;
            conDetails= new GE_ES_PublishContact.ContactDetailsRequest();
            webclient = new GE_ES_PublishContact.GE_SFDC_RDBContact_Source_WebServices_publishContact_WSD_Port();
            objResponse=new GE_ES_PublishContact.ContactDetailsResponse();
    
            // Credentials for Web Service (HTTP Header)
            if (GE_HQ_SingleOrgEnvConfig.GCON_useHTTPAuthorization())
            {
                webclient.inputHttpHeaders_x = new Map<string, string>();
                webclient.inputHttpHeaders_x.put('Authorization', GE_HQ_SingleOrgEnvConfig.GCON_getHTTPAuthorization());
            }
                
            // Set webservice timeout
            webclient.timeout_x = GE_HQ_SingleOrgEnvConfig.GCON_getWebServiceTimeout();
            webclient.endpoint_x = GE_HQ_SingleOrgEnvConfig.GCON_getEndpointBase(); 
    
            //Set the User details and Account details to the MAP objects
            Map<Id, User> UserDetails = new map<Id, User>([Select ID,Name from User where id IN :UserIds]);
            Map<Id, Account> AccountDetails = new map<Id, Account>([Select ID,GE_HQ_DUNS_Number__c from Account where id IN :AccountIDs]);
    
            //iterate through each contact record in the list and call the webservice once for each contact.
            for(Contact objContact :srcList) {
                String DunsNum;
                String CreatedBy;
                String ModifiedBy;
                try{
                    DunsNum = '';
                    DunsNum = AccountDetails.get(objContact.AccountID).GE_HQ_DUNS_Number__c;
                } catch(exception e){}
                try{
                    CreatedBy= '';
                    CreatedBy= UserDetails.get(objContact.CreatedById).Name;
                } catch(exception e){}
                try{
                    ModifiedBy= '';
                    ModifiedBy= UserDetails.get(objContact.LastModifiedById).Name;
                } catch(exception e){}
        
                conDetails= new GE_ES_PublishContact.ContactDetailsRequest();
                
                conDetails.DUNS_NUMBER=DunsNum;
                if(objContact.GE_HQ_SFDC_Legacy_Id__c != null){
                    conDetails.ID=objContact.GE_HQ_SFDC_Legacy_Id__c;
                }
                else{
                    conDetails.ID=objContact.ID;
                }
                conDetails.FIRST_NAME='';
                conDetails.LAST_NAME='';
                conDetails.SALUTATION='';
                conDetails.EMAIL_ADDRESS='';
                conDetails.PHONE_NUM='';
                conDetails.FAX_NUM='';
                conDetails.CREATION_DATE=null;
                conDetails.CREATED_BY='';
                conDetails.LAST_UPDATE_DATE=null;
                conDetails.LAST_UPDATED_BY='';
                
                try {
                    conDetails.FIRST_NAME=objContact.FirstName;
                } catch(exception e){ }
                
                try {
                    conDetails.LAST_NAME=objContact.LastName;
                } catch(exception e){ }
                try {
                    conDetails.SALUTATION=objContact.Title; //objContact.Salutation;
                } catch(exception e){ }
                try {
                    conDetails.EMAIL_ADDRESS=objContact.Email;
                } catch(exception e){ }
                try {
                    conDetails.PHONE_NUM=objContact.Phone;
                } catch(exception e){ }
                try {
                    conDetails.FAX_NUM=objContact.Fax;
                } catch(exception e){ }
                try {
                    conDetails.CREATION_DATE=objContact.CreatedDate; //.format('yyyy-MM-dd HH:mm:ss');
                } catch(exception e){ }
                try {
                    conDetails.CREATED_BY=CreatedBy;
                } catch(exception e){ }
                try {
                    conDetails.LAST_UPDATE_DATE=objContact.LastModifiedDate; //.format('yyyy-MM-dd HH:mm:ss');
                } catch(exception e){ }
                try {
                    conDetails.LAST_UPDATED_BY=ModifiedBy;
                } catch(exception e){ }
                conDetails.CONTACT_STATUS = objContact.GE_HQ_CONTACT_STATUS__c; //'InActive';
                try {
                    objResponse=webclient.publishContact(conDetails);
                   // if(status != 'InActive') //for insert or updated records
                   // {
                        //update the WebService response status to SFDC Contact object.
                        objContact.GE_ES_Galaxy_Status__c = objResponse.STATUS;
                        objContact.GE_ES_Galaxy_Error_Description__c = objResponse.ERROR_DESCRIPTION;
                        system.Debug('SSSSSS'+objResponse);
                   // }
                } catch(exception e){}
            }
            update srcList;
        }
        else {
          
            IntegrationActivity intActivity = new IntegrationActivity();
            intActivity.setStrObject('Opportunity');
            intActivity.setStrSource('SFDC');
            intActivity.setStrTarget('Galaxy');
            intActivity.setStrStatus('Failure');
            intActivity.setStrStatusDetail('Opportunity of PW can not be submitted in ' + Label.GE_Organization_Name + ' Instance');
            //intActivity.setStrSubmittedRecordId(OpptyId);
            intActivity.setStrRecordDesc('Integration submitted via Trigger to send Contact detail to the Galaxy system');
            intActivity.insertIntegrationActivity();
            
        }
    }

}