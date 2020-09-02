/*
=======================================================================================================================================
Name       : TEST_GE_OG_SAP_InboundIntegration
Author     : Abhijeet Mitra
Created On : 24th Dec 2015
Purpose    : To calculate code coverage for "GE_OG_SAP_InboundIntegration"  Apex class
======================================================================================================================================
*/
@isTest
public class TEST_GE_OG_SAP_InboundIntegration{
    static testMethod void GE_OG_SAP_InboundIntegration(){
        test.startTest();
        
        GE_OG_SAP_InboundIntegration.Status objStatus = new GE_OG_SAP_InboundIntegration.Status();
        GE_OG_SAP_InboundIntegration.Location_Info locInfo1 = new GE_OG_SAP_InboundIntegration.Location_Info();
        GE_OG_SAP_InboundIntegration.IP_Info ipInfo1 = new GE_OG_SAP_InboundIntegration.IP_Info();
        GE_OG_SAP_InboundIntegration.Location_Info locInfo2 = new GE_OG_SAP_InboundIntegration.Location_Info();
        GE_OG_SAP_InboundIntegration.IP_Info ipInfo2 = new GE_OG_SAP_InboundIntegration.IP_Info();
        
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
        locObj.GE_AL_WELL__c=true;
        insert locObj;
        SVMXC__Site__c retLoc = [Select Id, GE_Rig_ID__c from SVMXC__Site__c where Id=:locObj.Id];
        String GERigId1 = retLoc.GE_Rig_ID__c;
            
        //New Installed Product
        SVMXC__Installed_Product__c ipObj = new SVMXC__Installed_Product__c();
        ID ipRecTypeId=Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('GE OG D&S Artificial Lift').getRecordTypeId();
        ipObj.RecordTypeID=ipRecTypeId;
        ipObj.SVMXC__Status__c = 'Installed';
        ipObj.SVMXC__Serial_Lot_Number__c='54321';
        ipObj.GE_OG_DS_Part_Number__c='12345';
        ipObj.SVMXC__Site__c=locObj.Id;
        ipObj.SVMXC__Company__c=accObj.Id;
        insert ipObj;
        List<SVMXC__Installed_Product__c> lstInstalledProduct= new List<SVMXC__Installed_Product__c>();
        lstInstalledProduct.add(ipObj);

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

/*      //New Technician     
        SVMXC__Service_Group_Members__c techObj = new SVMXC__Service_Group_Members__c();
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
//      woObj.SVMXC__Group_Member__c = techObj.Id;          
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
        woObj.GE_OG_Work_Center_Description__c = 'AU01';
        woObj.SVMXC__Problem_Description__c ='TEST';
        woObj.SVMXC__Order_Type__c = 'Install';
        woObj.GE_OG_Bill_to_Account_Number__c = '123456';
        woObj.Well_Type__c = 'ESP';
        woObj.GE_OG_Work_Center_Description__c = 'OKC Plant ESP Field Service';
        woObj.GE_OG_AL_Work_Center__c = 'SMESPF01';
        woObj.GE_OG_Sold_to_Party__c = '123456';
        woObj.GE_OG_AL_Ship_to_Account_Number__c = '123456';
        woObj.SVMXC__Skill__c = sklObj.Id;
        woObj.GE_OG_MC_Business_Unit__c ='AL';
        woObj.GE_OG_MC_Service_Region__c = 'India';
        insert woObj;
        SVMXC__Service_Order__c retWOrder = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj.Id ];
        System.debug('WorkOrder ID--> '+retWOrder.Id);
//      woIdList.add(String.valueOf(retWOrder.Id));
//      System.debug('WorkOrder Id List-->' +woIdList);

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
//      wdObj.SVMXC__Group_Member__c = techObj.Id;
        insert wdObj;

        //New Access Token
        String AccessToken;
        AccessToken='Bearer 2338923';
        
        List<GE_OG_SAP_InboundIntegration.Location_Info> LocationList1 = new List<GE_OG_SAP_InboundIntegration.Location_Info>();
        locInfo1.LocName='Test OG SAP Int Location';
        locInfo1.ShipToAddress='123456';
        locInfo1.BillToAddress='CAT12345';
        locInfo1.BillToNumber='123456';
        locInfo1.SoldToParty='123456';
        locInfo1.RecordTypeId='Well';
        locInfo1.Street='Test street';
        locInfo1.City='Test City';
        locInfo1.State='Test State';
        locInfo1.Country='United States';
        locInfo1.Zip='12345';
        locInfo1.SitePhone='1234567890';
        locInfo1.SiteFax='1234567890';
        String BusinessUnit1='AL';
        LocationList1.add(locInfo1);        
        
        List<GE_OG_SAP_InboundIntegration.IP_Info> InstalledProductList1 = new List<GE_OG_SAP_InboundIntegration.IP_Info>();
        ipInfo1.LocName='Test OG SAP Int Location';
        ipInfo1.ShipToAddress='123456';
        ipInfo1.BillToAddress='CAT12345';
        ipInfo1.BillToNumber='123456';
        ipInfo1.SoldToParty='123456';
        ipInfo1.PartNumber='123456';
        ipInfo1.Serial='123456';
        ipInfo1.GeRigId=GERigId1;
        ipInfo1.EquipmentNumber=123456;
        InstalledProductList1.add(ipInfo1);
        
        List<GE_OG_SAP_InboundIntegration.Location_Info> LocationList2 = new List<GE_OG_SAP_InboundIntegration.Location_Info>();
        locInfo2.LocName='';
        locInfo2.ShipToAddress='';
        locInfo2.BillToAddress='';
        locInfo2.BillToNumber='';
        locInfo2.SoldToParty='';
        locInfo2.RecordTypeId='';
        locInfo2.Street='Test street';
        locInfo2.City='Test City';
        locInfo2.State='Test State';
        locInfo2.Country='United States';
        locInfo2.Zip='12345';
        locInfo2.SitePhone='1234567890';
        locInfo2.SiteFax='1234567890';
        String BusinessUnit2='';
        LocationList2.add(locInfo2);
        
        List<GE_OG_SAP_InboundIntegration.IP_Info> InstalledProductList2 = new List<GE_OG_SAP_InboundIntegration.IP_Info>();
        ipInfo2.LocName='Test OG SAP Int Location';
        ipInfo2.ShipToAddress='';
        ipInfo2.BillToAddress='';
        ipInfo2.BillToNumber='123456';
        ipInfo2.SoldToParty='';
        ipInfo2.PartNumber='';
        ipInfo2.Serial='';
        ipInfo2.GeRigId='';
        ipInfo2.EquipmentNumber=null;
        InstalledProductList2.add(ipInfo2);
        
        List<GE_OG_SAP_InboundIntegration.Location_Info> LocationList3 = null;
        List<GE_OG_SAP_InboundIntegration.IP_Info> InstalledProductList3 = null;
        String BusinessUnit3=null;
        
        objStatus=GE_OG_SAP_InboundIntegration.InsertLocation(LocationList1,BusinessUnit1);
        objStatus=GE_OG_SAP_InboundIntegration.InsertInstalledProduct(InstalledProductList1,BusinessUnit1);
        objStatus=GE_OG_SAP_InboundIntegration.InsertLocation(LocationList2,BusinessUnit2);
        objStatus=GE_OG_SAP_InboundIntegration.InsertInstalledProduct(InstalledProductList2,BusinessUnit2);
        objStatus=GE_OG_SAP_InboundIntegration.InsertLocation(LocationList3,BusinessUnit3);
        objStatus=GE_OG_SAP_InboundIntegration.InsertInstalledProduct(InstalledProductList3,BusinessUnit3);

        test.stopTest();
    }
}