@isTest
public class seismicLicenseCheckTest {
    
    public static testmethod void testLicenseCheck(){
        
        PackageLicense packageId = new PackageLicense(); 
        packageId = [SELECT Id FROM PackageLicense where NamespacePrefix = 'Seismic' limit 1];
        
        List<UserPackageLicense> UPL = new List<UserPackageLicense>();
        UPL = [select Id, PackageLicenseId, UserId from UserPackageLicense where packagelicenseId =: packageId.Id limit 1];
        
        List<ID> passedIds = new List<ID>();
        if(UPL.size()>0){
            passedIds.add(UPL[0].UserId);
        }
        else
            passedIds.add('005A0000002DOfi');
        
        Test.startTest();
        
        List<Id> myList = seismicLicenseCheck.getUserIdsWithSeismicLicenses(passedIds);
        
        // negative scenario
        passedIds = new List<ID>{'005A00000000O00'};
            myList = seismicLicenseCheck.getUserIdsWithSeismicLicenses(passedIds);
        
        Test.stopTest();  
    }
    
}