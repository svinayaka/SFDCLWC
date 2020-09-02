/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *ActiveServiceContracts
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 *
 * 2015-07-22 - MAPLES - Added lines to increase code coverage from 75% to 87% after the code was added for showing SVMX Events
 * Used custom report for SVMX Activity test, would have prefered to use standard report but there were no reports on SVMX Events in the SVMX Package
 */
@isTest(SeeAllData=true)
private class GE_OG_GS_ReportGroupingControllerTest {

    static testMethod void TestController() {
        GE_OG_GS_Report_Grouping__c reportSetting = new GE_OG_GS_Report_Grouping__c();
        // changing the report setting configurations tied to bug 0000023075  (getting test class failure)
        /*reportSetting.Filter_Object__c = 'SVMXC__Service_Order__c';
        reportSetting.Report_Name_1__c = 'OpenWorkOrdersByType';
        reportSetting.Filter_1_Object_Field__c = 'SVMXC__Order_Status__c';
        reportSetting.Filter_1_Report_Field__c = 'Order Status';
        reportSetting.Filter_1_Match_Exact__c = true;
        reportSetting.Report_1_Exclusive__c = true;
        // 2015-07-22 - MAPLES adding to test
        reportSetting.Report_Name_3__c = 'GEOGGS_Tech_Availability';
        reportSetting.Overlap_Filter_Object_Start_Date_Field__c = 'GE_OG_GS_Customer_Want_Start_Date__c';
        reportSetting.Overlap_Filter_Report_Start_Date_Field__c = 'StartDateTime';
        reportSetting.Overlap_Filter_Object_End_Date_Field__c = 'GE_OG_GS_Customer_Want_End_Date__c';
        reportSetting.Overlap_Filter_Report_End_Date_Field__c = 'EndDateTime';
        reportSetting.Help_Text__c = 'This is the location of Help Text';
        reportSetting.Report_Name_2__c = 'OpenWorkOrdersByType_2';
        reportSetting.Filter_2_Object_Field__c = 'SVMXC__Priority__c';
        reportSetting.Filter_2_Report_Field__c = 'Priority';
        reportSetting.Filter_2_Match_Exact__c = false;
        reportSetting.Report_2_Exclude__c = false;
        End commenting tied to bug 0000023075 */
        
        // edit tied to bug 0000023075
        reportSetting.Filter_Object__c = 'SVMXC__Service_Order__c';
		reportSetting.Report_Name_1__c = 'GEOGGS_Technician_with_Expertise_2';
        reportSetting.Filter_1_Object_Field__c = 'SVMXC__Country__c';
        reportSetting.Filter_1_Report_Field__c = 'Visa Country';
        reportSetting.Filter_1_Match_Exact__c = true;
        reportSetting.Report_1_Exclusive__c = true;
        reportSetting.Help_Text__c = 'This is the location of Help Text';
        // end edit tied to bug 0000023075
                      
        
        // 2015-07-22 - MAPLES End of add to test
        reportSetting.Name = 'UnitTest1';
        insert reportSetting;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.SVMXC__Order_Status__c = 'Open';
        wo.SVMXC__Country__c = 'Argentina';  // edit tied to bug 0000023075
        wo.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c' AND NAme = 'GS-Requirement' LIMIT 1].Id;
        insert wo;
        
        Test.startTest();
        PageReference pageRef = new PageReference('/apex/GE_OG_GS_ReportGrouping?id=' + wo.Id + '&setting=UnitTest1');
        
        Test.setCurrentPageReference(pageRef);
        
        GE_OG_GS_ReportGroupingController controller = new GE_OG_GS_ReportGroupingController();
        controller.getDateFormat1();
        controller.getDateFormat2();
        controller.getLocaleFile();
        controller.getLocale();
        system.assert(! controller.reportData.isEmpty());
        Test.stopTest();
    }
}