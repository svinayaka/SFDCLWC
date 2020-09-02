@isTest 
public class Skuid_Home_Redirect_Controller_Test{
   /* public pagereference go(){
        return new pagereference('/apex/skuid__ui?page=GEOG_HomePage');
    }
    */
    
    static testMethod void checkGo() {
        PackageLicense pl = [SELECT Id FROM PackageLicense WHERE NamespacePrefix = 'skuid'];

        list<UserPackageLicense> lupl = [select id from userpackagelicense where userid = :userinfo.getuserid() and PackageLicenseId = :pl.id];
    
        if (lupl.size()==0){
            Skuid_Home_Redirect_Controller shrc = new Skuid_Home_Redirect_Controller();
            System.assertEquals(shrc.go().getURL(), '/home/home.jsp');
            
            UserPackageLicense upl = new UserPackageLicense(userid=userinfo.getuserid(), packagelicenseid=pl.id);
            insert upl;
            System.assertEquals(shrc.go().getURL(), '/apex/skuid__ui?page=GEOG_HomePage');
            
        }else{
            Skuid_Home_Redirect_Controller shrc = new Skuid_Home_Redirect_Controller();
            System.assertEquals(shrc.go().getURL(), '/apex/skuid__ui?page=GEOG_HomePage');
            
            delete lupl;
            
            System.assertEquals(shrc.go().getURL(), '/home/home.jsp');
        }
    

    }
    
    
}