@isTest
public class GE_OG_GS_NewEmployeeExtnTest {
    
    public static testmethod void testNewEmployee(){
        //Initialize sso auth setting 
        GE_OG_GS_SSO_Auth_Setting__c ssoAuth = new GE_OG_GS_SSO_Auth_Setting__c();
        ssoAuth.GE_OG_GS_API_Key__c = 'k3kheh88fvu26wwfmx8ejfw2';
        ssoAuth.GE_OG_GS_API_Secret__c = 'pxfN3mK5Aj';
        ssoAuth.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/dev/v1/gs/hr/people';
        insert ssoAuth;
        
        System.Test.startTest();
        SVMXC__Service_Group_Members__c emp = new SVMXC__Service_Group_Members__c();
        emp.GE_SM_HQ_SSO_ID__c = '12123234';
        ApexPages.StandardController sc = new ApexPages.StandardController (emp);
        PageReference newContractorPage = Page.GE_OG_GS_NewEmployee;
        Test.setCurrentPage(newContractorPage);
        GE_OG_GS_NewEmployeeExtn nce = new GE_OG_GS_NewEmployeeExtn(sc);
        nce.save();
        System.Test.stopTest();
    }
    
    public static testmethod void testNewEmployeeWithoutSSOID(){
        System.Test.startTest();
        SVMXC__Service_Group_Members__c emp = new SVMXC__Service_Group_Members__c();
        ApexPages.StandardController sc = new ApexPages.StandardController (emp);
        PageReference newContractorPage = Page.GE_OG_GS_NewEmployee;
        Test.setCurrentPage(newContractorPage);
        GE_OG_GS_NewEmployeeExtn nce = new GE_OG_GS_NewEmployeeExtn(sc);
        nce.save();
        nce.cancel();
        System.Test.stopTest();
    }
}