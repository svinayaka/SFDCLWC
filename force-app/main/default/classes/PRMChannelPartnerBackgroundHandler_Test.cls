@isTest
public class PRMChannelPartnerBackgroundHandler_Test {
    static testMethod void riskRatingCalculationOnCPInsertTest(){
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
        
        GE_HQ_Country__c primarybankIsoCode1 = new GE_HQ_Country__c();                
        primarybankIsoCode1.GE_HQ_ISO_Code__c='IN';
        primarybankIsoCode1.name='INDIA';
        primarybankIsoCode1.GE_PRM_Channel_Risk_Type__c='High';
        primarybankIsoCode1.GE_PRM_Adverse_Termination_Risk__c = 28;
        insert primarybankIsoCode1;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp.id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Authorized_Countries_1__c = 'INDIA';
        comlinelst.add(prm_commline);
        insert comlinelst;
        
        PRM_Channel_Partner_Background__c cpbg = new PRM_Channel_Partner_Background__c();
        cpbg.PRM_Channel_Appointment__c = prm_chApp.id;
        cpbg.Year__c = string.valueOf(system.today().year());
        cpbg.Orders_Actual1__c = 10000000.00;
        cpbg.Target__c = 20000.00;
        cpbg.CurrencyIsoCode = 'USD';
        cpbg.PRM_CPB_Tier_2__c = 'Digital Solutions';
        cpList.add(cpbg);
        insert cpList;
        
        Test.startTest();
        PRMChannelPartnerBackgroundHandler_GE_OG obj = new PRMChannelPartnerBackgroundHandler_GE_OG();
        Test.stopTest();
    }
    
    static testMethod void riskRatingCalculationOnCPInsertTest1(){
        List<PRM_Channel_Partner_Background__c> cpList1 = new List<PRM_Channel_Partner_Background__c>();
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc2';
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc1.GE_HQ_Country_Code__c = 'AT'; 
        insert Acc1;
        //Account Acc1 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc2');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp1;
        
        GE_HQ_Country__c primarybankIsoCode1 = new GE_HQ_Country__c();                
        primarybankIsoCode1.GE_HQ_ISO_Code__c='AT';
        primarybankIsoCode1.name='AUSTRIA';
        primarybankIsoCode1.GE_PRM_Channel_Risk_Type__c='Medium';
        primarybankIsoCode1.GE_PRM_Adverse_Termination_Risk__c = 50;
        insert primarybankIsoCode1;
        
        PRM_Channel_Partner_Background__c cpbg1 = new PRM_Channel_Partner_Background__c();
        cpbg1.PRM_Channel_Appointment__c = prm_chApp1.id;
        cpbg1.Year__c = string.valueOf(system.today().year());
        cpbg1.Orders_Actual1__c = 8000000.00;
        cpbg1.Target__c = 20000.00;
        cpbg1.CurrencyIsoCode = 'USD';
        cpbg1.PRM_CPB_Tier_2__c = 'Digital Solutions';
        cpList1.add(cpbg1);
        insert cpList1;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp1.id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        comlinelst.add(prm_commline);
        insert comlinelst;
        
        Test.startTest();
        PRMChannelPartnerBackgroundHandler_GE_OG obj = new PRMChannelPartnerBackgroundHandler_GE_OG();
        obj.riskRatingCalculationOnCPInsert(cpList1);
        Test.stopTest();
    }
    
