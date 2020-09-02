/*
Type Name [Class/Trigger/Page Name] : Class - GE_OG_MCTStoCIR_CaseTransferController
Purpose                             : Transfers case from mc-ts to cir is selected
Overview                            : Transfers case from mc-ts to cir is selected
Functional Area                     : Service
Author                              : Sandeep Rayavarapu
Created Date                        : 11/11/2014
Test Class                          : GE_OG_MCTStoCIR_CaseTransferCtrlTest
Modified On/By                      : 28 October 2014
Purpose                             : Transfers case from mc-ts to cir is selected

*/


public class GE_OG_MCTStoCIR_CaseTransferController
{
    Public String JobType;
    Public String business;
    Public String subbusiness;
    public string SelectedFields {get;set;}
   
      List<SelectOption> optionscomponent {get;set;}
    List<SelectOption> optionsitem {get;set;}
 
 
    public case c {get;set;}
    public Boolean showdate {get; set;}  
    public case cObject {get;set;}
    public Boolean refreshPage { get; set; }
    public Boolean booleanexp{get;set;}
    public string pgMsgTxt{get; set;}
    public Boolean disableInput {get; set;}
    
     public string businessvalue{get;set;}
    public string subbusinessvalue {get;set;}
    public string assemblyvalue {get;set;}
    public string componentvalue {get;set;}
    public string itemvalue {get;set;}
       public string Businesscir{get;set;}
    public string SubBusinesscir{get;set;}
    
    public GE_OG_MCTStoCIR_CaseTransferController(apexpages.standardcontroller controller)
    {
        
          c=[Select  id,GE_OG_CIR_Site_Name__c ,GE_OG_CIR_Defect_Code_Lev_1__c ,GE_OG_CIR_Defect_Code_Lev_2__c ,GE_OG_CIR_Defect_Code_Lev_3__c 
            ,status,Subject,GE_OG_CIR_Safer_case__c,GE_OG_CIR_Customer_Phone__c ,GE_OG_CIR_Link_to_CIN_Cal__c,GE_OG_CIR_Customer_Contact_Name__c ,GE_OG_CIR_Customer_Address__c,GE_OG_CIR_Customer_Email__c,RecordTypeId,OwnerId,Description,GE_OG_Actions_Taken_To_Resolve_befor_CIR__c,GE_OG_Issue_Event_Date_CIR__c,
             GE_OG_Customer_Want_Date_CIR__c,GE_OG_CIR_Specific_Deliverable_Required__c,
             casenumber,GE_OG_Customer_Impact_CIR__c,GE_OG_CIR_Impact_on_Customer_Description__c,
             GE_OG_EHS_Product_Safety_CIR__c,GE_OG_Escalation_Level_CIR__c,GE_OG_Front_Line_case_Reference_CIR__c,GE_OG_Business_CIR__c
             ,GE_OG_TS_Item_Description__c ,GE_OG_TS_Item_Description_1__c ,GE_OG_Sub_Business_CIR__c,GE_OG_Customer_Escalation_CIR__c,GE_OG_GE_Executive_Request_CIR__c,GE_OG_CIR_Type_of_Issue__c,
             accountid,GE_OG_Account_Name_Only_If_Not_List_CIR__c,
             GE_OG_MC_Con_Name__c,GE_OG_MC_Con_Phone__c,GE_OG_MC_Con_Email__c,GE_OG_CIR_State__c,GE_OG_Project_Name_CIR__c,
             GE_OG_Project_Sales_Order_ID_CIR__c,GE_OG_M_C_Job_Number_CIR__c, GE_OG_CIR_Site_Country__c,GE_OG_CIR_Unit_Serial_number__c,
             GE_OG_CIR_M_C_Job_Type__c,GE_OG_CIR_M_C_Location_of_Mfg_Service__c,GE_OG_CIR_Region__c,GE_OG_Confirm_Escalated_CIR__c,
             GE_OG_CIR_Case_Manager_Function__c,GE_OG_CIR_Assembly__c,GE_OG_CIR_Component__c,GE_OG_CIR_Item__c,GE_OG_Item_Description_CIR__c,
             GE_OG_Resolution_Committed_date_CIR__c,GE_OG_Resolution_Forecasted_Date_CIR__c,GE_OG_Correction_CIR__c,
             GE_OG_CIR_Case_Re_opened_Date__c,GE_OG_Case_Update_CIR__c,
             GE_OG_Customer_Feedback_CIR__c,GE_OG_CIR_Case_Resolution_Date__c,GE_OG_CIR_Case_Closure_Date__c,GE_OG_Case_Cancellation_Note_CIR__c,
             GE_OG_Send_Back_Reason_Description_CIR__c,GE_OG_CIN_CIR__c,
             GE_OG_Gensuite_Link_CIR__c,
             GE_OG_CIR_NC_Screening__c,GE_OG_NCA_RCA_value_CIR__c,GE_OG_MC_TS_Initiator_Type__c ,
             GE_OG_MC_TS_Name_of_Site_Contact__c ,GE_OG_MC_TS_Case_Level__c ,Origin ,GE_OG_MC_TS_Final_Issue__c ,GE_OG_Final_TS_Solution__c 
             ,GE_OG_TS_NPS__c,GE_OG_MC_TS_Notify_CI_team__c ,GE_OG_MC_TS_CI_Notification_date__c,Priority,GE_OG_MC_TS_PQE_engaged__c,Product_Hierarchy__c,Component__c,Item__c,GE_OG_Site_LegalEntity_Account__c
             from case where id= :ApexPages.currentPage().getParameters().get('id')];
        
             businesscir=c.GE_OG_Business_CIR__c;
         
          subbusinesscir=c.GE_OG_Sub_Business_CIR__c;
         
        assembly=c.GE_OG_CIR_Assembly__c;
        component=c.GE_OG_CIR_Component__c;
        item=c.GE_OG_CIR_Item__c;
        if(c.GE_OG_Site_LegalEntity_Account__c != null){
            c.accountid = c.GE_OG_Site_LegalEntity_Account__c;
        }
        else{
            c.accountid = null;
        }
        
        
         disableInput=true;
        pgMsgTxt ='';
        showdate =false;
        optionscomponent = new List<SelectOption>();
    
    }
public void jobtypeToController(){
    JobType = SelectedFields;
}

public void businessToController(){
    business= SelectedFields;
}

public void subbusinessToController(){
    subbusiness= SelectedFields;
}

