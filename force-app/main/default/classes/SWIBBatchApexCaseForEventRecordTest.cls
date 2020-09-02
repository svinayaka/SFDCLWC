@isTest(SeeAllData=false)
                                
private class SWIBBatchApexCaseForEventRecordTest{

 static  testMethod void SWIBBatchApexCaseForEventRecordTest() {
       
    List<SWIBEventRecord__c> sortList = new List<SWIBEventRecord__c>();
       
    List<Case> lstGECombinedList = new List<Case>();
    List<Case> lstGESNEquipNameCIR = new List<Case>();
    List<Case> lstGESNEquipNameNPT = new List<Case>();
    List<Case> lstGESNEquipNameCam = new List<Case>();
    

    //String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId(); 
     String CIRrecType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
     String nptRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();
     String SIRCamRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SIR - CaM').getRecordTypeId();
    

    
       List<string> lstGESNEquipName = new List<string>(); 
      
     String   rtypeSCM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Control Module'].id;
     String  rtypeSM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Manifold'].id;
     String rtypeSXT=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Xmas Tree'].id;
 
       
        Profile p1 = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser121w32@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p1.Id, Isactive= true,
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser22332@testorg.com');
        
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        Test.startTest();
   
   
        account a = new account();
        a.name='test';
        a.RecordtypeId = CommAccrecType ;
        insert a;
        /*contact con = new contact();
        con.FirstName='test';
        con.MobilePhone='2222222222';
        con.LastName='test';
        con.accountid = a.id; 
        con.email='test@ge.com';
        insert con;*/
        
        
        GE_Installed_Base__c ib = new GE_Installed_Base__c();
        ib.recordtypeid = rtypeSCM;
        ib.Name = 'testing';
        ib.GE_OGSS_ProdFamily__c = 'testing';
        ib.GE_ES_Status__c = 'testing';
        ib.GE_OG_SS_Control_Module_Location__c = 'testing';
        ib.GE_OG_SS_Pod_Number_1__c = 'testing';
        ib.GE_OG_SS_SEM_sl_Number_1__c = 'testing';
        ib.GE_OG_SS_Comms_Technology__c = 'testing';
        ib.GE_OG_SS_Back_Up_Comms_Type__c = 'testing';
        ib.GE_OG_SS_Primary_Comms_Type__c = 'testing';
        ib.GE_OG_SS_Comms_Channel__c = 'testing';
        ib.GE_OG_SS_Input_Voltage_Range__c = 'testing';
        ib.GE_OG_SS_Input_Power_Communications__c = 'testing';
        ib.GE_OG_SS_SEM_Type__c = 'testing';
        ib.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing';
        ib.GE_OG_SS_DCV_Type__c = 'testing';
        ib.GE_OG_SS_HP_Working_Pressure__c = 'testing';
        ib.GE_OG_SS_Returns__c = 'testing';
        ib.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing';
        ib.GE_OG_SS_LP_Working_Pressure__c = 'testing';
        ib.GE_OG_SS_HP_Functions__c = 'testing';
        ib.GE_OGSS_SrcSys__c = 'testing';
        ib.GE_OG_SS_LP_Functions__c = 'testing';
        ib.GE_OG_Delrd_Date__c = System.today();
        ib.GE_OG_SaleodrCrt_Date__c = System.today();
        ib.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing';
        ib.GE_OG_Sal_Odr_Num__c = 'testing';
        ib.GE_OGSS_CBSCode__c = 'testing';
        ib.GE_OGSS_PMSCode__c = 'testing';
        ib.GE_OGSS_Manufacturer__c = 'testing';
        
        ib.GE_ES_Status__c='Installed';
        
        insert ib;
        lstGESNEquipName.add(ib.Name);
        
        
        GE_OG_Product_Hierarchy1__c p = new GE_OG_Product_Hierarchy1__c();
        p.GE_OG_MCS_Assembly__c = 'Remote Visual Inspection';
        p.GE_OG_MCS_Business__c = 'Subsea (SS)';
        p.GE_OG_MCS_Component__c ='Video Borescopes';
        p.GE_OG_MCS_Item_Description1__c='Air Hose';
        p.GE_OG_MCS_Item_Description__c ='Accessory';
        p.GE_OG_MCS_Item__c = 'Flying Probe';
        p.GE_OG_MCS_Sub_Business__c='Inspection Technologies';
        p.Name ='OG_Prod_Hier__1341';
        insert p;
        
    
 
            list<Case> scope = new list<Case>();
            case c = new case();
      
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c = p.GE_OG_MCS_Business__c;        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        c.GE_OG_CIR_Unit_Serial_number__c=ib.id;  
        c.GE_OG_CIR_Assembly__c=p.GE_OG_MCS_Assembly__c;
        c.recordtypeid = CIRrecType;
        c.GE_OG_CIR_Component__c=p.GE_OG_MCS_Component__c;
        c.GE_OG_Sub_Business_CIR__c=p.GE_OG_MCS_Sub_Business__c;
        c.GE_OG_CIR_Item__c =  p.GE_OG_MCS_Item__c ;
        c.status= 'closed';
        c.Origin='Email';
        insert c;
 
        scope.add(c);
        
        case c1 = new case();
      
        c1.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c1.GE_OG_Business_CIR__c = p.GE_OG_MCS_Business__c;        
        c1.GE_ES_Sub_Type__c='MCS Sub Status';   
        c1.accountid=a.id;   
        c1.GE_OG_CIR_Unit_Serial_number__c=ib.id;  
        c1.GE_OG_CIR_Assembly__c=p.GE_OG_MCS_Assembly__c;
        c1.recordtypeid = CIRrecType;
        c1.GE_OG_CIR_Component__c=p.GE_OG_MCS_Component__c;
        c1.GE_OG_Sub_Business_CIR__c=p.GE_OG_MCS_Sub_Business__c;
        c1.GE_OG_CIR_Item__c =  p.GE_OG_MCS_Item__c ;
        c1.status= 'closed';
        c1.Origin='Email';
        
        c1.GE_OG_CIR_Type_of_Issue__c='Technical';
        c1.GE_OG_Issue_Event_Date_CIR__c=system.today();
        c1.GE_OG_CIR_Unit_Serial_number__c=ib.id;
        
        insert c1;
        
        
        
        SWIBeventRecord__c ev1 = new SWIBeventRecord__c();
       ev1.Component_Affected__c='testing1';
       ev1.Component_PN__c='testing1';
       ev1.Component_SN__c='testing1';
       ev1.event_Description__c='testing1';
       ev1.Failure_Mode__c='testing1';
       ev1.Notes__c='testing1';
       ev1.Record_Type__c=CIRrecType;
       ev1.RecordTypeID__c=CIRrecType;
       //ev1.SWIB_GE_S_N_Equip_Name__c =  ib.id;
       ev1.GE_Equipment_Name_Lkp__c =  ib.id;
      // ev1.Well_ID__c =c.GE_NPT_Well_Name_ID__c;
       ev1.Event_Type__c= 'Technical';
       ev1.Event_Start_Date__c =  system.today();
       ev1.event_End_Date__c= System.today()-1;
       
       ev1.event_Record_Number__c ='testing123';
       insert ev1;
       sortList.add(ev1);
       
    

        /*   case c = new case();  
        c.recordtypeid=cirRecID;       
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c='TMS';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.Account='test';
        c.Status='New';
        c.Origin='Test';
        c.GE_OG_Resolution_Committed_date_CIR__c=null;
        c.GE_OG_Escalation_Level_CIR__c = 'Escalated';
        c.IS_CIR_sixthday_Notification_Sent__c = false;
        c.GE_OG_CIR_Customer_Address__c ='testing';
        c.GE_OG_CIR_Customer_Phone__c ='1123';
        c.GE_OG_CIR_Type_of_Issue__c = 'testing11111111';
        c.GE_OG_M_C_Job_Number_CIR__c = '12434';
        c.GE_OG_CIR_Unit_Serial_number__c=ib.id;
          c.GE_OG_Issue_Event_Date_CIR__c = System.today();
       // c.GE_NPT_Well_Name_ID__c='testing111111111111111111';
       insert c;*/
       
  
   //lstGECombinedList.add(c);
 //  lstGESNEquipNameCIR.add(c);
  // update lstGESNEquipNameCIR;
         //scope.add(c1);
        //   scope.add(c2);
           //  scope.add(c3);
     //  lstGECombinedList.add(c);
  //  lstGESNEquipNameNPT.add(c);
    //   insert lstGESNEquipNameNPT;
   // lstGESNEquipNameNPT.add(c1);
  //  lstGESNEquipNameCam.add(c);
  //  insert lstGESNEquipNameCam;

       
         
        SWIBBatchApexCaseForEventRecord  objBatch = new SWIBBatchApexCaseForEventRecord();
        ID batchprocessid = Database.executeBatch(objBatch);
        AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors 
                    FROM AsyncApexJob WHERE ID =: batchprocessid ];
          database.batchableContext bc;
           Database.SaveResult srList1;
          objBatch.execute(bc,scope);
        //  objBatch.start(bc);
       // objBatch.finish(bc);
         objBatch.lstGECombinedList = lstGECombinedList;
            objBatch.lstGESNEquipNameCIR = lstGESNEquipNameCIR;
                objBatch.lstGESNEquipNameNPT = lstGESNEquipNameNPT;
                objBatch.lstGESNEquipNameCam = lstGESNEquipNameCam; 
               objBatch.lstGESNEquipName =lstGESNEquipName;
             //  objBatch.CreateBatchSOQL;
      
