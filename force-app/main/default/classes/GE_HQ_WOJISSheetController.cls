public  class GE_HQ_WOJISSheetController {

    public String WOId {get; set; }
    public User loginuser {get; set; }
    Map<String,String> timezonevalueMap = new Map<String,String>();   


    
    public GE_HQ_WOJISSheetController() {
    
        List<User> userlist = [SELECT ID, TimeZoneSidKey FROM User WHERE ID = :UserInfo.getUserId()];
        loginuser = userlist.get(0);
        
        Schema.DescribeFieldResult fieldResult = User.TimeZoneSidKey.getdescribe();
        
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        integer startIndex,endIndex;
        String idValue;
        for(Schema.PicklistEntry p : ple)
        {
             startIndex= p.getlabel().indexOf('(');
             endIndex = p.getlabel().indexOf(')');
             idValue= p.getlabel().substring(startIndex+1, endIndex);
             System.debug('IDValue'+idValue);
             
             if(!(timezonevalueMap.containsKey(idValue))){
                     timezonevalueMap.put(idValue,p.getValue());
            }  
        
        }
        
    }
    
    public String getTechTimeZone(String techTimezone){
    
             integer startIndex,endIndex;
             String searchString='';    
             startIndex= techTimezone.indexOf('(');
             endIndex = techTimezone.indexOf(')');
             searchString = techTimezone.substring(startIndex+1, endIndex);          
            
                
                    return timezonevalueMap.get(searchString);
          
    }
    
    
    public SVMXC__Service_Order__c getWorkOrder()
    {
    //Added SVMXC__Case__r.GE_ES_Project_Number__c in query as Paart of R-24912
      /*  for (SVMXC__Service_Order__c wo : [SELECT Id, SVMXC__Company__r.Name,GE_SM_OG_MC_SAP_Project_Number__c, GE_SM_OG_MC_Network_Number__c, SVMXC__Case__r.GE_SM_HQ_Site_Name__c, SVMXC__Street__c, SVMXC__City__c, SVMXC__State__c, SVMXC__Country__c, SVMXC__Zip__c,
            GE_SM_HQ_Ship_to_Address__c, SVMXC__Contact__r.Name, GE_SM_HQ_Site_CREmail__c, GE_SM_HQ_Site_CRMobile__c, GE_SM_HQ_Site_CRTitle__c, 
            GE_SM_HQ_Installed_Base__r.Name, GE_SM_HQ_Driven_Eq__c, GE_SM_HQ_Control_System__c, GE_SM_HQ_Eq_Type__c,GE_SM_HQ_Excitation__c, GE_SM_HQ_Unit_Nbr__c,
            GE_SM_HQ_Task_Description__c, GE_SM_HQ_Dispatcher_Name__c, GE_SM_HQ_Dispatcher_Email__c, Name, GE_SM_HQ_Site_ERPPO_EMIS__c, SVMXC__Group_Member__r.Name, SVMXC__Group_Member__r.SVMXC__Phone__c, GE_SM_HQ_SM_Name__c,  GE_SM_HQ_SM_TelNo__c, GE_SM_HQ_SM_Email__c, GE_SM_HQ_Site_CPM_Name__c,
            GE_SM_HQ_Site_CPMTelNo__c, GE_SM_HQ_Site_AM__c, GE_SM_HQ_Region_Local_Office_Address__c, GE_SM_HQ_Region_Local_Office_Contact__c, 
            GE_SM_HQ_Region_LocalOffice_ContactTelNo__c, GE_SM_HQ_Region_Local_Office_FaxNo__c, GE_SM_HQ_Region_Local_Office_TelNo__c, GE_SM_HQ_Scheduled_Start_Date_Time__c, 
            GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Case__r.GE_ES_Project_Number__c,SVMXC__Case__r.GE_SM_HQ_Nbr_Shifts__c, SVMXC__Case__r.GE_SM_HQ_Shift_Duration__c, SVMXC__Case__r.GE_SM_HQ_Tools_Provided_by__c, SVMXC__Case__r.GE_SM_HQ_Tools_Types__c, 
            SVMXC__Case__r.GE_SM_HQ_Outage_Report_Req__c, GE_SM_HQ_Visa_Work_Permit_Req__c,  SVMXC__Case__r.GE_SM_HQ_Contact_Visa_Processing_TelNo__c, SVMXC__Case__r.GE_SM_HQ_Contact_Visa_Processing__c,
            SVMXC__Case__r.GE_SM_HQ_International_Airport__c,  SVMXC__Case__r.GE_SM_HQ_Local_Airport__c, SVMXC__Case__r.GE_SM_HQ_Local_Accommodations__c, SVMXC__Case__r.GE_SM_HQ_Local_Trans__c, SVMXC__Case__r.GE_SM_HQ_Site_Leave__c,  SVMXC__Case__r.GE_SM_HQ_Directions__c,
            SVMXC__Case__r.GE_SM_HQ_MD_Special_Instructions__c, GE_SM_HQ_Group_Instructions__c, GE_SM_HQ_TAS__c, GE_SM_HQ_TAS_Instructions__c, 
            SVMXC__Case__r.GE_SM_HQ_PPE_Req__c, SVMXC__Case__r.GE_SM_HQ_Customer_Trianing_Req__c,SVMXC__Case__r.GE_SM_HQ_Site_Entry_Req__c, SVMXC__Case__r.GE_SM_HQ_EHS_Special_Instructions__c, SVMXC__Case__r.GE_SM_HQ_Ambulance__c, 
            SVMXC__Case__r.GE_SM_HQ_Fire__c, SVMXC__Case__r.GE_SM_HQ_Police__c, SVMXC__Case__r.GE_SM_HQ_Traffic__c, SVMXC__Case__r.GE_SM_HQ_Local_Hospital__c, SVMXC__Case__r.GE_SM_HQ_ED_Special_Instructions__c, SVMXC__Case__r.GE_SM_HQ_Contract_Type__c,
            SVMXC__Case__r.GE_SM_HQ_Site_Loc_Code__c, SVMXC__Case__r.GE_OG_DS_DM__c, SVMXC__Case__r.GE_OG_MC_Con_Name__c, SVMXC__Case__r.GE_OG_MC_Con_Phone__c, SVMXC__Case__r.GE_OG_MC_Con_Email__c, SVMXC__Billing_Type__c, SVMXC__Case__r.SVMXC__Billing_Type__c, 
            GE_SM_HQ_ERP_Task_Number__c, SVMXC__Case__r.GE_SM_HQ_Loc_Premium__c, SVMXC__Skill__r.Name, SVMXC__Company__c,SVMXC__Component__c,SVMXC__Component__r.Name, GE_OG_DS_Rig_Location__c, GE_OG_DS_Rig_Location__r.Name, GE_OG_DS_BOP_Drawing_Numbers__c, 
            GE_OG_DS_Controls_Drawing_Numbers__c, GE_OG_DS_CDE_Drawing_Numbers__c, GE_OG_DS_Other__c,GE_OG_DS_Supporting_Documentation_Dwgs__c,GE_OG_DS_Associated_Equipment__c,  SVMXC__Case__r.GE_ES_PO__c, SVMXC__Case__c, SVMXC__Case__r.CaseNumber, 
            GE_SM_HQ_OnSite_Start__c, GE_SM_HQ_OnSite_End__c, GE_OG_DS_Heliport_Street__c, GE_OG_DS_Heliport_City__c, GE_OG_DS_Heliport_State__c, GE_OG_DS_Heliport_Zip__c, GE_OG_DS_Heliport_Country__c, SVMXC__Special_Instructions__c, 
            GE_OG_DS_On_Site_Duration__c, SVMXC__Group_Member__c, SVMXC__Contact__c, SVMXC__Contact__r.Phone, SVMXC__Contact__r.Email, GE_OG_DS_EHS_Special_Instructions__c, GE_OG_DS_Rig_Site_Entry_Requirements__c, 
            SVMXC__Case__r.GE_PW_PO__c,SVMXC__Service_Group__r.Name, GE_OG_DS_Non_Billable_Reason__c, GE_OG_DS_Pricing_Agreement__c,GE_OG_MC_Subject__c,GE_OG_MC_ERP_Project_Number__c,GE_OG_MC_Additional_Site_Details__c,
            GE_OG_MC_Serial_Nmber__c,GE_OG_MC_Additional_Project_Details__c,GE_OG_MC_ConName__c,GE_OG_MC_Con_Phone__c,GE_OG_MC_Con_Email__c,GE_OG_MC_Additional_PPE__c,GE_OG_MC_Customer_training__c,GE_OG_MC_Site_Entry_Req__c,GE_OG_SM_Directions__c,
            GE_OG_MC_Business_Unit__c,Type__c,GE_OG_MC_Service_Region__c,GE_OG_MC_Equipment_type__c,GE_SM_HQ_Installed_Base__c,GE_OG_Shipping_Address__c,SVMXC__Group_Member__r.GE_SM_HQ_Regional_Manager__c,SVMXC__Problem_Description__c, 
            SVMXC__Site__r.Name,SVMXC__Site__r.SVMXC__Account__r.Name, SVMXC__Site__r.GE_DS_Primary_Contact_Name__c, SVMXC__Site__r.GE_DS_Primary_Contact_Phone__c ,SVMXC__Site__r.GE_DS_Primary_Contact_Email__c, 
            GE_OG_DS_Bill_To_Address__c ,GE_DS_Daily_Rate__c  FROM SVMXC__Service_Order__c WHERE Id = :WOId])
        Commented above query as part of R-26296
        */
       //Added below as part of R-26296
       //Removed GE_OG_DS_Rig_Site_Entry_Requirements__c field part of R-26369
       //Removed GE_SM_HQ_OnSite_Start__c field as part of R-26370
        for (SVMXC__Service_Order__c wo : [SELECT Id, SVMXC__Company__r.Name,GE_SM_OG_MC_SAP_Project_Number__c, GE_SM_OG_MC_Network_Number__c, SVMXC__Case__r.GE_SM_HQ_Site_Name__c, SVMXC__Street__c, SVMXC__City__c, SVMXC__State__c, SVMXC__Country__c, SVMXC__Zip__c,
            GE_SM_HQ_Ship_to_Address__c, SVMXC__Contact__r.Name, GE_SM_HQ_Site_CREmail__c,GE_SM_HQ_Task_Description__c, GE_SM_HQ_Dispatcher_Name__c, GE_SM_HQ_Dispatcher_Email__c, Name,
            SVMXC__Group_Member__r.Name, SVMXC__Group_Member__r.SVMXC__Phone__c, GE_SM_HQ_SM_Name__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Case__r.GE_ES_Project_Number__c,
            SVMXC__Case__r.GE_SM_HQ_Nbr_Shifts__c, SVMXC__Case__r.GE_SM_HQ_Tools_Provided_by__c, SVMXC__Case__r.GE_SM_HQ_Tools_Types__c, SVMXC__Case__r.GE_SM_HQ_Outage_Report_Req__c, SVMXC__Case__r.GE_SM_HQ_Contact_Visa_Processing_TelNo__c,
            SVMXC__Case__r.GE_SM_HQ_Contact_Visa_Processing__c,SVMXC__Case__r.GE_SM_HQ_International_Airport__c,SVMXC__Case__r.GE_SM_HQ_Local_Airport__c, SVMXC__Case__r.GE_SM_HQ_Local_Accommodations__c, SVMXC__Case__r.GE_SM_HQ_Local_Trans__c,
            SVMXC__Case__r.GE_SM_HQ_Site_Leave__c,  SVMXC__Case__r.GE_SM_HQ_Directions__c,SVMXC__Case__r.GE_SM_HQ_MD_Special_Instructions__c,SVMXC__Case__r.GE_SM_HQ_PPE_Req__c, SVMXC__Case__r.GE_SM_HQ_Customer_Trianing_Req__c,
            SVMXC__Case__r.GE_SM_HQ_Site_Entry_Req__c, SVMXC__Case__r.GE_SM_HQ_EHS_Special_Instructions__c, SVMXC__Case__r.GE_SM_HQ_Ambulance__c,SVMXC__Case__r.GE_SM_HQ_Fire__c,SVMXC__Case__r.GE_SM_HQ_Police__c, 
            SVMXC__Case__r.GE_SM_HQ_Traffic__c, SVMXC__Case__r.GE_SM_HQ_Local_Hospital__c, SVMXC__Case__r.GE_SM_HQ_ED_Special_Instructions__c, SVMXC__Case__r.GE_SM_HQ_Contract_Type__c, SVMXC__Case__r.GE_OG_DS_DM__c,
            SVMXC__Case__r.GE_OG_MC_Con_Name__c, SVMXC__Case__r.GE_OG_MC_Con_Phone__c, SVMXC__Case__r.GE_OG_MC_Con_Email__c, SVMXC__Billing_Type__c, SVMXC__Case__r.SVMXC__Billing_Type__c, SVMXC__Case__r.GE_SM_HQ_Loc_Premium__c, 
            SVMXC__Skill__r.Name, SVMXC__Company__c,SVMXC__Component__c,SVMXC__Component__r.Name, GE_OG_DS_Rig_Location__c, GE_OG_DS_Rig_Location__r.Name,GE_OG_DS_Associated_Equipment__c,SVMXC__Case__r.GE_ES_PO__c,
            SVMXC__Case__c, SVMXC__Case__r.CaseNumber,  GE_OG_DS_Heliport_Street__c, GE_OG_DS_Heliport_City__c, GE_OG_DS_Heliport_State__c, GE_OG_DS_Heliport_Zip__c, GE_OG_DS_Heliport_Country__c, 
            SVMXC__Special_Instructions__c, SVMXC__Group_Member__c, SVMXC__Contact__c, SVMXC__Contact__r.Phone, SVMXC__Contact__r.Email, GE_OG_DS_EHS_Special_Instructions__c, 
            SVMXC__Case__r.GE_PW_PO__c,SVMXC__Service_Group__r.Name, GE_OG_DS_Non_Billable_Reason__c, GE_OG_DS_Pricing_Agreement__c,GE_OG_MC_Subject__c,GE_OG_MC_ERP_Project_Number__c,GE_OG_MC_Additional_Site_Details__c,
            GE_OG_MC_Serial_Nmber__c,GE_OG_MC_Additional_Project_Details__c,GE_OG_MC_ConName__c,GE_OG_MC_Con_Phone__c,GE_OG_MC_Con_Email__c,GE_OG_MC_Additional_PPE__c,GE_OG_MC_Customer_training__c,GE_OG_MC_Site_Entry_Req__c,
            GE_OG_SM_Directions__c,GE_OG_MC_Business_Unit__c,Type__c,GE_OG_MC_Service_Region__c,GE_OG_Shipping_Address__c,SVMXC__Group_Member__r.GE_SM_HQ_Regional_Manager__c,SVMXC__Problem_Description__c,
            SVMXC__Site__r.Name,SVMXC__Site__r.SVMXC__Account__r.Name, SVMXC__Site__r.GE_DS_Primary_Contact_Name__c, SVMXC__Site__r.GE_DS_Primary_Contact_Phone__c ,SVMXC__Site__r.GE_DS_Primary_Contact_Email__c, GE_OG_DS_Bill_To_Address__c,
            GE_DS_Daily_Rate__c  FROM SVMXC__Service_Order__c WHERE Id = :WOId ]){
       
       
            return wo;
        
        }
        return new SVMXC__Service_Order__c();
     }
     
    // Added by Raj on 12th NOV 2015
    public String SMaxEventId {get; set; }
    public DateTime date_time { get; set; } //property that reads the datetime value from component attribute tag
    public String defined_format { get; set;} //property that reads the string value from component attribute tag
    public String timezone { get; set;} //property that reads the timezone value from component attribute tag
    

    public SVMXC__SVMX_Event__c getSMaxEvent()
    {

        for (SVMXC__SVMX_Event__c smevent:[SELECT Id,SVMXC__ActivityDateTime__c,SVMXC__StartDateTime__c,SVMXC__EndDateTime__c,SVMXC_Start_Date_Time_UI__c,SVMXC_End_Date_Time_UI__c, SVMXC__WhatId__c,SVMXC__Technician__c, SVMXC__Technician__r.Name,SVMXC__Technician__r.GE_OG_MC_TimeZone__c from SVMXC__SVMX_Event__c where id =: SMaxEventId])
        {
            return smevent;
        }

        return new SVMXC__SVMX_Event__c();
    }
    
    public String getFormattedDatetime()
    {
    
    
        try{
        if (date_time == null) { return ''; }
        else { 
        
                if (defined_format == null ) {
                    return date_time.format(); //return the full date/time in user's locale and time zone
                }
                else{ 
                    if(timezone == null){
                       return date_time.format(defined_format,loginuser.TimeZoneSidKey);
                    }
                    else{
                            if(String.isNotEmpty(getTechTimeZone(timezone))){
                                    return date_time.format(defined_format,getTechTimeZone(timezone));              
                            }else {
                            
                                return date_time.format(defined_format,loginuser.TimeZoneSidKey);
                            }
                    
                        //Specify Time zone like IST,CST
                    }
                }
            }
        }Catch(Exception e){
        
        System.debug('Exception here is '+e.getMessage());
        
        }
        
        return date_time.format(defined_format,loginuser.TimeZoneSidKey);
     
     }
     
     
     
    // end by Raj on 12th NOV 2015
        
        
            
    public Static TestMethod void testGE_HQ_WOJISSheetController()
    {
        Case ca = new Case(Status='New',CurrencyIsoCode='USD',GE_OG_MC_Con_Name__c='Test Contact',GE_OG_MC_Con_Phone__c='995949596',GE_OG_MC_Con_Email__c='Test@test.com',GE_ES_Sub_Type__c = 'RFQ processing',
      GE_ES_Customer_Request_Date__c = Date.Today().adddays(20));
            insert ca;
        
            SVMXC__Skill__c skill=new SVMXC__Skill__c();
            insert skill;
        
            SVMXC__Service_Order__c workorder = new SVMXC__Service_Order__c(SVMXC__Skill__c=skill.id,SVMXC__Case__c=ca.Id, SVMXC__Order_Status__c='open');
            insert workorder;
            
            GE_HQ_WOJISSheetController testWO = new GE_HQ_WOJISSheetController();
            testWO.WOId = workorder.Id;
            testWO.getWorkOrder();
            
            GE_HQ_WOJISSheetController testWORK = new GE_HQ_WOJISSheetController();
            testWORK.getWorkOrder();
            
            
            SVMXC__Service_Group__c team = new SVMXC__Service_Group__c(
               Name = 'test',
               GE_HQ_Resource_Director__c = UserInfo.getUserId()
            );
                 insert team; 
            
            
            SVMXC__Service_Group_Members__c tech= new SVMXC__Service_Group_Members__c(
               name='abc',
               SVMXC__Street__c = 'test Home street',
               SVMXC__City__c = 'test home city',
               SVMXC__State__c = 'test home state',
               SVMXC__Country__c = 'United States',
               SVMXC__Zip__c = 'test home zip',
               SVMXC__Service_Group__c = team.Id,
               GE_SM_HQ_SSO_ID__c = '123',
               GE_SM_HQ_Regional_Manager__c = 'test Manager',
               SVMXC__Email__c = 'chris.hurd@servicemax.com'
              
               );
            
            insert tech;
            
             SVMXC__SVMX_Event__c event = new SVMXC__SVMX_Event__c ( 
                  Name='test',
                  SVMXC__StartDateTime__c = Date.newInstance(2015, 1, 8),
                  SVMXC__EndDateTime__c= Date.newInstance(2015, 1, 10),
                  SVMXC_Start_Date_Time_UI__c=Date.newInstance(2015, 1, 8),
                  SVMXC_End_Date_Time_UI__c=Date.newInstance(2015, 1, 10),
                  SVMXC__Service_Team__c=team.id,
                  SVMXC__Technician__c=tech.id,
                  SVMXC__WhatId__c = workorder.id);
                  
                  insert event;
            
            GE_HQ_WOJISSheetController eve = new GE_HQ_WOJISSheetController();
            eve.getSMaxEvent();
            
            String date_time ='10/31/2015 G 11:11:00 IST';
            String defined_format=null;
            String timezone='(GMT+14:00)';
            
            GE_HQ_WOJISSheetController timeCheck = new GE_HQ_WOJISSheetController();
           timeCheck.getTechTimeZone(timezone);
            timeCheck.getWorkOrder();
            timeCheck.getSMaxEvent();
            timeCheck.getFormattedDatetime();
            //defined_format='10/31/2015 G 11:11:00 z';
            //timeCheck.getFormattedDatetime();
            //timezone=null;
            //eve.getFormattedDatetime();      
            
    }
}