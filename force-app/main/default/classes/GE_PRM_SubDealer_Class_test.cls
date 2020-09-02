@istest
  public with sharing class GE_PRM_SubDealer_Class_test {
  
  static testMethod  void Testsubdealerclass(){
        Test.StartTest();
        
        
        
       /*User terec = new User();
       terec.firstname = 'test';
       terec.lastname = 'record';
       terec.email = 'testrecord@ge.com';
       terec.alias = 'trecord';
       terec.profileId = p.id;
       terec.Title = 'test record';
       terec.Username = 'testrecord@ge.com';
       //terec.CommunityNickname = 'trec';
       terec.TimeZoneSidKey = 'America/New_York';
       terec.LocaleSidKey = 'en_US';
       terec.EmailEncodingKey= 'ISO-8859-1';
       terec.LanguageLocaleKey= 'en_US';*/
       
        
    
     // RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='CMF Approved' Limit 1];
        account acc=new account();
     
        //acc.RecordTypeId = rt.Id;
      
       acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
         acc.Account_Tier_GEOG__c = 'Country';

            acc.GE_PRM_Active_PRM_Users__c=1;    
            acc.name='testacc';
            acc.Account_Status__c ='New';
            acc.GE_PW_Phone_New_Request__c='123456789';
            acc.GE_HQ_New_Account_Street__c='Room 203, Building Nanxuefu Garden, Zhaowuda Rd.';
            acc.GE_HQ_New_Account_City__c='Huhehaote';
            acc.GE_HQ_New_Account_State_Province__c='Inner Mongolia';
            acc.GE_HQ_New_Account_Zip_Postal_Code__c='010040';
            acc.GE_HQ_New_Account_Country__c='CHINA';
            acc.Type = 'Direct Customer';
            acc.Classification__c = 'Strategic';
           insert acc;
           // Account a1=[select id from account where id=:acc.id];
            //system.debug('accid=='+acc.id);
      
            contact c = new contact();
            c.GE_OG_Contact_Audience__c='Customer Care';
            c.lastName = 'test';
            c.firstName = 'name';
            c.accountId = acc.id;
            c.phone='243241234';
            c.email = 'abc@gmail.com';
            insert c;
             Profile p = [select id from profile where name='Gold Partner User'];
        User terec = new User(Alias = 'newUser', Email='newuse12r@testorg.com', 
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
         LocaleSidKey='en_US', ProfileId = p.Id,
         TimeZoneSidKey='America/Los_Angeles', UserName='new12u12serPRM@testorg.com');
            terec.contactId = c.id;
            terec.GE_HQ_Tier_3_P_L__c = 'DOS - Opex CS';
            insert terec;
             
            List<GE_PRM_Channel_Appointment__c > ChAppList = new List<GE_PRM_Channel_Appointment__c >();
            
                      
          
            
            GE_PRM_Channel_Appointment__c ChannelApp = new GE_PRM_Channel_Appointment__c();
            ChannelApp.GE_PRM_Account_Name__c=acc.id;
            ChannelApp.GE_PRM_Current_Status__c= 'Approved'; 
            ChannelApp.GE_PRM_Master_appointment_type__c ='New';
            ChannelApp.GE_PRM_Primary_bank_account_country__c = 'INDIA';
            ChannelApp.GE_PRM_Primary_bank_name_address__c = 'test12';
            ChannelApp.GE_PRM_Primary_bank_contact__c = 'test21';
            ChannelApp.GE_PRM_Primary_bank_account__c = 'test12';
            ChannelApp.GE_PRM_Payment_term_requested__c= '21';
            ChannelApp.GE_PRM_Commercial_quali_rationale__c='fghdd';
            ChannelApp.GE_PRM_Prior_growth_rating__c = 'Medium';
            ChannelApp.GE_PRM_Prior_year_commission_paid__c='New';
            ChannelApp.GE_PRM_Prior_performance_rating__c = 'Medium';
            ChannelApp.GE_PRM_Prior_year_orders__c = '<$100K';
            ChannelApp.GE_PRM_With_GE_since__c = 0;
            ChannelApp.GE_PRM_In_Business_Since__c = Date.today();
            ChannelApp.GE_PRM_Mandated_by_End_Customer__c = 'No';
            ChannelApp.GE_PRM_Convicted_of_any_felony_crims_r_s__c= 'No';
            ChannelApp.GE_PRM_Do_you_have_Officers_in_Gov__c= 'No';
            ChannelApp.GE_PRM_High_Risk_product_lines__c= 'No';
            ChannelApp.GE_PRM_Sell_to_Nuclear_industry__c= 'No';
            ChannelApp.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c= 'No';
            ChannelApp.GE_PRM_Does_Channel_Partner_have_subsid__c= 'No';
            ChannelApp.GE_PRM_Export_Controlled_products__c= 'No';
            ChannelApp.GE_PRM_Export_outside_own_country__c= 'No';
            ChannelApp.GE_PRM_Approved_exclusivity_from_P_L__c= 'No';
            ChannelApp.GE_PRM_Primary_Sales_Channel_Manager__c=terec.id;
            ChannelApp.GE_PRM_Region_Sales_Channel_Leader__c=terec.id;       
            ChannelApp.GE_PRM_Tier_2_P_L__c='Measurement & Control (M&C)';
            insert ChannelApp; 
               
            System.assertEquals(ChannelApp.GE_PRM_Tier_2_P_L__c,'Measurement & Control (M&C)');  
            Sub_Dealer__c subdeal = new Sub_Dealer__c();
            subdeal.GE_PRM_Affiliate_dependent_type__c='Sub-Dealer';
            subdeal.GE_PRM_Authorized_commercial_lines__c='commercial';
            subdeal.GE_PRM_Channel_Appointment__c=ChannelApp.id;            
            subdeal.GE_PRM_City__c='aa';                
            subdeal.GE_PRM_City_of_registration__c='aa';                
            subdeal.GE_PRM_Country__c='UNITED STATES';              
            subdeal.GE_PRM_Email__c='test@test.com';
            subdeal.GE_PRM_Legal_name__c='test';             
            subdeal.GE_PRM_Mobile__c='123456789';     
            subdeal.GE_PRM_Ownership__c=50;              
            subdeal.GE_PRM_Phone__c='123456789';     
            subdeal.GE_PRM_Postal_code__c='1';             
            subdeal.GE_PRM_Prinicipal_Conatct_Text__c='test';         
            insert subdeal; 
            System.assertEquals(subdeal.GE_PRM_Prinicipal_Conatct_Text__c,'test');  
       
            Apexpages.currentpage().getparameters().put('id' ,subdeal.id);  
            Apexpages.currentpage().getparameters().put('Clone' ,'true');
            Apexpages.currentpage().getparameters().put('isNew' ,'true');  
            Apexpages.currentpage().getparameters().put('bpartnerUser' ,'true');
            Apexpages.currentpage().getparameters().put('bpartnerUser' ,'false');
            Apexpages.currentpage().getparameters().put('ChannelAppointmentId' ,ChannelApp.id);
           
            GE_PRM_SubDealer_Class controller=new GE_PRM_SubDealer_Class(new ApexPages.StandardController(subdeal));
            //controller.userprofileId=p1.id;
            //controller.bpartnerUser = true;
            controller.saveSubDealerDetails();
            controller.backToChApp();
            controller.cancel();
            controller.saveSubDealerDetails();
           

              controller.cancel();
               controller.cancel();
               
             Test.StopTest();
            }
        
        
                }