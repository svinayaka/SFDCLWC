@isTest
public class ReparentLegalEntity_PRM_GE_OG_Test
{
     private static list<Id> conIds = new list<Id>();
     private static List<Contract> contractList = new List<Contract>();
    
    
    public static testmethod void reparent_LE()
    {
        account oldMemberOfAcc = new account();
        oldMemberOfAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        oldMemberOfAcc.name = 'Test Account Country HQ';
        oldMemberOfAcc.Account_Tier_GEOG__c = 'Country';
        oldMemberOfAcc.Country_GEOG__c = 'INDIA';
        oldMemberOfAcc.Classification__c= 'Unclassified';
        oldMemberOfAcc.Type = 'Direct Customer';
        oldMemberOfAcc.ShippingCountry = 'India';
        oldMemberOfAcc.Account_Tier_GEOG__c = 'Global';
       
        insert oldMemberOfAcc;
        
        account newMemberOfAcc = new account();
        newMemberOfAcc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        newMemberOfAcc.name = 'Test Account Country HQ NEW';
        newMemberOfAcc.Account_Tier_GEOG__c = 'Country';
        newMemberOfAcc.Country_GEOG__c = 'INDIA';
        newMemberOfAcc.Classification__c= 'Unclassified';
        newMemberOfAcc.Type = 'Direct Customer';
        newMemberOfAcc.ShippingCountry = 'India';
        newMemberOfAcc.Account_Tier_GEOG__c = 'Global';
       
        insert newMemberOfAcc;
        
        account accCountry = new account();
        accCountry.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountry.name = 'Test Account Country';
        accCountry.Account_Tier_GEOG__c = 'Country';
        accCountry.Country_GEOG__c = 'INDIA';
        accCountry.Classification__c= 'Unclassified';
        accCountry.Member_of_GE_OG__c = oldMemberOfAcc.Id;
        accCountry.Type = 'Direct Customer';
        accCountry.ShippingCountry = 'India';
       
        insert accCountry;
        
        account accCountry_noMemOf = new account();
        accCountry_noMemOf.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountry_noMemOf.name = 'Test Account Country 1234';
        accCountry_noMemOf.Account_Tier_GEOG__c = 'Country';
        accCountry_noMemOf.Country_GEOG__c = 'INDIA';
        accCountry_noMemOf.Classification__c= 'Unclassified';
        //accCountry.Member_of_GE_OG__c = oldMemberOfAcc.Id;
        accCountry_noMemOf.Type = 'Direct Customer';
        accCountry_noMemOf.ShippingCountry = 'India';
       
        insert accCountry_noMemOf;
        
        
        account accCountryNew = new account();
        accCountryNew.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accCountryNew.name = 'Test Account Country New';
        accCountryNew.Account_Tier_GEOG__c = 'Country';
        accCountryNew.Country_GEOG__c = 'INDIA';
        accCountryNew.Classification__c= 'Unclassified';
        accCountryNew.Type = 'Direct Customer';
        accCountryNew.Member_of_GE_OG__c = newMemberOfAcc.Id;
        accCountryNew.ShippingCountry = 'India';
        
        insert accCountryNew;
        //newPar.add(accCountryNew.Id);
        
        account accLE = new account();
        accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = accCountry.Id;
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Type = 'Direct Customer';
        accLE.Classification__c = 'Do Not Contact';
        accLE.ShippingCountry = 'India';
        accLE.Account_Status__c = 'CC Approved';
        
        insert accLE;
        
        GE_PRM_Channel_Appointment__c ChApp = new GE_PRM_Channel_Appointment__c();
        ChApp.GE_PRM_Account_Name__c=accLE.id;
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
        ChApp.GE_PRM_Primary_Sales_Channel_Manager__c=UserInfo.getUserId();
        ChApp.GE_PRM_Region_Sales_Channel_Leader__c=UserInfo.getUserId();      
        ChApp.GE_PRM_Tier_2_P_L__c='Measurement & Control (M&C)'; 
        
        insert ChApp;    
        
        
        GE_PRM_Commercial_line__c commline= new GE_PRM_Commercial_line__c();
        commline.GE_PRM_Channel_Appointment__c=ChApp.id;
        commline.GE_PRM_Status__c='New';       
        commline.GE_PRM_Tier_1__c='Oil & Gas (O&G)';
        commline.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
        commline.GE_PRM_Tier_3__c='Bently Nevada';
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
        
        
        
        String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        
                    Contract master=new  Contract();
                    master.RecordTypeId= contractRecordTypeMasterId ;
                    
                    master.accountid =accLE.Id;
                    master.StartDate =Date.today();
                    master.status = 'Executed';
                    master.GE_PRM_For_Cause__c = 'Upon Notice';
                    master.GE_PRM_Without_Cause__c = '30 days';
                    master.GE_Contract_Specialist__c = UserInfo.getUserId();

                    master.GE_PRM_Contract_Draft_date__c =Date.today();
                    master.GE_PRM_Contract_Sent_to_CP__c =Date.today();
                    master.GE_PRM_ASC_Signed_contract_received__c =Date.today();
                    master.GE_PRM_GE_Signatures_completed__c =Date.today();
                    master.GE_PRM_Close_out__c =Date.today();
                    master.Hold_Flag__c = FALSE;                    
                    insert master;
                    
                    conIds.add(master.Id);
        
        
                    
                    Contract addedum=new  Contract();
                    
                    addedum.GE_PRM_Commercial_line__c = commline.Id;
                    addedum.GE_Commercial_Member_Of_GE_OG__c  = oldMemberOfAcc.Id;
                    addedum.GE_PRM_Commercial_Account__c = accCountry.Id;                    
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
                    addedum.status = 'Under Renewal';
                    addedum.GE_PRM_Master_Agreement__c = master.ID ;
                    addedum.GE_OG_Contract_End_Date__c = Date.today();
                    
                    
                    
                                      
                    
                    insert addedum ;
                    
                    conIds.add(addedum.Id);
                    
                    
                    
                     List<Contract> conList = [Select Id,AccountID,Status,GE_Commercial_Member_Of_GE_OG__c,GE_PRM_Commercial_Account__c  From Contract where Id IN : conIds];
            
            List<Account> newParentList = [Select Id,Type ,Active_Channel_Partner__c ,Classification__c,Member_of_GE_OG__c From Account where Id =: accCountryNew.Id];
            
            List<Account> newParentList2 = [Select Id,Type ,Active_Channel_Partner__c ,Classification__c,Member_of_GE_OG__c From Account where Id =: accCountry_noMemOf.Id];
            ReparentLegalEntity_PRM_GE_OG.reparent_PRM(newParentList[0],conList);
            ReparentLegalEntity_PRM_GE_OG.reparent_PRM(newParentList2[0],conList);
            
        
    }
    
        
}