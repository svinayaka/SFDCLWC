/*
=======================================================================================================================================
Name       : TEST_GE_OG_SAP_OutboundWrapper 
Author     : Abhijeet Mitra
Created On : 21st Dec 2015
Purpose    : To calculate code coverage for "GE_OG_SAP_OutboundWrapper"  Apex class
======================================================================================================================================
*/
@isTest
public class TEST_GE_OG_SAP_OutboundWrapper{
    static testMethod void GE_OG_SAP_OutboundWrapper(){
        test.startTest();
        try{
            
            List <String> woIdList1 = new List <String>();
            List <String> woIdList2 = new List <String>();
            String AL_ENVIRON = Label.GE_Integration_Environment;
            GE_OG_SAP_OutboundWrapper refObj = new GE_OG_SAP_OutboundWrapper();
            GE_OG_SAP_OutboundWrapper.Universal_Response univResp = new GE_OG_SAP_OutboundWrapper.Universal_Response();
            GE_OG_SAP_AL_WOPublish.OrderStatus_element orderStatus = new GE_OG_SAP_AL_WOPublish.OrderStatus_element();
            List<GE_OG_SAP_OutboundWrapper.Universal_Response> univRespList = new List<GE_OG_SAP_OutboundWrapper.Universal_Response>();
            List<GE_OG_SAP_AL_WOPublish.OrderStatus_element> orderStatus_List = new List<GE_OG_SAP_AL_WOPublish.OrderStatus_element>();
            
            //New Account
            Account accObj = new Account();
            ID accRecTypeID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            accObj.RecordTypeID = accRecTypeID;
            accObj.Name = 'Test OG SAP Int Account';
            accObj.GE_HQ_DUNS_Number__c = 'CAT12345';
            insert accObj;
            Account retAccount = [Select id FROM Account WHERE id=:accObj.Id];
            
            //New Location
            SVMXC__Site__c locObj = new SVMXC__Site__c();
            ID locRecTypeId=Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Well').getRecordTypeId();
            locObj.RecordTypeID = locRecTypeId;
            locObj.Name='Test OG SAP Int Location';
            locObj.GE_AL_Well_Type__c='ESP';
            insert locObj;
            SVMXC__Site__c retLocation = [Select id FROM SVMXC__Site__c WHERE id=:locObj.Id];
            
            //New Case
            Case csObj = new Case();
            ID caseRecTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-AL').getRecordTypeId();
            csObj.RecordTypeID=caseRecTypeId;
            csObj.Subject='Test';
            csObj.Description='Test Description';
            csObj.Status='New';
            csObj.Origin='Email';
            csObj.SVMXC__Site__c=retLocation.Id;
            csObj.accountid=retAccount.Id;
            insert csObj;
            Case retCase = [Select id FROM Case WHERE id=:csObj.Id];
            
            //New ServiceTeam
            SVMXC__Service_Group__c teamObj = new SVMXC__Service_Group__c();
            ID stRectypeId=Schema.SObjectType.SVMXC__Service_Group__c.getRecordTypeInfosByName().get('Technician').getRecordTypeId();
            teamObj.RecordTypeID=stRectypeId;
            teamObj.name='Test Team';
            teamObj.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
            teamObj.GE_HQ_P_L_Level__c='O&G > D&S';
            insert teamObj;
            SVMXC__Service_Group__c retTeam = [Select id FROM SVMXC__Service_Group__c WHERE id=:teamObj.Id];

/*          //New Technician     
            SVMXC__Service_Group_Members__c techObj = new SVMXC__Service_Group_Members__c();
            ID techRectypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('AL Technician/Equipment').getRecordTypeId();
            techObj.RecordTypeID=techRecTypeId;
            techObj.SVMXC__Service_Group__c = retTeam.Id;
            techObj.Name = 'SVMX Tech';
            techObj.SVMXC__Active__c = true;
            techObj.SVMXC__Enable_Scheduling__c = true;
            techObj.SVMXC__Email__c = 'test.abc@xyz.com';
            techObj.GE_SM_HQ_SSO_ID__c = '123456737';
            techObj.SVMCX_Status__c = 'Active GE';
            techObj.GE_SM_HQ_Regional_Manager__c = 'SVMX';
            techObj.GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com';
            techObj.SVMXC_Function__c = 'Services';
            techObj.GE_SM_HQ_Controls_EmpType__c = 'Field Engineer';
            techObj.SVMXC__Salesforce_User__c = UserInfo.getUserId();
            insert techObj;*/
            
            //New Skill
            SVMXC__Skill__c sklObj = new SVMXC__Skill__c();
            sklObj.Name = 'Test Skill';
            insert sklObj;
            
            //New Work Order1
            SVMXC__Service_Order__c woObj1 = new SVMXC__Service_Order__c();
            ID woRectypeId1=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
            woObj1.RecordTypeID=woRectypeId1;
            woObj1.SVMXC__Site__c = retLocation.Id;
            woObj1.SVMXC__Case__c = retCase.Id;
            woObj1.SVMXC__Company__c = retAccount.ID;
            woObj1.SVMXC__Service_Group__c = retTeam.Id;
//          woObj1.SVMXC__Group_Member__c = techObj.Id;          
            woObj1.GE_PC_Ship_to_Account__c = retAccount.ID;
            woObj1.GE_OG_Service_Order__c = '123456';
            woObj1.SVMXC__Street__c = 'Test Street';
            woObj1.SVMXC__City__c = 'Test City';
            woObj1.SVMXC__State__c = 'Test State';
            woObj1.SVMXC__Zip__c = '77041';
            woObj1.SVMXC__Country__c = 'United States';
            woObj1.GE_PC_Phone_Number__c = '18324761123';
            woObj1.SVMXC__Work_Performed__c = 'Test';     
            woObj1.GE_SS_Customer_PO_number__c = '5555';
            woObj1.SVMXC__Order_Status__c = 'Open';
            woObj1.GE_PC_Branch__c = 'MCR-Purcell,OK';
            woObj1.GE_OG_Work_Center_Description__c = 'OKC Plant SPS Field Service';
            woObj1.SVMXC__Problem_Description__c ='TEST';
            woObj1.SVMXC__Order_Type__c = 'Install';
            woObj1.GE_OG_Bill_to_Account_Number__c = '123456';
            woObj1.Well_Type__c = 'ESP';
            woObj1.GE_OG_AL_Work_Center__c = 'SMSPSF02';
            woObj1.GE_OG_Sold_to_Party__c = '123456';
            woObj1.GE_OG_AL_Ship_to_Account_Number__c = '123456';
            woObj1.SVMXC__Skill__c = sklObj.Id;
            woObj1.GE_OG_MC_Business_Unit__c ='AL';
            woObj1.GE_OG_MC_Service_Region__c = 'India';
            insert woObj1;
            SVMXC__Service_Order__c retWOrder1 = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj1.Id ];
            System.debug('WorkOrder ID--> '+retWOrder1.Id);
            woIdList1.add(String.valueOf(retWOrder1.Id));
            System.debug('WorkOrder Id List-->' +woIdList1);
            
            //New Work Order2
            SVMXC__Service_Order__c woObj2 = new SVMXC__Service_Order__c();
            ID woRectypeId2=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
            woObj2.RecordTypeID=woRectypeId2;
            woObj2.SVMXC__Site__c = retLocation.Id;
            woObj2.SVMXC__Case__c = retCase.Id;
            woObj2.SVMXC__Company__c = retAccount.ID;
            woObj2.SVMXC__Service_Group__c = retTeam.Id;
//          woObj2.SVMXC__Group_Member__c = techObj.Id;          
            woObj2.GE_PC_Ship_to_Account__c = retAccount.ID;
            woObj2.SVMXC__Street__c = 'Test Street';
            woObj2.SVMXC__City__c = 'Test City';
            woObj2.SVMXC__State__c = 'Test State';
            woObj2.SVMXC__Zip__c = '77041';
            woObj2.SVMXC__Country__c = 'United States';
            woObj2.GE_PC_Phone_Number__c = '18324761123';
            woObj2.SVMXC__Work_Performed__c = 'Test';     
            woObj2.GE_SS_Customer_PO_number__c = '5555';
            woObj2.SVMXC__Order_Status__c = 'Open';
            woObj2.SVMXC__Billing_Type__c = 'Billable';
            woObj2.GE_PC_Branch__c = 'MCR-Purcell,OK';
            woObj2.GE_OG_Work_Center_Description__c = 'OKC Plant SPS Field Service';
            woObj2.GE_OG_AL_Work_Center__c = 'SMSPSF02';
            woObj2.SVMXC__Problem_Description__c ='TEST';
            woObj2.SVMXC__Order_Type__c = 'Install';
            woObj2.GE_OG_Bill_to_Account_Number__c = '123456';
            woObj2.Well_Type__c = 'ESP';           
            woObj2.GE_OG_Sold_to_Party__c = '123456';
            woObj2.GE_OG_AL_Ship_to_Account_Number__c = '123456';
            woObj2.SVMXC__Skill__c = sklObj.Id;
            woObj2.GE_OG_MC_Business_Unit__c ='AL';
            woObj2.GE_OG_MC_Service_Region__c = 'India';
            insert woObj2;
            SVMXC__Service_Order__c retWOrder2 = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj2.Id ];
            System.debug('WorkOrder ID--> '+retWOrder2.Id);
            woIdList2.add(String.valueOf(retWOrder2.Id));
            System.debug('WorkOrder Id List-->' +woIdList2);

