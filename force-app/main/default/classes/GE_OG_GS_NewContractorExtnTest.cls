@isTest
public class GE_OG_GS_NewContractorExtnTest {
    
    public static testmethod void testNewContractor(){
        //Initialize sso auth setting 
        GE_OG_GS_SSO_Auth_Setting__c ssoAuth = new GE_OG_GS_SSO_Auth_Setting__c();
        ssoAuth.GE_OG_GS_API_Key__c = 'k3kheh88fvu26wwfmx8ejfw2';
        ssoAuth.GE_OG_GS_API_Secret__c = 'pxfN3mK5Aj';
        ssoAuth.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/dev/v1/gs/hr/people';
        insert ssoAuth;
        
        System.Test.startTest();
        SVMXC__Service_Group_Members__c contractor = new SVMXC__Service_Group_Members__c();
        contractor.GE_SM_HQ_SSO_ID__c = '12123234';
        ApexPages.StandardController sc = new ApexPages.StandardController (contractor);
        PageReference newContractorPage = Page.GE_OG_GS_NewContractor;
        Test.setCurrentPage(newContractorPage);
        GE_OG_GS_NewContractorExtn nce = new GE_OG_GS_NewContractorExtn(sc);
        nce.save();
        nce.cancel();
        System.Test.stopTest();
    }
    
    public static testmethod void testNewContractorWithoutSSOID(){
        //Initialize sso auth setting 
        GE_OG_GS_SSO_Auth_Setting__c ssoAuth = new GE_OG_GS_SSO_Auth_Setting__c();
        ssoAuth.GE_OG_GS_API_Key__c = 'k3kheh88fvu26wwfmx8ejfw2';
        ssoAuth.GE_OG_GS_API_Secret__c = 'pxfN3mK5Aj';
        ssoAuth.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/dev/v1/gs/hr/people';
        insert ssoAuth;
        
        System.Test.startTest();
        SVMXC__Service_Group_Members__c contractor = new SVMXC__Service_Group_Members__c();
        ApexPages.StandardController sc = new ApexPages.StandardController (contractor);
        PageReference newContractorPage = Page.GE_OG_GS_NewContractor;
        Test.setCurrentPage(newContractorPage);
        GE_OG_GS_NewContractorExtn nce = new GE_OG_GS_NewContractorExtn(sc);
        nce.save();
        System.Test.stopTest();
    }
}