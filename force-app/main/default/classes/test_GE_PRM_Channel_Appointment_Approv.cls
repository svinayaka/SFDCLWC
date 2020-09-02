@isTest
public class test_GE_PRM_Channel_Appointment_Approv {

   static testMethod  void GE_PRM_Channel_Appointment_Class_Method(){ 
   
         RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
        String recordTypeId = rt.id;
        String accountName = 'HierarchyTest';
        
        Account acc= new Account(name=accountName+'0', ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=recordTypeId );
        
        List<GE_PRM_Channel_Appointment__c > ChAppList = new List<GE_PRM_Channel_Appointment__c >();
        profile  chnlMagrId =  [select id from profile where name ='OG_Sales/Comm Ops' limit 1];
        User chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUsrs', profileId = chnlMagrId.id, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        //list<Account> lstacc = [select Id, Name from Account where recordtype.Name = 'CMF Approved' AND GE_HQ_Country_Code__c != null limit 10];      
        //account acc = lstacc[0]; 
        System.runAs(chnlManr){
         insert acc;
        }
        GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
            ChApp.GE_PRM_Account_Name__c=acc.id;
            ChApp.GE_PRM_Current_Status__c= 'Submitted'; 
            ChApp.GE_PRM_Master_appointment_type__c ='New';
            ChApp.GE_PRM_Primary_bank_account_country__c = 'UNITED States';
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
            System.runAs(chnlManr){  
            insert ChApp; 
           }
        GE_PRM_Commercial_line__c commline= new GE_PRM_Commercial_line__c();
            commline.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline.GE_PRM_Status__c='New';      
            commline.GE_PRM_Tier_1__c='Oil & Gas (O&G)';
            commline.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
            commline.GE_PRM_Tier_3__c='Bently Nevada';
            commline.GE_PRM_Tier_4__c='';
            commline.GE_PRM_Type__c='Sales Representative';
            commline.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline.GE_PRM_If_Services_pick_type__c='MARC';
            commline.GE_PRM_Term__c=0;
            commline.GE_PRM_If_flat_pricing__c=80;
            commline.GE_PRM_Is_this_linked_to_project_oppty__c='No';
            commline.GE_PRM_Military_use_Add_comment__c='No';
            commline.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
            commline.GE_PRM_Nuclear_use_Add_comment__c='No';
            commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
            commline.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
            commline.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM';
            commline.GE_PRM_Non_Renewal_or_Termination__c = 'Termination';
            commline.GE_PRM_Due_To_Compliance_Issue__c = 'test' ;
            commline.GE_PRM_Is_there_contracts_T_C_risk__c = 'test' ;
            commline.GE_PRM_outstanding_receivables__c = 'test' ;
            commline.GE_PRM_Outstanding_Payments__c = 'test' ;
            commline.GE_PRM_any_GE_equipment_to_return__c = 'test' ;
            commline.GE_PRM_Authorized_to_sell_other__c = 'test' ;
            commline.GE_PRM_Pricing_Type__c='Flat';
            System.runAs(chnlManr){  
            insert commline;
            }
        
         GE_PRM_Channel_Appointment_Approver__c apprvers1 =new GE_PRM_Channel_Appointment_Approver__c();
            apprvers1.GE_PRM_Role__c = 'Commercial1';
            apprvers1.GE_PRM_Region__c = 'test'; 
            apprvers1.GE_PRM_Country__c = 'United States';          
            apprvers1.GE_PRM_Status__c ='Pending';
            apprvers1.GE_PRM_Channel_Appointment__c= ChApp.id;
            apprvers1.GE_PRM_Tier_2__c= 'test';
            apprvers1.GE_PRM_Tier_3__c= 'test';
            apprvers1.Commercial_line__c = commline.id;
            System.runAs(chnlManr){  
            insert apprvers1;
            }
            string ChAFAApprovalId = string.valueof([select id from GE_PRM_Channel_Appointment_Approver__c limit 1].id);       
            PageReference ChApptapprvepageRef = Page.GE_PRM_ChApp_Approver_Edit_Override;
            Test.setCurrentPage(ChApptapprvepageRef);
            ApexPages.currentPage().getParameters().put('Id', ChAFAApprovalId);        
            GE_PRM_Channel_Appointment_Approver__c ChApprov = new  GE_PRM_Channel_Appointment_Approver__c();
            GE_PRM_Channel_Appointment_Approvers  chapprover = new GE_PRM_Channel_Appointment_Approvers(new ApexPages.StandardController(ChApprov));  
            chapprover.redirectChAppApproval();
            chapprover.goBack();
   }
   
