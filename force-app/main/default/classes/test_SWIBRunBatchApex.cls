@isTest
                                
public class test_SWIBRunBatchApex {

static  testMethod void test_SWIBRunBatchApexWOException() {
       
        Test.startTest();
   String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();   
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();   
      account a = new account();
        a.name='test';
        a.RecordtypeId = CommAccrecType ;
        a.type='Direct Customer';
        a.classification__c='Strategic';
        insert a;
        
       
    List<Case> lstGECombinedList = new List<Case>();
    List<Case> lstGESNEquipNameCIR = new List<Case>();
    List<Case> lstGESNEquipNameNPT = new List<Case>();
    List<Case> lstGESNEquipNameCam = new List<Case>();
    
           case c = new case();  
        c.recordtypeid=cirRecID;       
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c='TMS';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.GE_OG_Account_Name_Only_If_Not_List_CIR__c='testing';
       c.Status='New';
       c.Origin='Test';
       c.GE_OG_Resolution_Committed_date_CIR__c=null;
       c.GE_OG_Escalation_Level_CIR__c = 'Escalated';
       c.IS_CIR_sixthday_Notification_Sent__c = false;
      c.GE_OG_CIR_Customer_Address__c ='testing';
      c.GE_OG_CIR_Customer_Phone__c ='1123';
       insert c;
      
        lstGECombinedList.add(c);
    lstGESNEquipNameCIR.add(c);
    lstGESNEquipNameNPT.add(c);
    lstGESNEquipNameCam.add(c);
  
        

 
      
      String dailyRecID = Schema.SObjectType.SVMXC__Service_Order__c .getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();      

    String mobilizeRecID = Schema.SObjectType.SVMXC__Service_Order__c .getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();      

    
     String tripRecID = Schema.SObjectType.SVMXC__Service_Order__c .getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();      

     list<SVMXC__Service_Order__c> scope = new list<SVMXC__Service_Order__c>();
           SVMXC__Service_Order__c so = new SVMXC__Service_Order__c();
           so.GE_SS_Job_Description__c='test';
         so.GE_SM_HQ_Actual_Start_Date__c = System.Today();
         so.GE_SM_HQ_Actual_End_Date__c = System.today();
             so.SVMXC__Order_Status__c='Closed';
           //Delete the field Well as part of R-26138  so.GE_SS_Well__c = '12345678901234567890123456789012345678901234567890123456789012345678901234567890';
              so.RecordTypeId=tripRecID;
            insert so;
         scope.add(so);
         
         
 
   
 
    SVMXC__Installed_Product__c  ip =  new SVMXC__Installed_Product__c();
  
  ip.Name = '123456478';
  ip.SVMXC__Status__c = 'Installed';
  insert ip;
  
  SVMXC__Case_Line__c cl = new SVMXC__Case_Line__c();
  cl.SVMXC__Case__c = c.Id;
  cl.GE_SS_Usage_Type__c = 'test';
  cl.GE_SS_Storage__c = 'test';
  cl.SVMXC__Serial_Number_List__c = 'test';
  cl.GE_SS_Returned__c = 'test';
  cl.SVMXC__Quantity__c = 12;
  cl.GE_SS_Qty_Used__c = 14;
    cl.SVMXC__Product_Text__c = 'test';
    cl.SVMXC__Summary__c = 'test'; 
    cl.SVMXC__Description__c = 'test';
       cl.SVMXC__Priority__c = 'test';
        cl.GE_SS_Pre_installed__c = 'test';
         cl.GE_SS_Number_of_Runs__c = 2;
          cl.SVMXC__Line_Status__c = 'test';
           cl.GE_SS_IP_Status__c = 'test';
            cl.GE_SS_If_No_please_specify__c = 'test';
             cl.SVMXC__Entitlement_Status__c = 'test';
              cl.SVMXC__Entitlement_Notes__c = 'test';
               cl.SVMXC__Entitled_Exchange_Type__c = 'test';
                cl.GE_SS_Tool_Function_Correctly__c = 'test';
                 cl.GE_SS_Delivered__c = 'test';
                  cl.GE_SS_Date_Tool_Sent__c = System.today();
                   cl.GE_SS_Date_Tool_Received_By_FSE__c = System.today();
                    cl.GE_SS_Condition_after_job__c = 'test';
                     cl.GE_SS_Tool_Upon_Arrival__c = 'test';
                     //Commenting below as part of  R-26631  
                      //cl.GE_SS_Additional_Comments__c = 'test';
                      cl.GE_SS_Serial_Number__c = ip.id;
                      insert cl;
  
    
  
         
    List<SWIBEventRecord__c> event = new List<SWIBEventRecord__c>();
       SWIBEventRecord__c ev = new SWIBEventRecord__c();
  
       ev.Component_Affected__c='demoing2';
       ev.Component_PN__c='demoing2';
       ev.Component_SN__c='demoing2';
      ev.Event_Description__c=so.GE_SS_Job_Description__c;
       ev.Failure_Mode__c='demoing2';
       ev.Notes__c='demoing2';
       ev.Record_Type__c=so.RecordType.Name;  
       ev.RecordTypeID__c='demoing2';
       //ev.SWIB_GE_S_N_Equip_Name__c = 'test4';
       ev.GE_Equipment_Name_Lkp__c = 'a9q12000000Gml1AAC';
       
       ev.Well_ID__c ='demoing2';
        ev.Event_Type__c  ='demoing2';
       ev.Event_End_Date__c= System.today();
       ev.Event_Record_Number__c ='123456';
        event.add(ev);
       
       SWIBEventRecord__c objSWIBEventRec = new SWIBEventRecord__c ();
       objSWIBEventRec.Component_Affected__c='demoing1';
       objSWIBEventRec.Component_PN__c='demoing1';
       objSWIBEventRec.Component_SN__c='demoing1';
       objSWIBEventRec.Event_Description__c='demoing1';
       objSWIBEventRec.Failure_Mode__c='demoing1';
       objSWIBEventRec.Notes__c='demoing1';
       objSWIBEventRec.Record_Type__c='demoing1';  
       objSWIBEventRec.RecordTypeID__c='demoing1';
       //objSWIBEventRec.SWIB_GE_S_N_Equip_Name__c = 'demoing1';
       objSWIBEventRec.GE_Equipment_Name_Lkp__c = 'a9q12000000Gml2AAC';
       objSWIBEventRec.Well_ID__c ='demoing1';
        objSWIBEventRec.Event_Type__c  ='demoing1';
       objSWIBEventRec.Event_End_Date__c= System.today();
       objSWIBEventRec.Event_Record_Number__c ='123456';
    
       
       event.add(objSWIBEventRec);
       System.debug('--------event record----'+objSWIBEventRec);
        
     list<Database.SaveResult>  srList = Database.Insert(event,false);
     System.debug('---save result--'+srList);
    Map<Id, String> errorMap = new Map<Id, String>();
    Map<Id, SWIBEventRecord__c> IdToSObjectMap = new    Map<Id, SWIBEventRecord__c>();
      for(Database.SaveResult tmpSR : srList){
              if(!tmpSR.isSuccess()){
            String errMsg = tmpSR.getErrors()[0].getMessage();
              StatusCode errCode = tmpSR.getErrors()[0].getStatusCode();
                Integer index = 0;
               errorMap.put(event[index].Id, errMsg);
        IdToSObjectMap.put(event[index].Id, event[index]);
         index ++;
      }
      }
     List<string> lstGESNEquipName = new List<string>(); 
      
     String   rtypeSCM=Schema.SObjectType.GE_Installed_Base__c .getRecordTypeInfosByName().get('Subsea Control Module').getRecordTypeId();      
String  rtypeSM=Schema.SObjectType.GE_Installed_Base__c .getRecordTypeInfosByName().get('Subsea Manifold').getRecordTypeId();   
 String rtypeSXT=Schema.SObjectType.GE_Installed_Base__c .getRecordTypeInfosByName().get('Subsea Xmas Tree').getRecordTypeId(); 
 
 
 
 GE_Installed_Base__c ib = new GE_Installed_Base__c();
 ib.recordtypeid = rtypeSCM;
 ib.Name = '123456';
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
ib.GE_OGSS_WelIdntfr__c='demoing1';
insert ib;
 lstGESNEquipName.add(ib.Name);
 
 
  
  
  
list<SVMXC__Service_Order_Line__c>  order = new list<SVMXC__Service_Order_Line__c>();
 SVMXC__Service_Order_Line__c order1 = new SVMXC__Service_Order_Line__c();
  order1.SVMXC__Service_Order__c = so.id;
  order1.SVMXC__Line_Type__c = 'testing';
  order1.SVMXC__Serial_Number__c=ip.id;
  order1.Case_Line__c = cl.id;
  
  SVMXC__Service_Order_Line__c order2 = new SVMXC__Service_Order_Line__c();
  order2.SVMXC__Service_Order__c = so.id;
  order2.SVMXC__Line_Type__c = 'testing';
  order2.SVMXC__Serial_Number__c=ip.id;
  order2.Case_Line__c = cl.id;
 
  SVMXC__Service_Order_Line__c order3 = new SVMXC__Service_Order_Line__c();
  order3.SVMXC__Service_Order__c = so.id;
  order3.SVMXC__Line_Type__c = 'testing';
  order3.SVMXC__Serial_Number__c=ip.id;
  order3.Case_Line__c = cl.id;
 // order3.GE_SS_Well__c = loc.id;
  
  //SVMXC__Service_Order__c
  
  insert order1;
  insert order2;
  //insert order3;
  
  order.add(order1);
  order.add(order2);
 // order.add(order3);
  
  Date dateWO = System.today(); 
  Date dateWOstartDate = System.today();
DateTime datetimeWO = order1.SVMXC__Service_Order__r.GE_SM_HQ_Actual_End_Date__c;
DateTime datetimeWOstartDate = order1.SVMXC__Service_Order__r.GE_SM_HQ_Actual_Start_Date__c;
  
System.debug('-----------service order line--------'+order);
  
       SWIBBatchApexWOForEventRecord objBatch = new SWIBBatchApexWOForEventRecord();
       ID batchprocessid = Database.executeBatch(objBatch);
AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors 
                    FROM AsyncApexJob WHERE ID =: batchprocessid ];
            database.batchableContext bc;
            Database.SaveResult srList1;
              objBatch.execute(bc,order);
           //objBatch.setQry();    
      //objBatch.start(bc);
        //objBatch.finish(bc);
     objBatch.lstGESNEquipNameCIR = lstGESNEquipNameCIR;
      objBatch.lstGESNEquipNameNPT = lstGESNEquipNameNPT;
       objBatch.lstGESNEquipNameCam = lstGESNEquipNameCam;
       objBatch.rtypeSCM  = 'test';
        objBatch.rtypeSM  = 'test';
         objBatch.rtypeSXT  = 'test';
          Test.stopTest();
}
   
 }