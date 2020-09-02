/*
 * Unit test class for CallGetSSOResource
 */
@isTest
public class GE_OG_GS_CallGetSSOResourceTest {
    
    /*
     * test CallGetResource 
     */
    public static testmethod void testCallGetResource(){
        //Initialize sso auth setting 
        GE_OG_GS_SSO_Auth_Setting__c ssoAuth = new GE_OG_GS_SSO_Auth_Setting__c();
        ssoAuth.GE_OG_GS_API_Key__c = 'k3kheh88fvu26wwfmx8ejfw2';
        ssoAuth.GE_OG_GS_API_Secret__c = 'pxfN3mK5Aj';
        ssoAuth.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/dev/v1/gs/hr/people';
        insert ssoAuth;
        
        //Create test data for technician
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c(Name = 'Team 2 - East');
        sg.SVMXC__Group_Code__c = 'T2E';
        sg.SVMXC__Group_Type__c = 'Internal';
        sg.SVMXC__Active__c = true;
        sg.SVMXC__Description__c = 'test Eastern team of specialists';
        insert sg;
        
        SVMXC__Service_Group_Members__c technician = new SVMXC__Service_Group_Members__c();
        technician.SVMXC__Service_Group__c = sg.Id;
        technician.Name  = 'Test technician';
        technician.GE_SM_HQ_SSO_ID__c = '1213424234';
        technician.SVMXC__Active__c = true;
        technician.SVMXC__Role__c = 'Service Engineer';
        //insert technician;
        
        System.Test.startTest();
        GE_OG_GS_CallGetSSOResource.execute('1213424234', 'technician.Id');        
        System.Test.stopTest();
    }
    
    /*
     * test CallGetResource 
     */
    public static testmethod void testCallGetResourceNioSSOID(){
        System.Test.startTest();
        GE_OG_GS_CallGetSSOResource.execute('', 'technician.Id');        
        System.Test.stopTest();
    }
}