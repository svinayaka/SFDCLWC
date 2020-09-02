/*
================================================================
Test Class      : GE_CodeUtilization_Test
Class Name      : GE_CodeUtilization
Business        : GE Oil & Gas
Author          : Prasanth Nalle
Guidance        :Sanjay Patidar
Created Date    : 11/14/2014
Reason          : used for code Utilization
Code Coverage	: 100%

================================================================
*/
@isTest
public class GE_CodeUtilization_Test {
    static testMethod void GE_CodeUtilization() {
    Test.setCurrentPageReference(Page.GE_OG_Directory_Mobile); 
    GE_CodeUtilization cu = new GE_CodeUtilization();
    cu.insertCodeUtilization('test','visualforce page');
    cu.insertCodeUtilization(cu.captureVFPageName(), 'Visualforce Page');
    }
}