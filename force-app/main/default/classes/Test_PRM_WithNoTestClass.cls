@isTest(seealldata=true)
public class Test_PRM_WithNoTestClass {
/*
static testMethod  void Test_GEESDeleteApprovalsWhenSubmissionDeleted(){
    GE_ES_Checklist_Item_Submission__c g = [select id from GE_ES_Checklist_Item_Submission__c limit 1];
    delete g;
}
*/
static testMethod  void Test_GEESPopulateSICDesc(){
    account a = [select id from account limit 1];
    account a1 = a.clone(false, true);
    a1.Name = 'test';
    a1.GE_HQ_SIC1__c = 1;
    a1.GE_HQ_SIC2__c = 1;
    a1.GE_HQ_SIC3__c = 1;
    
    insert a1;
     a1.GE_HQ_SIC1__c = 2;
    a1.GE_HQ_SIC2__c = 2;
    a1.GE_HQ_SIC3__c = 2;
    update a1;
}    
static testMethod  void Test_GE_DS_BonusSheet(){
    contact c = [select id from contact limit 1];
    list<id> lstid = new list<id>();
    lstid.add(c.id);
    GE_DS_BonusSheet.sendEmail(lstid);
}    
static testMethod  void Test_GE_ES_CustomClone(){
   GE_ES_Custom_Clone__c gc = new GE_ES_Custom_Clone__c();
   gc.GE_ES_Object_Name__c = 'account';
   gc.GE_ES_Record_Type__c = 'CMF Approved';
   insert gc; 
   GE_ES_Custom_Clone_Detail__c gcdetail = new GE_ES_Custom_Clone_Detail__c();
   gcdetail.GE_ES_Custom_Clone__c = gc.id;
   Insert gcdetail; 
   account a = [select id from account where recordtype.Name = 'CMF Approved' limit 1]; 
   RecordType recordTypeId = [select Id, Name from RecordType where Name =:gc.GE_ES_Record_Type__c limit 1];
    PageReference pf = Page.GE_ES_CustomClone;        
    Test.setCurrentPage(pf);
    ApexPages.currentPage().getParameters().put('RecordTypeId', recordTypeId.id); 
    ApexPages.currentPage().getParameters().put('ParentId' , a.Id );
    GE_ES_CustomClone  cc = new GE_ES_CustomClone ();  
        
   // GE_ES_CustomClone cc = new GE_ES_CustomClone();

  //cc.cloneWithItems();  
}  
static testMethod  void Test_OG_FA_Content_Display_On_Contract(){
     RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
     String recordTypeId = rt.id;
     Account a= new Account(name='TestClassAccount', ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=recordTypeId );
     insert a;
     contract c = [select id from contract limit 1];
     contract Ogcontract =  c.clone(false,false);
     ogcontract.GE_OG_Evergreen__c = true;
     ogcontract.AccountId = a.id;
     insert ogcontract;
     OG_FA_Content_Display_On_Contract controller=new OG_FA_Content_Display_On_Contract(new ApexPages.StandardController(Ogcontract));
     controller.init();  
  
 }  

static testMethod  void GE_PRM_Channel_Appointment_Class_Method(){        
        List<GE_PRM_Channel_Appointment__c > ChAppList = new List<GE_PRM_Channel_Appointment__c >();
        //GE_Profile__c myChannelMgr = GE_Profile__c.getValues('GE_OG_PII Sales Manager');  -- commented related to bug 0000024161
        GE_Profile__c myChannelMgr = GE_Profile__c.getValues('Standard User');
        Id chnlMagrId =  myChannelMgr.Profile_SFDC_ID__c;
        User chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUsrs', profileId = chnlMagrId, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
        String recordTypeId = rt.id;
        Account acc= new Account(name='TestClassAccount', ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', 
         ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.',
         BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,
         GE_HQ_Country_Code__c='TS',recordtypeid=recordTypeId );
         insert acc;
         GE_HQ_Country__c  HQ_Country = new GE_HQ_Country__c();
         HQ_Country.GE_PRM_Risk_Score__c = 2;
         HQ_Country.GE_PRM_Adverse_Termination_Risk__c = 2;
         HQ_Country.GE_PRM_Channel_Risk_Type__c = 'High';
         HQ_Country.GE_HQ_ISO_Code__c = 'TS';
         HQ_Country.Name = 'HQ_Country';
         insert HQ_Country;
        
        
        System.assertEquals(acc.Name ,'TestClassAccount');      
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
        insert ChApp;
         
        System.assertEquals(ChApp.GE_PRM_Tier_2_P_L__c,'Measurement & Control (M&C)');
        System.debug('Channel Appointment ID'+ChApp.id);
        apexpages.currentpage().getparameters().put('id' ,ChApp.id);        
        GE_PRM_Commercial_line__c commline= new GE_PRM_Commercial_line__c();
        commline.GE_PRM_Channel_Appointment__c=ChApp.id;
        commline.GE_PRM_Status__c='New';       
        commline.GE_PRM_Tier_1__c='Oil & Gas (O&G)';
        commline.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
        commline.GE_PRM_Tier_3__c='Bently Nevada';
        commline.GE_PRM_Tier_4__c='Application';
        commline.GE_PRM_Type__c='Sales Representative';
        commline.GE_PRM_Channel_Appointment__c=ChApp.id;
        commline.GE_PRM_If_Services_pick_type__c='MARC';
        commline.GE_PRM_Term__c=8;
        commline.GE_PRM_If_flat_pricing__c=80;
        commline.GE_PRM_Is_this_linked_to_project_oppty__c='No';
        commline.GE_PRM_Military_use_Add_comment__c='No';
        commline.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
        commline.GE_PRM_Nuclear_use_Add_comment__c='No';
        commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
        commline.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
        commline.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM';        
        insert commline;
        System.assertEquals(commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c,'Standard');
        Sub_Dealer__c sdeal = new Sub_Dealer__c();
        sdeal.GE_PRM_Affiliate_dependent_type__c='Sub-Dealer';
        sdeal.GE_PRM_Authorized_commercial_lines__c='commercial';
        sdeal.GE_PRM_Channel_Appointment__c=ChApp.id;            
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
        
        Contract cont = new Contract();
        cont.GE_PRM_Commercial_line__c = commline.Id;
        cont.AccountId=acc.Id;
        insert cont;
        System.assertEquals(sdeal.GE_PRM_Prinicipal_Conatct_Text__c,'test');        
        GE_PRM_Channel_Appointment_Class controller=new GE_PRM_Channel_Appointment_Class(new ApexPages.StandardController(ChApp));
        controller.save();
        controller.generateCommerApp();       
        controller.addCommercialLines();
        controller.showmore();
        controller.addcontent();
        controller.edit();      
        controller.cancel();
        controller.back();        
        controller.getCommercialLines();  
        controller.editChannelAppointment(); 
        controller.addBranchOffice();
        controller.getBranchOffices();   
      //  controller.sendSLPolicyEmail();
        controller.Additionalcommline();
        test.starttest();
        controller.GenerateaddCommlinesAppr();
        controller.AddnCOmplApprovers();
        controller.GetComplainceApprovers();
        GE_PRM_GenerateContracts g = new GE_PRM_GenerateContracts();
        list<GE_PRM_Channel_Appointment__c> lstChAppt = new list<GE_PRM_Channel_Appointment__c>();
        lstChAppt.add(ChApp);
        GE_PRM_Channel_Appointment__c ChApp2 = ChApp.clone(false, true);
        ChApp2.GE_PRM_Current_Status__c = 'Submitted';
        insert ChApp2;
        Map<id,GE_PRM_Channel_Appointment__c> oldmapchappt = new Map<id,GE_PRM_Channel_Appointment__c>();
        oldmapchappt.put(ChApp.id, ChApp2);
        g.createcontracts(lstChAppt,oldmapchappt);
        test.stopTest();
    }     
    
    
   
}