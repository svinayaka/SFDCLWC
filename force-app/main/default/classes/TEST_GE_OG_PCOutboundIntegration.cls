/*
=======================================================================================================================================
Name       : TEST_GE_OG_PCOutboundIntegration 
Author     : Amit Kumar
Created On : 13th May 2015
Purpose    : To calculate code coverage for "GE_OG_PCOutboundIntegration"  Apex class
======================================================================================================================================
*/
@isTest(SeeAllData=true)
public class TEST_GE_OG_PCOutboundIntegration {
    static testMethod void GE_OG_PCOutboundIntegration(){
           String recordId, logDescription, woName, outboundResponse;
           List<SVMXC__Service_Order__c> listWO;
           test.startTest();
           try{
              
              SVMXC.INTF_WebServicesDef.INTF_Response resp = new SVMXC.INTF_WebServicesDef.INTF_Response();
              SVMXC.INTF_WebServicesDef.INTF_Response request = new SVMXC.INTF_WebServicesDef.INTF_Response();
                           
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name = 'Test Location';
              insert loc;
                          
              //New Account  
              Account acc = new Account(name='Test Acc', GE_HQ_Proposed_DUNS__c='CAT000000', GE_HQ_Request_Status__c='CMF Approved'); 
              insert acc; 
              Account retAcc = [select id, name from Account where id=:acc.id]; 
                             
              Id recTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-PC').getRecordTypeId();
              List<Case> cObj = [SELECT Id, CaseNumber, Status FROM Case where recordtypeid=:recTypeID LIMIT 1];
              System.debug('Case Number -->' +cObj[0].CaseNumber);
              
              //New Skill
              SVMXC__Skill__c sk = new SVMXC__Skill__c();
              sk.Name = 'Test Skill';
              insert sk;
               
              //New Work Order
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Case__c = cObj[0].ID;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'Fairfield';
              woObj.SVMXC__Company__c = acc.ID;
              woObj.SVMXC__Skill__c = sk.Id;
              insert woObj;
              SVMXC__Service_Order__c retWO = [SELECT Id, Name From SVMXC__Service_Order__c WHERE Id=:woObj.Id ];
              ID woID = retWO.ID;
              System.debug('Id-->' +woID);
          
              //Map<String,ID> rqmap = new Map<String,ID>();
              //rqmap.put('WorkOrder_ID', woID);
              //resp = GE_OG_PCOutboundIntegration.sfmSubmitToOracle(rqmap);
              
              resp = GE_OG_PCOutboundIntegration.sfmSubmitToOracle(request);
             
             
              test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           }    
        }  
        static testMethod void GE_OG_PCOutboundIntegration1(){
        String recordId, logDescription, woName, outboundResponse;
         test.startTest();
         GE_OG_PCOutboundIntegration obj1=new GE_OG_PCOutboundIntegration();
                             try{
              
              SVMXC.INTF_WebServicesDef.INTF_Response resp = new SVMXC.INTF_WebServicesDef.INTF_Response();
              SVMXC.INTF_WebServicesDef.INTF_Response request = new SVMXC.INTF_WebServicesDef.INTF_Response();
               //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name = 'Test Location';
              insert loc;
               Account retAcc1 = [select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];   
            Id recTypeID1 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();   
            case caseObj = new case();
            caseObj.RecordTypeId=recTypeID1;
            caseObj.GE_PC_Ship_to_Account__r.Name=retAcc1.Name;           
            caseObj.GE_OG_DS_Region__c= 'NAM';
            caseObj.SVMXC__Billing_Type__c='T&M (Transactional)';
            caseObj.GE_PC_Ship_to_Account__c=retAcc1.Id;
            caseObj.GE_DS_Opportunity_Number__c='00000';
            caseObj.SVMXC__Site__c=loc.id;
            insert caseObj;
            resp = GE_OG_PCOutboundIntegration.sfmCaseToOracle(request);
              test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           }  
         }            
}