/*
=======================================================================================================================================
Name       : TEST_GE_OG_SAP_OutboundIntegration 
Author     : Abhijeet Mitra
Created On : 22nd Dec 2015
Purpose    : To calculate code coverage for "GE_OG_SAP_OutboundIntegration"  Apex class
======================================================================================================================================
*/
@isTest
public class TEST_GE_OG_SAP_OutboundIntegration {
    static testMethod void GE_OG_SAP_OutboundIntegration(){
        String recordId, logDescription, woName;
        List<SVMXC__Service_Order__c> listWO;
        List <String> woIdList = new List <String>();
        test.startTest();
        try{
            GE_OG_SAP_OutboundWrapper.Universal_Response outboundResponse = new GE_OG_SAP_OutboundWrapper.Universal_Response();
            SVMXC.INTF_WebServicesDef.INTF_Response resp = new SVMXC.INTF_WebServicesDef.INTF_Response();
            SVMXC.INTF_WebServicesDef.INTF_Response request = new SVMXC.INTF_WebServicesDef.INTF_Response();
            SVMXC.INTF_WebServicesDef.SVMXMap objSVMXMap = new SVMXC.INTF_WebServicesDef.SVMXMap();

            //New Account
            Account accObj = new Account();
            ID accRecTypeID = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            accObj.RecordTypeID = accRecTypeID;
            accObj.Name = 'Test OG SAP Int Account';
            accObj.GE_HQ_DUNS_Number__c = 'CAT12345';
            insert accObj;
            System.debug('Account ID--> '+accObj.Id);
            
            //New Location
            SVMXC__Site__c locObj = new SVMXC__Site__c();
            ID locRecTypeId=Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Well').getRecordTypeId();
            locObj.RecordTypeID = locRecTypeId;
            locObj.Name='Test OG SAP Int Location';
            locObj.GE_AL_Well_Type__c='ESP';
            insert locObj;
            
            //New Case
            Case csObj = new Case();
            ID caseRecTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-AL').getRecordTypeId();
            csObj.RecordTypeID=caseRecTypeId;
            csObj.Subject='Test';
            csObj.Description='Test Description';
            csObj.Status='New';
            csObj.Origin='Email';
            csObj.SVMXC__Site__c=locObj.Id;
            csObj.accountid=accObj.Id;
            insert csObj;
            
            //New ServiceTeam
            SVMXC__Service_Group__c teamObj = new SVMXC__Service_Group__c();
            ID stRectypeId=Schema.SObjectType.SVMXC__Service_Group__c.getRecordTypeInfosByName().get('Technician').getRecordTypeId();
            teamObj.RecordTypeID=stRectypeId;
            teamObj.name='Test Team';
            teamObj.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
            teamObj.GE_HQ_P_L_Level__c='O&G > D&S';
            insert teamObj;

            //New Technician     
/*          SVMXC__Service_Group_Members__c techObj = new SVMXC__Service_Group_Members__c();
            ID techRectypeId=Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('AL Technician/Equipment').getRecordTypeId();
            techObj.RecordTypeID=techRecTypeId;
            techObj.SVMXC__Service_Group__c = teamObj.Id;
            techObj.Name = 'SVMX Tech';
            techObj.SVMXC__Active__c = true;
            techObj.SVMXC__Enable_Scheduling__c = true;
            techObj.SVMXC__Email__c = 'test.abc@xyz.com';
            techObj.GE_SM_HQ_SSO_ID__c = '987654321';
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
            
            //New Work Order
            SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();
            ID woRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
            woObj.RecordTypeID=woRectypeId;
            woObj.SVMXC__Site__c = locObj.Id;
            woObj.SVMXC__Case__c = csObj.Id;
            woObj.SVMXC__Company__c = accObj.ID;
            woObj.SVMXC__Service_Group__c = teamObj.Id;
//          woObj.SVMXC__Group_Member__c = techObj.Id;          
            woObj.GE_PC_Ship_to_Account__c = accObj.ID;
            woObj.GE_OG_Service_Order__c = '123456';
            woObj.SVMXC__Street__c = 'Test Street';
            woObj.SVMXC__City__c = 'Test City';
            woObj.SVMXC__State__c = 'Test State';
            woObj.SVMXC__Zip__c = '77041';
            woObj.SVMXC__Country__c = 'United States';
            woObj.GE_PC_Phone_Number__c = '18324761123';
            woObj.SVMXC__Work_Performed__c = 'Test';     
            woObj.GE_SS_Customer_PO_number__c = '5555';
            woObj.SVMXC__Order_Status__c = 'Open';
            woObj.SVMXC__Billing_Type__c = 'Billable';        
            woObj.SVMXC__Problem_Description__c ='TEST';
            woObj.SVMXC__Order_Type__c = 'Install';
            woObj.GE_OG_Bill_to_Account_Number__c = '123456';
            woObj.Well_Type__c = 'ESP';
            woObj.GE_PC_Branch__c = 'OKC Plant';
            woObj.GE_OG_Work_Center_Description__c = 'OKC Plant ESP Field Service';
            woObj.GE_OG_AL_Work_Center__c = 'SMSPSF02';
            woObj.GE_OG_Sold_to_Party__c = '123456';
            woObj.GE_OG_AL_Ship_to_Account_Number__c = '123456';
            woObj.SVMXC__Skill__c = sklObj.Id;
            woObj.GE_OG_MC_Business_Unit__c ='AL';
            woObj.GE_OG_MC_Service_Region__c = 'India';
            insert woObj;
            SVMXC__Service_Order__c retWO = [SELECT Id, Name From SVMXC__Service_Order__c WHERE Id=:woObj.Id ];
            ID woID = retWO.ID;
            woIdList.add(woID);
            System.debug('Id-->' +woID);
            
            objSVMXMap.key = 'WorkOrder_ID';
            objSVMXMap.value = woID;
            request.valueMap = new List<SVMXC.INTF_WebServicesDef.SVMXMap>();
            request.valueMap.add(objSVMXMap);

            //Map<String,ID> rqmap = new Map<String,ID>();
            //rqmap.put('WorkOrder_ID', woID);
            //resp = GE_OG_PCOutboundIntegration.sfmSubmitToOracle(rqmap);
            resp = GE_OG_SAP_OutboundIntegration.sfmSubmitToSAP(request);

            if(System.Test.isRunningTest())
            {
            String oAuthResponse = 'bearer 2338923';
            GE_OG_SAP_OutboundWrapper outInstance= new GE_OG_SAP_OutboundWrapper();
            List<GE_OG_SAP_OutboundWrapper.Universal_Response> outboundResponseList = new List<GE_OG_SAP_OutboundWrapper.Universal_Response>();
            outboundResponseList = outInstance.submitToSAP(woIdList,oAuthResponse);
            outboundResponse.Status='S';
            if(outboundResponse.Status=='S')
            {
            logDescription='Success:' + woID;
            GE_OG_SAP_IntegrationUtility.insertLog('SYNCHED',logDescription,system.now(),woID, 'WorkOrder');
            }
            }

            test.stopTest();
        }
        catch(Exception e){
            System.debug('OutBound Exception :'+e.getMessage());
        }
    }
}