    static testMethod void riskRatingCalculationOnCPInsert2(){
        List<PRM_Channel_Partner_Background__c> cpLists = new List<PRM_Channel_Partner_Background__c>();
        List<PRM_Commercial_Line_GE_OG__c> comlinelsts = new List<PRM_Commercial_Line_GE_OG__c>();
        
        Account Acct = new Account();
        Acct.Name='Test Acct';
        Acct.Account_Status__c ='CC Approved';
        Acct.GE_HQ_New_Account_Country__c = 'INDIA'; 
        Acct.GE_HQ_Country_Code__c = 'IN'; 
        insert Acct;
        //Account Acct = CommonTestDataFactory_GE_OG.highRiskCountry('Test Acct');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApps = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApps.PRM_Account_Name__c = Acct.id;
        prm_chApps.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApps.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApps.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApps.PRM_Last_Compliance_Approved__c = system.today();
        insert prm_chApps;
        
        GE_HQ_Country__c primarybankIsoCode3 = new GE_HQ_Country__c();                
        primarybankIsoCode3.GE_HQ_ISO_Code__c='IN';
        primarybankIsoCode3.name = 'INDIA';
        primarybankIsoCode3.GE_PRM_Channel_Risk_Type__c = 'High';
        insert primarybankIsoCode3;
        
        PRM_Commercial_Line_GE_OG__c prm_commlines = new PRM_Commercial_Line_GE_OG__c();
        prm_commlines.PRM_Channel_Appointment__c = prm_chApps.id;
        prm_commlines.PRM_Status__c = 'Draft';
		prm_commlines.PRM_Authorized_Countries_1__c = 'INDIA';
        comlinelsts.add(prm_commlines);
        insert comlinelsts;

        PRM_Channel_Partner_Background__c cpbg3 = new PRM_Channel_Partner_Background__c();
        cpbg3.PRM_Channel_Appointment__c = prm_chApps.id;
        cpbg3.Year__c = string.valueOf(system.today().year());
        cpbg3.Orders_Actual1__c = 800000.00;
        cpbg3.Target__c = 8000000.00;
        cpbg3.CurrencyIsoCode = 'USD';
        cpbg3.PRM_CPB_Tier_2__c = 'Digital Solutions';
        cpLists.add(cpbg3);
        insert cpLists;

        Test.startTest();
        PRMChannelPartnerBackgroundHandler_GE_OG obj = new PRMChannelPartnerBackgroundHandler_GE_OG();
        obj.riskRatingCalculationOnCPInsert(cpLists);
        Test.stopTest();
    }
        
    static testMethod void riskRatingCalculationOnCPUpdate(){
        List<PRM_Channel_Partner_Background__c> cpList3 = new List<PRM_Channel_Partner_Background__c>();
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        
        Account Acc= new Account();
        Acc.Name='Test Acc3';
        Acc.Account_Status__c ='CC Approved';
        Acc.GE_HQ_New_Account_Country__c = 'INDIA'; 
        Acc.GE_HQ_Country_Code__c = 'IN'; 
        insert Acc;
        //Account Acc = CommonTestDataFactory_GE_OG.highRiskCountry('Test Acc3');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp.PRM_Account_Name__c = Acc.id;
        prm_chApp.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp.PRM_Primary_Bank_Account_Country__c = 'INDIA';
        insert prm_chApp;
        
        GE_HQ_Country__c primarybankIsoCode1 = new GE_HQ_Country__c();                
        primarybankIsoCode1.GE_HQ_ISO_Code__c='IN';
        primarybankIsoCode1.name='INDIA';
        primarybankIsoCode1.GE_PRM_Channel_Risk_Type__c='High';
        primarybankIsoCode1.GE_PRM_Adverse_Termination_Risk__c = 28;
        insert primarybankIsoCode1;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp.id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Authorized_Countries_1__c = 'INDIA';
        comlinelst.add(prm_commline);
        insert comlinelst;
        
        PRM_Channel_Partner_Background__c cpbg1 = new PRM_Channel_Partner_Background__c();
        cpbg1.PRM_Channel_Appointment__c = prm_chApp.id;
        cpbg1.Year__c = string.valueOf(system.today().year());
        cpbg1.Orders_Actual1__c = 8000000.00;
        cpbg1.Target__c = 20000.00;
        cpbg1.CurrencyIsoCode = 'USD';
        cpbg1.PRM_CPB_Tier_2__c = 'Digital Solutions';
        cpList3.add(cpbg1);
        insert cpList3;
        
        cpbg1.Orders_Actual1__c = 10000000.00;
        update cpbg1;
        cpList3.add(cpbg1);
        
        Test.startTest();
        PRMChannelPartnerBackgroundHandler_GE_OG obj = new PRMChannelPartnerBackgroundHandler_GE_OG();
        Test.stopTest();
    }
    
