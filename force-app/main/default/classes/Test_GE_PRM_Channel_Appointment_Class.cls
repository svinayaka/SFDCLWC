/*
* dated---
1.GE_PRM_Channel_Appointment_Class----78%
2.SaveSendPDF-------------------------75%
3.GE_PRM_GenerateContracts------------89%
4.GE_PRM_CAA_TriggerHandler-----------100%  
5.GE_PRM_NRTerminationClass-----------81%
6.GE_PRM_CAA_TriggerhelperClass-------100%
*/
@isTest
public class Test_GE_PRM_Channel_Appointment_Class 
{
    private static Account ObjAcc;
    private static Account ObjCommAcc;
    private static Contact ObjCon;
    private static User chnlManr;
    private static GE_PRM_Recommendation__c recc;
    private static GE_PRM_Channel_Appointment__c ChApp1;
    private static Sub_Dealer__c sdeal;
    private static GE_PRM_Commercial_line__c commline1;
    private static GE_PRM_Commercial_line__c commline2;
    private static GE_PRM_Commercial_line__c commline3;
    private static list<Contract>  contractstoinsert;
    private static GE_PRM_Channel_Appointment_Approver__c objApprover1;
    private static GE_PRM_Channel_Appointment_Approver__c objApprover2;
    private static GE_PRM_Channel_Appointment_Approver__c objApprover3;
    private static List<GE_PRM_Channel_Appointment_Approver__c> ChannelApptApproverList=new List<GE_PRM_Channel_Appointment_Approver__c>();
    private static list<GE_ES_Role__c> lstGE_ES;
    private static list<GE_HQ_Country__c> lstCountry;
    private static GE_PRM_Recommendation_Approvers__c objRecApprover;
    private static String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
    private static String contractRecordTypeAddedumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId(); 
    
    
    static testMethod  void ValidateGE_PRM_Channel_Appointment_Class_New()
      {
     
     //test.startTest();
        String TestAccountName = system.Label.Test_Account_Name;
            //Account testRRAccount = new Account(name=TestAccountName,type='Direct Customer', Classification__c='Unclassified');
             //insert testRRAccount;
         LoadData();
         GE_PRM_Channel_Appointment__c ChApp2= new GE_PRM_Channel_Appointment__c();
         ChApp2.GE_PRM_Account_Name__c = ObjAcc.id;
         ChApp2.GE_PRM_Commercial_Account__c = ObjCommAcc.id;
         PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
         Test.setCurrentPage(ChApptViewpageRef1);
           test.startTest();
              GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp2));
              ChApptViewcontroller1.init();
              ChApptViewcontroller1.save();
              ChApptViewcontroller1.Stylesellstomiltary = 'true';
              ChApptViewcontroller1.checkSLPolicy=true;
              ChApptViewcontroller1.sendPartner=true;
                // ChApptViewcontroller1.terminatestr=true;
              ChApptViewcontroller1.ObjectType='GE_PRM_Channel_Appointment__c';
              ChApptViewcontroller1.displayCAA();
          test.stopTest();
    }
    
   
    
    static testMethod  void ValidateGE_PRM_Channel_Appointment_Class_New1()
        {
            String TestAccountName = system.Label.Test_Account_Name;            
            LoadData();
            GE_PRM_Channel_Appointment__c ChApp2= new GE_PRM_Channel_Appointment__c();
            ChApp2.GE_PRM_Account_Name__c = ObjAcc.id; 
            ChApp2.GE_PRM_Commercial_Account__c = ObjCommAcc.id;
            PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
            Test.setCurrentPage(ChApptViewpageRef1);
            ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
            ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
            test.startTest();         
            GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp2));
            ChApptViewcontroller1.newchannelrec = ChApp1; 
            ChApptViewcontroller1.init();
            ChApptViewcontroller1.save();
            ChApptViewcontroller1.Stylesellstomiltary = 'true';
            ChApptViewcontroller1.checkSLPolicy=true;
            ChApptViewcontroller1.sendPartner=true;
            // ChApptViewcontroller1.terminatestr=true;
            ChApptViewcontroller1.ObjectType='GE_PRM_Channel_Appointment__c';
            ApexPages.currentPage().getParameters().put('recallRegen','true');
            ChApptViewcontroller1.save();
            test.stopTest();
        }
        
        static testMethod  void Validate_commercialwrap()
         {
            String TestAccountName = system.Label.Test_Account_Name;            
            LoadData();
            GE_PRM_Channel_Appointment__c ChApp2= new GE_PRM_Channel_Appointment__c();
            ChApp2.GE_PRM_Account_Name__c = ObjAcc.id; 
            ChApp2.GE_PRM_Commercial_Account__c = ObjCommAcc.id;
            PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
            Test.setCurrentPage(ChApptViewpageRef1);
            ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
            ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
            test.startTest();         
            GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp2));
            ChApptViewcontroller1.ObjectType='GE_PRM_Channel_Appointment__c';
            ApexPages.currentPage().getParameters().put('recallRegen','true');
            GE_PRM_Channel_Appointment_Class.commercialwrap wrapper = new GE_PRM_Channel_Appointment_Class.commercialwrap(commline1);            
            test.stopTest();
         }
                
    static testMethod void ValidateGE_PRM_Channel_Appointment_Class_Update()
    {
         String TestAccountName = system.Label.Test_Account_Name;
         
        LoadData();
        PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
        system.debug('ChApptViewpageRef1**===='+ChApptViewpageRef1 );
        Test.setCurrentPage(ChApptViewpageRef1);
        system.debug('ChApp1.id**===='+ChApp1.id);
        ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
        system.debug('ObjAcc.id**===='+ObjAcc.id);
        ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
        test.startTest(); 
        system.debug('ChApp1 before**===='+ChApp1);
        GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
        system.debug('ChApp1===='+ChApp1); 
        ChApptViewcontroller1.init();
        ChApptViewcontroller1.save();
        ChApptViewcontroller1.cancel(); 
        ChApptViewcontroller1.cloneCommline();    
        ChApptViewcontroller1.editCommline();   
        ChApptViewcontroller1.editChannelAppointment();    
        ChApptViewcontroller1.edit();    
        ChApptViewcontroller1.addcontent();    
        ChApptViewcontroller1.showmore(); 
        ChApptViewcontroller1.back();  
        ChApptViewcontroller1.getCommercialLines();    
       
        ChApptViewcontroller1.getBranchOffices();
        ChApptViewcontroller1.addBranchOffice();
        ChApptViewcontroller1.generateCommerApp();        
   
        ChApptViewcontroller1.AddnCOmplApprovers();
        ChApptViewcontroller1.cmdTerminate(); 
        ChApptViewcontroller1.cmdNonrenew(); 
        ChApptViewcontroller1.newchannelrec = ChApp1;
        ChApptViewcontroller1.CAPDF = blob.valueof('test');      
        ChApptViewcontroller1.backtoAccount();  
        
        test.stopTest();   
    }
     static testMethod  void Validate_GenerateaddCommlinesAppr()
    {
         String TestAccountName = system.Label.Test_Account_Name;
         
        LoadData();
        PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
        Test.setCurrentPage(ChApptViewpageRef1);
        ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
        ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
        test.startTest(); 
         
        GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
       
        ChApptViewcontroller1.init();
        ChApptViewcontroller1.GenerateaddCommlinesAppr();
        ChApptViewcontroller1.GetComplainceApprovers();  
        list<GE_PRM_Commercial_line__c> lstCl = new list<GE_PRM_Commercial_line__c>();
        ChApptViewcontroller1.Getapprovers(lstCl,'CommercialApprovers');  
        ChApptViewcontroller1.Getapprovers(lstCl,'HIGH');    
        test.stopTest(); 
    }
    static testMethod  void Validate_addCommercialLines()
    {
         String TestAccountName = system.Label.Test_Account_Name;
         
        LoadData();
        PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
        Test.setCurrentPage(ChApptViewpageRef1);
        ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
        ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
        test.startTest(); 
         
        GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
       
        ChApptViewcontroller1.init();
        ChApptViewcontroller1.addCommercialLines(); 
        ChApptViewcontroller1.Additionalcommline();
       // ChApptViewcontroller1.sendPartnerPdf();
        test.stopTest(); 
    }
    static testMethod  void Validate_sendSLPolicyEmail()
        {
             String TestAccountName = system.Label.Test_Account_Name;
             
            LoadData();
            PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
            Test.setCurrentPage(ChApptViewpageRef1);
            ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
            ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
            test.startTest(); 
             
            GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
           
            ChApptViewcontroller1.init();
            ChApptViewcontroller1.sendSLPolicyEmail(); 
           // ChApptViewcontroller1.sendPartnerPdf();
            test.stopTest(); 
        }
       static testMethod  void Validate_sendPartnerPdf()
        {
             String TestAccountName = system.Label.Test_Account_Name;
             
            LoadData();
            PageReference ChApptViewpageRef1 = Page.GE_PRM_ChannelAppointmentPDF;
            Test.setCurrentPage(ChApptViewpageRef1);
            Blob content = Blob.valueOf('UNIT.TEST');
            ApexPages.currentPage().getParameters().put('Id', ChApp1.id); 
            ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
            test.startTest();              
            GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
            Attachment attach=new Attachment();     
            attach.Name='Unit Test Attachment';
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            attach.body=bodyBlob;
            attach.parentId=ChApp1.id;
            insert attach;               
            ChApptViewcontroller1.init();           
            ChApptViewcontroller1.sendPartnerPdf();
            test.stopTest(); 
        }
     static testMethod  void Validate_abandonChannelAppointment()
       {
         String TestAccountName = system.Label.Test_Account_Name;         
         LoadData();
         PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
         Test.setCurrentPage(ChApptViewpageRef1);
         ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
         ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
         test.startTest(); 
         
         GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
       
         ChApptViewcontroller1.init();        
         ChApptViewcontroller1.abandonChannelAppointment();
         ChApptViewcontroller1.GetComplainceApprovers(); 
         test.stopTest(); 
    }
    static testMethod  void Validate_CancelAbandon()
       {
          LoadData();
          PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
          Test.setCurrentPage(ChApptViewpageRef1);
          ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
          ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
          test.startTest();          
          GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
          ChApptViewcontroller1.init();
          ChApptViewcontroller1.CancelAbandon();
          test.stopTest();   
       }
     static testMethod  void Validate_AbandonProcessed()
       {
          LoadData();
          PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
          Test.setCurrentPage(ChApptViewpageRef1);
          ApexPages.currentPage().getParameters().put('id',ChApp1.id); 
          ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
          test.startTest();          
          GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
          ChApptViewcontroller1.init();
          ChApptViewcontroller1.AbandonProcessed();
          ChApp1.GE_PRM_Abandon_Reason__c='Other';
          ChApp1.GE_PRM_Abandon_Reason_If_Others__c='Testing Abandon';
          update ChApp1;
          ChApptViewcontroller1.AbandonProcessed();
          test.stopTest();   
       }
     static testMethod  void Validate_generateCommerApp()
     {
         String TestAccountName = system.Label.Test_Account_Name;
         
        LoadData();
        PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
        Test.setCurrentPage(ChApptViewpageRef1);
        ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
        ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
        test.startTest(); 
         
        GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
       
        ChApptViewcontroller1.init();
        ChApptViewcontroller1.save();
        ChApptViewcontroller1.generateCommerApp(); 
        Account acc = [select name,ShippingCountry, GE_HQ_Country_Code__c from account where id =: ChApp1.GE_PRM_Account_Name__c]; 
        ChApp1.GE_PRM_Master_appointment_type__c = 'Renewal';
        ChApp1.GE_PRM_Tier_2_P_L__c= 'Surface';
        ChApp1.GE_PRM_Primary_Sales_Channel_Manager__c = UserInfo.getUserId();
        ChApp1.GE_PRM_Region_Sales_Channel_Leader__c = UserInfo.getUserId();
        ChApp1.GE_PRM_Commercial_Account__c = ObjCommAcc.id;        
        ChApp1.GE_PRM_Sales_Channel_Manager__c = 'test';
        ChApp1.GE_PRM_In_Business_Since__c = system.today();
        ChApp1.GE_PRM_With_GE_since__c = 12;
        ChApp1.GE_PRM_Prior_year_orders__c= 'New';
        ChApp1.GE_PRM_Prior_performance_rating__c = 'Low';
        ChApp1.GE_PRM_Prior_year_commission_paid__c= 'New';
        ChApp1.GE_PRM_Prior_growth_rating__c= 'Low';
        ChApp1.GE_PRM_Commercial_quali_rationale__c= 'New';
        ChApp1.GE_PRM_Commercial_Start_Date_addCL__c=null;
        update ChApp1;        
        ChApptViewcontroller1.generateCommerApp();
        test.stopTest(); 
    }
    static testMethod  void Validate_ComplainceApprovers()
    {
         String TestAccountName = system.Label.Test_Account_Name;
         
        LoadData();
        PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
        Test.setCurrentPage(ChApptViewpageRef1);
        ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
        ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
        test.startTest(); 
         
        GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
       
        ChApptViewcontroller1.init();
        ChApptViewcontroller1.save();
        ChApptViewcontroller1.GetComplainceApprovers(); 
        ChApp1.GE_PRM_Master_appointment_type__c = 'New';
        ChApp1.GE_PRM_Tier_2_P_L__c= 'Surface';
        ChApp1.GE_PRM_Commercial_Account__c = ObjCommAcc.id;        
        ChApp1.GE_PRM_Sales_Channel_Manager__c = 'test';
        ChApp1.GE_PRM_In_Business_Since__c = system.today();
        ChApp1.GE_PRM_With_GE_since__c = 12;
        ChApp1.GE_PRM_Prior_year_orders__c= 'New';
        ChApp1.GE_PRM_Prior_performance_rating__c = 'Low';
        ChApp1.GE_PRM_Prior_year_commission_paid__c= 'New';
        ChApp1.GE_PRM_Prior_growth_rating__c= 'Low';
        ChApp1.GE_PRM_Commercial_quali_rationale__c= 'New';
        ChApp1.GE_PRM_Primary_Sales_Channel_Manager__c = UserInfo.getUserId();
        ChApp1.GE_PRM_Region_Sales_Channel_Leader__c = UserInfo.getUserId();
        update ChApp1;
        ChApptViewcontroller1.GetComplainceApprovers();        
        test.stopTest(); 
        
        
    }
 
    static testMethod  void ValidateGE_PRM_Channel_Appointment_Class_Update2()
    {
        String TestAccountName = system.Label.Test_Account_Name;        
        LoadData();
        PageReference ChApptViewpageRef1 = Page.GE_PRM_Channel_Appointment_View_Page1;
        Test.setCurrentPage(ChApptViewpageRef1);
        ApexPages.currentPage().getParameters().put('id', ChApp1.id); 
        ApexPages.currentPage().getParameters().put('RenewAccId', ObjAcc.id); 
         test.startTest();
         
        GE_PRM_Channel_Appointment_Class  ChApptViewcontroller1 = new GE_PRM_Channel_Appointment_Class (new ApexPages.StandardController(ChApp1));
        
        ChApp1.GE_PRM_Master_appointment_type__c = 'Renewal';
        ChApp1.GE_PRM_Tier_2_P_L__c= 'Digital Solutions';      
        ChApp1.GE_PRM_Sales_Channel_Manager__c = 'test';
        ChApp1.GE_PRM_In_Business_Since__c = system.today();
        ChApp1.GE_PRM_With_GE_since__c = 12;
        ChApp1.GE_PRM_Prior_year_orders__c= 'New';
        ChApp1.GE_PRM_Prior_performance_rating__c = 'Low';
        ChApp1.GE_PRM_Prior_year_commission_paid__c= 'New';
        ChApp1.GE_PRM_Prior_growth_rating__c= 'Low';
        ChApp1.GE_PRM_Due_diligence_approval_Status__c='Due Diligence Accepted';
        ChApp1.GE_PRM_Commercial_Start_Date_addCL__c=null;
        ChApp1.GE_PRM_Commercial_quali_rationale__c= 'New';
        ChApp1.GE_PRM_Current_Status__c = 'Draft'; 
        chApp1.GE_PRM_Partner_Approval__c = 'Approved';
        CheckRecursion_GE_OG.run = false;
        update ChApp1;
        
        ChApptViewcontroller1.GetComplainceApprovers(); 
        test.stopTest();
                 
    }
    
    static testMethod  void ValidateGE_PRM_NRTerminationClass()
    {
        String TestAccountName = system.Label.Test_Account_Name;        
        InsertCommercialAccount();
        InsertAccount();
        InsertContact();
        InsertChannelManager();
        InsertPRMRecommendation();
        InsertChannelAppointmentNew();
        InsertChannelAppointment();      
        InsertCommercialLine();
        InsertContract();       
        ApexPages.currentPage().getParameters().put('clineid', commline2.id); 
        test.startTest();
        GE_PRM_NRTerminationClass NRTerminationClass1 = new GE_PRM_NRTerminationClass(new ApexPages.StandardController(commline2));
        NRTerminationClass1.cmdcancel();        
        NRTerminationClass1.commline.GE_PRM_Non_Renewal_or_Termination__c =null;
        NRTerminationClass1.commline.GE_PRM_Due_To_Compliance_Issue__c=null;
        NRTerminationClass1.commline.GE_PRM_Non_Renewal_or_Termination__c =null;
        NRTerminationClass1.commline.GE_PRM_outstanding_receivables__c=null;
        NRTerminationClass1.commline.GE_PRM_Outstanding_Payments__c=null;
        NRTerminationClass1.commline.GE_PRM_any_GE_equipment_to_return__c=null;
        NRTerminationClass1.commline.GE_PRM_Authorized_to_sell_other__c=null;
        NRTerminationClass1.commline.GE_PRM_Non_Renewal_or_Termination__c=null;
        
        NRTerminationClass1.cmdSubmit();
        
        NRTerminationClass1.commline.GE_PRM_Non_Renewal_or_Termination__c='test';
        NRTerminationClass1.commline.GE_PRM_Due_To_Compliance_Issue__c=null;
        NRTerminationClass1.cmdSubmit();
        
        NRTerminationClass1.commline.GE_PRM_Due_To_Compliance_Issue__c='test';
        NRTerminationClass1.commline.GE_PRM_Is_there_contracts_T_C_risk__c=null;
        NRTerminationClass1.cmdSubmit();
        
        NRTerminationClass1.commline.GE_PRM_Is_there_contracts_T_C_risk__c='test';
        NRTerminationClass1.commline.GE_PRM_outstanding_receivables__c=null;
        NRTerminationClass1.cmdSubmit();
        
        NRTerminationClass1.commline.GE_PRM_outstanding_receivables__c='test';
        NRTerminationClass1.commline.GE_PRM_Outstanding_Payments__c=null;
        NRTerminationClass1.cmdSubmit();
        
        NRTerminationClass1.commline.GE_PRM_Outstanding_Payments__c='test';
        NRTerminationClass1.commline.GE_PRM_any_GE_equipment_to_return__c=null;
        NRTerminationClass1.cmdSubmit();
        
        NRTerminationClass1.commline.GE_PRM_any_GE_equipment_to_return__c='test';
        NRTerminationClass1.commline.GE_PRM_Authorized_to_sell_other__c=null;
        NRTerminationClass1.cmdSubmit();
        List<GE_PRM_Commercial_line__c> Listcmline = [Select id,GE_PRM_Tier_4__c from GE_PRM_Commercial_line__c Where Id=:commline1.Id OR Id=:commline2.Id];
        NRTerminationClass1.Getapprovers(Listcmline,'Non-Renewal');
        NRTerminationClass1.Getapprovers(Listcmline,'Termination');
        test.stopTest();        
    }
    
    public static testMethod void testSubDealerClass(){
        String TestAccountName = system.Label.Test_Account_Name;
         Account testRRAccount = new Account(name=TestAccountName);
         insert testRRAccount;
         InsertCommercialAccount();
         InsertAccount();
         InsertContact();
        //InsertChannelManager();
        //InsertPRMRecommendation();
         InsertChannelAppointmentNew();
         InsertChannelAppointment();
         InsertSubDealer();
         PageReference subdealerpage = Page.GE_PRM_Channel_BranchOffice_sub;
         Test.setCurrentPage(subdealerpage);
         ApexPages.currentPage().getParameters().put('Id', sdeal.id);
         ApexPages.currentPage().getParameters().put('clone', 'Yes'); 
         ApexPages.currentPage().getParameters().put('ChannelAppointmentId', ChApp1.id); 
         test.startTest();
         GE_PRM_SubDealer_Class subDealer = new GE_PRM_SubDealer_Class(new ApexPages.StandardController(sdeal));
         subDealer.errorMessage = '';
         subDealer.saveSubDealerDetails();
         subDealer.backToChApp();
         subDealer.isnew_SB_from_URL= 'true';
         subDealer.cancel();
         test.stopTest();
    }
    
    private static void LoadData()
    {
        InsertCommercialAccount();
        InsertAccount();
        InsertContact();
        InsertChannelManager();
        InsertPRMRecommendation();
        InsertChannelAppointmentNew();
        InsertChannelAppointment();
        InsertSubDealer();
        InsertCommercialLine();
        InsertContract();
        InsertGE_ES_Role();
        InsertChannelApprover();
        InsertCountry();
        insertApprover();
    }
    
    private static void InsertAccount()
    {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rt = AccountRecordTypeInfo .get('CMF Approved').getRecordTypeId();
        //RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
        ObjAcc= new Account(name='TestAccount0',Oil_Gas_Parent_Account__c=ObjCommAcc.id, Account_Status__c='CC Approved',
        GE_HQ_Country_Code__c='BG',ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', 
        ShippingCountry = 'USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.',
         BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,
         recordtypeid=rt, type='Direct Customer', Classification__c='Unclassified');        
        insert ObjAcc;
        system.debug('ObjAcc='+ObjAcc);
    }
    
    private static void InsertCommercialAccount()
    
    {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rt = AccountRecordTypeInfo .get('Relationship Account').getRecordTypeId();
       // RecordType rt = [SELECT Id FROM WHERE SObjectType='Account' AND Name='Relationship Account' LIMIT 1];
        ObjCommAcc= new Account(name='TestAccount0',Account_Tier_GEOG__c='Country', Account_Status__c='CC Approved',GE_HQ_Country_Code__c='BG',ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry = 'USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=rt, type='Direct Customer', Classification__c='Unclassified');
        insert ObjCommAcc;
        system.debug('ObjCommAcc='+ObjCommAcc);
    }
    
    private static void InsertContact()
    {
        ObjCon = new Contact(Email='test@ge.com',AccountId=ObjCommAcc.id,firstname='testCon',LastName ='Test1' , GE_OG_Contact_Audience__c ='Customer Care');
        insert objCon;
        system.debug('objCon='+objCon);
    }
    private static void InsertChannelManager()
    {
        
        /*profile  chnlMagrId =  [select id from profile where name ='OG_Sales/Comm Ops' limit 1];
        chnlManr = new User(firstname = 'channel', lastname = 'manager', email = 'chnmanager@ge.com', alias = 'chnUsr', profileId = chnlMagrId.id, Title = 'Channel Manager', Username = 'channelmagr@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        
        insert chnlManr;*/
    }
    private static void InsertPRMRecommendation()
    {
        recc= new GE_PRM_Recommendation__c();
        recc.GE_PRM_Agreement_Category__c='New';
        recc.GE_PRM_Status__c='Approved';
        
        insert recc;
    }
    private static void InsertChannelAppointmentNew()
    {
        ChApp1 = new GE_PRM_Channel_Appointment__c();
        ChApp1.GE_PRM_Master_appointment_type__c = 'New';
        ChApp1.GE_PRM_Current_Status__c= 'New'; 
        ChApp1.GE_PRM_Account_Name__c = ObjAcc.id; 
        ChApp1.GE_PRM_Commercial_Account__c = ObjCommAcc.id;
        ChApp1.GE_PRM_Principal_contact__c=objCon.id;
        system.debug('ChApp1.GE_PRM_Principal_contact__c='+ChApp1.GE_PRM_Principal_contact__c);
        //ChApp1.GE_PRM_Primary_Sales_Channel_Manager__c=chnlManr.id;
        //ChApp1.GE_PRM_Region_Sales_Channel_Leader__c=chnlManr.id;       
        ChApp1.GE_PRM_With_GE_since__c = 2;
        ChApp1.GE_PRM_In_Business_Since__c = Date.today();        
        ChApp1.GE_PRM_Prior_year_orders__c = 'New';
        ChApp1.GE_PRM_Prior_performance_rating__c = 'Medium';
        ChApp1.GE_PRM_Prior_year_commission_paid__c='New';
        ChApp1.GE_PRM_Prior_growth_rating__c = 'Medium';
        ChApp1.GE_PRM_Commercial_quali_rationale__c='Test';        
        ChApp1.GE_PRM_Due_diligence_approval_Status__c = 'Pending';  
        ChApp1.GE_PRM_Partner_Approval__c  ='Pending';    
        ChApp1.GE_PRM_Mandated_by_End_Customer__c = 'No';
        ChApp1.GE_PRM_Export_Controlled_products__c= 'No';
        ChApp1.GE_PRM_High_Risk_product_lines__c= 'No';
        ChApp1.GE_PRM_Approved_exclusivity_from_P_L__c= 'No';
        ChApp1.GE_PRM_Do_you_sell_to_the_government__c = 'No';
        ChApp1.GE_PRM_Sell_to_Nuclear_industry__c= 'No';
        ChApp1.GE_PRM_Sell_to_Military__c= 'No';
        ChApp1.GE_PRM_Export_outside_own_country__c= 'No';
        ChApp1.GE_PRM_Do_you_have_Officers_in_Gov__c= 'No';
        ChApp1.GE_PRM_Convicted_of_any_felony_crims_r_s__c= 'No';
        ChApp1.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c= 'No';
        ChApp1.GE_PRM_Does_Channel_Partner_have_subsid__c= 'No'; 
        ChApp1.GE_PRM_Commercial_Start_Date_addCL__c=system.now();
        ChApp1.GE_PRM_EnableCommercialButton__c=true;
        ChApp1.GE_PRM_WillUpdateCommercial__c=true; 
        ChApp1.GE_PRM_Primary_bank_account_country__c= 'BANGLADESH';
        // ChApp1.GE_PRM_Status__c='New'; 
        ChApp1.GE_PRM_IsApproved__c = true;
        ChApp1.GE_PRM_ComplainceAffected__c = false;
        ChApp1.GE_PRM_CommercialAffected__c = false;
        insert ChApp1; 
    }
    private static void InsertChannelAppointment()
    {
        ChApp1 = new GE_PRM_Channel_Appointment__c();
        ChApp1.GE_PRM_Master_appointment_type__c = 'Renewal';
        ChApp1.GE_PRM_Current_Status__c= 'Draft'; 
        ChApp1.GE_PRM_Account_Name__c = ObjAcc.id; 
        ChApp1.GE_PRM_Commercial_Account__c = ObjCommAcc.id;
        system.debug('ChApp1.GE_PRM_Commercial_Account__c***'+ChApp1.GE_PRM_Commercial_Account__c);
        ChApp1.GE_PRM_Principal_contact__c=objCon.id;
        //ChApp1.GE_PRM_Primary_Sales_Channel_Manager__c=chnlManr.id;
        //ChApp1.GE_PRM_Region_Sales_Channel_Leader__c=chnlManr.id;       
        ChApp1.GE_PRM_With_GE_since__c = 2;
        ChApp1.GE_PRM_In_Business_Since__c = Date.today();        
        ChApp1.GE_PRM_Prior_year_orders__c = 'New';
        ChApp1.GE_PRM_Prior_performance_rating__c = 'Medium';
        ChApp1.GE_PRM_Prior_year_commission_paid__c='New';
        ChApp1.GE_PRM_Prior_growth_rating__c = 'Medium';
        ChApp1.GE_PRM_Commercial_quali_rationale__c='Test';        
        ChApp1.GE_PRM_Due_diligence_approval_Status__c = 'Pending';  
        ChApp1.GE_PRM_Partner_Approval__c  ='Pending';    
        ChApp1.GE_PRM_Mandated_by_End_Customer__c = 'No';
        ChApp1.GE_PRM_Export_Controlled_products__c= 'No';
        ChApp1.GE_PRM_High_Risk_product_lines__c= 'No';
        ChApp1.GE_PRM_Approved_exclusivity_from_P_L__c= 'No';
        ChApp1.GE_PRM_Do_you_sell_to_the_government__c = 'No';
        ChApp1.GE_PRM_Sell_to_Nuclear_industry__c= 'No';
        ChApp1.GE_PRM_Sell_to_Military__c= 'No';
        ChApp1.GE_PRM_Export_outside_own_country__c= 'No';
        ChApp1.GE_PRM_Do_you_have_Officers_in_Gov__c= 'No';
        ChApp1.GE_PRM_Convicted_of_any_felony_crims_r_s__c= 'No';
        ChApp1.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c= 'No';
        ChApp1.GE_PRM_Does_Channel_Partner_have_subsid__c= 'No'; 
        ChApp1.GE_PRM_Commercial_Start_Date_addCL__c=system.now();
        ChApp1.GE_PRM_EnableCommercialButton__c=true;
        ChApp1.GE_PRM_WillUpdateCommercial__c=true; 
        ChApp1.GE_PRM_Primary_bank_account_country__c= 'BANGLADESH';
        // ChApp1.GE_PRM_Status__c='New'; 
        ChApp1.GE_PRM_IsApproved__c = true;
        ChApp1.GE_PRM_ComplainceAffected__c = false;
        ChApp1.GE_PRM_CommercialAffected__c = false;    
        insert ChApp1; 
    }
    private static void InsertSubDealer()
    {
        sdeal = new Sub_Dealer__c();
        sdeal.GE_PRM_Affiliate_dependent_type__c='Sub-Dealer2';
        sdeal.GE_PRM_Authorized_commercial_lines__c='commercial2';
        sdeal.GE_PRM_Channel_Appointment__c=ChApp1.id;            
        sdeal.GE_PRM_City__c='aa';                
        sdeal.GE_PRM_City_of_registration__c='aa';                
        sdeal.GE_PRM_Country__c='UNITED STATES';              
        sdeal.GE_PRM_Email__c='test@test.com';
        sdeal.GE_PRM_Legal_name__c='test';             
        sdeal.GE_PRM_Mobile__c='123456789';     
        sdeal.GE_PRM_Ownership__c=50;              
        sdeal.GE_PRM_Phone__c='123456789';     
        sdeal.GE_PRM_Postal_code__c='1';             
        sdeal.GE_PRM_Prinicipal_Conatct_Text__c='test';           
        insert sdeal;
    }
    
    private static void InsertCommercialLine()
    {   
        list<GE_PRM_Commercial_line__c> lstCl = new list<GE_PRM_Commercial_line__c>();    
        commline1= new GE_PRM_Commercial_line__c();
        commline1.GE_PRM_Channel_Appointment__c=ChApp1.id;
        commline1.GE_PRM_Status__c='Under NR/T';       
        commline1.GE_PRM_Tier_1__c='Oil & Gas';
        commline1.GE_PRM_Tier_2__c='Digital Solutions';
        commline1.GE_PRM_Tier_3__c='Controls & Condition Monitoring';
        commline1.GE_PRM_Tier_4__c='Cyber Security';
        commline1.GE_PRM_Type__c='Sales Representative';       
        commline1.GE_PRM_If_Services_pick_type__c='MARC';
        commline1.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
        commline1.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM'; 
        commline1.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
        commline1.GE_PRM_Term__c=8;
        
        commline1.GE_PRM_Non_Renewal_or_Termination__c ='Termination';
        commline1.GE_PRM_Due_To_Compliance_Issue__c ='Yes';
        commline1.GE_PRM_Is_there_contracts_T_C_risk__c='Yes';
        commline1.GE_PRM_outstanding_receivables__c ='Yes';
        commline1.GE_PRM_Outstanding_Payments__c='Yes';
        commline1.GE_PRM_any_GE_equipment_to_return__c='Yes';
        commline1.GE_PRM_Authorized_to_sell_other__c='Yes';
        commline1.GE_PRM_If_Outstanding_Payments_Yes1__c  = userinfo.getuserid();
        commline1.GE_PRM_If_outstanding_receivable_Yes1__c = userinfo.getuserid();
        commline1.GE_PRM_If_GE_Equipment_to_return_Yes1__c = userinfo.getuserid();
        commline1.GE_PRM_If_due_to_Compliance_issue_Yes1__c  = userinfo.getuserid();
        commline1.GE_PRM_If_Is_there_contracts_T_C_Yes1__c= userinfo.getuserid();
        commline1.GE_PRM_If_authorized_to_sell_other_Yes__c = 'test';
        commline1.GE_PRM_If_Is_there_contracts_T_C_Yes__c='test';
        commline1.GE_PRM_If_authorized_to_sell_other_Yes1__c =userinfo.getuserid();
        
        commline1.isCommercialApproved__c = true;
        commline1.GE_PRM_Is_this_linked_to_project_oppty__c='No';
        commline1.GE_PRM_Military_use_Add_comment__c='No';
        commline1.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
        commline1.GE_PRM_Nuclear_use_Add_comment__c='No';
        commline1.isCommercialApproved__c=false;
        lstCl.add(commline1);
        
        commline2= new GE_PRM_Commercial_line__c();
        commline2.GE_PRM_Channel_Appointment__c=ChApp1.id;
        commline2.GE_PRM_Status__c='New'; 
        commline2.GE_PRM_Tier_1__c='Oil & Gas';
        commline2.GE_PRM_Tier_2__c='Digital Solutions';
        commline2.GE_PRM_Tier_3__c='Controls & Condition Monitoring';
        commline2.GE_PRM_Tier_4__c='Cyber Security';
        commline2.GE_PRM_Type__c='Sales Representative';       
        commline2.GE_PRM_If_Services_pick_type__c='MARC';
        commline2.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
        commline2.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM'; 
        commline2.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
        commline2.GE_PRM_Term__c=8;
        commline2.isCommercialApproved__c = true;
        commline2.GE_PRM_Is_this_linked_to_project_oppty__c='No';
        commline2.GE_PRM_Military_use_Add_comment__c='No';
        commline2.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
        commline2.GE_PRM_Nuclear_use_Add_comment__c='No';
        
        commline2.GE_PRM_Non_Renewal_or_Termination__c ='Termination';
        commline2.GE_PRM_Due_To_Compliance_Issue__c ='Yes';
        commline2.GE_PRM_Is_there_contracts_T_C_risk__c='Yes';
        commline2.GE_PRM_outstanding_receivables__c ='Yes';
        commline2.GE_PRM_Outstanding_Payments__c='Yes';
        commline2.GE_PRM_any_GE_equipment_to_return__c='Yes';
        commline2.GE_PRM_Authorized_to_sell_other__c='Yes';
        commline2.GE_PRM_If_Outstanding_Payments_Yes1__c  = userinfo.getuserid();
        commline2.GE_PRM_If_outstanding_receivable_Yes1__c = userinfo.getuserid();
        commline2.GE_PRM_If_GE_Equipment_to_return_Yes1__c = userinfo.getuserid();
        commline2.GE_PRM_If_due_to_Compliance_issue_Yes1__c  = userinfo.getuserid();
        commline2.GE_PRM_If_Is_there_contracts_T_C_Yes__c='test';
        commline2.GE_PRM_If_Is_there_contracts_T_C_Yes1__c= userinfo.getuserid();
        commline2.GE_PRM_If_authorized_to_sell_other_Yes__c = 'test';
        commline2.GE_PRM_If_authorized_to_sell_other_Yes1__c =userinfo.getuserid();
        commline2.isCommercialApproved__c=true;
        lstCl.add(commline2);        
        insert lstCl;
    }
    private static void InsertContract()
    {
        contractstoinsert = new list<Contract>();
        Contract master=new  Contract();
        integer intterm = 6;
        master.RecordTypeId= contractRecordTypeMasterId ;
        master.GE_PRM_Channel_Appointment_ID__c=ChApp1.id;
        master.accountid =ChApp1.GE_PRM_Account_Name__c;
        master.GE_PRM_Primary_Sales_Channel_Manager__c =ChApp1.GE_PRM_Primary_Sales_Channel_Manager__c;
        system.debug('commid--->'+ChApp1.GE_PRM_Commercial_Manager__c);
        master.GE_PRM_Commercial_Manager1__c=ChApp1.GE_PRM_Commercial_Manager__c;
        master.GE_PRM_Tier_2__c=ChApp1.GE_PRM_Tier_2_P_L__c;
        master.GE_PRM_Region__c=ChApp1.GE_PRM_O_G_Region__c;
        master.GE_PRM_Business_Tier_1__c = commline1.GE_PRM_Tier_1__c;
        master.GE_PRM_Tier_2__c =commline1.GE_PRM_Tier_2__c;
        master.GE_PRM_Tier_3__c= commline1.GE_PRM_Tier_3__c;
        master.GE_PRM_Tier_4__c =commline1.GE_PRM_Tier_4__c;
        master.GE_PRM_Tier_5__c= commline1.GE_PRM_Tier_5__c;
        master.GE_PRM_Relationship_Type__c=commline1.GE_PRM_Type__c;
        master.StartDate =Date.today();    
        if(intterm != -1){    
            master.ContractTerm = intterm;
            master.GE_OG_Contract_End_Date__c = Date.today().addMonths(intterm);     
        }
        if(ChApp1.GE_PRM_Sell_to_Nuclear_industry__c=='Yes')
            master.GE_PRM_Nuclear_sales__c=true;
        if(ChApp1.GE_PRM_Sell_to_Military__c=='Yes')
            master.GE_PRM_Military_sales__c=true;
        if(ChApp1.GE_PRM_No_Of_Subdealers_Subsidary__c>0)
            master.GE_PRM_Sub_dealer_agents__c=true;
        if(ChApp1.GE_PRM_Account_Country__c=='BRAZIL')
            master.GE_PRM_Brazil_Sales_Rep__c=true;
        contractstoinsert.add(master);

        Contract addedum=new  Contract();
        addedum.GE_PRM_Commercial_line__c = commline1.Id;
        addedum.RecordTypeId=contractRecordTypeAddedumId;
        addedum.AccountID=ChApp1.GE_PRM_Account_Name__c;
        addedum.GE_ES_User_Lead_Sales_Person__c =commline1.GE_PRM_Sales_Manager__c;
        addedum.GE_PRM_Business_Tier_1__c = commline1.GE_PRM_Tier_1__c;
        addedum.GE_PRM_Tier_2__c =commline1.GE_PRM_Tier_2__c;
        addedum.GE_PRM_Tier_3__c= commline1.GE_PRM_Tier_3__c;
        addedum.GE_PRM_Tier_4__c =commline1.GE_PRM_Tier_4__c;
        addedum.GE_PRM_Tier_5__c= commline1.GE_PRM_Tier_5__c;
        addedum.GE_PRM_If_flat_Pricing__c= commline1.GE_PRM_If_flat_Pricing__c;
        addedum.GE_PRM_If_schedule_Max_Pricing__c= commline1.GE_PRM_If_schedule_Max_Pricing__c;
        addedum.GE_PRM_If_schedule_Min_Pricing__c= commline1.GE_PRM_If_schedule_Min_Pricing__c;
        addedum.GE_PRM_Industries__c= commline1.GE_PRM_Industries__c;
        addedum.GE_PRM_Buyers__c= commline1.GE_PRM_Buyers__c;
        addedum.GE_PRM_Channel_Appointment_ID__c=commline1.GE_PRM_Channel_Appointment__r.id;
        addedum.GE_PRM_Authorized_Country__c =commline1.GE_PRM_Authorized_Countries_1__c + ';'+ commline1.GE_PRM_Authorized_Countries_2__c;
        addedum.GE_PRM_State_Province_Region__c =commline1.GE_PRM_State_Province_Region__c;
        addedum.GE_PRM_Pricing__c= commline1.GE_PRM_Pricing__c;
        addedum.GE_PRM_Pricing_type__c=commline1.GE_PRM_Pricing_Type__c;
        addedum.GE_PRM_Nuclear_use__c=commline1.GE_PRM_Nuclear_use_Add_comment__c;
        addedum.GE_PRM_Military_use__c =commline1.GE_PRM_Military_use_Add_comment__c;
        addedum.GE_PRM_If_Brazil_SR_SC_core__c= commline1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
        addedum.GE_PRM_If_Brazil_SR_CMPJ__c=commline1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
        addedum.GE_PRM_Inclusions_exclusions__c = commline1.GE_PRM_Inclusions_exclusions_Add_comment__c;
        addedum.GE_PRM_If_SR_sales_to_US_government__c =commline1.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
        addedum.GE_PRM_Comments__c =commline1.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
        addedum.GE_PRM_Commercial_Manager1__c=commline1.GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c;
        addedum.GE_PRM_Relationship_Type__c=commline1.GE_PRM_Type__c;
        addedum.StartDate =Date.today();
        addedum.ContractTerm = integer.valueof(commline1.GE_PRM_Term__c);
        if(commline1.GE_PRM_Term__c!=null)
            addedum.GE_OG_Contract_End_Date__c = addedum.StartDate.addmonths(integer.valueof(commline1.GE_PRM_Term__c));
        if(commline1.GE_PRM_Inclusions_exclusions_Add_comment__c =='yes')
        {
            addedum.GE_PRM_Limitations_exclusions__c=true;
        }
        else if(commline1.GE_PRM_Inclusions_exclusions_Add_comment__c =='no')
        {
            addedum.GE_PRM_Limitations_exclusions__c=false;
        }
        if(commline1.GE_PRM_Any_Exclusions__c=='yes')
        {
            addedum.GE_PRM_Exclusions__c=true;
        }
        else if(commline1.GE_PRM_Any_Exclusions__c=='no')
        {
            addedum.GE_PRM_Exclusions__c=false;
        }

        addedum.GE_PRM_Primary_Sales_Channel_Manager__c =commline1.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
        addedum.GE_PRM_Region__c =commline1.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
        addedum.GE_PRM_Master_Agreement__c=master.id;
        addedum.GE_PRM_Channel_Appointment_ID__c=ChApp1.id;
        contractstoinsert.add(addedum);
        
        Contract master1=new  Contract();
        master1.RecordTypeId= contractRecordTypeMasterId ;
        master1.GE_PRM_Channel_Appointment_ID__c=ChApp1.id;
        master1.accountid =objAcc.id;
        //master1.GE_PRM_Primary_Sales_Channel_Manager__c =chnlManr.id;
        //master1.GE_PRM_Commercial_Manager1__c=chnlManr.id;
        master1.GE_PRM_Tier_2__c=ChApp1.GE_PRM_Tier_2_P_L__c;
        master1.GE_PRM_Region__c=ChApp1.GE_PRM_O_G_Region__c;
        master1.StartDate =Date.today();
        master1.GE_PRM_Business_Tier_1__c = commline1.GE_PRM_Tier_1__c;
        master1.GE_PRM_Tier_2__c =commline1.GE_PRM_Tier_2__c;
        master1.GE_PRM_Tier_3__c= commline1.GE_PRM_Tier_3__c;
        master1.GE_PRM_Tier_4__c =commline1.GE_PRM_Tier_4__c;
        master1.GE_PRM_Tier_5__c= commline1.GE_PRM_Tier_5__c;
        master1.GE_PRM_Relationship_Type__c=commline1.GE_PRM_Type__c;
        if(intterm != -1){    
            master1.ContractTerm = intterm;
            master1.GE_OG_Contract_End_Date__c = Date.today().addMonths(intterm);     
        }
        if(ChApp1.GE_PRM_Sell_to_Nuclear_industry__c=='Yes')
            master1.GE_PRM_Nuclear_sales__c=true;
        if(ChApp1.GE_PRM_Sell_to_Military__c=='Yes')
            master1.GE_PRM_Military_sales__c=true;
        if(ChApp1.GE_PRM_No_Of_Subdealers_Subsidary__c>0)
            master1.GE_PRM_Sub_dealer_agents__c=true;
        if(ChApp1.GE_PRM_Account_Country__c=='BRAZIL')
            master1.GE_PRM_Brazil_Sales_Rep__c=true;
        
        
        //TERMINATE MASTER
        master1.status = 'Executed';
        master1.Termination_Email__c = true ;
        
        master1.GE_PRM_For_Cause__c='30 Days';
        master1.GE_PRM_Without_Cause__c='30 Days';
        //master1.GE_Contract_Specialist__c=chnlManr.Id;
        master1.GE_PRM_Contract_Draft_date__c=Date.today();
        master1.GE_PRM_Contract_Sent_to_CP__c=Date.today();
        master1.GE_PRM_ASC_Signed_contract_received__c=Date.today(); 
        master1.GE_PRM_GE_Signatures_completed__c=Date.today();
        master1.GE_PRM_Close_out__c=Date.today();
        master1.GE_OG_3rd_Party_Indemnity__c='Negligence based';
        master1.Hold_Flag__c =false;
        master1.Red_Line__c =false;
        contractstoinsert.add(master1);             

        Contract addedum1=new  Contract();
        // addedum1.GE_PRM_Commercial_line__c = commline1.Id;
        addedum1.RecordTypeId=contractRecordTypeAddedumId;
        addedum1.AccountID=objAcc.id;
        addedum1.GE_ES_User_Lead_Sales_Person__c =commline1.GE_PRM_Sales_Manager__c;
        addedum1.GE_PRM_Business_Tier_1__c = commline1.GE_PRM_Tier_1__c;
        addedum1.GE_PRM_Tier_2__c =commline1.GE_PRM_Tier_2__c;
        addedum1.GE_PRM_Tier_3__c= commline1.GE_PRM_Tier_3__c;
        addedum1.GE_PRM_Tier_4__c =commline1.GE_PRM_Tier_4__c;
        addedum1.GE_PRM_Tier_5__c= commline1.GE_PRM_Tier_5__c;
        addedum1.GE_PRM_If_flat_Pricing__c= commline1.GE_PRM_If_flat_Pricing__c;
        addedum1.GE_PRM_If_schedule_Max_Pricing__c= commline1.GE_PRM_If_schedule_Max_Pricing__c;
        addedum1.GE_PRM_If_schedule_Min_Pricing__c= commline1.GE_PRM_If_schedule_Min_Pricing__c;
        addedum1.GE_PRM_Industries__c= commline1.GE_PRM_Industries__c;
        addedum1.GE_PRM_Buyers__c= commline1.GE_PRM_Buyers__c;
        addedum1.GE_PRM_Channel_Appointment_ID__c=commline1.GE_PRM_Channel_Appointment__r.id;
        addedum1.GE_PRM_Authorized_Country__c =commline1.GE_PRM_Authorized_Countries_1__c + ';'+ commline1.GE_PRM_Authorized_Countries_2__c;
        addedum1.GE_PRM_State_Province_Region__c =commline1.GE_PRM_State_Province_Region__c;
        addedum1.GE_PRM_Pricing__c= commline1.GE_PRM_Pricing__c;
        addedum1.GE_PRM_Pricing_type__c=commline1.GE_PRM_Pricing_Type__c;
        addedum1.GE_PRM_Nuclear_use__c=commline1.GE_PRM_Nuclear_use_Add_comment__c;
        addedum1.GE_PRM_Military_use__c =commline1.GE_PRM_Military_use_Add_comment__c;
        addedum1.GE_PRM_If_Brazil_SR_SC_core__c= commline1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
        addedum1.GE_PRM_If_Brazil_SR_CMPJ__c=commline1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
        addedum1.GE_PRM_Inclusions_exclusions__c = commline1.GE_PRM_Inclusions_exclusions_Add_comment__c;
        addedum1.GE_PRM_If_SR_sales_to_US_government__c =commline1.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
        addedum1.GE_PRM_Comments__c =commline1.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
        addedum1.GE_PRM_Commercial_Manager1__c=commline1.GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c;
        addedum1.GE_PRM_Relationship_Type__c=commline1.GE_PRM_Type__c;
        addedum1.StartDate =Date.today();
        addedum1.ContractTerm = integer.valueof(commline1.GE_PRM_Term__c);
        addedum1.GE_PRM_Master_Agreement__c=master1.id;
        addedum1.status='Executed';
        addedum1.GE_PRM_Channel_Appointment_ID__c=ChApp1.id;
        if(commline1.GE_PRM_Term__c!=null)
            addedum1.GE_OG_Contract_End_Date__c = addedum.StartDate.addmonths(integer.valueof(commline1.GE_PRM_Term__c));
        if(commline1.GE_PRM_Inclusions_exclusions_Add_comment__c =='yes')
        {
            addedum1.GE_PRM_Limitations_exclusions__c=true;
        }
        else if(commline1.GE_PRM_Inclusions_exclusions_Add_comment__c =='no')
        {
            addedum1.GE_PRM_Limitations_exclusions__c=false;
        }
        if(commline1.GE_PRM_Any_Exclusions__c=='yes')
        {
            addedum1.GE_PRM_Exclusions__c=true;
        }
        else if(commline1.GE_PRM_Any_Exclusions__c=='no')
        {
            addedum1.GE_PRM_Exclusions__c=false;
        }

        addedum1.GE_PRM_Primary_Sales_Channel_Manager__c =commline1.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
        addedum1.GE_PRM_Region__c =commline1.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
        addedum1.Termination_Email__c = true;
        contractstoinsert.add(addedum1);
        Contract NRTaddedum=new  Contract();
        // NRTaddedum.GE_PRM_Commercial_line__c = commline1.Id;
        NRTaddedum.RecordTypeId=contractRecordTypeAddedumId;
        NRTaddedum.AccountId = ObjAcc.id; 
        NRTaddedum.GE_ES_User_Lead_Sales_Person__c =commline1.GE_PRM_Sales_Manager__c;
        NRTaddedum.GE_PRM_Business_Tier_1__c = commline2.GE_PRM_Tier_1__c;
        NRTaddedum.GE_PRM_Tier_2__c =commline2.GE_PRM_Tier_2__c;
        NRTaddedum.GE_PRM_Tier_3__c= commline2.GE_PRM_Tier_3__c;
        NRTaddedum.GE_PRM_Tier_4__c =commline2.GE_PRM_Tier_4__c;
        NRTaddedum.GE_PRM_Tier_5__c= commline2.GE_PRM_Tier_5__c;
        NRTaddedum.GE_PRM_If_flat_Pricing__c= commline2.GE_PRM_If_flat_Pricing__c;
        NRTaddedum.GE_PRM_If_schedule_Max_Pricing__c= commline2.GE_PRM_If_schedule_Max_Pricing__c;
        NRTaddedum.GE_PRM_If_schedule_Min_Pricing__c= commline2.GE_PRM_If_schedule_Min_Pricing__c;
        NRTaddedum.GE_PRM_Industries__c= commline2.GE_PRM_Industries__c;
        NRTaddedum.GE_PRM_Buyers__c= commline2.GE_PRM_Buyers__c;
        NRTaddedum.GE_PRM_Channel_Appointment_ID__c=commline2.GE_PRM_Channel_Appointment__r.id;
        NRTaddedum.GE_PRM_Authorized_Country__c =commline2.GE_PRM_Authorized_Countries_1__c + ';'+ commline2.GE_PRM_Authorized_Countries_2__c;
        NRTaddedum.GE_PRM_State_Province_Region__c =commline2.GE_PRM_State_Province_Region__c;
        NRTaddedum.GE_PRM_Pricing__c= commline2.GE_PRM_Pricing__c;
        NRTaddedum.GE_PRM_Pricing_type__c=commline2.GE_PRM_Pricing_Type__c;
        NRTaddedum.GE_PRM_Nuclear_use__c=commline2.GE_PRM_Nuclear_use_Add_comment__c;
        NRTaddedum.GE_PRM_Military_use__c =commline2.GE_PRM_Military_use_Add_comment__c;
        NRTaddedum.GE_PRM_If_Brazil_SR_SC_core__c= commline2.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
        NRTaddedum.GE_PRM_If_Brazil_SR_CMPJ__c=commline1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
        NRTaddedum.GE_PRM_Inclusions_exclusions__c = commline2.GE_PRM_Inclusions_exclusions_Add_comment__c;
        NRTaddedum.GE_PRM_If_SR_sales_to_US_government__c =commline2.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
        NRTaddedum.GE_PRM_Comments__c =commline2.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
        NRTaddedum.GE_PRM_Commercial_Manager1__c=commline2.GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c;
        NRTaddedum.GE_PRM_Relationship_Type__c=commline2.GE_PRM_Type__c;
        NRTaddedum.StartDate =Date.today();
        NRTaddedum.ContractTerm = integer.valueof(commline1.GE_PRM_Term__c);
        NRTaddedum.GE_PRM_Master_Agreement__c=master1.id;
        NRTaddedum.status='Draft';
        NRTaddedum.GE_PRM_Channel_Appointment_ID__c=ChApp1.id;
        if(commline1.GE_PRM_Term__c!=null)
            NRTaddedum.GE_OG_Contract_End_Date__c = addedum.StartDate.addmonths(integer.valueof(commline1.GE_PRM_Term__c));
        if(commline1.GE_PRM_Inclusions_exclusions_Add_comment__c =='yes')
        {
            NRTaddedum.GE_PRM_Limitations_exclusions__c=true;
        }
        else if(commline1.GE_PRM_Inclusions_exclusions_Add_comment__c =='no')
        {
            NRTaddedum.GE_PRM_Limitations_exclusions__c=false;
        }
        if(commline1.GE_PRM_Any_Exclusions__c=='yes')
        {
            NRTaddedum.GE_PRM_Exclusions__c=true;
        }
        else if(commline1.GE_PRM_Any_Exclusions__c=='no')
        {
            NRTaddedum.GE_PRM_Exclusions__c=false;
        }

        NRTaddedum.GE_PRM_Primary_Sales_Channel_Manager__c =commline2.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
        NRTaddedum.GE_PRM_Region__c =commline2.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
        NRTaddedum.Termination_Email__c = true;
        contractstoinsert.add(NRTaddedum);  
                 
        User u = [Select Id From User Where Profile.Name = 'System Administrator' and isActive=True Limit 1 ];
        System.runAs(u){
            insert contractstoinsert;
        }
        Contract Renew_addedum=new  Contract(); 
        Renew_addedum.RecordTypeId=contractRecordTypeAddedumId;
        Renew_addedum.AccountId = ObjAcc.id; 
        Renew_addedum.GE_ES_User_Lead_Sales_Person__c =commline1.GE_PRM_Sales_Manager__c;
        Renew_addedum.GE_PRM_Business_Tier_1__c = commline2.GE_PRM_Tier_1__c;
        Renew_addedum.GE_PRM_Tier_2__c =commline2.GE_PRM_Tier_2__c;
        Renew_addedum.GE_PRM_Tier_3__c= commline2.GE_PRM_Tier_3__c;
        Renew_addedum.GE_PRM_Tier_4__c =commline2.GE_PRM_Tier_4__c;
        Renew_addedum.GE_PRM_Tier_5__c= commline2.GE_PRM_Tier_5__c;
        Renew_addedum.GE_PRM_If_flat_Pricing__c= commline2.GE_PRM_If_flat_Pricing__c;
        Renew_addedum.GE_PRM_If_schedule_Max_Pricing__c= commline2.GE_PRM_If_schedule_Max_Pricing__c;
        Renew_addedum.GE_PRM_If_schedule_Min_Pricing__c= commline2.GE_PRM_If_schedule_Min_Pricing__c;
        Renew_addedum.GE_PRM_Industries__c= commline2.GE_PRM_Industries__c;
        Renew_addedum.GE_PRM_Buyers__c= commline2.GE_PRM_Buyers__c;
        Renew_addedum.GE_PRM_Channel_Appointment_ID__c=commline2.GE_PRM_Channel_Appointment__r.id;
        Renew_addedum.GE_PRM_Authorized_Country__c =commline2.GE_PRM_Authorized_Countries_1__c + ';'+ commline2.GE_PRM_Authorized_Countries_2__c;
        Renew_addedum.GE_PRM_State_Province_Region__c =commline2.GE_PRM_State_Province_Region__c;
        Renew_addedum.GE_PRM_Pricing__c= commline2.GE_PRM_Pricing__c;
        Renew_addedum.GE_PRM_Pricing_type__c=commline2.GE_PRM_Pricing_Type__c;
        Renew_addedum.GE_PRM_Nuclear_use__c=commline2.GE_PRM_Nuclear_use_Add_comment__c;
        Renew_addedum.GE_PRM_Military_use__c =commline2.GE_PRM_Military_use_Add_comment__c;
        Renew_addedum.GE_PRM_If_Brazil_SR_SC_core__c= commline2.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
        Renew_addedum.GE_PRM_If_Brazil_SR_CMPJ__c=commline1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
        Renew_addedum.GE_PRM_Inclusions_exclusions__c = commline2.GE_PRM_Inclusions_exclusions_Add_comment__c;
        Renew_addedum.GE_PRM_If_SR_sales_to_US_government__c =commline2.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
        Renew_addedum.GE_PRM_Comments__c =commline2.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
        Renew_addedum.GE_PRM_Commercial_Manager1__c=commline2.GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c;
        Renew_addedum.GE_PRM_Relationship_Type__c=commline2.GE_PRM_Type__c;
        Renew_addedum.StartDate =Date.today();
        Renew_addedum.ContractTerm = integer.valueof(commline1.GE_PRM_Term__c);
        Renew_addedum.GE_PRM_Master_Agreement__c=master1.id;
        Renew_addedum.status='Under Renewal';
        Renew_addedum.GE_PRM_Channel_Appointment_ID__c=ChApp1.id;
        if(commline1.GE_PRM_Term__c!=null)
            Renew_addedum.GE_OG_Contract_End_Date__c = addedum.StartDate.addmonths(integer.valueof(commline1.GE_PRM_Term__c));
        if(commline1.GE_PRM_Inclusions_exclusions_Add_comment__c =='yes')
        {
            Renew_addedum.GE_PRM_Limitations_exclusions__c=true;
        }
        else if(commline1.GE_PRM_Inclusions_exclusions_Add_comment__c =='no')
        {
            Renew_addedum.GE_PRM_Limitations_exclusions__c=false;
        }
        if(commline1.GE_PRM_Any_Exclusions__c=='yes')
        {
            Renew_addedum.GE_PRM_Exclusions__c=true;
        }
        else if(commline1.GE_PRM_Any_Exclusions__c=='no')
        {
            Renew_addedum.GE_PRM_Exclusions__c=false;
        }

        Renew_addedum.GE_PRM_Primary_Sales_Channel_Manager__c =commline2.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
        Renew_addedum.GE_PRM_Region__c =commline2.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
        Renew_addedum.Termination_Email__c = true;
        Renew_addedum.GE_PRM_Old_Channel_Appointment_ID__c=addedum1.Id;
        Renew_addedum.GE_PRM_Renewal_Channel_Appointment_ID__c=addedum1.Id;
        System.runAs(u){
            insert Renew_addedum;
        }
        
    }
    private static void InsertGE_ES_Role()
    {
        lstGE_ES = new list<GE_ES_Role__c>();
        GE_ES_Role__c objGE_ES = new GE_ES_Role__c();
        objGE_ES.GE_PRM_Role__c = true;
        objGE_ES.Name = 'TestGE_ES - %';
        objGE_ES.GE_PRM_Approver_Type__c = 'CommercialApprovers';
        lstGE_ES.add(objGE_ES);
        
        GE_ES_Role__c objGE_ES1 = new GE_ES_Role__c();
        objGE_ES1.GE_PRM_Role__c = true;
        objGE_ES1.Name = 'TestGE_ES - %';
        objGE_ES1.GE_PRM_Approver_Type__c = 'High';
        lstGE_ES.add(objGE_ES1);
        
        GE_ES_Role__c objGE_ES2 = new GE_ES_Role__c();
        objGE_ES2.GE_PRM_Role__c = true;
        objGE_ES2.Name = 'TestGE_ES - %';
        objGE_ES2.GE_PRM_Approver_Type__c = 'Medium';
        lstGE_ES.add(objGE_ES2);
        
        GE_ES_Role__c objGE_ES3 = new GE_ES_Role__c();
        objGE_ES3.GE_PRM_Role__c = true;
        objGE_ES3.Name = 'TestGE_ES - %';
        objGE_ES3.GE_PRM_Approver_Type__c = 'Low';
        lstGE_ES.add(objGE_ES3);
        
        GE_ES_Role__c objGE_ES4 = new GE_ES_Role__c();
        objGE_ES4.GE_PRM_Role__c = true;
        objGE_ES4.Name = 'TestGE_ES - %';
        objGE_ES4.GE_PRM_Approver_Type__c = 'Termination';
        lstGE_ES.add(objGE_ES4 );
        
        insert lstGE_ES;
    }
    private static void InsertChannelApprover()
    {
        objApprover1 = new GE_PRM_Channel_Appointment_Approver__c();
        objApprover1.GE_PRM_Role__c ='Commercial 1';        
        objApprover1.GE_PRM_Channel_Appointment__c =ChApp1.id;        
        objApprover1.GE_PRM_Status__c = 'Need More Info';
        objApprover1.Terminate__c = false ;
        objApprover1.Non_Renewal__c = false ;
        objApprover1.GE_PRM_Comments_c__c ='test comment';
        ChannelApptApproverList.add(objApprover1);
        
        objApprover2 = new GE_PRM_Channel_Appointment_Approver__c();
        objApprover2.GE_PRM_Role__c ='Commercial 1';        
        objApprover2.GE_PRM_Channel_Appointment__c =ChApp1.id;        
        objApprover2.GE_PRM_Status__c = 'Pending';
        objApprover2.Terminate__c = false ;
        objApprover2.Non_Renewal__c = false ;
        objApprover2.GE_PRM_Comments_c__c ='test comment';
        ChannelApptApproverList.add(objApprover2);
        
        objApprover3 = new GE_PRM_Channel_Appointment_Approver__c();
        objApprover3.GE_PRM_Role__c ='Commercial 1';        
        objApprover3.GE_PRM_Channel_Appointment__c =ChApp1.id;        
        objApprover3.GE_PRM_Status__c = 'Approved';
        objApprover3.Terminate__c = false ;
        objApprover3.Non_Renewal__c = false ;
        objApprover3.GE_PRM_Comments_c__c ='test comment';
        ChannelApptApproverList.add(objApprover3);
        
        insert ChannelApptApproverList;
       
    }
    private static void insertCountry()
    {
        lstCountry = new list<GE_HQ_Country__c>();    
        GE_HQ_Country__c objCountry1 = new GE_HQ_Country__c();
        objCountry1.GE_HQ_ISO_Code__c='BG';
        objCountry1.GE_PRM_Adverse_Termination_Risk__c=34;
        objCountry1.name='BANGLADESH';
        objCountry1.GE_PRM_Channel_Risk_Type__c='High';
        lstCountry.add(objCountry1);
        
        GE_HQ_Country__c objCountry2= new GE_HQ_Country__c();
        
        objCountry2.GE_HQ_ISO_Code__c='GB';
        objCountry2.GE_PRM_Adverse_Termination_Risk__c=43;
        objCountry2.name='UNITED KINGDOM';
        objCountry2.GE_PRM_Channel_Risk_Type__c='Medium';
        lstCountry.add(objCountry2);
        
        insert lstCountry ;
    }
    private static void insertApprover()
    {
        objRecApprover= new GE_PRM_Recommendation_Approvers__c();
        objRecApprover.GE_PRM_Approver_Name__c =userinfo.getuserid();
        objRecApprover.GE_PRM_Tier_1_New__c = 'Oil & Gas';
        objRecApprover.GE_PRM_Tier_2__c ='Digital Solutions';
        objRecApprover.GE_PRM_Tier_3__c='Controls & Condition Monitoring';
        objRecApprover.GE_PRM_Region__c ='North America';
        objRecApprover.GE_PRM_Country__c ='United States';
        objRecApprover.GE_PRM_Role__c ='Commercial 1';
        objRecApprover.GE_PRM_Tier_4__c='Cyber Security';  
        objRecApprover.GE_PRM_ISO_Code__c ='US';
        insert objRecApprover;
        
    }
    

}