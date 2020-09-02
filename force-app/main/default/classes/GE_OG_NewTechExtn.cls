public class GE_OG_NewTechExtn {
    
    private ApexPages.StandardController sc;
    private SVMXC__Service_Group_Members__c technician;    
    private String erroMSG ;
    private static final String CONTRACTOR_TYPE = 'Contractor';
    private static final String EMPLOYEE_TYPE = 'Employee';
    private Set<String> m_pnl = new Set<String>{'AL','DNS','PC','SS','TMS-Emp','TMS-Cont','MNC','DTS'};
    private Set<String> availableTechTypes = new Set<String>();
    private boolean SSOpnl = false;
    
    public pagereference onloadpage(){
    
    return new PageReference('/apex/GE_OG_NewTech?pnl=DTS');
    }
        
        public void addCodeUtilization() 
    {
        
        
        //Instantiate the CCodeUtilization Class
        GE_CodeUtilization cu = new GE_CodeUtilization();
        
        //Class the insert insertCodeUtilization Method
        cu.insertCodeUtilization('GE_OG_NewTechExtn', 'Controller');
        cu.insertCodeUtilization(cu.captureVFPageName(), 'Visualforce Page');
         //return new PageReference('/apex/GE_OG_NewTech?pnl=DTS');
    }  
    
    public String business {
        get{
            if(apexpages.currentpage().getparameters().get('pnl')==null)
                business='';
            else if(m_pnl.contains(apexpages.currentpage().getparameters().get('pnl')))
                business = apexpages.currentpage().getparameters().get('pnl');
            else
                business ='';
            
            return business;
        }
        set;}
    
    public GE_OG_NewTechExtn (ApexPages.StandardController sc) {
        this.sc = sc;
        technician = (SVMXC__Service_Group_Members__c)sc.getRecord();
        technician.SVMXC__Enable_Scheduling__c=true;        
        if(business == 'TMS-Emp'){
            technician.RecordTypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.RecordTypeInfosByName.get('GE OG GS Employee').RecordTypeId;
            technician.SVMXC__Enable_Scheduling__c=false;
            System.debug('Setting TMS-Emp RT');
        }
        //system.debug('before DTS else if');
        else if (business == 'DTS'){ 
            system.debug('inside DTS else if');
            technician.RecordTypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.RecordTypeInfosByName.get('GE OG DTS Technician').RecordTypeId;
            system.debug('Record Id *******   '+technician.RecordTypeId);
            SSOpnl = true;
            technician.SVMXC__Enable_Scheduling__c=false;
            technician.GE_OG_DS_Sub_Org__c='GE OG DTS Technician';    
            System.debug('Setting DTS TS');
        }
        else if(business =='TMS-Cont'){
            technician.RecordTypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.RecordTypeInfosByName.get('GE OG GS Contractor').RecordTypeId;
            technician.SVMXC__Enable_Scheduling__c=false;
            System.debug('Setting TMS-Cont RT');
        }
        else if(business =='AL'){
            technician.RecordTypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.RecordTypeInfosByName.get('AL Technician/Equipment').RecordTypeId;
            SSOpnl = true;
            System.debug('Setting AL RT');
        }
        else if(business =='DNS'){
            technician.RecordTypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.RecordTypeInfosByName.get('GE OG D&S Technician/Equipment').RecordTypeId;
            SSOpnl = true;
            System.debug('Setting Drilling RT');
        }
        else if (business == 'PC'){
            technician.RecordTypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.RecordTypeInfosByName.get('GE OG PC Technician/Equipment').RecordTypeId;
            SSOpnl = true;
            System.debug('Setting PC RT');
        }
        else if (business == 'SS'){ 
            technician.RecordTypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.RecordTypeInfosByName.get('SubSea').RecordTypeId;
            SSOpnl = true;
            technician.GE_OG_DS_Sub_Org__c='SubSea';
            System.debug('Setting SS RT');
        }
        else if (business == 'MNC'){
            // M&C uses the master record type, so leaving RT as null, but the RT will default to whatever RT is set as default for the profile running the transaction
            System.debug('Setting Master (M&C) RT');
        }
        
        erroMSG = '';
        
        availableTechTypes = GetAvailableRecordTypeNamesForSObject(SVMXC__Service_Group_Members__c.SObjectType);
    }
    
    public PageReference save(){
        try{          
            if(String.isBlank(technician.GE_SM_HQ_SSO_ID__c)){
                throw new GE_OG_GS_SSOException('Please enter sso id');
            }
            
            GE_OG_GS_GetSSOResource resource = new GE_OG_GS_GetSSOResource(technician.GE_SM_HQ_SSO_ID__c);
            GE_OG_GS_SSOData sdata = GE_OG_GS_SSOData.parse(resource.invoke());
            
            if(business=='TMS-Emp' && sdata.Person.personType == CONTRACTOR_TYPE){throw new GE_OG_GS_SSOException(Label.GE_OG_GS_SSO_Contractor_not_Employee);
            }
            if(business=='TMS-Emp' && sdata.Person.personType != EMPLOYEE_TYPE){throw new GE_OG_GS_SSOException(Label.GE_OG_GS_Employee_Not_Found);
            }
            if(business=='TMS-Cont' && sdata.Person.personType == EMPLOYEE_TYPE){throw new GE_OG_GS_SSOException(Label.GE_OG_GS_SSO_is_Employee_not_Contractor);
            }
            if(business=='TMS-Cont' && sdata.Person.personType != CONTRACTOR_TYPE){throw new GE_OG_GS_SSOException(Label.GE_OG_GS_Contractor_Not_Found);
            }
            
            system.debug(LoggingLevel.INFO,'ssodata = '+sdata);
            
            // map sso data to technician object and update
            if(business == 'TMS-Cont' || business =='TMS-Emp')
              technician = GE_OG_GS_Utility.mappSSODataToTechnician(technician,sdata);
            else
                technician = GE_OG_GS_Utility.mappSSODataToTechnician(technician,sdata,'NonTMS');
            
            //try to set the Salesforce user for the technician if the P&L has technicians as SFDC users
            if(SSOpnl){
                setSFDCUser();
            }
            
            // check if user has permission to create a technician record
            if(Schema.sObjectType.SVMXC__Service_Group_Members__c.isCreateable())
                insert technician;
            else{
                GE_OG_GS_SSOException ee = new GE_OG_GS_SSOException('User does not have permissions to create technician record');
                throw ee;
            }      
            
            // If a Salesforce user could not be automaticaly mapped to the technician record, redirect to a VF page to inform the user
            if(SSOpnl && technician.SVMXC__Salesforce_User__c == null){
                String url = '/apex/GE_OG_NewTech_UsrNotFound?techId='+technician.Id;
                return new PageReference(url);
            }
            // otherwise, just take the user to the techican record
            else
                return new PageReference('/'+technician.Id);
            
        }Catch(GE_OG_GS_SSOException e){ 
            erroMSG = e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,erroMSG));
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,erroMSG = e.getMessage()));
        }
        return null;
    }
    
    public PageReference cancel(){
        Schema.DescribeSObjectResult r = SVMXC__Service_Group_Members__c.sObjectType.getDescribe();
        return new PageReference('/'+r.getKeyPrefix());
    }
    
    // Only give dropdown options that are applicable to the current users record type access on their profile
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();              
           options.add(new SelectOption('','--- None ---'));
        if(availableTechTypes.contains('AL Technician/Equipment'))
          options.add(new SelectOption('AL','Artificial Lift'));
        if(availableTechTypes.contains('GE OG D&S Technician/Equipment'))
            options.add(new SelectOption('DNS','Drilling'));
        if(availableTechTypes.contains('GE OG PC Technician/Equipment'))
          options.add(new SelectOption('PC','Pressure Control'));
        if(availableTechTypes.contains('SubSea'))
          options.add(new SelectOption('SS','Subsea'));
        if(availableTechTypes.contains('GE OG GS Employee'))
          options.add(new SelectOption('TMS-Emp','TMS Employee'));
        if(availableTechTypes.contains('GE OG GS Contractor'))
            options.add(new SelectOption('TMS-Cont','TMS Contractor'));
        if(availableTechTypes.size()==0)options.add(new SelectOption('MNC','Measurement & Control'));
        if(availableTechTypes.contains('GE OG DTS Technician'))
          options.add(new SelectOption('DTS','DTS'));
        
        return options;
    } 
   @TestVisible 
    private void setSFDCUser(){      
        List<User> users = [Select Id from User where GE_HQ_SSO_ID__c = : technician.GE_SM_HQ_SSO_ID__c];
        if(users.size()>0)
            technician.SVMXC__Salesforce_User__c = users[0].Id;
    }
    
    public Set<String> GetAvailableRecordTypeNamesForSObject(Schema.SObjectType objType) {
        Set<String> names = new Set<String>();
        List<RecordTypeInfo> infos = objType.getDescribe().getRecordTypeInfos();
        // If there are 2 or more RecordTypes...
        if (infos.size() > 1) {
            for (RecordTypeInfo i : infos) {
                if (i.isAvailable() 
                    // Ignore the Master Record Type, whose Id always ends with 'AAA'.
                    // We check the Id because Name can change depending on the user's language.
                    && !String.valueOf(i.getRecordTypeId()).endsWith('AAA'))
                    names.add(i.getName());
            }
        } 
        // Otherwise there's just the Master record type,
        // so add it in, since it MUST always be available
        else names.add(infos[0].getName());
        return names;
    }
}