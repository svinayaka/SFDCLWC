public with sharing class OG_Support_Tab
{
    
    public SFDC_Support_Case__c objCase;
    public String strBusiness {get; set;}
    public String strApplication;
    public String strUserSSOId {get; set;}
    public User userLoggedIn {get; set;}
    public String strApp {get; set;}
    public User objUser;
    public Boolean boolSFDC {get; set;}
    public Boolean boolBM {get; set;}
    public String strSucess {get; set;}
    public String strSelTab {get; set;}
    public String strLoggedInUserId;
    public Boolean riskAdmin {get; set;}
    public string strDocUrl{get;set;}
    
        
    public OG_Support_Tab(ApexPages.StandardController stdController) {
        this.objCase = (SFDC_Support_Case__c)stdController.getRecord();
        //strApplication = apexpages.CurrentPage().getParameters().get('ap');
        //userLoggedIn = [Select Id, Email, GE_HQ_SSO_ID__c from User where Id=:UserInfo.getUserId()];
        objCase.Caller_SSO_ID__c = UserInfo.getUserId();
        strLoggedInUserId = UserInfo.getUserId();
        strSelTab = 'Home';
        
        
        //Added for Report issues
        
        try
  {
    List<Document> FirstDocument = [SELECT Id,Name FROM Document WHERE Name = 'Report Issues' LIMIT 1];
    string strOrgId = UserInfo.getOrganizationId();
    strDocUrl = '/servlet/servlet.FileDownload?file='+FirstDocument[0].Id;
    system.debug('strDocUrl*******'+strDocUrl);

  }
  catch (Exception e) 
  {
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error in getDocumentLogoUrl() ' + e.getMessage()));
    System.debug('Error: ' + e.getMessage());
  }
    System.debug('The URL is ' + strDocUrl);
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'The URL returned is ' + strDocUrl));   
        
              //Added for Report issues
  
        
        
        
        try{
        PermissionSetAssignment psa = [Select AssigneeId from PermissionSetAssignment where PermissionSet.Name = 'Risk_Admin_Super_Users' AND AssigneeId =:UserInfo.getUserId()];
        riskAdmin = true;
        } catch(Exception e) {
            riskAdmin = false;
        }
            
        /*if(strApplication == 'Salesforce')
        {
            boolSFDC = TRUE;
            boolBM = FALSE;
        }
        else
        {
            if(strApplication == 'Bigmachines')
            {
                boolBM = TRUE;
            }
            else
            {
                boolBM = FALSE;
            }
            boolSFDC = FALSE;
            
        }*/
        
    }
     public Attachment attachment {
      get {
          if (attachment == null)
            attachment = new Attachment();
          return attachment;
        }
      set;
      }
      
      public Attachment attachmentTemp {
      get ;
      set;
      }
      
      
      

    public String url {get; set;}
    Public List<SelectOption> options {get; set;}
    
    public boolean displayPopup {get; set;}     
    
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
    
    public List<SelectOption> getBusinessSFDC() 
    {
        options = new List<SelectOption>();
        Schema.DescribeFieldResult F = SFDC_Support_Case__c.Business_Tier__c.getDescribe();
        List<Schema.PicklistEntry> values = F.getPicklistValues();
        for (Schema.PicklistEntry P : values)
          { 
             options.add(new SelectOption(P.getLabel(), P.getValue())); 
          }  
        //if(strApplication == 'Salesforce')
        //{
            /*options.add(new SelectOption('Global Services','Global Services'));
            options.add(new SelectOption('Turbo Machinery','Turbo Machinery'));
            options.add(new SelectOption('Drilling and Surface','Drilling and Surface'));
            options.add(new SelectOption('Subsea','Subsea'));
            options.add(new SelectOption('Measurement and Control','Measurement and Control'));
            options.add(new SelectOption('PII','PII'));
        }
        else if(strApplication == 'Bigmachines')
        {
            options.add(new SelectOption('Measurement and Control','Measurement and Control'));
        }
        else if(strApplication == 'Servicemax')
        {
            options.add(new SelectOption('Measurement and Control','Measurement and Control'));
             options.add(new SelectOption('Drilling and Surface','Drilling and Surface'));
        }
        else if(strApplication == 'Marketo')
        {
            options.add(new SelectOption('ALL','ALL'));
            options.add(new SelectOption('Global Services','Global Services'));
            options.add(new SelectOption('Turbo Machinery','Turbo Machinery'));
            options.add(new SelectOption('Drilling and Production','Drilling and Production'));
            options.add(new SelectOption('Subsea','Subsea'));
            options.add(new SelectOption('Measurement and Control','Measurement and Control'));
            options.add(new SelectOption('PII','PII'));
        }*/
        
        return options;
    }
    
    public List<SelectOption> getBusinessBigMachines() 
    {
        options = new List<SelectOption>();
        options.add(new SelectOption('Surface','Surface'));
        options.add(new SelectOption('Digital Solutions','Digital Solutions'));
        options.add(new SelectOption('Subsea & Drilling','Subsea & Drilling'));
        return options;
    }
    
    public List<SelectOption> getBusinessServiceMax() 
    {
        options = new List<SelectOption>();
        options.add(new SelectOption('Surface','Surface'));
        options.add(new SelectOption('Digital Solutions','Digital Solutions'));
        options.add(new SelectOption('Subsea & Drilling','Subsea & Drilling'));
        options.add(new SelectOption('Turbomachinery Solutions','Turbomachinery Solutions'));
        options.add(new SelectOption('Downstream Technology Solutions ','Downstream Technology Solutions '));
        return options;
    }
    
    public Attachment processUpload()
    {
        System.debug('attachmentTemp ==='+attachmentTemp +'attachment===='+attachment );
        attachmentTemp = attachment ;
        
        return attachment ;
        } 
        
     
       
       
    public PageReference saveTicketSFDC() 
    {
    System.debug('IN SFDC SAVE');
        strSelTab ='SFDC';
        strSucess = NULL;
        saveTicket('Salesforce');
        if(strSucess == 'SUCCESS')
        {
            PageReference pg = new PageReference('/apex/OG_Support_Thank_You');
            pg.setRedirect(true);
            return pg;
        }
        else{
            return null;}
    }
    
    public PageReference saveTicketBigMachines() 
    {
        strSucess = NULL;
        saveTicket('Bigmachines');
        if(strSucess == 'SUCCESS')
        {
            PageReference pg = new PageReference('/apex/OG_Support_Thank_You');
            pg.setRedirect(true);
            return pg;
        }
        else{
            return null;}
    }
    
    public PageReference saveTicketServiceMax() 
    {
        strSucess = NULL;
        saveTicket('ServiceMax');
        if(strSucess == 'SUCCESS')
        {
            PageReference pg = new PageReference('/apex/OG_Support_Thank_You');
            pg.setRedirect(true);
            return pg;
        }
        else{
            return null;}
    }
    
    public PageReference saveTicket(String strSelApp) {
        String sfdcBaseURL = System.URL.getSalesforceBaseUrl().toExternalForm();
        System.debug('URL========='+sfdcBaseURL +objCase +attachmentTemp );
        strApplication = strSelApp;
        String strAffectedRecord = '';
        String strAffectedPeople = '';
        if(objCase.Id != null)
        {
            SFDC_Support_Case__c objTempCase = new SFDC_Support_Case__c();
            objTempCase = ObjCase;
            ObjCase = new SFDC_Support_Case__c();
            ObjCase.Caller_SSO_ID__c = objTempCase.Caller_SSO_ID__c; 
            ObjCase.Priority__c = objTempCase.Priority__c; 
            ObjCase.Issue_Details__c = objTempCase.Issue_Details__c; 
            ObjCase.Type__c = objTempCase.Type__c; 
            ObjCase.Quote_Number__c = objTempCase.Quote_Number__c ; 
            ObjCase.Record_Affected__c = objTempCase.Record_Affected__c ; 
            ObjCase.People_Affected__c = objTempCase.People_Affected__c ; 
        }
        if(objCase.Quote_Number__c != null || objCase.Quote_Number__c != '')
        {
            strAffectedRecord = 'Quoted Affected : '+objCase.Quote_Number__c;
        }
        if(objCase.Record_Affected__c != null || objCase.Record_Affected__c != '')
        {
            strAffectedRecord = 'SFDC Record Affected : '+objCase.Record_Affected__c;
        }
        if(objCase.People_Affected__c != null || objCase.People_Affected__c != '')
        {
            strAffectedPeople = 'People Affected : '+objCase.People_Affected__c;
        }
        String strOpenCI = '';
        String strPriority = '';
        String strAssignmentGroup = '';
        
        System.debug('attachment========'+attachment);
        System.debug('objCase.Caller_SSO_ID__c========'+objCase.Caller_SSO_ID__c);
        
        userLoggedIn = [Select Id, Email, GE_HQ_SSO_ID__c from User where Id=: objCase.Caller_SSO_ID__c ];
        strUserSSOId = userLoggedIn.GE_HQ_SSO_ID__c ;
        
        System.debug('strUserSSOId ===='+strUserSSOId + 'strBusiness ====='+strBusiness +'objCase.Type__c===='+objCase.Type__c+'objCase.Priority__c===='+objCase.Priority__c+'strApplication ====='+strApplication );
         if(strUserSSOId == '' || strBusiness == '' || strBusiness == null || objCase.Type__c == '' || objCase.Type__c == null || objCase.Priority__c == null  || objCase.Issue_Details__c == null || objCase.Issue_Details__c == '' || objCase.Short_Description__c == null || objCase.Short_Description__c == '')
         {
             System.debug('HEllo');
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'All fields are mandatory');
             ApexPages.addMessage(myMsg);
           return null;
         }
         else
         {
             try{
                
                objCase.Business_Tier__c = strBusiness;
                // set Open CI
                if(strApplication == 'Salesforce')
                {
                    strAssignmentGroup = '@OIL & GAS IT Configuration Team';
                    if(objCase.Business_Tier__c == 'Downstream Technology Solutions')    
                    {
                        strOpenCI = 'ogsfdc-dts';
                    }
                    else if(objCase.Business_Tier__c == 'Turbomachinery Solutions')
                    {
                        strOpenCI = 'ogsfdc-tms'; 
                    }
                    else if(objCase.Business_Tier__c == 'Surface')
                    {
                        strOpenCI = 'ogsfdc-d-and-s';
                    }
                    else if(objCase.Business_Tier__c == 'Subsea & Drilling')
                    {
                        strOpenCI = 'ogsfdc-ss';
                    }
                    else if(objCase.Business_Tier__c == 'Digital Solutions')
                    {
                        strOpenCI = 'ogsfdc-m-and-c';
                    }
                    else if(objCase.Business_Tier__c == 'PII Pipeline Solutions')
                    {
                        strOpenCI = 'ogsfdc-pii';
                    }
                    else if(objCase.Business_Tier__c == 'Lufkin')
                    {
                        strOpenCI = 'ogsfdc-lufkin';
                    }
                   else if(objCase.Business_Tier__c == 'HQ')
                    {
                        strOpenCI = 'sfdc-og';
                    }
                }
                else if(strApplication == 'Bigmachines')
                {
                    strAssignmentGroup = '@OIL & GAS IT Configuration Team';
                    //strOpenCI = 'OGBIGMACHINE-M&C';
                    if(objCase.Business_Tier__c == 'Surface')
                    {
                        strOpenCI = 'ogbigmachine-d-and-s';
                    }
                    else if(objCase.Business_Tier__c == 'Subsea & Drilling')
                    {
                        strOpenCI = 'ogbigmachine-ss';
                    }
                    else if(objCase.Business_Tier__c == 'Digital Solutions')
                    {
                        strOpenCI = 'ogbigmachine-m-and-c';
                    }
                }
                else if(strApplication == 'Servicemax')
                {
                    strAssignmentGroup = '@OIL & GAS IT Configuration Team';
                    if(objCase.Business_Tier__c == 'Digital Solutions')
                    {
                        strOpenCI = 'ogservicemax-m-and-c';
                    }
                    else if(objCase.Business_Tier__c == 'Surface')
                    {
                        strOpenCI = 'ogservicemax-d-and-s';
                    }
                    else if(objCase.Business_Tier__c == 'Subsea & Drilling')
                    {
                        strOpenCI = 'ogservicemax-subsea';
                    }
                    else if(objCase.Business_Tier__c == 'Turbomachinery Solutions')
                    {
                        strOpenCI = 'ogservicemax-tms';
                    }
                    else if(objCase.Business_Tier__c == 'Downstream Technology Solutions')
                    {
                        strOpenCI = 'ogservicemax-dts';
                    }
                    
                }
                else
                {
                    strAssignmentGroup = '@OIL & GAS IT Configuration Team';
                    strOpenCI = 'sfdc-og'; // for all other Business and Applications
                }
                
                // set Priority strPriority 
                if(objCase.Type__c == 'BreakFix')
                {
                    if(objCase.Priority__c == 'Urgent')
                    {
                        strPriority = 'P2';
                    }
                    else
                    {
                        strPriority = 'P3';
                    }
                }
                else
                {
                    strPriority = '';
                }
                if(objCase.Short_Description__c.Length() > 60){
                    objCase.Name = 'Helpdesk Ticket - ' + objCase.Short_Description__c.SubString(0,60);
                }
                else{
                    objCase.Name = 'Helpdesk Ticket - ' + objCase.Short_Description__c;
                }
                if(objCase.Short_Description__c!=NULL && objCase.Short_Description__c !='' ){
                    objCase.Short_Description__c = objCase.Short_Description__c.escapeXml();
                }
                else{
                    objCase.Short_Description__c=objCase.Short_Description__c;
                }
                objCase.Application__c = strApplication;
                objCase.User_SSO__c = strUserSSOId;
                objCase.Assignment_to_Workgroup_Name__c = strAssignmentGroup ;
                objCase.Open_CI_Search_Code__c = strOpenCI;
                objCase.TSG_Priority__c = strPriority ;
                insert objCase;
                System.debug('objCase========'+objCase+attachment.Name);
                if(attachment.Name != null && attachment.Name != '' && objCase.Id != null)
                {
                    //Folder folder = [select id from Folder where Id = '00lA0000000cNGuIAM'];
                    attachment.OwnerId = strLoggedInUserId ;
                    attachment.ParentId = objCase.Id;
                    //attachment.Body = this.fileBody;
        
                    insert attachment;
                    System.debug('attachment  -->>' + attachment.Id);
                }
                  
                strSucess = 'SUCCESS';
             }
             catch(DmlException e)
             {
                strSucess = 'FAILURE';
             }
             /*PageReference pg = new PageReference('/apex/OG_Support_Thank_You');
             pg.setRedirect(true);
             return pg;*/
             return null;
            
         }
         
         
         
        
     }  
     
     
  
  


     
     
     
     
     
     
     /*public PageReference useLinks()
     {
     System.debug('INNNNNN LINKS');
         objCase.Caller_SSO_ID__c = strUserSSOId;
         objCase.Issue_Details__c = 'User navigated to Links';
         try
         {
             insert objCase;
         }catch(Exception e){System.debug('EXCEPTION======'+e);}
         return null;
     }
     
     public PageReference redirectToSFDC()
     {
     System.debug('IPSITA');
         //useLinks();
         PageReference pg = new PageReference('https://idm.infra.ge.com/idm/user/');
         pg.setRedirect(true);
         System.debug('PPPPPPPPPPPPPPP'+pg);
         return pg;
     }
     public PageReference redirectToPartner()
     {
         useLinks();
         PageReference pg = new PageReference('http://supportcentral.ge.com/ProcessMaps/form_new_request.asp?prod_id=87486&form_id=292805&node_id=650590&map_id=&reference_id=&reference_type=');
         pg.setRedirect(true);
         return pg;
     }
     public PageReference redirectToChatter()
     {
         useLinks();
         PageReference pg = new PageReference('http://supportcentral.ge.com/ProcessMaps/form_new_request.asp?prod_id=87486&form_id=292805&node_id=650590&map_id=&reference_id=&reference_type=');
         pg.setRedirect(true);
         return pg;
     }
     public PageReference redirectToRiskApprover()
     {
         useLinks();
         PageReference pg = new PageReference('http://supportcentral.ge.com/ProcessMaps/form_new_request.asp?prod_id=87486&form_id=309453&node_id=719733&map_id=&reference_id=&reference_type=');
         pg.setRedirect(true);
         return pg;
     }*/

      
}