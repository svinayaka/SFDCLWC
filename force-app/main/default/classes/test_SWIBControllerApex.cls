@isTest

public class test_SWIBControllerApex{

 static  testMethod void test_SWIBcontroller1() {
 
 List<SWIBEventRecord__c> sortList = new List<SWIBEventRecord__c>();
 
        String   rtypeSCM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Control Module'].id;
     String  rtypeSM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Manifold'].id;
     String rtypeSXT=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Xmas Tree'].id;
  
      List<string> lstGESNEquipName = new List<string>(); 
        Profile p1 = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduser121w32@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p1.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser22332@testorg.com');
            
            String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
            
        Test.startTest();
   
   
        account a = new account();
        a.name='test';
        a.RecordtypeId = CommAccrecType ;
        a.type='Direct Customer';
        a.classification__c='Strategic';
        insert a;
        contact con = new contact();
        con.FirstName='test';
        con.MobilePhone='2222222222';
        con.LastName='test';
        con.accountid = a.id; 
        con.email = 'def@ge.com';
        con.GE_OG_Contact_Audience__c = 'Technical Support';
        insert con;
        
        
        GE_Installed_Base__c ib = new GE_Installed_Base__c();
        ib.recordtypeid = rtypeSCM;
        ib.Name = 'testing';
        ib.GE_OGSS_ProdFamily__c = 'testing';
       // ib.GE_ES_Status__c = 'testing';
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
        ib.GE_OGSS_WelIdntfr__c='test4521';
        ib.GE_OGSS_InstnDte__c=System.today();
        
        insert ib;
        lstGESNEquipName.add(ib.Name);
 
 
         
        SWIBeventRecord__c ev1 = new SWIBeventRecord__c();
       ev1.Component_Affected__c='testing1';
       ev1.Component_PN__c='testing1';
       ev1.Component_SN__c='testing1';
       ev1.event_Description__c='testing1';
       ev1.Failure_Mode__c='testing1';
       ev1.Notes__c='testing1';
     //  ev1.Record_Type__c=CIRrecType;
    //   ev1.RecordTypeID__c=CIRrecType;
       //ev1.SWIB_GE_S_N_Equip_Name__c =  ib.id;
       ev1.GE_Equipment_Name_Lkp__c =  ib.id;
       
       ev1.Well_ID__c ='test4521';
       ev1.Event_Type__c= 'Installation';
       ev1.Event_Start_Date__c =  system.today();
       ev1.event_End_Date__c= System.today();
       
       ev1.event_Record_Number__c ='testing123';
       insert ev1;
       sortList.add(ev1);
       
       SWIBeventRecord__c ev2 = new SWIBeventRecord__c();
       ev2.id=ev1.id;
       ev2.Component_Affected__c='testing1';
       ev2.Component_PN__c='testing1';
       ev2.Component_SN__c='testing1';
       ev2.event_Description__c='testing1';
       ev2.Failure_Mode__c='testing1';
       ev2.Notes__c='testing1';
     //  ev1.Record_Type__c=CIRrecType;
    //   ev1.RecordTypeID__c=CIRrecType;
       //ev2.SWIB_GE_S_N_Equip_Name__c =  ib.id;
       ev2.GE_Equipment_Name_Lkp__c =  ib.id;
       
       ev2.Well_ID__c ='test4521';
       ev2.Event_Type__c= 'Installation';
       ev2.Event_Start_Date__c =  system.today();
       ev2.event_End_Date__c= System.today();
       
       ev2.event_Record_Number__c ='testing123';
       update ev2;
       sortList.add(ev2);
       
        ApexPages.StandardController controller = new ApexPages.StandardController(ib); 
     //  ApexPages.currentPage().getUrl();
      ApexPages.currentPage().getParameters().put('Id',ib.Id);
    //  ApexPages.currentPage().getParameters().put('Id', attachment.ParentId);
      
     SWIBcontroller1 objBatch= new SWIBcontroller1(controller);
       
     //  SWIBcontroller1 objBatch = new SWIBcontroller1(new apexpages.standardcontroller(ib));
       objBatch.IBupdate();
       objBatch.callTwoMethods();
       objBatch.save();
       objBatch.modeSet();
     
                         objBatch.lastStatusDate = ev2.Event_End_Date__c;
                         objBatch.WellID = 'test4521';
                         objBatch.SWIBStatus= 'Installed';
                        // objBatch.sortList = sortList;
                       // objbatch.Quicksort(0, sortNum-1);
                       // objbatch.subjectInput = 'testing';
                        objbatch.mode = 'testing';
                        //objbatch.lstIB = lstGESNEquipName;
                        objbatch.displayMessage = true;
                       // objbatch.isSWIBPermissionExist = true;
                      //  objbatch.SWIBStatus = 'test';
 
 Test.StopTest();
 
 }
 
