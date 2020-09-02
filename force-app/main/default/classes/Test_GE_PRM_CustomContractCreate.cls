@isTest
public class Test_GE_PRM_CustomContractCreate 
{ 
    static testMethod  void GE_PRM_Channel_Appointment_Class_Method()
    {        
        List<GE_PRM_Channel_Appointment__c > ChAppList = new List<GE_PRM_Channel_Appointment__c >();
        list<Contract>  contractstoinsert=new list<Contract>();
        list<GE_PRM_Commercial_line__c> updatingcommlines=new list<GE_PRM_Commercial_line__c>(); 
        Profile sProfileID = [select id from profile where name ='System Administrator'  limit 1];
        User sysUser = [select id ,name from user where profileid=:sProfileID.id And Isactive = true limit 1];
        String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        //GE_Profile__c myChannelMgr = GE_Profile__c.getValues('GE_OG_PII Sales Manager'); -- commented related to bug 0000024161
        /*GE_Profile__c myChannelMgr = GE_Profile__c.getValues('Standard User');
        Id chnlMagrId =  myChannelMgr.Profile_SFDC_ID__c;*/
        Id chnlMagrId =  '00eA0000000n90xIAA';
        User chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUsrs', profileId = chnlMagrId, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        
        system.runAs(sysUser)
        {
            insert chnlManr;    
        }
        
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];      
        //System.assertEquals(acc.Name ,'TestClassAccount');    
        
        account Cacc = new account();
        Cacc.name = 'Test2';
        Cacc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Cacc.ShippingCountry = 'India';
        Cacc.Account_Tier_GEOG__c = 'Global';
        Cacc.Classification__c='Unclassified';
        Cacc.type='Direct Customer';
        insert Cacc;
        
        account Racc = new account();
        Racc.name = 'Test1';
        Racc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Racc.ShippingCountry = 'India';
        Racc.Account_Tier_GEOG__c = 'Country';
        Racc.Member_of_GE_OG__c = Cacc.id;
        Racc.Classification__c='Unclassified';
        Racc.type='Direct Customer';
        insert Racc;
        
        
        GE_PRM_Channel_Appointment__c ChApp1 = new GE_PRM_Channel_Appointment__c();
        ChApp1.GE_PRM_Account_Name__c=Racc.id;
        ChApp1.GE_PRM_Current_Status__c= 'Approved'; 
        ChApp1.GE_PRM_Master_appointment_type__c ='New';
        ChApp1.GE_PRM_Primary_bank_account_country__c = 'UNITED KINGDOM ';
        ChApp1.GE_PRM_Primary_bank_name_address__c = 'test';
        ChApp1.GE_PRM_Primary_bank_contact__c = 'test';
        ChApp1.GE_PRM_Primary_bank_account__c = 'test';
        ChApp1.GE_PRM_Payment_term_requested__c= '30';
        ChApp1.GE_PRM_Commercial_quali_rationale__c='abcde';
        ChApp1.GE_PRM_Prior_growth_rating__c = 'Medium';
        ChApp1.GE_PRM_Prior_year_commission_paid__c='New';
        ChApp1.GE_PRM_Prior_performance_rating__c = 'Medium';
        ChApp1.GE_PRM_Prior_year_orders__c = '<$100K';
        ChApp1.GE_PRM_With_GE_since__c = 0;
        ChApp1.GE_PRM_In_Business_Since__c = Date.today();
        ChApp1.GE_PRM_Mandated_by_End_Customer__c = 'No';
        ChApp1.GE_PRM_Convicted_of_any_felony_crims_r_s__c= 'No';
        ChApp1.GE_PRM_Do_you_have_Officers_in_Gov__c= 'No';
        ChApp1.GE_PRM_High_Risk_product_lines__c= 'No';
        ChApp1.GE_PRM_Sell_to_Nuclear_industry__c= 'No';
        ChApp1.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c= 'No';
        ChApp1.GE_PRM_Does_Channel_Partner_have_subsid__c= 'No';
        ChApp1.GE_PRM_Export_Controlled_products__c= 'No';
        ChApp1.GE_PRM_Export_outside_own_country__c= 'No';
        ChApp1.GE_PRM_Approved_exclusivity_from_P_L__c= 'No';
        ChApp1.GE_PRM_Primary_Sales_Channel_Manager__c=chnlManr.id;
        ChApp1.GE_PRM_Region_Sales_Channel_Leader__c=chnlManr.id;       
        ChApp1.GE_PRM_Tier_2_P_L__c='Measurement & Control (M&C)';       
        insert ChApp1; 
        
