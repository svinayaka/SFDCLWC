@isTest(SeeAllData = true)
    private class GE_OG_SrvcMaxWebService_test
     {
        
           
        static testMethod void WO_Test()
         {
            Account Acc = [Select id, GE_HQ_DUNS_Number__c,Name From Account Where GE_HQ_DUNS_Number__c!=Null  Limit 1];
            GE_Installed_Base__c IBase = [Select Id, Name From GE_Installed_Base__c Limit 1];
            User U = [SELECT Name,UserName,Email FROM User where Username like '%ogintegrationsmax%' LIMIT 1];
            System.debug('UserName: ' + u.UserName);
            List<GE_OG_SrvcMaxWebService.WorkOrder_Info> WOInfoList = New List<GE_OG_SrvcMaxWebService.WorkOrder_Info>();
            GE_OG_SrvcMaxWebService.WorkOrder_Info WOInfo = New GE_OG_SrvcMaxWebService.WorkOrder_Info();
            WOInfo.Actual_End_Date = '2020-01-01 18:00:00';
            WOInfo.Actual_Start_Date = '2020-01-01 10:00:00';
            WOInfo.DUNS_Number = Acc.GE_HQ_DUNS_Number__c;
            WOInfo.InstalledBase_SerialNo = IBase.Id;
            WOInfo.OwnerSSOId = '502052626';
            WOInfo.Planned_End_Date = '2013-01-01 18:00:00';
            WOInfo.Planned_Start_Date = '2013-01-01 10:00:00';
            WOInfo.Scheduled_End_Date = '2013-01-01 18:00:00';
            //WOInfo.Scheduled_Start_Date = '1998-01-01 10:00:00';
            WOInfo.Scheduled_Start_Date = '2013-01-01 10:00:00';
            WOInfo.ShipToAddress = 'Hyderabad';
            WOInfo.Source_System = 'SAP';
            WOInfo.NetworkNumber = 'XXXXX'; 
            WOInfo.AssignByDate = '2020-01-01 10:00:00'; 
            WOInfo.Task_Description='';
            WOInfo.Closed_On= '2013-12-01 10:00:00';
            WOInfo.ERP_Project_Number ='Test';
            WOInfo.InstalledBase_SerialNo= IBase.Name;
            WOInfo.OwnerName = U.Name;
            //WOInfo.Tier3='Bently';
            WOInfo.Business_Unit='Bently';
            WOInfo.Country='United States';
            WOInfo.Customer_PO='P1234';
            //WOInfo.Case_Amount=100;
            //WOInfo.Case_Currency='USD';
            WOInfo.Sales_Order='SO766878';
            //WOInfo.Service_Rate=200;
            //WOInfo.Service_Discount=10;
            WOInfo.WBS_Element_Number='W7658768';
            WOInfo.Product_Line_Code='P76587';
            WOInfo.Bill_To=Acc.GE_HQ_DUNS_Number__c;
            WOInfo.Sold_To=Acc.GE_HQ_DUNS_Number__c;
            WOInfo.Order_Status='New';
            System.debug('**** checking*****' + WOInfo.ERP_Project_Number+'***'+WOInfo.NetworkNumber +'***'+WOInfo.Source_System +'****'+WOInfo.OwnerName );
            WOInfoList.add(WOInfo);
            GE_OG_SrvcMaxWebService.InsertWorkOrder(WOInfoList);
            SVMXC__Skill__c skill = new SVMXC__Skill__c(
            Name = 'test',
            GE_PW_PGS_Country__c = 'Test Country',
            GE_PW_PGS_Needs_Visa__c = true,
            GE_PW_PGS_Days_to_Get_Visa__c = 5,
            Business__c = 'PGS',
            Sub_Business__c = 'CS');
            insert skill;   
            list<SVMXC__Service_Order__c >lsxms=new List<SVMXC__Service_Order__c >();      
            SVMXC__Service_Order__c xms=new SVMXC__Service_Order__c();
            xms.GE_OG_MC_ERP_Project_Number__c='123456';
            xms.SVMXC__Skill__c=skill.id;
            xms.GE_SM_OG_MC_Network_Number__c='122536';
            
            //insert xms;
            lsxms.add(xms);
            insert lsxms;
            List<GE_OG_SrvcMaxWebService.WorkOrder_Info> WOInfoList1 = New List<GE_OG_SrvcMaxWebService.WorkOrder_Info>();
            GE_OG_SrvcMaxWebService.WorkOrder_Info WOInfo1 = New GE_OG_SrvcMaxWebService.WorkOrder_Info();
            WOInfo1.NetworkNumber = 'XXXXX'; 
            WOInfo1.ERP_Project_Number= 'XXXXX'; 
            WOInfo.DUNS_Number = Acc.GE_HQ_DUNS_Number__c;      
            WOInfoList1.add(WOInfo); 
            GE_OG_SrvcMaxWebService.InsertWorkOrder(WOInfoList);   
            // SOC.SVMXC__Case__c = '';
            System.Assert(Acc!=null,'Account not inserted');  
            GE_OG_SrvcMaxWebService.WorkOrder_Info wf=new GE_OG_SrvcMaxWebService.WorkOrder_Info();
                       
          }
        
    /*
     Static TestMethod void GE_servicemax_Test_Negative()
        {
          GE_OG_SrvcMaxWebService.WorkOrderResult  WORInfo = New GE_OG_SrvcMaxWebService.WorkOrderResult();
          List<GE_OG_SrvcMaxWebService.WorkOrderResult> WORList = New List<GE_OG_SrvcMaxWebService.WorkOrderResult>();
         List<GE_OG_SrvcMaxWebService.WorkOrder_Info> WOList = New List<GE_OG_SrvcMaxWebService.WorkOrder_Info>();
         GE_OG_SrvcMaxWebService.WorkOrder_Info WOInfo = New GE_OG_SrvcMaxWebService.WorkOrder_Info();
         //RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
         Test.startTest();
         WOInfo.Source_System = 'SAP';
         WOInfo.ERP_Project_Number ='';
         WOInfo.OwnerName ='';
         WOInfo.NetworkNumber = '';
         WORInfo.Status=' ';
         
         WOList.add(WOInfo);
         GE_OG_SrvcMaxWebService.InsertWorkOrder(WOList);
         //GE_OG_SrvcMaxWebService.getRecordType('SVMXC__Service_Order__c', 'SAP');
         WORList.add(WORInfo);
        //GE_OG_ServiceMaxWebService.ValidateWorkOrderInfo(WOList,WORInfo);
         Test.stopTest();

      }
      */
      static testMethod void WO_Test_addingdate()
         {
            Account Acc = [Select id, GE_HQ_DUNS_Number__c,Name From Account Where GE_HQ_DUNS_Number__c!=Null  Limit 1];
            GE_Installed_Base__c IBase = [Select Id, Name From GE_Installed_Base__c Limit 1];
            User U = [SELECT Name,UserName,Email FROM User where Username like '%ogintegrationsmax%' LIMIT 1];
            System.debug('UserName: ' + u.UserName);
            List<GE_OG_SrvcMaxWebService.WorkOrder_Info> WOInfoList = New List<GE_OG_SrvcMaxWebService.WorkOrder_Info>();
            GE_OG_SrvcMaxWebService.WorkOrder_Info WOInfo = New GE_OG_SrvcMaxWebService.WorkOrder_Info();
            WOInfo.Actual_End_Date = '1998-01-01 18:00:00';
            WOInfo.Actual_Start_Date = '1998-01-01 10:00:00';
            WOInfo.DUNS_Number = Acc.GE_HQ_DUNS_Number__c;
            WOInfo.InstalledBase_SerialNo = IBase.Id;
            WOInfo.OwnerSSOId = '502052626';
            WOInfo.Planned_End_Date = '1998-01-01 18:00:00';
            WOInfo.Planned_Start_Date = '1998-01-01 10:00:00';
            WOInfo.Scheduled_End_Date = '1998-01-01 18:00:00';
            WOInfo.Scheduled_Start_Date = '1998-01-01 10:00:00';
            //WOInfo.Scheduled_Start_Date = '2013-01-01 10:00:00';
            WOInfo.ShipToAddress = 'Hyderabad';
            WOInfo.Source_System = 'SAP';
            WOInfo.NetworkNumber = 'XXXXX'; 
            WOInfo.AssignByDate = '1998-01-01 10:00:00'; 
            WOInfo.Task_Description='';
            WOInfo.Closed_On= '1998-12-01 10:00:00';
            WOInfo.ERP_Project_Number ='Test';
            WOInfo.InstalledBase_SerialNo= IBase.Name;
            WOInfo.OwnerName = U.Name;
            //WOInfo.Tier3='Bently';
            WOInfo.Business_Unit='Bently';
            WOInfo.Country='United States';
            WOInfo.Customer_PO='P1234';
            //WOInfo.Case_Amount=100;
            //WOInfo.Case_Currency='USD';
            WOInfo.Sales_Order='SO766878';
            //WOInfo.Service_Rate=200;
            //WOInfo.Service_Discount=10;
            WOInfo.WBS_Element_Number='W7658768';
            WOInfo.Product_Line_Code='P76587';
            WOInfo.Bill_To=Acc.GE_HQ_DUNS_Number__c;
            WOInfo.Sold_To=Acc.GE_HQ_DUNS_Number__c;
            WOInfo.Order_Status='New';
            System.debug('**** checking*****' + WOInfo.ERP_Project_Number+'***'+WOInfo.NetworkNumber +'***'+WOInfo.Source_System +'****'+WOInfo.OwnerName );
            WOInfoList.add(WOInfo);
            GE_OG_SrvcMaxWebService.InsertWorkOrder(WOInfoList);
            SVMXC__Skill__c skill = new SVMXC__Skill__c(
            Name = 'test',
            GE_PW_PGS_Country__c = 'Test Country',
            GE_PW_PGS_Needs_Visa__c = true,
            GE_PW_PGS_Days_to_Get_Visa__c = 5,
            Business__c = 'PGS',
            Sub_Business__c = 'CS');
            insert skill;   
            list<SVMXC__Service_Order__c >lsxms=new List<SVMXC__Service_Order__c >();      
            SVMXC__Service_Order__c xms=new SVMXC__Service_Order__c();
            xms.GE_OG_MC_ERP_Project_Number__c='123456';
            xms.SVMXC__Skill__c=skill.id;
            xms.GE_SM_OG_MC_Network_Number__c='122536';
            
            //insert xms;
            lsxms.add(xms);
            insert lsxms;
            List<GE_OG_SrvcMaxWebService.WorkOrder_Info> WOInfoList1 = New List<GE_OG_SrvcMaxWebService.WorkOrder_Info>();
            GE_OG_SrvcMaxWebService.WorkOrder_Info WOInfo1 = New GE_OG_SrvcMaxWebService.WorkOrder_Info();
            WOInfo1.NetworkNumber = 'XXXXX'; 
            WOInfo1.ERP_Project_Number= 'XXXXX'; 
            WOInfo.DUNS_Number = Acc.GE_HQ_DUNS_Number__c;      
            WOInfoList1.add(WOInfo); 
            GE_OG_SrvcMaxWebService.InsertWorkOrder(WOInfoList);   
            // SOC.SVMXC__Case__c = '';
            System.Assert(Acc!=null,'Account not inserted');  
            GE_OG_SrvcMaxWebService.WorkOrder_Info wf=new GE_OG_SrvcMaxWebService.WorkOrder_Info();
                       
          }
      }