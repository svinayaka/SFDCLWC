/*
Class/Trigger Name     : GEOGDirectory_Test
Used Where ?           : OG Directory
Purpose/Overview       : To cover the code for GE_OG_Directory_Report,GEOGDirectoryController
Functional Area        : Innovation 
Author                 : Prasanth Nalle
Created Date           : 04/06/2014
Test Class Name        : 
Code Coverage          : GEOGDirectoryController  - 100%
Code Coverage          : GEOGDirectoryController_Mobile  - 100%
Code Coverage          : GE_OG_Directory_Report  - 98%
Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
11/20/2014    : Prasad Yadala      : GEOGDirectoryController_Test(): Improve the code coverage
11/20/2014    : Prasad Yadala      : GE_OG_Directory_Report_Test() : Improve the code coverage
11/20/2014    : Prasad Yadala      : GEOGDirectoryController_Mobile_Test(): Improve the code coverage

*/

@isTest
public class GEOGDirectory_Test
{
    //method to provide code coverage for the controller GEOGDirectoryController
    static testMethod void GEOGDirectoryController_Test()
    {
        User us = new User(firstname = 'test', lastname = 'user', email = 'tstusrzy@ge.com',Site_Location__c='Banglore',
                           alias = 'chnUsr', profileId = '00eA0000000Ei50', Title = 'test user x123', Username = 'tstusrzy@ge.com', CommunityNickname = 'chusezy', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US',GE_HQ_Tier_1_P_L__c='Oil & Gas (O&G)',GE_HQ_Tier_2_P_L__c='DTS',GE_HQ_Tier_3_P_L__c='Salof',Function__c='Application Engineering',GE_DS_Country__c='India');
        insert us;
        Test.setCurrentPageReference(Page.GE_OG_Directory); 
        ApexPages.StandardController sc = new ApexPages.standardController(us);
        GEOGDirectoryController opc = new GEOGDirectoryController(sc);
        opc.getusrid();
        opc.regionKeyPlayerCall();
        opc.addCodeUtilization();
        //querying the inserted code utilization records
        for(GE_Code_Utilization__c cu: [select id,GE_Component_Name__c,GE_Component_type__c from GE_Code_Utilization__c])
        {
            if(cu.GE_Component_type__c == 'Controller')
            System.assertEquals(cu.GE_Component_Name__c,'GEOGDirectoryController');
            
        }
        
    }
    
    //method to provide code coverage for the controller GE_OG_Directory_Report
    public static testMethod void GE_OG_Directory_Report_Test()
    {
        
        //inserting delegate user
        User us = new User(firstname = 'test', lastname = 'user', email = 'tstusrzy@ge.com',Site_Location__c='Banglore',
                           alias = 'chnUsr', profileId = '00eA0000000Ei50', Title = 'test user x123', Username = 'tstusrzy@ge.com', CommunityNickname = 'chusezy', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US',GE_HQ_Tier_1_P_L__c='Oil & Gas (O&G)',GE_HQ_Tier_2_P_L__c='DTS',GE_HQ_Tier_3_P_L__c='Salof',Function__c='Application Engineering',GE_DS_Country__c='India');
        insert us;
        Test.setCurrentPageReference(Page.GEOGDirectoryReport);
        System.currentPageReference().getParameters().put('Function',us.Function__c);
        System.currentPageReference().getParameters().put('tier2',us.GE_HQ_Tier_2_P_L__c);        
        System.currentPageReference().getParameters().put('country','IN');
        System.currentPageReference().getParameters().put('tier3',us.GE_HQ_Tier_3_P_L__c);
        System.currentPageReference().getParameters().put('location',us.Site_Location__c);
        System.currentPageReference().getParameters().put('id1',us.id);
         
        ApexPages.StandardController sc = new ApexPages.standardController(us);
        GE_OG_Directory_Report GODR = new GE_OG_Directory_Report(sc);
        PageReference pageRef = GODR.Query();
        PageReference pageRef1 = GODR.getUserDetail();
        GODR.getusrid();
        GODR.getAllKeyPlayer();
        PageReference pg2 = GODR.backmethod();
        GODR.addCodeUtilization() ;
        
        System.currentPageReference().getParameters().put('tier3','');
        ApexPages.StandardController sc2 = new ApexPages.standardController(us);
        
        //querying the inserted code utilization records
        for(GE_Code_Utilization__c cu: [select id,GE_Component_Name__c,GE_Component_type__c from GE_Code_Utilization__c])
        {
            if(cu.GE_Component_type__c == 'Controller')
            System.assertEquals(cu.GE_Component_Name__c,'GE_OG_Directory_Report');
            
        }
        
    }
    
    //method to provide code coverage for the controller GEOGDirectoryController_Mobile
    static testMethod void GEOGDirectoryController_Mobile_Test()
    {
        User us = new User(firstname = 'test', lastname = 'user', email = 'tstusrzy@ge.com',Site_Location__c='Banglore',
                           alias = 'chnUsr', profileId = '00eA0000000Ei50', Title = 'test user x123', Username = 'tstusrzy@ge.com', CommunityNickname = 'chusezy', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US',GE_HQ_Tier_1_P_L__c='Oil & Gas (O&G)',GE_HQ_Tier_2_P_L__c='DTS',GE_HQ_Tier_3_P_L__c='Salof',Function__c='Application Engineering',GE_DS_Country__c='India');
        insert us;
        Test.setCurrentPageReference(Page.GE_OG_Directory_Mobile); 
        ApexPages.StandardController sc = new ApexPages.standardController(us);
        GEOGDirectoryController_Mobile opc = new GEOGDirectoryController_Mobile(sc);
        opc.getusrid();
        GE_HQ_Country__c c = new GE_HQ_Country__c(Name='Test Country',GE_HQ_ISO_Code__c='zz');
        insert c;
        opc.onLoadPage_Countries();
        opc.regionkeyplayercall();
        opc.addCodeUtilization();
        //querying the inserted code utilization records
        for(GE_Code_Utilization__c cu: [select id,GE_Component_Name__c,GE_Component_type__c from GE_Code_Utilization__c])
        {
            if(cu.GE_Component_type__c == 'Controller')
            System.assertEquals(cu.GE_Component_Name__c,'GEOGDirectoryController_Mobile');
            
        }
        
    }
    
}