        Contract tempContract=new  Contract();
        tempContract.RecordTypeId= contractRecordTypeMasterId ;
        tempContract.GE_PRM_Channel_Appointment_ID__c=ChApp1.id;
        tempContract.accountid =ChApp1.GE_PRM_Account_Name__c;
        tempContract.GE_PRM_Primary_Sales_Channel_Manager__c =ChApp1.GE_PRM_Primary_Sales_Channel_Manager__c;
        tempContract.GE_PRM_Commercial_Manager1__c=ChApp1.GE_PRM_Commercial_Manager__c;
        tempContract.GE_PRM_Tier_2__c=ChApp1.GE_PRM_Tier_2_P_L__c;
        tempContract.GE_PRM_Region__c=ChApp1.GE_PRM_O_G_Region__c;
        tempContract.StartDate =Date.today();
        tempContract.GE_PRM_Commercial_Manager1__c=ChApp1.GE_PRM_Commercial_Manager__c;
        tempContract.GE_PRM_Contract_Sent_to_CP__c =Date.today();
        tempContract.GE_PRM_ASC_Signed_contract_received__c=Date.today();
        tempContract.GE_PRM_GE_Signatures_completed__c =Date.today();
        tempContract.GE_PRM_Close_out__c =Date.today();
        
        insert tempContract;
        test.startTest();  
        GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
        ChApp.GE_PRM_Account_Name__c=Racc.id;
        ChApp.GE_PRM_Current_Status__c= 'Approved'; 
        ChApp.GE_PRM_Master_appointment_type__c ='New';
        ChApp.GE_PRM_Primary_bank_account_country__c = 'UNITED KINGDOM ';
        ChApp.GE_PRM_Primary_bank_name_address__c = 'test';
        ChApp.GE_PRM_Old_Channel_Appointment__c = ChApp1.id;
        ChApp.GE_PRM_Old_Contract__c = tempContract.id;
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
        
      /**  Apttus__APTS_Agreement__c objAgreement = new Apttus__APTS_Agreement__c();
        objAgreement.GE_PRM_Channel_Appointment_ID__c = ChApp.id;
        objAgreement.recordTypeid = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        insert objAgreement;  **/
        
        System.assertEquals(ChApp.GE_PRM_Tier_2_P_L__c,'Measurement & Control (M&C)');
        System.debug('Channel Appointment ID'+ChApp.id);
        apexpages.currentpage().getparameters().put('id' ,ChApp.id);        
        GE_PRM_Commercial_line__c commline1= new GE_PRM_Commercial_line__c();
        commline1.GE_PRM_Channel_Appointment__c=ChApp.id;
        commline1.GE_PRM_Status__c='New';       
        commline1.GE_PRM_Tier_1__c='Oil & Gas (O&G)';
        commline1.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
        commline1.GE_PRM_Tier_3__c='Bently Nevada';
        commline1.GE_PRM_Tier_4__c='Application';
        commline1.GE_PRM_Type__c='Sales Representative';
        commline1.GE_PRM_Channel_Appointment__c=ChApp.id;
        commline1.GE_PRM_If_Services_pick_type__c='MARC';
        commline1.GE_PRM_Term__c=8;
        commline1.GE_PRM_If_flat_pricing__c=80;
        commline1.GE_PRM_Is_this_linked_to_project_oppty__c='No';
        commline1.GE_PRM_Military_use_Add_comment__c='No';
        commline1.GE_PRM_Inclusions_exclusions_Add_comment__c='No';
        commline1.GE_PRM_Nuclear_use_Add_comment__c='No';
        commline1.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c='Standard';
        commline1.GE_PRM_Authorized_Countries_1__c='BANGLADESH;BARBADOS';
        commline1.GE_PRM_Authorized_Countries_2__c='UNITED STATES;UNITED KINGDOM';        
        insert commline1;
        
