@isTest 
public class PRMChannelAppointmentHandler_Test {
    
    @testSetup static void setup() {
        List<PRM_Channel_Appointment_GE_OG__c> chApps = new List<PRM_Channel_Appointment_GE_OG__c>();
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        Map<ID,PRM_Channel_Appointment_GE_OG__c> chMap = new Map<ID,PRM_Channel_Appointment_GE_OG__c>();
        List<GE_HQ_Country__c> countryCode1 = new List<GE_HQ_Country__c>();
        
        Account Acct = new Account();
        Acct.Name = 'Unique Account';   
        Acct.Account_Status__c = 'CC Approved';
        Acct.GE_HQ_New_Account_Country__c = 'ALGERIA'; 
        Acct.GE_HQ_Country_Code__c = 'DZ';
        Acct.Account_Status__c = 'Active';
        insert Acct;
        
        Account Accts = new Account();
        Accts.Name = 'Unique Account1';   
        Accts.Account_Status__c = 'CC Approved';
        Accts.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Accts.GE_HQ_Country_Code__c = 'AT';
        Accts.Account_Status__c = 'Active';
        insert Accts;
        
        GE_HQ_Country__c primarybankIsoCode4 = new GE_HQ_Country__c();                
        primarybankIsoCode4.GE_HQ_ISO_Code__c = 'DZ';
        primarybankIsoCode4.name = 'ALGERIA';
        primarybankIsoCode4.GE_PRM_Channel_Risk_Type__c = 'High';
        primarybankIsoCode4.GE_PRM_Adverse_Termination_Risk__c = 10;
        countryCode1.add(primarybankIsoCode4);
        
        GE_HQ_Country__c primarybankIsoCode5 = new GE_HQ_Country__c();                
        primarybankIsoCode5.GE_HQ_ISO_Code__c = 'AO';
        primarybankIsoCode5.name = 'ANGOLA';
        primarybankIsoCode5.GE_PRM_Channel_Risk_Type__c = 'High';
        primarybankIsoCode5.GE_PRM_Adverse_Termination_Risk__c = 10;
        countryCode1.add(primarybankIsoCode5);
        
        GE_HQ_Country__c primarybankIsoCode6 = new GE_HQ_Country__c();                
        primarybankIsoCode6.GE_HQ_ISO_Code__c = 'AT';
        primarybankIsoCode6.name = 'AUSTRIA';
        primarybankIsoCode6.GE_PRM_Channel_Risk_Type__c = 'Medium';
        primarybankIsoCode6.GE_PRM_Adverse_Termination_Risk__c = 10;
        countryCode1.add(primarybankIsoCode6);
        insert countryCode1;
        
        PRM_Channel_Appointment_GE_OG__c prm_chAppt = new PRM_Channel_Appointment_GE_OG__c();
        prm_chAppt.PRM_Account_Name__c = Accts.id;
        prm_chAppt.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chAppt.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chAppt.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chAppt.PRM_Primary_Bank_Account_Country__c = 'AUSTRIA';
        insert prm_chAppt;
        
        PRM_Channel_Appointment_GE_OG__c prm_chApps = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApps.PRM_Account_Name__c = Acct.id;
        prm_chApps.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApps.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApps.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApps.PRM_Primary_Bank_Account_Country__c = 'ALGERIA';
        chApps.add(prm_chApps);
        insert chApps;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = chApps[0].id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Authorized_Countries_1__c = 'ANGOLA';
        comlinelst.add(prm_commline);

        PRM_Commercial_Line_GE_OG__c prm_commline4 = new PRM_Commercial_Line_GE_OG__c();
        prm_commline4.PRM_Channel_Appointment__c = prm_chAppt.id;
        prm_commline4.PRM_Status__c = 'Draft';
        prm_commline4.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        prm_commline4.PRM_Authorized_Countries_1__c = 'AUSTRIA';
        comlinelst.add(prm_commline4);
        insert comlinelst;
        
        
        PRM_Channel_Partner_Background__c cpbg = new PRM_Channel_Partner_Background__c();
        cpbg.PRM_Channel_Appointment__c = chApps[0].id;
        cpbg.Year__c = string.valueOf(system.today().year());
        cpbg.Orders_Actual1__c = 10000000.00;
        cpbg.Target__c = 20000.00;
        cpbg.CurrencyIsoCode = 'USD';
        cpbg.PRM_CPB_Tier_2__c = 'Digital Solutions';
        insert cpbg;
    }
    
