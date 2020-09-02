@isTest
public class PRM_SubmitCommercialService_Test {
    static testMethod void riskRatingCalculationOnCLInsert(){
        
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        List<PRM_Channel_Partner_Background__c> cpList = new List<PRM_Channel_Partner_Background__c>();
        
        Account Acc= new Account();
        Acc.Name='Test Acc1';
        Acc.Account_Status__c ='CC Approved';
        Acc.GE_HQ_New_Account_Country__c = 'INDIA'; 
        Acc.GE_HQ_Country_Code__c = 'IN'; 
        insert Acc;
        //Account Acc = CommonTestDataFactory_GE_OG.highRiskCountry('Test Acc');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp.PRM_Account_Name__c = Acc.id;
        prm_chApp.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp.PRM_Primary_Bank_Account_Country__c = 'INDIA';
        insert prm_chApp;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp.id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Authorized_Countries_1__c = 'INDIA';
        insert prm_commline;
        PRM_Commercial_Line_GE_OG__c prm_commline2= new PRM_Commercial_Line_GE_OG__c();
        prm_commline2.PRM_Channel_Appointment__c = prm_chApp.id;
        prm_commline2.PRM_Status__c='Draft';
        prm_commline2.PRM_Authorized_Countries_1__c = 'INDIA';
        insert prm_commline2;
        String jSON = '{"inputs":[{"commLines":["'+prm_commline.Id+'","'+prm_commline2.Id+'"]}]}';
        String str= PRM_SubmitCommercialService.parse(jSON);
        
    }
    
}