        Contract master=new  Contract();
        master.RecordTypeId= contractRecordTypeMasterId ;
        master.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
        master.accountid =ChApp.GE_PRM_Account_Name__c;
        master.GE_PRM_Primary_Sales_Channel_Manager__c =ChApp.GE_PRM_Primary_Sales_Channel_Manager__c;
        system.debug('commid--->'+ChApp.GE_PRM_Commercial_Manager__c);
        master.GE_PRM_Commercial_Manager1__c=ChApp.GE_PRM_Commercial_Manager__c;
        master.GE_PRM_Tier_2__c=ChApp.GE_PRM_Tier_2_P_L__c;
        master.GE_PRM_Region__c=ChApp.GE_PRM_O_G_Region__c;
        master.StartDate =Date.today();
        master.GE_PRM_Commercial_Manager1__c=ChApp.GE_PRM_Commercial_Manager__c;
        master.GE_PRM_Business_Tier_1__c =commline1.GE_PRM_Tier_1__c;
        master.GE_PRM_Tier_2__c=commline1.GE_PRM_Tier_2__c;
        master.GE_PRM_Tier_3__c=commline1.GE_PRM_Tier_3__c;
        master.GE_PRM_Tier_4__c=commline1.GE_PRM_Tier_4__c;
        master.GE_PRM_Tier_5__c= commline1.GE_PRM_Tier_5__c;
        master.GE_PRM_Contract_Sent_to_CP__c =Date.today();
        master.GE_PRM_ASC_Signed_contract_received__c=Date.today();
        master.GE_PRM_GE_Signatures_completed__c =Date.today();
        master.GE_PRM_Close_out__c =Date.today();
        integer intterm = 6;
       
        if(intterm != -1){    
            master.ContractTerm = intterm;
            master.GE_OG_Contract_End_Date__c = Date.today().addMonths(intterm);     
        }
        if(ChApp.GE_PRM_Sell_to_Nuclear_industry__c=='Yes')
            master.GE_PRM_Nuclear_sales__c=true;
        if(ChApp.GE_PRM_Sell_to_Military__c=='Yes')
            master.GE_PRM_Military_sales__c=true;
        if(ChApp.GE_PRM_No_Of_Subdealers_Subsidary__c>0)
            master.GE_PRM_Sub_dealer_agents__c=true;
        if(ChApp.GE_PRM_Account_Country__c=='BRAZIL')
            master.GE_PRM_Brazil_Sales_Rep__c=true;
        contractstoinsert.add(master);
    
        
        Contract master1=new  Contract();
        master1.RecordTypeId= contractRecordTypeAddendumId;
        master1.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
        master1.accountid =ChApp.GE_PRM_Account_Name__c;
        master1.GE_PRM_Primary_Sales_Channel_Manager__c =ChApp.GE_PRM_Primary_Sales_Channel_Manager__c;
        master1.GE_PRM_Commercial_Manager1__c=ChApp.GE_PRM_Commercial_Manager__c;
        master1.GE_PRM_Business_Tier_1__c =commline1.GE_PRM_Tier_1__c;
        master1.GE_PRM_Tier_2__c=commline1.GE_PRM_Tier_2__c;
        master1.GE_PRM_Tier_3__c=commline1.GE_PRM_Tier_3__c;
        master1.GE_PRM_Tier_4__c=commline1.GE_PRM_Tier_4__c;
        master1.GE_PRM_Tier_5__c= commline1.GE_PRM_Tier_5__c;
        master1.GE_PRM_Region__c=ChApp.GE_PRM_O_G_Region__c;
        master1.StartDate =Date.today();
        master1.GE_PRM_Contract_Sent_to_CP__c =Date.today();
        master1.GE_PRM_ASC_Signed_contract_received__c=Date.today();
        master1.GE_PRM_GE_Signatures_completed__c =Date.today();
        master1.GE_PRM_Close_out__c =Date.today();
        if(intterm != -1){    
            master1.ContractTerm = intterm;
            master1.GE_OG_Contract_End_Date__c = Date.today().addMonths(intterm);     
        }
        if(ChApp.GE_PRM_Sell_to_Nuclear_industry__c=='Yes')
            master1.GE_PRM_Nuclear_sales__c=true;
        if(ChApp.GE_PRM_Sell_to_Military__c=='Yes')
            master1.GE_PRM_Military_sales__c=true;
        if(ChApp.GE_PRM_No_Of_Subdealers_Subsidary__c>0)
            master1.GE_PRM_Sub_dealer_agents__c=true;
        if(ChApp.GE_PRM_Account_Country__c=='BRAZIL')
            master1.GE_PRM_Brazil_Sales_Rep__c=true; 
        
        contractstoinsert.add(master1);
        
        
        Contract addedum=new  Contract();
        addedum.GE_PRM_Commercial_line__c = commline1.Id;
        addedum.RecordTypeId=contractRecordTypeAddendumId;
        addedum.AccountID=ChApp.GE_PRM_Account_Name__c;
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
        addedum.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
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
        addedum.GE_PRM_Contract_Sent_to_CP__c =Date.today();
        addedum.GE_PRM_ASC_Signed_contract_received__c=Date.today();
        addedum.GE_PRM_GE_Signatures_completed__c =Date.today();
        addedum.GE_PRM_Close_out__c =Date.today();
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
        
