@isTest
public class GE_OG_PRM_ChannelApptTrigger_Test{


public User chnlManr ;

public GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
@testSetup static void PrepareTestData() {
GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
   list<Account> lstacc = new list<Account> ();
 List<GE_PRM_Commercial_line__c>    lstCommLine = new List<GE_PRM_Commercial_line__c>();
    GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
        
       profile  chnlMagrId =  [select id from profile where name ='OG_Sales/Comm Ops' limit 1];
        User chnlManr = new User(firstname = 'channel', lastname = 'manager', email = 'chnmanager@ge.com', alias = 'chnUsr', profileId = chnlMagrId.id, Title = 'Channel Manager', Username = 'channelmagr@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
         Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc12=rtByName_acc1.getRecordTypeId();
        
        Account Acc= new Account();
        Acc.Name='Test Acc';  
        Acc.GE_HQ_KYC_Complete__c=False;
        Acc.GE_PRM_KYC_Completed__c=False;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='D&S - DT';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        Acc.GE_HQ_Nts_Comments__c='Test'; 
        Acc.GE_OG_MDM_Shipping_Country_ISO_Code__c = 'US';     
        acc.GE_OG_MDM_Billing_Country_ISO_Code__c ='IN';
       
        acc.RecordTypeId=acc12;
        acc.GE_OG_AccFin_Status__c='In Progress';
        acc.Account_Status__c ='CC Approved';
        acc.ShippingCountry ='ARGENTINA';
        acc.GE_PW_Phone_New_Request__c='(111)111-1111';
        Acc.GE_HQ_Site_Use_Code__c ='BILL_TO';
        
        lstacc.add(Acc);
      
        insert lstacc;  
                     
       
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
ChApp.GE_PRM_Expirydate1__c = Date.today().adddays(10);
      
        insert ChApp; 
        
        GE_PRM_Channel_Appointment__c ChApp2 = ChApp.clone(false, true, false, false);
         insert ChApp2;
         
        
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
        
        commline2.GE_PRM_Term__c = 2;   
        commline2.GE_PRM_Pricing_Type__c='Schedule';
        lstCommLine.add(commline2);   
insert lstCommLine;  

}

 testMethod static void commerciallinesTest1(){        
        Test.StartTest();
    try{
 
                               
         GE_PRM_Channel_Appointment__c ChApp = [select id from GE_PRM_Channel_Appointment__c  limit 1 ]; 
           ChApp.GE_PRM_Prior_growth_rating__c = 'Medium';
           update ChApp;
       
       
        }
        catch(Exception e){ 
            system.debug(e);
        }  
         
        
        
        Test.StopTest();
 }
 testMethod static void commerciallinesTest2(){        
        Test.StartTest();
        try{                  
           GE_PRM_Channel_Appointment__c ChApp = [select id from GE_PRM_Channel_Appointment__c  limit 1 ]; 
           ChApp.GE_PRM_Prior_growth_rating__c = 'Medium';
           delete ChApp;
           undelete ChApp;
       
        }
        catch(Exception e){ 
            system.debug(e);
        }  
        Test.StopTest();
 }
     testMethod static void UpdateWasEverHighTest(){        
            Test.StartTest();
            try{                  
               GE_PRM_Channel_Appointment__c ChApp = [select id from GE_PRM_Channel_Appointment__c  limit 1 ]; 
               ChApp.GE_PRM_Prior_growth_rating__c = 'Medium';
               ChApp.Was_Ever_High__c =true;
               ChApp.GE_PRM_Risk_rating__c ='High';
               update ChApp;       
            }
            catch(Exception e){ 
                system.debug(e);
            }  
            Test.StopTest();
     }
     
     public static testMethod void updateIPIPFieldsTest(){
         test.startTest();
         List<GE_PRM_Channel_Appointment__c> objApptTest = [select id from GE_PRM_Channel_Appointment__c]; 
         
         objApptTest[0].GE_PRM_Last_Spirit_Letter_signed_date__c = Date.parse('01/01/2016');
         objApptTest[0].GE_PRM_Last_Site_visit_signed_date__c = Date.parse('01/01/2016');
         objApptTest[0].GE_PRM_Last_Deloitte_report_cmpltd_date__c = Date.parse('01/01/2016');
         objApptTest[0].GE_PRM_Deloitte_report_order_date__c = Date.parse('01/01/2016');
         objApptTest[0].Negative_News_Search_Date__c= Date.parse('01/01/2016');
         objApptTest[0].GE_PRM_KYC_DD_Approved_Date__c= Date.parse('01/01/2016');
         update objApptTest[0];
         
         test.stopTest();
     }
     
 
}