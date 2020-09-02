/*
Type Name [Class/Trigger/Page Name] : Class - GE_OG_CIR_CaseEditController
Purpose                             : Redirectd to a visulaforce page when clicked on edit button on Case 
Overview                            : To redirect to Visualforce page for Cir for Open,New and resolved status
Functional Area                     : Service
    GE_OG_CIR_CaseEdit  GE_OG_CIR_CaseEditController        
Author                              : Sandeep Rayavarapu
Created Date                        : 21 August 2014
Test Class                          : GE_OG_CIR_CaseEditControllerTest
Modified On/By                      : 28 October 2014
Purpose                             : To accomidate extra functionalities for CIR Layout on Case 

*/

public with sharing class GE_OG_CIR_CaseEditController
{
    Public String JobType;
    Public String business;
    Public String subbusiness;
    public case c{get;set;}
    public string profileid{get;set;}
    public string CLOP{get;set;}
    public string VS{get;set;}
    public string SelectedFields {get;set;}
    
    public void subbusinessToController(){
    subbusiness= SelectedFields;
    system.debug('++++++++++,'+subbusiness);
    }
    public void jobtypeToController(){
    JobType = SelectedFields;
    system.debug('++++++++++,'+JobType);
    }

    public void businessToController(){
    business= SelectedFields;
    system.debug('***********,'+business);   
    }
    
    public string pgMsgTxt{get; set;}
    public Boolean disableInput {get; set;}
    List<SelectOption> optionscomponent {get;set;}
    List<SelectOption> optionsitem {get;set;}
    public string assembly{get;set;}
    public String component {get; set;}   
    public String item {get;set;}
    public Boolean booleanexp{get;set;}
    public string businessvalue{get;set;}
    public string subbusinessvalue {get;set;}
    public string assemblyvalue {get;set;}
    public string componentvalue {get;set;}
    public string itemvalue {get;set;}
    public string Businesscir{get;set;}
    public string SubBusinesscir{get;set;}
    
    public List<SelectOption> getcomponentsSelectList() {
    optionscomponent.clear();
    system.debug('..........'+assembly);
    system.debug('..........'+SubBusinesscir );
    system.debug('..........'+businessvalue);
    system.debug('..........'+Businesscir);
    system.debug('.....CLOP.....'+CLOP);
    // Find all the components in the custom setting
    List<GE_OG_Product_Hierarchy1__c> prd=  [select GE_OG_MCS_Component__c,GE_OG_MCS_Assembly__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Assembly__c=:assembly and GE_OG_MCS_Sub_Business__c=:SubBusinesscir and GE_OG_MCS_Business__c=:Businesscir];
    system.debug('***********Line 63,'+prd);    
    set<String> s= new Set<String>();
    for(GE_OG_Product_Hierarchy1__c pr:prd){
    s.add(pr.GE_OG_MCS_Component__c);
    system.debug('***********Line 67,'+s);
    system.debug('***********Line 68,'+pr);
    
    }
        
    List<String> list1= new List<String>();
    list1.addAll(s);
    list1.sort();
    
    for(String s1:list1) {
    optionscomponent.add(new SelectOption(s1, s1));
    system.debug('***********Line 87,'+optionscomponent);
    }
            
        if(optionscomponent.size() ==1 && prd.size() ==1) {
        component=prd[0].GE_OG_MCS_Component__c;
        system.debug('***********Line 92,'+component);
        }
        else if (optionscomponent.size() ==1 && prd.size() >1)
        {
        optionscomponent.add(0, new SelectOption('', '--Select One--'));
        system.debug('***********Line 97,'+optionscomponent);
        }
        else if (optionscomponent.size() >1 && prd.size() >1)
        {
        optionscomponent.add(0, new SelectOption('', '--Select One--'));
        system.debug('***********Line 102,'+optionscomponent);
        }
        else{
         
            optionscomponent.add(new SelectOption('', '--None--'));
           system.debug('***********Line 107,'+optionscomponent);
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
    
    
    //Constructor
    public GE_OG_CIR_CaseEditController(apexpages.standardcontroller sc)
    {
        c=[select id,Key_Account_Name__c, GE_OG_CIR_Type_of_issue_level_2__c,GE_OG_CIR_Site_Name__c ,GE_OG_CIR_Defect_Code_Lev_1__c ,GE_OG_CIR_Defect_Code_Lev_2__c ,GE_OG_CIR_Defect_Code_Lev_3__c 
            ,status,Subject,GE_OG_CIR_Safer_case__c,NPT_Loss_Of_Production_Hours__c,GE_OG_CIR_Customer_Phone__c ,GE_OG_CIR_Link_to_CIN_Cal__c,GE_OG_CIR_Customer_Contact_Name__c ,GE_OG_CIR_Customer_Address__c,GE_OG_CIR_Customer_Email__c,RecordTypeId,OwnerId,Description,GE_OG_Actions_Taken_To_Resolve_befor_CIR__c,GE_OG_Issue_Event_Date_CIR__c,
             GE_OG_Customer_Want_Date_CIR__c,GE_OG_CIR_Specific_Deliverable_Required__c,
             casenumber,GE_OG_Customer_Impact_CIR__c,GE_OG_CIR_Impact_on_Customer_Description__c,
             GE_OG_EHS_Product_Safety_CIR__c,GE_OG_Escalation_Level_CIR__c,GE_OG_Front_Line_case_Reference_CIR__c,GE_OG_Link_to_CIR_Handbook_and_Videos__c,GE_OG_Business_CIR__c
             ,GE_OG_Sub_Business_CIR__c,GE_OG_Customer_Escalation_CIR__c,GE_OG_GE_Executive_Request_CIR__c,GE_OG_CIR_Type_of_Issue__c,
             accountid,GE_OG_Account_Name_Only_If_Not_List_CIR__c,
             GE_OG_MC_Con_Name__c,GE_OG_MC_Con_Phone__c,GE_OG_MC_Con_Email__c,GE_OG_CIR_State__c,GE_OG_Project_Name_CIR__c,
             GE_OG_Project_Sales_Order_ID_CIR__c,GE_OG_M_C_Job_Number_CIR__c, GE_OG_CIR_Site_Country__c,GE_OG_CIR_Unit_Serial_number__c,
             GE_OG_CIR_M_C_Job_Type__c,Customer_Loss_of_Production__c,GE_OG_CIR_M_C_Location_of_Mfg_Service__c,GE_OG_CIR_Region__c,GE_OG_Confirm_Escalated_CIR__c,
             GE_OG_CIR_Case_Manager_Function__c,GE_OG_CIR_Assembly__c,GE_OG_CIR_Component__c,GE_OG_CIR_Item__c,GE_OG_Item_Description_CIR__c,
             GE_OG_Resolution_Committed_date_CIR__c,GE_OG_Resolution_Forecasted_Date_CIR__c,GE_OG_Correction_CIR__c,
             GE_OG_CIR_Case_Re_opened_Date__c,GE_OG_Case_Update_CIR__c,
             GE_OG_Customer_Feedback_CIR__c,GE_OG_CIR_Case_Resolution_Date__c,GE_OG_CIR_Case_Closure_Date__c,GE_OG_Case_Cancellation_Note_CIR__c,
             GE_OG_Send_Back_Reason_Description_CIR__c,GE_OG_CIN_CIR__c,
             GE_OG_Gensuite_Link_CIR__c,Escalation__c,Product_Hierarchy__c,Component__c,Item__c,
             GE_OG_CIR_NC_Screening__c,GE_OG_NCA_RCA_value_CIR__c from case where id =:apexpages.currentpage().getparameters().get('id')];
         
          businesscir=c.GE_OG_Business_CIR__c;
          
          CLOP = c.Customer_Loss_of_Production__c ;
          
    System.debug('----Customer_Loss_of_Production__c---'+c.Customer_Loss_of_Production__c);
    
    
       if(businesscir=='Turbomachinery & Process Solutions')
    {
    Businesscir='Turbomachinery & Process Solutions';
    
    }else if(businesscir=='Turbomachinery & Process Solutions')
    {
        Businesscir='Turbomachinery & Process Solutions';
    }
    else if(businesscir=='Oil Field Equipment')
    {
        Businesscir='Oil Field Equipment';
    }
          subbusinesscir=c.GE_OG_Sub_Business_CIR__c;
    if(subbusinessvalue == 'Drilling Equipment' || subbusinessvalue == 'Subsea Services' || subbusinessvalue == 'Subsea Production Systems, Services & Offshore' || subbusinessvalue == 'Flexible Pipeline Systems & Wellstream Construction Services' || subbusinessvalue == 'Surface Pressure Control')
    {
  
    subbusinesscir='All';
    
    }
    /*
      if(subbusinesscir=='DP&S' )
    {
  
    subbusinesscir='DP&S';
    
    }   
    if(subbusinesscir=='D&S - Drilling'||subbusinesscir=='Well Performance Services'||subbusinesscir=='DT'||subbusinesscir=='PC')
    {
     
        subbusinesscir='All';
    }
    */
    if(subbusinesscir=='Controls'||subbusinesscir=='Trees'||subbusinesscir=='Manifold and Connection Systems'||subbusinesscir=='Offshore'
    ||subbusinesscir=='EPC'||subbusinesscir=='Wellstream'||subbusinesscir=='Services'||subbusinesscir=='Services COE'||subbusinesscir=='Services Intervention Rental'
    ||subbusinesscir=='Wellstream Subsea Construction')
    {
    
    subbusinesscir='All';
    
    }
    

        assembly=c.GE_OG_CIR_Assembly__c;
        component=c.GE_OG_CIR_Component__c;
        item=   c.GE_OG_CIR_Item__c;
        disableInput=true;
        pgMsgTxt ='';
        optionscomponent = new List<SelectOption>();
     
       
  
    
        user u=[select id,profileid from user where id=:userinfo.getuserid()];
        profileid=u.profileid;
        system.debug('............'+c.status );
        
            
    }
     
    


    public pagereference save()
    {
    
  /* 
    
    if(c.GE_OG_Business_CIR__c!='Digital Solutions')
    {
    c.GE_OG_M_C_Job_Number_CIR__c=null;
    c.GE_OG_CIR_M_C_Location_of_Mfg_Service__c=null;
    c.GE_OG_CIR_M_C_Job_Type__c=null;
    
    }*/
    
    
    
    
    
        if(c.GE_OG_CIR_Unit_Serial_number__c!=null)
        {
            GE_Installed_Base__c ib=[select id,Account__c,GE_ES_Station_Name__c from GE_Installed_Base__c where id =:c.GE_OG_CIR_Unit_Serial_number__c];
           list<account> a=[select id,ShippingCountry,Shippingstate from account where id =:ib.Account__c];
if(a.size()>0)
{
c.accountid=a[0].id;
//c.GE_OG_Key_Account_Name_CIR__c=null;
c.GE_OG_Account_Name_Only_If_Not_List_CIR__c=null;
c.GE_OG_CIR_Site_Country__c=a[0].ShippingCountry;
c.GE_OG_CIR_State__c=a[0].Shippingstate;
}
else
{
  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'The provided unit serial number does not have an account.');
ApexPages.addMessage(myMsg);

}
            if(ib.GE_ES_Station_Name__c!=null)
            {
            c.GE_OG_CIR_Site_Name__c=ib.GE_ES_Station_Name__c;
            }
        
        }
        else if(c.accountid!=null)
        {
            account a=[select id,ShippingCountry,Shippingstate from account where id =:c.accountid];
            c.GE_OG_CIR_Site_Country__c=a.ShippingCountry;
            system.debug('......'+c.account.ShippingCountry);
            system.debug('......'+c.accountid);
            c.GE_OG_CIR_Site_Country__c=a.ShippingCountry;
            //c.GE_OG_Key_Account_Name_CIR__c=null;
            c.GE_OG_Account_Name_Only_If_Not_List_CIR__c=null;
            
            c.GE_OG_CIR_State__c=a.Shippingstate;
            
        }
        try
        {
        
            if(c.status=='New')
            {
                AssignmentRule AR = new AssignmentRule();
                AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
                c.setOptions(dmlOpts);
            }
            if(c.GE_OG_Escalation_Level_CIR__c=='Priority')
            {
                c.GE_OG_Confirm_Escalated_CIR__c=false;
            }
            
         CLOP=  c.Customer_Loss_of_Production__c;
         
         
             system.debug('CLOP Value in Save ********************'+CLOP); 
            update c;
            system.debug('updatecase++++++++,'+c);
            pagereference p2= new pagereference('/'+c.id);
            return p2;
        }
        catch(exception e)
        {
            ApexPages.addMessages(e);
                        
        
        }
        return null;
    }
    
    public pagereference cancel()
    {
        pagereference p2= new pagereference('/'+c.id);
        return p2;
        
    }
    
       public  pagereference makeNullValues() 
    {
   SubBusinesscir=null;
    subbusinessvalue=null;
   
     businessvalue= Apexpages.currentPage().getParameters().get('one');
     system.debug('Business Value in makeNullValues ********************'+businessvalue);
   if(businessvalue=='Turbomachinery & Process Solutions')
    {
    Businesscir='Turbomachinery & Process Solutions';
    
    }else if(businessvalue=='Turbomachinery & Process Solutions')
    {
        Businesscir='Turbomachinery & Process Solutions';
    }
    else if(businessvalue=='Oil Field Equipment')
    {
        Businesscir='Oil Field Equipment';
    }
    else
    {
    
        System.debug('!!!'+businessvalue);
        if(businessvalue !=null || businessvalue!='')
        {
            Businesscir=businessvalue;
        }
           
           assembly='';
           optionscomponent.clear();
           component='';
           item='';
       }   
       
        return null;
    }
    
    
     public  pagereference makeNullValues1() 
    {
    
    SubBusinesscir=null;
    subbusinessvalue=null;
  
    subbusinessvalue= Apexpages.currentPage().getParameters().get('two');
    
    
    if(subbusinessvalue == 'New Units' || subbusinessvalue == 'Services - CS & TX' || subbusinessvalue == 'Services - Upgrades' || subbusinessvalue == 'Power Transmission' ||
            subbusinessvalue == 'Gas Processing' || subbusinessvalue == 'RC - New Units' || subbusinessvalue == 'RC - Services' || subbusinessvalue == 'FPT - Valve Projects' || subbusinessvalue == 'FPT - Aftermarket Solutions' || subbusinessvalue == 'FPT - Natural Gas Solutions' || subbusinessvalue == 'PVS')
    {
    Businesscir='Oil Field Equipment';
    subbusinesscir='All';
    
    }
    if(subbusinessvalue == 'Flexible Pipeline Systems & Wellstream Construction Services' || subbusinessvalue == 'Surface Pressure Control')
    {
    Businesscir='Oil Field Equipment';
    if(subbusinessvalue !=null || subbusinessvalue!=''){
            subBusinesscir=subbusinessvalue;
    }
    
    }
    /*
    if(subbusinessvalue=='New Units'||subbusinessvalue=='CMS'||subbusinessvalue=='U&IA'
    ||subbusinessvalue=='DGS'||subbusinessvalue=='IA&GT' ||subbusinessvalue=='GP'||subbusinessvalue=='Recip. Compression' )
    {
    Businesscir='DTS';
    subbusinesscir='All';
    
    }
     
     if(subbusinessvalue=='DP&S')
    {
    Businesscir='DTS';
    subbusinesscir='DP&S';
    
    }
    
    if(subbusinessvalue=='Well Performance Services'||subbusinessvalue=='DT'||subbusinessvalue=='PC')
    {
        Businesscir='Surface';
        subbusinesscir='All';
    }
    
    if(subbusinessvalue=='Controls'||subbusinessvalue=='Trees'||subbusinessvalue=='Manifold and Connection Systems'||subbusinessvalue=='Offshore'
    ||subbusinessvalue=='EPC'||subbusinessvalue=='Wellstream'||subbusinessvalue=='Services'||subbusinessvalue=='Services COE'||subbusinessvalue=='Services Intervention Rental'
    ||subbusinessvalue=='Wellstream Subsea Construction'||subbusinessvalue=='Drilling')
    {
    Businesscir='Subsea';
    subbusinesscir='All';
    
    }*/
    if (subbusinessvalue == 'Wireline Services' || subbusinessvalue == 'Artificial Lift' || subbusinessvalue == 'Drilling Services' || subbusinessvalue == 'Drilling & Completion Fluids' || subbusinessvalue == 'Drill Bits' || subbusinessvalue == 'Completions' || subbusinessvalue == 'Wellbore interventions ' || subbusinessvalue == 'Pressure Pumping' || subbusinessvalue == 'Chemicals') {
            Businesscir = 'Oil Field Services';
            subbusinesscir = 'All';
        }
    if(subbusinessvalue=='Control Solutions'||subbusinessvalue=='Inspection Technologies'||subbusinessvalue=='Measurement & Sensing'||subbusinessvalue=='Bently Nevada'
    ||subbusinessvalue=='PII')
    {
        Businesscir='Digital Solutions';
    
        if(subbusinessvalue !=null || subbusinessvalue!=''){
            subBusinesscir=subbusinessvalue;
            }
    
    }
    
    if(subbusinessvalue=='FPT- Valve Projects'||subbusinessvalue=='FPT- Aftermarket Solutions'||subbusinessvalue=='FPT- Natural Gas Solutions')
    {
        Businesscir='Turbomachinery & Process Solutions';
    
        if(subbusinessvalue !=null || subbusinessvalue!=''){
            subBusinesscir=subbusinessvalue;
            }
    
    }
     if(subbusinessvalue=='PVS')
    {
        Businesscir='Turbomachinery & Process Solutions';
        c.GE_OG_CIR_M_C_Location_of_Mfg_Service__c='Bari';
        if(subbusinessvalue !=null || subbusinessvalue!=''){
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
    
    public  pagereference makeNullValues6() 
    {
         system.debug('******************Inside method makeNullValues6*****************' );
            CLOP = Apexpages.currentPage().getParameters().get('Six');
        
        
            c.Customer_Loss_of_Production__c =CLOP;  
      
         system.debug('********************In New Case makeNullValues6 CLOP Value ******************* '+c.Customer_Loss_of_Production__c);

        return null;
    }
    public  pagereference makeNullValues7() 
    { system.debug('******************Inside method makeNullValues7*****************' );
            VS = Apexpages.currentPage().getParameters().get('Seven');
        
        
           
       
          system.debug('********************In Open Case makeNullValues6 CLOP Value ******************* '+c.Customer_Loss_of_Production__c);

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