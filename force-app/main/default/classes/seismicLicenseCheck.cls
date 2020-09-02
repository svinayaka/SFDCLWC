// Tied to R-29739
// Used by SKUID to check if a user has a Seismic license or not.

public class seismicLicenseCheck {
    
    @InvocableMethod(label='Check for Seismic License' description='Returns true or false if the User ID passed has a Seismic License or not.')
    public static List<Id> getUserIdsWithSeismicLicenses(List<ID> PassedUserIDs) {
        
        List<ID> UserIdsWithLicenses = new List<id>();
        
        PackageLicense packageId = new PackageLicense(); 
        packageId = [SELECT Id FROM PackageLicense where NamespacePrefix = 'Seismic' limit 1];
        
        List<UserPackageLicense> UPL = new List<UserPackageLicense>();
        
        if(PassedUserIDs != null && packageId != null){
            
            UPL = [select Id, PackageLicenseId, UserId from UserPackageLicense where packagelicenseId =: packageId.Id and UserId = : PassedUserIDs];
            
            for(UserPackageLicense u : UPL)
                UserIdsWithLicenses.add(u.UserId);
            
            System.debug('Number of records: ' + UserIdsWithLicenses.size());
            
        }
        
        System.debug('List of Users: ' + UserIdsWithLicenses);
        return UserIdsWithLicenses;
    }
    
    
    
}