@isTest()
public class Test_Save_Send_Pdf {
   
    //It will cover----SaveSendPDF---class     

static testMethod  void SaveSendPDF_method(){
        Test.StartTest();
        List<GE_PRM_Channel_Appointment__c > ChAppList = new List<GE_PRM_Channel_Appointment__c >();
        String pdf;        
         List<Profile> pf = [Select id,name from Profile where name ='OG_Sales/Comm Ops' limit 1];
        // R-22629  GE_Profile__c myPartner = GE_Profile__c.getValues('Channel Partner Leader user - DR');        
       // Id chnlMagrId =  myChannelMgr.Profile_SFDC_ID__c;
        //  R-22629  Id chnlPartId =  myPartner.Profile_SFDC_ID__c;         
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId()];        
        User chnlManr = new User(firstname = 'channelll', lastname = 'managerrr', email = 'chnmanager1@ge.com', alias = 'chnUsrr1', profileId = pf[0].id, Title = 'Channel Manager', Username = 'channelmagr@ge.com.'+Math.random(), CommunityNickname = 'chuse'+Math.random(), TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        System.runAs (thisUser) {
            insert chnlManr;  
        }

        
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='Relationship Account' LIMIT 1];
        String recordTypeId = rt.id;
        String accountName = 'HierarchyTest';
        
        Account acc= new Account(name=accountName+'0', GE_HQ_Country_Code__c='RU',ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,RecordtypeId=rt.id,Type = 'Direct Customer', Classification__c = 'Strategic' );
        System.runAs(chnlManr){
            insert acc;
        }
        Contact DRCont = new Contact(GE_OG_Contact_Audience__c='Customer Care',firstname = 'test', lastname = 'partner', accountid = acc.Id, GE_ES_I_Agree_picklist__c='Yes', phone = '+7098767890',GE_PRM_Primary_Contact__c = true, Email = 'abc@abc.com');
        System.runAs(chnlManr){
          insert DRCont;   
        }           
       //  R-22629 User chnlpart = new User(GE_HQ_Tier_3_P_L__c = 'test', firstname = 'SR', lastname = 'Leader 2', email = 'channelpartner@ge.com',contactid = DRCont.id, alias = 'chnPtr', profileId = chnlPartId, Title = 'Channel Partner', Username = 'channelpartner@ge.com', CommunityNickname = 'chptr', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
       // R-22629 insert chnlpart;         
        GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
        ChApp.GE_PRM_Account_Name__c=acc.id;
        ChApp.GE_PRM_Current_Status__c= 'Approved'; 
        ChApp.GE_PRM_Master_appointment_type__c ='New';
        ChApp.GE_PRM_Primary_bank_account_country__c = 'UNITED KINGDOM ';
        ChApp.GE_PRM_Primary_bank_name_address__c = 'test';
        ChApp.GE_PRM_Primary_bank_contact__c = 'test';
        ChApp.GE_PRM_Primary_bank_account__c = 'test';
        ChApp.GE_PRM_Payment_term_requested__c= '30';
        ChApp.GE_PRM_Commercial_quali_rationale__c='abcde';
        ChApp.GE_PRM_Prior_growth_rating__c = 'Medium';
        ChApp.GE_PRM_Prior_year_commission_paid__c='New';
        ChApp.GE_PRM_Prior_performance_rating__c = 'Medium';
        ChApp.GE_PRM_Prior_year_orders__c = '<$100K';
        ChApp.GE_PRM_With_GE_since__c = 0;
        ChApp.GE_PRM_In_Business_Since__c = Date.today();
        ChApp.GE_PRM_Mandated_by_End_Customer__c = 'No';
        ChApp.GE_PRM_Convicted_of_any_felony_crims_r_s__c= 'No';
        ChApp.GE_PRM_Do_you_have_Officers_in_Gov__c= 'No';
        ChApp.GE_PRM_High_Risk_product_lines__c= 'No';
        ChApp.GE_PRM_Sell_to_Nuclear_industry__c= 'No';
        ChApp.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c= 'No';
        ChApp.GE_PRM_Does_Channel_Partner_have_subsid__c= 'No';
        ChApp.GE_PRM_Export_Controlled_products__c= 'No';
        ChApp.GE_PRM_Export_outside_own_country__c= 'No';
        ChApp.GE_PRM_Approved_exclusivity_from_P_L__c= 'No';
        ChApp.GE_PRM_Primary_Sales_Channel_Manager__c=chnlManr.id;
        ChApp.GE_PRM_Region_Sales_Channel_Leader__c=chnlManr.id;       
        ChApp.GE_PRM_Tier_2_P_L__c='Measurement & Control (M&C)';
        chApp.GE_PRM_Principal_contact__c = DRCont.id;
        ChApp.GE_PRM_Primary_Sales_Channel_Manager__c=chnlManr.id;
        System.runAs(chnlManr){
         insert ChApp;  
        }      
        System.assertEquals(ChApp.GE_PRM_Tier_2_P_L__c,'Measurement & Control (M&C)'); 
        Apexpages.currentpage().getparameters().put('id' ,ChApp.id);       
        PageReference pr= Page.GE_PRM_SaveSendPDF;        
        Blob pdffile;
        if (Test.IsRunningTest())
        {
            pdffile=Blob.valueOf('UNIT.TEST');
        }
        else
        {
            pdffile=pr.getContentAsPDF();
        }
        
        Attachment at = new Attachment();
        at.Name = 'Channel Appointment for test-.pdf';
        at.body=pdffile;
        at.ParentId =ChApp.id;
        System.runAs (chnlManr) {
           insert at;
        }
        SaveSendPDF controller=new SaveSendPDF(new ApexPages.StandardController(ChApp));
        controller.CAPDF=pdffile;
        controller.savepdf(pdffile);
        controller.goback();
        controller.sendEmail(pdffile); 
        controller.chAppID = ChApp.id;
        controller.GeneratePDF();       
        Test.StopTest();
    } 
    
    
    }