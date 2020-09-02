@isTest
public class SD_CurrentUserInfoCtrlTest {
    
     @isTest static void testmethod111(){
         String orgId = userInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
         Profile p = [SELECT Id FROM Profile WHERE Name='Service Delivery Dispatcher'];
        
        
        //1.Prepare Test User Record
        User u = new User();
            u.firstname = 'VijayaTest';
            u.lastName = 'MTest';
            u.email = uniqueName + '@test' + orgId + '.org';
            u.Username = uniqueName + '@test' + orgId + '.org';
            u.EmailEncodingKey = 'ISO-8859-1';
            u.Alias = uniqueName.substring(18, 23);
            u.TimeZoneSidKey = 'America/Los_Angeles';
            u.LocaleSidKey = 'en_US';
            u.LanguageLocaleKey = 'en_US';
            u.ProfileId = p.id;
        Insert u;
        SD_CurrentUserInfoCtrl.fetchUser();
    }
   
}