@isTest
    public class GE_PRM_Commercial_Lines_Class_Test{
    public User chnlManr ;
    public GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
    
    @testSetup static void PrepareTestData() {

            list<Account> lstacc = new list<Account> ();
            List<GE_PRM_Commercial_line__c>    lstCommLine = new List<GE_PRM_Commercial_line__c>(); 
            List<GE_PRM_Channel_Appointment__c > ChAppList = new List<GE_PRM_Channel_Appointment__c >();
            List<GE_HQ_Country__c> List_GE_HQ_Country = new List<GE_HQ_Country__c>();
            String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
            
            //commented by rahul maurya #CM-034396
            List<profile> myChannelMgr = new list<profile>();
            myChannelMgr = [select id from profile where name = 'OG_Sales/Comm Ops' limit 1];
            Id chnlMagrId;
            User chnlManr;
             if(myChannelMgr!= null && myChannelMgr.size()>0)
             {
                chnlMagrId =  myChannelMgr[0].ID;
                chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUssr', profileId = chnlMagrId, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
                insert chnlManr;
             }    
            Account acc=new Account();          
            acc.name = 'Test';
            acc.GE_HQ_Request_Status__c = 'New';
            acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
            acc.GE_HQ_Site_Use_Code__c = 'BOTH';
            acc.Phone = '03332342345';
            acc.ShippingStreet = 'test'; 
            acc.ShippingCity = 'test';
            acc.ShippingState = 'test';
            acc.ShippingPostalCode = '1245521';
            acc.ShippingCountry = 'UNITED KINGDOM';
            acc.BillingCity = 'test';
            acc.BillingCountry = 'UNITED KINGDOM'; 
            acc.BillingPostalCode = '1235412';
            acc.BillingState = 'test';
            acc.BillingStreet = 'test';
            acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
            acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
            acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
            acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
            acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
            acc.GE_PW_Street_Bill_To__c = 'test';
            acc.GE_PW_City_Bill_To__c = 'test';
            acc.GE_PW_State_Province_Bill_To__c = 'test'; 
            acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
            acc.GE_PW_Street_Ship_To__c = 'test';
            acc.GE_PW_City_Ship_To__c = 'test';
            acc.GE_PW_State_Province_Ship_To__c = 'test'; 
            acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
            acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'TOGO';
            acc.GE_PW_Country_Bill_To__c = 'TOGO';
            acc.GE_PW_Country_Ship_To__c = 'TOGO';
            acc.GE_PW_Send_to_CMF_Bill_To__c = true;
            acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
            acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
            acc.GE_PW_Latitude_Bill_To__c = '10.242454';
            acc.GE_PW_Longitude_Bill_To__c = '20.041244';
            acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
            acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
            acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
            acc.GE_PW_Longitude_Ship_To__c = '2.012255';
            acc.GE_PW_Phone_Bill_To__c = '0212142121';
            acc.GE_PW_Phone_Ship_To__c = '020124512';
            acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
            acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
            acc.GE_HQ_DB_DUNS__c = '254123452';
            acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
            acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
            acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
            acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
            acc.GE_HQ_New_Account_City__c = 'test';
            acc.GE_HQ_New_Account_Street__c = 'test';
            acc.GE_HQ_New_Account_State_Province__c = 'test';
            acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
            acc.GE_HQ_New_Account_Country__c = 'UNITED KINGDOM'; 
            acc.GE_HQ_Country_Code__c = 'GB';    
            System.runAs(chnlManr)  {   
            insert acc; 
            }
            System.assertEquals(acc.Name,'Test');                  
            
             
           
                 
            GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
            ChApp.GE_PRM_Account_Name__c=acc.id;
            ChApp.GE_PRM_Current_Status__c= 'Approved'; 
            ChApp.GE_PRM_Master_appointment_type__c ='New';
            ChApp.GE_PRM_Primary_bank_account_country__c = 'BANGLADESH';
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
            System.runAs(chnlManr)  {               
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
            commline.GE_PRM_Authorized_to_sell_other__c = 'test1' ;
            commline.GE_PRM_Pricing_Type__c='Flat';            
            lstCommLine.add( commline);

            GE_PRM_Commercial_line__c commline2= new GE_PRM_Commercial_line__c(); 
            commline2.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline2.GE_PRM_Status__c='New';       
            commline2.GE_PRM_Tier_1__c='Oil & Gas (O&G)';
            commline2.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
            commline2.GE_PRM_Tier_3__c='Bently Nevada';
            commline2.GE_PRM_Tier_4__c='Application';
            commline2.GE_PRM_Type__c='Sales Representative';
            commline2.GE_PRM_If_Services_pick_type__c='MARC';
            commline2.GE_PRM_Term__c=8;
            commline2.GE_PRM_If_flat_pricing__c=80;
            commline2.GE_PRM_Is_this_linked_to_project_oppty__c='No';
            commline2.GE_PRM_Military_use_Add_comment__c='No';
            commline2.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
            commline2.GE_PRM_Nuclear_use_Add_comment__c='No';
            commline2.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
            commline2.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
            commline2.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM';
            commline2.GE_PRIf_Sales_Rep_sales_to_US_Government__c = 'Yes';
            commline2.GE_PRM_if_Yes_provide_comments_SlaesRep__c = 'test';
            commline.GE_PRM_Due_To_Compliance_Issue__c = 'test2' ;            
            commline2.GE_PRM_Term__c = 2;   
            commline2.GE_PRM_Pricing_Type__c='Schedule';
            lstCommLine.add(commline2);  
            System.runAs(chnlManr)  {               
            insert lstCommLine;  
            }
            
            GE_HQ_Country__c primarybankIsoCode1 = new GE_HQ_Country__c();
            
            primarybankIsoCode1.GE_HQ_ISO_Code__c='BG';
            primarybankIsoCode1.name='BANGLADESH';
            primarybankIsoCode1.GE_PRM_Channel_Risk_Type__c='High';
            System.runAs(chnlManr)  {   
            List_GE_HQ_Country.add(primarybankIsoCode1);
            }
                
            GE_HQ_Country__c primarybankIsoCode2 = new GE_HQ_Country__c();
                
            primarybankIsoCode2.GE_HQ_ISO_Code__c='GB';
            primarybankIsoCode2.name='UNITED KINGDOM';
            primarybankIsoCode2.GE_PRM_Channel_Risk_Type__c='Medium';
            List_GE_HQ_Country.add(primarybankIsoCode2);
                
            GE_HQ_Country__c primarybankIsoCode3 = new GE_HQ_Country__c();                
            primarybankIsoCode3.GE_HQ_ISO_Code__c='In';
            primarybankIsoCode3.name='India';
            primarybankIsoCode3.GE_PRM_Channel_Risk_Type__c='Low';
            List_GE_HQ_Country.add(primarybankIsoCode3);
            System.runAs(chnlManr)  {
            insert List_GE_HQ_Country ;
            }   
            GE_PRM_CL_UpdateField__c gecl = New GE_PRM_CL_UpdateField__c ();
            gecl.Name = 'Test1';
            gecl.APIName__c = 'GE_PRM_Due_To_Compliance_Issue__c';
            gecl.IsCommercialUpdated__c = true;
            gecl.IsComplaincelUpdated__c = true;
            System.runAs(chnlManr)  {
            insert gecl;
            }           

    }

     testMethod static void commerciallinesTest1(){  
        List<GE_PRM_Commercial_line__c> lstCommLine =  [select Id, GE_PRM_Status__c,         
                                   GE_PRM_Relationship_expiry_date__c,              
                                   GE_PRM_Tier_1__c,  
                                   GE_PRM_Tier_2__c,
                                   GE_PRM_Tier_3__c,
                                   GE_PRM_Tier_4__c,
                                   GE_PRM_Tier_5__c, 
                                   GE_PRM_Comments_New_acquisition__c,
                                   GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c,
                                   GE_PRM_Sales_Manager__c,
                                   GE_PRM_Type__c,
                                   GE_PRM_If_Services_pick_type__c,                               
                                   GE_PRM_State_Province_Region__c,
                                   GE_PRM_Pricing__c,     
                                   GE_PRM_Pricing_Type__c,
                                   GE_PRM_If_schedule_Max_pricing__c,
                                   GE_PRM_If_schedule_Min_pricing__c,
                                   GE_PRM_If_flat_pricing__c,
                                   GE_PRM_Term__c,
                                   GE_PRM_Current_year_target__c,
                                   GE_PRM_Next_year_target__c,
                                   GE_PRM_Is_this_linked_to_project_oppty__c,
                                   GE_PRM_If_yes_provide_Opporty_Project_Id__c,
                                   GE_PRM_Nuclear_use_Add_comment__c,
                                   GE_PRM_Military_use_Add_comment__c,
                                   GE_PRM_Inclusions_exclusions_Add_comment__c,
                                   GE_PRIf_Sales_Rep_sales_to_US_Government__c,
                                   GE_PRM_Buyers__c,
                                   GE_PRM_Industries__c                               
                                   ,GE_PRM_if_Yes_provide_comments_SlaesRep__c,
                                   GE_PRM_any_GE_equipment_to_return__c,
                                   GE_PRM_Authorized_to_sell_other__c,
                                   GE_PRM_Due_To_Compliance_Issue__c,
                                   GE_PRM_If_authorized_to_sell_other_Yes__c,
                                   GE_PRM_If_due_to_Compliance_issue_Yes__c,
                                   GE_PRM_If_GE_Equipment_to_return_Yes__c,
                                   GE_PRM_If_Is_there_contracts_T_C_Yes__c,
                                   GE_PRM_If_Outstanding_Payments_Yes__c,
                                   GE_PRM_If_outstanding_receivable_Yes__c,
                                   GE_PRM_Is_there_contracts_T_C_risk__c,
                                   GE_PRM_Non_Renewal_or_Termination__c,
                                   GE_PRM_Outstanding_Payments__c,
                                   GE_PRM_outstanding_receivables__c,
                                   GE_PRM_Proposed_effective_date__c,
                                   GE_PRM_Future_market_coverage__c,
                                   Non_renewal_Termination_Rationale__c ,   
                                    GE_PRM_Channel_Appointment__c
                                   from GE_PRM_Commercial_line__c LIMIT 2];
                                   
            GE_PRM_Channel_Appointment__c ChApp = [select id from GE_PRM_Channel_Appointment__c  limit 1 ]; 
            PageReference pageRef = Page.GE_PRM_CommercialLines_Details;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('ChannelAppointmentId', ChApp.id);
            ApexPages.currentPage().getParameters().put('Id', lstCommLine[0].id);        
            GE_PRM_Commercial_Lines_Class  controller = new GE_PRM_Commercial_Lines_Class (new ApexPages.StandardController(lstCommLine[0]));
            Test.StartTest();        
            controller.getItems();             
            PageReference nextPage = controller.saveCommercialLineDetails();                      
            ApexPages.currentPage().getParameters().put('clone', 'true');
            ApexPages.currentPage().getParameters().put('isadditonal', 'addCL');
            nextPage = controller.saveCommercialLineDetails();
            nextPage = controller.backToChApp(); 
            ApexPages.currentPage().getParameters().put('fromviewpage', 'true');
            nextPage = controller.cancel();
            ApexPages.currentPage().getParameters().put('isNew', 'true');
            ApexPages.currentPage().getParameters().put('fromviewpage', 'false');
            ApexPages.currentPage().getParameters().put('Id', lstCommLine[1].id); 
            controller = new GE_PRM_Commercial_Lines_Class (new ApexPages.StandardController(lstCommLine[1]));
            controller.isnew_CL_from_URL = 'true';
            nextPage = controller.cancel();            
            Test.StopTest();
     }
     
     
     testMethod static void commerciallinesTest2(){        
            Test.StartTest();
        //try{
        List<GE_PRM_Commercial_line__c> lstCommLine =  [select Id, GE_PRM_Status__c,         
                                   GE_PRM_Relationship_expiry_date__c,              
                                   GE_PRM_Tier_1__c,  
                                   GE_PRM_Tier_2__c,
                                   GE_PRM_Tier_3__c,
                                   GE_PRM_Tier_4__c,
                                   GE_PRM_Tier_5__c, 
                                   GE_PRM_Comments_New_acquisition__c,
                                   GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c,
                                   GE_PRM_Sales_Manager__c,
                                   GE_PRM_Type__c,
                                   GE_PRM_If_Services_pick_type__c,                               
                                   GE_PRM_State_Province_Region__c,
                                   GE_PRM_Pricing__c,     
                                   GE_PRM_Pricing_Type__c,
                                   GE_PRM_If_schedule_Max_pricing__c,
                                   GE_PRM_If_schedule_Min_pricing__c,
                                   GE_PRM_If_flat_pricing__c,
                                   GE_PRM_Term__c,
                                   GE_PRM_Current_year_target__c,
                                   GE_PRM_Next_year_target__c,
                                   GE_PRM_Is_this_linked_to_project_oppty__c,
                                   GE_PRM_If_yes_provide_Opporty_Project_Id__c,
                                   GE_PRM_Nuclear_use_Add_comment__c,
                                   GE_PRM_Military_use_Add_comment__c,
                                   GE_PRM_Inclusions_exclusions_Add_comment__c,
                                   GE_PRIf_Sales_Rep_sales_to_US_Government__c,
                                   GE_PRM_Buyers__c,
                                   GE_PRM_Industries__c                               
                                   ,GE_PRM_if_Yes_provide_comments_SlaesRep__c,
                                   GE_PRM_any_GE_equipment_to_return__c,
                                   GE_PRM_Authorized_to_sell_other__c,
                                   GE_PRM_Due_To_Compliance_Issue__c,
                                   GE_PRM_If_authorized_to_sell_other_Yes__c,
                                   GE_PRM_If_due_to_Compliance_issue_Yes__c,
                                   GE_PRM_If_GE_Equipment_to_return_Yes__c,
                                   GE_PRM_If_Is_there_contracts_T_C_Yes__c,
                                   GE_PRM_If_Outstanding_Payments_Yes__c,
                                   GE_PRM_If_outstanding_receivable_Yes__c,
                                   GE_PRM_Is_there_contracts_T_C_risk__c,
                                   GE_PRM_Non_Renewal_or_Termination__c,
                                   GE_PRM_Outstanding_Payments__c,
                                   GE_PRM_outstanding_receivables__c,
                                   GE_PRM_Proposed_effective_date__c,
                                   GE_PRM_Future_market_coverage__c,
                                   Non_renewal_Termination_Rationale__c ,   
                                    GE_PRM_Channel_Appointment__c
                                   from GE_PRM_Commercial_line__c LIMIT 2];
                                   
            GE_PRM_Channel_Appointment__c ChApp = [select id from GE_PRM_Channel_Appointment__c  limit 1 ]; 
            PageReference pageRef = Page.GE_PRM_CommercialLines_Details;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('ChannelAppointmentId', ChApp.id);
            ApexPages.currentPage().getParameters().put('Id', lstCommLine[0].id);     
            ApexPages.currentPage().getParameters().put('isadditonal', 'addCL');    
            GE_PRM_Commercial_Lines_Class  controller = new GE_PRM_Commercial_Lines_Class (new ApexPages.StandardController(lstCommLine[0]));
            String nextPage = controller.cancel().getUrl(); 
            
            ApexPages.currentPage().getParameters().put('fromviewpage', 'false');
            ApexPages.currentPage().getParameters().put('Id', lstCommLine[1].id); 
            ApexPages.currentPage().getParameters().put('isadditonal', 'no');  
            ApexPages.currentPage().getParameters().put('Status','New');
            controller = new GE_PRM_Commercial_Lines_Class (new ApexPages.StandardController(lstCommLine[1]));
            
            nextPage = controller.cancel().getUrl();
            controller.savenotes();
            Test.StopTest();
     }
     testMethod static void commerciallinesTest3(){        
            Test.StartTest();
            
            String AccRecordtype = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
             
            Account oGAct = new Account();
            oGAct.Name='TestAccount1';
            oGAct.GE_HQ_DUNS_Number__c='GEGUL9999';
            oGAct.Account_Tier_GEOG__c = 'Country';
            oGAct.recordtypeid = AccRecordtype;
            oGAct.Type = 'Direct Customer';
            oGAct.Classification__c = 'Strategic';
            insert oGAct; 

            Account acc=new Account();          
            acc.name = 'Test';
            acc.RecordTypeId = AccRecordtype;
            acc.GE_HQ_Request_Status__c = 'New';
            acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
            acc.GE_HQ_Site_Use_Code__c = 'BOTH';
            acc.Phone = '03332342345';
            acc.ShippingStreet = 'test'; 
            acc.ShippingCity = 'test';
            acc.ShippingState = 'test';
            acc.ShippingPostalCode = '1245521';
            acc.ShippingCountry = 'UNITED KINGDOM';
            acc.BillingCity = 'test';
            acc.BillingCountry = 'UNITED KINGDOM'; 
            acc.BillingPostalCode = '1235412';
            acc.BillingState = 'test';
            acc.BillingStreet = 'test';
            acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
            acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
            acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
            acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
            acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
            acc.GE_PW_Street_Bill_To__c = 'test';
            acc.GE_PW_City_Bill_To__c = 'test';
            acc.GE_PW_State_Province_Bill_To__c = 'test'; 
            acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
            acc.GE_PW_Street_Ship_To__c = 'test';
            acc.GE_PW_City_Ship_To__c = 'test';
            acc.GE_PW_State_Province_Ship_To__c = 'test'; 
            acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
            acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'TOGO';
            acc.GE_PW_Country_Bill_To__c = 'TOGO';
            acc.GE_PW_Country_Ship_To__c = 'TOGO';
            acc.GE_PW_Send_to_CMF_Bill_To__c = true;
            acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
            acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
            acc.GE_PW_Latitude_Bill_To__c = '10.242454';
            acc.GE_PW_Longitude_Bill_To__c = '20.041244';
            acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
            acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
            acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
            acc.GE_PW_Longitude_Ship_To__c = '2.012255';
            acc.GE_PW_Phone_Bill_To__c = '0212142121';
            acc.GE_PW_Phone_Ship_To__c = '020124512';
            acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
            acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
            acc.GE_HQ_DB_DUNS__c = '254123452';
            acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
            acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
            acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254';
            acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
            acc.GE_HQ_New_Account_City__c = 'test';
            acc.GE_HQ_New_Account_Street__c = 'test';
            acc.GE_HQ_New_Account_State_Province__c = 'test';
            acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
            acc.GE_HQ_New_Account_Country__c = 'UNITED KINGDOM'; 
            acc.GE_HQ_Country_Code__c = 'GB';   
            acc.Type = 'Direct Customer';
            acc.Classification__c = 'Strategic';
            acc.Oil_Gas_Parent_Account__c=oGAct.id;         
            insert acc; 
            
            List<GE_PRM_Channel_Appointment__c> lstchannelApt = new list<GE_PRM_Channel_Appointment__c>();
            
            GE_PRM_Channel_Appointment__c ChApp = new  GE_PRM_Channel_Appointment__c();
            ChApp.GE_PRM_Expirydate1__c= date.today();
            ChApp.GE_PRM_Current_Status__c= 'Draft'; 
            ChApp.GE_PRM_Account_Name__c=oGAct.id;
            ChApp.GE_PRM_Commercial_Account__c = acc.id;
            
            ChApp.GE_PRM_Master_appointment_type__c ='New';
            ChApp.GE_PRM_Primary_bank_account_country__c = 'BANGLADESH';
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
            ChApp.GE_PRM_IsApproved__c = true;
            lstchannelApt.add(ChApp);
            Insert ChApp;
            ChApp.GE_PRM_Current_Status__c= 'Approved';
             
            Update ChApp;
        
           List<GE_PRM_Commercial_line__c> lstCommLine = [select GE_PRM_Any_Exclusions__c, id,GE_PRM_Type__c,GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.Oil_Gas_Parent_Account__c, GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c,GE_PRM_Channel_Appointment__r.GE_PRM_GE_Account_Name__c,GE_PRM_Authorized_Countries_1__c,GE_PRM_Authorized_Countries_2__c,GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c,
                       GE_PRM_contract_genrated__c, GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c,GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,GE_PRM_State_Province_Region__c,
                       GE_PRM_if_Yes_provide_comments_SlaesRep__c,GE_PRM_Term__c,GE_PRM_Channel_Appointment__r.GE_PRM_Expirydate__c, GE_PRM_Pricing__c,GE_PRM_Pricing_Type__c,GE_PRM_Nuclear_use_Add_comment__c,GE_PRM_Sales_Manager__c,GE_PRM_Military_use_Add_comment__c,GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c,GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c,GE_PRM_Inclusions_exclusions_Add_comment__c,GE_PRIf_Sales_Rep_sales_to_US_Government__c
                       ,GE_PRM_If_flat_Pricing__c,GE_PRM_If_schedule_Max_Pricing__c, GE_PRM_If_schedule_Min_Pricing__c, GE_PRM_Industries__c, GE_PRM_Buyers__c 
                      ,ERP_Contact__c from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c in :lstchannelApt];
        
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
            commline.GE_PRM_Authorized_to_sell_other__c = 'test1' ;
            commline.GE_PRM_Pricing_Type__c='Flat';
            commline.GE_PRM_Channel_Appointment__c = ChApp.Id;
            
            lstCommLine.add( commline);

            insert lstCommLine;
            
            PageReference pageRef = Page.GE_PRM_CommercialLines_Details;
            Test.setCurrentPage(pageRef);
            
            ApexPages.currentPage().getParameters().put('ChannelAppointmentId', ChApp.id);
            ApexPages.currentPage().getParameters().put('Id', lstCommLine[0].id);   
               
            GE_PRM_Commercial_Lines_Class  controller = new GE_PRM_Commercial_Lines_Class (new ApexPages.StandardController(lstCommLine[0]));

            String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
            
            String contractRecordTypeAMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
            
            //Rahul Maurya code change start here//
            
            
            Contract addedum=new  Contract();
            addedum.GE_PRM_Commercial_line__c = commline.id;
            addedum.RecordTypeId=contractRecordTypeAMasterId;
            addedum.AccountID=acc.id;
            addedum.GE_PRM_Commercial_Account__c =acc.id;
            //addedum.GE_PRM_Channel_Appointment_ID__c =ChApp.Id;
            addedum.GE_ES_User_Lead_Sales_Person__c =commline.GE_PRM_Sales_Manager__c;
            addedum.GE_PRM_Business_Tier_1__c = commline.GE_PRM_Tier_1__c;
            addedum.GE_PRM_Tier_2__c =commline.GE_PRM_Tier_2__c;
            addedum.GE_PRM_Tier_3__c= commline.GE_PRM_Tier_3__c;
            addedum.GE_PRM_Tier_4__c =commline.GE_PRM_Tier_4__c;
            addedum.GE_PRM_Tier_5__c= commline.GE_PRM_Tier_5__c;
            addedum.GE_PRM_If_flat_Pricing__c= commline.GE_PRM_If_flat_Pricing__c;
            addedum.GE_PRM_If_schedule_Max_Pricing__c= commline.GE_PRM_If_schedule_Max_Pricing__c;
            addedum.GE_PRM_If_schedule_Min_Pricing__c= commline.GE_PRM_If_schedule_Min_Pricing__c;
            addedum.GE_PRM_Industries__c= commline.GE_PRM_Industries__c;
            addedum.GE_PRM_Buyers__c= commline.GE_PRM_Buyers__c;
            addedum.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
            addedum.GE_PRM_Authorized_Country__c =commline.GE_PRM_Authorized_Countries_1__c + ';'+ commline.GE_PRM_Authorized_Countries_2__c;
            addedum.GE_PRM_State_Province_Region__c =commline.GE_PRM_State_Province_Region__c;
            addedum.GE_PRM_Pricing__c= commline.GE_PRM_Pricing__c;
            addedum.GE_PRM_Pricing_type__c=commline.GE_PRM_Pricing_Type__c;
            addedum.GE_PRM_Nuclear_use__c=commline.GE_PRM_Nuclear_use_Add_comment__c;
            addedum.GE_PRM_Military_use__c =commline.GE_PRM_Military_use_Add_comment__c;
            addedum.GE_PRM_If_Brazil_SR_SC_core__c= commline.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
            addedum.GE_PRM_If_Brazil_SR_CMPJ__c=commline.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
            addedum.GE_PRM_Inclusions_exclusions__c = commline.GE_PRM_Inclusions_exclusions_Add_comment__c;
            addedum.GE_PRM_If_SR_sales_to_US_government__c =commline.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
            addedum.GE_PRM_Comments__c =commline.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
            addedum.GE_PRM_Commercial_Manager1__c=commline.GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c;
            addedum.GE_PRM_Relationship_Type__c=commline.GE_PRM_Type__c;
            addedum.StartDate =Date.today();
            //addedum.ContractTerm = integer.valueof(commline.GE_PRM_Term__c);
            
            insert addedum;
            
            
            
            controller.EditCommLine();
            controller.Checkstatus();
            controller.iscommercialupdated = true;
            controller.savenotes();
            
            controller.iscomplainceupdated= true;
            controller.savenotes();
            controller.BacktoCLview();
            
            // Rahul maurya change end here            
            
            list<GE_PRM_Channel_Appointment__c> CPAlist = new List<GE_PRM_Channel_Appointment__c>();
            Map<id,GE_PRM_Channel_Appointment__c> CPAoldlist = new Map<id,GE_PRM_Channel_Appointment__c>();
            CPAlist.add(ChApp);
            
            CPAoldlist.put(ChApp.id,ChApp);
            
            GE_PRM_GenerateContracts gr= new GE_PRM_GenerateContracts();
            gr.createcontracts(CPAlist,CPAoldlist);
            
            gr.updatecontract1(CPAlist);           
           
            Test.StopTest();
            
            //Joydeep
            GE_PRM_Commercial_line__c editedComLine = [ Select Id, GE_PRM_Authorized_Countries_2__c, GE_PRM_Authorized_Countries_1__c From  GE_PRM_Commercial_line__c where Id =: lstCommLine[0].Id ];
            
            editedComLine.GE_PRM_Authorized_Countries_2__c = 'UNITED STATES;UNITED KINGDOM;TURKEY';
            editedComLine.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS;INDIA';
            update editedComLine;
            
            controller.commercialLineObj = editedComLine;
            controller.Checkstatus();
            
     }
     testMethod static void commerciallinesTest4()
     {
        String AccRecordtype = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
             
            Account oGAct = new Account();
            oGAct.Name='TestAccount1';
            oGAct.GE_HQ_DUNS_Number__c='GEGUL9999';
            oGAct.Account_Tier_GEOG__c = 'Country';
            oGAct.recordtypeid = AccRecordtype;
            oGAct.Type = 'Direct Customer';
            oGAct.Classification__c = 'Strategic';
            insert oGAct; 

            Account acc=new Account();          
            acc.name = 'Test';
            acc.RecordTypeId = AccRecordtype;
            acc.GE_HQ_Request_Status__c = 'New';
            acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
            acc.GE_HQ_Site_Use_Code__c = 'BOTH';
            acc.Phone = '03332342345';
            acc.ShippingStreet = 'test'; 
            acc.ShippingCity = 'test';
            acc.ShippingState = 'test';
            acc.ShippingPostalCode = '1245521';
            acc.ShippingCountry = 'UNITED KINGDOM';
            acc.BillingCity = 'test';
            acc.BillingCountry = 'UNITED KINGDOM'; 
            acc.BillingPostalCode = '1235412';
            acc.BillingState = 'test';
            acc.BillingStreet = 'test';
            acc.GE_PW_Street_Quote_To_Sold_To_HQ__c = 'test';
            acc.GE_PW_Phone_Quote_To_Sold_To_HQ__c = '111111111';
            acc.GE_PW_City_Quote_To_Sold_To_HQ__c = 'test';
            acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c = 'test';
            acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c = 'test';
            acc.GE_PW_Street_Bill_To__c = 'test';
            acc.GE_PW_City_Bill_To__c = 'test';
            acc.GE_PW_State_Province_Bill_To__c = 'test'; 
            acc.GE_PW_Zip_Postal_Code_Bill_To__c = '2524525';
            acc.GE_PW_Street_Ship_To__c = 'test';
            acc.GE_PW_City_Ship_To__c = 'test';
            acc.GE_PW_State_Province_Ship_To__c = 'test'; 
            acc.GE_PW_Zip_Postal_Code_Ship_To__c = '2554852';
            acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'TOGO';
            acc.GE_PW_Country_Bill_To__c = 'TOGO';
            acc.GE_PW_Country_Ship_To__c = 'TOGO';
            acc.GE_PW_Send_to_CMF_Bill_To__c = true;
            acc.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = true;
            acc.GE_PW_Send_to_CMF_Ship_To__c = true;      
            acc.GE_PW_Latitude_Bill_To__c = '10.242454';
            acc.GE_PW_Longitude_Bill_To__c = '20.041244';
            acc.GE_PW_Latitude_Quote_To_Sold_To_HQ__c = '10.24245';
            acc.GE_PW_Longitude_Quote_To_Sold_To_HQ__c = '20.1255';
            acc.GE_PW_Latitude_Ship_To__c = '35.1044411';
            acc.GE_PW_Longitude_Ship_To__c = '2.012255';
            acc.GE_PW_Phone_Bill_To__c = '0212142121';
            acc.GE_PW_Phone_Ship_To__c = '020124512';
            acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c = false;
            acc.GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c = false;
            acc.GE_HQ_DB_DUNS__c = '254123452';
            acc.GE_PW_DB_DUNS_BillTo__c = '254215454';
            acc.GE_PW_DB_DUNS_New_Request__c = '235124542';
            acc.GE_PW_DB_DUNS_QuoteTo__c = '547254254'; 
            acc.GE_PW_DB_DUNS_ShipTo__c = '652150545';
            acc.GE_HQ_New_Account_City__c = 'test';
            acc.GE_HQ_New_Account_Street__c = 'test';
            acc.GE_HQ_New_Account_State_Province__c = 'test';
            acc.GE_HQ_New_Account_Zip_Postal_Code__c = '6757474';
            acc.GE_HQ_New_Account_Country__c = 'UNITED KINGDOM'; 
            acc.GE_HQ_Country_Code__c = 'GB';   
            acc.Type = 'Direct Customer';
            acc.Classification__c = 'Strategic';
            acc.Oil_Gas_Parent_Account__c=oGAct.id;         
            insert acc;  
            GE_PRM_Channel_Appointment__c ChApp = new  GE_PRM_Channel_Appointment__c();
            ChApp.GE_PRM_Expirydate1__c= date.today();
            ChApp.GE_PRM_Current_Status__c= 'Draft'; 
            ChApp.GE_PRM_Account_Name__c=oGAct.id;
            ChApp.GE_PRM_Commercial_Account__c = acc.id;
            
            ChApp.GE_PRM_Master_appointment_type__c ='Renewal';
            ChApp.GE_PRM_Primary_bank_account_country__c = 'BANGLADESH';
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
            ChApp.GE_PRM_IsApproved__c = true;
            
            Insert ChApp;
            ChApp.GE_PRM_Current_Status__c= 'Approved';
             
            Update ChApp;
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
            commline.GE_PRM_Authorized_to_sell_other__c = 'test1' ;
            commline.GE_PRM_Pricing_Type__c='Flat';
            commline.GE_PRM_Channel_Appointment__c = ChApp.Id;
            insert commline;
            
           PageReference pageRef = Page.GE_PRM_CommercialLines_Details;
            Test.setCurrentPage(pageRef);
            
            ApexPages.currentPage().getParameters().put('ChannelAppointmentId', ChApp.id);
            ApexPages.currentPage().getParameters().put('Id', commline.id);   
               
            GE_PRM_Commercial_Lines_Class  controller = new GE_PRM_Commercial_Lines_Class (new ApexPages.StandardController(commline));
            PageReference pgRef = controller.EditCommLine();
            Test.setCurrentPage(pgRef);
            GE_PRM_Commercial_line__c editedComLine = [ Select Id, GE_PRM_Authorized_Countries_2__c, GE_PRM_Authorized_Countries_1__c From  GE_PRM_Commercial_line__c where Id =: commline.Id ];
            
            editedComLine.GE_PRM_Authorized_Countries_2__c = 'UNITED STATES;UNITED KINGDOM;TURKEY';
            editedComLine.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS;INDIA';
            update editedComLine;
            
             ApexPages.currentPage().getParameters().put('Id', editedComLine.id); 
            controller.Checkstatus();
            //controller.GenerateRisk(ChApp.Id);
            
            
            
            
            
     }
     
  }