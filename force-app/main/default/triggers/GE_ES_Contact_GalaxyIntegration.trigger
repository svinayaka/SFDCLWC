//Number of SOQL queries: 0 out of 100
//Number of DML statements: 0
//Number of DML rows: 0
//trigger GE_ES_Contact_GalaxyIntegration on Contact (After Insert, Before Update, Before Delete)
trigger GE_ES_Contact_GalaxyIntegration on Contact (After Insert, Before Update) {

  //Code to skip trigger

   OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_ES_Contact_GalaxyIntegration');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Contact'){
       
        return;  
    }
    else{
    List<Contact> contactsToProcess = new List<Contact>(); //these contacs will be send to WS
    Set<Id> UserIds = new Set<Id>();
    Set<ID> AccountIDs = new Set<ID>();
    Set<ID> ContactIDs = new Set<ID>();

    /*if(Trigger.isDelete)
    {
        for(Contact objContact: System.Trigger.old)
        {
            contactsToProcess.add(objContact);
            ContactIDs.add(objContact.ID);
            AccountIDs.add(objContact.AccountID);
            UserIds.add(objContact.CreatedById);
            UserIds.add(objContact.LastModifiedById);
        }
    }
    else*/
     if(Trigger.isInsert)
    {
        for(Contact objContact: System.Trigger.new)
        {
            contactsToProcess.add(objContact);
            ContactIDs.add(objContact.ID);
            AccountIDs.add(objContact.AccountID);
            UserIds.add(objContact.CreatedById);
            UserIds.add(objContact.LastModifiedById);
        }
    }
    else
    {
        for(Contact objContact: System.Trigger.new)
        {
            Contact oValues = Trigger.oldmap.get(objContact.ID);
            if((oValues.AccountID != objContact.AccountID) || (oValues.FirstName != objContact.FirstName) || (oValues.LastName != objContact.LastName) || (oValues.Title != objContact.Title)
                || (oValues.Email != objContact.Email) || (oValues.Phone != objContact.Phone) || (oValues.Fax != objContact.Fax) || (oValues.GE_HQ_CONTACT_STATUS__c != objContact.GE_HQ_CONTACT_STATUS__c)
 )
            {
                contactsToProcess.add(objContact);
                ContactIDs.add(objContact.ID);
                AccountIDs.add(objContact.AccountID);
                UserIds.add(objContact.CreatedById);
                UserIds.add(objContact.LastModifiedById);
            }
        }
    }
    if(contactsToProcess.size()>0) //if there are contacts to send to WS
    {
       /* if(Trigger.isDelete) {
            //for deleted records, data will be stored in Set of strings with :::: as delimiter
            Set<String> ContactDetails= new Set<String>();
            String outStr;
            for(Contact objCon :contactsToProcess) {
                outStr = objCon.ID + '::::' + objCon.AccountID + '::::' + objCon.FirstName + '::::';
                outStr = outStr + objCon.LastName + '::::' + objCon.Salutation + '::::' + objCon.Email + '::::';
                outStr = outStr + objCon.Phone + '::::' + objCon.Fax + '::::' + objCon.CreatedDate.format('yyyy-MM-dd HH:mm:ss') + '::::';
                outStr = outStr + objCon.CreatedByID + '::::' + objCon.LastModifiedDate.format('yyyy-MM-dd HH:mm:ss') + '::::';
                outStr = outStr + objCon.LastModifiedById;
                ContactDetails.add(outStr);
            }
            GE_ES_ContactGalaxyIntegrationWrapper.deleteContactRequest(ContactDetails,UserIDs,AccountIDs,'InActive');
        }
        else {*/
        
            try {
            //GE_ES_ContactGalaxyIntegrationWrapper.newContactRequest(ContactIDs,UserIDs,AccountIDs,'Active');
             GE_ES_ContactGalaxyIntegrationWrapper.newContactRequest(ContactIDs,UserIDs,AccountIDs);
            } catch(exception e) {}
        //}
    }
}
}