  public string assembly{get;set;}
    public String component {get; set;}   
    public String item {get;set;}
    
    
  public List<SelectOption> getcomponentsSelectList() {
     optionscomponent.clear();
     system.debug('..........'+assembly);
     system.debug('..........'+SubBusinesscir );
     system.debug('..........'+Businesscir);
     system.debug('..........'+item);
           // Find all the components in the custom setting
          List<GE_OG_Product_Hierarchy1__c> prd=  [select GE_OG_MCS_Component__c,GE_OG_MCS_Assembly__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Assembly__c=:assembly and GE_OG_MCS_Sub_Business__c=:SubBusinesscir and GE_OG_MCS_Business__c=:Businesscir];
          
        set<String> s= new Set<String>();
        for(GE_OG_Product_Hierarchy1__c pr:prd) {
         s.add(pr.GE_OG_MCS_Component__c);
          
        }
        
        List<String> list1= new List<String>();
        list1.addAll(s);
        list1.sort();
        for(String s1:list1) {
            optionscomponent.add(new SelectOption(s1, s1));
        }
            
        if(optionscomponent.size() ==1 && prd.size() ==1) {
        component=prd[0].GE_OG_MCS_Component__c;
        }
        else if (optionscomponent.size() ==1 && prd.size() >1)
        {
        optionscomponent.add(0, new SelectOption('', '--Select One--'));
        }
        else if (optionscomponent.size() >1 && prd.size() >1)
        {
        optionscomponent.add(0, new SelectOption('', '--Select One--'));
        }
        else{
         
            optionscomponent.add(new SelectOption('', '--None--'));
           
        }
       
        return optionscomponent;
    }
    
