@istest
public class OG_PackageLicenseExtTest {

    public static testmethod void runPackageExtTest(){
        
        System.Test.startTest();
        User usr = new User();
        ApexPages.StandardController sc = new ApexPages.StandardController (usr);
        PageReference newPackagePage = Page.OG_PackageLicense;
        Test.setCurrentPage(newPackagePage);
        OG_PackageLicenseExt nce = new OG_PackageLicenseExt(sc);
        System.Test.stopTest();
    }
        
}