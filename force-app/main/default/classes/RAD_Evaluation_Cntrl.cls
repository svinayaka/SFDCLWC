public class RAD_Evaluation_Cntrl{
    public String eradId{get;set;}
    public List<eRAD__c> eRadRecRes{get;set;}
    Public List<eRAD__c> erAdlist{get;set;}
    public LIst<Competitor__c> competitorsList{get;set;}
    public boolean errormsg{get;set;}
    public boolean capexboo{get;set;}
    public boolean opexboo{get;set;}
    public boolean commboo{get;set;}
    public boolean refboo{get;set;}
    public boolean relboo{get;set;}
    public boolean techboo{get;set;}
    public boolean catw8hboo{get;set;}
    public boolean capexscrboo{get;set;}
    public boolean opexscrboo{get;set;}
    public boolean commscrboo{get;set;}
    public boolean refscrboo{get;set;}
    public boolean relscrboo{get;set;}
    public boolean techscrboo{get;set;}
    public String browserName{get;set;}
    public RAD_Evaluation_Cntrl(ApexPages.StandardController controller) {
        eradId = (String)controller.getRecord().get('id');
        if(eradid != null)
        eRadRecRes = eradQuery(eradid);
        if(eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - CSA').getRecordTypeId() || eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS- CSA Read Only').getRecordTypeId() || eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS New Units/Opex').getRecordTypeId() || eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId()){
            eRadRecRes[0].TP_Value__c = String.ValueOf(eRadRecRes[0].Opportunity_Amount__c);
        }
        erAdlist = new List<eRad__c>();
        erAdlist.addall(eRadRecRes);
        competitorsList = new List<Competitor__c>();
        for(eRAD__c e : eRadRecRes){
            for(Competitor__c con : e.Competitors__r)
                competitorsList.add(con);
        }
    }
    //remove the field from Query while renaming the object 'Project' : Opportunity__r.GE_ES_Project__r.name,
    public List<eRAD__c> eradQuery(id eradid){
        return [select id,Name,Status__c,Opportunity__c,Opportunity_Number__C,Opportunity_Status__c,RecordtypeId ,Opportunity_Name__c,Opportunity_Amount__c,Highllights__c,TP_Rating__c,TP_Value__c,TP_Remarks__c,TrP_Remarks__c,TrP_Rating__c,TrP_Value__c,TeP_Rating__c,TeP_Value__c,EP_Value__c,EP_Rating__c,EP_Remarks__c,
                            Capex_Category_weight__c,Total_Price__c,Equipment_Price__c,Installation_Price__c,Training_Price__c,Spare_parts_Price__c,Tests_Price__c,BOP_Price__c,IP_Rating__c,IP_Value__c,IP_Remarks__c,SpP_Value__c,SpP_Rating__c,SpP_Remarks__c,
                            TeP_Remarks__c,BP_Rating__c,BP_Value__c,BP_Remarks__c,(select id,Name,Competitor__c,TP_Rating__c,TP_Value__c,BP_Rating__c,BP_Value__c,EP_Rating__c,EP_Value__c,IP_Rating__c,IP_Value__c,SpP_Rating__c,SpP_Value__c,TeP_Rating__c,TeP_Value__c,TrP_Rating__c,TrP_Value__c,
                            TP_Comparison__C,EP_Comparison__c,IP_Comparison__c,SpP_Comparison__c,TrP_Comparison__c,TeP_Comparison__c,BP_Comparison__c,Effieciency_Rating__c,Effieciency_Value__c,Maintenability_Rating__c,Maintenability_Value__c,Availability_Rating__c,Availability_Value__c,
                            FEC_Rating__c,FEC_Value__c,Reliability_Rating__c,Reliability_Value__c,MC_Value__c,MC_Rating__c,Responsiveness_Value__c,Responsiveness_Rating__c,T_C_Rating__c,T_C_Value__c,Delivery_wk_Rating__c,Delivery_wk_Value__c,Pre_bid_support_Value__c,Pre_bid_support_Rating__c,
                            Submission_Value__c,Submission_Rating__c,OEM_Value__c,OEM_Rating__c,FA_agreement_EPC_Value__c,FA_agreement_EPC_Rating__c,FA_agreement_End_Value__c,FA_agreement_End_Rating__c,Quick_negotiation_Value__c,Quick_negotiation_Rating__c,BTD_Value__c,BTD_Rating__c,
                            ASS_Value__c,ASS_Rating__c,Agreement_Value__c,Agreement_Rating__c,Pre_bid_agreement_Value__c,Pre_bid_agreement_Rating__c,Installation_time_Value__c,Installation_time_Rating__c,ISR_Value__c,ISR_Rating__c,CIF_Value__c,CIF_Rating__c,RIF_Value__c,RIF_Rating__c,OTR_Value__c,OTR_Rating__c,
                            CPIF_Value__c,CPIF_Rating__c,Localization_Value__c,Localization_Rating__c,SW_Value__c,SW_Rating__c,PES_Value__c,PES_Rating__c,RWEU_Value__c,RWEU_Rating__c,RWE_Value__c,RWE_Rating__c,RWI_Value__c,RWI_Rating__c,Reputation_Value__c,Reputation_Rating__c,RWB_Value__c,RWB_Rating__c,
                            SD_Value__c,SD_Rating__c,PR_Value__c,PR_Rating__c,TP_CSA_Value__c,TP_CSA_Rating__c,PM_Driver_CSA_Value__c,PM_Driver_CSA_Rating__c,PM_Driven_CSA_Value__c,PM_Driven_CSA_Rating__c,UM_CSA_Value__c,UM_CSA_Rating__c,CPMT_CSA_Value__c,CPMT_CSA_Rating__c,Service_CSA_Value__c,Service_CSA_Rating__c,
                            IS_CSA_Value__c,IS_CSA_Rating__c,PMP_Value__c,PMP_Rating__c,Engineering_Price_Rating__c,Engineering_Price_Value__c,ICSSP_Value__c,ICSSP_Rating__c,FSER_Value__c,FSER_Rating__c,RTP_Value__c,RTP_Rating__c,Storage_Price_Value__c,Storage_Price_Rating__c,IWOCS_Value__c,IWOCS_Rating__c,
                            OP_Value__c,OP_Rating__c,CWOR_Rating__c,CWOR_Value__c,PMP_Comparison__c,Engineering_Price_Comparison__c,ICSSP_Comparison__c,FSE_Comparison__c,RTP_Comparison__c,Storage_Price_Comparison__c,IWOCS_Comparison__c,OP_Comparison__c,CWOR_Comparison__c,
                            Ability_to_meet_Customer_Spec_Value__c,Ability_to_meet_Customer_Spec_Rating__c,MD_Value__c,MD_Rating__c,SVP_Value__c,SVP_Raitng__c,Footprint_Value__c,Footprint_Rating__c,IS_Value__c,IS_Rating__c,Weight_Value__c,Weight_Rating__c,Noise_Value__c,Noise_Rating__c,
                            CCOF_Value__c,CCOF_Rating__c,Test_Value__c,Test_Rating__c,Train_line_up_Value__c,Train_line_up_Rating__c,MQ_Value__c,MQ_Rating__c,GT_Value__c,GT_Rating__c,GTFF_Value__c,GTFF_Rating__c,Covered_units_Rating__c,Covered_units_Value__c,
                            AT_CSA_Value__c,AT_CSA_Rating__c,RT_CSA_Value__c,RT_CSA_Rating__c,OP_CSA_Value__c,OP_CSA_Rating__c,ESF_Value__c,ESF_Rating__c,FSE_Value__c,FSE_Rating__c,RTR_Value__c,RTR_Rating__c,SR_Value__c,SR_Rating__c,TR_Value__c,TR_Rating__c,TC_Value__c,TC_Rating__c,
                            ID_Value__c,ID_Rating__c,STT_Value__c,STT_Rating__c,RT_Value__c,RT_Rating__c,Repair_turnaround_Value__c,Repair_turnaround_Rating__c,IWOCS_Rates_Value__c,IWOCS_Rates_Rating__c,CWOR_Rates_Value__c,CWOR_Rates_Rating__c,LSR_Value__c,LSR_Rating__c,
                            LC_Value__c,LC_Rating__c,CA_Value__c,CA_Rating__c,FP_Value__c,FP_Rating__c,Incumbent_Supplier_Value__c,Incumbent_Supplier_Rating__c,Mobilization_Value__c,Mobilization_Rating__c,AI_Rating__c,RWKA_Value__c,RWKA_Rating__c,RWPT_Value__c,RWPT_Rating__c,
                            RWBT_Value__c,RWBT_Rating__c,RWS_Value__c,RWS_Rating__c,RWSC_Value__c,RWSC_Rating__c,AI_Value__c,CPPS_Value__c,CPPS_Rating__c,MRS_Value__c,MRS_Rating__c,FL_Value__c,FL_Rating__c,MTPR_Value__c,MTPR_Rating__c,MSHR_Value__c,MSHR_Rating__c,
                            EoI_Value__c,EoI_Rating__c,FFP_Value__c,FFP_Rating__c,RFN_Value__c,RFN_Rating__c,RFQ_Value__c,RFQ_Rating__c,CHLC_Value__c,CHLC_Rating__c,RBUP_Value__c,RBUP_Rating__c,Capex_Score__c,Opex_Score__c,Commercial_Score__c,
                            References_Score__c,Relations_Score__c,Technical_Score__c,Total_Competitor_Score__c,Reliability_product_life_Rating__c,Reliability_product_life_Value__c,Discounts_Value__c,Discounts_Rating__c,
                            Design_alignment_Value__c,Design_alignment_Rating__c,Spare_parts_cost_Value__c,Spare_parts_cost_Rating__c,Operational_Flexibility_Rating__c,Operational_Flexibility_Value__c,Testing_Rating__c,Testing_Value__c,X3rd_Party_Price_Comparison__c,
                            High_strength_material_Value__c,High_strength_material_Rating__c,Forging_technology_Value__c,Forging_technology_Rating__c,X3rd_Party_Price_Rating__c,X3rd_Party_Price_Value__c,Overall_Dimensions_Value__c,Overall_Dimensions_Rating__c,Rental_Duration_Value__c,Rental_Duration_Rating__c from Competitors__r Order by CReatedDate),
                            Reliability__c,Reliability_Rating__c,Reliability_Value__c,Maintenability__c,Maintenability_Rating__c,Maintenability_Value__c,Availability__c,Availability_Rating__c,Availability_Value__c,Field_engineer_cost__c,FEC_Rating__c,FEC_Value__c,Maintenance_Cost__c,
                            MC_Rating__c,MC_Value__c,Effieciency__c,Effieciency_Rating__c,Effieciency_Value__c,Availability_Remarks__c,FEC_Remarks__c,Maintenability_Remarks__c,MC_Remarks__c,Reliability_Remarks__c,Effieciency_Remarks__c,Opex_Category_weight__c,
                            Commercial_Category_weight__c,Delivery_wk__c,Delivery_wk_Rating__c,Delivery_wk_Remarks__c,Delivery_wk_Value__c,T_C__c,T_C_Rating__c,T_C_Remarks__c,T_C_Value__c,Responsiveness__c,Responsiveness_Value__c,Responsiveness_Rating__c,Responsiveness_Reamarks__c,
                            Pre_bid_support__c,Pre_bid_support_Value__c,Pre_bid_support_Rating__c,Pre_bid_support_Remarks__c,submission_best_price__c,Submission_Value__c,Submission_Rating__c,Submission_Remarks__c,OEM_Integrated_Solution__c,OEM_Value__c,OEM_Rating__c,OEM_Remarks__c,
                            FA_agreement_End_Rating__c,FA_agreement_End_Value__c,FA_agreement_End_Remarks__c,FA_agreement_w_EPC__c,FA_agreement_EPC_Value__c,FA_agreement_EPC_Rating__c,FA_agreement_EPC_Remarks__c,Quick_negotiation__c,Quick_negotiation_Value__c,
                            Quick_negotiation_Rating__c,Quick_negotiation_Remarks__c,Bidder_Tender_deviations__c,BTD_Value__c,BTD_Rating__c,BTD_Remarks__c,After_Sales_services__c,ASS_Value__c,ASS_Rating__c,ASS_Remarks__c,Agreement_w_Buyer__c,Agreement_Value__c,Agreement_Rating__c,
                            Agreement_Remarks__c,Pre_bid_agreement_EPC__c,Pre_bid_agreement_Value__c,Pre_bid_agreement_Rating__c,Pre_bid_agreement_Remarks__c,Installation_time_wk__c,Installation_time_Value__c,Installation_time_Rating__c,Installation_time_Remarks__c,FA_agreement_w_End_User__c,
                            Industrial_Service_References__c,ISR_Value__c,ISR_Rating__c,ISR_Remarks__c,Customer_Installed_Fleet__c,CIF_Value__c,CIF_Rating__c,CIF_Remarks__c,Region_installed_Fleet__c,RIF_Value__c,RIF_Rating__c,RIF_Remarks__c,OTR_performances__c,OTR_Value__c,OTR_Rating__c,
                            OTR_Remarks__c,Customer_Plant_Installed_Fleet__c,CPIF_Value__c,CPIF_Rating__c,CPIF_Remarks__c,Localization__c,Localization_Value__c,Localization_Rating__c,Localization_Remarks__c,Service_Workshops__c,SW_Value__c,SW_Rating__c,SW_Remarks__c,Prior_Equipment_Supplier__c,
                            PES_Value__c,PES_Rating__c,PES_Remarks__c,Relations_With_End_User__c,RWEU_Value__c,RWEU_Rating__c,RWEU_Remarks__c,RWE_Value__c,RWE_Rating__c,RWE_Remarks__c,Relations_with_Influencer__c,RWI_Value__c,RWI_Rating__c,RWI_Remarks__c,Reputation__c,
                            Reputation_Value__c,Reputation_Rating__c,Reputation_Remarks__c,Relations_with_Buyer__c,RWB_Value__c,RWB_Rating__c,RWB_Remarks__c,Supplier_Diversification__c,SD_Value__c,SD_Rating__c,SD_Remarks__c,Reference_Category_Weight__c,Relation_Category_Weight__c,
                            Product_References__c,PR_Value__c,PR_Rating__c,PR_Remarks__c,Relations_with_EPC__c,Total_Price_CSA__c,TP_CSA_Value__c,TP_CSA_Rating__c,TP_CSA_Remarks__c,Planned_Maintenance_Driver_CSA__c,PM_Driver_CSA_Value__c,PM_Driver_CSA_Rating__c,PM_Driver_CSA_Remarks__c,
                            Planned_Maintenance_Driven_CSA__c,PM_Driven_CSA_Value__c,PM_Driven_CSA_Rating__c,PM_Driven_CSA_Remarks__c,Unplanned_Maintenance_CSA__c,UM_CSA_Value__c,UM_CSA_Rating__c,UM_CSA_Remarks__c,CPMT_CSA__c,CPMT_CSA_Value__c,CPMT_CSA_Rating__c,CPMT_CSA_Remarks__c,Service_2_0_CSA__c,
                            Service_CSA_Value__c,Service_CSA_Rating__c,Service_CSA_Remarks__c,Initial_Spares_CSA__c,IS_CSA_Value__c,IS_CSA_Rating__c,IS_CSA_Remarks__c,Project_Management_Price__c,PMP_Value__c,PMP_Rating__c,PMP_Remarks__c,Engineering_Price__c,Engineering_Price_Value__c,
                            Engineering_Price_Rating__c,Engineering_Price_Remarks__c,In_Country_Support_Services_Price__c,ICSSP_Value__c,ICSSP_Rating__c,ICSSP_Remarks__c,Field_Service_Engineering__c,FSE_Value__c,FSE_Rating__c,FSER_Remarks__c,Rental_Tools_Price__c,RTP_Value__c,RTP_Rating__c,
                            RTP_Remarks__c,Storage_Price__c,Storage_Price_Value__c,Storage_Price_Rating__c,Storage_Price_Remarks__c,IWOCS_Price__c,IWOCS_Value__c,IWOCS_Rating__c,IWOCS_Remarks__c,Other_Price__c,OP_Value__c,OP_Rating__c,OP_Remarks__c,CWOR_Price__c,CWOR_Value__c,CWOR_Rating__c,CWOR_Remarks__c,
                            Ability_to_meet_Customer_Spec__c,Ability_to_meet_Customer_Spec_Value__c,Ability_to_meet_Customer_Spec_Rating__c,Ability_to_meet_Customer_Remarks__c,Machine_design__c,MD_Value__c,MD_Rating__c,MD_Remarks__c,Sub_Vendor_Preferences__c,SVP_Value__c,SVP_Raitng__c,SVP_Remarks__c, 
                            Footprint_m2__c,Footprint_Value__c,Footprint_Rating__c,Footprint_Remarks__c,Integrated_Solution__c,IS_Value__c,IS_Rating__c,IS_Remarks__c,Weights__c,Weight_Value__c,Weight_Rating__c,Weight_Remarks__c,Noise_db_A__c,Noise_Value__c,Noise_Rating__c,Noise_Remarks__c,
                            CC_Operational_Flexibility__c,CCOF_Value__c,CCOF_Rating__c,CCOF_Remarks__c,Test_Value_Driver__c,Test_Value__c,Test_Rating__c,Test_Remarks__c,Train_line_up_number_of_casings__c,Train_line_up_Value__c,Train_line_up_Rating__c,Train_line_up_Remarks__c,
                            Mechanical_quality__c,MQ_Value__c,MQ_Rating__c,MQ_Remarks__c,GT_Emissions_NOX_CO__c,GT_Value__c,GT_Rating__c,GT_Remarks__c,GT_Fuel_Flexibility__c,GTFF_Value__c,GTFF_Rating__c,GTFF_Remarks__c,Covered_units_and_IOC_details_CSA_Only__c,Covered_units_Rating__c,Covered_units_Remarks__c,
                            Availability_target_inc_bonus_LDs_CSA__c,AT_CSA_Value__c,AT_CSA_Rating__c,AT_CSA_Remarks__c,Reliability_target_inc_bonus_LDs_CSA__c,RT_CSA_Value__c,RT_CSA_Rating__c,RT_CSA_Remarks__c,Other_Performances_CSA_Only__c,OP_CSA_Value__c,OP_CSA_Rating__c,OP_CSA_Reamrks__c,ESF_Value__c,ESF_Rating__c,ESF_Remarks__c,
                            Technical_Category_weight__c,Field_Service_Engineer_Rate__c,FSER_Value__c,FSER_Rating__c,FSE_Remarks__c,Rental_Tools_Rates__c,RTR_Value__c,RTR_Rating__c,RTR_Remarks__c,Storage_Rates__c,SR_Value__c,SR_Rating__c,SR_Remarks__c,Training_Rates__c,
                            TR_Value__c,TR_Rating__c,TR_Remarks__c,Testing_costs__c,TC_Value__c,TC_Rating__c,TC_Remarks__c,Intervention_downtime__c,ID_Value__c,ID_Rating__c,ID_Remarks__c,Single_trip_tools__c,STT_Value__c,STT_Rating__c,STT_Remarks__c,Retrieval_time__c,RT_Value__c,RT_Rating__c,RT_Remarks__c,
                            Repair_turnaround__c,Repair_turnaround_Value__c,Repair_turnaround_Rating__c,Repair_turnaround_Remarks__c,IWOCS_Rates__c,IWOCS_Rates_Value__c,IWOCS_Rates_Rating__c,IWOCS_Rates_Remarks__c,CWOR_Rates__c,CWOR_Rates_Value__c,CWOR_Rates_Rating__c,CWOR_Rates_Remarks__c,
                            Landing_String_Rates__c,LSR_Value__c,LSR_Rating__c,LSR_Remarks__c,Local_Content__c,LC_Value__c,LC_Rating__c,LC_Remarks__c,Channel_Availability__c,CA_Value__c,CA_Rating__c,CA_Reamrks__c,Field_Proven__c,FP_Value__c,FP_Rating__c,FP_Remarks__c,Incumbent_Supplier__c,
                            Incumbent_Supplier_Value__c,Incumbent_Supplier_Rating__c,Incumbent_Supplier_Remarks__c,Mobilization__c,Mobilization_Value__c,Mobilization_Rating__c,Mobilization_Remarks__c,Agent_Influence__c,AI_Rating__c,AI_Remarks__c,Relations_w_EU_Bid_Teams__c,Relations_w_EU_Key_Accounts__c,
                            Relations_w_EU_Project_Teams__c,Relations_w_Key_Stakeholders__c,Relations_w_Supply_Chain__c,AI_Value__c,RWSC_Value__c,RWKA_Value__c,RWKA_Rating__c,RWKA_Remarks__c,RWPT_Value__c,RWPT_Rating__c,RWPT_Remarks__c,RWBT_Value__c,RWBT_Rating__c,RWBT_Remarks__c,RWS_Value__c,RWS_Rating__c,RWS_Remarks__c,RWSC_Rating__c,RWSC_Remarks__c,
                            Customers_Preference_for_3rd_Party_Supp__c,CPPS_Value__c,CPPS_Rating__c,CPPS_Remarks__c,Meet_Relevant_Standards__c,MRS_Value__c,MRS_Rating__c,MRS_Remarks__c,Field_Layout__c,FL_Value__c,FL_Rating__c,FL_Remarks__c,Meet_Temperature_Pressure_Req__c,MTPR_Value__c,
                            MTPR_Rating__c,MTPR_Remarks__c,Meet_Sweet_Sour_Hydrocarbon_Req__c,MSHR_Value__c,MSHR_Rating__c,MSHR_Remarks__c,Ease_of_Intervention__c,EoI_Value__c,EoI_Rating__c,EoI_Remarks__c,Fit_for_Purpose__c,FFP_Value__c,FFP_Rating__c,FFP_Remarks__c,Requirements_for_NPI__c,
                            RFN_Value__c,RFN_Rating__c,RFN_Remarks__c,Requirements_for_Qualifications__c,RFQ_Value__c,RFQ_Rating__c,RFQ_Remarks__c,Rental_Back_Up_Provisions__c,RBUP_Value__c,RBUP_Rating__c,RBUP_Remarks__c,Casing_Hanger_Lockdown_Capability__c,CHLC_Value__c,CHLC_Rating__c,CHLC_Remarks__c,
                            Capex_Score__c,Opex_Score__c,Commercial_Score__c,References_Score__c,Relations_Score__c,Technical_Score__c,Equipment_Size_Fitting__c,Total_Oppty_Score__c,Reliability_product_life__c,Reliability_product_life_Rating__c,Reliability_product_life_Remarks__c,Reliability_product_life_Value__c,Discounts__c,Discounts_Rating__c,Discounts_Remarks__c,Discounts_Value__c,
                            Design_alignment__c,Design_alignment_Rating__c,Design_alignment_Remarks__c,Design_alignment_Value__c,Spare_parts_cost__c,Spare_parts_cost_Rating__c,Spare_parts_cost_Remarks__c,Spare_parts_cost_Value__c,Covered_units_Value__c,
                            High_strength_material__c,High_strength_material_Rating__c,High_strength_material_Remarks__c,High_strength_material_Value__c,Forging_technology__c,Forging_technology_Rating__c,Forging_technology_Remarks__c,Forging_technology_Value__c,Opportunity_Amount_SS__c,Testing__c,Testing_Rating__c,Testing_Value__c,Testing_Remarks__c,
                            Operational_Flexibility__c,Operational_Flexibility_Rating__c,Operational_Flexibility_Value__c,Operational_Flexibility_Remarks__c,X3rd_Party_Price__c,X3rd_Party_Price_Rating__c,X3rd_Party_Price_Remarks__c,X3rd_Party_Price_Value__c,Rental_Duration__c,Rental_Duration_Rating__c,
                            Rental_Duration_Remarks__c,Rental_Duration_Value__c,Overall_Dimensions__c,Overall_Dimensions_Rating__c,Overall_Dimensions_Remarks__c,Overall_Dimensions_Value__c,Opportunity_Tier_2_P_L__c,Opportunity_Tier_3_P_L__c,Segment__c from eRad__c where id =: eradid Limit 1];
    }
    public PageReference savecontent(){
        errormsg = capexboo = opexboo = commboo = refboo = relboo = techboo = catw8hboo = capexscrboo = opexscrboo = commscrboo = refscrboo = relscrboo = techscrboo = false;
        integer totalcategoryweight = Integer.valueOf(erAdlist[0].Capex_Category_weight__c.substring(0,erAdlist[0].Capex_Category_weight__c.length() - 1)) + Integer.valueOf(erAdlist[0].Opex_Category_weight__c.substring(0,erAdlist[0].Opex_Category_weight__c.length() - 1)) + Integer.valueOf(erAdlist[0].Commercial_Category_weight__c.substring(0,erAdlist[0].Commercial_Category_weight__c.length() - 1)) + Integer.valueOf(erAdlist[0].Reference_Category_Weight__c.substring(0,erAdlist[0].Reference_Category_Weight__c.length() - 1)) + Integer.valueOf(erAdlist[0].Relation_Category_Weight__c.substring(0,erAdlist[0].Relation_Category_Weight__c.length() - 1)) + Integer.valueOf(erAdlist[0].Technical_Category_weight__c.substring(0,erAdlist[0].Technical_Category_weight__c.length() - 1));
        
        if(erAdlist[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId() || erAdlist[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea Read Only').getRecordTypeId()){
            SubSea_Validations();
        }else{
            TMS_Validations();
        }
        if(totalcategoryweight != 100){
            errormsg = catw8hboo = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Category Weights should be 100%.'));
        }else{
            catw8hboo = false;
        }
        
        if(capexboo == false && opexboo == false && commboo == false && commboo == false && refboo == false && relboo == false && techboo == false && catw8hboo == false && capexscrboo == false && opexscrboo == false && commboo == false && commscrboo == false && refscrboo == false && relscrboo == false && techscrboo == false){
            errormsg = false;
            if(erAdlist != null){
                update erAdlist;
            }
            if(competitorsList != null)
                update competitorsList;
            return new PageReference('/'+eradid);
        }
        
        return null;
    }
    
    public Pagereference  ss_savecontent(){    
        errormsg = false;
        if(erAdlist != null){
            update erAdlist;
        }
        if(competitorsList != null)
            update competitorsList;
        return new PageReference('/'+eradid);
    }
    public Pagereference save_custom(){    
        errormsg = false;
        if(erAdlist != null){
            update erAdlist;
        }
        if(competitorsList != null)
            update competitorsList;
        return null;
    }
    public Pagereference cancelpage(){
        return new PageReference('/'+eradid);
    }
    public void TMS_Validations(){
        if(erAdlist[0].Capex_Category_Weight__c != '0%'){
            integer totalcapexcatew8 = Integer.valueOf(erAdlist[0].Total_Price__c.substring(0,erAdlist[0].Total_Price__c.length() - 1)) + Integer.valueOf(erAdlist[0].Equipment_Price__c.substring(0,erAdlist[0].Equipment_Price__c.length() - 1)) + Integer.valueOf(erAdlist[0].Installation_Price__c.substring(0,erAdlist[0].Installation_Price__c.length() - 1)) + Integer.valueOf(erAdlist[0].Training_Price__c.substring(0,erAdlist[0].Training_Price__c.length() - 1)) + Integer.valueOf(erAdlist[0].Spare_parts_Price__c.substring(0,erAdlist[0].Spare_parts_Price__c.length() - 1)) + Integer.valueOf(erAdlist[0].Tests_Price__c.substring(0,erAdlist[0].Tests_Price__c.length() - 1)) + Integer.valueOf(erAdlist[0].BOP_Price__c.substring(0,erAdlist[0].BOP_Price__c.length() - 1));
            if(totalcapexcatew8 != 100){
                errormsg = capexboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Capex Value Attribute Weight should be 100%.'));
            }else{
                capexboo = false;
            }
            if(erAdlist[0].Capex_Score__c == null || erAdlist[0].Capex_Score__c == '0.0'){
                errormsg = capexscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Capex Score of GE O&G is Blank.'));
            }else{
                capexscrboo = false;
            }
        }
        if(erAdlist[0].Opex_Category_Weight__c != '0%'){
            integer totalOpexcatew8 = Integer.valueOf(erAdlist[0].Reliability__c.substring(0,erAdlist[0].Reliability__c.length() - 1)) + Integer.valueOf(erAdlist[0].Maintenability__c.substring(0,erAdlist[0].Maintenability__c.length() - 1)) + Integer.valueOf(erAdlist[0].Availability__c.substring(0,erAdlist[0].Availability__c.length() - 1)) + Integer.valueOf(erAdlist[0].Field_engineer_cost__c.substring(0,erAdlist[0].Field_engineer_cost__c.length() - 1)) + Integer.valueOf(erAdlist[0].Maintenance_Cost__c.substring(0,erAdlist[0].Maintenance_Cost__c.length() - 1)) + Integer.valueOf(erAdlist[0].Effieciency__c.substring(0,erAdlist[0].Effieciency__c.length() - 1)) + Integer.valueOf(erAdlist[0].Total_Price_CSA__c.substring(0,erAdlist[0].Total_Price_CSA__c.length() - 1)) + Integer.valueOf(erAdlist[0].Planned_Maintenance_Driver_CSA__c.substring(0,erAdlist[0].Planned_Maintenance_Driver_CSA__c.length() - 1)) + Integer.valueOf(erAdlist[0].Planned_Maintenance_Driven_CSA__c.substring(0,erAdlist[0].Planned_Maintenance_Driven_CSA__c.length() - 1)) + Integer.valueOf(erAdlist[0].Unplanned_Maintenance_CSA__c.substring(0,erAdlist[0].Unplanned_Maintenance_CSA__c.length() - 1)) + Integer.valueOf(erAdlist[0].CPMT_CSA__c.substring(0,erAdlist[0].CPMT_CSA__c.length() - 1)) + Integer.valueOf(erAdlist[0].Service_2_0_CSA__c.substring(0,erAdlist[0].Service_2_0_CSA__c.length() - 1)) + Integer.valueOf(erAdlist[0].Initial_Spares_CSA__c.substring(0,erAdlist[0].Initial_Spares_CSA__c.length() - 1));
            if(totalOpexcatew8 != 100){
                errormsg = opexboo =  true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Opex Value Attribute Weight should be 100%.'));
            }else{
                opexboo = false;
            }
            if(erAdlist[0].Opex_Score__c == null || erAdlist[0].Opex_Score__c == '0.0'){
                errormsg = opexscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Opex Score of GE O&G is Blank.'));
            }else{
                opexscrboo = false;
            }
        }
        if(erAdlist[0].Commercial_Category_weight__c != '0%'){
           // integer totalCommcatew8 = Integer.valueOf(erAdlist[0].Delivery_wk__c.substring(0,erAdlist[0].Delivery_wk__c.length() - 1)) + Integer.valueOf(erAdlist[0].T_C__c.substring(0,erAdlist[0].T_C__c.length() - 1)) + Integer.valueOf(erAdlist[0].Availability__c.substring(0,erAdlist[0].Availability__c.length() - 1)) + Integer.valueOf(erAdlist[0].Responsiveness__c.substring(0,erAdlist[0].Responsiveness__c.length() - 1)) + Integer.valueOf(erAdlist[0].Pre_bid_support__c.substring(0,erAdlist[0].Pre_bid_support__c.length() - 1)) + Integer.valueOf(erAdlist[0].submission_best_price__c.substring(0,erAdlist[0].submission_best_price__c.length() - 1)) + Integer.valueOf(erAdlist[0].OEM_Integrated_Solution__c.substring(0,erAdlist[0].OEM_Integrated_Solution__c.length() - 1)) + Integer.valueOf(erAdlist[0].FA_agreement_w_End_User__c.substring(0,erAdlist[0].FA_agreement_w_End_User__c.length() - 1)) + Integer.valueOf(erAdlist[0].Quick_negotiation__c.substring(0,erAdlist[0].Quick_negotiation__c.length() - 1)) + Integer.valueOf(erAdlist[0].Bidder_Tender_deviations__c.substring(0,erAdlist[0].Bidder_Tender_deviations__c.length() - 1)) + Integer.valueOf(erAdlist[0].After_Sales_services__c.substring(0,erAdlist[0].After_Sales_services__c.length() - 1)) + Integer.valueOf(erAdlist[0].Service_2_0_CSA__c.substring(0,erAdlist[0].Service_2_0_CSA__c.length() - 1)) + Integer.valueOf(erAdlist[0].Agreement_w_Buyer__c.substring(0,erAdlist[0].Agreement_w_Buyer__c.length() - 1)) + Integer.valueOf(erAdlist[0].FA_agreement_w_EPC__c.substring(0,erAdlist[0].FA_agreement_w_EPC__c.length() - 1)) + Integer.valueOf(erAdlist[0].Pre_bid_agreement_EPC__c.substring(0,erAdlist[0].Pre_bid_agreement_EPC__c.length() - 1)) + Integer.valueOf(erAdlist[0].Installation_time_wk__c.substring(0,erAdlist[0].Installation_time_wk__c.length() - 1));
             integer totalCommcatew8 = Integer.valueOf(erAdlist[0].Delivery_wk__c.substring(0,erAdlist[0].Delivery_wk__c.length() - 1)) + Integer.valueOf(erAdlist[0].T_C__c.substring(0,erAdlist[0].T_C__c.length() - 1)) + Integer.valueOf(erAdlist[0].Responsiveness__c.substring(0,erAdlist[0].Responsiveness__c.length() - 1)) + Integer.valueOf(erAdlist[0].Pre_bid_support__c.substring(0,erAdlist[0].Pre_bid_support__c.length() - 1)) + Integer.valueOf(erAdlist[0].submission_best_price__c.substring(0,erAdlist[0].submission_best_price__c.length() - 1)) + Integer.valueOf(erAdlist[0].OEM_Integrated_Solution__c.substring(0,erAdlist[0].OEM_Integrated_Solution__c.length() - 1)) + Integer.valueOf(erAdlist[0].FA_agreement_w_End_User__c.substring(0,erAdlist[0].FA_agreement_w_End_User__c.length() - 1)) + Integer.valueOf(erAdlist[0].Quick_negotiation__c.substring(0,erAdlist[0].Quick_negotiation__c.length() - 1)) + Integer.valueOf(erAdlist[0].Bidder_Tender_deviations__c.substring(0,erAdlist[0].Bidder_Tender_deviations__c.length() - 1)) + Integer.valueOf(erAdlist[0].After_Sales_services__c.substring(0,erAdlist[0].After_Sales_services__c.length() - 1)) + Integer.valueOf(erAdlist[0].Agreement_w_Buyer__c.substring(0,erAdlist[0].Agreement_w_Buyer__c.length() - 1)) + Integer.valueOf(erAdlist[0].FA_agreement_w_EPC__c.substring(0,erAdlist[0].FA_agreement_w_EPC__c.length() - 1)) + Integer.valueOf(erAdlist[0].Pre_bid_agreement_EPC__c.substring(0,erAdlist[0].Pre_bid_agreement_EPC__c.length() - 1)) + Integer.valueOf(erAdlist[0].Installation_time_wk__c.substring(0,erAdlist[0].Installation_time_wk__c.length() - 1));
            if(totalCommcatew8 != 100){
                errormsg = commboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Commercial Value Attribute Weight should be 100%.'));
            }else{
                commboo = false;
            }
            if(erAdlist[0].Commercial_Score__c == null || erAdlist[0].Commercial_Score__c == '0.0'){
                errormsg = commscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Commercial Score of GE O&G is Blank.'));
            }else{
                commscrboo = false;
            }
        }
        if(erAdlist[0].Reference_Category_Weight__c != '0%'){
            integer totalRefcatew8 = Integer.valueOf(erAdlist[0].Industrial_Service_References__c.substring(0,erAdlist[0].Industrial_Service_References__c.length() - 1)) + Integer.valueOf(erAdlist[0].Product_References__c.substring(0,erAdlist[0].Product_References__c.length() - 1)) + Integer.valueOf(erAdlist[0].Customer_Installed_Fleet__c.substring(0,erAdlist[0].Customer_Installed_Fleet__c.length() - 1)) + Integer.valueOf(erAdlist[0].Region_installed_Fleet__c.substring(0,erAdlist[0].Region_installed_Fleet__c.length() - 1)) + Integer.valueOf(erAdlist[0].OTR_performances__c.substring(0,erAdlist[0].OTR_performances__c.length() - 1)) + Integer.valueOf(erAdlist[0].Customer_Plant_Installed_Fleet__c.substring(0,erAdlist[0].Customer_Plant_Installed_Fleet__c.length() - 1)) + Integer.valueOf(erAdlist[0].Localization__c.substring(0,erAdlist[0].Localization__c.length() - 1)) + Integer.valueOf(erAdlist[0].Service_Workshops__c.substring(0,erAdlist[0].Service_Workshops__c.length() - 1)) + Integer.valueOf(erAdlist[0].Prior_Equipment_Supplier__c.substring(0,erAdlist[0].Prior_Equipment_Supplier__c.length() - 1));
            if(totalRefcatew8 != 100){
                errormsg = refboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of References Value Attribute Weight should be 100%.'));
            }else{
                refboo = false;
            }
            if(erAdlist[0].References_Score__c == null || erAdlist[0].References_Score__c == '0.0'){
                errormsg = refscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total References Score of GE O&G is Blank.'));
            }else{
                refscrboo = false;
            }
        }
        if(erAdlist[0].Relation_Category_Weight__c != '0%'){
            integer totalRelcatew8 = Integer.valueOf(erAdlist[0].Relations_With_End_User__c.substring(0,erAdlist[0].Relations_With_End_User__c.length() - 1)) + Integer.valueOf(erAdlist[0].Relations_with_EPC__c.substring(0,erAdlist[0].Relations_with_EPC__c.length() - 1)) + Integer.valueOf(erAdlist[0].Relations_with_Influencer__c.substring(0,erAdlist[0].Relations_with_Influencer__c.length() - 1)) + Integer.valueOf(erAdlist[0].Reputation__c.substring(0,erAdlist[0].Reputation__c.length() - 1)) + Integer.valueOf(erAdlist[0].Relations_with_Buyer__c.substring(0,erAdlist[0].Relations_with_Buyer__c.length() - 1)) + Integer.valueOf(erAdlist[0].Supplier_Diversification__c.substring(0,erAdlist[0].Supplier_Diversification__c.length() - 1));
            if(totalRelcatew8 != 100){
                errormsg = relboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Relations Value Attribute Weight should be 100%.'));
            }else{
                relboo = false;
            }
            if(erAdlist[0].Relations_Score__c == null || erAdlist[0].Relations_Score__c == '0.0'){
                errormsg = relscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Relations Score of GE O&G is Blank.'));
            }else{
                relscrboo = false;
            }
        }
        if(erAdlist[0].Technical_Category_weight__c != '0%'){
            integer totalTechcatew8 = Integer.valueOf(erAdlist[0].Ability_to_meet_Customer_Spec__c.substring(0,erAdlist[0].Ability_to_meet_Customer_Spec__c.length() - 1)) + Integer.valueOf(erAdlist[0].Equipment_Size_Fitting__c.substring(0,erAdlist[0].Equipment_Size_Fitting__c.length() - 1)) + Integer.valueOf(erAdlist[0].Machine_design__c.substring(0,erAdlist[0].Machine_design__c.length() - 1)) + Integer.valueOf(erAdlist[0].Sub_Vendor_Preferences__c.substring(0,erAdlist[0].Sub_Vendor_Preferences__c.length() - 1)) + Integer.valueOf(erAdlist[0].Footprint_m2__c.substring(0,erAdlist[0].Footprint_m2__c.length() - 1)) + Integer.valueOf(erAdlist[0].Integrated_Solution__c.substring(0,erAdlist[0].Integrated_Solution__c.length() - 1)) + Integer.valueOf(erAdlist[0].Weights__c.substring(0,erAdlist[0].Weights__c.length() - 1)) + Integer.valueOf(erAdlist[0].Noise_db_A__c.substring(0,erAdlist[0].Noise_db_A__c.length() - 1)) + Integer.valueOf(erAdlist[0].CC_Operational_Flexibility__c.substring(0,erAdlist[0].CC_Operational_Flexibility__c.length() - 1)) + Integer.valueOf(erAdlist[0].Test_Value_Driver__c.substring(0,erAdlist[0].Test_Value_Driver__c.length() - 1)) + Integer.valueOf(erAdlist[0].Train_line_up_number_of_casings__c.substring(0,erAdlist[0].Train_line_up_number_of_casings__c.length() - 1)) + Integer.valueOf(erAdlist[0].Mechanical_quality__c.substring(0,erAdlist[0].Mechanical_quality__c.length() - 1)) + Integer.valueOf(erAdlist[0].GT_Emissions_NOX_CO__c.substring(0,erAdlist[0].GT_Emissions_NOX_CO__c.length() - 1)) + Integer.valueOf(erAdlist[0].GT_Fuel_Flexibility__c.substring(0,erAdlist[0].GT_Fuel_Flexibility__c.length() - 1)) + Integer.valueOf(erAdlist[0].Covered_units_and_IOC_details_CSA_Only__c.substring(0,erAdlist[0].Covered_units_and_IOC_details_CSA_Only__c.length() - 1)) + Integer.valueOf(erAdlist[0].Availability_target_inc_bonus_LDs_CSA__c.substring(0,erAdlist[0].Availability_target_inc_bonus_LDs_CSA__c.length() - 1)) +Integer.valueOf(erAdlist[0].Reliability_target_inc_bonus_LDs_CSA__c.substring(0,erAdlist[0].Reliability_target_inc_bonus_LDs_CSA__c.length() - 1)) +Integer.valueOf(erAdlist[0].Other_Performances_CSA_Only__c.substring(0,erAdlist[0].Other_Performances_CSA_Only__c.length() - 1));
            if(totalTechcatew8 != 100){
                errormsg = techboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Technical Value Attribute Weight should be 100%.'));
            }else{
                techboo = false;
            }
            if(erAdlist[0].Technical_Score__c == null || erAdlist[0].Technical_Score__c == '0.0'){
                errormsg = techscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Technical Score of GE O&G is Blank.'));
            }else{
                techscrboo = false;
            }
        }
    }
    public void SubSea_Validations(){
        if(erAdlist[0].Capex_Category_Weight__c != '0%'){
            integer totalcapexcatew8 = Integer.valueOf(erAdlist[0].Total_Price__c.substring(0,erAdlist[0].Total_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Equipment_Price__c.substring(0,erAdlist[0].Equipment_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Training_Price__c.substring(0,erAdlist[0].Training_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Installation_Price__c.substring(0,erAdlist[0].Installation_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Spare_parts_Price__c.substring(0,erAdlist[0].Spare_parts_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Tests_Price__c.substring(0,erAdlist[0].Tests_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Project_Management_Price__c.substring(0,erAdlist[0].Project_Management_Price__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Engineering_Price__c.substring(0,erAdlist[0].Engineering_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].In_Country_Support_Services_Price__c.substring(0,erAdlist[0].In_Country_Support_Services_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Field_Service_Engineering__c.substring(0,erAdlist[0].Field_Service_Engineering__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Rental_Tools_Price__c.substring(0,erAdlist[0].Rental_Tools_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Storage_Price__c.substring(0,erAdlist[0].Storage_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].IWOCS_Price__c.substring(0,erAdlist[0].IWOCS_Price__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Other_Price__c.substring(0,erAdlist[0].Other_Price__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].CWOR_Price__c.substring(0,erAdlist[0].CWOR_Price__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].X3rd_Party_Price__c.substring(0,erAdlist[0].X3rd_Party_Price__c.length() - 1));
            if(totalcapexcatew8 != 100){
                errormsg = capexboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Capex Value Attribute Weight should be 100%.'));
            }else{
                capexboo = false;
            }
            if(erAdlist[0].Capex_Score__c == null || erAdlist[0].Capex_Score__c == '0.0'){
                errormsg = capexscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Capex Score of GE O&G is Blank.'));
            }else{
                capexscrboo = false;
            }
        }
        if(erAdlist[0].Opex_Category_Weight__c != '0%'){
            integer totalOpexcatew8 = Integer.valueOf(erAdlist[0].Field_Service_Engineer_Rate__c.substring(0,erAdlist[0].Field_Service_Engineer_Rate__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Rental_Tools_Rates__c.substring(0,erAdlist[0].Rental_Tools_Rates__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Storage_Rates__c.substring(0,erAdlist[0].Storage_Rates__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Training_Rates__c.substring(0,erAdlist[0].Training_Rates__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Testing_costs__c.substring(0,erAdlist[0].Testing_costs__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Intervention_downtime__c.substring(0,erAdlist[0].Intervention_downtime__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Single_trip_tools__c.substring(0,erAdlist[0].Single_trip_tools__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Retrieval_time__c.substring(0,erAdlist[0].Retrieval_time__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Repair_turnaround__c.substring(0,erAdlist[0].Repair_turnaround__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].IWOCS_Rates__c.substring(0,erAdlist[0].IWOCS_Rates__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].CWOR_Rates__c.substring(0,erAdlist[0].CWOR_Rates__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Landing_String_Rates__c.substring(0,erAdlist[0].Landing_String_Rates__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Spare_parts_cost__c.substring(0,erAdlist[0].Spare_parts_cost__c.length() - 1));
            if(totalOpexcatew8 != 100){
                errormsg = opexboo =  true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Opex Value Attribute Weight should be 100%.'));
            }else{
                opexboo = false;
            }
            if(erAdlist[0].Opex_Score__c == null || erAdlist[0].Opex_Score__c == '0.0'){
                errormsg = opexscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Opex Score of GE O&G is Blank.'));
            }else{
                opexscrboo = false;
            }
        }
        if(erAdlist[0].Commercial_Category_weight__c != '0%'){
            integer totalCommcatew8 = Integer.valueOf(erAdlist[0].Delivery_wk__c.substring(0,erAdlist[0].Delivery_wk__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Local_Content__c.substring(0,erAdlist[0].Local_Content__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].FA_agreement_w_End_User__c.substring(0,erAdlist[0].FA_agreement_w_End_User__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].FA_agreement_w_EPC__c.substring(0,erAdlist[0].FA_agreement_w_EPC__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Pre_bid_support__c.substring(0,erAdlist[0].Pre_bid_support__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].After_Sales_services__c.substring(0,erAdlist[0].After_Sales_services__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Bidder_Tender_deviations__c.substring(0,erAdlist[0].Bidder_Tender_deviations__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Quick_negotiation__c.substring(0,erAdlist[0].Quick_negotiation__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Responsiveness__c.substring(0,erAdlist[0].Responsiveness__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].T_C__c.substring(0,erAdlist[0].T_C__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Channel_Availability__c.substring(0,erAdlist[0].Channel_Availability__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Discounts__c.substring(0,erAdlist[0].Discounts__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Rental_Duration__c.substring(0,erAdlist[0].Rental_Duration__c.length() - 1));
            if(totalCommcatew8 != 100){
                errormsg = commboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Commercial Value Attribute Weight should be 100%.'));
            }else{
                commboo = false;
            }
            if(erAdlist[0].Commercial_Score__c == null || erAdlist[0].Commercial_Score__c == '0.0'){
                errormsg = commscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Commercial Score of GE O&G is Blank.'));
            }else{
                commscrboo = false;
            }
        }
        if(erAdlist[0].Reference_Category_Weight__c != '0%'){
            integer totalRefcatew8 = Integer.valueOf(erAdlist[0].Field_Proven__c.substring(0,erAdlist[0].Field_Proven__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Incumbent_Supplier__c.substring(0,erAdlist[0].Incumbent_Supplier__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Customer_Installed_Fleet__c.substring(0,erAdlist[0].Customer_Installed_Fleet__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Product_References__c.substring(0,erAdlist[0].Product_References__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Region_installed_Fleet__c.substring(0,erAdlist[0].Region_installed_Fleet__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Service_Workshops__c.substring(0,erAdlist[0].Service_Workshops__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Mobilization__c.substring(0,erAdlist[0].Mobilization__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].OTR_performances__c.substring(0,erAdlist[0].OTR_performances__c.length() - 1));
            if(totalRefcatew8 != 100){
                errormsg = refboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of References Value Attribute Weight should be 100%.'));
            }else{
                refboo = false;
            }
            if(erAdlist[0].References_Score__c == null || erAdlist[0].References_Score__c == '0.0'){
                errormsg = refscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total References Score of GE O&G is Blank.'));
            }else{
                refscrboo = false;
            }
        }
        if(erAdlist[0].Relation_Category_Weight__c != '0%'){
            integer totalRelcatew8 = Integer.valueOf(erAdlist[0].Relations_w_EU_Key_Accounts__c.substring(0,erAdlist[0].Relations_w_EU_Key_Accounts__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Relations_w_EU_Project_Teams__c.substring(0,erAdlist[0].Relations_w_EU_Project_Teams__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Relations_w_EU_Bid_Teams__c.substring(0,erAdlist[0].Relations_w_EU_Bid_Teams__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Relations_w_Key_Stakeholders__c.substring(0,erAdlist[0].Relations_w_Key_Stakeholders__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Agent_Influence__c.substring(0,erAdlist[0].Agent_Influence__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Relations_with_EPC__c.substring(0,erAdlist[0].Relations_with_EPC__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Relations_with_Influencer__c.substring(0,erAdlist[0].Relations_with_Influencer__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Relations_with_Buyer__c.substring(0,erAdlist[0].Relations_with_Buyer__c.length() - 1)) + 
                                    Integer.valueOf(erAdlist[0].Relations_w_Supply_Chain__c.substring(0,erAdlist[0].Relations_w_Supply_Chain__c.length() - 1));
            if(totalRelcatew8 != 100){
                errormsg = relboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Relations Value Attribute Weight should be 100%.'));
            }else{
                relboo = false;
            }
            if(erAdlist[0].Relations_Score__c == null || erAdlist[0].Relations_Score__c == '0.0'){
                errormsg = relscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Relations Score of GE O&G is Blank.'));
            }else{
                relscrboo = false;
            }
        }
        if(erAdlist[0].Technical_Category_weight__c != '0%'){
            integer totalTechcatew8 = Integer.valueOf(erAdlist[0].Integrated_Solution__c.substring(0,erAdlist[0].Integrated_Solution__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Ability_to_meet_Customer_Spec__c.substring(0,erAdlist[0].Ability_to_meet_Customer_Spec__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Mechanical_quality__c.substring(0,erAdlist[0].Mechanical_quality__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Weights__c.substring(0,erAdlist[0].Weights__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Customers_Preference_for_3rd_Party_Supp__c.substring(0,erAdlist[0].Customers_Preference_for_3rd_Party_Supp__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Meet_Relevant_Standards__c.substring(0,erAdlist[0].Meet_Relevant_Standards__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Field_Layout__c.substring(0,erAdlist[0].Field_Layout__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Meet_Temperature_Pressure_Req__c.substring(0,erAdlist[0].Meet_Temperature_Pressure_Req__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Meet_Sweet_Sour_Hydrocarbon_Req__c.substring(0,erAdlist[0].Meet_Sweet_Sour_Hydrocarbon_Req__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Ease_of_Intervention__c.substring(0,erAdlist[0].Ease_of_Intervention__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Fit_for_Purpose__c.substring(0,erAdlist[0].Fit_for_Purpose__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Requirements_for_NPI__c.substring(0,erAdlist[0].Requirements_for_NPI__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Requirements_for_Qualifications__c.substring(0,erAdlist[0].Requirements_for_Qualifications__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Rental_Back_Up_Provisions__c.substring(0,erAdlist[0].Rental_Back_Up_Provisions__c.length() - 1)) + 
                                        Integer.valueOf(erAdlist[0].Casing_Hanger_Lockdown_Capability__c.substring(0,erAdlist[0].Casing_Hanger_Lockdown_Capability__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Reliability_product_life__c.substring(0,erAdlist[0].Reliability_product_life__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Design_alignment__c.substring(0,erAdlist[0].Design_alignment__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].High_strength_material__c.substring(0,erAdlist[0].High_strength_material__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Forging_technology__c.substring(0,erAdlist[0].Forging_technology__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].testing__c.substring(0,erAdlist[0].Testing__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Operational_Flexibility__c.substring(0,erAdlist[0].Operational_Flexibility__c.length() - 1)) +
                                        Integer.valueOf(erAdlist[0].Overall_Dimensions__c.substring(0,erAdlist[0].Overall_Dimensions__c.length() - 1));
            if(totalTechcatew8 != 100){
                errormsg = techboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total of Technical Value Attribute Weight should be 100%.'));
            }else{
                techboo = false;
            }
            if(erAdlist[0].Technical_Score__c == null || erAdlist[0].Technical_Score__c == '0.0'){
                errormsg = techscrboo = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Total Technical Score of GE O&G is Blank.'));
            }else{
                techscrboo = false;
            }
        }
    }
    public boolean queueresult(String quename){
        buttonboo = false;
        id queId = [Select Id from Group where type='Queue' and Name=: quename].id;
        List<GroupMember> groupmem = [Select UserOrGroupId From GroupMember where GroupId =: queId];
        for(GroupMember gm : groupmem){
            if(Userinfo.getUserid() == gm.UserOrGroupId)
                buttonboo = true;
        }
        return buttonboo;
    }
    public ID usrid(string cusset){
        eRAD_TMS_Approver_IDs__c myCS1 = eRAD_TMS_Approver_IDs__c.getValues(cusset);
        String myCCVal = myCS1.SSO_ID__c;
        if(myCCVal != '' || myCCVal != null)
        return [select id from User where GE_HQ_SSO_ID__c =: myCCVal].id;
        else
        return null;
    }
    public boolean buttonboo{get;set;}
    public void pageaction(){
        if(eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea Read Only').getRecordTypeId()){
            queueresult('eRAD_SS_Approvals');
        }else if(eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId() || eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS- CSA Read Only').getRecordTypeId()){
            if(eRadRecRes[0].Opportunity_Tier_2_P_L__c == 'DTS'){
                queueresult('eRAD_DTS_Approvals');   
            }else if(eRadRecRes[0].Opportunity_Tier_2_P_L__c == 'TMS'){
                buttonboo = false;
                if(eRadRecRes[0].Opportunity_Tier_3_P_L__c == 'Opex CS' && eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId()){
                    if(Userinfo.getUserid() == usrid('TMS - Opex CS')){
                        buttonboo = true;
                    }
                }else if(eRadRecRes[0].Opportunity_Tier_3_P_L__c == 'Upgrades'){
                    if(Userinfo.getUserid() == usrid('TMS - Upgrades')){
                        buttonboo = true;
                    }
                }else if((eRadRecRes[0].Opportunity_Tier_3_P_L__c == 'New Units' && eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId()) || (eRadRecRes[0].Opportunity_Tier_3_P_L__c == 'Opex CS' && eRadRecRes[0].RecordtypeId == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS- CSA Read Only').getRecordTypeId())){
                    if(eRadRecRes[0].Segment__c == 'LNG'){
                        if(Userinfo.getUserid() == usrid('New Units / CS - LNG')){
                            buttonboo = true;
                        }
                    }else if(eRadRecRes[0].Segment__c == 'NG OFF'){
                        if(Userinfo.getUserid() == usrid('New Units / CS - NG OFF')){
                            buttonboo = true;
                        }
                    }else if(eRadRecRes[0].Segment__c == 'NG ON' || eRadRecRes[0].Segment__c == 'PIP' || eRadRecRes[0].Segment__c == 'IPG'){
                        if(Userinfo.getUserid() == usrid('New Units / CS - NG ON/PIP/IPG')){
                            buttonboo = true;
                        }
                    }
                }
            }
        }else{
            buttonboo = true;
        }
        
    }

}