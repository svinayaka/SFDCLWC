/*
=======================================================================================================================================
Name       : TEST_GE_OG_SAP_IntegrationUtility 
Author     : Abhijeet Mitra
Created On : 25th Dec 2015
Purpose    : To calculate code coverage for "GE_OG_SAP_IntegrationUtility"  Apex class
======================================================================================================================================
*/
@isTest
public class TEST_GE_OG_SAP_IntegrationUtility {
    static testMethod void GE_OG_SAP_IntegrationUtility(){
        try{
            test.startTest();
            GE_OG_SAP_IntegrationUtility intUtil = new GE_OG_SAP_IntegrationUtility();
            GE_OG_SAP_IntegrationUtility.OAuthResponse oAuthResp = new GE_OG_SAP_IntegrationUtility.OAuthResponse();
            Integer soaTimeOut=GE_OG_SAP_IntegrationUtility.AL_SOA_TIMEOUT;
            String log_desc=GE_OG_SAP_IntegrationUtility.LOG_DESCRIPTION;
            String locInbErrMsg=GE_OG_SAP_IntegrationUtility.LOC_INBOUND_ERROR_MSG;
            String ipInbErrMsg=GE_OG_SAP_IntegrationUtility.IP_INBOUND_ERROR_MSG;
            String woInbScsMsg=GE_OG_SAP_IntegrationUtility.WO_SUCCESS_MSG;
            String woInbErrMsg=GE_OG_SAP_IntegrationUtility.WO_ERROR_MSG;
            
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
            locObj.GE_OG_AL_Ship_to_Account_Number__c='1234567';
            locObj.GE_AL_Well_Type__c='ESP';
            locObj.GE_AL_Well__c=true;
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
            woObj.GE_PC_Branch__c = 'OKC Plant';
            woObj.GE_OG_Work_Center_Description__c = 'OKC Plant ESP Field Service';
            woObj.SVMXC__Problem_Description__c ='TEST';
            woObj.SVMXC__Order_Type__c = 'Install';
            woObj.GE_OG_Bill_to_Account_Number__c = '123456';
            woObj.Well_Type__c = 'ESP';
            woObj.GE_OG_AL_Work_Center__c = 'SMESPF01';
            woObj.GE_OG_Sold_to_Party__c = '123456';
            woObj.GE_OG_AL_Ship_to_Account_Number__c = '123456';
            woObj.SVMXC__Skill__c = sklObj.Id;
            woObj.GE_OG_MC_Business_Unit__c ='AL';
            woObj.GE_OG_MC_Service_Region__c = 'India';
            insert woObj;
            SVMXC__Service_Order__c retWOrder = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj.Id ];
            System.debug('WorkOrder ID--> '+retWOrder.Id);
//          woIdList.add(String.valueOf(retWOrder.Id));
//          System.debug('WorkOrder Id List-->' +woIdList);

            

/*          //New USer
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
            insert u;
            User retU=[Select id FROM USer WHERE id=:u.Id ];*/
            
            //New Work Detail
            SVMXC__Service_Order_Line__c wdObj = new SVMXC__Service_Order_Line__c();
            wdObj.SVMXC__Line_Type__c  = 'Labor';
            wdObj.SVMXC__Work_Description__c = 'TEST';
            wdObj.SVMXC__Actual_Quantity2__c = 10.00;
            wdObj.SVMXC__Actual_Price2__c = 12.50;
            wdObj.SVMXC__Line_Status__c = 'Open';
            wdObj.SVMXC__Billable_Quantity__c=1234.1234;
            wdObj.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
            wdObj.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
            wdObj.SVMXC__Service_Order__c = woObj.Id;
//          wdObj.SVMXC__Group_Member__c = techObj.Id;
            insert wdObj;

            
//          oAuthResp.access_token='123456';
            
            String emailBody = GE_OG_SAP_IntegrationUtility.getEmailBodyOutFailure(retWOrder);
            String emailBody1 = GE_OG_SAP_IntegrationUtility.getEmailBodySAPResponse('Test', 'S', 'Error');
            String emailBody2 = GE_OG_SAP_IntegrationUtility.getEmailBodySAPResponse('Test', 'N', 'Error');
            GE_OG_SAP_IntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(),'Test','Test Sub','Test Body');
           
            List<SVMXC__Site__c> locList = new List<SVMXC__Site__c>();
            List<SVMXC__Installed_Product__c> ipList = new List<SVMXC__Installed_Product__c>();
            
            Set<String> locNames1 = new Set<String>();
            String flag1='Name';
            Set<String> strShipToAddress1 = new Set<String>();
            locNames1.add('Test OG SAP Int Location');
            strShipToAddress1.add('1234567');
            