 static  testMethod void test_SWIBcontroller2() {
        Integer listEmpty;
        Integer sortNum;
      
        test.starttest();
      Profile p = [select id, name from Profile where name = 'OG_Sales/Comm Ops'];
    User u = new User(Alias = 'standt11', Email='SWIB2@testorg.com', 
      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
      LocaleSidKey='en_US', ProfileId = p.Id, 
      TimeZoneSidKey='America/Los_Angeles', UserName='SWIB2@testorg.com'); 
    
    insert u ;
    
    
    
 
        // Query your permission set name from Organization that your want to test.
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'C_SWIB_Edit'];
       
        // Assign the above inserted user for the above Permission Set.
        PermissionSetAssignment psa = new PermissionSetAssignment();
        psa.AssigneeId = u.Id;
        psa.PermissionSetId = ps.Id;
        insert psa;
        
        System.runAs(u){
      
          List<SWIBEventRecord__c> sortList = new List<SWIBEventRecord__c>(); 
   String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
   String nptRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();      

        
   
     
   
       List<GE_Installed_Base__c> lstGESNEquipName = new List<GE_Installed_Base__c>(); 
      
     String   rtypeSCM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Control Module'].id;
String  rtypeSM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Manifold'].id;
 String rtypeSXT=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Xmas Tree'].id;
 
 
   List<GE_Installed_Base__c> lstGESNEquipName11 = new List<GE_Installed_Base__c>(); 
 GE_Installed_Base__c ib = new GE_Installed_Base__c();
 ib.recordtypeid = rtypeSCM;
 ib.Name = 'demo';
 ib.GE_OGSS_ProdFamily__c = 'testing';
//ib.GE_ES_Status__c = 'testing';
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
ib.GE_ES_Status__c = 'Installed';
ib.GE_OGSS_WelIdntfr__c='testing';
ib.GE_OGSS_InstnDte__c=System.today();
insert ib;
 lstGESNEquipName11.add(ib); 
 
  GE_Installed_Base__c ib1 = new GE_Installed_Base__c();
 ib1.recordtypeid = rtypeSCM;
 ib1.Name = 'testing1';
 ib1.GE_OGSS_ProdFamily__c = 'testing3';
//ib1.GE_ES_Status__c = 'Installation';
ib1.GE_OG_SS_Control_Module_Location__c = 'testing3';
ib1.GE_OG_SS_Pod_Number_1__c = 'testing3';
ib1.GE_OG_SS_SEM_sl_Number_1__c = 'testing3';
ib1.GE_OG_SS_Comms_Technology__c = 'testing3';
ib1.GE_OG_SS_Back_Up_Comms_Type__c = 'testing3';
ib1.GE_OG_SS_Primary_Comms_Type__c = 'testing3';
ib1.GE_OG_SS_Comms_Channel__c = 'testing3';
ib1.GE_OG_SS_Input_Voltage_Range__c = 'testing3';
ib1.GE_OG_SS_Input_Power_Communications__c = 'testing3';
ib1.GE_OG_SS_SEM_Type__c = 'testing3';
ib1.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing3';
ib1.GE_OG_SS_DCV_Type__c = 'testing3';
ib1.GE_OG_SS_HP_Working_Pressure__c = 'testing3';
ib1.GE_OG_SS_Returns__c = 'testing3';
ib1.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing3';
ib1.GE_OG_SS_LP_Working_Pressure__c = 'testing3';
ib1.GE_OG_SS_HP_Functions__c = 'testing3';
ib1.GE_OGSS_SrcSys__c = 'testing3';
ib1.GE_OG_SS_LP_Functions__c = 'testing3';
ib1.GE_OG_Delrd_Date__c = System.today();
ib1.GE_OG_SaleodrCrt_Date__c = System.today();
ib1.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing3';
ib1.GE_OG_Sal_Odr_Num__c = 'testing3';
ib1.GE_OGSS_CBSCode__c = 'testing3';
ib1.GE_OGSS_PMSCode__c = 'testing3';
ib1.GE_OGSS_Manufacturer__c = 'testing3';
ib1.GE_OGSS_WelIdntfr__c='testing';
insert ib1;
ib1.GE_ES_Status__c = 'Installed';
ib1.GE_OGSS_WelIdntfr__c='testing';
        ib1.GE_OGSS_InstnDte__c=System.today();
update ib1;

 lstGESNEquipName11.add(ib1); 
 
   GE_Installed_Base__c ib2 = new GE_Installed_Base__c();
 ib2.recordtypeid = rtypeSCM;
 ib2.Name = 'testing2';
 ib2.GE_OGSS_ProdFamily__c = 'testing4';
//ib2.GE_ES_Status__c = 'Installed';
ib2.GE_OG_SS_Control_Module_Location__c = 'testing4';
ib2.GE_OG_SS_Pod_Number_1__c = 'testing4';
ib2.GE_OG_SS_SEM_sl_Number_1__c = 'testing4';
ib2.GE_OG_SS_Comms_Technology__c = 'testing4';
ib2.GE_OG_SS_Back_Up_Comms_Type__c = 'testing4';
ib2.GE_OG_SS_Primary_Comms_Type__c = 'testing4';
ib2.GE_OG_SS_Comms_Channel__c = 'testing4';
ib2.GE_OG_SS_Input_Voltage_Range__c = 'testing4';
ib2.GE_OG_SS_Input_Power_Communications__c = 'testing4';
ib2.GE_OG_SS_SEM_Type__c = 'testing4';
ib2.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing4';
ib2.GE_OG_SS_DCV_Type__c = 'testing4';
ib2.GE_OG_SS_HP_Working_Pressure__c = 'testing4';
ib2.GE_OG_SS_Returns__c = 'testing4';
ib2.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing4';
ib2.GE_OG_SS_LP_Working_Pressure__c = 'testing4';
ib2.GE_OG_SS_HP_Functions__c = 'testing4';
ib2.GE_OGSS_SrcSys__c = 'testing4';
ib2.GE_OG_SS_LP_Functions__c = 'testing4';
ib2.GE_OG_Delrd_Date__c = System.today();
ib2.GE_OG_SaleodrCrt_Date__c = System.today();
ib2.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing4';
ib2.GE_OG_Sal_Odr_Num__c = 'testing4';
ib2.GE_OGSS_CBSCode__c = 'testing4';
ib2.GE_OGSS_PMSCode__c = 'testing4';
ib2.GE_OGSS_Manufacturer__c = 'testing4';
ib2.GE_ES_Status__c = 'Installed';
ib2.GE_OGSS_WelIdntfr__c='testing';
        ib2.GE_OGSS_InstnDte__c=System.today();
insert ib2;
 lstGESNEquipName11.add(ib2); 
 
  lstGESNEquipName = lstGESNEquipName11;
 
   
   List<SWIBEventRecord__c> lstSWIBEventRecord = new List<SWIBEventRecord__c>();
      SWIBEventRecord__c ev = new SWIBEventRecord__c();
    
       ev.Component_Affected__c='testing';
       ev.Component_PN__c='testing';
       ev.Component_SN__c='testing';
       ev.Event_Description__c='testing';
       ev.Failure_Mode__c='testing';
       ev.Notes__c='testing';
       ev.Record_Type__c='testing';
       ev.RecordTypeID__c='testing';
       //ev.SWIB_GE_S_N_Equip_Name__c = ib.Id;
       ev.GE_Equipment_Name_Lkp__c = ib.Id;
       
       ev.Event_End_Date__c= System.today();
       ev.Event_Type__c='Installation';
       ev.Well_ID__c ='testing';
       ev.Event_Record_Number__c ='demo';
       insert ev;
        lstSWIBEventRecord.add(ev);
        
        SWIBEventRecord__c ev0 = new SWIBEventRecord__c();
    
       ev0.Component_Affected__c='testing';
       ev0.Component_PN__c='testing';
       ev0.Component_SN__c='testing';
       ev0.Event_Description__c='testing';
       ev0.Failure_Mode__c='testing';
       ev0.Notes__c='testing';
       ev0.Record_Type__c='testing';
       ev0.RecordTypeID__c='testing';
       //ev0.SWIB_GE_S_N_Equip_Name__c = ib.Id;
       ev0.GE_Equipment_Name_Lkp__c = ib.Id;
       
       ev0.Event_End_Date__c= System.today();
       ev0.Event_Type__c='Installation';
       ev0.Well_ID__c ='testing';
       ev0.Event_Record_Number__c ='demo1';
       insert ev0;
        lstSWIBEventRecord.add(ev0);
        
    SWIBEventRecord__c ev1 = new SWIBEventRecord__c();
       ev1.Component_Affected__c='testing1';
       ev1.Component_PN__c='testing1';
       ev1.Component_SN__c='testing1';
       ev1.Event_Description__c='testing1';
       ev1.Failure_Mode__c='testing1';
       ev1.Notes__c='testing1';
       ev1.Record_Type__c='testing1';
       ev1.RecordTypeID__c='testing1';
       //ev1.SWIB_GE_S_N_Equip_Name__c = ib1.Id;
       ev1.GE_Equipment_Name_Lkp__c = ib1.Id;
       
       ev1.Event_End_Date__c= System.today();
       ev1.Event_Type__c='Installation';
       ev1.Well_ID__c ='testing';
       ev1.Event_Record_Number__c ='testing1';
       insert ev1;
       lstSWIBEventRecord.add(ev1);
       
       SWIBEventRecord__c ev2 = new SWIBEventRecord__c();
       ev2.Component_Affected__c='testing2';
       ev2.Component_PN__c='testing2';
       ev2.Component_SN__c='testing2';
       ev2.Event_Description__c='testing2';
       ev2.Failure_Mode__c='testing2';
       ev2.Notes__c='testing2';
       ev1.Record_Type__c='testing2';
       ev2.RecordTypeID__c='testing2';
       //ev2.SWIB_GE_S_N_Equip_Name__c = ib.Id;
       ev2.GE_Equipment_Name_Lkp__c = ib.Id;
       
       ev2.Event_End_Date__c= System.today();
       ev2.Event_Type__c ='Installation';
       ev2.Well_ID__c ='testing';
       ev2.Event_Record_Number__c ='testing2';
       insert ev2;
       lstSWIBEventRecord.add(ev2);
       
    
       
       System.debug('list of event record' +lstSWIBEventRecord.Size());
       System.debug('list of event record' +lstSWIBEventRecord);
      string WellID;
      string SWIBStatus;
       date lastStatusDate;
       for (SWIBEventRecord__c SWIB : lstSWIBEventRecord) {
   system.debug('-----Entering this loop--------');  
     
          if(SWIB.Event_Type__c =='Installation'){
           WellID=SWIB.Well_ID__c;
           lastStatusDate=SWIB.Event_End_Date__c;
           SWIBStatus='Installed';}
}

      
  
        sortList.addall(lstSWIBEventRecord);
        system.debug('-------sortList--------' + sortList);  
      //   Integer sortNum;
        // Integer sortNum1 = 0 ;
//Integer listEmpty;
         Integer low = 0;
         Integer high = 1;
       //  Integer i ;// = low;
       //  Integer j;// = high;
//i = 0;
      //  j = listEmpty;
        sortNum = sortList.Size();
        
        System.debug('sortNum'+sortList.Size());
         
      system.debug('-------sortList--------' + sortList);   
      system.debug('----------------sortNum value of event record------------------------' + sortNum);
         
        listEmpty=sortNum ;
       
system.debug('----------------listEmpty value of event record------------------------' + listEmpty);


 
  /*  GE_Installed_Base__c IBUpdate1 = new  GE_Installed_Base__c();
IBUpdate1 =[SELECT Name,GE_OGSS_InstnDte__c,GE_ES_Status__c,GE_OGSS_WelIdntfr__c  FROM GE_Installed_Base__c WHERE ID = :ib.Id];
IBUpdate1.GE_OGSS_InstnDte__c = ev.Event_End_Date__c;
IBUpdate1.GE_OGSS_WelIdntfr__c  = ev.Well_ID__c;
IBUpdate1.GE_ES_Status__c='Pulled';
update IBUpdate1;
*/



//update IBUpdate1;




       
        

  Date lastStatusDate1 ;
  lastStatusDate1 = ev.Event_End_Date__c;
  System.debug('------------lastStatusDate1----------'+lastStatusDate1);
        
      //  Test.startTest();
     
      String aa =  apexpages.currentpage().getparameters().put('id',ib.id);
    PageReference pageRef = new PageReference('/apex/SWIBReqPage_IB?id='+ aa);
     
       
       SWIBcontroller1 objBatch = new SWIBcontroller1(new apexpages.standardcontroller(ib));
    //  objBatch.GE_ES_Status__c='Installed';
     
     
                         objBatch.lastStatusDate = ev.Event_End_Date__c;
                         objBatch.WellID = 'testing';
                         objBatch.SWIBStatus='Installed';
                         objBatch.sortList = sortList;
                         objBatch.lstGECombinedList = sortList;
                        objbatch.Quicksort(0, sortNum-1);
                        objbatch.subjectInput = 'testing';
                        objbatch.mode = 'edit';
                        objbatch.lstIB = lstGESNEquipName11;
 objBatch.IBupdate();
      // objBatch.GE_ES_Status__c='Pulled';
      
       objBatch.callTwoMethods();
      objBatch.save();
     
     
    
   objBatch.modeSet();
                        objbatch.displayMessage = true;
                        
                        Test.stopTest();

    }
}
 
}