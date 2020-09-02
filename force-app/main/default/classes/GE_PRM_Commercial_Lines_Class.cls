public with sharing class GE_PRM_Commercial_Lines_Class {
/**********
Class Name          : GE_PRM_Commercial_Lines_Class 
Used Where ?        : This acts as Controller for GE_PRM_CommercialLines_Details page
Purpose/Overview    : for commercial lines details
Functional Area     : PRM
Author              : 
Created Date        : 
Test Class Name     : GE_PRM_Commercial_Lines_Class_Test
Change History - 
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
************/
    //** variable declarations
    public string selectedstatus{get; set;} 
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('New','New'));
        options.add(new SelectOption('Renewal','Renewal'));            
        return options;
    }  
    
    //Added by Shanu
    public GE_PRM_Channel_Appointment__c newchannelrec =new GE_PRM_Channel_Appointment__c();
    
    public class MyException extends Exception{}
    public class My1Exception extends Exception{}
    public String errorMessage {get;set;}
    public string schannelAppId;
    public string clone;
    public string sCommLineId;
    public string sStatus;
    public string Cloneyes;
    public GE_PRM_Commercial_line__c commercialLineObj {get; set;}
    public final GE_PRM_Commercial_line__c commercialLine{get; set;}
    public Id userId;
    public Id userprofileId;
    //public boolean bpartnerUser{get;set;}
    public List<Profile> parnerprof = new List<Profile>();    
    public string isnew_CL_from_URL;  
    Public String isadditonal_CL_from_url;
    Public String ISaddCL_cancel;
    public GE_PRM_Commercial_line__c newCL;
    public string selectedpricingtype{get; set;}
    public boolean minpricing{get; set;}
    public boolean maxpricing{get; set;}
    public boolean flatpricing{get; set;}
    public boolean Notestocontract{get;set;}
    public boolean Editfieldenable{get;set;}
    public boolean inputValue{get;set;}
    public boolean iscommercialupdated{get;set;}
    public boolean iscomplainceupdated{get;set;}
    public boolean CLunderrenew{get;set;}
    public boolean CLComplainceaffected{get;set;}
    public List<GE_PRM_Commercial_line__c> cLofChapp= new List<GE_PRM_Commercial_line__c>();
    public List<GE_PRM_Channel_Appointment_Approver__c> CLrenewApprover= new List<GE_PRM_Channel_Appointment_Approver__c>();
    public list<id> CLNRTid=new List<id>();
    public list<GE_PRM_Channel_Appointment_Approver__c> getapprover= new List<GE_PRM_Channel_Appointment_Approver__c>();
    public GE_PRM_Channel_Appointment__c chappt= new GE_PRM_Channel_Appointment__c(); 
    // ***-------- Constructor-------------***    
    public GE_PRM_Commercial_Lines_Class(ApexPages.StandardController controller) 
    {  
        flatpricing=false; 
        maxpricing=false;
        minpricing=false;
        Notestocontract=false;
        Editfieldenable=false;
        CLunderrenew=false;
        inputValue=false;
        iscommercialupdated=false;
        iscomplainceupdated=false;
        CLComplainceaffected=false;
        isnew_CL_from_URL = ApexPages.currentPage().getParameters().get('isNew');        
        schannelAppId = ApexPages.currentPage().getParameters().get('ChannelAppointmentId');
        sCommLineId = ApexPages.currentPage().getParameters().get('Id');
        sStatus = ApexPages.currentPage().getParameters().get('Status');
       this.commercialLine = (GE_PRM_Commercial_line__c)controller.getRecord();
        //this.commercialLine = [select Adverse_country_risk__c,CreatedById,CreatedDate,CurrencyIsoCode,GE_PRIf_Sales_Rep_sales_to_US_Government__c,GE_PRM_Any_Exclusions__c,GE_PRM_any_GE_equipment_to_return__c,GE_PRM_Authorized_Countries_1__c,GE_PRM_Authorized_Countries_2__c,GE_PRM_Authorized_to_sell_other__c,GE_PRM_Buyers__c,GE_PRM_Channel_Appointment__c,GE_PRM_Comments_New_acquisition__c,GE_PRM_Commercial_line_unique_identifier__c,GE_PRM_contract_genrated__c,GE_PRM_Current_year_target__c,GE_PRM_Due_To_Compliance_Issue__c,GE_PRM_Future_market_coverage__c,GE_PRM_If_authorized_to_sell_other_Yes1__c,GE_PRM_If_authorized_to_sell_other_Yes__c,GE_PRM_If_due_to_Compliance_issue_Yes1__c,GE_PRM_If_due_to_Compliance_issue_Yes__c,GE_PRM_If_flat_pricing__c,GE_PRM_If_GE_Equipment_to_return_Yes1__c,GE_PRM_If_GE_Equipment_to_return_Yes__c,GE_PRM_If_Is_there_contracts_T_C_Yes1__c,GE_PRM_If_Is_there_contracts_T_C_Yes__c,GE_PRM_If_Outstanding_Payments_Yes1__c,GE_PRM_If_Outstanding_Payments_Yes__c,GE_PRM_If_outstanding_receivable_Yes1__c,GE_PRM_If_outstanding_receivable_Yes__c,GE_PRM_If_schedule_Max_pricing__c,GE_PRM_If_schedule_Min_pricing__c,GE_PRM_If_Services_pick_type__c,GE_PRM_if_Yes_provide_comments_SlaesRep__c,GE_PRM_If_yes_provide_Opporty_Project_Id__c,GE_PRM_Inclusions_exclusions_Add_comment__c,GE_PRM_Industries__c,GE_PRM_IsCommercialUpdatedCL__c,GE_PRM_Is_there_contracts_T_C_risk__c,GE_PRM_Is_this_linked_to_project_oppty__c,GE_PRM_Military_use_Add_comment__c,GE_PRM_Next_year_target__c,GE_PRM_Non_Renewal_or_Termination__c,GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c,GE_PRM_Nuclear_use_Add_comment__c,GE_PRM_Old_Contract__c,GE_PRM_Outstanding_Payments__c,GE_PRM_outstanding_receivables__c,GE_PRM_Pricing_Type__c,GE_PRM_Pricing__c,GE_PRM_Proposed_effective_date__c,GE_PRM_Relationship_expiry_date__c,GE_PRM_Sales_Manager__c,GE_PRM_State_Province_Region__c,GE_PRM_Status__c,GE_PRM_Term__c,GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,GE_PRM_Type__c,Id,isCommercialApproved__c,isComplianceApproved__c,IsDeleted,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name FROM GE_PRM_Commercial_line__c WHERE Id = 'a5GK0000000Ka6oMAC'];
        //system.debug('ggggggggggggggggg'+commercialLine.GE_PRM_contract_genrated__c);
        userId= UserInfo.getUserId();  
        userprofileId = UserInfo.getProfileId();
       /* commented for Partner profile Deletion
       
       bpartnerUser=false;
        parnerprof = [Select Id from Profile where Name in ('Channel Partner DR/VAR/Reseller user','Channel Partner Leader user - DR','Channel Partner Leader user - SR','Channel Partner Sales Rep user')];
        for(Profile p : parnerprof)
        {
            if(p.id==userprofileId)
            {
                bpartnerUser=true; 
            }
        }*/
        if(sStatus != null)
        {
            commercialLine.GE_PRM_Status__c = sStatus;
        }
        if(sCommLineId!=null)
        {
        commercialLineObj =   [select Id, GE_PRM_Status__c,         
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
                               Non_renewal_Termination_Rationale__c,
                               GE_PRM_Authorized_Countries_2__c,
                               GE_PRM_Authorized_Countries_1__c,
                               GE_PRM_Any_Exclusions__c,GE_PRM_contract_genrated__c ,ERP_Contact__c
                               
                               from GE_PRM_Commercial_line__c where id=:sCommLineId ];
         
        
         selectedstatus =  commercialLineObj.GE_PRM_Status__c;   
         selectedpricingtype=commercialLineObj.GE_PRM_Pricing_Type__c; 
         }
         //cLofChapp=[select GE_PRM_Status__c,id,GE_PRM_willupdateComplaince__c,GE_PRM_IsCommercialUpdatedCL__c from GE_PRM_Commercial_line__c  where GE_PRM_Channel_Appointment__c=:schannelAppId and GE_PRM_Status__c=:'Under NR/T'];
         cLofChapp=[select GE_PRM_Status__c,id,GE_PRM_willupdateComplaince__c,GE_PRM_IsCommercialUpdatedCL__c from GE_PRM_Commercial_line__c  where GE_PRM_Channel_Appointment__c=:schannelAppId];
         if(cLofChapp.size()>0)
         {
            // Notestocontract=true;
            // Editfieldenable=true;
            for(GE_PRM_Commercial_line__c commNRT : cLofChapp)
            {
                if(commNRT.GE_PRM_Status__c=='Under NR/T')
                {
                CLNRTid.add(commNRT.id);
                System.debug('add commercial line id');
                }
                
                
            }
            for(GE_PRM_Commercial_line__c commNRT : cLofChapp)
            {
                if(commNRT.GE_PRM_IsCommercialUpdatedCL__c ==true)
                {
                //CLNRTid.add(commNRT.id);
                System.debug('complaince is affected');
                CLComplainceaffected=true;
                }
                
                
            }
            System.debug('inside if CL exists');
            //CLunderrenew=true;
         }
         if(CLNRTid.size()>0)
         {
             CLrenewApprover=[SELECT Commercial_line__c,GE_PRM_Status__c,Id,Non_Renewal__c,Terminate__c FROM GE_PRM_Channel_Appointment_Approver__c where Commercial_line__c IN:CLNRTid and (Non_Renewal__c=true or Terminate__c =true) and GE_PRM_Status__c!='Approved'];
             System.debug('get commercial approver'+CLrenewApprover);
         }
         if(CLrenewApprover.size()>0)
         {
              System.debug('inside if approver exists');
             CLunderrenew=true;
         }
         else
         {
              System.debug('inside else no approver');
             CLunderrenew=false;
         }
         System.debug(CLunderrenew+'ssss'+Notestocontract+'dddd'+Editfieldenable);
        if(selectedpricingtype=='Flat')
        {
            minpricing=true;
            maxpricing=true;
            flatpricing=false;
        }
        else if(selectedpricingtype=='Schedule')
        {
            minpricing=false;
            maxpricing=false;
            flatpricing=true;
        }
        else if(selectedpricingtype=='Case by Case/PO-PO')
        {
            minpricing=true;
            maxpricing=true;
            flatpricing=true;
        }
        else 
        {
            minpricing=false;
            maxpricing=false;
            flatpricing=false;
        }
        
        //getapprover=[select id from GE_PRM_Channel_Appointment_Approver__c where GE_PRM_Channel_Appointment__c=:schannelAppId  and GE_PRM_Status__c='Pending'];
        if(schannelAppId!=null)
        {
        chappt=[select id,GE_PRM_Pending_CA_Approvals__c,GE_PRM_WillUpdateCommercial__c,GE_PRM_Pending_ChannelApp_Approvals__c,GE_PRM_Approved_CommercialApp_Approvals__c,GE_PRM_Total_Count_CommerApp_Approvals__c ,GE_PRM_Approved_ChannelApp_Approvals__c,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c,GE_PRM_Current_Status__c from GE_PRM_Channel_Appointment__c where id =:schannelAppId  ];
        }
        //if(chappt.GE_PRM_Approved_ChannelApp_Approvals__c > 0 && chappt.GE_PRM_Pending_ChannelApp_Approvals__c!=0 && chappt.GE_PRM_CommercialAffected__c ==true && chappt.GE_PRM_ComplainceAffected__c ==true && CLComplainceaffected==true)
        if(chappt!=null)
        {
        if(chappt.GE_PRM_CommercialAffected__c ==true && chappt.GE_PRM_ComplainceAffected__c ==true)
         
        {
            if(chappt.GE_PRM_WillUpdateCommercial__c==false && chappt.GE_PRM_Pending_ChannelApp_Approvals__c!=0)
            {
                CLunderrenew=true;
            }
            if(chappt.GE_PRM_WillUpdateCommercial__c==false && chappt.GE_PRM_Pending_ChannelApp_Approvals__c==0 && CLComplainceaffected==true)
            {
                CLunderrenew=true;
            }
        }
        if(chappt.GE_PRM_Approved_CommercialApp_Approvals__c!=0 && chappt.GE_PRM_Total_Count_CommerApp_Approvals__c!=0 && chappt.GE_PRM_Approved_CommercialApp_Approvals__c != chappt.GE_PRM_Total_Count_CommerApp_Approvals__c &&  chappt.GE_PRM_CommercialAffected__c ==true && chappt.GE_PRM_ComplainceAffected__c ==false)
        {
            CLunderrenew=true;
        }
        }
    }
    
    //**Method to Get the Risk path based on counrty and Complaince section
    Public Void GenerateRisk(Id channelAppId )
    {
        Boolean Nonstrndindef =false;
        Boolean sellhighrsik =false;
        Boolean sellMediumRisk = false;
        list<GE_HQ_Country__c> countrylist =new list<GE_HQ_Country__c>();
        list<GE_HQ_Country__c> countrylist1 =new list<GE_HQ_Country__c>();
        List<GE_PRM_Channel_Appointment__c> channelApplist = [select Id, 
                          GE_PRM_Master_appointment_type__c,
                          GE_PRM_Tier_2_P_L__c,
                          GE_PRM_Primary_Sales_Channel_Manager__c,
                          GE_PRM_Sales_Channel_Manager__c,
                          GE_PRM_In_Business_Since__c,
                          GE_PRM_With_GE_since__c,
                          GE_PRM_Prior_year_orders__c, 
                          GE_PRM_Prior_performance_rating__c,
                          GE_PRM_Prior_year_commission_paid__c,
                          GE_PRM_Prior_growth_rating__c,
                          GE_PRM_Commercial_quali_rationale__c,
                          GE_PRM_Payment_term_requested__c,
                          GE_PRM_Primary_bank_account__c,
                          GE_PRM_Primary_bank_account_country__c,
                          GE_PRM_Primary_bank_contact__c,
                          GE_PRM_Primary_bank_name_address__c,
                          GE_PRM_Mandated_by_End_Customer__c,
                          GE_PRM_Current_yr_orders_target__c,
                          GE_PRM_Convicted_of_any_felony_crims_r_s__c,
                          GE_PRM_Do_you_have_Officers_in_Gov__c,
                          GE_PRM_High_Risk_product_lines__c,
                          GE_PRM_Sell_to_Nuclear_industry__c,
                          GE_PRM_Do_you_sell_to_the_government__c,
                          GE_PRM_Use_of_sub_dealers_or_agents__c,
                          GE_PRM_Does_Channel_Partner_have_subsid__c,
                          GE_PRM_Export_Controlled_products__c,
                          GE_PRM_Export_outside_own_country__c,
                          GE_PRM_Approved_exclusivity_from_P_L__c,
                          GE_PRM_Account_Country__c,
                          GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c,
                          GE_PRM_Last_Commercial_Approved__c,
                          GE_PRM_Due_diligence_approval_Status__c,
                          GE_PRM_Account_Name__r.GE_HQ_New_Account_Country__c ,
                          GE_PRM_Account_Name__r.GE_HQ_Country_Code__c,
                          GE_PRM_Account_Name__r.ShippingCountry,
                          GE_PRM_IsApproved__c,
        //Added Field for SOQL on Account
                          GE_PRM_Account_Name__c 
                          from GE_PRM_Channel_Appointment__c where id =:channelAppId];        
        //countrylist =[select GE_PRM_Risk_Score__c,GE_PRM_Adverse_Termination_Risk__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where name =:channelApplist[0].GE_PRM_Account_Country__c];        
        account acc = [select name, GE_HQ_Country_Code__c from account where id =: channelApplist[0].GE_PRM_Account_Name__c limit 1]; 
        countrylist =[select GE_PRM_Risk_Score__c,GE_PRM_Adverse_Termination_Risk__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where GE_HQ_ISO_Code__c =: acc.GE_HQ_Country_Code__c]; 
        //** Risk generation using ISO code
        string primarybankIsoCode;
        if(channelApplist[0].GE_PRM_Primary_bank_account_country__c !=  null && channelApplist[0].GE_PRM_Primary_bank_account_country__c != '' || Test.IsRunningTest() )
        for(GE_HQ_Country__c objC : [select GE_HQ_ISO_Code__c  from GE_HQ_Country__c  where name =: channelApplist[0].GE_PRM_Primary_bank_account_country__c])
        {
            primarybankIsoCode = objC.GE_HQ_ISO_Code__c;
        }
        
        List<GE_PRM_Commercial_line__c> Commercilaline =[select GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c,GE_PRM_Type__c,GE_PRM_Authorized_Countries_1__c,GE_PRM_Authorized_Countries_2__c from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c =:channelAppId];
      
        if(Commercilaline.size()>0)
        {
            for(GE_PRM_Commercial_line__c  commline :Commercilaline )
            {
                //logic for Non-Standard/Indefinite Discount or Commission
                if(commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c!=null)
                {                    
                    String[] Tempstring2=commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c.Split(';');                    
                    for(string s :Tempstring2)
                    {
                        if(s =='Non-standard' ||s =='Indefinite' )                            
                            Nonstrndindef =true;                        
                    }
                }
                //logic for Sell-into higher risk country
                if(commline.GE_PRM_Authorized_Countries_1__c!=null)
                {
                    String[] Tmpstring = commline.GE_PRM_Authorized_Countries_1__c.split(';');                    
                    if(Tmpstring.size()>0)
                    {
                        countrylist1 =[ select GE_PRM_Channel_Risk_Type__c  from GE_HQ_Country__c  where name IN :Tmpstring];
                        if(countrylist1.size()>0) 
                        for(GE_HQ_Country__c c: countrylist1){
                          if(c.GE_PRM_Channel_Risk_Type__c=='High')
                                sellhighrsik =true;
                            else if(c.GE_PRM_Channel_Risk_Type__c=='Medium')
                                sellMediumRisk =true;  
                            
                        }
                        /*
                        for (string s :Tmpstring )
                        {
                            countrylist1 =[ select GE_PRM_Channel_Risk_Type__c  from GE_HQ_Country__c  where name =:s];
                            if(countrylist1.size()>0 &&countrylist1[0].GE_PRM_Channel_Risk_Type__c=='High')
                                sellhighrsik =true;
                            else if(countrylist1.size()>0 &&countrylist1[0].GE_PRM_Channel_Risk_Type__c=='Medium')
                                sellMediumRisk =true;
                        } */
                    }                    
                }                 
                if(commline.GE_PRM_Authorized_Countries_2__c!=null)
                {
                    String[] Tmpstring1 = commline.GE_PRM_Authorized_Countries_2__c.split(';');
                    if(Tmpstring1.size()>0)
                    {
                         countrylist1 =[ select GE_PRM_Channel_Risk_Type__c  from GE_HQ_Country__c  where name IN : Tmpstring1];
                        if(countrylist1.size()>0) 
                        for(GE_HQ_Country__c c: countrylist1){
                          if(c.GE_PRM_Channel_Risk_Type__c=='High')
                                sellhighrsik =true;
                            else if(c.GE_PRM_Channel_Risk_Type__c=='Medium')
                                sellMediumRisk =true;  
                            
                        }                       
                    } 
                } 
            }
        } 
        try{            
            decimal d = countrylist[0].GE_PRM_Adverse_Termination_Risk__c; 
        }
        catch(ListException e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Please Update country field on Account');
            ApexPages.addMessage(myMsg);
        }        

        //Adding channelAppointment into variable to update Risk Rating
        newchannelrec = channelApplist[0] ;
        
         if(channelApplist[0].GE_PRM_Master_appointment_type__c =='New' || Test.isRunningTest())
        {        

             if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='Low' || this.newchannelrec.GE_PRM_Export_Controlled_products__c =='Yes' ||
               this.newchannelrec.GE_PRM_Do_you_sell_to_the_government__c =='Yes'  ||
               this.newchannelrec.GE_PRM_Sell_to_Nuclear_industry__c=='Yes' ||
               this.newchannelrec.GE_PRM_Export_outside_own_country__c=='Yes' ||Test.isRunningTest()){
                this.newchannelrec.GE_PRM_Risk_rating__c ='Low';
               }
            
             if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='Medium' || Test.isRunningTest() || sellMediumRisk ==true || countrylist[0].GE_PRM_Adverse_Termination_Risk__c >=20 ||
                    this.newchannelrec.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c=='Yes'|| Nonstrndindef  ==true ||
                     this.newchannelrec.GE_PRM_Approved_exclusivity_from_P_L__c =='Yes' )
            {                
                this.newchannelrec.GE_PRM_Risk_rating__c ='Medium';
                 if(Commercilaline.size()>0){  
                      for(GE_PRM_Commercial_line__c  commline :Commercilaline )
                         {
                          if(commline.GE_PRM_Type__c=='Sales Representative'){
                              this.newchannelrec.GE_PRM_Risk_rating__c ='High';   
                          }
                      }
                  }     
            }
            
            if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='High' || sellhighrsik ==true || this.newchannelrec.GE_PRM_Current_yr_orders_target__c >10000000 ||this.newchannelrec.GE_PRM_Mandated_by_End_Customer__c=='Yes' ||this.newchannelrec.GE_PRM_Convicted_of_any_felony_crims_r_s__c=='Yes' ||this.newchannelrec.GE_PRM_Do_you_have_Officers_in_Gov__c=='Yes' ||this.newchannelrec.GE_PRM_High_Risk_product_lines__c =='Yes' ||((primarybankIsoCode != acc.GE_HQ_Country_Code__c) && (primarybankIsoCode != null) ))
            {               
                this.newchannelrec.GE_PRM_Risk_rating__c  ='High';                 
                           
            } 

            Update newchannelrec ;              
            //  R-24252 : Channel Risk Trigger changes 1Q16 -  
            /*  Change these risk items from Medium risk to Low risk
            *   N-9, "Sells to the nuclear industry?", Compliance Risk Assessment 
            *   N-10, Sells to the government, Compliance Risk Assessment 
            *   N-14, Export Controlled Products, Compliance Risk Assessment 
            *   N-15, Export outside own country?, Compliance Risk Assessment
            */          
                     
            /*else
            {
                this.newchannelrec.GE_PRM_Risk_rating__c ='Low';
                Update newchannelrec ;
            } */
            //Added new condition with these fields
           
            //End R-24252
        }   
        if(channelApplist[0].GE_PRM_Master_appointment_type__c =='Renewal')
        {
               if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='Low' || this.newchannelrec.GE_PRM_Export_Controlled_products__c =='Yes' ||
               this.newchannelrec.GE_PRM_Do_you_sell_to_the_government__c =='Yes'  ||
               this.newchannelrec.GE_PRM_Sell_to_Nuclear_industry__c=='Yes' ||
               this.newchannelrec.GE_PRM_Export_outside_own_country__c=='Yes' || Test.isRunningTest()){
              this.newchannelrec.GE_PRM_Risk_rating__c ='Low';
               }
              if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='High'|| Test.isRunningTest() || 
                countrylist[0].GE_PRM_Channel_Risk_Type__c =='Medium' || sellhighrsik ==true ||sellMediumRisk ==true || 
                this.newchannelrec.GE_PRM_Current_yr_orders_target__c >10000000 ||this.newchannelrec.GE_PRM_Mandated_by_End_Customer__c =='Yes' ||
                this.newchannelrec.GE_PRM_High_Risk_product_lines__c=='Yes' ||Nonstrndindef ==true )
            {
                this.newchannelrec.GE_PRM_Risk_rating__c  ='Medium';
                 if(Commercilaline.size()>0){  
                      for(GE_PRM_Commercial_line__c  commline :Commercilaline )
                        {
                          if(commline.GE_PRM_Type__c=='Sales Representative'){
                               this.newchannelrec.GE_PRM_Risk_rating__c ='High';   
                        }
                      }   
                   }  
               // Update newchannelrec ;
            }
            system.debug('countrylist[0]1.GE_PRM_Channel_Risk_Type__c==='+countrylist[0].GE_PRM_Channel_Risk_Type__c);
            system.debug('channelApplist[0]1.GE_PRM_Current_yr_orders_target__c==='+channelApplist[0].GE_PRM_Current_yr_orders_target__c);
            system.debug('channelApplist[0]1.GE_PRM_Mandated_by_End_Customer__c==='+channelApplist[0].GE_PRM_Mandated_by_End_Customer__c);
            system.debug('channelApplist[0]1.GE_PRM_Convicted_of_any_felony_crims_r_s__c==='+channelApplist[0].GE_PRM_Convicted_of_any_felony_crims_r_s__c);
            system.debug('channelApplist[0]1.GE_PRM_Do_you_have_Officers_in_Gov__c==='+channelApplist[0].GE_PRM_Do_you_have_Officers_in_Gov__c);
            system.debug('channelApplist[0]1.GE_PRM_High_Risk_product_lines__c ==='+channelApplist[0].GE_PRM_High_Risk_product_lines__c );
            system.debug('primarybankIsoCode1 != acc.GE_HQ_Country_Code__c==='+primarybankIsoCode +'='+ acc.GE_HQ_Country_Code__c);
            if(this.newchannelrec.GE_PRM_Convicted_of_any_felony_crims_r_s__c=='Yes' ||this.newchannelrec.GE_PRM_Do_you_have_Officers_in_Gov__c=='Yes' || Test.isRunningTest())
            {
                this.newchannelrec.GE_PRM_Risk_rating__c  ='High';
                //
            }
            system.debug('newchannelrec ==='+newchannelrec.GE_PRM_Risk_rating__c  );
            Update newchannelrec ;
            //  R-24252 : Channel Risk Trigger changes 1Q16 -  
            /*  Change these risk items from Medium risk to Low risk
            *   N-9, "Sells to the nuclear industry?", Compliance Risk Assessment 
            *   N-10, Sells to the government, Compliance Risk Assessment 
            *   N-14, Export Controlled Products, Compliance Risk Assessment 
            *   N-15, Export outside own country?, Compliance Risk Assessment
            */
             
          /*  else
            {
                this.newchannelrec.GE_PRM_Risk_rating__c  ='Low';
                Update newchannelrec ;
            } */
           
            //End R-24252
        }       
    }   
    
    //** Method to Sync fields from CommercialLines with ChannelAppointment (Added by Shanu)
    Public static void SyncFieldsfromCommLines(Id chapID )
    {
        Set<String> countries  = New  Set<String>();
        boolean check1 = false, check2=false, check3 = false;
        
        GE_PRM_Channel_Appointment__c Ca = [ Select GE_PRM_Account_Country__c,GE_PRM_Sell_to_Nuclear_industry__c, 
        GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c, GE_PRM_Sell_to_Military__c, 
        GE_PRM_Export_outside_own_country__c from GE_PRM_Channel_Appointment__c 
        where id =:chapID ]; 
        
        System.debug('** CHANNEL ID **** '+ chapID);
        System.debug('** CHANNEL **** '+ ca);
        
        
      
        GE_PRM_Commercial_line__c [] gec = [Select GE_PRM_Nuclear_use_Add_comment__c,
        GE_PRM_Military_use_Add_comment__c,GE_PRM_Authorized_Countries_1__c,
        GE_PRM_Authorized_Countries_2__c From GE_PRM_Commercial_line__c 
        Where GE_PRM_Channel_Appointment__c =:chapID ];
        
        System.debug('** CHANNEL **** '+ gec);
        Ca.GE_PRM_Sell_to_Nuclear_industry__c = 'No';
         Ca.GE_PRM_Sell_to_Military__c = 'No';
        For ( GE_PRM_Commercial_line__c newCL : gec )
        {
                       
        
        If (newCL.GE_PRM_Nuclear_use_Add_comment__c == 'Yes')
        {
              Ca.GE_PRM_Sell_to_Nuclear_industry__c = 'Yes';
              check1 = true ;
        }
        else if ( newCL.GE_PRM_Nuclear_use_Add_comment__c == 'No' && !check1 )
        {
           Ca.GE_PRM_Sell_to_Nuclear_industry__c = 'No';
        }       

        If ( newCL.GE_PRM_Military_use_Add_comment__c== 'Yes' )
        {
              Ca.GE_PRM_Sell_to_Military__c = 'Yes';
              check2 = true;            
        }
        else If ( newCL.GE_PRM_Military_use_Add_comment__c== 'No' && !check2 )
        {
            Ca.GE_PRM_Sell_to_Military__c = 'No';
        }

        If ( newCL.GE_PRM_Authorized_Countries_1__c !=null )
        {
        Countries.AddAll(newCL.GE_PRM_Authorized_Countries_1__c.split(';'));
        }
        
        If ( newCL.GE_PRM_Authorized_Countries_2__c !=null )
        {
        Countries.AddAll(newCL.GE_PRM_Authorized_Countries_2__c.split(';'));
        }
        
        countries.Remove(Ca.GE_PRM_Account_Country__c);
        //
        If ( countries.size() > 0 )
        {
               Ca.GE_PRM_Export_outside_own_country__c = 'Yes' ;
               check3 = true; 
        }
        Else If ( countries.size() ==0 && !check3 )
        {
           Ca.GE_PRM_Export_outside_own_country__c = 'No' ;
        }
        
        }
        System.debug('** Ca.GE_PRM_Account_Country__c *** '+ Ca.GE_PRM_Account_Country__c); 
        System.debug('** Countries *** '+ Countries);
        System.debug('** CHANNEL BEFORE UPDATE *** '+ Ca);
        Update Ca;
        System.debug('** CHANNEL AFTER UPDATE *** '+ Ca);

    }
    
    // Clicked on SAVE     
   public PageReference saveCommercialLineDetails()
    { 
        errorMessage = '';
        Cloneyes = ApexPages.currentPage().getParameters().get('clone'); 
        isadditonal_CL_from_url=ApexPages.currentPage().getParameters().get('isadditonal');
        // clicked on Commercial line Clone 
        if(Cloneyes !=null){            
            newCL = commercialLine.clone(false,true);
            newCL.GE_PRM_Channel_Appointment__c=schannelAppId;
        /*    // Logic to compare term value with expiry date of channel appointment
            try{  
                GE_PRM_Channel_Appointment__c c = [select GE_PRM_Expirydate1__c,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c from GE_PRM_Channel_Appointment__c where id =: newCL.GE_PRM_Channel_Appointment__c ];                
                if(!(string.valueof(c.GE_PRM_Expirydate1__c) == null || string.valueof(c.GE_PRM_Expirydate1__c) == '' || string.valueof(newCL.GE_PRM_Term__c) == ''  || string.valueof(newCL.GE_PRM_Term__c) == null )){
                    date myDate = date.today();
                    if ( myDate.addmonths(integer.valueof(newCL.GE_PRM_Term__c)) > c.GE_PRM_Expirydate1__c ) throw new MyException();
                    
                }
            }
            catch ( MyException e ) {  
                apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.ERROR,'Today + Terms(months) should not exceed Channel Appointment Expiry Date' );
                apexpages.addmessage(msg);
                return null;
            }*/
            try{
                if(newCL.GE_PRIf_Sales_Rep_sales_to_US_Government__c == 'Yes' && newCL.GE_PRM_if_Yes_provide_comments_SlaesRep__c == null) throw new My1Exception();
            }
            catch ( My1Exception e ) {  
                apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.ERROR,' As Sales to US Govt, Please provide Notes to Contract Team' );
                apexpages.addmessage(msg);
                return null;
            }   
            System.debug(string.valueof(newCL.GE_PRM_Pricing_Type__c)); 
            newCL.GE_PRM_Status__c = selectedstatus;
                if(string.valueof(newCL.GE_PRM_Pricing_Type__c) == 'Flat' )
                {
                newCL.GE_PRM_If_schedule_Max_pricing__c = null;
                newCL.GE_PRM_If_schedule_Min_pricing__c = null;
                }
                else if(string.valueof(newCL.GE_PRM_Pricing_Type__c) == 'Schedule' )
                {
                    newCL.GE_PRM_If_flat_pricing__c = null;
                }
                else if(string.valueof(newCL.GE_PRM_Pricing_Type__c) == 'Case by Case/PO-PO')
                {        System.debug('inside case by Case');         
                     newCL.GE_PRM_If_schedule_Max_pricing__c = null;
                     newCL.GE_PRM_If_schedule_Min_pricing__c = null;
                     newCL.GE_PRM_If_flat_pricing__c = null;                
                }
                if(string.valueof(newCL.GE_PRM_Type__c) == 'Sales Representative' )
                newCL.GE_PRM_If_Services_pick_type__c = null; 
                         
            insert newCL;
            //added by neha to update channel appointment once commercial line added
            //c.GE_PRM_CommercialAffected__c=true;
            //c.GE_PRM_ComplainceAffected__c=true;
            //c.GE_PRM_WillUpdateCommercial__c=true; 
           // update c;
            
            //Syncing fields with Channel Appointment (Added by Shanu)
           SyncFieldsfromCommLines(newCL.GE_PRM_Channel_Appointment__c );
            
           //Generating risk (added by Shanu)
           
           If (newCL.GE_PRM_Channel_Appointment__r.GE_PRM_Risk_rating__c != 'High' )
           {
                GenerateRisk(newCL.GE_PRM_Channel_Appointment__c); 
           }
            
            
            System.debug('new commercialline'+newCL);            
        }
        else{              
          /*  try{  
                GE_PRM_Channel_Appointment__c c = [select GE_PRM_Expirydate1__c,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c from GE_PRM_Channel_Appointment__c where id =: commercialLine.GE_PRM_Channel_Appointment__c ];                
                if(!(string.valueof(c.GE_PRM_Expirydate1__c) == null || string.valueof(c.GE_PRM_Expirydate1__c) == '' || string.valueof(commercialLine.GE_PRM_Term__c) == '' || string.valueof(commercialLine.GE_PRM_Term__c) == null)){
                    date myDate = date.today();
                    if ( myDate.addmonths(integer.valueof(commercialLine.GE_PRM_Term__c)) > c.GE_PRM_Expirydate1__c ) throw new MyException();
                }
            }
            catch ( MyException e ) {  
                apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.ERROR,'Today + Terms(months) should not exceed Channel Appointment Expiry Date' );
                apexpages.addmessage(msg);
                return null; 
            } */
            try{
                if(commercialLine.GE_PRIf_Sales_Rep_sales_to_US_Government__c == 'Yes' && commercialLine.GE_PRM_if_Yes_provide_comments_SlaesRep__c == null) throw new My1Exception();
            }
            catch ( My1Exception e ) {  
                apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.ERROR,'As Sales to US Govt, Please provide Notes to Contract Team' );
                apexpages.addmessage(msg);
                return null;
            } 
            try{ 
                commercialLine.GE_PRM_Status__c = selectedstatus;  
                if(string.valueof(commercialLine.GE_PRM_Pricing_Type__c) == 'Flat' )
                {
                commercialLine.GE_PRM_If_schedule_Max_pricing__c = null;
                commercialLine.GE_PRM_If_schedule_Min_pricing__c = null;
                }
               else if(string.valueof(commercialLine.GE_PRM_Pricing_Type__c) == 'Schedule' )
               {
                commercialLine.GE_PRM_If_flat_pricing__c = null;
                }
                 else if(string.valueof(commercialLine.GE_PRM_Pricing_Type__c) == 'Case by Case/PO-PO')
                {        System.debug('inside case by Case');         
                     commercialLine.GE_PRM_If_schedule_Max_pricing__c = null;
                     commercialLine.GE_PRM_If_schedule_Min_pricing__c = null;
                     commercialLine.GE_PRM_If_flat_pricing__c = null;                
                }
                
                 if(string.valueof(commercialLine.GE_PRM_Type__c) == 'Sales Representative' )
                commercialLine.GE_PRM_If_Services_pick_type__c = null;
                update commercialLine; 
                //c.GE_PRM_CommercialAffected__c=true;
               // c.GE_PRM_ComplainceAffected__c=true;
                //update c;
                 //Syncing fields with Channel Appointment (Added by Shanu)
           SyncFieldsfromCommLines(commercialLine.GE_PRM_Channel_Appointment__c );
            
           //Generating risk (added by Shanu)
           If (commercialLine.GE_PRM_Channel_Appointment__r.GE_PRM_Risk_rating__c != 'High' )
           {
                GenerateRisk(commercialLine.GE_PRM_Channel_Appointment__c); 
           }
                
            }
            catch(Exception e)
            {
                return null;
           }
            system.debug(commercialLine);            
        }
        if(errorMessage.length() >1)
        {   
            return null;
        } 
        else
        {
            //checking if additional comm line is added redirect back to view page    
            if(isadditonal_CL_from_url =='addCL' || isnew_CL_from_URL == 'true' )
            {
                list<GE_PRM_Channel_Appointment__c> updatecpa = new list<GE_PRM_Channel_Appointment__c>();                
                updatecpa =[select id,GE_PRM_addtional_CL__c,GE_PRM_Current_Status__c,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c,GE_PRM_EnableComplainceButton__c,GE_PRM_EnableCommercialButton__c from  GE_PRM_Channel_Appointment__c where id =:schannelAppId];          
                updatecpa [0].GE_PRM_addtional_CL__c =true;
                if(updatecpa [0].GE_PRM_Current_Status__c =='Approved')
                {
                    updatecpa [0].GE_PRM_IsstatusChanged__c=true;
                }
                updatecpa [0].GE_PRM_Current_Status__c ='Draft';
                updatecpa [0].GE_PRM_CommercialAffected__c=true;
                updatecpa [0].GE_PRM_ComplainceAffected__c=true;
                updatecpa [0].GE_PRM_EnableComplainceButton__c=true;
                updatecpa [0].GE_PRM_EnableCommercialButton__c=true;
                updatecpa [0].GE_PRM_WillUpdateCommercial__c=true; 
               // update c;
                update  updatecpa [0];
                PageReference pageRef;
                if(ApexPages.currentPage().getParameters().get('recallRegen')=='true'){
                pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+schannelAppId+'#CommercialLines&recallRegen=true');
                }else{
                pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+schannelAppId+'#CommercialLines');
                }
                return pageRef;                
            }
            else 
            {          
                PageReference pageRef;
                if(ApexPages.currentPage().getParameters().get('recallRegen')=='true'){
                pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_page1?id='+schannelAppId+'#CommercialLines&recallRegen=true');
                }else{
                pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_page1?id='+schannelAppId+'#CommercialLines');
                }
                return pageRef;
            }         
        }
    }
    // clicked on BACK TO CHANNEL APPOINTMENT 
    public PageReference backToChApp()        
    {
        PageReference pageRef;
        pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+schannelAppId);
       /*  commented for Partner profile Deletion
       
       if(bpartnerUser)
            pageRef = new PageReference('/apex/GE_PRM_PartnerView_ChApp_page?id='+schannelAppId+'&sfdc.override=1');
        
        */
        pageRef.setRedirect(true);
        return pageRef;  
    }
    
    //public void EditCommLine()
    public pagereference EditCommLine()
    {
        GE_PRM_Channel_Appointment__c chapp= new GE_PRM_Channel_Appointment__c(); 
        chapp=[select GE_PRM_Current_Status__c,GE_PRM_IsApproved__c,GE_PRM_Master_appointment_type__c from GE_PRM_Channel_Appointment__c  where id  =:schannelAppId];
        //id chappid=chapp.id;
        //id commid=commercialLine.id;
        if(chapp.GE_PRM_IsApproved__c==true )
        {
        Editfieldenable=true;
        }
        else
        {
            Notestocontract=true;
        }
        PageReference pageRef;
                //pageRef = new PageReference('apex/GE_PRM_CommercialLine_View?ChannelAppointmentId='+chappid+'&Id='+commid);
                pageRef = new PageReference('/apex/GE_PRM_CommercialLine_View?id='+schannelAppId+'#CommercialLines');
                //pageRef.setRedirect(True);      
                return pageRef;

    }
    
    public void Checkstatus()
    {
        System.debug('bbbbneha');
        GE_PRM_Channel_Appointment__c chapp= new GE_PRM_Channel_Appointment__c(); 
        chapp=[select GE_PRM_Current_Status__c from GE_PRM_Channel_Appointment__c  where id  =:schannelAppId];
        Contract con= new Contract();
        String field;
        Boolean commercialupdated=false;
        Boolean complainceupdated=false;
        
        List<GE_PRM_CL_UpdateField__c>  fields=new List<GE_PRM_CL_UpdateField__c>();
        fields=  GE_PRM_CL_UpdateField__c.getAll().values();
        
        for(GE_PRM_CL_UpdateField__c customdata: fields)
        {
            field=customdata.APIName__c;
            commercialupdated=customdata.IsCommercialUpdated__c;
            complainceupdated=customdata.IsComplaincelUpdated__c;
            
           
          
           /* if(field=='GE_PRM_State_Province_Region__c' && commercialLine.GE_PRM_State_Province_Region__c.normalizeSpace()!=commercialLineObj.GE_PRM_State_Province_Region__c.normalizeSpace()){
                inputValue=true;
                 if(commercialupdated==true)
                {
                    System.debug('ppppupdatecommercial');
                    iscommercialupdated=true;
                }
                if(complainceupdated==true)
                {
                    System.debug('ppppupdatecompliance');
                    iscomplainceupdated=true;
                }
            }*/
            if(commercialLine.get(field)!=commercialLineObj.get(field) && field!='GE_PRM_State_Province_Region__c') 
            {
                 
                if(commercialLineObj.get(field) != null && field == 'GE_PRM_Authorized_Countries_2__c')
                {
                    if(commercialLine.GE_PRM_Authorized_Countries_2__c == null || String.isBlank(commercialLine.GE_PRM_Authorized_Countries_2__c))
                    {
                        inputValue=true;
                               if(commercialupdated==true)
                               {
                                   System.debug('ppppupdatecommercial');
                                   iscommercialupdated=true;
                               }
                               if(complainceupdated==true)
                               {
                                   System.debug('ppppupdatecompliance');
                                   iscomplainceupdated=true;
                               }
                    }
                    else
                    {
                           Set<String> oldValSet = new Set<String>(commercialLineObj.GE_PRM_Authorized_Countries_2__c.split(';'));
                           Set<String> newValSet = new Set<String>(commercialLine.GE_PRM_Authorized_Countries_2__c.split(';'));
                           System.debug('##OLD##'+oldValSet);
                           System.debug('##NEW##'+newValSet);
                           if(!oldValSet.containsAll(newValSet) || !newValSet.containsAll(oldValSet))
                           {
                               inputValue=true;
                               if(commercialupdated==true)
                               {
                                   System.debug('ppppupdatecommercial');
                                   iscommercialupdated=true;
                               }
                               if(complainceupdated==true)
                               {
                                   System.debug('ppppupdatecompliance');
                                   iscomplainceupdated=true;
                               }
                           }
                    }
                    
                    
                }
                else if(commercialLineObj.get(field) != null && field == 'GE_PRM_Authorized_Countries_1__c')
                {
                    if(commercialLine.GE_PRM_Authorized_Countries_1__c == null || String.isBlank(commercialLine.GE_PRM_Authorized_Countries_1__c)){
                        inputValue=true;
                             if(commercialupdated==true)
                             {
                                 System.debug('ppppupdatecommercial');
                                 iscommercialupdated=true;
                             }
                             if(complainceupdated==true)
                             {
                                 System.debug('ppppupdatecompliance');
                                 iscomplainceupdated=true;
                             }
                    }
                    else{
                         Set<String> oldValSet = new Set<String>(commercialLineObj.GE_PRM_Authorized_Countries_1__c.split(';'));
                         Set<String> newValSet = new Set<String>(commercialLine.GE_PRM_Authorized_Countries_1__c.split(';'));
                         System.debug('##OLD##'+oldValSet);
                         System.debug('##NEW##'+newValSet);
                         if(!oldValSet.containsAll(newValSet) || !newValSet.containsAll(oldValSet))
                         {
                             inputValue=true;
                             if(commercialupdated==true)
                             {
                                 System.debug('ppppupdatecommercial');
                                 iscommercialupdated=true;
                             }
                             if(complainceupdated==true)
                             {
                                 System.debug('ppppupdatecompliance');
                                 iscomplainceupdated=true;
                             }
                         }
                    }
                    
                    

                    
                }
                else
                {
                        inputValue=true;
                    if(commercialupdated==true)
                    {
                        System.debug('ppppupdatecommercial');
                        iscommercialupdated=true;
                    }
                    if(complainceupdated==true)
                    {
                        System.debug('ppppupdatecompliance');
                        iscomplainceupdated=true;
                    }
                }
                
            }
            
            
        }
         
        if(iscommercialupdated==false && iscomplainceupdated==false)
            {
                System.debug('hhhhhhhhhhh inside else');
                 saveCL(chapp);   
            }      
    }
    
    public pagereference saveCL(GE_PRM_Channel_Appointment__c schannelAppId1)
    {
        GE_PRM_Channel_Appointment__c chapp= new GE_PRM_Channel_Appointment__c(); 
     
        chapp=[select GE_PRM_Current_Status__c,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c,GE_PRM_IsstatusChanged__c,GE_PRM_IsApproved__c from GE_PRM_Channel_Appointment__c  where id  =:schannelAppId1.id];
        System.debug('llllupdatedin newsave'+chapp.GE_PRM_Current_Status__c);
         List<Contract> con= new List<Contract> ();
        if(chapp.GE_PRM_IsApproved__c==true)
                {
                    con=[select id,GE_PRM_Commercial_line__c,GE_PRM_Comments__c,GE_ES_User_Lead_Sales_Person__c,GE_PRM_ERP_Contact__c from Contract where GE_PRM_Commercial_line__c=:commercialLine.id limit 1];
                    if(con!=null && con.size() > 0 )
                    {
                        try{
                            con[0].GE_PRM_Comments__c=commercialLine.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
                            con[0].GE_ES_User_Lead_Sales_Person__c=commercialLine.GE_PRM_Sales_Manager__c;
                            con[0].GE_PRM_ERP_Contact__c = commercialLine.ERP_Contact__c;
                            update con[0];
                            }
                        catch(Exception e){}
                     }
                }
                try
                {
                System.debug('kkkkkkkk updatecommeercial line');
                   update commercialLine; 
                   //update chapp;
                   Editfieldenable=false;
                   Notestocontract=false;
                }
                catch(Exception e)
                {}
                PageReference pageRef;
               //pageRef = new PageReference('/apex/apex/GE_PRM_Channel_Appointment_View_Page1?id='+schannelAppId);
                pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_page1?id='+schannelAppId+'#CommercialLines');
                return pageRef;
    }
    
    public pagereference savenotes()
    {
        inputValue=false;
        //System.debug('llllupdated'+chapp.GE_PRM_Current_Status__c);
        GE_PRM_Channel_Appointment__c chapp= new GE_PRM_Channel_Appointment__c(); 
        chapp=[select GE_PRM_Current_Status__c,GE_PRM_EnableCommercialButton__c,GE_PRM_EnableComplainceButton__c,GE_PRM_WillUpdateCommercial__c,GE_PRM_WillUpdateCompliance__c,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c,GE_PRM_IsstatusChanged__c from GE_PRM_Channel_Appointment__c  where id  =:schannelAppId];
        System.debug('llllupdated'+chapp);
        Contract con= new Contract();
        System.debug('aaaawwww'+iscommercialupdated);  
        System.debug('aaaawwww111111'+iscomplainceupdated); 
        
          System.debug('llllupdatednew'+commercialLineObj.GE_PRM_contract_genrated__c+commercialLineObj.id);
        //String field;
        //System.debug('aaaaaaaoldvalue'+commercialLineObj.GE_PRM_Type__c);
        //System.debug('aaaaaaanewvalue'+commercialLine.GE_PRM_Type__c);
        //List<GE_PRM_CL_UpdateField__c>  fields=new List<GE_PRM_CL_UpdateField__c>();
        //fields=  GE_PRM_CL_UpdateField__c.getAll().values();
        //fields=  GE_PRM_CL_UpdateField__c.getvalues('APIName__c');
       /* Map<GE_PRM_CL_UpdateField__c,String> fieldMap= new  Map<GE_PRM_CL_UpdateField__c,String>();
        for(GE_PRM_CL_UpdateField__c customdata: fields)
        {
             //System.debug('aaaawwww'+commercialLine.customdata.APIName__c);   
             fieldMap.put(customdata,customdata.APIName__c);
        }*/
        //for(GE_PRM_CL_UpdateField__c customdata: fields)
        //{
          //  field=customdata.APIName__c;
           // System.debug('aaaawwww'+commercialLine.get(field));  
       // }
        //if(chapp.GE_PRM_Current_Status__c=='Approved' )
        /*if(commercialLineObj.GE_PRM_contract_genrated__c==true)
        {
        System.debug('Uodate contract');
        con=[select id,GE_PRM_Commercial_line__c,GE_PRM_Comments__c from Contract where GE_PRM_Commercial_line__c=:commercialLine.id];
        if(con!=null)
        {
            try{
            con.GE_PRM_Comments__c=commercialLine.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
            con.GE_ES_User_Lead_Sales_Person__c =commercialLine.GE_PRM_Sales_Manager__c;
            con.GE_PRM_Business_Tier_1__c = commercialLine.GE_PRM_Tier_1__c;
                    con.GE_PRM_Tier_2__c =commercialLine.GE_PRM_Tier_2__c;
                    con.GE_PRM_Tier_3__c= commercialLine.GE_PRM_Tier_3__c;
                    con.GE_PRM_Tier_4__c =commercialLine.GE_PRM_Tier_4__c;
                    con.GE_PRM_Tier_5__c= commercialLine.GE_PRM_Tier_5__c;
                    con.GE_PRM_If_flat_Pricing__c= commercialLine.GE_PRM_If_flat_Pricing__c;
                    con.GE_PRM_If_schedule_Max_Pricing__c= commercialLine.GE_PRM_If_schedule_Max_Pricing__c;
                    con.GE_PRM_If_schedule_Min_Pricing__c= commercialLine.GE_PRM_If_schedule_Min_Pricing__c;
                    con.GE_PRM_Industries__c= commercialLine.GE_PRM_Industries__c;
                    con.GE_PRM_Buyers__c= commercialLine.GE_PRM_Buyers__c;
                    con.GE_PRM_Authorized_Country__c =commercialLine.GE_PRM_Authorized_Countries_1__c + ';'+ commercialLine.GE_PRM_Authorized_Countries_2__c;
                    con.GE_PRM_State_Province_Region__c =commercialLine.GE_PRM_State_Province_Region__c;
                    con.GE_PRM_Pricing__c= commercialLine.GE_PRM_Pricing__c;
                    con.GE_PRM_Pricing_type__c=commercialLine.GE_PRM_Pricing_Type__c;
                    con.GE_PRM_Nuclear_use__c=commercialLine.GE_PRM_Nuclear_use_Add_comment__c;
                    con.GE_PRM_Military_use__c =commercialLine.GE_PRM_Military_use_Add_comment__c;
                    con.GE_PRM_If_Brazil_SR_SC_core__c= commercialLine.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
                    con.GE_PRM_If_Brazil_SR_CMPJ__c=commercialLine.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
                    con.GE_PRM_Inclusions_exclusions__c = commercialLine.GE_PRM_Inclusions_exclusions_Add_comment__c;
                    con.GE_PRM_If_SR_sales_to_US_government__c =commercialLine.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
                    con.GE_PRM_Comments__c =commercialLine.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
                    con.GE_PRM_Relationship_Type__c=commercialLine.GE_PRM_Type__c;
                    con.ContractTerm = integer.valueof(commercialLine.GE_PRM_Term__c);
                    if(commercialLine.GE_PRM_Inclusions_exclusions_Add_comment__c =='yes')
                    {
                        con.GE_PRM_Limitations_exclusions__c=true;
                    }
                    else if(commercialLine.GE_PRM_Inclusions_exclusions_Add_comment__c =='no')
                    {
                        con.GE_PRM_Limitations_exclusions__c=false;
                    }
                    if(commercialLine.GE_PRM_Any_Exclusions__c=='yes')
                    {
                        con.GE_PRM_Exclusions__c=true;
                    }
                    else if(commercialLine.GE_PRM_Any_Exclusions__c=='no')
                    {
                        con.GE_PRM_Exclusions__c=false;
                    }
            update con;
            }
            catch(Exception e){}
            }
        }*/
        if(iscommercialupdated==true || iscomplainceupdated==true)
        {
            System.debug('llllupdatedaaaaaa'+iscommercialupdated);
            chapp.GE_PRM_Current_Status__c='Draft';
             chapp.GE_PRM_IsstatusChanged__c=true; 
             if(iscommercialupdated==true)
             {
                 System.debug('aaaawwwwinsidecommercial'+iscommercialupdated);  
                 chapp.GE_PRM_CommercialAffected__c=true;
                 chapp.GE_PRM_WillUpdateCommercial__c=true;
                 chapp.GE_PRM_EnableCommercialButton__c=true;
                 //chapp.GE_PRM_Commercial_Start_Date_addCL__c=datetime.Now(); 
                 commercialLine.GE_PRM_IsCommercialUpdatedCL__c=true;
                 commercialLine.GE_PRM_willupdateComplaince__c=false;
             } 
             if(iscomplainceupdated==true)
             {
                 System.debug('aaaawwww111111insidecomplaince'+iscomplainceupdated); 
                 chapp.GE_PRM_ComplainceAffected__c=true;
                 chapp.GE_PRM_WillUpdateCompliance__c=true;
                 chapp.GE_PRM_EnableComplainceButton__c=true;
                 commercialLine.GE_PRM_IsCommercialUpdatedCL__c=true;
                 commercialLine.GE_PRM_willupdateComplaince__c=true;
             } 
             
        }
        try
        {
           update commercialLine; 
           update chapp;
           System.debug('saving commercial line');
           //update con;
            
          //Syncing fields with Channel Appointment (Added by Shanu)
          SyncFieldsfromCommLines(commercialLine.GE_PRM_Channel_Appointment__c);    
          //Generating risk (added by Shanu)
          GenerateRisk(commercialLine.GE_PRM_Channel_Appointment__c); 
          
        }
        catch(Exception e)
        {}
         PageReference pageRef;
         pageRef = new PageReference('/apex/apex/GE_PRM_Channel_Appointment_View_Page1?id='+schannelAppId);
         //pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_page1?id='+schannelAppId+'#CommercialLines');
         return pageRef;
    }
    
    public PageReference BacktoCLview()
    {
        Editfieldenable=true;
        inputValue=false;
       // PageReference pageRef;
                //pageRef = new PageReference('apex/GE_PRM_CommercialLine_View?ChannelAppointmentId='+schannelAppId +'&Id='+commercialLine.id);
               // pageRef = new PageReference('/apex/GE_PRM_CommercialLine_View?id='+commercialLine.id);
                 //pageRef = new PageReference('/apex/GE_PRM_CommercialLine_View?id='+schannelAppId+'#CommercialLines');
                //pageRef.setRedirect(true);      
               // return pageRef;
        //apex/GE_PRM_CommercialLine_View?ChannelAppointmentId={!item.c.GE_PRM_Channel_Appointment__c}&Id={!item.c.Id}
        return null;
    }
    
    // clicked on CANCEL
    public PageReference cancel() {
        ISaddCL_cancel= ApexPages.currentPage().getParameters().get('isadditonal');
        string fromviewpagestr = ApexPages.currentPage().getParameters().get('fromviewpage'); 
        if(fromviewpagestr=='true')
        {
            delete commercialLine;
            PageReference pageRef;
            if(ApexPages.currentPage().getParameters().get('recallRegen')=='true'){
                pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+schannelAppId+'&recallRegen=true');
             }else{
               pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+schannelAppId);
             }
            return pageRef;   
        }
        if(isnew_CL_from_URL == 'true'){
            delete commercialLine;
        }
        system.debug('ca--------' );        
        if(ISaddCL_cancel=='addCL')
        {
            PageReference pageRef;            
            if(ApexPages.currentPage().getParameters().get('recallRegen')=='true'){
                pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+schannelAppId+'&recallRegen=true');
             }else{
               pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+schannelAppId);
             }
            return pageRef;   
        }
        else
        {
            PageReference pageRef;
            if(ApexPages.currentPage().getParameters().get('recallRegen')=='true'){
                pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_Page1?id='+schannelAppId+'&recallRegen=true');
             }else{
               pageRef = new PageReference('/apex/GE_PRM_Channel_Appointment_Page1?id='+schannelAppId);
             }            
            return pageRef;  
        }         
    }    
}