    static testMethod void riskRatingCalculationOnCAInsertTest(){
        List<PRM_Channel_Appointment_GE_OG__c> chApp = new List<PRM_Channel_Appointment_GE_OG__c>();
        List<GE_HQ_Country__c> countryCode = new List<GE_HQ_Country__c>();
        List<Account> accList = new List<Account>();
        
        Account Acc= new Account();
        Acc.Name='Test Acc';   
        Acc.Account_Status__c ='CC Approved';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED KINGDOM'; 
        Acc.GE_HQ_Country_Code__c = 'GB'; 
        Acc.Account_Status__c = 'Active';
        accList.add(Acc);
        
        Account Acc1= new Account();
        Acc1.Name='Test Acc1';
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AFGHANISTAN'; 
        Acc1.GE_HQ_Country_Code__c = 'AF';
        Acc1.Account_Status__c = 'Active';
        accList.add(Acc1);
        
        Account Acc2 = new Account();
        Acc2.name = 'Test Acc2';
        Acc2.Account_Status__c ='CC Approved';
        Acc2.GE_HQ_New_Account_Country__c = 'UNITED STATES'; 
        Acc2.GE_HQ_Country_Code__c = 'US';
        Acc2.Account_Status__c = 'Active';
        accList.add(Acc2);
        //insert accList;
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp.PRM_Account_Name__c = Acc.id;
        prm_chApp.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp.PRM_Primary_Bank_Account_Country__c = 'INDIA';
        prm_chApp.PRM_Any_felony_or_crime__c = 'Yes';
        prm_chApp.PRM_Officers_Relatives_in_govt_positions__c = 'No';
        chApp.add(prm_chApp);
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp.PRM_Primary_Bank_Account_Country__c = 'AFGHANISTAN';
        prm_chApp1.PRM_Exclusivity_requested__c = 'Yes';
        prm_chApp1.PRM_Last_Compliance_Approved__c = system.today();
        chApp.add(prm_chApp1);
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp2 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp2.PRM_Account_Name__c = Acc2.id;
        prm_chApp2.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp2.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp2.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        chApp.add(prm_chApp2);
        
        GE_HQ_Country__c primarybankIsoCode = new GE_HQ_Country__c();                
        primarybankIsoCode.GE_HQ_ISO_Code__c='IN';
        primarybankIsoCode.name='INDIA';
        primarybankIsoCode.GE_PRM_Channel_Risk_Type__c='High';
        primarybankIsoCode.GE_PRM_Adverse_Termination_Risk__c = 31;
        countryCode.add(primarybankIsoCode);
        
        GE_HQ_Country__c primarybankIsoCode1 = new GE_HQ_Country__c();                
        primarybankIsoCode1.GE_HQ_ISO_Code__c='AF';
        primarybankIsoCode1.name='AFGHANISTAN';
        primarybankIsoCode1.GE_PRM_Channel_Risk_Type__c='High';
        primarybankIsoCode1.GE_PRM_Adverse_Termination_Risk__c = 28;
        countryCode.add(primarybankIsoCode1);
        
        GE_HQ_Country__c primarybankIsoCode2 = new GE_HQ_Country__c();                
        primarybankIsoCode2.GE_HQ_ISO_Code__c='US';
        primarybankIsoCode2.name='UNITED STATES';
        primarybankIsoCode2.GE_PRM_Channel_Risk_Type__c='Low';
        primarybankIsoCode2.GE_PRM_Adverse_Termination_Risk__c = 10;
        countryCode.add(primarybankIsoCode2);
        
        GE_HQ_Country__c primarybankIsoCode3 = new GE_HQ_Country__c();                
        primarybankIsoCode3.GE_HQ_ISO_Code__c = 'GB';
        primarybankIsoCode3.name = 'UNITED KINGDOM';
        primarybankIsoCode3.GE_PRM_Channel_Risk_Type__c = 'Low';
        primarybankIsoCode3.GE_PRM_Adverse_Termination_Risk__c = 10;
        countryCode.add(primarybankIsoCode3);
        insert countryCode;
        
        Test.startTest();
        insert accList;
        insert chApp;
        PRMChannelAppointmentHandler_GE_OG obj = new PRMChannelAppointmentHandler_GE_OG();
        obj.riskRatingCalculationOnCAInsert(chApp);
        Test.stopTest();
    }
    
    static testMethod void riskRatingCalculationOnCAUpdateTest(){
        List<ID> prmchApp_ID = new List<ID>();
        
        PRM_Channel_Appointment_GE_OG__c prm_chApps = [Select Id,Name from PRM_Channel_Appointment_GE_OG__c where PRM_Channel_Appointment_GE_OG__c.PRM_Account_Name__r.Name='Unique Account'];
        prm_chApps.PRM_Primary_Bank_Account_Country__c = 'ANGOLA';
        prm_chApps.PRM_Mandated_by_end_user_end_customer__c = 'Yes';
        prm_chApps.PRM_Any_felony_or_crime__c = 'Yes';
        
        Test.startTest();
        update prm_chApps;
        prmchApp_ID.add(prm_chApps.id);
        PRMChannelAppointmentHandler_GE_OG obj1 = new PRMChannelAppointmentHandler_GE_OG();
        PRMChannelAppointmentHandler_PB.ChAppIdFetch(prmchApp_ID);
        Test.stopTest();
    }
    
    static testMethod void riskRatingCalculationOnCAUpdateTest1(){
        List<ID> prmchApp_ID = new List<ID>();
        
        PRM_Channel_Appointment_GE_OG__c prm_chAppt2 = [Select Id,Name from PRM_Channel_Appointment_GE_OG__c where PRM_Channel_Appointment_GE_OG__c.PRM_Account_Name__r.Name='Unique Account1'];
        prm_chAppt2.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
 
        Test.startTest();
        update prm_chAppt2;
        prmchApp_ID.add(prm_chAppt2.id);
        PRMChannelAppointmentHandler_GE_OG obj2 = new PRMChannelAppointmentHandler_GE_OG();
        PRMChannelAppointmentHandler_PB.ChAppIdFetch(prmchApp_ID);
        Test.stopTest();
    }
    
}