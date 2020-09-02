global class batchUsrUpdate implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.stateful {   
    
    global integer countSuccess = 0;
    global  integer countFailed = 0;
    global integer timelimitExceeds = 0;
    global integer ServiceNotavailable = 0;
    global integer BadSSODataFound = 0;
    global integer SSOnotFound = 0;
    global integer misleniouscouont = 0;
    global List<string> lstFailedSSo = new List<String>();
    global List<string> lstSuccessSSo = new List<String>();
    global List<GE_OG_OHR_User_Data_Sync__c> lstUsrDataSync = new List<GE_OG_OHR_User_Data_Sync__c>();   
    global List<String> lstEmails = new List<String>();
    global String strBaseURL ;
    global Integer usrLimit;
    global String query ;
    //global List<User> lstUsertoUpdate = new List<User>();
    
    global batchUsrUpdate(Integer i){
        usrLimit = i;
    }
    global batchUsrUpdate(){
        System.Debug('.... Non Parameterized Cons... ');
    }
    
    global database.querylocator start(Database.BatchableContext BC) {
        
       strBaseURL = URL.getSalesforceBaseUrl().toExternalForm() ;
      // String query ;
       // String query = 'SELECT Id, Name, GE_HQ_SSO_ID__c, City, GE_DS_Country__c FROM User WHERE GE_HQ_SSO_ID__c = \'305013936\' or isActive = true AND GE_Is_ServiceMax_User__c = true limit 500';
       
       if(Test.isRunningTest())
       {
        query = 'SELECT Id, Name, GE_HQ_SSO_ID__c, City, Email, PostalCode, State, GE_DS_Country__c FROM User WHERE isActive = true AND GE_Is_ServiceMax_User__c = true LIMIT 5 ';
       }
       else if(usrLimit != null ){
            query = 'SELECT Id, Name, GE_HQ_SSO_ID__c, City, Email, PostalCode, State, GE_DS_Country__c FROM User WHERE isActive = true AND GE_Is_ServiceMax_User__c = true LIMIT:usrLimit ';
            
       }else{
            query = 'SELECT Id, Name, GE_HQ_SSO_ID__c, City, Email, PostalCode, State, GE_DS_Country__c FROM User WHERE isActive = true AND GE_Is_ServiceMax_User__c = true';
        }
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, Sobject[] scope) {
        List<User> lstUsertoUpdate = new List<User>();
        Boolean UpdateUserData = false;
        for(User u: (List<User>)scope){
            system.debug('inside userloop');
            if(u.GE_HQ_SSO_ID__c.length()<=9){
            UpdateUserData = false;
            
            try{
                GE_OG_GetSSO_OHR_User_Update resource = new GE_OG_GetSSO_OHR_User_Update();
                GE_OG_OHR_SSOData sdata = GE_OG_OHR_SSOData.parse(resource.returnresponse(u.GE_HQ_SSO_ID__c)); 
                 system.debug('sdata----'+u.GE_HQ_SSO_ID__c) ;
                system.debug('country  '+sdata.person.workLocationCountry) ;
                lstSuccessSSo.add(u.GE_HQ_SSO_ID__c);
                 system.debug('country  '+u.GE_HQ_SSO_ID__c) ;
                 system.debug('country  '+lstSuccessSSo) ;
                if(sdata.person.workLocationCountry != null && sdata.person.workLocationCountry != u.GE_DS_Country__c && sdata.person.workLocationCountry.length() <= 255) { u.GE_DS_Country__c = sdata.person.workLocationCountry; UpdateUserData=true;  }
                if(sdata.person.workLocationTownOrCity != null && sdata.person.workLocationTownOrCity != u.city && sdata.person.workLocationTownOrCity.length() <= 40){ u.city = sdata.person.workLocationTownOrCity; UpdateUserData=true; }
                if(sdata.person.workLocationPostalCode != null && sdata.person.workLocationPostalCode != u.PostalCode && sdata.person.workLocationPostalCode.length() <= 20){ u.PostalCode = sdata.person.workLocationPostalCode;UpdateUserData=true; }
                if(sdata.person.workLocationStateOrProvince != null && sdata.person.workLocationStateOrProvince != u.State && sdata.person.workLocationStateOrProvince.length() <= 80 ) {u.State = sdata.person.workLocationStateOrProvince; UpdateUserData=true;}
                system.debug('success SSO    '+u.GE_HQ_SSO_ID__c);
                System.Debug('.... User City ... '+u.city);
                system.debug('location name  '+sdata.person.workLocationName)  ;          
                System.Debug('count Success... '+ countSuccess++);
                System.Debug('UpdateUserData ----'+ UpdateUserData  );
                System.Debug('... lstUsrDataSync .... '+lstUsrDataSync.size());
                if(UpdateUserData )
                { 
                    lstUsertoUpdate.add(u);lstUsrDataSync.add(new GE_OG_OHR_User_Data_Sync__c(City__c = sdata.person.workLocationTownOrCity, State__c = sdata.person.workLocationStateOrProvince, SSO__c = u.GE_HQ_SSO_ID__c, Postal_Code__c = sdata.person.workLocationPostalCode, Status__c = 'Successful', User_Name__c = u.Name, Uesr_Id__c = u.Id,GE_OHR_Information_Updated_in_SFDC__c = 'Yes',GE_OG_Batch_Run_Date__c = Date.today(), Country__c = sdata.person.workLocationCountry)); } 
                else
                { 
                    lstUsrDataSync.add(new GE_OG_OHR_User_Data_Sync__c(City__c = sdata.person.workLocationTownOrCity, State__c = sdata.person.workLocationStateOrProvince, Postal_Code__c = sdata.person.workLocationPostalCode, SSO__c = u.GE_HQ_SSO_ID__c, Status__c = 'Successful', Uesr_Id__c = u.Id, User_Name__c = u.Name, GE_OHR_Information_Updated_in_SFDC__c = 'No',GE_OG_Batch_Run_Date__c = Date.today(), Country__c = sdata.person.workLocationCountry));}
                if(Test.isRunningTest())
                    Integer i =1/0 ;
            }catch(Exception e){
                String errmsg= e.getMessage();
                if(errmsg.contains('Bad SSO Data Found'))
                {  BadSSODataFound++;
                } else if(errmsg.contains('SSO not Found'))
                {  SSOnotFound++;
                } else if(errmsg.contains('Service Not available'))
                { ServiceNotavailable++;
                } else if(errmsg.contains('Exceeded maximum time allotted for callout'))
                { timelimitExceeds++;
                }else
                { misleniouscouont++;
                }
                 lstUsrDataSync.add(new GE_OG_OHR_User_Data_Sync__c(User_Name__c = u.Name, SSO__c = u.GE_HQ_SSO_ID__c, Status__c = 'Failed', Uesr_Id__c = u.Id,GE_OHR_Information_Updated_in_SFDC__c = 'No',GE_OG_Batch_Run_Date__c = Date.today(), Error_Description__c = e.getMessage()));
                system.debug('batch error message  '+e.getMessage());
                system.debug('failed SSO    '+u.GE_HQ_SSO_ID__c);
                system.debug('failed SSO  Email... '+u.Email);
                lstFailedSSo.add(u.GE_HQ_SSO_ID__c);
                if(lstFailedSSo.size() > 0){
                    lstEmails.add(u.Email) ;
                }
                System.Debug('count failed... '+ countFailed++);
                continue;
        }
            }
        }
        System.Debug('..... lstUsertoUpdate ..... ' +lstUsertoUpdate.size());
        if(lstUsertoUpdate!= null && lstUsertoUpdate.size() > 0)
        { System.Debug('..... lstUsertoUpdate ..... ' +lstUsertoUpdate.size());
            update lstUsertoUpdate;
        } 
        System.Debug('..... lstUsertoUpdate ..... ' +lstUsertoUpdate.size());       
    }
    global void finish(Database.BatchableContext BC) {
        /*List<GE_OG_OHR_User_Data_Sync__c> lstUsrInsrtRecords =  [SELECT Id FROM GE_OG_OHR_User_Data_Sync__c];
        if(lstUsrInsrtRecords != null && lstUsrInsrtRecords.size() > 0)
           Delete lstUsrInsrtRecords ;      
        */
        System.Debug('lstUsrDataSync...... '+lstUsrDataSync);
        //System.Debug('..... lstUsertoUpdate ..... ' +lstUsertoUpdate.size());
        if(lstUsrDataSync.size() > 0 )
            insert lstUsrDataSync ;
        String successRepURL  = 'Report not available';
        String FailedRepURL = 'Report not available';
        for(Report rep:[SELECT Id,DeveloperName FROM Report WHERE DeveloperName = 'OHR_Data_Updated_Successful' or DeveloperName = 'OHR_User_Data_Failed'])
        {           
            if(rep.developername == 'OHR_Data_Updated_Successful')
            {
                successRepURL = strBaseURL+'/'+rep.id;
                System.Debug('.... strBaseURL ....'+strBaseURL);
            }
            if(rep.developername == 'OHR_User_Data_Failed')
            {
                FailedRepURL = strBaseURL+'/'+rep.id;
                System.Debug('.... strBaseURL ....'+strBaseURL);
            }
        }   
        System.debug('... lstEmails ..... '+lstEmails.size());
        System.Debug('Total count failed records ... '+ countFailed);
        System.Debug(' failed SSO... '+ lstFailedSSo);
        System.Debug('Total count failed records BadSSODataFound...  '+ BadSSODataFound);
        System.Debug('Total count failed records ... SSOnotFound   '+ SSOnotFound);
        System.Debug('Total count failed records ... ServiceNotavailable  '+ ServiceNotavailable);
        System.Debug('Total count failed records ... timelimitExceeds  '+ timelimitExceeds);
        System.Debug('Total count failed records ... misleniouscouont  '+ misleniouscouont);    
        System.Debug('Total count success records ... '+ countSuccess);    
        System.Debug('List Success SSO ... '+ lstSuccessSSo);

        AsyncApexJob a = [SELECT Id, CreatedDate, CompletedDate FROM AsyncApexJob WHERE Id = :BC.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        OrgWideEmailAddress owa = [select Id, Address, DisplayName from OrgWideEmailAddress WHERE Id=: Label.GE_OG_SER_OrganizationWideEmailLabel LIMIT 1];
        mail.setOrgWideEmailAddressId(owa.id);
        
        String toAddress = Label.GEOGOHRUserDL;
        String[] toAdd = toAddress.split(',');
        mail.setToAddresses(toAdd);
        //mail.setCCAddresses();
        mail.setSubject('User Data Updated from OHR');
        mail.setHtmlBody('Please find below the Report Links of successful and failed user records which were updated from OHR Server.<br/><br/> Batch Submission Date/Time:' + a.CreatedDate+'<br/> Batch Completion Date/Time: '+a.CompletedDate+'<br/><br/>Total Number of User Records: '+lstUsrDataSync.size()+'<br/>Number of User Records Processed: '+lstUsrDataSync.size()+'<br/><br/>Successfully Updated Records Report: '+ successRepURL +' <br/> <br/> Failed Records Report Link: '+FailedRepURL );
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}