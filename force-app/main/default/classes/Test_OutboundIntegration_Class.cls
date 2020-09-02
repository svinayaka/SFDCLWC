/*
Purpose/Overview : Test Class 
Functional Area : Subsea
Author : Raju Manche
Created Date : Feb 7, 2019
Test ClassName : Test_OutboundIntegration_Class
Covered Classes :
GE_OG_PCOutboundIntegration
GE_OG_OutboundAttachmentBatch
Modified By : 
Modified Date:
Reason:-
*/
@isTest(seeAllData=true)
public class Test_OutboundIntegration_Class{
    public static Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
    public static testMethod void submitToOracleMethod() {
        Id recTypeID = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId();   
        GE_SS_Project__c ssPrjct = [select id from GE_SS_Project__c where id='a3p1H000000TbzI'];
        //SVMXC__Service_Order__c wo = [select id from SVMXC__Service_Order__c where id='a3Nc0000001AZqz'];
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId =rtWOId;
        wo.GE_SS_Project__c='a3p1H000000TbzI';
        wo.SVMXC__Company__c='001A000000vqT0b';
        wo.GE_PC_Ship_to_Account__c='001A000000vqT0b';
        insert wo;
        SVMXC.INTF_WebServicesDef.INTF_Response resp = new SVMXC.INTF_WebServicesDef.INTF_Response();
        SVMXC.INTF_WebServicesDef.INTF_Response request = new SVMXC.INTF_WebServicesDef.INTF_Response();
        SVMXC.INTF_WebServicesDef.SVMXMap objSVMXMap = new SVMXC.INTF_WebServicesDef.SVMXMap();
        objSVMXMap.key = 'WorkOrder_ID';
        objSVMXMap.value = wo.id;
        request.valueMap = new List<SVMXC.INTF_WebServicesDef.SVMXMap>();
        request.valueMap.add(objSVMXMap);
        resp = GE_OG_PCOutboundIntegration.sfmSubmitToOracle(request);  
        resp = GE_OG_PCOutboundIntegration.sfmCaseToOracle(request);   
        GE_OG_PCOutboundWrapper wrp = new GE_OG_PCOutboundWrapper();  
        //wrp.submitToOracle(wo.id,'12345');                    
    }
    public static testMethod void submitToCaseMethod() {
        SVMXC__Site__c loc = new SVMXC__Site__c();
        loc.Name = 'Test Location';
        insert loc;
        Account retAcc1 = [select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];   
        Id recTypeID1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();   
        case caseObj = new case();
        caseObj.RecordTypeId=recTypeID1;
        //caseObj.GE_PC_Ship_to_Account__r.Name='001A000000vqT0b';           
        caseObj.GE_OG_DS_Region__c= 'NAM';
        caseObj.SVMXC__Billing_Type__c='T&M (Transactional)';
        caseObj.GE_PC_Ship_to_Account__c=retAcc1.Id;
        caseObj.GE_DS_Opportunity_Number__c='00000';
        caseObj.SVMXC__Site__c=loc.id;
        caseObj.status='New';
        caseObj.GE_PC_Branch__c='NAM';
        caseObj.SVMXC__Billing_Type__c='Billable';
        insert caseObj;
        SVMXC.INTF_WebServicesDef.INTF_Response resp = new SVMXC.INTF_WebServicesDef.INTF_Response();
        SVMXC.INTF_WebServicesDef.INTF_Response request = new SVMXC.INTF_WebServicesDef.INTF_Response();
        SVMXC.INTF_WebServicesDef.SVMXMap objSVMXMap = new SVMXC.INTF_WebServicesDef.SVMXMap();
        SVMXC.INTF_WebServicesDef.SVMXMap objSVMXMap1 = new SVMXC.INTF_WebServicesDef.SVMXMap();
        objSVMXMap1.key = 'Case_ID';
        objSVMXMap1.value = caseObj.Id;
        objSVMXMap.key = 'RecordType_ID';
        objSVMXMap.value = 'SS-Mobilize';        
        request.valueMap = new List<SVMXC.INTF_WebServicesDef.SVMXMap>();
        request.valueMap.add(objSVMXMap);
        request.valueMap.add(objSVMXMap1);
        resp = GE_OG_PCOutboundIntegration.sfmCaseToOracle(request);
        //GE_OG_PCOutboundWrapper wrp = new GE_OG_PCOutboundWrapper();          
        
    }
}