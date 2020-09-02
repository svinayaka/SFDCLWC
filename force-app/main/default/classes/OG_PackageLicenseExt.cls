public class OG_PackageLicenseExt {

    private User theUser;
    private ApexPages.StandardController sc;
    public List<Package_License__c> licenseRecords {get; set;} 
    
    public OG_PackageLicenseExt (ApexPages.StandardController sc) {
        this.sc = sc;
        theUser = (User)sc.getRecord();
        
        licenseRecords = new List<Package_License__c>();
        licenseRecords = [select name, Package__r.Name, Active_License__c, Package_License_Type__c, SFDC_License_Type__c, CreatedDate, LastModifiedDate 
                          from Package_License__c  where user__c = :theUser.Id order by Package__r.Name asc limit 1000];
    }
    
}