   static testMethod  void GE_PRM_Channel_Appointment_Class_Method1(){    
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
        String recordTypeId = rt.id;
        String accountName = 'HierarchyTest';        
        Account acc= new Account(name=accountName+'0', ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=recordTypeId );
        List<GE_PRM_Channel_Appointment__c > ChAppList = new List<GE_PRM_Channel_Appointment__c >();
        profile  chnlMagrId =  [select id from profile where name ='OG_Sales/Comm Ops' limit 1];
        User chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUsrs', profileId = chnlMagrId.id, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        System.runAs(chnlManr){
         insert acc;
        }
        GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
            ChApp.GE_PRM_Account_Name__c=acc.id;
            ChApp.GE_PRM_Current_Status__c= 'Approved'; 
            ChApp.GE_PRM_Master_appointment_type__c ='New';
            ChApp.GE_PRM_Primary_bank_account_country__c = 'UNITED States';
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
            system.runAs(chnlManr){  
            insert ChApp;                             
         }
         GE_PRM_Commercial_line__c commline= new GE_PRM_Commercial_line__c();
            commline.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline.GE_PRM_Status__c='New';      
            commline.GE_PRM_Tier_1__c='Oil & Gas (O&G)';
            commline.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
            commline.GE_PRM_Tier_3__c='Bently Nevada';
            commline.GE_PRM_Tier_4__c='';
            commline.GE_PRM_Type__c='Sales Representative';
            commline.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline.GE_PRM_If_Services_pick_type__c='MARC';
            commline.GE_PRM_Term__c=0;
            commline.GE_PRM_If_flat_pricing__c=80;
            commline.GE_PRM_Is_this_linked_to_project_oppty__c='No';
            commline.GE_PRM_Military_use_Add_comment__c='No';
            commline.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
            commline.GE_PRM_Nuclear_use_Add_comment__c='No';
            commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
            commline.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
            commline.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM';
            commline.GE_PRM_Non_Renewal_or_Termination__c = 'Termination';
            commline.GE_PRM_Due_To_Compliance_Issue__c = 'test' ;
            commline.GE_PRM_Is_there_contracts_T_C_risk__c = 'test' ;
            commline.GE_PRM_outstanding_receivables__c = 'test' ;
            commline.GE_PRM_Outstanding_Payments__c = 'test' ;
            commline.GE_PRM_any_GE_equipment_to_return__c = 'test' ;
            commline.GE_PRM_Authorized_to_sell_other__c = 'test' ;
            commline.GE_PRM_Pricing_Type__c='Flat';
            system.runAs(chnlManr){  
            insert commline;
            }
        
