@isTest
public class GE_OG_NewTechExtnTest {
    
    public static testmethod void testNewTech(){
        //Initialize sso auth setting 
        GE_OG_GS_SSO_Auth_Setting__c ssoAuth = new GE_OG_GS_SSO_Auth_Setting__c();
        ssoAuth.GE_OG_GS_API_Key__c = 'k3kheh88fvu26wwfmx8ejfw2';
        ssoAuth.GE_OG_GS_API_Secret__c = 'pxfN3mK5Aj';
        ssoAuth.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/dev/v1/gs/hr/people';
        insert ssoAuth;
        
        System.Test.startTest();
        SVMXC__Service_Group_Members__c emp1 = new SVMXC__Service_Group_Members__c();
        emp1.GE_SM_HQ_SSO_ID__c = '12123234';
        ApexPages.StandardController sc1 = new ApexPages.StandardController (emp1);
        PageReference newContractorPage1 = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage1);
        System.currentPageReference().getParameters().put('pnl', 'SS');
        GE_OG_NewTechExtn nce1 = new GE_OG_NewTechExtn(sc1);
        nce1.setSFDCUser();
        nce1.save();
        
        SVMXC__Service_Group_Members__c emp2 = new SVMXC__Service_Group_Members__c();
        emp2.GE_SM_HQ_SSO_ID__c = '12123235';
        ApexPages.StandardController sc2 = new ApexPages.StandardController (emp2);
        PageReference newContractorPage2 = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage2);
        System.currentPageReference().getParameters().put('pnl', 'DNS');
        GE_OG_NewTechExtn nce2 = new GE_OG_NewTechExtn(sc2);
        nce2.save();
        
        SVMXC__Service_Group_Members__c emp3 = new SVMXC__Service_Group_Members__c();
        emp3.GE_SM_HQ_SSO_ID__c = '12123236';
        ApexPages.StandardController sc3 = new ApexPages.StandardController (emp3);
        PageReference newContractorPage3 = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage3);
        System.currentPageReference().getParameters().put('pnl', 'TMS-Emp');
        GE_OG_NewTechExtn nce3 = new GE_OG_NewTechExtn(sc3);
        nce3.save();
        
        nce3.cancel();
       		
        SVMXC__Service_Group_Members__c emp4 = new SVMXC__Service_Group_Members__c();
        emp4.GE_SM_HQ_SSO_ID__c = '12123237';
        ApexPages.StandardController sc4 = new ApexPages.StandardController (emp4);
        PageReference newContractorPage4 = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage4);
		System.currentPageReference().getParameters().put('pnl', 'PC');
        GE_OG_NewTechExtn nce4 = new GE_OG_NewTechExtn(sc4);
        nce4.save();
        
        SVMXC__Service_Group_Members__c emp5 = new SVMXC__Service_Group_Members__c();
        emp5.GE_SM_HQ_SSO_ID__c = '12123238';
        ApexPages.StandardController sc5 = new ApexPages.StandardController (emp5);
        PageReference newContractorPage5 = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage5);
        System.currentPageReference().getParameters().put('pnl', 'AL');
        GE_OG_NewTechExtn nce5 = new GE_OG_NewTechExtn(sc5);
        nce5.save();
        nce5.business='AL';
        String l_business = nce5.business;
        List<SelectOption> options = nce5.getItems();
        nce5.addCodeUtilization();
        
        SVMXC__Service_Group_Members__c emp6 = new SVMXC__Service_Group_Members__c();
        emp6.GE_SM_HQ_SSO_ID__c = '12123558';
        ApexPages.StandardController sc6 = new ApexPages.StandardController (emp6);
        PageReference newContractorPage6 = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage6);
        System.currentPageReference().getParameters().put('pnl', 'TMS-Cont');
        GE_OG_NewTechExtn nce6 = new GE_OG_NewTechExtn(sc6);
        nce6.save();
        
        SVMXC__Service_Group_Members__c emp7 = new SVMXC__Service_Group_Members__c();
        emp7.GE_SM_HQ_SSO_ID__c = '12124448';
        ApexPages.StandardController sc7 = new ApexPages.StandardController (emp7);
        PageReference newContractorPage7 = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage7);
        System.currentPageReference().getParameters().put('pnl', 'MNC');
        GE_OG_NewTechExtn nce7 = new GE_OG_NewTechExtn(sc7);
        nce7.save();
        
        SVMXC__Service_Group_Members__c emp8 = new SVMXC__Service_Group_Members__c();
        emp8.GE_SM_HQ_SSO_ID__c = '12121118';
        ApexPages.StandardController sc8 = new ApexPages.StandardController (emp8);
        PageReference newContractorPage8 = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage8);
        GE_OG_NewTechExtn nce8 = new GE_OG_NewTechExtn(sc8);
        nce8.save();
        
        SVMXC__Service_Group_Members__c emp9 = new SVMXC__Service_Group_Members__c();
        emp7.GE_SM_HQ_SSO_ID__c = '72124455';
        ApexPages.StandardController sc9 = new ApexPages.StandardController (emp9);
        PageReference newContractorPage9 = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage9);
        System.currentPageReference().getParameters().put('pnl', 'DTS');
        GE_OG_NewTechExtn nce9 = new GE_OG_NewTechExtn(sc9);
        nce9.save();
        
        nce9.onloadpage();
        
        System.Test.stopTest();
    }
    
    public static testmethod void testNewTechWithoutSSOID(){
        System.Test.startTest();
        SVMXC__Service_Group_Members__c emp = new SVMXC__Service_Group_Members__c();
        ApexPages.StandardController sc = new ApexPages.StandardController (emp);
        PageReference newContractorPage = Page.GE_OG_NewTech;
        Test.setCurrentPage(newContractorPage);
        GE_OG_GS_NewEmployeeExtn nce = new GE_OG_GS_NewEmployeeExtn(sc);
        nce.save();
        nce.cancel();
        System.Test.stopTest();
    }
}