            Set<String> locNames2 = new Set<String>();
            String flag2='RigId';
            Set<String> strShipToAddress2 = new Set<String>();
            locNames2.add('Test OG SAP Int Location');
            strShipToAddress2.add('1234567');
            
            locList = intUtil.locDetails(locNames1,flag1,strShipToAddress1);
            locList = intUtil.locDetails(locNames2,flag2,strShipToAddress2);
            
            Set<String> serialNumbers = new Set<String>();
            String buisnessUnit='AL';
            serialNumbers.add('54321');
            
            ipList = intUtil.ipDetails(serialNumbers,buisnessUnit);
            
            String obj1 = 'location';
            String recTypeName1 = 'Well';
            String obj2 = 'InstalledProduct';
            String recTypeName2 = 'GE OG D&S Artificial Lift';
            Id recTypeId = intUtil.getRecTypeId(obj1,recTypeName1);
            recTypeId = intUtil.getRecTypeId(obj2,recTypeName2);
            
            string logType1='Error';
            string logDescription1='Test Error';
            datetime logDate1=DateTime.now();
            String recName1='Test Location';
            String objectName1='Location';
            GE_OG_SAP_IntegrationUtility.insertLog(logType1,logDescription1,logDate1,recName1,objectName1);
            
            string logType2='Error';
            string logDescription2='Test Error';
            datetime logDate2=DateTime.now();
            String recName2='12345678';
            String objectName2='InstalledProduct';
            GE_OG_SAP_IntegrationUtility.insertLog(logType2,logDescription2,logDate2,recName2,objectName2);
            
            string logType3='Error';
            string logDescription3='Test Error';
            datetime logDate3=DateTime.now();
            String recName3='WO-12345678';
            String objectName3='WorkOrder';
            GE_OG_SAP_IntegrationUtility.insertLog(logType3,logDescription3,logDate3,recName3,objectName3);
            
            GE_OG_SAP_IntegrationUtility.insertLog(null,null,null,null,null);
            
            GE_OG_SAP_InboundIntegration.IP_Info ipInfo = new GE_OG_SAP_InboundIntegration.IP_Info();
            ipInfo.LocName='Test OG SAP Int Location';
            ipInfo.ShipToAddress='123456';
            ipInfo.BillToAddress='CAT12345';
            ipInfo.BillToNumber='123456';
            ipInfo.SoldToParty='123456';
            ipInfo.PartNumber='123456';
            ipInfo.Serial='123456';
            ipInfo.GeRigId='123456';
            ipInfo.EquipmentNumber=123456;
            List<GE_OG_SAP_InboundIntegration.IP_Info> InstalledProductList = new List<GE_OG_SAP_InboundIntegration.IP_Info>();
            InstalledProductList.add(ipInfo);
            
            GE_OG_SAP_IntegrationUtility.notifyInboundIP(InstalledProductList,logDescription1);
            
            GE_OG_SAP_InboundIntegration.Location_Info locInfo = new GE_OG_SAP_InboundIntegration.Location_Info();
            locInfo.LocName='Test OG SAP Int Location';
            locInfo.ShipToAddress='123456';
            locInfo.BillToAddress='CAT12345';
            locInfo.BillToNumber='123456';
            locInfo.SoldToParty='123456';
            locInfo.RecordTypeId='Well';
            locInfo.Street='Test street';
            locInfo.City='Test City';
            locInfo.State='Test State';
            locInfo.Country='United States';
            locInfo.Zip='12345';
            locInfo.SitePhone='1234567890';
            locInfo.SiteFax='1234567890';
            List<GE_OG_SAP_InboundIntegration.Location_Info> LocationList = new List<GE_OG_SAP_InboundIntegration.Location_Info>();
            LocationList.add(locInfo);
            
            GE_OG_SAP_IntegrationUtility.notifyInboundLocation(LocationList,logDescription1);
            
            String BusinessUnit1='AL';
            
            String soaep1;
            String dmzep1;
            String AccessToken1;
            String environ1;
            
            environ1 ='Dev';
            soaep1 = GE_OG_SAP_IntegrationUtility.getEndpointBaseSOA(environ1);
            dmzep1 = GE_OG_SAP_IntegrationUtility.getEndpointBaseOAuth(environ1);
            AccessToken1 = GE_OG_SAP_IntegrationUtility.getOAuthAccessToken();

            test.stopTest();
        }
        catch(Exception e){
            System.debug('Exception :'+e.getMessage());
        }
    }
}