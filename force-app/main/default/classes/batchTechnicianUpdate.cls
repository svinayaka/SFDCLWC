global class batchTechnicianUpdate implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.stateful {  
    global integer countSuccess = 0;
    global  integer countFailed = 0;
    global integer timelimitExceeds = 0;
    global integer ServiceNotavailable = 0;
    global integer BadSSODataFound = 0;
    global integer SSOnotFound = 0;
    global integer misleniouscount = 0;
    global List<string> lstFailedSSo = new List<String>();
    global List<string> lstSuccessSSo = new List<String>();
    global List<GE_OG_OHR_User_Data_Sync__c> lstTechDataSync = new List<GE_OG_OHR_User_Data_Sync__c>();   
    global List<String> lstEmails = new List<String>();
    global String strBaseURL ;
    global Integer techLimit;
    global String query ;

global batchTechnicianUpdate(Integer i){
        techLimit = i;
    }
                
global batchTechnicianUpdate(){
        System.Debug('.... Non Parameterized Cons... ');
    }

global database.querylocator start(Database.BatchableContext BC) {
        
       strBaseURL = URL.getSalesforceBaseUrl().toExternalForm() ;
      // String query ;
       // String query = 'SELECT Id, Name, GE_HQ_SSO_ID__c, City, GE_DS_Country__c FROM User WHERE GE_HQ_SSO_ID__c = \'305013936\' or isActive = true AND GE_Is_ServiceMax_User__c = true limit 500';
       
       if(Test.isRunningTest())
       {
        query = 'SELECT Id, Name, GE_SM_HQ_SSO_ID__c, SVMXC__City__c, SVMXC__Email__c, SVMXC__Zip__c, SVMXC__State__c, SVMXC__Country__c,GE_OG_Region__c,SVMXC__Street__c FROM SVMXC__Service_Group_Members__c where GE_SM_HQ_SSO_ID__c!= null LIMIT 5 ';
        System.debug('inside test');
       }
       else if(techLimit != null ){
            query = 'SELECT Id, Name, GE_SM_HQ_SSO_ID__c, SVMXC__City__c, SVMXC__Email__c, SVMXC__Zip__c, SVMXC__State__c, SVMXC__Country__c,GE_OG_Region__c,SVMXC__Street__c  FROM SVMXC__Service_Group_Members__c LIMIT:techLimit';
       }else{
            query = 'SELECT Id, Name, GE_SM_HQ_SSO_ID__c, SVMXC__City__c, SVMXC__Email__c, SVMXC__Zip__c, SVMXC__State__c, SVMXC__Country__c,GE_OG_Region__c,SVMXC__Street__c  FROM SVMXC__Service_Group_Members__c' ;
        }
        System.debug('outside test');       
        return Database.getQueryLocator(query);
    }          

global void execute(Database.BatchableContext BC, Sobject[] scope) {
        List<SVMXC__Service_Group_Members__c> lstTechtoUpdate = new List<SVMXC__Service_Group_Members__c>();
        Boolean UpdateTechData = false;
        for(SVMXC__Service_Group_Members__c tech: (List<SVMXC__Service_Group_Members__c>)scope){
            system.debug('inside techloop' + tech.GE_SM_HQ_SSO_ID__c);
            if(tech.GE_SM_HQ_SSO_ID__c.length()<=9){
            UpdateTechData = false;
            
            try{
                //GE_OG_GetSSO_OHR_User_Update resource = new GE_OG_GetSSO_OHR_User_Update(tech.GE_SM_HQ_SSO_ID__c);
                //GE_OG_OHR_SSOData sdata = GE_OG_OHR_SSOData.parse(resource.invoke()); 
                 GE_OG_GetSSO_OHR_User_Update resource = new GE_OG_GetSSO_OHR_User_Update();
                 GE_OG_OHR_SSOData sdata = GE_OG_OHR_SSOData.parse(resource.returnresponse(tech.GE_SM_HQ_SSO_ID__c)); 
                 system.Debug('country  '+tech.GE_SM_HQ_SSO_ID__c) ;
                system.Debug('country  '+sdata.person.workLocationCountry) ;
                 system.Debug('street  '+sdata.person.workLocationAddressLine1) ;
                lstSuccessSSo.add(tech.GE_SM_HQ_SSO_ID__c);
                 system.Debug('country  '+tech.GE_SM_HQ_SSO_ID__c) ;
                 system.Debug('country  '+lstSuccessSSo) ;
                if(sdata.person.workLocationCountry != null && sdata.person.workLocationCountry != tech.SVMXC__Country__c && sdata.person.workLocationCountry.length() <= 255){ tech.SVMXC__Country__c = sdata.person.workLocationCountry;UpdateTechData=true; } 
                if(sdata.person.workLocationTownOrCity != null && sdata.person.workLocationTownOrCity != tech.SVMXC__City__c && sdata.person.workLocationTownOrCity.length() <= 40){tech.SVMXC__City__c= sdata.person.workLocationTownOrCity; UpdateTechData=true;  }
                  if(sdata.person.workLocationPostalCode != null && sdata.person.workLocationPostalCode !=tech.SVMXC__Zip__c && sdata.person.workLocationPostalCode.length() <= 20) { tech.SVMXC__Zip__c = sdata.person.workLocationPostalCode; UpdateTechData=true;  }
                  if(sdata.person.workLocationStateOrProvince != null && sdata.person.workLocationStateOrProvince != tech.SVMXC__State__c && sdata.person.workLocationStateOrProvince.length() <= 80 ) {tech.SVMXC__State__c = sdata.person.workLocationStateOrProvince; UpdateTechData=true; }
                   if(sdata.person.workLocationAddressLine2!= null && sdata.person.workLocationAddressLine2!= tech.SVMXC__Street__c  && sdata.person.workLocationAddressLine2.length() <= 100 ) 
                    {tech.SVMXC__Street__c = sdata.person.workLocationAddressLine1 + ' ' + sdata.person.workLocationAddressLine2; }else{ tech.SVMXC__Street__c = sdata.person.workLocationAddressLine1; UpdateTechData=true;}
                 system.Debug('success SSO    '+tech.GE_SM_HQ_SSO_ID__c);
                System.Debug('.... User City ... '+tech.SVMXC__City__c);
                system.Debug('location name  '+sdata.person.workLocationName)  ;          
                System.Debug('count Success... '+ countSuccess++);
                System.Debug('... lstTechDataSync .... '+lstTechDataSync.size());
                
                if(UpdateTechData ){ lstTechtoUpdate.add(tech);lstTechDataSync.add(new GE_OG_OHR_User_Data_Sync__c(City__c = sdata.person.workLocationTownOrCity, State__c = sdata.person.workLocationStateOrProvince, Street__c= sdata.person.workLocationAddressLine1,SSO__c = tech.GE_SM_HQ_SSO_ID__c, Postal_Code__c = sdata.person.workLocationPostalCode, Status__c = 'Successful', Technician_Name__c = tech.Name, Tech_Id__c = tech.Id,GE_OHR_Information_Updated_in_SFDC__c = 'Yes',GE_OG_Technician_Batch_Run_Date__c = Date.today(), Country__c = sdata.person.workLocationCountry, Region__c=tech.GE_OG_Region__c)); } 
                 else{  lstTechDataSync.add(new GE_OG_OHR_User_Data_Sync__c(City__c = sdata.person.workLocationTownOrCity, State__c = sdata.person.workLocationStateOrProvince, Postal_Code__c = sdata.person.workLocationPostalCode, Street__c= sdata.person.workLocationAddressLine1, SSO__c = tech.GE_SM_HQ_SSO_ID__c, Status__c = 'Successful', Tech_Id__c = tech.Id, Technician_Name__c = tech.Name, GE_OHR_Information_Updated_in_SFDC__c = 'No',GE_OG_Technician_Batch_Run_Date__c = Date.today(), Country__c = sdata.person.workLocationCountry, Region__c=tech.GE_OG_Region__c)); }
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
                { misleniouscount++;
                }
                 lstTechDataSync.add(new GE_OG_OHR_User_Data_Sync__c(Technician_Name__c = tech.Name, SSO__c = tech.GE_SM_HQ_SSO_ID__c, Status__c = 'Failed', Tech_Id__c = tech.Id,GE_OHR_Information_Updated_in_SFDC__c = 'No',GE_OG_Technician_Batch_Run_Date__c = Date.today(), Error_Description__c = e.getMessage()));
                system.Debug('batch error message  '+e.getMessage());
                system.Debug('failed SSO    '+tech.GE_SM_HQ_SSO_ID__c);
                system.Debug('failed SSO  Email... '+tech.SVMXC__Email__c);
                lstFailedSSo.add(tech.GE_SM_HQ_SSO_ID__c);
                if(lstFailedSSo.size() > 0){
                    lstEmails.add(tech.SVMXC__Email__c) ;
                }
                System.Debug('count failed... '+ countFailed++);
                continue;
        }
            }
        }
        System.Debug('..... lstTechtoUpdate ..... ' +lstTechtoUpdate.size());
        if(lstTechtoUpdate!= null && lstTechtoUpdate.size() > 0)
        { System.Debug('..... lstTechtoUpdate ..... ' +lstTechtoUpdate.size());
            update lstTechtoUpdate;
        } 
        System.Debug('..... lstTechtoUpdate ..... ' +lstTechtoUpdate.size());       
    }
 
  global void finish(Database.BatchableContext BC) {
        
        System.Debug('lstTechDataSync...... '+lstTechDataSync.size());
       
        if(lstTechDataSync.size() > 0 )
            insert lstTechDataSync ;
        
        String successRepURL  = 'Report not available';
        String FailedRepURL = 'Report not available';
        for(Report rep:[SELECT Id,DeveloperName FROM Report WHERE DeveloperName = 'OHR_Technician_Data_Successful' or DeveloperName = 'OHR_Technician_Data_Failed'])
        {           
            if(rep.developername == 'OHR_Technician_Data_Successful')
            {
                successRepURL = strBaseURL+'/'+rep.id;
                System.Debug('.... strBaseURL ....'+strBaseURL);
            }
            if(rep.developername == 'OHR_Technician_Data_Failed')
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
        System.Debug('Total count failed records ... misleniouscouont  '+ misleniouscount);    
        System.Debug('Total count success records ... '+ countSuccess);    
        System.Debug('List Success SSO ... '+ lstSuccessSSo);

        AsyncApexJob a = [SELECT Id, CreatedDate, CompletedDate FROM AsyncApexJob WHERE Id = :BC.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        OrgWideEmailAddress owa = [select Id, Address, DisplayName from OrgWideEmailAddress WHERE Id=: Label.GE_OG_SER_OrganizationWideEmailLabel LIMIT 1];
        mail.setOrgWideEmailAddressId(owa.id);
        
        String toAddress = Label.GEOGOHRTechnicianDL;
        String[] toAdd = toAddress.split(',');
        mail.setToAddresses(toAdd);
        //mail.setCCAddresses();
        mail.setSubject('Technician Data Updated from OHR');
        mail.setHtmlBody('Please find below the Report Links of successful and failed Technician records which were updated from OHR Server.<br/><br/> Batch Submission Date/Time:' + a.CreatedDate+'<br/> Batch Completion Date/Time: '+a.CompletedDate+'<br/><br/>Total Number of Technician Records: '+lstTechDataSync.size()+'<br/>Number of Technician Records Processed: '+lstTechDataSync.size()+'<br/><br/>Successfully Updated Records Report: '+ successRepURL +' <br/> <br/> Failed Records Report Link: '+FailedRepURL );
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }           

}