    static testMethod void riskRatingCalculationOnCPUpdate1(){
        List<PRM_Channel_Partner_Background__c> cpList4 = new List<PRM_Channel_Partner_Background__c>();
        List<PRM_Commercial_Line_GE_OG__c> comlinelst4 = new List<PRM_Commercial_Line_GE_OG__c>();
        
        Account Acc3 = new Account();
        Acc3.Name='Test Acc4';
        Acc3.Account_Status__c ='CC Approved';
        Acc3.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc3.GE_HQ_Country_Code__c = 'AT'; 
        insert Acc3;
        //Account Acc3 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc4');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp4 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp4.PRM_Account_Name__c = Acc3.id;
        prm_chApp4.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp4.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp4.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp4.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp4;
        
        GE_HQ_Country__c primarybankIsoCode1 = new GE_HQ_Country__c();                
        primarybankIsoCode1.GE_HQ_ISO_Code__c='AT';
        primarybankIsoCode1.name='AUSTRIA';
        primarybankIsoCode1.GE_PRM_Channel_Risk_Type__c='Medium';
        primarybankIsoCode1.GE_PRM_Adverse_Termination_Risk__c = 50;
        insert primarybankIsoCode1;
        
        PRM_Commercial_Line_GE_OG__c prm_commline4 = new PRM_Commercial_Line_GE_OG__c();
        prm_commline4.PRM_Channel_Appointment__c = prm_chApp4.id;
        prm_commline4.PRM_Status__c = 'Draft';
        prm_commline4.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        comlinelst4.add(prm_commline4);
        insert comlinelst4;

        PRM_Channel_Partner_Background__c cpbg1 = new PRM_Channel_Partner_Background__c();
        cpbg1.PRM_Channel_Appointment__c = prm_chApp4.id;
        cpbg1.Year__c = string.valueOf(system.today().year());
        cpbg1.Orders_Actual1__c = 8000000.00;
        cpbg1.Target__c = 20000.00;
        cpbg1.CurrencyIsoCode = 'USD';
        cpbg1.PRM_CPB_Tier_2__c = 'Digital Solutions';
        cpList4.add(cpbg1);
        insert cpList4;
        
		cpbg1.Target__c = 3000000.00; 
        update cpbg1;
        cpList4.add(cpbg1);
                
        Test.startTest();
        PRMChannelPartnerBackgroundHandler_GE_OG obj = new PRMChannelPartnerBackgroundHandler_GE_OG();
        obj.riskRatingCalculationOnCPInsert(cpList4);
        Test.stopTest();
    }
    
    static testMethod void riskRatingCalculationOnCPUpdate2(){
        List<PRM_Channel_Partner_Background__c> cpList5 = new List<PRM_Channel_Partner_Background__c>();
        List<PRM_Commercial_Line_GE_OG__c> comlinelst5 = new List<PRM_Commercial_Line_GE_OG__c>();
        
        Account Acc4 = new Account();
        Acc4.Name='Test Acc5';
        Acc4.Account_Status__c ='CC Approved';
        Acc4.GE_HQ_New_Account_Country__c = 'UNITED KINGDOM'; 
        Acc4.GE_HQ_Country_Code__c = 'GB'; 
        insert Acc4;
        //Account Acc4 = CommonTestDataFactory_GE_OG.lowRiskCountry('Test Acc5');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp5 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp5.PRM_Account_Name__c = Acc4.id;
        prm_chApp5.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp5.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp5.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp5.PRM_Last_Compliance_Approved__c = system.today();
        insert prm_chApp5;
        
        GE_HQ_Country__c primarybankIsoCode2 = new GE_HQ_Country__c();                
        primarybankIsoCode2.GE_HQ_ISO_Code__c='GB';
        primarybankIsoCode2.name = 'UNITED KINGDOM';
        primarybankIsoCode2.GE_PRM_Channel_Risk_Type__c = 'Low';
        primarybankIsoCode2.GE_PRM_Adverse_Termination_Risk__c = 12;
        insert primarybankIsoCode2;
        
        PRM_Commercial_Line_GE_OG__c prm_commline5 = new PRM_Commercial_Line_GE_OG__c();
        prm_commline5.PRM_Channel_Appointment__c = prm_chApp5.id;
        prm_commline5.PRM_Status__c = 'Draft';
		prm_commline5.PRM_Authorized_Countries_1__c = 'UNITED KINGDOM';
        comlinelst5.add(prm_commline5);
        insert comlinelst5;

        PRM_Channel_Partner_Background__c cpbg2 = new PRM_Channel_Partner_Background__c();
        cpbg2.PRM_Channel_Appointment__c = prm_chApp5.id;
        cpbg2.Year__c = string.valueOf(system.today().year());
        cpbg2.Orders_Actual1__c = 800000.00;
        cpbg2.Target__c = 8000000.00;
        cpbg2.CurrencyIsoCode = 'USD';
        cpbg2.PRM_CPB_Tier_2__c = 'Digital Solutions';
        cpList5.add(cpbg2);
        insert cpList5;
        
		cpbg2.Target__c = 10000000.00; 
        update cpbg2;
        cpList5.add(cpbg2);
                
        Test.startTest();
        PRMChannelPartnerBackgroundHandler_GE_OG obj = new PRMChannelPartnerBackgroundHandler_GE_OG();
        obj.riskRatingCalculationOnCPInsert(cpList5);
        Test.stopTest();
    }
}