        //GE_PRM_Channel_use_of_Sub_ACSs__c=
       
       
        addedum.GE_PRM_Primary_Sales_Channel_Manager__c =commline1.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
        addedum.GE_PRM_Region__c =commline1.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
        contractstoinsert.add(addedum);
        
        Contract addedum1=new  Contract();
        addedum1.GE_PRM_Commercial_line__c = commline1.Id;
        addedum1.RecordTypeId=contractRecordTypeAddendumId;
        addedum1.AccountID=ChApp.GE_PRM_Account_Name__c;
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
        addedum1.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
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
        addedum1.GE_PRM_Contract_Sent_to_CP__c =Date.today();
        addedum1.GE_PRM_ASC_Signed_contract_received__c=Date.today();
        addedum1.GE_PRM_GE_Signatures_completed__c =Date.today();
        addedum1.GE_PRM_Close_out__c =Date.today();
        addedum1.ContractTerm = integer.valueof(commline1.GE_PRM_Term__c);
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
        
        //GE_PRM_Channel_use_of_Sub_ACSs__c=
       
       
        addedum1.GE_PRM_Primary_Sales_Channel_Manager__c =commline1.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
        addedum1.GE_PRM_Region__c =commline1.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
        contractstoinsert.add(addedum1);
        
        Contract master2=new  Contract();
        master2.RecordTypeId= contractRecordTypeMasterId ;
        master2.GE_PRM_Channel_Appointment_ID__c=ChApp.id;
        master2.accountid =ChApp.GE_PRM_Account_Name__c;
        master2.GE_PRM_Primary_Sales_Channel_Manager__c =ChApp.GE_PRM_Primary_Sales_Channel_Manager__c;
        master2.GE_PRM_Commercial_Manager1__c=ChApp.GE_PRM_Commercial_Manager__c;
        master2.GE_PRM_Tier_2__c=ChApp.GE_PRM_Tier_2_P_L__c;
        master2.GE_PRM_Region__c=ChApp.GE_PRM_O_G_Region__c;
        master2.StartDate =Date.today();
        master2.GE_PRM_Commercial_Manager1__c=ChApp.GE_PRM_Commercial_Manager__c;
        master2.GE_PRM_Business_Tier_1__c =commline1.GE_PRM_Tier_1__c;
        master2.GE_PRM_Tier_2__c=commline1.GE_PRM_Tier_2__c;
        master2.GE_PRM_Tier_3__c=commline1.GE_PRM_Tier_3__c;
        master2.GE_PRM_Tier_4__c=commline1.GE_PRM_Tier_4__c;
        master2.GE_PRM_Tier_5__c= commline1.GE_PRM_Tier_5__c;
        master2.GE_PRM_Contract_Sent_to_CP__c =Date.today();
        master2.GE_PRM_ASC_Signed_contract_received__c=Date.today();
        master2.GE_PRM_GE_Signatures_completed__c =Date.today();
        master2.GE_PRM_Close_out__c =Date.today();
       
        if(intterm != -1){    
            master2.ContractTerm = intterm;
            master2.GE_OG_Contract_End_Date__c = Date.today().addMonths(intterm);     
        }
        if(ChApp.GE_PRM_Sell_to_Nuclear_industry__c=='Yes')
            master2.GE_PRM_Nuclear_sales__c=true;
        if(ChApp.GE_PRM_Sell_to_Military__c=='Yes')
            master2.GE_PRM_Military_sales__c=true;
        if(ChApp.GE_PRM_No_Of_Subdealers_Subsidary__c>0)
            master2.GE_PRM_Sub_dealer_agents__c=true;
        if(ChApp.GE_PRM_Account_Country__c=='BRAZIL')
            master2.GE_PRM_Brazil_Sales_Rep__c=true;
        contractstoinsert.add(master2);
        
