@isTest(SeeAllData=true)
public class GE_DS_WO_LinesUpdate_Test{
        
       
       public  static  testmethod void testrate(){
       test.starttest();
        
               Id recTypeID1= Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();// FS-DS
             
               
               SVMXC__Service_Order__c woObj = [Select Id,Name,GE_DS_Daily_Rate__c,GE_DS_Overtime__c from SVMXC__Service_Order__c 
               where GE_SM_HQ_Task_Description__c like '%test%' AND RecordTypeId =: recTypeID1 AND SVMXC__Order_Status__c ='Work Complete' limit 1  ];  
               
            
              woObj.GE_DS_Daily_Rate__c =1500;
              woObj.GE_DS_Overtime__c =80;
              update woObj;
              System.debug('List WO Update'+woObj);
              
                test.stopTest();
           }
      public  static  testmethod void testdeletion(){
       test.starttest();
        //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
         //Account Data Helper
              Account acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
       //New Case              
              Id recTypeID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();// FS-DS
              Case retCs=[select id,accountid, CaseNumber, GE_PW_PO__c from Case where RecordTypeId=:recTypeID LIMIT 1];
              
              retCs.accountid = acc.Id; 
              retCs.GE_PW_PO__c = '1234';
              retCs.GE_OG_DS_Bill_To_Address__c = 'Test Bill To Address';
              update retCs;               
              System.debug('Case-->'+retCs);
              
              //New Skill
              SVMXC__Skill__c sk = new SVMXC__Skill__c();
              sk.Name='Test Skill';
              insert sk;
               Id recTypeID1= Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();// FS-DS
               
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c=loc.ID;
              woObj.SVMXC__Case__c = retCs.Id;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'Fairfield';
              woObj.SVMXC__Company__c = acc.ID;
              woObj.SVMXC__Skill__c = sk.Id;
              woObj.GE_PC_Ship_to_Account__c = acc.ID;
              woObj.SVMXC__Street__c = 'Test Street';
              woObj.SVMXC__City__c = 'Test City';
              woObj.SVMXC__State__c = 'Test State';
              woObj.SVMXC__Zip__c = '77041';
              woObj.SVMXC__Country__c = 'United States';
              woObj.GE_PC_Phone_Number__c = '18324761123';
              woObj.SVMXC__Work_Performed__c = 'Test';     
              woObj.GE_SS_Customer_PO_number__c = '5555';
              woObj.GE_OG_Attachment_Id__c = sk.Id;
              woObj.GE_DS_Daily_Rate__c =1000;
              woObj.GE_DS_Overtime__c =100;
              woObj.RecordTypeId = recTypeID1;
              insert woObj;
             
               
              //New Part
              Product2 prod = new Product2();
              prod.Name  = 'FsoTypeAttach';
              prod.ProductCode = '1234';
              prod.GE_ES_P_L__c = 'D&S - PC';
              insert prod;
              Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
              System.debug('Product-->'+retProd);
              
               
              //New Work Detail
              SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
              wodet.SVMXC__Line_Type__c  = 'Parts';
              wodet.SVMXC__Product__c = retProd.Id;
              wodet.SVMXC__Actual_Quantity2__c = 10.00;
              wodet.SVMXC__Actual_Price2__c = 12.50;
              wodet.SVMXC__Line_Status__c = 'Open';
              wodet.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
              wodet.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
              wodet.SVMXC__Service_Order__c = woObj.Id;
              insert wodet;
              SVMXC__Service_Order_Line__c retWdet = [Select id, Name, SVMXC__Line_Type__c, SVMXC__Actual_Quantity2__c, SVMXC__Actual_Price2__c, SVMXC__Line_Status__c  FROM SVMXC__Service_Order_Line__c WHERE id=:wodet.Id ];
              System.debug('WorkDetail--> ' +retWdet);
              
             
              
              ID wdRectypeId=Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Drilling RecordType').getRecordTypeId();
              SVMXC__Service_Order_Line__c wdlabor = new SVMXC__Service_Order_Line__c();
              wdlabor.SVMXC__Line_Type__c  = 'Labor';
              wdlabor.SVMXC__Product__c = retProd.Id;
              wdlabor.SVMXC__Actual_Quantity2__c = 10.00;
              wdlabor.SVMXC__Actual_Price2__c = 12.50;
              wdlabor.SVMXC__Line_Status__c = 'Open';
              wdlabor.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
              wdlabor.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
              wdlabor.SVMXC__Service_Order__c = woObj.Id;
              wdlabor.RecordTypeId = wdRectypeId;
              insert wdlabor;
               System.debug('WorkDetail Labor--> ' +wdlabor);
               
              SVMXC__Service_Order_Line__c wdtask = new SVMXC__Service_Order_Line__c();
              wdtask.SVMXC__Line_Type__c  = 'Task';
              wdtask.SVMXC__Product__c = retProd.Id;
              wdtask.SVMXC__Actual_Quantity2__c = 10.00;
              wdtask.SVMXC__Actual_Price2__c = 12.50;
              wdtask.SVMXC__Line_Status__c = 'Open';
              wdtask.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
              wdtask.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
              wdtask.SVMXC__Service_Order__c = woObj.Id;
              wdtask.SVMXC__Work_Detail__c = wdlabor.Id;
              wdtask.RecordTypeId = wdRectypeId;
              
              insert wdtask;
             
              delete wdlabor;
              
              
              /*List<SVMXC__Service_Order__c> wofl = new List<SVMXC__Service_Order__c>();
              wofl.add(woObj);
              GE_DS_WO_LinesUpdate Lineupdate = new GE_DS_WO_LinesUpdate();
              Lineupdate.updateLineItemRates(wofl,retWO);  */       

                test.stopTest();
           }
}