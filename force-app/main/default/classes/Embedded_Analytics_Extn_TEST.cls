@isTest
Public class Embedded_Analytics_Extn_TEST {

    Static testmethod void  EmbedAnalExt1(){
    /* try{
    GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
    Account accObj= new Account();
    accObj.Name='Test Acc';  
    accObj.GE_PW_Country_Quote_To_Sold_To_HQ__c ='UNITED STATES';
    accObj.GE_HQ_Request_Status__c='CMF Approved';
    accObj.GE_HQ_KYC_Complete__c=TRUE;
    accObj.GE_PRM_KYC_Completed__c=TRUE;
    accObj.GE_HQ_DUNS_Number__c='GEGUL1863';  
    insert accObj;

    GE_HQ_Account_Plan__c obj = new GE_HQ_Account_Plan__c();
    obj.name = 'Test Ac plan';
    obj.GE_HQ_DDUNS_Number__c = accObj.Id;
    obj.GE_HQ_Buss_Tier__c = 'Oil & Gas (O&G)';
    obj.GE_OG_Tier_2_P_L__c = 'Drilling & Surface (D&S)';
    obj.GE_OG_Tier_3_P_L__c = '';
    insert obj;

    GE_HQ_Account_Plan__c AccPlan = Test_GE_OG_AccountPlan_Handler.createAccountPlan();
    System.assertEquals(AccPlan.name,'TestMeth');
    update AccPlan;
    String reportId;
    List <Report> reportList = [SELECT Id,DeveloperName FROM Report where
    DeveloperName = 'OG_Forecast_by_PL_Current_Year'];

    reportId = (String)reportList.get(0).get('Id');

    Reports.ReportMetadata reportMetadata =
    Reports.ReportManager.describeReport(reportId).getReportMetadata();

    Reports.ReportResults result =
    Reports.ReportManager.runReport(reportId,reportMetadata,false); 

    ApexPages.StandardController sc = new ApexPages.StandardController(AccPlan);
    Embedded_Analytics_Extn EAE = new Embedded_Analytics_Extn(sc);
    EAE.Report7Id='String1';
    EAE.Report7Name='String2';
    EAE.Report8Id='String3';
    EAE.Report8Name='String4';
    EAE.Report9Id='String5';
    EAE.Report9Name='String6';
    EAE.Report10Id='String7';
    EAE.Report10Name='String8';
    EAE.Report11Id='String9';
    EAE.Report11Name='String0';
    EAE.Report12Id='String12';
    EAE.Report12Name='String22';
    EAE.Report13Id='String32';
    EAE.Report13Name='String42';
    EAE.Report14Id='String52';
    EAE.Report14Name='String72';
    EAE.tier2='Drilling & Surface (D&S)';
    EAE.tier3='';
    EAE.accName=accObj.name;

    EAE.setTiers();}catch(Exception ex){}*/

Embedded_Analytics_Extn EAE = new Embedded_Analytics_Extn();

} 
}