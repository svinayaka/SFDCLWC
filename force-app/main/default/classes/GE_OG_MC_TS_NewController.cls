/*
Type Name [Class/Trigger/Page Name] : Class - GE_OG_MC_TS_NewController
Purpose                             : Redirectd to a visulaforce page when clicked on new button on Case and mc-ts recordtype is selected
Overview                            : To redirect to Visualforce page to accomidate assembly component item item descrition
Functional Area                     : Service
Author                              : Sandeep Rayavarapu
Created Date                        : 11/11/2014
Test Class                          : GE_OG_MC_TS_NewControllerTest
Modified On/By                      : 28 October 2014
Purpose                             : To accomidate extra functionalities for mc-ts Layout on Case 

*/



public with sharing class GE_OG_MC_TS_NewController
{
    public case cVar{get;set;}
    
    public Boolean disableInput {get; set;}
    List<SelectOption> optionscomponent {get;set;}
    List<SelectOption> optionsitem {get;set;}
    List<SelectOption> optionsdescription {get;set;}
    List<SelectOption> optionsdescription1 {get;set;}
    List<SelectOption> options4 {get;set;}
    public case c {get;set;}
    public Boolean showdate {get; set;}  
    public case cObject {get;set;}
    public Boolean refreshPage { get; set; }
    public Boolean booleanexp{get;set;}
    public string pgMsgTxt{get; set;}
    public string businessvalue{get;set;}
    public string subbusinessvalue {get;set;}
    public string assemblyvalue {get;set;}
    public string componentvalue {get;set;}
    public string itemvalue {get;set;}
    public string descriptionvalue {get;set;}
    public GE_OG_MC_TS_NewController(apexpages.standardcontroller sc)
    {
    businessmcts='Digital Solutions';
        this.cVar= (case)sc.getRecord();
         cvar.accountid=apexpages.currentpage().getparameters().get('cas4_lkid');
         cvar.contactid=apexpages.currentpage().getparameters().get('cas3_lkid');
         cvar.Opportunity_Name__c=apexpages.currentpage().getparameters().get('CF00NA0000009xOJR_lkid');
        cvar.recordtypeid=Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId(); 
        cvar.status= 'New';
        cvar.GE_OG_Issue_Event_Date_CIR__c=system.today();
        
        AssignmentRule AR = new AssignmentRule();
AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
Database.DMLOptions dmlOpts = new Database.DMLOptions();
dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
cvar.setOptions(dmlOpts);
        disableInput=true;
        pgMsgTxt ='';
        showdate =false;
        optionscomponent = new List<SelectOption>();
   
    }
    public PageReference autoRun() {
        system.debug('..........'+assembly);
       
        return null;
    }
    
    public pagereference savecase()
    {
    cvar.GE_OG_TS_Item_Description_1__c=itemdescription1;
        try
{
system.debug('......'+c);
   AssignmentRule AR = new AssignmentRule();
AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
Database.DMLOptions dmlOpts = new Database.DMLOptions();
dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
cvar.setOptions(dmlOpts);
insert cvar;

pagereference p2= new pagereference('/'+cvar.id);
return p2;
}
catch(exception e)
{
ApexPages.addMessages(e);
                

}
return null;
    }
    public string Businessmcts{get;set;}
    public string Subbusinessmcts{get;set;}
    public string assembly{get;set;}
    public String component {get; set;}   
    public String item {get;set;}
    public String itemdescription {get;set;}
    public String itemdescription1 {get;set;}
    
   
    public List<SelectOption> getcomponentsSelectList() {
     optionscomponent.clear();
     
     system.debug('..........'+assembly);
     system.debug('..........'+Subbusinessmcts );
     system.debug('..........'+Businessmcts);
     system.debug('..........'+component);
     GE_OG_Product_Hierarchy1__c state;
           // Find all the components in the custom setting
          List<GE_OG_Product_Hierarchy1__c> prd=  [select GE_OG_MCS_Component__c,GE_OG_MCS_Assembly__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Assembly__c=:assembly and GE_OG_MCS_Sub_Business__c=:Subbusinessmcts and GE_OG_MCS_Business__c=:Businessmcts];
          
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
     system.debug('......'+component);
        cvar.GE_OG_CIR_Component__c=component;
       
     
        
        booleanexp=true;
     GE_OG_Product_Hierarchy1__c state;
      optionscomponent.clear(); 
        optionsitem= new List<SelectOption>();
        // Find all the states we have in custom settings.
        
       
        List<GE_OG_Product_Hierarchy1__c> allitem =[select  GE_OG_MCS_Item__c,GE_OG_MCS_Component__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Component__c=:component and GE_OG_MCS_Assembly__c=:assembly and GE_OG_MCS_Sub_Business__c=:Subbusinessmcts and GE_OG_MCS_Business__c=:Businessmcts ];
        
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
    
    
    public List<SelectOption> getitemdescriptionsSelectList1() {
   
  
   cvar.GE_OG_CIR_Item__c=item;
    optionscomponent.clear();
    optionsitem.clear(); 
    system.debug('.............'+assembly);
   booleanexp=true;
    System.debug('entered2-----------------------');
        optionsdescription = new List<SelectOption>();
        optionsdescription.clear();
        
        List<GE_OG_Product_Hierarchy1__c> allitemdescription =[select GE_OG_MCS_Item__c,GE_OG_MCS_Item_Description__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Item__c=:item and GE_OG_MCS_Component__c=:component and GE_OG_MCS_Assembly__c=:assembly and GE_OG_MCS_Sub_Business__c=:Subbusinessmcts and GE_OG_MCS_Business__c=:Businessmcts ];
        
        if(allitemdescription.size()==1)
        {
        // Filter states that belong to the selected country
        Map<String, GE_OG_Product_Hierarchy1__c> items = new Map<String, GE_OG_Product_Hierarchy1__c>();
        for(GE_OG_Product_Hierarchy1__c item1 : allitemdescription) {
            if (item1.GE_OG_MCS_Item__c== this.item) {
                items.put(item1.GE_OG_MCS_Item_Description__c, item1);
               
            }
        }
        
        // Sort the states based on their names
        List<String> itemNames = new List<String>();
        itemNames.clear();
        itemNames.addAll(items.keySet());
        itemNames.sort();
       
        
        
        
        // Generate the Select Options based on the final sorted list
        for (String itemName : itemNames) {
            GE_OG_Product_Hierarchy1__c  state = items.get(itemName);
            optionsdescription.add(new SelectOption(state.GE_OG_MCS_Item_Description__c, state.GE_OG_MCS_Item_Description__c));
             
        }
        
        
        itemdescription=allitemdescription[0].GE_OG_MCS_Item_Description__c;
        System.debug('itemdescription is =========>'+itemdescription);
        
        }else     
        if(allitemdescription.size()>1)
        {
        
        // Filter states that belong to the selected country
        Map<String, GE_OG_Product_Hierarchy1__c> items = new Map<String, GE_OG_Product_Hierarchy1__c>();
        for(GE_OG_Product_Hierarchy1__c item1 : allitemdescription) {
            if (item1.GE_OG_MCS_Item__c == this.item) {
                items.put(item1.GE_OG_MCS_Item_Description__c, item1);
               
            }
        }
        
        // Sort the states based on their names
        List<String> itemNames = new List<String>();
        itemNames.clear();
        itemNames.addAll(items.keySet());
        itemNames.sort();
       
        
        
        
        // Generate the Select Options based on the final sorted list
        for (String itemName : itemNames) {
            GE_OG_Product_Hierarchy1__c state = items.get(itemName);
            optionsdescription.add(new SelectOption(state.GE_OG_MCS_Item_Description__c, state.GE_OG_MCS_Item_Description__c));
             
        }
        
        }
        
        // If no states are found, just say not required in the dropdown.
        
        if(optionsdescription.size() ==1 && allitemdescription.size() ==1)
        {
        }
        else if (optionsdescription.size() ==1 && allitemdescription.size() >1)
        {
        optionsdescription.add(0, new SelectOption('', '--Select One--'));
        }
        else if (optionsdescription.size() >1 && allitemdescription.size() >1)
        {
        optionsdescription.add(0, new SelectOption('', '--Select One--'));
        }
        else{
         
            optionsdescription.add(new SelectOption('', '--None--'));
           
        }
      /*  if (optionsdescription.size() > 1) {
      
            optionsdescription.add(0, new SelectOption('', '--Select One--'));
            
        } else if(optionsdescription.size()==1)
        {
        
        }else {
        
            optionsdescription.add(new SelectOption('', '--None--'));
           
        }*/
         system.debug('.........'+optionsdescription);
        return optionsdescription;
    }
    public List<SelectOption> getitemdescription1sSelectList1() {
   
 
    
   cvar.GE_OG_TS_Item_Description__c=itemdescription;
  /* if(itemdescription=='NA'||itemdescription=='N/A')
   {
   cvar.GE_OG_TS_Item_Description_1__c='NA';
   }
   else
   {
   cvar.GE_OG_TS_Item_Description_1__c=itemdescription1;
   }*/
    System.debug('entered3-----------------------');
     optionscomponent.clear();
    optionsitem.clear();
    
    optionsdescription.clear();
   booleanexp=true;
   // showSAstring='';
        optionsdescription1 = new List<SelectOption>();
        optionsdescription1.clear();
       
        
        List<GE_OG_Product_Hierarchy1__c> allitemdescription =[select  GE_OG_MCS_Item_Description__c,GE_OG_MCS_Item_Description1__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Item_Description__c=:itemdescription and GE_OG_MCS_Item_Description__c!=null and GE_OG_MCS_Item__c=:item and GE_OG_MCS_Component__c=:component and GE_OG_MCS_Assembly__c=:assembly and GE_OG_MCS_Sub_Business__c=:Subbusinessmcts and GE_OG_MCS_Business__c=:Businessmcts];
        if(allitemdescription.size()==1)
        {
        Map<String, GE_OG_Product_Hierarchy1__c> items = new Map<String, GE_OG_Product_Hierarchy1__c>();
        for(GE_OG_Product_Hierarchy1__c item2 : allitemdescription) {
            if (item2.GE_OG_MCS_Item_Description__c== this.itemdescription) {
                items.put(item2.GE_OG_MCS_Item_Description1__c, item2);
            }
        }
        
        // Sort the states based on their names
        List<String> itemNames = new List<String>();
        itemNames.clear();
        itemNames.addAll(items.keySet());
        itemNames.sort();
        
        // Generate the Select Options based on the final sorted list
        for (String itemName : itemNames) {
            GE_OG_Product_Hierarchy1__c state = items.get(itemName);
            optionsdescription1.add(new SelectOption(state.GE_OG_MCS_Item_Description1__c, state.GE_OG_MCS_Item_Description1__c));
        }
       
        cvar.GE_OG_TS_Item_Description_1__c=allitemdescription[0].GE_OG_MCS_Item_Description1__c;
        }
        if(allitemdescription.size()>1)
        {
        
        Map<String, GE_OG_Product_Hierarchy1__c> items = new Map<String, GE_OG_Product_Hierarchy1__c>();
        for(GE_OG_Product_Hierarchy1__c item2 : allitemdescription) {
            if (item2.GE_OG_MCS_Item_Description__c== this.itemdescription) {
                items.put(item2.GE_OG_MCS_Item_Description1__c, item2);
            }
        }
        
        // Sort the states based on their names
        List<String> itemNames = new List<String>();
        itemNames.clear();
        itemNames.addAll(items.keySet());
        itemNames.sort();
        
        // Generate the Select Options based on the final sorted list
        for (String itemName : itemNames) {
            GE_OG_Product_Hierarchy1__c state = items.get(itemName);
            optionsdescription1.add(new SelectOption(state.GE_OG_MCS_Item_Description1__c, state.GE_OG_MCS_Item_Description1__c));
        }
        
        }
        
        // If no states are found, just say not required in the dropdown.
        
        if(optionsdescription1.size() ==1 && allitemdescription.size() ==1)
        {
        }
        else if (optionsdescription1.size() ==1 && allitemdescription.size() >1)
        {
        optionsdescription1.add(0, new SelectOption('', '--Select One--'));
        }
        else if (optionsdescription1.size() >1 && allitemdescription.size() >1)
        {
        optionsdescription1.add(0, new SelectOption('', '--Select One--'));
        }
        else{
         
            optionsdescription1.add(new SelectOption('', '--None--'));
           
        }
      
        return optionsdescription1;
    }
     public  pagereference makeNullValues() 
    {
    
     businessvalue= Apexpages.currentPage().getParameters().get('one');
        System.debug('!!!'+businessvalue);
        if(businessvalue !=null || businessvalue!=''){
            Businessmcts=businessvalue;
        }
           optionscomponent.clear();
           assembly='';
           
           component='';
           item='';
           itemdescription='';
           itemdescription1='';
        return null;
    }
     public  pagereference makeNullValues1() 
    {
    subbusinessvalue= Apexpages.currentPage().getParameters().get('two');
        System.debug('!!!'+businessvalue);
        if(subbusinessvalue !=null || subbusinessvalue!=''){
            subBusinessmcts=subbusinessvalue;
            }
      
           assembly='';
           optionscomponent.clear();
           component='';
           item='';
           itemdescription='';
           itemdescription1='';

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
           itemdescription='';
           itemdescription1='';

        return null;
    }
    
    public  pagereference makeNullValues3() 
    {
    
   
           item='';
           itemdescription='';
           itemdescription1='';
        
        return null;
    }
    
     public  pagereference makeNullValues4() 
    {
        System.debug('!!!'+itemvalue );
        itemdescription='';
        itemdescription1='';

        return null;
    }
    
     public  pagereference makeNullValues5() 
    {
        System.debug('!!!'+itemvalue );
         
         //  itemdescription1='';

        return null;
    }
    
   

}