        GE_PRM_Channel_Appointment_Approver__c apprvers1 =new GE_PRM_Channel_Appointment_Approver__c();
          //  apprvers.GE_PRM_Approvers__c = 'test';
            apprvers1.GE_PRM_Role__c = 'Commercial1';
            apprvers1.GE_PRM_Region__c = 'test'; 
            apprvers1.GE_PRM_Country__c = 'United States';
           // apprvers.GE_PRM_Delegated_User__c =userWithDelegatedUser.get(i.GE_PRM_Approver_Name__c);
            apprvers1.GE_PRM_Status__c ='Approved';
            apprvers1.GE_PRM_Channel_Appointment__c= ChApp.id;
            apprvers1.GE_PRM_Tier_2__c= 'test';
            apprvers1.GE_PRM_Tier_3__c= 'test';
            apprvers1.Commercial_line__c = commline.id;            
            system.runAs(chnlManr){  
            insert apprvers1;
            }
            string ChAFAApprovalId = string.valueof([select id from GE_PRM_Channel_Appointment_Approver__c limit 1].id);
            PageReference ChApptapprvepageRef = Page.GE_PRM_ChApp_Approver_Edit_Override;
            Test.setCurrentPage(ChApptapprvepageRef);
            ApexPages.currentPage().getParameters().put('Id', ChAFAApprovalId); 
            GE_PRM_Channel_Appointment_Approver__c ChApprov = new  GE_PRM_Channel_Appointment_Approver__c();
            GE_PRM_Channel_Appointment_Approvers  chapprover = new GE_PRM_Channel_Appointment_Approvers(new ApexPages.StandardController(ChApprov));  
            chapprover.redirectChAppApproval();
            chapprover.goBack();
       }
       
       static testMethod  void GE_PRM_Channel_Appointment_Class_Method2(){ 
   
         RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
         String recordTypeId = rt.id;
         String accountName = 'HierarchyTest';
        
        Account acc= new Account(name=accountName+'0', ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=recordTypeId );
        
        List<GE_PRM_Channel_Appointment__c > ChAppList = new List<GE_PRM_Channel_Appointment__c >();
        profile  chnlMagrId =  [select id from profile where name ='OG_Sales/Comm Ops' limit 1];
        User chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUsrs', profileId = chnlMagrId.id, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        //list<Account> lstacc = [select Id, Name from Account where recordtype.Name = 'CMF Approved' AND GE_HQ_Country_Code__c != null limit 10];      
        //account acc = lstacc[0]; 
        System.runAs(chnlManr){
         insert acc;
        }
        GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
            ChApp.GE_PRM_Account_Name__c=acc.id;
            ChApp.GE_PRM_Current_Status__c= 'Approved'; 
            ChApp.GE_PRM_Master_appointment_type__c ='New';
            ChApp.GE_PRM_Primary_bank_account_country__c = 'UNITED States';
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
            System.runAs(chnlManr){       
            insert ChApp; 
            }
         GE_PRM_Commercial_line__c commline= new GE_PRM_Commercial_line__c();
            commline.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline.GE_PRM_Status__c='New';      
            commline.GE_PRM_Tier_1__c='Oil & Gas (O&G)';
            commline.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
            commline.GE_PRM_Tier_3__c='Bently Nevada';
            commline.GE_PRM_Tier_4__c='';
            commline.GE_PRM_Type__c='Sales Representative';
            commline.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline.GE_PRM_If_Services_pick_type__c='MARC';
            commline.GE_PRM_Term__c=0;
            commline.GE_PRM_If_flat_pricing__c=80;
            commline.GE_PRM_Is_this_linked_to_project_oppty__c='No';
            commline.GE_PRM_Military_use_Add_comment__c='No';
            commline.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
            commline.GE_PRM_Nuclear_use_Add_comment__c='No';
            commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
            commline.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
            commline.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM';
            commline.GE_PRM_Non_Renewal_or_Termination__c = 'Termination';
            commline.GE_PRM_Due_To_Compliance_Issue__c = 'test' ;
            commline.GE_PRM_Is_there_contracts_T_C_risk__c = 'test' ;
            commline.GE_PRM_outstanding_receivables__c = 'test' ;
            commline.GE_PRM_Outstanding_Payments__c = 'test' ;
            commline.GE_PRM_any_GE_equipment_to_return__c = 'test' ;
            commline.GE_PRM_Authorized_to_sell_other__c = 'test' ;
            commline.GE_PRM_Pricing_Type__c='Flat';
            //commline.GE_PRIf_Sales_Rep_sales_to_US_Government__c='yes';
            System.runAs(chnlManr){
                insert commline;
            }
         GE_PRM_Channel_Appointment_Approver__c apprvers1 =new GE_PRM_Channel_Appointment_Approver__c();
          //  apprvers.GE_PRM_Approvers__c = 'test';
            apprvers1.GE_PRM_Role__c = 'Commercial1';
            apprvers1.GE_PRM_Region__c = 'test'; 
            apprvers1.GE_PRM_Country__c = 'United States';
           // apprvers.GE_PRM_Delegated_User__c =userWithDelegatedUser.get(i.GE_PRM_Approver_Name__c);
            apprvers1.GE_PRM_Status__c ='Need More Info';
            apprvers1.GE_PRM_Channel_Appointment__c= ChApp.id;
            apprvers1.GE_PRM_Tier_2__c= 'test';
            apprvers1.GE_PRM_Tier_3__c= 'test';
            apprvers1.Commercial_line__c = commline.id;
            apprvers1.GE_PRM_Comments_c__c='tEST';
            System.runAs(chnlManr){
            insert apprvers1;
            }
            string ChAFAApprovalId = string.valueof([select id from GE_PRM_Channel_Appointment_Approver__c limit 1].id);
       
         PageReference ChApptapprvepageRef = Page.GE_PRM_ChApp_Approver_Edit_Override;
         Test.setCurrentPage(ChApptapprvepageRef);
         ApexPages.currentPage().getParameters().put('Id', ChAFAApprovalId); 
       
        GE_PRM_Channel_Appointment_Approver__c ChApprov = new  GE_PRM_Channel_Appointment_Approver__c();
        GE_PRM_Channel_Appointment_Approvers  chapprover = new GE_PRM_Channel_Appointment_Approvers(new ApexPages.StandardController(ChApprov));  
             chapprover.redirectChAppApproval();
             chapprover.goBack();
          }
       
       static testMethod  void GE_PRM_Channel_Appointment_Class_Method3(){ 
   
         RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
         String recordTypeId = rt.id;
         String accountName = 'HierarchyTest';
        
        Account acc= new Account(name=accountName+'0', ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=recordTypeId );
        
        List<GE_PRM_Channel_Appointment__c > ChAppList = new List<GE_PRM_Channel_Appointment__c >();
        profile  chnlMagrId =  [select id from profile where name ='OG_Sales/Comm Ops' limit 1];
        User chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUsrs', profileId = chnlMagrId.id, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        User chnlManr1 = new User(firstname = 'chanel', lastname = 'managers', email = 'chanelmanagers@ge.com', alias = 'chnlUsr', profileId = chnlMagrId.id, Title = 'Channel Managers', Username = 'channelmanagrs@ge.com', CommunityNickname = 'chuses', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr1;
        System.runAs(chnlManr){
             insert acc;
        }
        //list<Account> lstacc = [select Id, Name from Account where recordtype.Name = 'CMF Approved' AND GE_HQ_Country_Code__c != null limit 10];      
        //account acc = lstacc[0]; 
        GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
            ChApp.GE_PRM_Account_Name__c=acc.id;
            ChApp.GE_PRM_Current_Status__c= 'Approved'; 
            ChApp.GE_PRM_Master_appointment_type__c ='New';
            ChApp.GE_PRM_Primary_bank_account_country__c = 'UNITED States';
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
            System.runAs(chnlManr){       
            insert ChApp; 
        }
        GE_PRM_Commercial_line__c commline= new GE_PRM_Commercial_line__c();
            commline.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline.GE_PRM_Status__c='New';      
            commline.GE_PRM_Tier_1__c='Oil & Gas (O&G)';
            commline.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
            commline.GE_PRM_Tier_3__c='Bently Nevada';
            commline.GE_PRM_Tier_4__c='';
            commline.GE_PRM_Type__c='Sales Representative';
            commline.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline.GE_PRM_If_Services_pick_type__c='MARC';
            commline.GE_PRM_Term__c=0;
            commline.GE_PRM_If_flat_pricing__c=80;
            commline.GE_PRM_Is_this_linked_to_project_oppty__c='No';
            commline.GE_PRM_Military_use_Add_comment__c='No';
            commline.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
            commline.GE_PRM_Nuclear_use_Add_comment__c='No';
            commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
            commline.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
            commline.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM';
            commline.GE_PRM_Non_Renewal_or_Termination__c = 'Termination';
            commline.GE_PRM_Due_To_Compliance_Issue__c = 'test' ;
            commline.GE_PRM_Is_there_contracts_T_C_risk__c = 'test' ;
            commline.GE_PRM_outstanding_receivables__c = 'test' ;
            commline.GE_PRM_Outstanding_Payments__c = 'test' ;
            commline.GE_PRM_any_GE_equipment_to_return__c = 'test' ;
            commline.GE_PRM_Authorized_to_sell_other__c = 'test' ;
            commline.GE_PRM_Pricing_Type__c='Flat';
            //commline.GE_PRIf_Sales_Rep_sales_to_US_Government__c='yes';
            System.runAs(chnlManr){
            insert commline;
           }
        GE_PRM_Channel_Appointment_Approver__c apprvers1 =new GE_PRM_Channel_Appointment_Approver__c();
          //  apprvers.GE_PRM_Approvers__c = 'test';
            apprvers1.GE_PRM_Role__c = 'Commercial1';
            apprvers1.GE_PRM_Region__c = 'test'; 
            apprvers1.GE_PRM_Country__c = 'United States';
           // apprvers.GE_PRM_Delegated_User__c =userWithDelegatedUser.get(i.GE_PRM_Approver_Name__c);
            apprvers1.GE_PRM_Status__c ='Need More Info';
            apprvers1.GE_PRM_Channel_Appointment__c= ChApp.id;
            apprvers1.GE_PRM_Tier_2__c= 'test';
            apprvers1.GE_PRM_Tier_3__c= 'test';
            apprvers1.Commercial_line__c = commline.id; 
            apprvers1.GE_PRM_Comments_c__c='tEST';
            System.runAs(chnlManr){ 
            insert apprvers1;
            }
            string ChAFAApprovalId = string.valueof([select id from GE_PRM_Channel_Appointment_Approver__c limit 1].id);
         System.runAs(chnlManr1)
           {
             PageReference ChApptapprvepageRef = Page.GE_PRM_ChApp_Approver_Edit_Override;
             Test.setCurrentPage(ChApptapprvepageRef);
             ApexPages.currentPage().getParameters().put('Id', ChAFAApprovalId); 
           
             GE_PRM_Channel_Appointment_Approver__c ChApprov = new  GE_PRM_Channel_Appointment_Approver__c();
             GE_PRM_Channel_Appointment_Approvers  chapprover = new GE_PRM_Channel_Appointment_Approvers(new ApexPages.StandardController(ChApprov));  
             chapprover.redirectChAppApproval();
             chapprover.goBack();
           }
       }
    
}