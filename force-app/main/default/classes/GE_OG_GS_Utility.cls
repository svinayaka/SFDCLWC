public class GE_OG_GS_Utility {
    
    /*
* Map sso data to technician object
* MJM 2014-02-25: added new field to mapping GE_OG_MC_Supervisor_E_mail__c =p.managerEmail;
*/
    public static SVMXC__Service_Group_Members__c mappSSODataToTechnician(SVMXC__Service_Group_Members__c technician,
                                                                          GE_OG_GS_SSOData sdata)
    {
        GE_OG_GS_SSOData.Person p = sdata.Person;
        GE_OG_GS_SSOData.ITFSEExpatContract it = sdata.Person.ITFSEExpatContract;                                                                     
        technician.GE_OG_GS_First_Name__c = p.firstName;
        System.debug('first name: ' + p.firstName);
        technician.GE_OG_GS_Last_Name__c = p.lastName;
        technician.Name = p.firstName+' '+p.lastName;                                                                
        System.debug('Member name: ' + p.firstName+' '+p.lastName);
        technician.GE_OG_GS_Full_Name__c = p.fullName;
        technician.GE_OG_GS_Title__c = p.title;                                                                     
        technician.GE_OG_GS_Gender__c = p.gender;
        technician.SVMXC__Email__c = p.emailAddress;
        technician.GE_OG_GS_Birth_Date__c = p.dateOfBirth;
        technician.GE_OG_GS_Person_Type__c = p.personType;
        technician.GE_OG_GS_FS_Hiring_Date__c = p.dateFirstHired;
        technician.GE_OG_GS_Legal_Entity_Hire_Date__c = p.legalEntityHireDate;
        technician.GE_OG_GS_Actual_Termination_Date__c = p.actualTerminationDate;
        technician.GE_OG_GS_Organization_Name__c = p.organizationName;
        technician.GE_SM_HQ_Tier_1__c = p.businessSegment;
        technician.GE_SM_HQ_Tier_2__c = p.subBusiness;
        technician.GE_OG_GS_Position_Title__c = p.positionTitle;
        technician.GE_OG_GS_Payroll_Name__c = p.payrollName;
        technician.GE_OG_GS_Legal_Entity__c = p.legalEntity;
        technician.GE_OG_GS_Work_Location_Country__c = p.workLocationCountry; 
        technician.GE_OG_GS_Work_Location_Name__c = p.workLocationName;
        technician.SVMXC__Country__c = p.workLocationCountry;
        technician.GE_OG_DS_Supervisor_Name__c = p.manager;
        technician.GE_OG_MC_Supervisor_E_mail__c = p.managerEmail;
        technician.GE_OG_GS_length_of_service_years__c = p.yearsOfService;
        technician.GE_OG_GS_CW_Supplier_Company__c = p.CWSupplierCompany;
        technician.GE_OG_GS_CW_Supplier_Code__c = p.CWSupplierCode;
        technician.OG_GS_IT_Contract_Type__c = p.ITContractType;
        technician.GE_OG_GS_IT_Contract_Status__c = p.ITContractStatus;
        if(it != null){       
            technician.GE_OG_GS_Expat_Contract_Foreign_Plant__c = it.foreignPlant;
            technician.GE_OG_GS_Expat_Contract_Country__c = it.country;   
            technician.GE_OG_GS_Expat_Contract_Zone__c = it.zone; 
            technician.GE_OG_GS_Expat_Contract_Location__c = it.location; 
            technician.GE_OG_GS_Expat_Contract_Eff_Start_Date__c = it.effectiveStartDate; 
            technician.GE_OG_GS_Expat_Contract_Eff_End_Date__c = it.effectiveEndDate;  
        }                                                                                  
        return technician;                                                           
    }
    
    
    
    /* This function is a version of the mapping that will allow for P&L customization
     * As of now, the difference is that technician address will be mapped in this method
     * */     
    public static SVMXC__Service_Group_Members__c mappSSODataToTechnician(SVMXC__Service_Group_Members__c technician,
                                                                          GE_OG_GS_SSOData sdata,
                                                                         String p_pnl)
    {
        GE_OG_GS_SSOData.Person p = sdata.Person;
        GE_OG_GS_SSOData.ITFSEExpatContract it = sdata.Person.ITFSEExpatContract;                                                                     
        technician.GE_OG_GS_First_Name__c = p.firstName;
        System.debug('first name: ' + p.firstName);
        technician.GE_OG_GS_Last_Name__c = p.lastName;
        technician.Name = p.firstName+' '+p.lastName;                                                                
        System.debug('Member name: ' + p.firstName+' '+p.lastName);
        technician.GE_OG_GS_Full_Name__c = p.fullName;
        technician.GE_OG_GS_Title__c = p.title;                                                                     
        technician.GE_OG_GS_Gender__c = p.gender;
        technician.SVMXC__Email__c = p.emailAddress;
        technician.GE_OG_GS_Birth_Date__c = p.dateOfBirth;
        technician.GE_OG_GS_Person_Type__c = p.personType;
        technician.GE_OG_GS_FS_Hiring_Date__c = p.dateFirstHired;
        technician.GE_OG_GS_Legal_Entity_Hire_Date__c = p.legalEntityHireDate;
        technician.GE_OG_GS_Actual_Termination_Date__c = p.actualTerminationDate;
        technician.GE_OG_GS_Organization_Name__c = p.organizationName;
        technician.GE_SM_HQ_Tier_1__c = p.businessSegment;
        technician.GE_SM_HQ_Tier_2__c = p.subBusiness;
        technician.GE_OG_GS_Position_Title__c = p.positionTitle;
        technician.GE_OG_GS_Payroll_Name__c = p.payrollName;
        technician.GE_OG_GS_Legal_Entity__c = p.legalEntity;
        technician.GE_OG_GS_Work_Location_Country__c = p.workLocationCountry; 
        technician.GE_OG_GS_Work_Location_Name__c = p.workLocationName;
        technician.SVMXC__Country__c = p.workLocationCountry;
        if(p.workLocationAddressLine2!=null)
            technician.SVMXC__Street__c = p.workLocationAddressLine1 + ' ' + p.workLocationAddressLine2;
        else
            technician.SVMXC__Street__c = p.workLocationAddressLine1;
		technician.SVMXC__City__c = p.workLocationTownOrCity;
		technician.SVMXC__Zip__c = p.workLocationPostalCode;
        technician.SVMXC__Phone__c = p.work1PhoneNumber;
        technician.GE_OG_DS_Supervisor_Name__c = p.manager;
        technician.GE_OG_MC_Supervisor_E_mail__c = p.managerEmail;
        technician.GE_OG_GS_length_of_service_years__c = p.yearsOfService;
        technician.GE_OG_GS_CW_Supplier_Company__c = p.CWSupplierCompany;
        technician.GE_OG_GS_CW_Supplier_Code__c = p.CWSupplierCode;
        technician.OG_GS_IT_Contract_Type__c = p.ITContractType;
        technician.GE_OG_GS_IT_Contract_Status__c = p.ITContractStatus;
        if(it != null){       
            technician.GE_OG_GS_Expat_Contract_Foreign_Plant__c = it.foreignPlant;
            technician.GE_OG_GS_Expat_Contract_Country__c = it.country;   
            technician.GE_OG_GS_Expat_Contract_Zone__c = it.zone; 
            technician.GE_OG_GS_Expat_Contract_Location__c = it.location; 
            technician.GE_OG_GS_Expat_Contract_Eff_Start_Date__c = it.effectiveStartDate; 
            technician.GE_OG_GS_Expat_Contract_Eff_End_Date__c = it.effectiveEndDate;  
        }                                                                                  
        return technician;                                                           
    }
}