 Test.StopTest();
 

        

 }      

 static  testMethod void SWIBBatchApexCaseForEventRecordTest1() {
       
    List<SWIBEventRecord__c> sortList = new List<SWIBEventRecord__c>();
       
    List<Case> lstGECombinedList = new List<Case>();
    List<Case> lstGESNEquipNameCIR = new List<Case>();
    List<Case> lstGESNEquipNameNPT = new List<Case>();
    List<Case> lstGESNEquipNameCam = new List<Case>();
    

    //String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId(); 
     String CIRrecType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
    String nptRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();
    String SIRCamRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SIR - CaM').getRecordTypeId();
    

    
       List<string> lstGESNEquipName = new List<string>(); 
      
     String   rtypeSCM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Control Module'].id;
     String  rtypeSM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Manifold'].id;
     String rtypeSXT=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Xmas Tree'].id;
 
       
        Profile p1 = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser121w32@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p1.Id, IsActive= true,
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser22332@testorg.com');
            
        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();    
        Test.startTest();
   
   
        account a = new account();
        a.name='test';
        a.RecordtypeId = CommAccrecType ;
        a.type='Direct Customer';
        a.classification__c='Strategic';
        insert a;
        
        /*contact con = new contact();
        con.FirstName='test';
        con.MobilePhone='2222222222';
        con.LastName='test';
        con.accountid = a.id; 
        con.email='test@ge.com';
        insert con;*/
        
        
        GE_Installed_Base__c ib = new GE_Installed_Base__c();
        ib.recordtypeid = rtypeSCM;
        ib.Name = 'testing';
        ib.GE_OGSS_ProdFamily__c = 'testing';
        ib.GE_ES_Status__c = 'testing';
        ib.GE_OG_SS_Control_Module_Location__c = 'testing';
        ib.GE_OG_SS_Pod_Number_1__c = 'testing';
        ib.GE_OG_SS_SEM_sl_Number_1__c = 'testing';
        ib.GE_OG_SS_Comms_Technology__c = 'testing';
        ib.GE_OG_SS_Back_Up_Comms_Type__c = 'testing';
        ib.GE_OG_SS_Primary_Comms_Type__c = 'testing';
        ib.GE_OG_SS_Comms_Channel__c = 'testing';
        ib.GE_OG_SS_Input_Voltage_Range__c = 'testing';
        ib.GE_OG_SS_Input_Power_Communications__c = 'testing';
        ib.GE_OG_SS_SEM_Type__c = 'testing';
        ib.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing';
        ib.GE_OG_SS_DCV_Type__c = 'testing';
        ib.GE_OG_SS_HP_Working_Pressure__c = 'testing';
        ib.GE_OG_SS_Returns__c = 'testing';
        ib.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing';
        ib.GE_OG_SS_LP_Working_Pressure__c = 'testing';
        ib.GE_OG_SS_HP_Functions__c = 'testing';
        ib.GE_OGSS_SrcSys__c = 'testing';
        ib.GE_OG_SS_LP_Functions__c = 'testing';
        ib.GE_OG_Delrd_Date__c = System.today();
        ib.GE_OG_SaleodrCrt_Date__c = System.today();
        ib.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing';
        ib.GE_OG_Sal_Odr_Num__c = 'testing';
        ib.GE_OGSS_CBSCode__c = 'testing';
        ib.GE_OGSS_PMSCode__c = 'testing';
        ib.GE_OGSS_Manufacturer__c = 'testing';
        
        ib.GE_ES_Status__c='Installed';
        
        insert ib;
        lstGESNEquipName.add(ib.Name);
        
        
        GE_OG_Product_Hierarchy1__c p = new GE_OG_Product_Hierarchy1__c();
        p.GE_OG_MCS_Assembly__c = 'Remote Visual Inspection';
        p.GE_OG_MCS_Business__c = 'Subsea (SS)';
        p.GE_OG_MCS_Component__c ='Video Borescopes';
        p.GE_OG_MCS_Item_Description1__c='Air Hose';
        p.GE_OG_MCS_Item_Description__c ='Accessory';
        p.GE_OG_MCS_Item__c = 'Flying Probe';
        p.GE_OG_MCS_Sub_Business__c='Inspection Technologies';
        p.Name ='OG_Prod_Hier__1341';
        insert p;
        
    
 
            list<Case> scope = new list<Case>();
            case c = new case();
        c.recordtypeid = nptRecID;
        c.CIN_Number__c='test1235';
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';
        c.GE_OG_EHS_Product_Safety_CIR__c='accident';        
        c.GE_OG_Business_CIR__c ='Subsea(SS)';      
        c.Subject='test';
        c.Description='testing in progress';
        c.accountid=a.id;   
        c.GE_OG_CIR_Specific_Deliverable_Required__c='test';
        c.GE_NPT_Platform_Rig_Jack_up_Name__c='test';
        c.GE_NPT_FSE_Name__c=u.name;
       // c.GE_OG_CIR_Unit_Serial_number__c=ib.id;  
        c.GE_NPT_Near_Miss_Event__c='yes';
        c.GE_NPT_Hours_Type__c='Actual';
        c.GE_OG_Customer_Want_Date_CIR__c=system.today();
        c.GE_OG_Issue_Event_Date_CIR__c=system.today();
        c.GE_NPT_Subsea_Services_Regions__c='Emea';
        c.GE_OG_Sub_Business_CIR__c='Services';      
        c.GE_OG_Customer_Escalation_CIR__c='no';
        c.GE_OG_CIR_Impact_on_Customer_Description__c ='high';
        c.status= 'new';
        c.Origin='Email';
        c.GE_NPT_Project_Field_Name__c='test';
        c.GE_NPT_Downtime_hours__c=10.1;
        c.Has_this_case_has_been_approved_by_the_C__c='yes';
        c.Have_you_uploaded_Customer_correspondanc__c    ='yes';
        c.GE_OG_Resolution_Committed_date_CIR__c=system.today();
        c.GE_NPT_Well_Name_ID__c='test123';
        c.GE_NPT_Primary_Failure_Classification__c='Tool';
        c.GE_NPT_Is_it_a_Non_GE_event__c='No';
        c.Reoccurence__c='First event';
        c.GE_NPT_Complexity__c='test root cause';
        c.GE_NPT_Impact__c='low';
        c.GE_Action_Taken_To_prevent_NPT_occuring__c    ='testing';
        
        insert c;
 
        scope.add(c);
        
        //update c;
        //scope.add(c);
        
        case c2 = new case();
        c2.id=c.id;
        c2.GE_OG_EHS_Product_Safety_CIR__c='accident';  
        c2.GE_OG_CIR_Site_Country__c='AFGHANISTAN';      
        c2.GE_OG_Business_CIR__c ='Subsea(SS)';      
        c2.Subject='test';
        c2.GE_NPT_Downtime_hours__c=10.1;
        c2.Description='testing in progress';
        c2.GE_NPT_Project_Field_Name__c='test';
        c2.accountid=a.id;   
        c2.GE_OG_CIR_Specific_Deliverable_Required__c='test';
        c2.GE_NPT_Hours_Type__c='Actual';
        c2.GE_NPT_Platform_Rig_Jack_up_Name__c='test';
        c2.GE_NPT_FSE_Name__c=u.name;
        c2.CIN_Number__c='test1234';
        c2.GE_NPT_Near_Miss_Event__c='yes';
        c2.recordtypeid = nptRecID;
        c2.GE_OG_Customer_Want_Date_CIR__c=system.today();
        c2.GE_OG_Issue_Event_Date_CIR__c=system.today();
        c2.GE_NPT_Subsea_Services_Regions__c='Emea';
        c2.GE_OG_Sub_Business_CIR__c='Services';      
        c2.GE_OG_Customer_Escalation_CIR__c='no';
        c2.GE_OG_CIR_Impact_on_Customer_Description__c ='high';
        c2.GE_NPT_Primary_Failure_Classification__c='Tool';
        c2.status= 'closed';
        c2.Origin='Email';
        c2.Has_this_case_has_been_approved_by_the_C__c='yes';
        c2.Have_you_uploaded_Customer_correspondanc__c   ='yes';
        c2.GE_OG_Resolution_Committed_date_CIR__c=system.today();
        c2.GE_NPT_Is_it_a_Non_GE_event__c='No';
        c2.Reoccurence__c='First event';
        c2.GE_NPT_Complexity__c='test root cause';
        c2.GE_NPT_Impact__c='low';
        c2.GE_Action_Taken_To_prevent_NPT_occuring__c   ='testing';
        c2.CIN_Number__c='test1234';
        c2.GE_OG_CIR_Type_of_Issue__c='Material';
        c2.GE_NPT_Well_Name_ID__c='test123';
        c2.GE_OG_Issue_Event_Date_CIR__c=system.today();
        c2.GE_NPT_Unit_Serial_Number__c=ib.id;
        c2.Summary_of_Investigation__c='test Invest';
        update  c2;

        SWIBeventRecord__c ev2 = new SWIBeventRecord__c();
       ev2.Component_Affected__c='testing1';
       ev2.Component_PN__c='testing1';
       ev2.Component_SN__c='testing1';
       ev2.event_Description__c='testing1';
       ev2.Failure_Mode__c='testing1';
       ev2.Notes__c='testing1';
       ev2.Record_Type__c=nptRecID;
       ev2.RecordTypeID__c=nptRecID;
       //ev2.SWIB_GE_S_N_Equip_Name__c =  ib.id;
       ev2.GE_Equipment_Name_Lkp__c =  ib.id;
       
      // ev1.Well_ID__c =c.GE_NPT_Well_Name_ID__c;
       ev2.Event_Type__c= 'Material';
       ev2.Event_Start_Date__c =  system.today();
       ev2.Well_ID__c ='test123';
       
       ev2.event_Record_Number__c ='testing567';
       insert ev2;
       sortList.add(ev2);
       
  

        /*   case c = new case();  
        c.recordtypeid=cirRecID;       
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c='TMS';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.Account='test';
        c.Status='New';
        c.Origin='Test';
        c.GE_OG_Resolution_Committed_date_CIR__c=null;
        c.GE_OG_Escalation_Level_CIR__c = 'Escalated';
        c.IS_CIR_sixthday_Notification_Sent__c = false;
        c.GE_OG_CIR_Customer_Address__c ='testing';
        c.GE_OG_CIR_Customer_Phone__c ='1123';
        c.GE_OG_CIR_Type_of_Issue__c = 'testing11111111';
        c.GE_OG_M_C_Job_Number_CIR__c = '12434';
        c.GE_OG_CIR_Unit_Serial_number__c=ib.id;
          c.GE_OG_Issue_Event_Date_CIR__c = System.today();
       // c.GE_NPT_Well_Name_ID__c='testing111111111111111111';
       insert c;*/
       
  
   //lstGECombinedList.add(c);
 //  lstGESNEquipNameCIR.add(c);
  // update lstGESNEquipNameCIR;
         //scope.add(c1);
        //   scope.add(c2);
           //  scope.add(c3);
     //  lstGECombinedList.add(c);
  //  lstGESNEquipNameNPT.add(c);
    //   insert lstGESNEquipNameNPT;
   // lstGESNEquipNameNPT.add(c1);
  //  lstGESNEquipNameCam.add(c);
  //  insert lstGESNEquipNameCam;

       
         
        SWIBBatchApexCaseForEventRecord  objBatch = new SWIBBatchApexCaseForEventRecord();
        ID batchprocessid = Database.executeBatch(objBatch);
        AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors 
                    FROM AsyncApexJob WHERE ID =: batchprocessid ];
          database.batchableContext bc;
           Database.SaveResult srList1;
          objBatch.execute(bc,scope);
        //  objBatch.start(bc);
       // objBatch.finish(bc);
         objBatch.lstGECombinedList = lstGECombinedList;
            objBatch.lstGESNEquipNameCIR = lstGESNEquipNameCIR;
                objBatch.lstGESNEquipNameNPT = lstGESNEquipNameNPT;
                objBatch.lstGESNEquipNameCam = lstGESNEquipNameCam; 
               objBatch.lstGESNEquipName =lstGESNEquipName;
             //  objBatch.CreateBatchSOQL;
      
 Test.StopTest();
 

        

 }      



}