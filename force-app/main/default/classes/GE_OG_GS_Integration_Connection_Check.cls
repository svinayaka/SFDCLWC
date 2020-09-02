public class GE_OG_GS_Integration_Connection_Check {
    /*  This class is tied to R-22098
*  This class will look for custom settings for ServiceMax GS integrations and if the environment is not production
*  check the custom setting and if it is pointing to production update the custom setting to point to the dev end point
*  Author: Matt Koshay 220009756 6/2015
* 
*  Test Coverage found in GE_OG_GS_Integration_Connection_Test
* */
    
    private String prod_url = 'api.geoilandgas.com/v1/gs';
    
    private String WO_UpdateAPIKey = 'k3kheh88fvu26wwfmx8ejfw2';
    private String WO_UpdateURL = 'https://stage.api.ge.com/geoilgas/api/dev/v1/gs/field-automation/publish/servicemax/work-order-event';
    
    private String Auth_API_Secret='26667c5441f7efc18c9166c476ca1111bf9adb1d';
    private String Auth_API_Key='k3kheh88fvu26wwfmx8ejfw2';
    private String Auth_URL ='https://stage.api.ge.com/geoilgas/api/dev/v1/gs/hr/people/';
    
    public GE_OG_GS_Integration_Connection_Check(){
        // run the method to check connections
        this.validateIntegrationConnections();
    }
    
    //Check if in sandbox or not:
    public Boolean isSandbox() {
        
        Boolean isSandbox = false;
        System.Debug('Current org URL: ' + URL.getSalesforceBaseUrl().getHost());
        System.Debug('Current org has .CS in it?: '+ URL.getSalesforceBaseUrl().getHost().contains('.cs'));
        
        // If the URL does NOT matche custom label of geog.my.salesforce.com 
        // and URL DOES contain .cs then set sandbox = true
        if(!URL.getSalesforceBaseUrl().getHost().equals(Label.GE_Oil_Gas_Production_URL)
           && URL.getSalesforceBaseUrl().getHost().contains('.cs')){
               isSandbox = true;
           }
        return isSandbox;
    } 
    
    public void validateIntegrationConnections(){
        // if the program is running in a sandbox
        if(isSandbox()){
            // check custom setting for GE OG GS WO Update Settings
            List<GE_OG_GS_WO_Update_Settings__c> WO_updateSetting = [SELECT GE_OG_GS_API_Key__c,GE_OG_GS_API_URL__c FROM GE_OG_GS_WO_Update_Settings__c Limit 1];
            if(WO_updateSetting.size() ==1){
                if (WO_updateSetting[0].GE_OG_GS_API_URL__c.contains(prod_url))
                {
                    System.debug('Found Production URL info; resetting API and URL to dev values');
                    WO_updateSetting[0].GE_OG_GS_API_Key__c = WO_UpdateAPIKey;
                    WO_updateSetting[0].GE_OG_GS_API_URL__c = WO_UpdateURL;
                    update(WO_updateSetting);
                }                
            }
            else
                System.debug('Did not find the GE OG GS WO Update Settings custom setting in the system');
            
            // check custom setting for SSO Auth Setting custom setting
            List<GE_OG_GS_SSO_Auth_Setting__c> SSOAuth = [SELECT GE_OG_GS_API_Key__c,GE_OG_GS_API_Secret__c,GE_OG_GS_API_URL__c FROM GE_OG_GS_SSO_Auth_Setting__c limit 1];
            if(SSOAuth.size()==1){
                if(SSOAuth[0].GE_OG_GS_API_URL__c.contains(prod_url)){
                    System.debug('Found Production URL info for SSO Auth Setting custom setting; resetting to dev values');    
                    SSOAuth[0].GE_OG_GS_API_Key__c=Auth_API_Key;
                    SSOAuth[0].GE_OG_GS_API_Secret__c=Auth_API_Secret;
                    SSOAuth[0].GE_OG_GS_API_URL__c=Auth_URL;
                    update(SSOAuth);
                }
            }
            else 
                System.debug('Did not find the SSO Auth Setting custom setting in the system');
            
        }// end if sandbox
        else{
            System.debug('Process not running - production sandbox detected');
        }
    }
    
}