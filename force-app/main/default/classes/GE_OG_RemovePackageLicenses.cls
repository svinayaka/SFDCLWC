global class GE_OG_RemovePackageLicenses implements Database.Batchable<sObject>
{
public integer count=0;

global Set<Id> userIdLst = new Set<Id>();
global Set<Id> PackageIdLst = new Set<Id>();
global Set<String> packageIdSet= new Set<String>();

global Database.QueryLocator start(Database.BatchableContext BC) {
String query = 'Select Username, Id, Name, Profile.Name, IsActive, LastLoginDate FROM User where IsActive=False AND ( NOT (Profile.Name LIKE\'%Chatter%\'))' ;
if(Test.isRunningTest())
{
query += ' Limit 1';
}

return Database.getQueryLocator(query); 
 }
 
 global void execute(Database.BatchableContext BC, List<User> Users) {

List<Package_License__c> LicensesToDelete = new List<Package_License__c>();   
     

system.debug('userslist **********'+Users);
try {
     if(Users.size()>0){
     
map<string,Package_License_List__c> m_package; 
m_package = Package_License_List__c.getAll();

for(Package_License_List__c mp : m_package.values()){
                String[] PackageIds = mp.Package_License_Ids__c.split(';');
                for(String i : PackageIds)
                    packageIdSet.add(i);
            }
     system.debug('packageIdSet*******'+packageIdSet);
       
     List<PackageLicense> LicenseList = [SELECT Id, NamespacePrefix FROM PackageLicense WHERE Id IN:packageIdSet ]; 
     system.debug('LicenseList******'+LicenseList);
     if(LicenseList.size() > 0){
     List<UserPackageLicense> packageLcs = [SELECT Id,UserId,PackageLicense.Id FROM UserPackageLicense WHERE UserId IN:Users AND PackageLicense.id IN:LicenseList ];
      system.debug('packageLcs*******'+packageLcs);

          if(packageLcs.size()> 0) {
            for(UserPackageLicense per :packageLcs ) {
               userIdLst.add(per.UserId);
               PackageIdLst.add(per.PackageLicense.Id);

            }
               delete packageLcs;

           }  
           }
           

           count++;
           system.debug('userIdLst*******'+userIdLst);



         
      }
    }
    catch(Exception e)
    {
       system.debug('Exception ***'+e);
    }

}

 global void finish(Database.BatchableContext BC)
        {
    
        }
 
 
 
 


}