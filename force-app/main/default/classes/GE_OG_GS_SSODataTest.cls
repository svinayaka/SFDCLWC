/*
 * Unit test class for SSODATA
 */
@isTest
public class GE_OG_GS_SSODataTest {
    
    public static testMethod void testData() {
        GE_OG_GS_SSOData sdata = new GE_OG_GS_SSOData();
        GE_OG_GS_SSOData.Person p = new GE_OG_GS_SSOData.Person();
        p.ITFSEExpatContract = new GE_OG_GS_SSOData.ITFSEExpatContract();
        
        String json = getTestResponse();
        GE_OG_GS_SSOData obj = GE_OG_GS_SSOData.parse(json);
        System.assert(obj != null);
        
        SVMXC__Service_Group_Members__c tech1 = new SVMXC__Service_Group_Members__c();
        SVMXC__Service_Group_Members__c tech2 = GE_OG_GS_Utility.mappSSODataToTechnician(tech1,obj);
        tech2 = GE_OG_GS_Utility.mappSSODataToTechnician(tech1,obj,'NonTMSPnL');
        
        try{
        String json2 = getTestResponse().replace('firstName', 'replacement');
        GE_OG_GS_SSOData obj2 = GE_OG_GS_SSOData.parse(json2);
        }catch(Exception e){}
    }
    
    
    /*
     * Sample response json data fro test
     */
    public static String getTestResponse(){
        String json = '{'+
        '    \"person\": {'+
        '        \"firstName\": \"Claudio\",'+
        '        \"lastName\": \"Celletti\",'+
        '        \"fullName\": \"Celletti, Claudio\",'+
        '        \"title\": \"dummyString\",'+
        '        \"gender\": \"dummyString\",'+
        '        \"sso\": \"212413527\",'+
        '        \"emailAddress\": \"Claudio.Celletti@ge.com\",'+
        '        \"dateOfBirth\": \"2014-01-01\",'+
        '        \"personType\": \"Employee Contractor\",'+
        '        \"dateFirstHired\": \"2014-01-01\",'+
        '        \"legalEntityHireDate\": \"2014-01-01\",'+
        '        \"actualTerminationDate\": \"2014-01-01\",'+
        '        \"organizationName\": \"OG-TMS-HQ-IM-OPS-FLD Field Services\",'+
        '        \"businessSegment\": \"OG-TMS Turbomachinery Solutions\",'+
        '        \"subBusiness\": \"OG-TMS-HQ Headquarters\",'+
        '        \"positionTitle\": \"IM Project Manager Business Solutions 5\",'+
        '        \"payrollName\": \"dummyString\",'+
        '        \"legalEntity\": \"Nuovo Pignone S.p.A.\",'+
        '        \"workLocationCountry\": \"Italy\",'+
        '        \"workLocationName\": \"Florence IT 5\",'+
        '        \"manager\": \"Lorenzi, Elena\",'+
        '        \"yearsOfService\": 0,'+
        '        \"CWSupplierCompany\": \"dummyString\",'+
        '        \"CWSupplierCode\": \"dummyString\",'+
        '        \"ITContractType\": \"dummyString\",'+
        '        \"ITContractStatus\": \"dummyString\",'+
        '        \"ITFSEExpatContract\": {'+
        '            \"foreignPlant\": \"dummyString\",'+
        '            \"country\": \"Italy\",'+
        '            \"zone\": \"dummyString\",'+
        '            \"location\": \"Florence\",'+
        '            \"effectiveStartDate\": \"2014-01-01\",'+
        '            \"effectiveEndDate\": \"2014-01-01\"'+
        '        }'+
        '    }'+
        '}';
        return json;
    }
    
}