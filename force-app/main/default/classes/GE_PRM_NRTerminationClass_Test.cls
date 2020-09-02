@Istest
Public Class GE_PRM_NRTerminationClass_Test
{
    private static GE_PRM_Recommendation_Approvers__c objRecApprover;
    private static GE_ES_Role__c obj_esRole;
    Private static Account acc;
    private static GE_PRM_Channel_Appointment__c ChApp;
    private static GE_PRM_Commercial_line__c commline;
    private static Contract master;
    private static Contract addedum;
  
    static  void GE_PRM_NRTerminationClass_Test()
         {     
              String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
              String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
              profile myChannelMgr= [select id from profile where name = 'OG_Sales/Comm Ops' limit 1];
              Id chnlMagrId =  myChannelMgr.ID;
              User thisUser = [ select Id from User where Id = :UserInfo.getUserId()];        
              User chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUsrs', profileId = chnlMagrId, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
              System.runAs (thisUser) {
              insert chnlManr;
            }
                Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
                Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
                Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
                Id acc12=rtByName_acc1.getRecordTypeId();
                       
            acc=new Account();          
            acc.name = 'Test';
            acc.Account_Status__c = 'New';
            acc.GE_PW_Select_Type_of_Business__c = 'Government Agency';
            acc.GE_HQ_Site_Use_Code__c = 'BOTH';
            acc.Phone = '03332342345';
            acc.ShippingStreet = 'test'; 
            acc.ShippingCity = 'test';
            acc.ShippingState = 'test';
            acc.ShippingPostalCode = '1245521';
            acc.ShippingCountry = 'United States';
           // acc.GE_OG_Region_Tier1__c = Obj_Region.Id;
            acc.BillingCity = 'test';
            acc.BillingCountry = 'United States'; 
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
            acc.GE_PW_Country_Quote_To_Sold_To_HQ__c = 'United States';
            acc.GE_PW_Country_Bill_To__c = 'United States';
            acc.GE_PW_Country_Ship_To__c = 'United States';
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
            acc.GE_HQ_New_Account_Country__c = 'United States';   
            acc.GE_HQ_Country_Code__c = 'US';      
            insert acc; 
            System.assertEquals(acc.Name,'Test');                  
                                 
                 
            ChApp = new GE_PRM_Channel_Appointment__c();
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
            
            commline= new GE_PRM_Commercial_line__c();
            commline.GE_PRM_Channel_Appointment__c=ChApp.id;
            commline.GE_PRM_Status__c='New';       
            commline.GE_PRM_Tier_1__c='Oil & Gas';
            commline.GE_PRM_Tier_2__c='Digital Solutions';
            commline.GE_PRM_Tier_3__c='Controls & Condition Monitoring';
            commline.GE_PRM_Tier_4__c='Application';
            commline.GE_PRM_Tier_5__c= 'Test';
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
            
            system.debug('commercial line id--->'+commline.id);
            
            list<Contract>  contractstoinsert=new list<Contract>();
            master=new  Contract();
                        master.RecordTypeId= contractRecordTypeMasterId ;
                        master.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
                        master.accountid =ChApp.GE_PRM_Account_Name__c;
                        master.GE_PRM_Primary_Sales_Channel_Manager__c =ChApp.GE_PRM_Primary_Sales_Channel_Manager__c;
                        system.debug('commid--->'+ChApp.GE_PRM_Commercial_Manager__c);
                        master.GE_PRM_Commercial_Manager1__c=ChApp.GE_PRM_Commercial_Manager__c;
                        master.GE_PRM_Tier_2__c=ChApp.GE_PRM_Tier_2_P_L__c;
                        master.GE_PRM_Region__c=ChApp.GE_PRM_O_G_Region__c;
                        master.StartDate =Date.today();
                        master.status = 'Executed';
                        master.GE_PRM_For_Cause__c = 'Upon Notice';
                        master.GE_PRM_Without_Cause__c = '30 days';
                        master.GE_Contract_Specialist__c = chnlManr.ID; 
                        master.GE_PRM_Contract_Draft_date__c =Date.today();
                        master.GE_PRM_Contract_Sent_to_CP__c =Date.today();
                        master.GE_PRM_ASC_Signed_contract_received__c =Date.today();
                        master.GE_PRM_GE_Signatures_completed__c =Date.today();
                        master.GE_PRM_Close_out__c =Date.today();                                            
                       // contractstoinsert.add(master);
                       insert master;
                
              addedum=new  Contract();
                        addedum.GE_PRM_Commercial_line__c = commline.Id;
                        addedum.RecordTypeId=contractRecordTypeAddendumId;
                        addedum.AccountID=ChApp.GE_PRM_Account_Name__c;
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
                        addedum.GE_PRM_Channel_Appointment_ID__c=commline.GE_PRM_Channel_Appointment__r.id;
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
                        addedum.ContractTerm = integer.valueof(commline.GE_PRM_Term__c);                                    
                        addedum.GE_PRM_Primary_Sales_Channel_Manager__c =commline.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
                        addedum.GE_PRM_Region__c =commline.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
                        addedum.status = 'Executed';
                        addedum.GE_PRM_Master_Agreement__c = master.ID ;
                        addedum.GE_OG_Contract_End_Date__c = Date.today();                      
                        addedum.GE_PRM_For_Cause__c = 'Upon Notice';
                        addedum.GE_PRM_Without_Cause__c = '30 Days';
                        addedum.GE_Contract_Specialist__c = UserInfo.getUserId();
                        addedum.GE_PRM_Governing_Law__c = 'England and Wales';
                        addedum.GE_PRM_Arbitration_location__c = 'London England';
                        addedum.GE_PRM_Contract_Draft_date__c = System.Today();
                        addedum.GE_PRM_GE_Confirmed_Date__c =System.Today();
                        addedum.GE_PRM_Contract_Sent_to_CP__c =System.Today();
                        addedum.GE_PRM_ASC_Signed_contarct_received__c = System.Today();
                        addedum.GE_PRM_GE_Signatures_completed__c= System.Today();   
                        addedum.CurrencyIsoCode = 'USD';
                        addedum.GE_OG_Legal_Entity__c = 'GE Oil & Gas Compression Systems LLC';
                        addedum.GE_PRM_Close_out__c = System.Today();                 
                       // contractstoinsert.add(addedum);
                        insert addedum;
            GE_PRM_Channel_Appointment_Approver__c caa = new GE_PRM_Channel_Appointment_Approver__c();  
                caa.GE_PRM_Channel_Appointment__c = ChApp.id;
                caa.Commercial_line__c = commline.id;
                caa.GE_PRM_Status__c ='Draft';
                caa.GE_PRM_Tier_3__c ='Bently Nevada';
                caa.GE_PRM_Tier_2__c ='Measurement & Control (M&C)';
                caa.Terminate__c = false;
                caa.GE_PRM_Role__c= 'Commercial 1';
                caa.GE_PRM_Region__c = 'US North';
                caa.Non_Renewal__c = true;
                caa.GE_PRM_Approvers__c = userinfo.getuserid();
                insert caa;
                 
         
           User u1 = [Select ID From User where isActive=true and Profile.Name ='System Administrator' Limit 1];
           System.runas(u1)
             {
             //  insert contractstoinsert ;       
             }
           System.debug('&&&&&&&------Contracts-->'+addedum);
        }
       private static void insert_EsRole()
          {
            obj_esRole= new GE_ES_Role__c();
            obj_esRole.Name = 'Commercial 1';
            obj_esRole.GE_PRM_Approver_Type__c = 'Termination';
            obj_esRole.GE_PRM_Role__c = true;
            obj_esRole.GE_PRM_Role_Type__c = 'P&L';        
            insert obj_esRole; 
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
            objRecApprover.GE_PRM_ISO_Code__c ='US';
            insert objRecApprover;        
        }
     static testmethod void ValidateException_GE_PRM_NRTerminationClass()
        {            
            Test.startTest();  
            GE_PRM_NRTerminationClass_Test();
            Apexpages.currentpage().getparameters().put('id',ChApp.id);             
            ApexPages.currentPage().getParameters().put('clineid', commline.id); 
            List<GE_PRM_Commercial_line__c> Listcmline = [Select id,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_1__c,GE_PRM_Tier_5__c,GE_PRM_Type__c,GE_PRM_Channel_Appointment__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c from GE_PRM_Commercial_line__c];
             
            GE_PRM_NRTerminationClass NRTerminationClass1 = new GE_PRM_NRTerminationClass(new ApexPages.StandardController(commline));
           
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
            NRTerminationClass1.cmdcancel();
            Test.stopTest();         
        }        
     static testmethod void Validate_GE_PRM_NRTerminationClass()
        {
            Test.startTest();  
            GE_PRM_NRTerminationClass_Test();
            Apexpages.currentpage().getparameters().put('id',ChApp.id);             
            ApexPages.currentPage().getParameters().put('clineid', commline.id);  
            system.debug('^^^^^^^^^^^^^^^^'+addedum.Id);          
            GE_PRM_NRTerminationClass NRTerminationClass1 = new GE_PRM_NRTerminationClass(new ApexPages.StandardController(commline));               
            NRTerminationClass1.commline.GE_PRM_Non_Renewal_or_Termination__c ='Termination';
            NRTerminationClass1.commline.GE_PRM_Future_market_coverage__c='Direct';
            NRTerminationClass1.commline.GE_PRM_Proposed_effective_date__c=system.Today()+1;
            NRTerminationClass1.commline.GE_PRM_Due_To_Compliance_Issue__c='No';           
            NRTerminationClass1.commline.GE_PRM_Is_there_contracts_T_C_risk__c='No';
            NRTerminationClass1.commline.GE_PRM_outstanding_receivables__c='No';
            NRTerminationClass1.commline.GE_PRM_Outstanding_Payments__c='No';
            NRTerminationClass1.commline.GE_PRM_any_GE_equipment_to_return__c='No';
            NRTerminationClass1.commline.GE_PRM_Authorized_to_sell_other__c='No';
            NRTerminationClass1.commline.Non_renewal_Termination_Rationale__c='Non renewal';
            commline.GE_PRM_Status__c = 'Under NR/T';           
           // update cmline;
            NRTerminationClass1.cmdSubmit();      
            Test.stopTest();               
        }   
        
      static testmethod void Validate_cancel()
        {
            Test.startTest();  
            GE_PRM_NRTerminationClass_Test();
            Apexpages.currentpage().getparameters().put('id',ChApp.id);             
            ApexPages.currentPage().getParameters().put('clineid', commline.id);  
            system.debug('^^^^^^^^^^^^^^^^'+addedum.Id);          
            GE_PRM_NRTerminationClass NRTerminationClass1 = new GE_PRM_NRTerminationClass(new ApexPages.StandardController(commline));
            NRTerminationClass1.cmdcancel();   
         } 
      static testmethod void Validate_Getapprovers()
        {
            Test.startTest();  
            GE_PRM_NRTerminationClass_Test();
            Apexpages.currentpage().getparameters().put('id',ChApp.id);             
            ApexPages.currentPage().getParameters().put('clineid', commline.id);  
            List<GE_PRM_Commercial_line__c> Listcmline = [Select id,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_1__c,GE_PRM_Tier_5__c,GE_PRM_Type__c,GE_PRM_Channel_Appointment__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c from GE_PRM_Commercial_line__c Where Id=:commline.Id];
            system.debug('^^^^^^^^^^^^^^^^'+addedum.Id);          
            GE_PRM_NRTerminationClass NRTerminationClass1 = new GE_PRM_NRTerminationClass(new ApexPages.StandardController(commline));
            insert_EsRole();
            insertApprover();
            NRTerminationClass1.Getapprovers(Listcmline,'Non-Renewal');
            NRTerminationClass1.Getapprovers(Listcmline,'Termination');  
         }
}