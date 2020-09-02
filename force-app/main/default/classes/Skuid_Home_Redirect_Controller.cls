public class Skuid_Home_Redirect_Controller{
    public pagereference go(){
        if (userinfo.isCurrentUserLicensed('skuid'))
            return new pagereference('/apex/skuid__ui?page=GEOG_HomePage');
        else
            return new pagereference('/home/home.jsp');            
    }
}