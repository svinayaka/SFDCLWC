/*
 * Call sso middleware web service
 * This class will be invoked using javascript btn
 * It will get sso data from middlerware and update to technician object.
 */ 
global class GE_OG_GS_CallGetSSOResource {
  
    /*
     * Call sso resource
     * parse sso data using SSOData wrapper class
     * map it to technician onject
     * update technician record.
     * Return success or failure as result.
     */
    webservice static string execute(String ssoId,String technicianId){
        SVMXC__Service_Group_Members__c technician = new SVMXC__Service_Group_Members__c();
        String status = '';
        try{
            if(String.isBlank(ssoId)){
                throw new GE_OG_GS_SSOException('Please enter sso id');
            }
            GE_OG_GS_GetSSOResource resource = new GE_OG_GS_GetSSOResource(ssoId);
            String response =  resource.invoke();
            //IT-FSE-ExpatContract replace with ITFSEExpatContract for proper parsing
            response = response.replace('IT-FSE-ExpatContract', 'ITFSEExpatContract');
            GE_OG_GS_SSOData sdata = GE_OG_GS_SSOData.parse(response);
            system.debug(LoggingLevel.INFO,'ssodata = '+sdata);
            // map sso data to technician object and update
            technician = GE_OG_GS_Utility.mappSSODataToTechnician(technician,sdata);
            technician.Id = technicianId;
            update technician;
            status =  'Success';
        }Catch(GE_OG_GS_SSOException e){ 
            status = e.getMessage();
        }Catch(Exception e){
            status = e.getMessage();
        }
        return status;
    }       
}