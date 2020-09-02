@istest(SeeAllData=false)
public class GE_OG_GS_Integration_Connection_Test {
    
    static testMethod void checkConnection(){
        
       test.startTest();
        
        // Create custom settings
        GE_OG_GS_WO_Update_Settings__c WO_Setting = new GE_OG_GS_WO_Update_Settings__c();
        WO_Setting.GE_OG_GS_API_Key__c = 'rnp6rwwx6ydr7hardat8mbup';
        WO_Setting.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/v1/gs/field-automation/publish/servicemax/work-order-event';
        insert (WO_Setting);
        
        
        GE_OG_GS_SSO_Auth_Setting__c SSO_Auth_Setting = new GE_OG_GS_SSO_Auth_Setting__c();
        SSO_Auth_Setting.GE_OG_GS_API_Key__c = 'rnp6rwwx6ydr7hardat8mbup';
        SSO_Auth_Setting.GE_OG_GS_API_Secret__c = 'Bdtt22uyDq';
        SSO_Auth_Setting.GE_OG_GS_API_URL__c = 'https://api.geoilandgas.com/v1/gs/hr/people';
        insert (SSO_Auth_Setting);
      
        GE_OG_GS_Integration_Connection_Check connectionTest = new GE_OG_GS_Integration_Connection_Check();
        
        Test.stopTest();
           
    }
}