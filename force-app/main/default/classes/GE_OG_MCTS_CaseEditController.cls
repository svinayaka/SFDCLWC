public with sharing class GE_OG_MCTS_CaseEditController 
    {
        public Boolean disableInput {get; set;}
        public case c {get;set;}
        public case cObject {get;set;}
        public case c1 {get;set;} // Added for MC-TS Clone R-21581




        public Boolean refreshPage { get; set; }
        public Boolean booleanexp{get;set;}
        ApexPages.StandardController controller;

        List<SelectOption> optionscomponent {get;set;}
        List<SelectOption> optionsitem {get;set;}
        List<SelectOption> optionsitem2 {get;set;}
        List<SelectOption> optionsdescription {get;set;}
        List<SelectOption> optionsdescription1 {get;set;}
        List<SelectOption> options4 {get;set;}
        public string pgMsgTxt{get; set;}
        public string businessvalue{get;set;}
        public string subbusinessvalue {get;set;}
        public string assemblyvalue {get;set;}
        public string componentvalue {get;set;}
        public string itemvalue {get;set;}
        public string descriptionvalue {get;set;}
        public string ProductCode1{get; set;} 
        public Boolean showdate {get; set;}  
        public Boolean showdate1 {get; set;}   
        public Boolean clonecase {get; set;}   // Added for MC-TS Clone R-21581
        public GE_OG_MCTS_CaseEditController(ApexPages.StandardController controller) {
        this.controller=controller;
         c=[Select  id,GE_OG_Site_LegalEntity_Account__c,Site_Contact_Information__c,GE_OG_CIR_Site_Name__c ,GE_OG_CIR_Defect_Code_Lev_1__c ,   GE_OG_CIR_Defect_Code_Lev_2__c ,GE_OG_CIR_Defect_Code_Lev_3__c 
                ,status,Subject,GE_OG_CIR_Safer_case__c,GE_OG_CIR_Customer_Phone__c ,GE_OG_CIR_Link_to_CIN_Cal__c,GE_OG_CIR_Customer_Contact_Name__c ,GE_OG_CIR_Customer_Address__c,GE_OG_CIR_Customer_Email__c,RecordTypeId,OwnerId,Description,GE_OG_Actions_Taken_To_Resolve_befor_CIR__c,GE_OG_Issue_Event_Date_CIR__c,
                GE_OG_TS_Case_Time__c ,GE_OG_Customer_Want_Date_CIR__c,GE_OG_CIR_Specific_Deliverable_Required__c,
                 casenumber,GE_OG_Customer_Impact_CIR__c,GE_OG_CIR_Impact_on_Customer_Description__c,
                 GE_OG_EHS_Product_Safety_CIR__c,GE_OG_Escalation_Level_CIR__c,GE_OG_Front_Line_case_Reference_CIR__c,GE_OG_Business_CIR__c
                 ,GE_OG_TS_Item_Description__c ,GE_OG_TS_Item_Description_1__c ,GE_OG_Sub_Business_CIR__c,GE_OG_Customer_Escalation_CIR__c,GE_OG_GE_Executive_Request_CIR__c,GE_OG_CIR_Type_of_Issue__c,
                 accountid,GE_OG_Account_Name_Only_If_Not_List_CIR__c,
                 GE_OG_MC_Con_Name__c,GE_OG_MC_Con_Phone__c,GE_OG_MC_Con_Email__c,GE_OG_CIR_State__c,GE_OG_Project_Name_CIR__c, Type,
                 GE_OG_Project_Sales_Order_ID_CIR__c,GE_OG_M_C_Job_Number_CIR__c, GE_OG_CIR_Site_Country__c,GE_OG_CIR_Unit_Serial_number__c,
                 GE_OG_CIR_M_C_Job_Type__c,GE_OG_CIR_M_C_Location_of_Mfg_Service__c,GE_OG_CIR_Region__c,GE_OG_Confirm_Escalated_CIR__c,
                 GE_OG_CIR_Case_Manager_Function__c,GE_OG_CIR_Assembly__c,GE_OG_CIR_Component__c,GE_OG_CIR_Item__c,GE_OG_Item_Description_CIR__c,
                 GE_OG_Resolution_Committed_date_CIR__c,GE_OG_Resolution_Forecasted_Date_CIR__c,GE_OG_Correction_CIR__c,
                 GE_OG_CIR_Case_Re_opened_Date__c,GE_OG_Case_Update_CIR__c,
                 GE_OG_Customer_Feedback_CIR__c,GE_OG_CIR_Case_Resolution_Date__c,GE_OG_CIR_Case_Closure_Date__c,GE_OG_Case_Cancellation_Note_CIR__c,
                 GE_OG_Send_Back_Reason_Description_CIR__c,GE_OG_CIN_CIR__c,
                 GE_OG_Gensuite_Link_CIR__c,
                 GE_OG_CIR_NC_Screening__c,GE_OG_NCA_RCA_value_CIR__c,ContactId,GE_OG_MC_TS_Initiator_Type__c ,
                 GE_OG_MC_TS_Name_of_Site_Contact__c ,GE_OG_MC_TS_Case_Level__c ,Origin ,GE_OG_MC_TS_Final_Issue__c ,GE_OG_Final_TS_Solution__c 
                 ,GE_OG_TS_NPS__c,GE_OG_MC_TS_Notify_CI_team__c ,GE_OG_MC_TS_CI_Notification_date__c,Priority,GE_OG_MC_TS_PQE_engaged__c,Task_Owner_Function__c,Product_Hierarchy__c,Component__c,Item__c,Item_Description__c,Item_Description_1__c
                     from case where id= :ApexPages.currentPage().getParameters().get('id')];
          Businessmcts=c.GE_OG_Business_CIR__c;
          subBusinessmcts=c.GE_OG_Sub_Business_CIR__c;
          assembly=c.GE_OG_CIR_Assembly__c;
          component=c.GE_OG_CIR_Component__c;
          itemdescription1= c.GE_OG_TS_Item_Description_1__c;
          item=   c.GE_OG_CIR_Item__c;
          itemdescription= c.GE_OG_TS_Item_Description__c;
          
          

          cObject = new case ();
          cObject = (case )controller.getRecord();
          refreshPage = false;

          clonecase = (ApexPages.currentPage().getParameters().get('Action') )== 'Clone' ? true : false ;  // Added for MC-TS Clone R-21581
          disableInput=true;
          pgMsgTxt ='';
          showdate =false;
          optionscomponent = new List<SelectOption>();
    }
        public PageReference autoRun() {
     
           
            return null;
     
        }
        
        public pagereference savecase()
        {
            
            System.debug('Checkpoint'+c);
          c.GE_OG_CIR_Component__c=component;
          c.GE_OG_TS_Item_Description_1__c=itemdescription1;
          c.GE_OG_CIR_Item__c=item;
          c.GE_OG_TS_Item_Description__c=itemdescription;

          // Adding for MC-TS Clone R-21581
            if(clonecase){
            try{  
               c1 = c;
               c1.id = null;
               insert c1;
               pagereference p19= new pagereference('/'+c1.id);
               return p19;
            }
            catch(exception e)
            {
                ApexPages.addMessages(e);
            }
            return null;
          } else 
          {
          //End Edit for R-21581
            try
            {
                AssignmentRule AR = new AssignmentRule();
                AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
                c.setOptions(dmlOpts);
                System.debug('Casecheck' + c);
                update c;
                pagereference p2= new pagereference('/'+c.id);
                return p2;
            }
            catch(exception e)
            {
                System.debug('EEE' +e);
                ApexPages.addMessages(e);
            }
            return null;
          }   // Added for MC-TS Clone R-21581
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
            c.GE_OG_CIR_Component__c=component;
            System.debug('Ashish--' + assembly);
            String selectedv =c.GE_OG_CIR_Item__c;
            
            booleanexp=true;
            GE_OG_Product_Hierarchy1__c state;
            optionscomponent.clear(); 
            optionsitem= new List<SelectOption>();
            optionsitem2= new List<SelectOption>();
            // Find all the states we have in custom settings.
            
           
            List<GE_OG_Product_Hierarchy1__c> allitem =[select  GE_OG_MCS_Item__c,GE_OG_MCS_Component__c,GE_OG_MCS_Sub_Business__c,GE_OG_MCS_Assembly__c,GE_OG_MCS_Business__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Component__c=:component and GE_OG_MCS_Assembly__c=:assembly and GE_OG_MCS_Sub_Business__c=:Subbusinessmcts and GE_OG_MCS_Business__c=:Businessmcts ];
            
            System.debug(allitem + 'allitemallitem');
            
            set<String> s= new Set<String>();
            for(GE_OG_Product_Hierarchy1__c pr:allitem) {
             s.add(pr.GE_OG_MCS_Item__c);
              
            }
            
            List<String> list1= new List<String>();
            list1.addAll(s);
            list1.sort();
            for(String s1:list1) {
                System.debug(component + s1 + selectedv+'ash---');
                if(!(assembly == 'Ultrasonic' && s1 == selectedv))
                optionsitem.add(new SelectOption(s1, s1));
            }
            
            System.debug('options-- ' + optionsitem);
            
            if(optionsitem.size() ==1 && allitem.size() ==1) {
                item=allitem[0].GE_OG_MCS_Item__c;
            }
            else if (optionsitem.size() ==1 && allitem.size() >1)
            {
            optionsitem.add(0, new SelectOption('', '--Select One--'));
            }
            else if (optionsitem.size() >1 && allitem.size() >1)
            {
                optionsitem.add(0, new SelectOption('', '--Select One--'));
                if((assembly == 'Ultrasonic' && (selectedv != null)))
                optionsitem.add(new SelectOption(selectedv, selectedv));    
            
            }
            else{
             
                optionsitem.add(new SelectOption('', '--None--'));
               
            }
            
            
            
             return optionsitem;
        }
        
        
        public List<SelectOption> getitemdescriptionsSelectList1() {
       
      
       c.GE_OG_CIR_Item__c=item;
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
             system.debug('.........'+optionsdescription);
            return optionsdescription;
        }
        public List<SelectOption> getitemdescription1sSelectList1() {
       
     
        
       c.GE_OG_TS_Item_Description__c=itemdescription;
      /* if(itemdescription=='NA'||itemdescription=='N/A')
       {
       c.GE_OG_TS_Item_Description_1__c='NA';
       }
       else
       {
       c.GE_OG_TS_Item_Description_1__c=itemdescription1;
       }*/
        System.debug('entered3-----------------------');
         optionscomponent.clear();
        optionsitem.clear();
        
        optionsdescription.clear();
       booleanexp=true;
       // showSAstring='';
            optionsdescription1 = new List<SelectOption>();
            optionsdescription1.clear();
           
            
            List<GE_OG_Product_Hierarchy1__c> allitemdescription =[select  GE_OG_MCS_Item_Description__c,GE_OG_MCS_Item_Description1__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Item_Description__c=:itemdescription and GE_OG_MCS_Item_Description__c!=null  and GE_OG_MCS_Item__c=:item and GE_OG_MCS_Component__c=:component and GE_OG_MCS_Assembly__c=:assembly and GE_OG_MCS_Sub_Business__c=:Subbusinessmcts and GE_OG_MCS_Business__c=:Businessmcts];
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
           
            c.GE_OG_TS_Item_Description_1__c=allitemdescription[0].GE_OG_MCS_Item_Description1__c;
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
               
               assembly='';
               optionscomponent.clear();
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