        commline1.GE_PRM_contract_genrated__c=true;
        updatingcommlines.add(commline1);
            
        
        system.debug('hhhhhhhhhhiiiiiiiiiii'+contractstoinsert.size());
        if(contractstoinsert.size()>0)
        {
            CheckRecursion_GE_OG.run = true;    
            insert contractstoinsert;
            List<Contract> lstupdate = new List<Contract>();
            Contract con = contractstoinsert[0];
            Contract con1 = contractstoinsert[1];
            Contract con2 = contractstoinsert[2];
            Contract con3 = contractstoinsert[3];
            Contract con4 = contractstoinsert[4];
            con.status='Executed';
            con1.status='Terminated';
            con2.status='Executed';
            con3.status='Executed';
            con4.status='Non-Renewed';
            con.Termination_Email__c = true;
            con1.Termination_Email__c = true;        
            con.StartDate=Date.today();
            con.GE_PRM_For_Cause__c  ='30 days';
            con.GE_PRM_Without_Cause__c ='30 days';
            con.GE_Contract_Specialist__c =chnlManr.id;
            con.GE_PRM_Contract_Draft_date__c= Date.today();
            con.GE_PRM_Contract_Sent_to_CP__c =Date.today();
            con.GE_PRM_ASC_Signed_contract_received__c=Date.today();
            con.GE_PRM_GE_Signatures_completed__c =Date.today();
            con.GE_PRM_Close_out__c =Date.today();
            
            con1.StartDate=Date.today();
            con1.GE_PRM_For_Cause__c  ='30 days';
            con1.GE_PRM_Without_Cause__c ='30 days';
            con1.GE_Contract_Specialist__c =chnlManr.id;
            con1.GE_PRM_Contract_Draft_date__c= Date.today();
            con1.GE_PRM_Contract_Sent_to_CP__c =Date.today();
            con1.GE_PRM_ASC_Signed_contract_received__c=Date.today();
            con1.GE_PRM_GE_Signatures_completed__c =Date.today();
            con1.GE_PRM_Close_out__c =Date.today();             
            con1.CurrencyIsoCode='USD';
            con1.GE_PRM_Governing_Law__c ='Test';
            con1.GE_PRM_Arbitration_location__c='Test';
            con1.GE_OG_Legal_Entity__c='Australia;India';
            
            con2.StartDate=Date.today();
            con2.GE_PRM_For_Cause__c  ='30 days';
            con2.GE_PRM_Without_Cause__c ='30 days';
            con2.GE_Contract_Specialist__c =chnlManr.id;
            con2.GE_PRM_Contract_Draft_date__c= Date.today();
            con2.GE_PRM_Contract_Sent_to_CP__c =Date.today();
            con2.GE_PRM_ASC_Signed_contract_received__c=Date.today();
            con2.GE_PRM_GE_Signatures_completed__c =Date.today();
            con2.GE_PRM_Close_out__c =Date.today();             
            con2.CurrencyIsoCode='USD';
            con2.GE_PRM_Governing_Law__c ='Test';
            con2.GE_PRM_Arbitration_location__c='Test';
            con2.GE_OG_Legal_Entity__c='Australia;India';
            
            con3.StartDate=Date.today();
            con3.GE_PRM_For_Cause__c  ='30 days';
            con3.GE_PRM_Without_Cause__c ='30 days';
            con3.GE_Contract_Specialist__c =chnlManr.id;
            con3.GE_PRM_Contract_Draft_date__c= Date.today();
            con3.GE_PRM_Contract_Sent_to_CP__c =Date.today();
            con3.GE_PRM_ASC_Signed_contract_received__c=Date.today();
            con3.GE_PRM_GE_Signatures_completed__c =Date.today();
            con3.GE_PRM_Close_out__c =Date.today();             
            con3.CurrencyIsoCode='USD';
            con3.GE_PRM_Governing_Law__c ='Test';
            con3.GE_PRM_Arbitration_location__c='Test';
            con3.GE_OG_Legal_Entity__c='Australia;India';                
            //GE_PRM_TriggerhelperClass.archiveold = false;
            
            con4.Termination_Email__c = true;
            con4.Termination_Email__c = true;        
            con4.StartDate=Date.today();
            con4.GE_PRM_For_Cause__c  ='30 days';
            con4.GE_PRM_Without_Cause__c ='30 days';
            con4.GE_Contract_Specialist__c =chnlManr.id;
            con4.GE_PRM_Contract_Draft_date__c= Date.today();
            con4.GE_PRM_Contract_Sent_to_CP__c =Date.today();
            con4.GE_PRM_ASC_Signed_contract_received__c=Date.today();
            con4.GE_PRM_GE_Signatures_completed__c =Date.today();
            con4.GE_PRM_Close_out__c =Date.today();
            
            lstupdate.add(con);
            
            lstupdate.add(con1);
            lstupdate.add(con2);
            lstupdate.add(con3);
            lstupdate.add(con4);
            CheckRecursion_GE_OG.run = true;
            System.runAs(sysUser)
            {
                update lstupdate;
            }
            delete con4;
        }
        test.stopTest();
    } 
}