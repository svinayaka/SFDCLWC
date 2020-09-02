public class GE_OG_GS_NewContractorExtn {
    
    private ApexPages.StandardController sc;
    private SVMXC__Service_Group_Members__c technician;    
    private String erroMSG ;
    private static final String CONTRACTOR_TYPE = 'Contractor';
    private static final String EMPLOYEE_TYPE = 'Employee';
    
    public GE_OG_GS_NewContractorExtn(ApexPages.StandardController sc) {
        this.sc = sc;
        technician = (SVMXC__Service_Group_Members__c)sc.getRecord();
        technician.RecordTypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.RecordTypeInfosByName.get('GE OG GS Contractor').RecordTypeId;
        erroMSG = '';
    }
    
    public PageReference save(){
        try{
            if(String.isBlank(technician.GE_SM_HQ_SSO_ID__c)){
                throw new GE_OG_GS_SSOException('Please enter sso id');
            }
            GE_OG_GS_GetSSOResource resource = new GE_OG_GS_GetSSOResource(technician.GE_SM_HQ_SSO_ID__c);
            GE_OG_GS_SSOData sdata = GE_OG_GS_SSOData.parse(resource.invoke());
            if(sdata.Person.personType == EMPLOYEE_TYPE){
                throw new GE_OG_GS_SSOException(Label.GE_OG_GS_SSO_is_Employee_not_Contractor);
            }
            if(sdata.Person.personType != CONTRACTOR_TYPE){
                throw new GE_OG_GS_SSOException(Label.GE_OG_GS_Contractor_Not_Found);
            }
            system.debug(LoggingLevel.INFO,'ssodata = '+sdata);
            // map sso data to technician object and update
            technician = GE_OG_GS_Utility.mappSSODataToTechnician(technician,sdata);
            return sc.save();
        }Catch(GE_OG_GS_SSOException e){ 
            erroMSG = e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,erroMSG));
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return null;
    }
    
    public PageReference cancel(){
        Schema.DescribeSObjectResult r = SVMXC__Service_Group_Members__c.sObjectType.getDescribe();
        return new PageReference('/'+r.getKeyPrefix());
    }
    
}