     public List<SelectOption> getitemsSelectList1() 
     {
        c.GE_OG_CIR_Component__c=component;
        c.GE_OG_CIR_Item__c=item;
     
        
        booleanexp=true;
     GE_OG_Product_Hierarchy1__c state;
      optionscomponent.clear(); 
        optionsitem= new List<SelectOption>();
        // Find all the states we have in custom settings.
        
       
        List<GE_OG_Product_Hierarchy1__c> allitem =[select  GE_OG_MCS_Item__c,GE_OG_MCS_Component__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Component__c=:component and GE_OG_MCS_Assembly__c=:assembly and GE_OG_MCS_Sub_Business__c=:SubBusinesscir and GE_OG_MCS_Business__c=:Businesscir ];
        
        if(allitem.size() ==1)
        {
        System.debug('Size is one========>');
          // Filter states that belong to the selected country
        Map<String, GE_OG_Product_Hierarchy1__c> items = new Map<String, GE_OG_Product_Hierarchy1__c>();
        for(GE_OG_Product_Hierarchy1__c item9 : allitem) {
            if (item9.GE_OG_MCS_Component__c== this.component) {
                items.put(item9.GE_OG_MCS_Item__c, item9);
            }
        }
        
        // Sort the states based on their names
        List<String> itemNames = new List<String>();
        itemNames.addAll(items.keySet());
        itemNames.sort();
        
        // Generate the Select Options based on the final sorted list
        for (String itemName : itemNames) {
             state = items.get(itemName);
            
            optionsitem.add(new SelectOption(state.GE_OG_MCS_Item__c, state.GE_OG_MCS_Item__c));
        }
        item=allitem[0].GE_OG_MCS_Item__c;
        
        }else
        
    if(allitem.size()>1)
    {
   
   System.debug('Size is >1========>');

        // Filter states that belong to the selected country
        Map<String, GE_OG_Product_Hierarchy1__c> items = new Map<String, GE_OG_Product_Hierarchy1__c>();
        for(GE_OG_Product_Hierarchy1__c item9 : allitem) {
            if (item9.GE_OG_MCS_Component__c == this.component) {
                items.put(item9.GE_OG_MCS_Item__c, item9);
            }
        }
        
        // Sort the states based on their names
        List<String> itemNames = new List<String>();
        itemNames.addAll(items.keySet());
        itemNames.sort();
        
        // Generate the Select Options based on the final sorted list
        for (String itemName : itemNames) {
             state = items.get(itemName);
            
            optionsitem.add(new SelectOption(state.GE_OG_MCS_Item__c, state.GE_OG_MCS_Item__c));
        }
        }
        
        // If no states are found, just say not required in the dropdown.
        if(optionsitem.size() ==1 && allitem.size() ==1)
        {
        }
        else if (optionsitem.size() ==1 && allitem.size() >1)
        {
        optionsitem.add(0, new SelectOption('', '--Select One--'));
        }
        else if (optionsitem.size() >1 && allitem.size() >1)
        {
        optionsitem.add(0, new SelectOption('', '--Select One--'));
        }
        else{
         
            optionsitem.add(new SelectOption('', '--None--'));
           
        }
         return optionsitem;
    }
    
    
    
    public pagereference savecaseCir()
    {
        try{
        AssignmentRule AR = new AssignmentRule();
                AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
                c.setOptions(dmlOpts);
        c.recordtypeid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId(); 
        c.status = 'New';
        c.ContactId=null;
        update c;
        pagereference p2= new pagereference('/'+c.id);
        return p2;
        }
        catch(exception e)
        {
        ApexPages.addMessages(e);
        }
        return null;
    }
    
      public  pagereference makeNullValues() 
    {
   
     businessvalue= Apexpages.currentPage().getParameters().get('one');
   
    
    
        System.debug('!!!'+businessvalue);
        if(businessvalue !=null || businessvalue!='')
        {
            Businesscir=businessvalue;
        }
           
           assembly='';
           optionscomponent.clear();
           component='';
           item='';
         
       
        return null;
    }
    
    
     public  pagereference makeNullValues1() 
    {
    
    
  
    subbusinessvalue= Apexpages.currentPage().getParameters().get('two');
    
    
  
    if(subbusinessvalue=='Control Solutions'||subbusinessvalue=='Inspection Technologies'||subbusinessvalue=='Measurement & Sensing'||subbusinessvalue=='Bently Nevada'
    ||subbusinessvalue=='PII')
    {
        Businesscir='Digital Solutions';
    
        if(subbusinessvalue !=null || subbusinessvalue!='')
        {
            subBusinesscir=subbusinessvalue;
        }
    
    }
        
      
           assembly='';
           optionscomponent.clear();
           component='';
           item='';
           return null;
        
      }
      
        
    
    
    public  pagereference makeNullValues2() 
    {
            assemblyvalue = Apexpages.currentPage().getParameters().get('three');
        System.debug('!!!'+assemblyvalue );
        if(assemblyvalue  !=null || assemblyvalue !=''){
            assembly=assemblyvalue  ;
        }
           optionscomponent.clear();
           component='';
           item='';
         

        return null;
    }
    
    public  pagereference makeNullValues3() 
    {
    
   
           item='';
         
        return null;
    }
    
     public  pagereference makeNullValues4() 
    {
       

        return null;
    }
    
     
}