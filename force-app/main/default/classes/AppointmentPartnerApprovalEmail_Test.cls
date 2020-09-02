@isTest
public class AppointmentPartnerApprovalEmail_Test{

    private static GE_PRM_Channel_Appointment__c ChApp1;
    private static Account ObjAcc;
    private static Account ObjCommAcc;
    private static COntact ObjCon;
     
    private static void InsertChannelAppointment()
    {
        InsertAccount();       
        InsertContact();
        ChApp1 = new GE_PRM_Channel_Appointment__c();
        ChApp1.GE_PRM_Master_appointment_type__c = 'Renewal';
        ChApp1.GE_PRM_Current_Status__c= 'New'; 
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
    private static void InsertAccount()
    {
        InsertCommercialAccount();
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rt = AccountRecordTypeInfo .get('CMF Approved').getRecordTypeId();
        //RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
        ObjAcc= new Account(name='TestAccount0',Oil_Gas_Parent_Account__c=ObjCommAcc.id, Account_Status__c='CC Approved',GE_HQ_Country_Code__c='BG',ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry = 'USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=rt, type='Direct Customer', Classification__c='Unclassified');
        
        insert ObjAcc;
        system.debug('ObjAcc='+ObjAcc);
    }
    private static void InsertContact()
        {           
            ObjCon = new Contact(Email='test@ge.com',AccountId=ObjCommAcc.id,firstname='testCon',LastName ='Test1',GE_OG_Contact_Audience__c = 'Sales / ITO');
            insert objCon;
            system.debug('objCon='+objCon);
        }
    
    static TestMethod void partnerTestMethod(){    
    //Test.startTest();   
        InsertChannelAppointment(); 
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        email.subject = 'Create Contact';
        email.fromAddress = 'someaddress@email.com';
        email.plainTextBody = 'approve email body\n2225256325\nTitle';
        
        
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'textfile.txt';
        attachment.mimeTypeSubType = 'text/plain';
    
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
        
        email.subject=ChApp1.id;
        AppointmentPartnerApprovalEmail testInbound=new AppointmentPartnerApprovalEmail();
        testInbound.handleInboundEmail(email, env);
        email.plainTextBody = 'modify email body\n2225256325\nTitle';
        testInbound.handleInboundEmail(email, env);
    }
}