            //New Work Detail Labor
            SVMXC__Service_Order_Line__c wdObj = new SVMXC__Service_Order_Line__c();
            wdObj.SVMXC__Line_Type__c  = 'Labor';
            wdObj.SVMXC__Work_Description__c = 'TEST';
            wdObj.SVMXC__Actual_Quantity2__c = 10.00;
            wdObj.SVMXC__Actual_Price2__c = 12.50;
            wdObj.SVMXC__Line_Status__c = 'Open';
            wdObj.SVMXC__Billable_Quantity__c=1234.1234;
            wdObj.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
            wdObj.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
            wdObj.SVMXC__Service_Order__c = woObj1.Id;
//          wdObj.SVMXC__Group_Member__c = techObj.Id;
            insert wdObj;
            
            //New Work Detail Part
            SVMXC__Service_Order_Line__c wdObj2 = new SVMXC__Service_Order_Line__c();
            wdObj2.SVMXC__Line_Type__c  = 'Part';
            wdObj2.GE_AL_Part_Number__c = '103255';
            wdObj2.SVMXC__Work_Description__c = 'TEST';
            wdObj2.SVMXC__Service_Order__c = woObj1.Id;
            insert wdObj2;
            
            //New Access Token
            String AccessToken;
            AccessToken='Bearer 2338923';
            
            //Response
            orderStatus.Status='S';
            orderStatus.ErrorMsg='Test error';
            orderStatus.SMAX_OrderID='WO-123456';
            orderStatus.SAP_OrderID='50123456';
            orderStatus_List.add(orderStatus);
            
            GE_OG_SAP_OutboundWrapper wrapObj = new GE_OG_SAP_OutboundWrapper();
            univRespList=wrapObj.updateALSapID(orderStatus_List);
            univRespList=wrapObj.submitToSAP(woIdList1,AccessToken);
            univRespList=wrapObj.submitToSAP(woIdList2,AccessToken);


            //Universal Response
            univResp.Status='New';
            univResp.ErrorMsg='ERROR';
            univResp.SMAX_OrderID=retWOrder1.Name;
            univRespList.add(univResp);
            test.stopTest();
        }
        catch(Exception e){
            System.debug('Exception :'+e.getMessage());
        }
    }
}